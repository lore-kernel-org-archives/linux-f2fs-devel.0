From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH] f2fs: unify rw and sync parameter into rw
Date: Tue, 10 Dec 2013 13:44:52 +0900
Message-ID: <1386650692-11618-1-git-send-email-cm224.lee@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Cc: Changman Lee <cm224.lee@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

When we submit io, we can know whether the io is read or write and sync
mode or not. So we can remove redundant sync parameter.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 fs/f2fs/checkpoint.c |   12 ++++++------
 fs/f2fs/data.c       |   19 ++++++++-----------
 fs/f2fs/f2fs.h       |    2 +-
 fs/f2fs/gc.c         |    2 +-
 fs/f2fs/node.c       |   15 ++++++++-------
 fs/f2fs/segment.c    |   16 ++++++++--------
 6 files changed, 32 insertions(+), 34 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 38f4a224..76b557c 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -158,8 +158,8 @@ long sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
 	}
 
 	if (nwritten)
-		f2fs_submit_merged_bio(sbi, type, nr_to_write == LONG_MAX,
-								WRITE);
+		f2fs_submit_merged_bio(sbi, type,
+				(nr_to_write == LONG_MAX) ? WRITE_SYNC : WRITE);
 
 	return nwritten;
 }
@@ -592,7 +592,7 @@ retry:
 		 * We should submit bio, since it exists several
 		 * wribacking dentry pages in the freeing inode.
 		 */
-		f2fs_submit_merged_bio(sbi, DATA, true, WRITE);
+		f2fs_submit_merged_bio(sbi, DATA, WRITE_SYNC);
 	}
 	goto retry;
 }
@@ -798,9 +798,9 @@ void write_checkpoint(struct f2fs_sb_info *sbi, bool is_umount)
 
 	trace_f2fs_write_checkpoint(sbi->sb, is_umount, "finish block_ops");
 
-	f2fs_submit_merged_bio(sbi, DATA, true, WRITE);
-	f2fs_submit_merged_bio(sbi, NODE, true, WRITE);
-	f2fs_submit_merged_bio(sbi, META, true, WRITE);
+	f2fs_submit_merged_bio(sbi, DATA, WRITE_SYNC);
+	f2fs_submit_merged_bio(sbi, NODE, WRITE_SYNC);
+	f2fs_submit_merged_bio(sbi, META, WRITE_SYNC);
 
 	/*
 	 * update checkpoint pack index
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 4e2fc09..470db6a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -95,7 +95,7 @@ static void f2fs_write_end_io(struct bio *bio, int err)
 
 static void __submit_merged_bio(struct f2fs_sb_info *sbi,
 				struct f2fs_bio_info *io,
-				enum page_type type, bool sync, int rw)
+				enum page_type type, int rw)
 {
 	enum page_type btype = PAGE_TYPE_OF_BIO(type);
 
@@ -106,16 +106,12 @@ static void __submit_merged_bio(struct f2fs_sb_info *sbi,
 		rw |= REQ_META;
 
 	if (is_read_io(rw)) {
-		if (sync)
-			rw |= READ_SYNC;
 		submit_bio(rw, io->bio);
 		trace_f2fs_submit_read_bio(sbi->sb, rw, type, io->bio);
 		io->bio = NULL;
 		return;
 	}
 
-	if (sync)
-		rw |= WRITE_SYNC;
 	if (type >= META_FLUSH)
 		rw |= WRITE_FLUSH_FUA;
 
@@ -136,7 +132,7 @@ static void __submit_merged_bio(struct f2fs_sb_info *sbi,
 }
 
 void f2fs_submit_merged_bio(struct f2fs_sb_info *sbi,
-				enum page_type type, bool sync, int rw)
+				enum page_type type, int rw)
 {
 	enum page_type btype = PAGE_TYPE_OF_BIO(type);
 	struct f2fs_bio_info *io;
@@ -144,7 +140,7 @@ void f2fs_submit_merged_bio(struct f2fs_sb_info *sbi,
 	io = is_read_io(rw) ? &sbi->read_io : &sbi->write_io[btype];
 
 	mutex_lock(&io->io_mutex);
-	__submit_merged_bio(sbi, io, type, sync, rw);
+	__submit_merged_bio(sbi, io, type, rw);
 	mutex_unlock(&io->io_mutex);
 }
 
@@ -195,7 +191,7 @@ void f2fs_submit_page_mbio(struct f2fs_sb_info *sbi, struct page *page,
 		inc_page_count(sbi, F2FS_WRITEBACK);
 
 	if (io->bio && io->last_block_in_bio != blk_addr - 1)
-		__submit_merged_bio(sbi, io, type, true, rw);
+		__submit_merged_bio(sbi, io, type, rw);
 alloc_new:
 	if (io->bio == NULL) {
 		bio_blocks = MAX_BIO_BLOCKS(max_hw_blocks(sbi));
@@ -212,7 +208,7 @@ alloc_new:
 
 	if (bio_add_page(io->bio, page, PAGE_CACHE_SIZE, 0) <
 							PAGE_CACHE_SIZE) {
-		__submit_merged_bio(sbi, io, type, true, rw);
+		__submit_merged_bio(sbi, io, type, rw);
 		goto alloc_new;
 	}
 
@@ -733,7 +729,7 @@ write:
 		goto redirty_out;
 
 	if (wbc->for_reclaim)
-		f2fs_submit_merged_bio(sbi, DATA, true, WRITE);
+		f2fs_submit_merged_bio(sbi, DATA, WRITE_SYNC);
 
 	clear_cold_data(page);
 out:
@@ -785,7 +781,8 @@ static int f2fs_write_data_pages(struct address_space *mapping,
 	ret = write_cache_pages(mapping, wbc, __f2fs_writepage, mapping);
 	if (locked)
 		mutex_unlock(&sbi->writepages);
-	f2fs_submit_merged_bio(sbi, DATA, wbc->sync_mode == WB_SYNC_ALL, WRITE);
+	f2fs_submit_merged_bio(sbi, DATA,
+			(wbc->sync_mode == WB_SYNC_ALL) ? WRITE_SYNC : WRITE);
 
 	remove_dirty_dir_inode(inode);
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 10eca02..3a82b57 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1140,7 +1140,7 @@ void destroy_checkpoint_caches(void);
 /*
  * data.c
  */
