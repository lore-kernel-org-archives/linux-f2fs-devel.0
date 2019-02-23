From: Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to dirty inode for i_mode recovery
Date: Sat, 23 Feb 2019 09:48:27 +0800
Message-ID: <20190223014827.7028-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

As Seulbae Kim reported in bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=202637

We didn't recover permission field correctly after sudden power-cut,
the reason is in setattr we didn't add inode into global dirty list
once i_mode is changed, so latter checkpoint triggered by fsync will
not flush last i_mode into disk, result in this problem, fix it.

Reported-by: Seulbae Kim <seulbae@gatech.edu>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b8f5d1208619..3a8c8eb0f549 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -766,7 +766,6 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
 	int err;
-	bool size_changed = false;
 
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
 		return -EIO;
@@ -841,8 +840,6 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 		down_write(&F2FS_I(inode)->i_sem);
 		F2FS_I(inode)->last_disk_size = i_size_read(inode);
 		up_write(&F2FS_I(inode)->i_sem);
-
-		size_changed = true;
 	}
 
 	__setattr_copy(inode, attr);
@@ -856,7 +853,7 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 	}
 
 	/* file size may changed here */
-	f2fs_mark_inode_dirty_sync(inode, size_changed);
+	f2fs_mark_inode_dirty_sync(inode, true);
 
 	/* inode change will produce dirty node pages flushed by checkpoint */
 	f2fs_balance_fs(F2FS_I_SB(inode), true);
-- 
2.18.0
