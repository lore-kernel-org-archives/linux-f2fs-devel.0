From: Chao Yu <chao@kernel.org>
Subject: [PATCH v2 2/2] f2fs: introduce io_list for serialize
	data/node IOs
Date: Fri, 19 May 2017 23:37:01 +0800
Message-ID: <20170519153701.19497-2-chao@kernel.org>
References: <20170519153701.19497-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1dBjzw-00058Z-J4
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 19 May 2017 15:39:24 +0000
Received: from mail.kernel.org ([198.145.29.99])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dBjzv-0000oW-Es
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 19 May 2017 15:39:24 +0000
In-Reply-To: <20170519153701.19497-1-chao@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

Serialize data/node IOs by using fifo list instead of mutex lock,
it will help to enhance concurrency of f2fs, meanwhile keeping LFS
IO semantics.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
 - rebase to last dev-test branch.
 fs/f2fs/checkpoint.c |  1 +
 fs/f2fs/data.c       | 24 ++++++++++++++++++++----
 fs/f2fs/f2fs.h       |  7 ++++++-
 fs/f2fs/gc.c         |  3 ++-
 fs/f2fs/segment.c    | 22 +++++++++++++++-------
 fs/f2fs/super.c      |  2 ++
 6 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 13828f63a871..12559a4b6c24 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -162,6 +162,7 @@ int ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 		.op = REQ_OP_READ,
 		.op_flags = sync ? (REQ_META | REQ_PRIO) : REQ_RAHEAD,
 		.encrypted_page = NULL,
+		.in_list = false,
 	};
 	struct blk_plug plug;
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 4ca0899621a0..f28304093179 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -397,6 +397,20 @@ int f2fs_submit_page_write(struct f2fs_io_info *fio)
 
 	f2fs_bug_on(sbi, is_read_io(fio->op));
 
+	down_write(&io->io_rwsem);
+next:
+	if (fio->in_list) {
+		spin_lock(&io->io_lock);
+		if (list_empty(&io->io_list)) {
+			spin_unlock(&io->io_lock);
+			goto out_fail;
+		}
+		fio = list_first_entry(&io->io_list,
+						struct f2fs_io_info, list);
+		list_del(&fio->list);
+		spin_unlock(&io->io_lock);
+	}
+
 	if (fio->old_blkaddr != NEW_ADDR)
 		verify_block_addr(sbi, fio->old_blkaddr);
 	verify_block_addr(sbi, fio->new_blkaddr);
@@ -408,8 +422,6 @@ int f2fs_submit_page_write(struct f2fs_io_info *fio)
 
 	inc_page_count(sbi, WB_DATA_TYPE(bio_page));
 
-	down_write(&io->io_rwsem);
-
 	if (io->bio && (io->last_block_in_bio != fio->new_blkaddr - 1 ||
 	    (io->fio.op != fio->op || io->fio.op_flags != fio->op_flags) ||
 			!__same_bdev(sbi, fio->new_blkaddr, io->bio)))
@@ -434,9 +446,13 @@ int f2fs_submit_page_write(struct f2fs_io_info *fio)
 
 	io->last_block_in_bio = fio->new_blkaddr;
 	f2fs_trace_ios(fio, 0);
+
+	trace_f2fs_submit_page_write(fio->page, fio);
+
+	if (fio->in_list)
+		goto next;
 out_fail:
 	up_write(&io->io_rwsem);
-	trace_f2fs_submit_page_write(fio->page, fio);
 	return err;
 }
 
@@ -749,7 +765,7 @@ static int __allocate_data_block(struct dnode_of_data *dn)
 	set_summary(&sum, dn->nid, dn->ofs_in_node, ni.version);
 
 	allocate_data_block(sbi, NULL, dn->data_blkaddr, &dn->data_blkaddr,
-						&sum, CURSEG_WARM_DATA);
+					&sum, CURSEG_WARM_DATA, NULL, false);
 	set_data_blkaddr(dn);
 
 	/* update i_size */
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 97d1a7ad243b..c5b357df57ba 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -809,8 +809,10 @@ struct f2fs_io_info {
 	block_t old_blkaddr;	/* old block address before Cow */
 	struct page *page;	/* page to be written */
 	struct page *encrypted_page;	/* encrypted page */
+	struct list_head list;		/* serialize IOs */
 	bool submitted;		/* indicate IO submission */
 	bool need_lock;		/* indicate we need to lock cp_rwsem */
+	bool in_list;		/* indicate fio is in io_list */
 };
 
 #define is_read_io(rw) ((rw) == READ)