-void f2fs_submit_merged_bio(struct f2fs_sb_info *, enum page_type, bool, int);
+void f2fs_submit_merged_bio(struct f2fs_sb_info *, enum page_type, int);
 int f2fs_submit_page_bio(struct f2fs_sb_info *, struct page *, block_t, int);
 void f2fs_submit_page_mbio(struct f2fs_sb_info *, struct page *, block_t,
 							enum page_type, int);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 2886aef..6f5f303 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -631,7 +631,7 @@ next_iput:
 		goto next_step;
 
 	if (gc_type == FG_GC) {
-		f2fs_submit_merged_bio(sbi, DATA, true, WRITE);
+		f2fs_submit_merged_bio(sbi, DATA, WRITE_SYNC);
 
 		/*
 		 * In the case of FG_GC, it'd be better to reclaim this victim
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 0855168..e597ecd 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -106,11 +106,11 @@ static void ra_nat_pages(struct f2fs_sb_info *sbi, int nid)
 			f2fs_put_page(page, 1);
 			continue;
 		}
-		f2fs_submit_page_mbio(sbi, page, index, META, READ);
+		f2fs_submit_page_mbio(sbi, page, index, META, READ_SYNC);
 		mark_page_accessed(page);
 		f2fs_put_page(page, 0);
 	}
-	f2fs_submit_merged_bio(sbi, META, true, READ);
+	f2fs_submit_merged_bio(sbi, META, READ_SYNC);
 }
 
 static struct nat_entry *__lookup_nat_cache(struct f2fs_nm_info *nm_i, nid_t n)
@@ -1135,9 +1135,10 @@ continue_unlock:
 		goto next_step;
 	}
 
-	if (wrote)
-		f2fs_submit_merged_bio(sbi, NODE, wbc->sync_mode == WB_SYNC_ALL,
-									WRITE);
+	if (wrote) {
+		int rw = (wbc->sync_mode == WB_SYNC_ALL) ? WRITE_SYNC : WRITE;
+		f2fs_submit_merged_bio(sbi, NODE, rw);
+	}
 	return nwritten;
 }
 
@@ -1594,9 +1595,9 @@ static int ra_sum_pages(struct f2fs_sb_info *sbi, struct list_head *pages,
 	}
 
 	list_for_each_entry(page, pages, lru)
-		f2fs_submit_page_mbio(sbi, page, page->index, META, READ);
+		f2fs_submit_page_mbio(sbi, page, page->index, META, READ_SYNC);
 
-	f2fs_submit_merged_bio(sbi, META, true, READ);
+	f2fs_submit_merged_bio(sbi, META, READ_SYNC);
 	return 0;
 }
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index ca9adf5..462524c 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -900,7 +900,7 @@ static void do_write_page(struct f2fs_sb_info *sbi, struct page *page,
 		fill_node_footer_blkaddr(page, NEXT_FREE_BLKADDR(sbi, curseg));
 
 	/* writeout dirty page into bdev */
-	f2fs_submit_page_mbio(sbi, page, *new_blkaddr, p_type, WRITE);
+	f2fs_submit_page_mbio(sbi, page, *new_blkaddr, p_type, WRITE_SYNC);
 
 	mutex_unlock(&curseg->curseg_mutex);
 }
