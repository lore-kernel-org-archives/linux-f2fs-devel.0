From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: split bio cache
Date: Mon, 8 May 2017 20:36:05 +0800
Message-ID: <20170508123605.111446-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1d7hu8-0004SI-Fc
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 08 May 2017 12:36:44 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1d7hu4-0002N7-5V
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 08 May 2017 12:36:44 +0000
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
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Split DATA/NODE type bio cache according to different temperature,
so write IOs with the same temperature can be merged in corresponding
bio cache as much as possible, otherwise, different temperature write
IOs submitting into one bio cache will always cause split of bio.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c | 10 +++----
 fs/f2fs/data.c       | 78 ++++++++++++++++++++++++++++++++--------------------
 fs/f2fs/f2fs.h       | 15 ++++++----
 fs/f2fs/gc.c         |  5 ++--
 fs/f2fs/node.c       |  8 +++---
 fs/f2fs/segment.c    | 14 +++++++---
 fs/f2fs/super.c      | 16 ++++++-----
 7 files changed, 89 insertions(+), 57 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index ea9c317b5916..2a475e83a092 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -212,7 +212,7 @@ int ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 		f2fs_put_page(page, 0);
 	}
 out:
-	f2fs_submit_merged_bio(sbi, META, READ);
+	f2fs_submit_meta_bio(sbi, META, READ);
 	blk_finish_plug(&plug);
 	return blkno - start;
 }
@@ -249,13 +249,13 @@ static int f2fs_write_meta_page(struct page *page,
 	dec_page_count(sbi, F2FS_DIRTY_META);
 
 	if (wbc->for_reclaim)
-		f2fs_submit_merged_bio_cond(sbi, page->mapping->host,
+		f2fs_submit_meta_bio_cond(sbi, page->mapping->host,
 						0, page->index, META, WRITE);
 
 	unlock_page(page);
 
 	if (unlikely(f2fs_cp_error(sbi)))
-		f2fs_submit_merged_bio(sbi, META, WRITE);
+		f2fs_submit_meta_bio(sbi, META, WRITE);
 
 	return 0;
 
@@ -358,7 +358,7 @@ long sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
 	}
 stop:
 	if (nwritten)
-		f2fs_submit_merged_bio(sbi, type, WRITE);
+		f2fs_submit_meta_bio(sbi, type, WRITE);
 
 	blk_finish_plug(&plug);
 
@@ -906,7 +906,7 @@ int sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type)
 		 * We should submit bio, since it exists several
 		 * wribacking dentry pages in the freeing inode.
 		 */
-		f2fs_submit_merged_bio(sbi, DATA, WRITE);
+		f2fs_submit_log_bio(sbi, DATA, WRITE);
 		cond_resched();
 	}
 	goto retry;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7c0f6bdf817d..37d0896021c7 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -278,28 +278,27 @@ static bool __has_merged_page(struct f2fs_bio_info *io,
 	return false;
 }
 
-static bool has_merged_page(struct f2fs_sb_info *sbi, struct inode *inode,
-				nid_t ino, pgoff_t idx, enum page_type type)
+static struct f2fs_bio_info *__get_bio_info(struct f2fs_sb_info *sbi, int rw,
+					enum page_type type, int seg_type)
 {
 	enum page_type btype = PAGE_TYPE_OF_BIO(type);
-	struct f2fs_bio_info *io = &sbi->write_io[btype];
-	bool ret;
+	struct f2fs_bio_info *io;
 
-	down_read(&io->io_rwsem);
-	ret = __has_merged_page(io, inode, ino, idx);
-	up_read(&io->io_rwsem);
-	return ret;
+	if (btype == META) {
+		int io_type = is_read_io(rw) ? READ : WRITE;
+
+		io = &sbi->meta_io[io_type];
+	} else {
+		io = &sbi->log_io[seg_type];
+	}
+
+	return io;
 }
 
