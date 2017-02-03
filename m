From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/5] f2fs: check last page index in cached bio to decide submission
Date: Fri,  3 Feb 2017 15:48:13 -0800
Message-ID: <20170203234816.12723-2-jaegeuk@kernel.org>
References: <20170203234816.12723-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170203234816.12723-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

If the cached bio has the last page's index, then we need to submit it.
Otherwise, we don't need to submit it and can wait for further IO merges.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c |  3 ++-
 fs/f2fs/data.c       | 39 +++++++++++++++++++++------------------
 fs/f2fs/f2fs.h       |  4 ++--
 fs/f2fs/node.c       |  9 ++++++---
 fs/f2fs/segment.c    |  8 ++++++--
 5 files changed, 37 insertions(+), 26 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index fb8cdfcaece6..e6e42a4b1344 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -249,7 +249,8 @@ static int f2fs_write_meta_page(struct page *page,
 	dec_page_count(sbi, F2FS_DIRTY_META);
 
 	if (wbc->for_reclaim)
-		f2fs_submit_merged_bio_cond(sbi, NULL, page, 0, META, WRITE);
+		f2fs_submit_merged_bio_cond(sbi, page->mapping->host,
+						0, page->index, META, WRITE);
 
 	unlock_page(page);
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 3b5f1d14cab3..c35db873637d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -243,8 +243,8 @@ static void __submit_merged_bio(struct f2fs_bio_info *io)
 	io->bio = NULL;
 }
 
-static bool __has_merged_page(struct f2fs_bio_info *io, struct inode *inode,
-						struct page *page, nid_t ino)
+static bool __has_merged_page(struct f2fs_bio_info *io,
+				struct inode *inode, nid_t ino, pgoff_t idx)
 {
 	struct bio_vec *bvec;
 	struct page *target;
@@ -253,7 +253,7 @@ static bool __has_merged_page(struct f2fs_bio_info *io, struct inode *inode,
 	if (!io->bio)
 		return false;
 
-	if (!inode && !page && !ino)
+	if (!inode && !ino)
 		return true;
 
 	bio_for_each_segment_all(bvec, io->bio, i) {
@@ -263,10 +263,11 @@ static bool __has_merged_page(struct f2fs_bio_info *io, struct inode *inode,
 		else
 			target = fscrypt_control_page(bvec->bv_page);
 
+		if (idx != target->index)
+			continue;
+
 		if (inode && inode == target->mapping->host)
 			return true;
-		if (page && page == target)
-			return true;
 		if (ino && ino == ino_of_node(target))
 			return true;
 	}
@@ -275,22 +276,21 @@ static bool __has_merged_page(struct f2fs_bio_info *io, struct inode *inode,
 }
 
 static bool has_merged_page(struct f2fs_sb_info *sbi, struct inode *inode,
-						struct page *page, nid_t ino,
-						enum page_type type)
+				nid_t ino, pgoff_t idx, enum page_type type)
 {
 	enum page_type btype = PAGE_TYPE_OF_BIO(type);
 	struct f2fs_bio_info *io = &sbi->write_io[btype];
 	bool ret;
 
 	down_read(&io->io_rwsem);
-	ret = __has_merged_page(io, inode, page, ino);
+	ret = __has_merged_page(io, inode, ino, idx);
 	up_read(&io->io_rwsem);
 	return ret;
 }
 
 static void __f2fs_submit_merged_bio(struct f2fs_sb_info *sbi,
-				struct inode *inode, struct page *page,
-				nid_t ino, enum page_type type, int rw)
+				struct inode *inode, nid_t ino, pgoff_t idx,
+				enum page_type type, int rw)
 {
 	enum page_type btype = PAGE_TYPE_OF_BIO(type);
 	struct f2fs_bio_info *io;
@@ -299,7 +299,7 @@ static void __f2fs_submit_merged_bio(struct f2fs_sb_info *sbi,
 
 	down_write(&io->io_rwsem);
 
-	if (!__has_merged_page(io, inode, page, ino))
+	if (!__has_merged_page(io, inode, ino, idx))
 		goto out;
 
 	/* change META to META_FLUSH in the checkpoint procedure */
@@ -318,15 +318,15 @@ static void __f2fs_submit_merged_bio(struct f2fs_sb_info *sbi,
 void f2fs_submit_merged_bio(struct f2fs_sb_info *sbi, enum page_type type,
 									int rw)
 {
-	__f2fs_submit_merged_bio(sbi, NULL, NULL, 0, type, rw);
+	__f2fs_submit_merged_bio(sbi, NULL, 0, 0, type, rw);
 }
 
 void f2fs_submit_merged_bio_cond(struct f2fs_sb_info *sbi,
-				struct inode *inode, struct page *page,
-				nid_t ino, enum page_type type, int rw)
+				struct inode *inode, nid_t ino, pgoff_t idx,
+				enum page_type type, int rw)
 {
-	if (has_merged_page(sbi, inode, page, ino, type))
-		__f2fs_submit_merged_bio(sbi, inode, page, ino, type, rw);
+	if (has_merged_page(sbi, inode, ino, idx, type))
+		__f2fs_submit_merged_bio(sbi, inode, ino, idx, type, rw);
 }
 
 void f2fs_flush_merged_bios(struct f2fs_sb_info *sbi)
@@ -1428,7 +1428,8 @@ static int f2fs_write_data_page(struct page *page,
 		ClearPageUptodate(page);
 
 	if (wbc->for_reclaim) {
-		f2fs_submit_merged_bio_cond(sbi, NULL, page, 0, DATA, WRITE);
+		f2fs_submit_merged_bio_cond(sbi, inode, 0, page->index,
+						DATA, WRITE);
 		remove_dirty_inode(inode);
 	}
 
@@ -1464,6 +1465,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 	pgoff_t index;
 	pgoff_t end;		/* Inclusive */
 	pgoff_t done_index;
+	pgoff_t last_idx = 0;
 	int cycled;
 	int range_whole = 0;
 	int tag;
@@ -1553,6 +1555,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 				break;
 			} else {
 				nwritten++;
+				last_idx = page->index;
 			}
 
 			if (--wbc->nr_to_write <= 0 &&
@@ -1576,7 +1579,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 
 	if (nwritten)
 		f2fs_submit_merged_bio_cond(F2FS_M_SB(mapping), mapping->host,
-							NULL, 0, DATA, WRITE);
+						0, last_idx, DATA, WRITE);
 
 	return ret;
 }
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 23b34d01e454..f01a73198176 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2224,8 +2224,8 @@ void destroy_checkpoint_caches(void);
 void f2fs_submit_merged_bio(struct f2fs_sb_info *sbi, enum page_type type,
 			int rw);
 void f2fs_submit_merged_bio_cond(struct f2fs_sb_info *sbi,
-				struct inode *inode, struct page *page,
-				nid_t ino, enum page_type type, int rw);
+				struct inode *inode, nid_t ino, pgoff_t idx,
+				enum page_type type, int rw);
 void f2fs_flush_merged_bios(struct f2fs_sb_info *sbi);
 int f2fs_submit_page_bio(struct f2fs_io_info *fio);
 int f2fs_submit_page_mbio(struct f2fs_io_info *fio);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 69c38a0022e7..c573954571dd 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1321,7 +1321,7 @@ static struct page *last_fsync_dnode(struct f2fs_sb_info *sbi, nid_t ino)
 int fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 			struct writeback_control *wbc, bool atomic)
 {
-	pgoff_t index, end;
+	pgoff_t index, end, last_idx;
 	struct pagevec pvec;
 	int ret = 0;
 	struct page *last_page = NULL;
@@ -1404,6 +1404,7 @@ int fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 				break;
 			} else {
 				nwritten++;
+				last_idx = page->index;
 			}
 
 			if (page == last_page) {
@@ -1430,7 +1431,8 @@ int fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 	}
 out:
 	if (nwritten)
