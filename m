From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/3] f2fs: remove unnecessary read cases in
	merged IO flow
Date: Wed, 10 May 2017 16:48:15 -0700
Message-ID: <20170510234816.3373-2-jaegeuk@kernel.org>
References: <20170510234816.3373-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1d8bLJ-0004Ck-9O
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 10 May 2017 23:48:29 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1d8bLH-0001lX-T6
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 10 May 2017 23:48:29 +0000
In-Reply-To: <20170510234816.3373-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

Merged IO flow doesn't need to care about read IOs.

f2fs_submit_merged_bio -> f2fs_submit_merged_write
f2fs_submit_merged_bios -> f2fs_submit_merged_writes
f2fs_submit_merged_bio_cond -> f2fs_submit_merged_write_cond

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c        | 14 ++++++------
 fs/f2fs/data.c              | 55 ++++++++++++++++++++-------------------------
 fs/f2fs/f2fs.h              | 11 +++++----
 fs/f2fs/gc.c                |  6 ++---
 fs/f2fs/node.c              | 11 +++++----
 fs/f2fs/segment.c           | 11 +++++----
 fs/f2fs/super.c             |  2 +-
 include/trace/events/f2fs.h |  2 +-
 8 files changed, 51 insertions(+), 61 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 8d92f8249000..13828f63a871 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -31,7 +31,7 @@ void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io)
 	set_ckpt_flags(sbi, CP_ERROR_FLAG);
 	sbi->sb->s_flags |= MS_RDONLY;
 	if (!end_io)
-		f2fs_flush_merged_bios(sbi);
+		f2fs_flush_merged_writes(sbi);
 }
 
 /*
@@ -247,13 +247,13 @@ static int f2fs_write_meta_page(struct page *page,
 	dec_page_count(sbi, F2FS_DIRTY_META);
 
 	if (wbc->for_reclaim)
-		f2fs_submit_merged_bio_cond(sbi, page->mapping->host,
-						0, page->index, META, WRITE);
+		f2fs_submit_merged_write_cond(sbi, page->mapping->host,
+						0, page->index, META);
 
 	unlock_page(page);
 
 	if (unlikely(f2fs_cp_error(sbi)))
-		f2fs_submit_merged_bio(sbi, META, WRITE);
+		f2fs_submit_merged_write(sbi, META);
 
 	return 0;
 
@@ -356,7 +356,7 @@ long sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
 	}
 stop:
 	if (nwritten)
-		f2fs_submit_merged_bio(sbi, type, WRITE);
+		f2fs_submit_merged_write(sbi, type);
 
 	blk_finish_plug(&plug);
 
@@ -904,7 +904,7 @@ int sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type)
 		 * We should submit bio, since it exists several
 		 * wribacking dentry pages in the freeing inode.
 		 */
-		f2fs_submit_merged_bio(sbi, DATA, WRITE);
+		f2fs_submit_merged_write(sbi, DATA);
 		cond_resched();
 	}
 	goto retry;
@@ -1293,7 +1293,7 @@ int write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	trace_f2fs_write_checkpoint(sbi->sb, cpc->reason, "finish block_ops");
 
