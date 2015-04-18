From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/3] f2fs: make posix_acl_create() safer and cleaner
Date: Sat, 18 Apr 2015 18:03:58 +0800
Message-ID: <007b01d079bf$1473eb40$3d5bc1c0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Our f2fs_acl_create is copied from posix_acl_create in ./fs/posix_acl.c and
modified to avoid deadlock bug when inline_dentry feature is enabled.

Dan Carpenter rewrites posix_acl_create in commit 2799563b281f
("fs/posix_acl.c: make posix_acl_create() safer and cleaner") to make this
function more safer, so that we can avoid potential bug in its caller,
especially for ocfs2.

Let's back port the patch to f2fs.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/acl.c | 46 ++++++++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 26 deletions(-)

diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index 4320ffa..c8f25f7 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -334,51 +334,45 @@ static int f2fs_acl_create(struct inode *dir, umode_t *mode,
 		struct page *dpage)
 {
 	struct posix_acl *p;
+	struct posix_acl *clone;
 	int ret;
 
+	*acl = NULL;
+	*default_acl = NULL;
+
 	if (S_ISLNK(*mode) || !IS_POSIXACL(dir))
-		goto no_acl;
+		return 0;
 
 	p = __f2fs_get_acl(dir, ACL_TYPE_DEFAULT, dpage);
-	if (IS_ERR(p)) {
-		if (p == ERR_PTR(-EOPNOTSUPP))
-			goto apply_umask;
-		return PTR_ERR(p);
+	if (!p || p == ERR_PTR(-EOPNOTSUPP)) {
+		*mode &= ~current_umask();
+		return 0;
 	}
+	if (IS_ERR(p))
+		return PTR_ERR(p);
 
-	if (!p)
-		goto apply_umask;
-
-	*acl = f2fs_acl_clone(p, GFP_NOFS);
-	if (!*acl)
+	clone = f2fs_acl_clone(p, GFP_NOFS);
+	if (!clone)
 		goto no_mem;
 
-	ret = f2fs_acl_create_masq(*acl, mode);
+	ret = f2fs_acl_create_masq(clone, mode);
 	if (ret < 0)
 		goto no_mem_clone;
 
-	if (ret == 0) {
-		posix_acl_release(*acl);
-		*acl = NULL;
-	}
+	if (ret == 0)
+		posix_acl_release(clone);
+	else
+		*acl = clone;
 
-	if (!S_ISDIR(*mode)) {
+	if (!S_ISDIR(*mode))
 		posix_acl_release(p);
-		*default_acl = NULL;
-	} else {
+	else
 		*default_acl = p;
-	}
-	return 0;
 
-apply_umask:
-	*mode &= ~current_umask();
-no_acl:
-	*default_acl = NULL;
-	*acl = NULL;
 	return 0;
 
 no_mem_clone:
-	posix_acl_release(*acl);
+	posix_acl_release(clone);
 no_mem:
 	posix_acl_release(p);
 	return -ENOMEM;
-- 
2.3.3