-		f2fs_submit_merged_bio_cond(sbi, NULL, NULL, ino, NODE, WRITE);
+		f2fs_submit_merged_bio_cond(sbi, NULL, ino, last_idx,
+							NODE, WRITE);
 	return ret ? -EIO: 0;
 }
 
@@ -1629,7 +1631,8 @@ static int f2fs_write_node_page(struct page *page,
 	up_read(&sbi->node_write);
 
 	if (wbc->for_reclaim)
-		f2fs_submit_merged_bio_cond(sbi, NULL, page, 0, NODE, WRITE);
+		f2fs_submit_merged_bio_cond(sbi, page->mapping->host, 0,
+						page->index, NODE, WRITE);
 
 	unlock_page(page);
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 3f56f709012a..984d94efe8cb 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -264,6 +264,7 @@ static int __commit_inmem_pages(struct inode *inode,
 		.encrypted_page = NULL,
 	};
 	bool submit_bio = false;
+	pgoff_t last_idx;
 	int err = 0;
 
 	list_for_each_entry_safe(cur, tmp, &fi->inmem_pages, list) {
@@ -291,13 +292,15 @@ static int __commit_inmem_pages(struct inode *inode,
 			cur->old_addr = fio.old_blkaddr;
 
 			submit_bio = true;
+			last_idx = page->index;
 		}
 		unlock_page(page);
 		list_move_tail(&cur->list, revoke_list);
 	}
 
 	if (submit_bio)
-		f2fs_submit_merged_bio_cond(sbi, inode, NULL, 0, DATA, WRITE);
+		f2fs_submit_merged_bio_cond(sbi, inode, 0, last_idx,
+							DATA, WRITE);
 
 	if (!err)
 		__revoke_inmem_pages(inode, revoke_list, false, false);
@@ -1917,7 +1920,8 @@ void f2fs_wait_on_page_writeback(struct page *page,
 	if (PageWriteback(page)) {
 		struct f2fs_sb_info *sbi = F2FS_P_SB(page);
 
-		f2fs_submit_merged_bio_cond(sbi, NULL, page, 0, type, WRITE);
+		f2fs_submit_merged_bio_cond(sbi, page->mapping->host,
+						0, page->index, type, WRITE);
 		if (ordered)
 			wait_on_page_writeback(page);
 		else
-- 
2.11.0
