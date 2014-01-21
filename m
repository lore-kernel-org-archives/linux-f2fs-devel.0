From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 1/2] f2fs: call mark_inode_dirty to flush dirty pages
Date: Tue, 21 Jan 2014 18:54:33 +0900
Message-ID: <1390298075-21458-1-git-send-email-jaegeuk.kim@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk.kim@samsung.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

If a dentry page is updated, we should call mark_inode_dirty to add the inode
into the dirty list, so that its dentry pages are flushed to the disk.
Otherwise, the inode can be evicted without flush.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/dir.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index cd055b6..1679e8b 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -387,7 +387,10 @@ static void update_parent_metadata(struct inode *dir, struct inode *inode,
 		}
 		clear_inode_flag(F2FS_I(inode), FI_NEW_INODE);
 	}
+
 	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
+	mark_inode_dirty(dir);
+
 	if (F2FS_I(dir)->i_current_depth != current_depth) {
 		F2FS_I(dir)->i_current_depth = current_depth;
 		set_inode_flag(F2FS_I(dir), FI_UPDATE_DIR);
@@ -395,8 +398,6 @@ static void update_parent_metadata(struct inode *dir, struct inode *inode,
 
 	if (is_inode_flag_set(F2FS_I(dir), FI_UPDATE_DIR))
 		update_inode_page(dir);
-	else
-		mark_inode_dirty(dir);
 
 	if (is_inode_flag_set(F2FS_I(inode), FI_INC_LINK))
 		clear_inode_flag(F2FS_I(inode), FI_INC_LINK);
@@ -549,12 +550,11 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	set_page_dirty(page);
 
 	dir->i_ctime = dir->i_mtime = CURRENT_TIME;
+	mark_inode_dirty(dir);
 
 	if (inode && S_ISDIR(inode->i_mode)) {
 		drop_nlink(dir);
 		update_inode_page(dir);
-	} else {
-		mark_inode_dirty(dir);
 	}
 
 	if (inode) {
-- 
1.8.4.474.g128a96c