-	f2fs_flush_merged_bios(sbi);
+	f2fs_flush_merged_writes(sbi);
 
 	/* this is the case of multiple fstrims without any changes */
 	if (cpc->reason & CP_DISCARD) {
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7c0f6bdf817d..06bb2042385e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -291,14 +291,12 @@ static bool has_merged_page(struct f2fs_sb_info *sbi, struct inode *inode,
 	return ret;
 }
 
-static void __f2fs_submit_merged_bio(struct f2fs_sb_info *sbi,
+static void __f2fs_submit_merged_write(struct f2fs_sb_info *sbi,
 				struct inode *inode, nid_t ino, pgoff_t idx,
-				enum page_type type, int rw)
+				enum page_type type)
 {
 	enum page_type btype = PAGE_TYPE_OF_BIO(type);
-	struct f2fs_bio_info *io;
-
-	io = is_read_io(rw) ? &sbi->read_io : &sbi->write_io[btype];
+	struct f2fs_bio_info *io = &sbi->write_io[btype];
 
 	down_write(&io->io_rwsem);
 
@@ -318,25 +316,24 @@ static void __f2fs_submit_merged_bio(struct f2fs_sb_info *sbi,
 	up_write(&io->io_rwsem);
 }
 
-void f2fs_submit_merged_bio(struct f2fs_sb_info *sbi, enum page_type type,
-									int rw)
+void f2fs_submit_merged_write(struct f2fs_sb_info *sbi, enum page_type type)
 {
-	__f2fs_submit_merged_bio(sbi, NULL, 0, 0, type, rw);
+	__f2fs_submit_merged_write(sbi, NULL, 0, 0, type);
 }
 
-void f2fs_submit_merged_bio_cond(struct f2fs_sb_info *sbi,
+void f2fs_submit_merged_write_cond(struct f2fs_sb_info *sbi,
 				struct inode *inode, nid_t ino, pgoff_t idx,
-				enum page_type type, int rw)
+				enum page_type type)
 {
 	if (has_merged_page(sbi, inode, ino, idx, type))
-		__f2fs_submit_merged_bio(sbi, inode, ino, idx, type, rw);
+		__f2fs_submit_merged_write(sbi, inode, ino, idx, type);
 }
 
-void f2fs_flush_merged_bios(struct f2fs_sb_info *sbi)
+void f2fs_flush_merged_writes(struct f2fs_sb_info *sbi)
 {
-	f2fs_submit_merged_bio(sbi, DATA, WRITE);
-	f2fs_submit_merged_bio(sbi, NODE, WRITE);
-	f2fs_submit_merged_bio(sbi, META, WRITE);
+	f2fs_submit_merged_write(sbi, DATA);
+	f2fs_submit_merged_write(sbi, NODE);
+	f2fs_submit_merged_write(sbi, META);
 }
 
 /*
@@ -368,16 +365,15 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 	return 0;
 }
 
-int f2fs_submit_page_mbio(struct f2fs_io_info *fio)
+int f2fs_submit_page_write(struct f2fs_io_info *fio)
 {
 	struct f2fs_sb_info *sbi = fio->sbi;
 	enum page_type btype = PAGE_TYPE_OF_BIO(fio->type);
-	struct f2fs_bio_info *io;
-	bool is_read = is_read_io(fio->op);
+	struct f2fs_bio_info *io = &sbi->write_io[btype];
 	struct page *bio_page;
 	int err = 0;
 
-	io = is_read ? &sbi->read_io : &sbi->write_io[btype];
+	f2fs_bug_on(sbi, is_read_io(fio->op));
 
 	if (fio->old_blkaddr != NEW_ADDR)
 		verify_block_addr(sbi, fio->old_blkaddr);
@@ -388,8 +384,7 @@ int f2fs_submit_page_mbio(struct f2fs_io_info *fio)
 	/* set submitted = 1 as a return value */
 	fio->submitted = 1;
 
-	if (!is_read)
-		inc_page_count(sbi, WB_DATA_TYPE(bio_page));
+	inc_page_count(sbi, WB_DATA_TYPE(bio_page));
 
 	down_write(&io->io_rwsem);
 
@@ -402,12 +397,11 @@ int f2fs_submit_page_mbio(struct f2fs_io_info *fio)
 		if ((fio->type == DATA || fio->type == NODE) &&
 				fio->new_blkaddr & F2FS_IO_SIZE_MASK(sbi)) {
 			err = -EAGAIN;
-			if (!is_read)
-				dec_page_count(sbi, WB_DATA_TYPE(bio_page));
+			dec_page_count(sbi, WB_DATA_TYPE(bio_page));
 			goto out_fail;
 		}
 		io->bio = __bio_alloc(sbi, fio->new_blkaddr,
-						BIO_MAX_PAGES, is_read);
+						BIO_MAX_PAGES, false);
 		io->fio = *fio;
 	}
 
@@ -421,7 +415,7 @@ int f2fs_submit_page_mbio(struct f2fs_io_info *fio)
 	f2fs_trace_ios(fio, 0);
 out_fail:
 	up_write(&io->io_rwsem);
-	trace_f2fs_submit_page_mbio(fio->page, fio);
+	trace_f2fs_submit_page_write(fio->page, fio);
 	return err;
 }
 
