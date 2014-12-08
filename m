From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH 2/3] f2fs: cleanup path to need cp at fsync
Date: Mon, 08 Dec 2014 15:29:41 +0900
Message-ID: <1418020182-5356-2-git-send-email-cm224.lee@samsung.com>
References: <1418020182-5356-1-git-send-email-cm224.lee@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <1418020182-5356-1-git-send-email-cm224.lee@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Changman Lee <cm224.lee@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Added some commentaries for code readability and cleaned up if-statement
clearly.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 fs/f2fs/file.c | 79 ++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 43 insertions(+), 36 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 0b97002..3c27e0e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -149,6 +149,26 @@ static bool need_inode_page_update(struct f2fs_sb_info *sbi, nid_t ino)
 	return ret;
 }
 
+static void try_to_fix_pino(struct inode *inode)
+{
+	struct f2fs_inode_info *fi = F2FS_I(inode);
+	nid_t pino;
+
+	down_write(&fi->i_sem);
+	fi->xattr_ver = 0;
+	if (file_wrong_pino(inode) && inode->i_nlink == 1 &&
+			get_parent_ino(inode, &pino)) {
+		fi->i_pino = pino;
+		file_got_pino(inode);
+		up_write(&fi->i_sem);
+
+		mark_inode_dirty_sync(inode);
+		f2fs_write_inode(inode, NULL);
+	} else {
+		up_write(&fi->i_sem);
+	}
+}
+
 int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 {
 	struct inode *inode = file->f_mapping->host;
@@ -213,49 +233,36 @@ go_write:
 	up_read(&fi->i_sem);
 
 	if (need_cp) {
-		nid_t pino;
-
 		/* all the dirty node pages should be flushed for POR */
 		ret = f2fs_sync_fs(inode->i_sb, 1);
 
-		down_write(&fi->i_sem);
-		fi->xattr_ver = 0;
-		if (file_wrong_pino(inode) && inode->i_nlink == 1 &&
-					get_parent_ino(inode, &pino)) {
-			fi->i_pino = pino;
-			file_got_pino(inode);
-			up_write(&fi->i_sem);
-			mark_inode_dirty_sync(inode);
-			ret = f2fs_write_inode(inode, NULL);
-			if (ret)
-				goto out;
-		} else {
-			up_write(&fi->i_sem);
-		}
-	} else {
+		/*
+		 * We've secured consistency through sync_fs. Following pino
+		 * will be used only for fsynced inodes after checkpoint.
+		 */
+		try_to_fix_pino(inode);
+		goto out;
+	}
 sync_nodes:
-		sync_node_pages(sbi, ino, &wbc);
-
-		if (need_inode_block_update(sbi, ino)) {
-			mark_inode_dirty_sync(inode);
-			ret = f2fs_write_inode(inode, NULL);
-			if (ret)
-				goto out;
-			goto sync_nodes;
-		}
+	sync_node_pages(sbi, ino, &wbc);
 
-		ret = wait_on_node_pages_writeback(sbi, ino);
-		if (ret)
-			goto out;
+	if (need_inode_block_update(sbi, ino)) {
+		mark_inode_dirty_sync(inode);
+		f2fs_write_inode(inode, NULL);
+		goto sync_nodes;
+	}
 
-		/* once recovery info is written, don't need to tack this */
-		remove_dirty_inode(sbi, ino, APPEND_INO);
-		clear_inode_flag(fi, FI_APPEND_WRITE);
+	ret = wait_on_node_pages_writeback(sbi, ino);
+	if (ret)
+		goto out;
+
+	/* once recovery info is written, don't need to tack this */
+	remove_dirty_inode(sbi, ino, APPEND_INO);
+	clear_inode_flag(fi, FI_APPEND_WRITE);
 flush_out:
-		remove_dirty_inode(sbi, ino, UPDATE_INO);
-		clear_inode_flag(fi, FI_UPDATE_WRITE);
-		ret = f2fs_issue_flush(sbi);
-	}
+	remove_dirty_inode(sbi, ino, UPDATE_INO);
+	clear_inode_flag(fi, FI_UPDATE_WRITE);
+	ret = f2fs_issue_flush(sbi);
 out:
 	trace_f2fs_sync_file_exit(inode, need_cp, datasync, ret);
 	return ret;
-- 
1.9.1