@@ -820,6 +822,8 @@ struct f2fs_bio_info {
 	sector_t last_block_in_bio;	/* last block number */
 	struct f2fs_io_info fio;	/* store buffered io info. */
 	struct rw_semaphore io_rwsem;	/* blocking op for bio */
+	spinlock_t io_lock;		/* serialize DATA/NODE IOs */
+	struct list_head io_list;	/* track fios */
 };
 
 #define FDEV(i)				(sbi->devs[i])
@@ -2282,7 +2286,8 @@ void f2fs_replace_block(struct f2fs_sb_info *sbi, struct dnode_of_data *dn,
 			bool recover_newaddr);
 void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 			block_t old_blkaddr, block_t *new_blkaddr,
-			struct f2fs_summary *sum, int type);
+			struct f2fs_summary *sum, int type,
+			struct f2fs_io_info *fio, bool add_list);
 void f2fs_wait_on_page_writeback(struct page *page,
 			enum page_type type, bool ordered);
 void f2fs_wait_on_encrypted_page_writeback(struct f2fs_sb_info *sbi,
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index e2b13558a915..8fe6654a6b57 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -590,6 +590,7 @@ static void move_encrypted_block(struct inode *inode, block_t bidx,
 		.op = REQ_OP_READ,
 		.op_flags = 0,
 		.encrypted_page = NULL,
+		.in_list = false,
 	};
 	struct dnode_of_data dn;
 	struct f2fs_summary sum;
@@ -633,7 +634,7 @@ static void move_encrypted_block(struct inode *inode, block_t bidx,
 	fio.new_blkaddr = fio.old_blkaddr = dn.data_blkaddr;
 
 	allocate_data_block(fio.sbi, NULL, fio.old_blkaddr, &newaddr,
-							&sum, CURSEG_COLD_DATA);
+					&sum, CURSEG_COLD_DATA, NULL, false);
 
 	fio.encrypted_page = pagecache_get_page(META_MAPPING(fio.sbi), newaddr,
 					FGP_LOCK | FGP_CREAT, GFP_NOFS);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index f3218fd769b1..a29919330e27 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2111,7 +2111,8 @@ static int __get_segment_type(struct f2fs_io_info *fio)
 
 void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 		block_t old_blkaddr, block_t *new_blkaddr,
-		struct f2fs_summary *sum, int type)
+		struct f2fs_summary *sum, int type,
+		struct f2fs_io_info *fio, bool add_list)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
@@ -2147,6 +2148,17 @@ void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 	if (page && IS_NODESEG(type))
 		fill_node_footer_blkaddr(page, NEXT_FREE_BLKADDR(sbi, curseg));
 
+	if (add_list) {
+		struct f2fs_bio_info *io;
+
+		INIT_LIST_HEAD(&fio->list);
+		fio->in_list = true;
+		io = sbi->write_io[fio->type] + fio->temp;
+		spin_lock(&io->io_lock);
+		list_add_tail(&fio->list, &io->io_list);
+		spin_unlock(&io->io_lock);
+	}
+
 	mutex_unlock(&curseg->curseg_mutex);
 }
 
@@ -2155,11 +2167,9 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 	int type = __get_segment_type(fio);
 	int err;
 
-	if (fio->type == NODE || fio->type == DATA)
-		mutex_lock(&fio->sbi->wio_mutex[fio->type][fio->temp]);
 reallocate:
 	allocate_data_block(fio->sbi, fio->page, fio->old_blkaddr,
-					&fio->new_blkaddr, sum, type);
+			&fio->new_blkaddr, sum, type, fio, true);
 
 	/* writeout dirty page into bdev */
 	err = f2fs_submit_page_write(fio);
@@ -2167,9 +2177,6 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 		fio->old_blkaddr = fio->new_blkaddr;
 		goto reallocate;
 	}
-
-	if (fio->type == NODE || fio->type == DATA)
-		mutex_unlock(&fio->sbi->wio_mutex[fio->type][fio->temp]);
 }
 
 void write_meta_page(struct f2fs_sb_info *sbi, struct page *page)
@@ -2183,6 +2190,7 @@ void write_meta_page(struct f2fs_sb_info *sbi, struct page *page)
 		.new_blkaddr = page->index,
 		.page = page,
 		.encrypted_page = NULL,
+		.in_list = false,
 	};
 
 	if (unlikely(page->index >= MAIN_BLKADDR(sbi)))
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index df19902282f2..09d0ef8827b6 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1967,6 +1967,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 			init_rwsem(&sbi->write_io[i][j].io_rwsem);
 			sbi->write_io[i][j].sbi = sbi;
 			sbi->write_io[i][j].bio = NULL;
+			spin_lock_init(&sbi->write_io[i][j].io_lock);
+			INIT_LIST_HEAD(&sbi->write_io[i][j].io_list);
 		}
 	}
 
-- 
2.12.2.575.gb14f27f


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
