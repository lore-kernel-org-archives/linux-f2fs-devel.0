From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] f2fs: constify super_operations
Date: Thu, 31 Aug 2017 15:06:24 +0530
Message-ID: <668bb6351adb54694cee5e94f213f5f4c63f96bd.1504171894.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: yuchao0@huawei.com, jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

super_operations are not supposed to change at runtime.
"struct super_block" working with super_operations provided
by <linux/fs.h> work with const super_operations. So mark
the non-const structs as const

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 32e4c02..2bf0869 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1199,7 +1199,7 @@ static inline void f2fs_quota_off_umount(struct super_block *sb)
 }
 #endif
 
-static struct super_operations f2fs_sops = {
+static const struct super_operations f2fs_sops = {
 	.alloc_inode	= f2fs_alloc_inode,
 	.drop_inode	= f2fs_drop_inode,
 	.destroy_inode	= f2fs_destroy_inode,
-- 
1.9.1