@@ -1321,7 +1315,7 @@ static int encrypt_one_page(struct f2fs_io_info *fio)
 
 	/* flush pending IOs and wait for a while in the ENOMEM case */
 	if (PTR_ERR(fio->encrypted_page) == -ENOMEM) {
-		f2fs_flush_merged_bios(fio->sbi);
+		f2fs_flush_merged_writes(fio->sbi);
 		congestion_wait(BLK_RW_ASYNC, HZ/50);
 		gfp_flags |= __GFP_NOFAIL;
 		goto retry_encrypt;
@@ -1513,8 +1507,7 @@ static int __write_data_page(struct page *page, bool *submitted,
 		ClearPageUptodate(page);
 
 	if (wbc->for_reclaim) {
-		f2fs_submit_merged_bio_cond(sbi, inode, 0, page->index,
-						DATA, WRITE);
+		f2fs_submit_merged_write_cond(sbi, inode, 0, page->index, DATA);
 		clear_inode_flag(inode, FI_HOT_DATA);
 		remove_dirty_inode(inode);
 		submitted = NULL;
@@ -1525,7 +1518,7 @@ static int __write_data_page(struct page *page, bool *submitted,
 		f2fs_balance_fs(sbi, need_balance_fs);
 
 	if (unlikely(f2fs_cp_error(sbi))) {
-		f2fs_submit_merged_bio(sbi, DATA, WRITE);
+		f2fs_submit_merged_write(sbi, DATA);
 		submitted = NULL;
 	}
 
@@ -1684,8 +1677,8 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 		mapping->writeback_index = done_index;
 
 	if (last_idx != ULONG_MAX)
-		f2fs_submit_merged_bio_cond(F2FS_M_SB(mapping), mapping->host,
-						0, last_idx, DATA, WRITE);
+		f2fs_submit_merged_write_cond(F2FS_M_SB(mapping), mapping->host,
+						0, last_idx, DATA);
 
 	return ret;
 }
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e26999a74522..bf837458cb18 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2325,14 +2325,13 @@ void destroy_checkpoint_caches(void);
 /*
  * data.c
  */
-void f2fs_submit_merged_bio(struct f2fs_sb_info *sbi, enum page_type type,
-			int rw);
-void f2fs_submit_merged_bio_cond(struct f2fs_sb_info *sbi,
+void f2fs_submit_merged_write(struct f2fs_sb_info *sbi, enum page_type type);
+void f2fs_submit_merged_write_cond(struct f2fs_sb_info *sbi,
 				struct inode *inode, nid_t ino, pgoff_t idx,
-				enum page_type type, int rw);
-void f2fs_flush_merged_bios(struct f2fs_sb_info *sbi);
+				enum page_type type);
+void f2fs_flush_merged_writes(struct f2fs_sb_info *sbi);
 int f2fs_submit_page_bio(struct f2fs_io_info *fio);
-int f2fs_submit_page_mbio(struct f2fs_io_info *fio);
+int f2fs_submit_page_write(struct f2fs_io_info *fio);
 struct block_device *f2fs_target_device(struct f2fs_sb_info *sbi,
 			block_t blk_addr, struct bio *bio);
 int f2fs_target_device_index(struct f2fs_sb_info *sbi, block_t blkaddr);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 965fbf5d0a2e..67b87155bc48 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -670,7 +670,7 @@ static void move_encrypted_block(struct inode *inode, block_t bidx,
 	fio.op = REQ_OP_WRITE;
 	fio.op_flags = REQ_SYNC;
 	fio.new_blkaddr = newaddr;
-	f2fs_submit_page_mbio(&fio);
+	f2fs_submit_page_write(&fio);
 
 	f2fs_update_data_blkaddr(&dn, newaddr);
 	set_inode_flag(inode, FI_APPEND_WRITE);
@@ -936,8 +936,8 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 	}
 
 	if (gc_type == FG_GC)
-		f2fs_submit_merged_bio(sbi,
-				(type == SUM_TYPE_NODE) ? NODE : DATA, WRITE);
+		f2fs_submit_merged_write(sbi,
+				(type == SUM_TYPE_NODE) ? NODE : DATA);
 
 	blk_finish_plug(&plug);
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 98351a4a4da3..41bb632ac2e0 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1373,15 +1373,15 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 	up_read(&sbi->node_write);
 
 	if (wbc->for_reclaim) {
-		f2fs_submit_merged_bio_cond(sbi, page->mapping->host, 0,
-						page->index, NODE, WRITE);
+		f2fs_submit_merged_write_cond(sbi, page->mapping->host, 0,
+						page->index, NODE);
 		submitted = NULL;
 	}
 
 	unlock_page(page);
 
 	if (unlikely(f2fs_cp_error(sbi))) {
-		f2fs_submit_merged_bio(sbi, NODE, WRITE);
+		f2fs_submit_merged_write(sbi, NODE);
 		submitted = NULL;
 	}
 	if (submitted)
@@ -1518,8 +1518,7 @@ int fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 	}
 out:
 	if (last_idx != ULONG_MAX)
-		f2fs_submit_merged_bio_cond(sbi, NULL, ino, last_idx,
-							NODE, WRITE);
+		f2fs_submit_merged_write_cond(sbi, NULL, ino, last_idx, NODE);
 	return ret ? -EIO: 0;
 }
 
@@ -1625,7 +1624,7 @@ int sync_node_pages(struct f2fs_sb_info *sbi, struct writeback_control *wbc)
 	}
 out:
 	if (nwritten)