@@ -908,7 +908,7 @@ static void do_write_page(struct f2fs_sb_info *sbi, struct page *page,
 void write_meta_page(struct f2fs_sb_info *sbi, struct page *page)
 {
 	set_page_writeback(page);
-	f2fs_submit_page_mbio(sbi, page, page->index, META, WRITE);
+	f2fs_submit_page_mbio(sbi, page, page->index, META, WRITE_SYNC);
 }
 
 void write_node_page(struct f2fs_sb_info *sbi, struct page *page,
@@ -938,7 +938,7 @@ void write_data_page(struct inode *inode, struct page *page,
 void rewrite_data_page(struct f2fs_sb_info *sbi, struct page *page,
 					block_t old_blk_addr)
 {
-	f2fs_submit_page_mbio(sbi, page, old_blk_addr, DATA, WRITE);
+	f2fs_submit_page_mbio(sbi, page, old_blk_addr, DATA, WRITE_SYNC);
 }
 
 void recover_data_page(struct f2fs_sb_info *sbi,
@@ -1025,8 +1025,8 @@ void rewrite_node_page(struct f2fs_sb_info *sbi,
 
 	/* rewrite node page */
 	set_page_writeback(page);
-	f2fs_submit_page_mbio(sbi, page, new_blkaddr, NODE, WRITE);
-	f2fs_submit_merged_bio(sbi, NODE, true, WRITE);
+	f2fs_submit_page_mbio(sbi, page, new_blkaddr, NODE, WRITE_SYNC);
+	f2fs_submit_merged_bio(sbi, NODE, WRITE_SYNC);
 	refresh_sit_entry(sbi, old_blkaddr, new_blkaddr);
 
 	locate_dirty_segment(sbi, old_cursegno);
@@ -1041,7 +1041,7 @@ void f2fs_wait_on_page_writeback(struct page *page,
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(page->mapping->host->i_sb);
 	if (PageWriteback(page)) {
-		f2fs_submit_merged_bio(sbi, type, sync, WRITE);
+		f2fs_submit_merged_bio(sbi, type, sync ? WRITE_SYNC : WRITE);
 		wait_on_page_writeback(page);
 	}
 }
@@ -1593,13 +1593,13 @@ repeat:
 			continue;
 		}
 
-		f2fs_submit_page_mbio(sbi, page, blk_addr, META, READ);
+		f2fs_submit_page_mbio(sbi, page, blk_addr, META, READ_SYNC);
 
 		mark_page_accessed(page);
 		f2fs_put_page(page, 0);
 	}
 
-	f2fs_submit_merged_bio(sbi, META, true, READ);
+	f2fs_submit_merged_bio(sbi, META, READ_SYNC);
 	return blkno - start;
 }
 
-- 
1.7.9.5

