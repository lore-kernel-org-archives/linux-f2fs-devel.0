From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/2] f2fs: kill duplicated code from posix_acl.c
Date: Wed, 22 Jul 2015 18:23:25 +0800
Message-ID: <00f301d0c468$88b74760$9a25d620$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZHrCB-0006n0-FI
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 Jul 2015 10:24:15 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZHrC9-0001hg-8K
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 Jul 2015 10:24:15 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NRV025U9WW4V7B0@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 Jul 2015 19:24:04 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

In commit bce8d1120707 ("f2fs: avoid deadlock on init_inode_metadata"),
we copied posix_acl codes from posix_acl.c, and reorganize them to avoid
deadlock described as below:
 - f2fs_mknod
  - __f2fs_add_link
   - f2fs_add_inline_entry
    - get_node_page           get parent's inode page
    - init_inode_metadata
     - f2fs_init_acl
      - posix_acl_create
       - get_acl
        - f2fs_get_acl
         - f2fs_getxattr
          - read_all_xattrs
           - get_node_page    get parent's inode page again

For now, we reorganized init_inode_metadata, and f2fs_init_acl will
no longer called after parent's inode page is grabbed.

So this patch reverts all changes in commit bce8d1120707
("f2fs: avoid deadlock on init_inode_metadata").

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/acl.c           | 140 ++----------------------------------------------
 fs/f2fs/acl.h           |   5 +-
 fs/f2fs/crypto_key.c    |   2 +-
 fs/f2fs/crypto_policy.c |   6 +--
 fs/f2fs/dir.c           |   8 +--
 fs/f2fs/xattr.c         |   6 +--
 fs/f2fs/xattr.h         |   6 +--
 7 files changed, 20 insertions(+), 153 deletions(-)

diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index c8f25f7..af83577 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -162,8 +162,7 @@ fail:
 	return ERR_PTR(-EINVAL);
 }
 
