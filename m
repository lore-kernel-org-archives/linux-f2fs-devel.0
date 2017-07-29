From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH] f2fs: provide f2fs_balance_fs to __write_data_page for dentry pages
Date: Sat, 29 Jul 2017 21:19:25 +0800
Message-ID: <1501334365-123333-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, sylinux@163.com, yunlong.song@huawei.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

f2fs_balance_fs of dentry pages is skipped in __write_data_page due to deadlock
of gc_mutex in write_checkpoint flow. This patch enables f2fs_balance_fs for
normal dentry page writeback to ensure there are always enough free segments.

Reported-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/checkpoint.c |  2 +-
 fs/f2fs/data.c       | 67 +++++++++++++++++++++++++++++++++++++++++++++-------
 fs/f2fs/f2fs.h       |  1 +
 3 files changed, 61 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 3c84a25..2882878 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -904,7 +904,7 @@ int sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type)
 	if (inode) {
 		unsigned long cur_ino = inode->i_ino;
 
-		filemap_fdatawrite(inode->i_mapping);
+		f2fs_filemap_fdatawrite(inode->i_mapping, is_dir);
 		iput(inode);
 		/* We need to give cpu to another writers. */
 		if (ino == cur_ino) {
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index aefc2a5..ed7efa5 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1475,7 +1475,7 @@ int do_write_data_page(struct f2fs_io_info *fio)
 }
 
 static int __write_data_page(struct page *page, bool *submitted,
-				struct writeback_control *wbc)
+				struct writeback_control *wbc, bool do_balance)
 {
 	struct inode *inode = page->mapping->host;
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
@@ -1578,7 +1578,7 @@ static int __write_data_page(struct page *page, bool *submitted,
 	}
 
 	unlock_page(page);
-	if (!S_ISDIR(inode->i_mode))
+	if (do_balance)
 		f2fs_balance_fs(sbi, need_balance_fs);
 
 	if (unlikely(f2fs_cp_error(sbi))) {
@@ -1602,7 +1602,7 @@ static int __write_data_page(struct page *page, bool *submitted,
 static int f2fs_write_data_page(struct page *page,
 					struct writeback_control *wbc)
 {
-	return __write_data_page(page, NULL, wbc);
+	return __write_data_page(page, NULL, wbc, true);
 }
 
 /*
@@ -1611,7 +1611,7 @@ static int f2fs_write_data_page(struct page *page,
  * warm/hot data page.
  */
 static int f2fs_write_cache_pages(struct address_space *mapping,
-					struct writeback_control *wbc)
+					struct writeback_control *wbc, bool do_balance)
 {
 	int ret = 0;
 	int done = 0;
@@ -1701,7 +1701,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 			if (!clear_page_dirty_for_io(page))
 				goto continue_unlock;
 
-			ret = __write_data_page(page, &submitted, wbc);
+			ret = __write_data_page(page, &submitted, wbc, do_balance);
 			if (unlikely(ret)) {
 				/*
 				 * keep nr_to_write, since vfs uses this to
@@ -1756,8 +1756,8 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 	return ret;
 }
 
-static int f2fs_write_data_pages(struct address_space *mapping,
-			    struct writeback_control *wbc)
+static int _f2fs_write_data_pages(struct address_space *mapping,
+			    struct writeback_control *wbc, bool do_balance)
 {
 	struct inode *inode = mapping->host;
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
@@ -1794,7 +1794,7 @@ static int f2fs_write_data_pages(struct address_space *mapping,
 		goto skip_write;
 
 	blk_start_plug(&plug);
-	ret = f2fs_write_cache_pages(mapping, wbc);
+	ret = f2fs_write_cache_pages(mapping, wbc, do_balance);
 	blk_finish_plug(&plug);
 
 	if (wbc->sync_mode == WB_SYNC_ALL)
@@ -1813,6 +1813,57 @@ static int f2fs_write_data_pages(struct address_space *mapping,
 	return 0;
 }
 
+static int f2fs_write_data_pages(struct address_space *mapping,
+			    struct writeback_control *wbc)
+{
+	return	_f2fs_write_data_pages(mapping, wbc, true);
+}
+
+/*
+ * This function was copied from do_writepages from mm/page-writeback.c.
+ * The major change is changing writepages to _f2fs_write_data_pages.
+ */
+static int f2fs_do_writepages(struct address_space *mapping,
+				struct writeback_control *wbc, bool is_dir)
+{
+	int ret;
+
+	if (wbc->nr_to_write <= 0)
+		return 0;
+	while (1) {
+		ret = _f2fs_write_data_pages(mapping, wbc, !is_dir);
+		if ((ret != -ENOMEM) || (wbc->sync_mode != WB_SYNC_ALL))
+			break;
+		cond_resched();
+		congestion_wait(BLK_RW_ASYNC, HZ/50);
+	}
+	return ret;
+}
+
+/*
+ * This function was copied from __filemap_fdatawrite_range from
+ * mm/filemap.c. The major change is changing do_writepages to
+ * f2fs_do_writepages.
+ */
+int f2fs_filemap_fdatawrite(struct address_space *mapping, bool is_dir)
+{
+	int ret;
+	struct writeback_control wbc = {
+		.sync_mode = WB_SYNC_ALL,
+		.nr_to_write = LONG_MAX,
+		.range_start = 0,
+		.range_end = LLONG_MAX,
+	};
+
+	if (!mapping_cap_writeback_dirty(mapping))
+		return 0;
+
+	wbc_attach_fdatawrite_inode(&wbc, mapping->host);
+	ret = f2fs_do_writepages(mapping, &wbc, is_dir);
+	wbc_detach_inode(&wbc);
+	return ret;
+}
+
 static void f2fs_write_failed(struct address_space *mapping, loff_t to)
 {
 	struct inode *inode = mapping->host;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9280283..ea9bebb 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2572,6 +2572,7 @@ void f2fs_invalidate_page(struct page *page, unsigned int offset,
 int f2fs_migrate_page(struct address_space *mapping, struct page *newpage,
 			struct page *page, enum migrate_mode mode);
 #endif
+int f2fs_filemap_fdatawrite(struct address_space *mapping, bool is_dir);
 
 /*
  * gc.c
-- 
1.8.5.2
