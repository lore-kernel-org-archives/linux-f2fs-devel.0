From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev][PATCH 4/4] f2fs: avoid to ra unneeded blocks in recover flow
Date: Mon, 08 Dec 2014 15:02:52 +0800
Message-ID: <001b01d012b5$18f786c0$4ae69440$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

To improve recovery speed, f2fs try to readahead many contiguous blocks in warm
node segment, but for most time, abnormal power-off do not occur frequently, so
when mount a normal power-off f2fs image, by contrary ra so many blocks and then
invalid them will hurt the performance of mount.
It's better to just ra the first next-block for normal condition.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/checkpoint.c | 29 ++++++++++++++---------------
 fs/f2fs/f2fs.h       |  2 +-
 fs/f2fs/recovery.c   | 10 ++++++++--
 3 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index aa2a21c..5eb4d1a 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -72,21 +72,6 @@ out:
 	return page;
 }
 
-struct page *get_meta_page_ra(struct f2fs_sb_info *sbi, pgoff_t index)
-{
-	bool readahead = false;
-	struct page *page;
-
-	page = find_get_page(META_MAPPING(sbi), index);
-	if (!page || (page && !PageUptodate(page)))
-		readahead = true;
-	f2fs_put_page(page, 0);
-
-	if (readahead)
-		ra_meta_pages(sbi, index, MAX_BIO_BLOCKS(sbi), META_POR);
-	return get_meta_page(sbi, index);
-}
-
 static inline bool is_valid_blkaddr(struct f2fs_sb_info *sbi,
 						block_t blkaddr, int type)
 {
@@ -181,6 +166,20 @@ out:
 	return blkno - start;
 }
 
+void ra_meta_pages_cond(struct f2fs_sb_info *sbi, pgoff_t index)
+{
+	struct page *page;
+	bool readahead = false;
+
+	page = find_get_page(META_MAPPING(sbi), index);
+	if (!page || (page && !PageUptodate(page)))
+		readahead = true;
+	f2fs_put_page(page, 0);
+
+	if (readahead)
+		ra_meta_pages(sbi, index, MAX_BIO_BLOCKS(sbi), META_POR);
+}
+
 static int f2fs_write_meta_page(struct page *page,
 				struct writeback_control *wbc)
 {
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index fc88e8a..b465896 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1423,8 +1423,8 @@ void destroy_segment_manager_caches(void);
  */
 struct page *grab_meta_page(struct f2fs_sb_info *, pgoff_t);
 struct page *get_meta_page(struct f2fs_sb_info *, pgoff_t);
-struct page *get_meta_page_ra(struct f2fs_sb_info *, pgoff_t);
 int ra_meta_pages(struct f2fs_sb_info *, block_t, int, int);
+void ra_meta_pages_cond(struct f2fs_sb_info *, pgoff_t);
 long sync_meta_pages(struct f2fs_sb_info *, enum page_type, long);
 void add_dirty_inode(struct f2fs_sb_info *, nid_t, int type);
 void remove_dirty_inode(struct f2fs_sb_info *, nid_t, int type);
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 9a93a6e..9160a37 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -170,13 +170,15 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head)
 	curseg = CURSEG_I(sbi, CURSEG_WARM_NODE);
 	blkaddr = NEXT_FREE_BLKADDR(sbi, curseg);
 
+	ra_meta_pages(sbi, blkaddr, 1, META_POR);
+
 	while (1) {
 		struct fsync_inode_entry *entry;
 
 		if (blkaddr < MAIN_BLKADDR(sbi) || blkaddr >= MAX_BLKADDR(sbi))
 			return 0;
 
-		page = get_meta_page_ra(sbi, blkaddr);
+		page = get_meta_page(sbi, blkaddr);
 
 		if (cp_ver != cpver_of_node(page))
 			break;
@@ -227,6 +229,8 @@ next:
 		/* check next segment */
 		blkaddr = next_blkaddr_of_node(page);
 		f2fs_put_page(page, 1);
+
+		ra_meta_pages_cond(sbi, blkaddr);
 	}
 	f2fs_put_page(page, 1);
 	return err;
@@ -436,7 +440,9 @@ static int recover_data(struct f2fs_sb_info *sbi,
 		if (blkaddr < MAIN_BLKADDR(sbi) || blkaddr >= MAX_BLKADDR(sbi))
 			break;
 
-		page = get_meta_page_ra(sbi, blkaddr);
+		ra_meta_pages_cond(sbi, blkaddr);
+
+		page = get_meta_page(sbi, blkaddr);
 
 		if (cp_ver != cpver_of_node(page)) {
 			f2fs_put_page(page, 1);
-- 
2.1.2
