From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 2/2] f2fs: fix a deadlock during init_acl procedure
Date: Mon, 28 Oct 2013 14:08:09 +0900
Message-ID: <1382936889-4911-1-git-send-email-jaegeuk.kim@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk.kim@samsung.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

The deadlock is found through the following scenario.

sys_mkdir()
 -> f2fs_add_link()
  -> __f2fs_add_link()
   -> init_inode_metadata()
     : lock_page(inode);
    -> f2fs_init_acl()
     -> f2fs_set_acl()
      -> f2fs_setxattr(..., NULL)
       : This NULL page incurs a deadlock at update_inode_page().

So, likewise f2fs_init_security(), this patch adds a parameter to transfer the
locked inode page to f2fs_setxattr().

Found by Linux File System Verification project (linuxtesting.org).

Reported-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/acl.c | 15 ++++++++-------
 fs/f2fs/acl.h |  5 +++--
 fs/f2fs/dir.c |  2 +-
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index f1a6975..d0fc287 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -205,7 +205,8 @@ struct posix_acl *f2fs_get_acl(struct inode *inode, int type)
 	return acl;
 }
 
-static int f2fs_set_acl(struct inode *inode, int type, struct posix_acl *acl)
+static int f2fs_set_acl(struct inode *inode, int type,
+			struct posix_acl *acl, struct page *ipage)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
@@ -250,7 +251,7 @@ static int f2fs_set_acl(struct inode *inode, int type, struct posix_acl *acl)
 		}
 	}
 
-	error = f2fs_setxattr(inode, name_index, "", value, size, NULL);
+	error = f2fs_setxattr(inode, name_index, "", value, size, ipage);
 
 	kfree(value);
 	if (!error)
@@ -260,7 +261,7 @@ static int f2fs_set_acl(struct inode *inode, int type, struct posix_acl *acl)
 	return error;
 }
 
-int f2fs_init_acl(struct inode *inode, struct inode *dir)
+int f2fs_init_acl(struct inode *inode, struct inode *dir, struct page *ipage)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(dir->i_sb);
 	struct posix_acl *acl = NULL;
@@ -280,7 +281,7 @@ int f2fs_init_acl(struct inode *inode, struct inode *dir)
 		goto cleanup;
 
 	if (S_ISDIR(inode->i_mode)) {
-		error = f2fs_set_acl(inode, ACL_TYPE_DEFAULT, acl);
+		error = f2fs_set_acl(inode, ACL_TYPE_DEFAULT, acl, ipage);
 		if (error)
 			goto cleanup;
 	}
@@ -288,7 +289,7 @@ int f2fs_init_acl(struct inode *inode, struct inode *dir)
 	if (error < 0)
 		return error;
 	if (error > 0)
-		error = f2fs_set_acl(inode, ACL_TYPE_ACCESS, acl);
+		error = f2fs_set_acl(inode, ACL_TYPE_ACCESS, acl, ipage);
 cleanup:
 	posix_acl_release(acl);
 	return error;
@@ -314,7 +315,7 @@ int f2fs_acl_chmod(struct inode *inode)
 	if (error)
 		return error;
 
-	error = f2fs_set_acl(inode, ACL_TYPE_ACCESS, acl);
+	error = f2fs_set_acl(inode, ACL_TYPE_ACCESS, acl, NULL);
 	posix_acl_release(acl);
 	return error;
 }
@@ -389,7 +390,7 @@ static int f2fs_xattr_set_acl(struct dentry *dentry, const char *name,
 		acl = NULL;
 	}
 
-	error = f2fs_set_acl(inode, type, acl);
+	error = f2fs_set_acl(inode, type, acl, NULL);
 
 release_and_out:
 	posix_acl_release(acl);
diff --git a/fs/f2fs/acl.h b/fs/f2fs/acl.h
index 3839048..4963313 100644
--- a/fs/f2fs/acl.h
+++ b/fs/f2fs/acl.h
@@ -38,7 +38,7 @@ struct f2fs_acl_header {
 
 extern struct posix_acl *f2fs_get_acl(struct inode *, int);
 extern int f2fs_acl_chmod(struct inode *);
-extern int f2fs_init_acl(struct inode *, struct inode *);
+extern int f2fs_init_acl(struct inode *, struct inode *, struct page *);
 #else
 #define f2fs_check_acl	NULL
 #define f2fs_get_acl	NULL
@@ -49,7 +49,8 @@ static inline int f2fs_acl_chmod(struct inode *inode)
 	return 0;
 }
 
-static inline int f2fs_init_acl(struct inode *inode, struct inode *dir)
+static inline int f2fs_init_acl(struct inode *inode, struct inode *dir,
+							struct page *page)
 {
 	return 0;
 }
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 384c6da..c9d53fc 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -346,7 +346,7 @@ static struct page *init_inode_metadata(struct inode *inode,
 				goto error;
 		}
 
-		err = f2fs_init_acl(inode, dir);
+		err = f2fs_init_acl(inode, dir, page);
 		if (err)
 			goto error;
 
-- 
1.8.4.474.g128a96c

