From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to show missing bits in FS_IOC_GETFLAGS
Date: Sun, 8 Apr 2018 11:27:14 +0800
Message-ID: <20180408032714.23458-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch fixes to show missing encrypt/inline_data flag in
FS_IOC_GETFLAGS like ext4 does.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3fd485395f9d..79cfaad21705 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1584,8 +1584,15 @@ static int f2fs_ioc_getflags(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
-	unsigned int flags = fi->i_flags &
-			(F2FS_FL_USER_VISIBLE | F2FS_PROJINHERIT_FL);
+	unsigned int flags = fi->i_flags;
+
+	if (file_is_encrypt(inode))
+		flags |= F2FS_ENCRYPT_FL;
+	if (f2fs_has_inline_data(inode) || f2fs_has_inline_dentry(inode))
+		flags |= F2FS_INLINE_DATA_FL;
+
+	flags &= F2FS_FL_USER_VISIBLE;
+
 	return put_user(flags, (int __user *)arg);
 }
 
-- 
2.15.0.55.gc2ece9dc4de6
