From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: relax permission for atomic/volatile ioctls
Date: Wed,  5 Jul 2017 19:23:26 -0700
Message-ID: <20170706022326.52594-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch allows atomic/volatile ioctls for sqlite under sdcardfs.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f5d6357e8360..dd8f5d2caa48 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1587,9 +1587,6 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 	struct inode *inode = file_inode(filp);
 	int ret;
 
-	if (!inode_owner_or_capable(inode))
-		return -EACCES;
-
 	if (!S_ISREG(inode->i_mode))
 		return -EINVAL;
 
@@ -1636,9 +1633,6 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 	struct inode *inode = file_inode(filp);
 	int ret;
 
-	if (!inode_owner_or_capable(inode))
-		return -EACCES;
-
 	ret = mnt_want_write_file(filp);
 	if (ret)
 		return ret;
@@ -1672,9 +1666,6 @@ static int f2fs_ioc_start_volatile_write(struct file *filp)
 	struct inode *inode = file_inode(filp);
 	int ret;
 
-	if (!inode_owner_or_capable(inode))
-		return -EACCES;
-
 	if (!S_ISREG(inode->i_mode))
 		return -EINVAL;
 
@@ -1707,9 +1698,6 @@ static int f2fs_ioc_release_volatile_write(struct file *filp)
 	struct inode *inode = file_inode(filp);
 	int ret;
 
-	if (!inode_owner_or_capable(inode))
-		return -EACCES;
-
 	ret = mnt_want_write_file(filp);
 	if (ret)
 		return ret;
@@ -1736,9 +1724,6 @@ static int f2fs_ioc_abort_volatile_write(struct file *filp)
 	struct inode *inode = file_inode(filp);
 	int ret;
 
-	if (!inode_owner_or_capable(inode))
-		return -EACCES;
-
 	ret = mnt_want_write_file(filp);
 	if (ret)
 		return ret;
-- 
2.13.0.rc1.294.g07d810a77f-goog
