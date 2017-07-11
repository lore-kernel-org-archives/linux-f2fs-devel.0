From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH] f2fs: remove extra inode_unlock() in error path
Date: Tue, 11 Jul 2017 17:30:33 +0100
Message-ID: <20170711163033.3700-1-lhenriques@suse.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Luis Henriques <lhenriques@suse.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This commit removes an extra inode_unlock() that is being done in function
f2fs_ioc_setflags error path.  While there, get rid of a useless 'out'
label as well.

Fixes: 0abd675e97e6 ("f2fs: support plain user/group quota")
Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 fs/f2fs/file.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index a0e6d2c65a9e..2706130c261b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1538,7 +1538,6 @@ static int f2fs_ioc_setflags(struct file *filp, unsigned long arg)
 
 	/* Is it quota file? Do not allow user to mess with it */
 	if (IS_NOQUOTA(inode)) {
-		inode_unlock(inode);
 		ret = -EPERM;
 		goto unlock_out;
 	}
@@ -1549,9 +1548,8 @@ static int f2fs_ioc_setflags(struct file *filp, unsigned long arg)
 
 	if ((flags ^ oldflags) & (FS_APPEND_FL | FS_IMMUTABLE_FL)) {
 		if (!capable(CAP_LINUX_IMMUTABLE)) {
-			inode_unlock(inode);
 			ret = -EPERM;
-			goto out;
+			goto unlock_out;
 		}
 	}
 
@@ -1564,7 +1562,6 @@ static int f2fs_ioc_setflags(struct file *filp, unsigned long arg)
 	f2fs_mark_inode_dirty_sync(inode, false);
 unlock_out:
 	inode_unlock(inode);
-out:
 	mnt_drop_write_file(filp);
 	return ret;
 }
