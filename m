From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: fix reference leaks in f2fs_acl_create
Date: Mon, 09 Mar 2015 18:18:19 +0800
Message-ID: <000901d05a52$77f298b0$67d7ca10$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Our f2fs_acl_create is copied and modified from posix_acl_create to avoid
deadlock bug when inline_dentry feature is enabled.

Now, we got reference leaks in posix_acl_create, and this has been fixed in
commit fed0b588be2f ("posix_acl: fix reference leaks in posix_acl_create")
by Omar Sandoval.
https://lkml.org/lkml/2015/2/9/5

Let's fix this issue in f2fs_acl_create too.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/acl.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index 7422027..4320ffa 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -351,13 +351,11 @@ static int f2fs_acl_create(struct inode *dir, umode_t *mode,
 
 	*acl = f2fs_acl_clone(p, GFP_NOFS);
 	if (!*acl)
-		return -ENOMEM;
+		goto no_mem;
 
 	ret = f2fs_acl_create_masq(*acl, mode);
-	if (ret < 0) {
-		posix_acl_release(*acl);
-		return -ENOMEM;
-	}
+	if (ret < 0)
+		goto no_mem_clone;
 
 	if (ret == 0) {
 		posix_acl_release(*acl);
@@ -378,6 +376,12 @@ no_acl:
 	*default_acl = NULL;
 	*acl = NULL;
 	return 0;
+
+no_mem_clone:
+	posix_acl_release(*acl);
+no_mem:
+	posix_acl_release(p);
+	return -ENOMEM;
 }
 
 int f2fs_init_acl(struct inode *inode, struct inode *dir, struct page *ipage,
-- 
2.3.0
