From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH 1/3] f2fs: check if inode state is dirty at fsync
Date: Mon, 08 Dec 2014 15:29:40 +0900
Message-ID: <1418020182-5356-1-git-send-email-cm224.lee@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Changman Lee <cm224.lee@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

If inode state is dirty, go straight to write.

Suggested-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 fs/f2fs/file.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b6f3fbf..0b97002 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -138,6 +138,17 @@ static inline bool need_do_checkpoint(struct inode *inode)
 	return need_cp;
 }
 
+static bool need_inode_page_update(struct f2fs_sb_info *sbi, nid_t ino)
+{
+	struct page *i = find_get_page(NODE_MAPPING(sbi), ino);
+	bool ret = false;
+	/* But we need to avoid that there are some inode updates */
+	if ((i && PageDirty(i)) || need_inode_block_update(sbi, ino))
+		ret = true;
+	f2fs_put_page(i, 0);
+	return ret;
+}
+
 int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 {
 	struct inode *inode = file->f_mapping->host;
@@ -168,19 +179,21 @@ int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 		return ret;
 	}
 
+	/* if the inode is dirty, let's recover all the time */
+	if (!datasync && is_inode_flag_set(fi, FI_DIRTY_INODE)) {
+		update_inode_page(inode);
+		goto go_write;
+	}
+
 	/*
 	 * if there is no written data, don't waste time to write recovery info.
 	 */
 	if (!is_inode_flag_set(fi, FI_APPEND_WRITE) &&
 			!exist_written_data(sbi, ino, APPEND_INO)) {
-		struct page *i = find_get_page(NODE_MAPPING(sbi), ino);
 
-		/* But we need to avoid that there are some inode updates */
-		if ((i && PageDirty(i)) || need_inode_block_update(sbi, ino)) {
-			f2fs_put_page(i, 0);
+		/* it may call write_inode just prior to fsync */
+		if (need_inode_page_update(sbi, ino))
 			goto go_write;
-		}
-		f2fs_put_page(i, 0);
 
 		if (is_inode_flag_set(fi, FI_UPDATE_WRITE) ||
 				exist_written_data(sbi, ino, UPDATE_INO))
-- 
1.9.1