-		f2fs_submit_merged_bio(sbi, NODE, WRITE);
+		f2fs_submit_merged_write(sbi, NODE);
 	return ret;
 }
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index de31030b5041..38bb675976e2 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -328,8 +328,7 @@ static int __commit_inmem_pages(struct inode *inode,
 	}
 
 	if (last_idx != ULONG_MAX)
-		f2fs_submit_merged_bio_cond(sbi, inode, 0, last_idx,
-							DATA, WRITE);
+		f2fs_submit_merged_write_cond(sbi, inode, 0, last_idx, DATA);
 
 	if (!err)
 		__revoke_inmem_pages(inode, revoke_list, false, false);
@@ -2150,7 +2149,7 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 					&fio->new_blkaddr, sum, type);
 
 	/* writeout dirty page into bdev */
-	err = f2fs_submit_page_mbio(fio);
+	err = f2fs_submit_page_write(fio);
 	if (err == -EAGAIN) {
 		fio->old_blkaddr = fio->new_blkaddr;
 		goto reallocate;
@@ -2177,7 +2176,7 @@ void write_meta_page(struct f2fs_sb_info *sbi, struct page *page)
 		fio.op_flags &= ~REQ_META;
 
 	set_page_writeback(page);
-	f2fs_submit_page_mbio(&fio);
+	f2fs_submit_page_write(&fio);
 }
 
 void write_node_page(unsigned int nid, struct f2fs_io_info *fio)
@@ -2296,8 +2295,8 @@ void f2fs_wait_on_page_writeback(struct page *page,
 	if (PageWriteback(page)) {
 		struct f2fs_sb_info *sbi = F2FS_P_SB(page);
 
-		f2fs_submit_merged_bio_cond(sbi, page->mapping->host,
-						0, page->index, type, WRITE);
+		f2fs_submit_merged_write_cond(sbi, page->mapping->host,
+						0, page->index, type);
 		if (ordered)
 			wait_on_page_writeback(page);
 		else
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 83355ec4a92c..104a571a41c0 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -817,7 +817,7 @@ static void f2fs_put_super(struct super_block *sb)
 	mutex_unlock(&sbi->umount_mutex);
 
 	/* our cp_error case, we can wait for any writeback page */
-	f2fs_flush_merged_bios(sbi);
+	f2fs_flush_merged_writes(sbi);
 
 	iput(sbi->node_inode);
 	iput(sbi->meta_inode);
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 15da88c5c3a4..5805d92893a8 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -790,7 +790,7 @@ DEFINE_EVENT_CONDITION(f2fs__submit_page_bio, f2fs_submit_page_bio,
 	TP_CONDITION(page->mapping)
 );
 
-DEFINE_EVENT_CONDITION(f2fs__submit_page_bio, f2fs_submit_page_mbio,
+DEFINE_EVENT_CONDITION(f2fs__submit_page_bio, f2fs_submit_page_write,
 
 	TP_PROTO(struct page *page, struct f2fs_io_info *fio),
 
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
