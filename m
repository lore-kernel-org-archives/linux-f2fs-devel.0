From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH] f2fs: cleanup redundant macro
Date: Mon, 01 Dec 2014 16:29:58 +0900
Message-ID: <1417418998-7356-1-git-send-email-cm224.lee@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Changman Lee <cm224.lee@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

We've already made fi and sbi for inode. Let's avoid duplicated work.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 fs/f2fs/file.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 0c5ae87..f02102c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -203,10 +203,10 @@ go_write:
 		ret = f2fs_sync_fs(inode->i_sb, 1);
 
 		down_write(&fi->i_sem);
-		F2FS_I(inode)->xattr_ver = 0;
+		fi->xattr_ver = 0;
 		if (file_wrong_pino(inode) && inode->i_nlink == 1 &&
 					get_parent_ino(inode, &pino)) {
-			F2FS_I(inode)->i_pino = pino;
+			fi->i_pino = pino;
 			file_got_pino(inode);
 			up_write(&fi->i_sem);
 			mark_inode_dirty_sync(inode);
@@ -238,7 +238,7 @@ sync_nodes:
 flush_out:
 		remove_dirty_inode(sbi, ino, UPDATE_INO);
 		clear_inode_flag(fi, FI_UPDATE_WRITE);
-		ret = f2fs_issue_flush(F2FS_I_SB(inode));
+		ret = f2fs_issue_flush(sbi);
 	}
 out:
 	trace_f2fs_sync_file_exit(inode, need_cp, datasync, ret);
-- 
1.9.1

