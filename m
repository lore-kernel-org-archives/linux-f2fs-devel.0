From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/3] f2fs: use is_valid_blkaddr to verify blkaddr for
 readability
Date: Sat, 18 Apr 2015 18:05:36 +0800
Message-ID: <007c01d079bf$4e436b20$eaca4160$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Export is_valid_blkaddr() and use it to replace some codes for readability.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/checkpoint.c | 3 +--
 fs/f2fs/f2fs.h       | 1 +
 fs/f2fs/recovery.c   | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index a5e17a2..72f64b3 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -77,8 +77,7 @@ out:
 	return page;
 }
 
-static inline bool is_valid_blkaddr(struct f2fs_sb_info *sbi,
-						block_t blkaddr, int type)
+bool is_valid_blkaddr(struct f2fs_sb_info *sbi, block_t blkaddr, int type)
 {
 	switch (type) {
 	case META_NAT:
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c06a25e..5cf7e9f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1580,6 +1580,7 @@ void destroy_segment_manager_caches(void);
  */
 struct page *grab_meta_page(struct f2fs_sb_info *, pgoff_t);
 struct page *get_meta_page(struct f2fs_sb_info *, pgoff_t);
+bool is_valid_blkaddr(struct f2fs_sb_info *, block_t, int);
 int ra_meta_pages(struct f2fs_sb_info *, block_t, int, int);
 void ra_meta_pages_cond(struct f2fs_sb_info *, pgoff_t);
 long sync_meta_pages(struct f2fs_sb_info *, enum page_type, long);
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 8d8ea99..b80d9d4 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -174,7 +174,7 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head)
 	while (1) {
 		struct fsync_inode_entry *entry;
 
-		if (blkaddr < MAIN_BLKADDR(sbi) || blkaddr >= MAX_BLKADDR(sbi))
+		if (!is_valid_blkaddr(sbi, blkaddr, META_POR))
 			return 0;
 
 		page = get_meta_page(sbi, blkaddr);
@@ -396,7 +396,7 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 		dest = datablock_addr(page, dn.ofs_in_node);
 
 		if (src != dest && dest != NEW_ADDR && dest != NULL_ADDR &&
-			dest >= MAIN_BLKADDR(sbi) && dest < MAX_BLKADDR(sbi)) {
+			is_valid_blkaddr(sbi, dest, META_POR)) {
 
 			if (src == NULL_ADDR) {
 				err = reserve_new_block(&dn);
@@ -454,7 +454,7 @@ static int recover_data(struct f2fs_sb_info *sbi,
 	while (1) {
 		struct fsync_inode_entry *entry;
 
-		if (blkaddr < MAIN_BLKADDR(sbi) || blkaddr >= MAX_BLKADDR(sbi))
+		if (!is_valid_blkaddr(sbi, blkaddr, META_POR))
 			break;
 
 		ra_meta_pages_cond(sbi, blkaddr);
-- 
2.3.3
