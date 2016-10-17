From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/3] f2fs: call f2fs_balance_fs for setattr
Date: Mon, 17 Oct 2016 14:56:44 -0700
Message-ID: <20161017215645.435-2-jaegeuk@kernel.org>
References: <20161017215645.435-1-jaegeuk@kernel.org>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20161017215645.435-1-jaegeuk@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

If inode becomes dirty, we need to check the # of dirty inodes whether or not
further checkpoint would be required.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 0907efa..e63d0fd 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -694,7 +694,6 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 			err = f2fs_truncate(inode);
 			if (err)
 				return err;
-			f2fs_balance_fs(F2FS_I_SB(inode), true);
 		} else {
 			/*
 			 * do not trim all blocks after i_size if target size is
@@ -723,6 +722,10 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 	}
 
 	f2fs_mark_inode_dirty_sync(inode);
+
+	/* inode change will produce dirty node pages flushed by checkpoint */
+	f2fs_balance_fs(F2FS_I_SB(inode), true);
+
 	return err;
 }
 
-- 
2.8.3