-static struct posix_acl *__f2fs_get_acl(struct inode *inode, int type,
-						struct page *dpage)
+struct posix_acl *f2fs_get_acl(struct inode *inode, int type)
 {
 	int name_index = F2FS_XATTR_INDEX_POSIX_ACL_DEFAULT;
 	void *value = NULL;
@@ -173,13 +172,12 @@ static struct posix_acl *__f2fs_get_acl(struct inode *inode, int type,
 	if (type == ACL_TYPE_ACCESS)
 		name_index = F2FS_XATTR_INDEX_POSIX_ACL_ACCESS;
 
-	retval = f2fs_getxattr(inode, name_index, "", NULL, 0, dpage);
+	retval = f2fs_getxattr(inode, name_index, "", NULL, 0);
 	if (retval > 0) {
 		value = kmalloc(retval, GFP_F2FS_ZERO);
 		if (!value)
 			return ERR_PTR(-ENOMEM);
-		retval = f2fs_getxattr(inode, name_index, "", value,
-							retval, dpage);
+		retval = f2fs_getxattr(inode, name_index, "", value, retval);
 	}
 
 	if (retval > 0)
@@ -196,11 +194,6 @@ static struct posix_acl *__f2fs_get_acl(struct inode *inode, int type,
 	return acl;
 }
 
-struct posix_acl *f2fs_get_acl(struct inode *inode, int type)
-{
-	return __f2fs_get_acl(inode, type, NULL);
-}
-
 static int __f2fs_set_acl(struct inode *inode, int type,
 			struct posix_acl *acl, struct page *ipage)
 {
@@ -256,135 +249,12 @@ int f2fs_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 	return __f2fs_set_acl(inode, type, acl, NULL);
 }
 
-/*
- * Most part of f2fs_acl_clone, f2fs_acl_create_masq, f2fs_acl_create
- * are copied from posix_acl.c
- */
-static struct posix_acl *f2fs_acl_clone(const struct posix_acl *acl,
-							gfp_t flags)
-{
-	struct posix_acl *clone = NULL;
-
-	if (acl) {
-		int size = sizeof(struct posix_acl) + acl->a_count *
-				sizeof(struct posix_acl_entry);
-		clone = kmemdup(acl, size, flags);
-		if (clone)
-			atomic_set(&clone->a_refcount, 1);
-	}
-	return clone;
-}
-
-static int f2fs_acl_create_masq(struct posix_acl *acl, umode_t *mode_p)
-{
-	struct posix_acl_entry *pa, *pe;
-	struct posix_acl_entry *group_obj = NULL, *mask_obj = NULL;
-	umode_t mode = *mode_p;
-	int not_equiv = 0;
-
-	/* assert(atomic_read(acl->a_refcount) == 1); */
-
-	FOREACH_ACL_ENTRY(pa, acl, pe) {
-		switch(pa->e_tag) {
-		case ACL_USER_OBJ:
-			pa->e_perm &= (mode >> 6) | ~S_IRWXO;
-			mode &= (pa->e_perm << 6) | ~S_IRWXU;
-			break;
-
-		case ACL_USER:
-		case ACL_GROUP:
-			not_equiv = 1;
-			break;
-
-		case ACL_GROUP_OBJ:
-			group_obj = pa;
-			break;
-
-		case ACL_OTHER:
-			pa->e_perm &= mode | ~S_IRWXO;
-			mode &= pa->e_perm | ~S_IRWXO;
-			break;
-
-		case ACL_MASK:
-			mask_obj = pa;
-			not_equiv = 1;
-			break;
-
-		default:
-			return -EIO;
-		}
-	}
-
-	if (mask_obj) {
-		mask_obj->e_perm &= (mode >> 3) | ~S_IRWXO;
-		mode &= (mask_obj->e_perm << 3) | ~S_IRWXG;
-	} else {
-		if (!group_obj)
-			return -EIO;
-		group_obj->e_perm &= (mode >> 3) | ~S_IRWXO;
-		mode &= (group_obj->e_perm << 3) | ~S_IRWXG;
-	}
-
-	*mode_p = (*mode_p & ~S_IRWXUGO) | mode;
-        return not_equiv;
-}
-
-static int f2fs_acl_create(struct inode *dir, umode_t *mode,
-		struct posix_acl **default_acl, struct posix_acl **acl,
-		struct page *dpage)
-{
-	struct posix_acl *p;
-	struct posix_acl *clone;
-	int ret;
-
-	*acl = NULL;
-	*default_acl = NULL;
-
-	if (S_ISLNK(*mode) || !IS_POSIXACL(dir))
-		return 0;
-
-	p = __f2fs_get_acl(dir, ACL_TYPE_DEFAULT, dpage);
-	if (!p || p == ERR_PTR(-EOPNOTSUPP)) {
-		*mode &= ~current_umask();
-		return 0;
-	}
-	if (IS_ERR(p))
-		return PTR_ERR(p);
-
-	clone = f2fs_acl_clone(p, GFP_NOFS);
-	if (!clone)
-		goto no_mem;
-
-	ret = f2fs_acl_create_masq(clone, mode);
-	if (ret < 0)
-		goto no_mem_clone;
-
-	if (ret == 0)
-		posix_acl_release(clone);
-	else
-		*acl = clone;
-
-	if (!S_ISDIR(*mode))
-		posix_acl_release(p);
-	else
-		*default_acl = p;
-
-	return 0;
-
-no_mem_clone:
-	posix_acl_release(clone);
-no_mem:
-	posix_acl_release(p);
-	return -ENOMEM;
-}
-
-int f2fs_init_acl(struct inode *inode, struct inode *dir, struct page *ipage,
-							struct page *dpage)
+int f2fs_init_acl(struct inode *inode, struct inode *dir, struct page *ipage)
 {
 	struct posix_acl *default_acl = NULL, *acl = NULL;
 	int error = 0;
 
-	error = f2fs_acl_create(dir, &inode->i_mode, &default_acl, &acl, dpage);
+	error = posix_acl_create(dir, &inode->i_mode, &default_acl, &acl);
 	if (error)
 		return error;
 
diff --git a/fs/f2fs/acl.h b/fs/f2fs/acl.h
index 997ca8e..0504394 100644
--- a/fs/f2fs/acl.h
+++ b/fs/f2fs/acl.h
@@ -38,15 +38,14 @@ struct f2fs_acl_header {
 
 extern struct posix_acl *f2fs_get_acl(struct inode *, int);
 extern int f2fs_set_acl(struct inode *inode, struct posix_acl *acl, int type);
-extern int f2fs_init_acl(struct inode *, struct inode *, struct page *,
-							struct page *);
+extern int f2fs_init_acl(struct inode *, struct inode *, struct page *);
 #else
 #define f2fs_check_acl	NULL
 #define f2fs_get_acl	NULL
 #define f2fs_set_acl	NULL
 
 static inline int f2fs_init_acl(struct inode *inode, struct inode *dir,
-				struct page *ipage, struct page *dpage)
+							struct page *ipage)
 {
 	return 0;
 }
diff --git a/fs/f2fs/crypto_key.c b/fs/f2fs/crypto_key.c
index 9f77de2..c994c9e 100644
--- a/fs/f2fs/crypto_key.c
+++ b/fs/f2fs/crypto_key.c
@@ -144,7 +144,7 @@ retry:
 
 	res = f2fs_getxattr(inode, F2FS_XATTR_INDEX_ENCRYPTION,
 				F2FS_XATTR_NAME_ENCRYPTION_CONTEXT,
-				&ctx, sizeof(ctx), NULL);
+				&ctx, sizeof(ctx));
 	if (res < 0)
 		return res;
 	else if (res != sizeof(ctx))
diff --git a/fs/f2fs/crypto_policy.c b/fs/f2fs/crypto_policy.c
index d4a96af..6d243fc 100644
--- a/fs/f2fs/crypto_policy.c
+++ b/fs/f2fs/crypto_policy.c
@@ -21,7 +21,7 @@
 static int f2fs_inode_has_encryption_context(struct inode *inode)
 {
 	int res = f2fs_getxattr(inode, F2FS_XATTR_INDEX_ENCRYPTION,
-			F2FS_XATTR_NAME_ENCRYPTION_CONTEXT, NULL, 0, NULL);
+			F2FS_XATTR_NAME_ENCRYPTION_CONTEXT, NULL, 0);
 	return (res > 0);
 }
 
@@ -35,7 +35,7 @@ static int f2fs_is_encryption_context_consistent_with_policy(
 	struct f2fs_encryption_context ctx;
 	int res = f2fs_getxattr(inode, F2FS_XATTR_INDEX_ENCRYPTION,
 				F2FS_XATTR_NAME_ENCRYPTION_CONTEXT, &ctx,
-				sizeof(ctx), NULL);
+				sizeof(ctx));
 
 	if (res != sizeof(ctx))
 		return 0;
@@ -120,7 +120,7 @@ int f2fs_get_policy(struct inode *inode, struct f2fs_encryption_policy *policy)
 
 	res = f2fs_getxattr(inode, F2FS_XATTR_INDEX_ENCRYPTION,
 				F2FS_XATTR_NAME_ENCRYPTION_CONTEXT,
-				&ctx, sizeof(ctx), NULL);
+				&ctx, sizeof(ctx));
 	if (res != sizeof(ctx))
 		return -ENODATA;
 	if (ctx.format != F2FS_ENCRYPTION_CONTEXT_FORMAT_V1)
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 0ad9a1c..f0c099e 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -382,7 +382,7 @@ static int make_empty_dir(struct inode *inode,
 }
 
 int init_inode_metadata(struct inode *inode, struct inode *dir,
-			const struct qstr *name, struct page *dpage)
+						const struct qstr *name)
 {
 	struct page *page;
 	int err;
@@ -400,7 +400,7 @@ int init_inode_metadata(struct inode *inode, struct inode *dir,
 			goto error;
 	}
 
-	err = f2fs_init_acl(inode, dir, page, dpage);
+	err = f2fs_init_acl(inode, dir, page);
 	if (err)
 		goto put_error;
 
@@ -554,7 +554,7 @@ int __f2fs_add_link(struct inode *dir, const struct qstr *name,
 
 	if (inode) {
 		down_write(&F2FS_I(inode)->i_sem);
-		err = init_inode_metadata(inode, dir, &new_name, NULL);
+		err = init_inode_metadata(inode, dir, &new_name);
 		up_write(&F2FS_I(inode)->i_sem);
 		if (err)
 			goto free_filename;
@@ -666,7 +666,7 @@ int f2fs_do_tmpfile(struct inode *inode, struct inode *dir)
 	int err;
 
 	down_write(&F2FS_I(inode)->i_sem);
-	err = init_inode_metadata(inode, dir, NULL, NULL);
+	err = init_inode_metadata(inode, dir, NULL);
 	up_write(&F2FS_I(inode)->i_sem);
 	if (err)
 		return err;
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 4de2286..944d2a0 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -83,7 +83,7 @@ static int f2fs_xattr_generic_get(struct dentry *dentry, const char *name,
 	}
 	if (strcmp(name, "") == 0)
 		return -EINVAL;
-	return f2fs_getxattr(d_inode(dentry), type, name, buffer, size, NULL);
+	return f2fs_getxattr(d_inode(dentry), type, name, buffer, size);
 }
 
 static int f2fs_xattr_generic_set(struct dentry *dentry, const char *name,
@@ -400,7 +400,7 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
 }
 
 int f2fs_getxattr(struct inode *inode, int index, const char *name,
-		void *buffer, size_t buffer_size, struct page *ipage)
+					void *buffer, size_t buffer_size)
 {
 	struct f2fs_xattr_entry *entry;
 	void *base_addr;
@@ -414,7 +414,7 @@ int f2fs_getxattr(struct inode *inode, int index, const char *name,
 	if (len > F2FS_NAME_LEN)
 		return -ERANGE;
 
-	base_addr = read_all_xattrs(inode, ipage);
+	base_addr = read_all_xattrs(inode, NULL);
 	if (!base_addr)
 		return -ENOMEM;
 
diff --git a/fs/f2fs/xattr.h b/fs/f2fs/xattr.h
index 71a7100..288b869 100644
--- a/fs/f2fs/xattr.h
+++ b/fs/f2fs/xattr.h
@@ -119,8 +119,7 @@ extern const struct xattr_handler *f2fs_xattr_handlers[];
 
 extern int f2fs_setxattr(struct inode *, int, const char *,
 				const void *, size_t, struct page *, int);
-extern int f2fs_getxattr(struct inode *, int, const char *, void *,
-						size_t, struct page *);
+extern int f2fs_getxattr(struct inode *, int, const char *, void *, size_t);
 extern ssize_t f2fs_listxattr(struct dentry *, char *, size_t);
 #else
 
@@ -131,8 +130,7 @@ static inline int f2fs_setxattr(struct inode *inode, int index,
 	return -EOPNOTSUPP;
 }
 static inline int f2fs_getxattr(struct inode *inode, int index,
-			const char *name, void *buffer,
-			size_t buffer_size, struct page *dpage)
+			const char *name, void *buffer, size_t buffer_size)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.4.2



------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
