From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/3] f2fs: flush symlink path to avoid broken symlink after POR
Date: Thu, 16 Apr 2015 00:30:43 -0700
Message-ID: <1429169445-18306-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch tries to avoid broken symlink case after POR in best effort.
This results in performance regression.
But, if f2fs has inline_data and the target path is under 3KB-sized long,
the page would be stored in its inode_block, so that there would be no
performance regression.

Note that, if user wants to keep this file atomically, it needs to trigger
dir->fsync.
And, there is still a hole to produce broken symlink.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/namei.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 8055e30..5d990d8 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -324,6 +324,17 @@ static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
 	d_instantiate(dentry, inode);
 	unlock_new_inode(inode);
 
+	/*
+	 * Let's flush symlink data in order to avoid broken symlink as much as
+	 * possible. Nevertheless, fsyncing is the best way, but there is no
+	 * way to get a file descriptor in order to flush that.
+	 *
+	 * Note that, it needs to do dir->fsync to make this recoverable.
+	 * If the symlink path is stored into inline_data, there is no
+	 * performance regression.
+	 */
+	filemap_write_and_wait_range(inode->i_mapping, 0, symlen);
+
 	if (IS_DIRSYNC(dir))
 		f2fs_sync_fs(sbi->sb, 1);
 	return err;
-- 
2.1.1

