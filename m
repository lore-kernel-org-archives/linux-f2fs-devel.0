From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: fix fs corruption due to zero inode page
Date: Tue, 11 Apr 2017 15:16:41 -0700
Message-ID: <20170411221641.4432-1-jaegeuk@kernel.org>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, stable@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch fixes the following scenario.

- f2fs_create/f2fs_mkdir             - write_checkpoint
 - f2fs_mark_inode_dirty_sync         - block_operations
                                       - f2fs_lock_all
                                       - f2fs_sync_inode_meta
                                        - f2fs_unlock_all
                                        - sync_inode_metadata
 - f2fs_lock_op
                                         - f2fs_write_inode
                                          - update_inode_page
                                           - get_node_page
                                             return -ENOENT
 - new_inode_page
  - fill_node_footer
 - f2fs_mark_inode_dirty_sync
 - ...
 - f2fs_unlock_op
                                          - f2fs_inode_synced
                                       - f2fs_lock_all
                                       - do_checkpoint

In this checkpoint, we can get an inode page which contains zeros having valid
node footer only.

Cc: <stable@vger.kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 3 ++-
 fs/f2fs/inode.c      | 3 ++-
 fs/f2fs/namei.c      | 5 +++--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 9db92990f193..300d88206621 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -936,7 +936,8 @@ int f2fs_sync_inode_meta(struct f2fs_sb_info *sbi)
 			sync_inode_metadata(inode, 0);
 
 			/* it's on eviction */
-			if (is_inode_flag_set(inode, FI_DIRTY_INODE))
+			if (is_inode_flag_set(inode, FI_DIRTY_INODE) &&
+					!is_inode_flag_set(inode, FI_NEW_INODE))
 				update_inode_page(inode);
 			iput(inode);
 		}
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 2520fa72b23f..e7ad3f213400 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -332,7 +332,8 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
 			inode->i_ino == F2FS_META_INO(sbi))
 		return 0;
 
-	if (!is_inode_flag_set(inode, FI_DIRTY_INODE))
+	if (!is_inode_flag_set(inode, FI_DIRTY_INODE) ||
+			is_inode_flag_set(inode, FI_NEW_INODE))
 		return 0;
 
 	/*
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 8906c9f6cce4..b0bf6a41ac34 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -44,6 +44,9 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 
 	inode_init_owner(inode, dir, mode);
 
+	/* we should set this early before dirting inode */
+	set_inode_flag(inode, FI_NEW_INODE);
+
 	inode->i_ino = ino;
 	inode->i_blocks = 0;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
@@ -60,8 +63,6 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 	if (f2fs_encrypted_inode(dir) && f2fs_may_encrypt(inode))
 		f2fs_set_encrypted_inode(inode);
 
-	set_inode_flag(inode, FI_NEW_INODE);
-
 	if (test_opt(sbi, INLINE_XATTR))
 		set_inode_flag(inode, FI_INLINE_XATTR);
 	if (test_opt(sbi, INLINE_DATA) && f2fs_may_inline_data(inode))
-- 
2.11.0
