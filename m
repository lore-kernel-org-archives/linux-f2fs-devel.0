From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs crypto: check CONFIG_F2FS_FS_XATTR for encrypted symlink
Date: Thu, 31 Dec 2015 18:20:10 +0800
Message-ID: <012101d143b4$f4905910$ddb10b30$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Add missed CONFIG_F2FS_FS_XATTR for encrypted symlink inode in order
to avoid unneeded registry of ->{get,set,remove}xattr.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/namei.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index a629af5..0d61a68 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -1016,10 +1016,12 @@ const struct inode_operations f2fs_encrypted_symlink_inode_operations = {
 	.put_link       = kfree_put_link,
 	.getattr	= f2fs_getattr,
 	.setattr	= f2fs_setattr,
+#ifdef CONFIG_F2FS_FS_XATTR
 	.setxattr	= generic_setxattr,
 	.getxattr	= generic_getxattr,
 	.listxattr	= f2fs_listxattr,
 	.removexattr	= generic_removexattr,
+#endif
 };
 #endif
 
-- 
2.6.3