-static void __f2fs_submit_merged_bio(struct f2fs_sb_info *sbi,
+static void __f2fs_submit_merged_bio(struct f2fs_bio_info *io,
 				struct inode *inode, nid_t ino, pgoff_t idx,
-				enum page_type type, int rw)
+				enum page_type type)
 {
-	enum page_type btype = PAGE_TYPE_OF_BIO(type);
-	struct f2fs_bio_info *io;
-
-	io = is_read_io(rw) ? &sbi->read_io : &sbi->write_io[btype];
-
 	down_write(&io->io_rwsem);
 
 	if (!__has_merged_page(io, inode, ino, idx))
@@ -310,7 +309,7 @@ static void __f2fs_submit_merged_bio(struct f2fs_sb_info *sbi,
 		io->fio.type = META_FLUSH;
 		io->fio.op = REQ_OP_WRITE;
 		io->fio.op_flags = REQ_META | REQ_PRIO | REQ_SYNC;
-		if (!test_opt(sbi, NOBARRIER))
+		if (!test_opt(io->sbi, NOBARRIER))
 			io->fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
 	}
 	__submit_merged_bio(io);
@@ -318,25 +317,45 @@ static void __f2fs_submit_merged_bio(struct f2fs_sb_info *sbi,
 	up_write(&io->io_rwsem);
 }
 
-void f2fs_submit_merged_bio(struct f2fs_sb_info *sbi, enum page_type type,
-									int rw)
+void f2fs_submit_log_bio_cond(struct f2fs_sb_info *sbi,
+				struct inode *inode, nid_t ino, pgoff_t idx,
+				enum page_type type, int rw)
+{
+	bool is_data = (type == DATA);
+	int i = is_data ? CURSEG_HOT_DATA : CURSEG_HOT_NODE;
+	int max = is_data ? CURSEG_COLD_DATA : CURSEG_COLD_NODE;
+
+	for (; i <= max; i++)
+		__f2fs_submit_merged_bio(&sbi->log_io[i],
+					inode, ino, idx, type);
+}
+
+void f2fs_submit_log_bio(struct f2fs_sb_info *sbi,
+					enum page_type type, int rw)
 {
-	__f2fs_submit_merged_bio(sbi, NULL, 0, 0, type, rw);
+	f2fs_submit_log_bio_cond(sbi, NULL, 0, 0, type, rw);
 }
 
-void f2fs_submit_merged_bio_cond(struct f2fs_sb_info *sbi,
+void f2fs_submit_meta_bio_cond(struct f2fs_sb_info *sbi,
 				struct inode *inode, nid_t ino, pgoff_t idx,
 				enum page_type type, int rw)
 {
-	if (has_merged_page(sbi, inode, ino, idx, type))
-		__f2fs_submit_merged_bio(sbi, inode, ino, idx, type, rw);
+	int io_type = is_read_io(rw) ? READ : WRITE;
+
+	__f2fs_submit_merged_bio(&sbi->meta_io[io_type], inode, ino, idx, type);
+}
+
+void f2fs_submit_meta_bio(struct f2fs_sb_info *sbi,
+					enum page_type type, int rw)
+{
+	f2fs_submit_meta_bio_cond(sbi, NULL, 0, 0, type, rw);
 }
 
 void f2fs_flush_merged_bios(struct f2fs_sb_info *sbi)
 {
-	f2fs_submit_merged_bio(sbi, DATA, WRITE);
-	f2fs_submit_merged_bio(sbi, NODE, WRITE);
-	f2fs_submit_merged_bio(sbi, META, WRITE);
+	f2fs_submit_log_bio(sbi, DATA, WRITE);
+	f2fs_submit_log_bio(sbi, NODE, WRITE);
+	f2fs_submit_meta_bio(sbi, META, WRITE);
 }
 
 /*
@@ -371,13 +390,12 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 int f2fs_submit_page_mbio(struct f2fs_io_info *fio)
 {
 	struct f2fs_sb_info *sbi = fio->sbi;
-	enum page_type btype = PAGE_TYPE_OF_BIO(fio->type);
 	struct f2fs_bio_info *io;
 	bool is_read = is_read_io(fio->op);
 	struct page *bio_page;
 	int err = 0;
 
-	io = is_read ? &sbi->read_io : &sbi->write_io[btype];
+	io = __get_bio_info(sbi, fio->op, fio->type, fio->seg_type);
 
 	if (fio->old_blkaddr != NEW_ADDR)
 		verify_block_addr(sbi, fio->old_blkaddr);
@@ -1513,7 +1531,7 @@ static int __write_data_page(struct page *page, bool *submitted,
 		ClearPageUptodate(page);
 
 	if (wbc->for_reclaim) {
-		f2fs_submit_merged_bio_cond(sbi, inode, 0, page->index,
+		f2fs_submit_log_bio_cond(sbi, inode, 0, page->index,
 						DATA, WRITE);
 		clear_inode_flag(inode, FI_HOT_DATA);
 		remove_dirty_inode(inode);
@@ -1525,7 +1543,7 @@ static int __write_data_page(struct page *page, bool *submitted,
 		f2fs_balance_fs(sbi, need_balance_fs);
 
 	if (unlikely(f2fs_cp_error(sbi))) {
-		f2fs_submit_merged_bio(sbi, DATA, WRITE);
+		f2fs_submit_log_bio(sbi, DATA, WRITE);
 		submitted = NULL;
 	}
 
@@ -1684,7 +1702,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 		mapping->writeback_index = done_index;
 
 	if (last_idx != ULONG_MAX)
-		f2fs_submit_merged_bio_cond(F2FS_M_SB(mapping), mapping->host,
+		f2fs_submit_log_bio_cond(F2FS_M_SB(mapping), mapping->host,
 						0, last_idx, DATA, WRITE);
 
 	return ret;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e26999a74522..4ab42749fd5f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -795,6 +795,7 @@ enum page_type {
 struct f2fs_io_info {
 	struct f2fs_sb_info *sbi;	/* f2fs_sb_info pointer */
 	enum page_type type;	/* contains DATA/NODE/META/META_FLUSH */
+	int seg_type;		/* indicate current segment type */
 	int op;			/* contains REQ_OP_ */
 	int op_flags;		/* req_flag_bits */
 	block_t new_blkaddr;	/* new block address to be written */
@@ -879,8 +880,8 @@ struct f2fs_sb_info {
 	struct f2fs_sm_info *sm_info;		/* segment manager */
 
 	/* for bio operations */
-	struct f2fs_bio_info read_io;			/* for read bios */
-	struct f2fs_bio_info write_io[NR_PAGE_TYPE];	/* for write bios */
+	struct f2fs_bio_info meta_io[2];		/* for meta bios */
+	struct f2fs_bio_info log_io[NR_CURSEG_TYPE];	/* for log bios */
 	struct mutex wio_mutex[NODE + 1];	/* bio ordering for NODE/DATA */
 	int write_io_size_bits;			/* Write IO size bits */
 	mempool_t *write_io_dummy;		/* Dummy pages */
@@ -2325,11 +2326,15 @@ void destroy_checkpoint_caches(void);
 /*
  * data.c
  */
-void f2fs_submit_merged_bio(struct f2fs_sb_info *sbi, enum page_type type,
-			int rw);
-void f2fs_submit_merged_bio_cond(struct f2fs_sb_info *sbi,
+void f2fs_submit_log_bio_cond(struct f2fs_sb_info *sbi,
 				struct inode *inode, nid_t ino, pgoff_t idx,
 				enum page_type type, int rw);
+void f2fs_submit_log_bio(struct f2fs_sb_info *sbi, enum page_type type, int rw);
+void f2fs_submit_meta_bio_cond(struct f2fs_sb_info *sbi,
+				struct inode *inode, nid_t ino, pgoff_t idx,
+				enum page_type type, int rw);
+void f2fs_submit_meta_bio(struct f2fs_sb_info *sbi,
+					enum page_type type, int rw);
 void f2fs_flush_merged_bios(struct f2fs_sb_info *sbi);
 int f2fs_submit_page_bio(struct f2fs_io_info *fio);
 int f2fs_submit_page_mbio(struct f2fs_io_info *fio);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 026522107ca3..8b267ca30926 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -586,6 +586,7 @@ static void move_encrypted_block(struct inode *inode, block_t bidx,
 	struct f2fs_io_info fio = {
 		.sbi = F2FS_I_SB(inode),
 		.type = DATA,
+		.seg_type = CURSEG_COLD_DATA,
 		.op = REQ_OP_READ,
 		.op_flags = 0,
 		.encrypted_page = NULL,
@@ -632,7 +633,7 @@ static void move_encrypted_block(struct inode *inode, block_t bidx,
 	fio.new_blkaddr = fio.old_blkaddr = dn.data_blkaddr;
 
 	allocate_data_block(fio.sbi, NULL, fio.old_blkaddr, &newaddr,
-							&sum, CURSEG_COLD_DATA);
+							&sum, fio.seg_type);
 
 	fio.encrypted_page = pagecache_get_page(META_MAPPING(fio.sbi), newaddr,
 					FGP_LOCK | FGP_CREAT, GFP_NOFS);
@@ -936,7 +937,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 	}
 
 	if (gc_type == FG_GC)
-		f2fs_submit_merged_bio(sbi,
+		f2fs_submit_log_bio(sbi,
 				(type == SUM_TYPE_NODE) ? NODE : DATA, WRITE);
 
 	blk_finish_plug(&plug);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 98351a4a4da3..28f6d1723327 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1373,7 +1373,7 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 	up_read(&sbi->node_write);
 
 	if (wbc->for_reclaim) {
-		f2fs_submit_merged_bio_cond(sbi, page->mapping->host, 0,
+		f2fs_submit_log_bio_cond(sbi, page->mapping->host, 0,
 						page->index, NODE, WRITE);
 		submitted = NULL;
 	}
@@ -1381,7 +1381,7 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 	unlock_page(page);
 
 	if (unlikely(f2fs_cp_error(sbi))) {
-		f2fs_submit_merged_bio(sbi, NODE, WRITE);
+		f2fs_submit_log_bio(sbi, NODE, WRITE);
 		submitted = NULL;
 	}
 	if (submitted)
@@ -1518,7 +1518,7 @@ int fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 	}
 out:
 	if (last_idx != ULONG_MAX)
-		f2fs_submit_merged_bio_cond(sbi, NULL, ino, last_idx,
+		f2fs_submit_log_bio_cond(sbi, NULL, ino, last_idx,
 							NODE, WRITE);
 	return ret ? -EIO: 0;
 }
@@ -1625,7 +1625,7 @@ int sync_node_pages(struct f2fs_sb_info *sbi, struct writeback_control *wbc)
 	}
 out:
 	if (nwritten)
-		f2fs_submit_merged_bio(sbi, NODE, WRITE);
+		f2fs_submit_log_bio(sbi, NODE, WRITE);
 	return ret;
 }
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b084b3a8f2c7..cdf7d61ac213 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -328,7 +328,7 @@ static int __commit_inmem_pages(struct inode *inode,
 	}
 
 	if (last_idx != ULONG_MAX)
-		f2fs_submit_merged_bio_cond(sbi, inode, 0, last_idx,
+		f2fs_submit_log_bio_cond(sbi, inode, 0, last_idx,
 							DATA, WRITE);
 
 	if (!err)
@@ -2141,14 +2141,15 @@ void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 
 static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 {
-	int type = __get_segment_type(fio->page, fio->type);
 	int err;
 
+	fio->seg_type = __get_segment_type(fio->page, fio->type);
+
 	if (fio->type == NODE || fio->type == DATA)
 		mutex_lock(&fio->sbi->wio_mutex[fio->type]);
 reallocate:
 	allocate_data_block(fio->sbi, fio->page, fio->old_blkaddr,
-					&fio->new_blkaddr, sum, type);
+					&fio->new_blkaddr, sum, fio->seg_type);
 
 	/* writeout dirty page into bdev */
 	err = f2fs_submit_page_mbio(fio);
@@ -2297,8 +2298,13 @@ void f2fs_wait_on_page_writeback(struct page *page,
 	if (PageWriteback(page)) {
 		struct f2fs_sb_info *sbi = F2FS_P_SB(page);
 
-		f2fs_submit_merged_bio_cond(sbi, page->mapping->host,
+		if (type == META)
+			f2fs_submit_meta_bio_cond(sbi, page->mapping->host,
+						0, page->index, type, WRITE);
+		else
+			f2fs_submit_log_bio_cond(sbi, page->mapping->host,
 						0, page->index, type, WRITE);
+
 		if (ordered)
 			wait_on_page_writeback(page);
 		else
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 83355ec4a92c..fed25ca609e4 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1950,13 +1950,15 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	set_sbi_flag(sbi, SBI_POR_DOING);
 	spin_lock_init(&sbi->stat_lock);
 
-	init_rwsem(&sbi->read_io.io_rwsem);
-	sbi->read_io.sbi = sbi;
-	sbi->read_io.bio = NULL;
-	for (i = 0; i < NR_PAGE_TYPE; i++) {
-		init_rwsem(&sbi->write_io[i].io_rwsem);
-		sbi->write_io[i].sbi = sbi;
-		sbi->write_io[i].bio = NULL;
+	for (i = 0; i < 2; i++) {
+		init_rwsem(&sbi->meta_io[i].io_rwsem);
+		sbi->meta_io[i].sbi = sbi;
+		sbi->meta_io[i].bio = NULL;
+	}
+	for (i = 0; i < NR_CURSEG_TYPE; i++) {
+		init_rwsem(&sbi->log_io[i].io_rwsem);
+		sbi->log_io[i].sbi = sbi;
+		sbi->log_io[i].bio = NULL;
 	}
 
 	init_rwsem(&sbi->cp_rwsem);
-- 
2.12.2.510.ge1104a5ee539


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
