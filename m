From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/4] f2fs: report error of fill_zero
Date: Fri, 07 Aug 2015 18:36:06 +0800
Message-ID: <017e01d0d0fd$0064e560$012eb020$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

fill_zero can fail due to a lot of reason, but previously we do not handle
its return value, so its callers such as punch_hole/f2fs_zero_range may
report success, but actually can fail because of error occurs inside
fill_zero.

This patch fixes to report correct return value of fill_zero.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/file.c | 56 ++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 18 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index be69a01..016ed3b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -695,14 +695,14 @@ const struct inode_operations f2fs_file_inode_operations = {
 	.fiemap		= f2fs_fiemap,
 };
 
-static void fill_zero(struct inode *inode, pgoff_t index,
+static int fill_zero(struct inode *inode, pgoff_t index,
 					loff_t start, loff_t len)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct page *page;
 
 	if (!len)
-		return;
+		return 0;
 
 	f2fs_balance_fs(sbi);
 
@@ -710,12 +710,14 @@ static void fill_zero(struct inode *inode, pgoff_t index,
 	page = get_new_data_page(inode, NULL, index, false);
 	f2fs_unlock_op(sbi);
 
-	if (!IS_ERR(page)) {
-		f2fs_wait_on_page_writeback(page, DATA);
-		zero_user(page, start, len);
-		set_page_dirty(page);
-		f2fs_put_page(page, 1);
-	}
+	if (IS_ERR(page))
+		return PTR_ERR(page);
+
+	f2fs_wait_on_page_writeback(page, DATA);
+	zero_user(page, start, len);
+	set_page_dirty(page);
+	f2fs_put_page(page, 1);
+	return 0;
 }
 
 int truncate_hole(struct inode *inode, pgoff_t pg_start, pgoff_t pg_end)
@@ -763,14 +765,22 @@ static int punch_hole(struct inode *inode, loff_t offset, loff_t len)
 	off_end = (offset + len) & (PAGE_CACHE_SIZE - 1);
 
 	if (pg_start == pg_end) {
-		fill_zero(inode, pg_start, off_start,
+		ret = fill_zero(inode, pg_start, off_start,
 						off_end - off_start);
+		if (ret)
+			return ret;
 	} else {
-		if (off_start)
-			fill_zero(inode, pg_start++, off_start,
-					PAGE_CACHE_SIZE - off_start);
-		if (off_end)
-			fill_zero(inode, pg_end, 0, off_end);
+		if (off_start) {
+			ret = fill_zero(inode, pg_start++, off_start,
+						PAGE_CACHE_SIZE - off_start);
+			if (ret)
+				return ret;
+		}
+		if (off_end) {
+			ret = fill_zero(inode, pg_end, 0, off_end);
+			if (ret)
+				return ret;
+		}
 
 		if (pg_start < pg_end) {
 			struct address_space *mapping = inode->i_mapping;
@@ -961,14 +971,21 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 	off_end = (offset + len) & (PAGE_CACHE_SIZE - 1);
 
 	if (pg_start == pg_end) {
-		fill_zero(inode, pg_start, off_start, off_end - off_start);
+		ret = fill_zero(inode, pg_start, off_start,
+						off_end - off_start);
+		if (ret)
+			return ret;
+
 		if (offset + len > new_size)
 			new_size = offset + len;
 		new_size = max_t(loff_t, new_size, offset + len);
 	} else {
 		if (off_start) {
-			fill_zero(inode, pg_start++, off_start,
-					PAGE_CACHE_SIZE - off_start);
+			ret = fill_zero(inode, pg_start++, off_start,
+						PAGE_CACHE_SIZE - off_start);
+			if (ret)
+				return ret;
+
 			new_size = max_t(loff_t, new_size,
 						pg_start << PAGE_CACHE_SHIFT);
 		}
@@ -1010,7 +1027,10 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 		}
 
 		if (off_end) {
-			fill_zero(inode, pg_end, 0, off_end);
+			ret = fill_zero(inode, pg_end, 0, off_end);
+			if (ret)
+				goto out;
+
 			new_size = max_t(loff_t, new_size, offset + len);
 		}
 	}
-- 
2.4.2
