From: Namjae Jeon <linkinjeon@gmail.com>
Subject: [PATCH 1/4] f2fs: reorganize the f2fs_setattr() function.
Date: Sat,  8 Jun 2013 21:25:03 +0900
Message-ID: <1370694303-2738-1-git-send-email-linkinjeon@gmail.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: jaegeuk.kim@samsung.com
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Namjae Jeon <linkinjeon@gmail.com>, Namjae Jeon <namjae.jeon@samsung.com>, Pankaj Kumar <pankaj.km@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Namjae Jeon <namjae.jeon@samsung.com>

Remove the redundant code from this function and make it aligned with
usages of latest generic vfs layer function e.g using the setattr_copy()
instead of using the f2fs specific function.

Also correct the condition for updating the size of file via
truncate_setsize().

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Pankaj Kumar <pankaj.km@samsung.com>
---
 fs/f2fs/acl.c  |    5 +----
 fs/f2fs/file.c |   47 +++++------------------------------------------
 2 files changed, 6 insertions(+), 46 deletions(-)

diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index 44abc2f..2d13f44 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -17,9 +17,6 @@
 #include "xattr.h"
 #include "acl.h"
 
-#define get_inode_mode(i)	((is_inode_flag_set(F2FS_I(i), FI_ACL_MODE)) ? \
-					(F2FS_I(i)->i_acl_mode) : ((i)->i_mode))
-
 static inline size_t f2fs_acl_size(int count)
 {
 	if (count <= 4) {
@@ -299,7 +296,7 @@ int f2fs_acl_chmod(struct inode *inode)
 	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
 	struct posix_acl *acl;
 	int error;
-	umode_t mode = get_inode_mode(inode);
+	umode_t mode = inode->i_mode;
 
 	if (!test_opt(sbi, POSIX_ACL))
 		return 0;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index deefd25..8dfc1da 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -300,63 +300,26 @@ static int f2fs_getattr(struct vfsmount *mnt,
 	return 0;
 }
 
-#ifdef CONFIG_F2FS_FS_POSIX_ACL
-static void __setattr_copy(struct inode *inode, const struct iattr *attr)
-{
-	struct f2fs_inode_info *fi = F2FS_I(inode);
-	unsigned int ia_valid = attr->ia_valid;
-
-	if (ia_valid & ATTR_UID)
-		inode->i_uid = attr->ia_uid;
-	if (ia_valid & ATTR_GID)
-		inode->i_gid = attr->ia_gid;
-	if (ia_valid & ATTR_ATIME)
-		inode->i_atime = timespec_trunc(attr->ia_atime,
-						inode->i_sb->s_time_gran);
-	if (ia_valid & ATTR_MTIME)
-		inode->i_mtime = timespec_trunc(attr->ia_mtime,
-						inode->i_sb->s_time_gran);
-	if (ia_valid & ATTR_CTIME)
-		inode->i_ctime = timespec_trunc(attr->ia_ctime,
-						inode->i_sb->s_time_gran);
-	if (ia_valid & ATTR_MODE) {
-		umode_t mode = attr->ia_mode;
-
-		if (!in_group_p(inode->i_gid) && !capable(CAP_FSETID))
-			mode &= ~S_ISGID;
-		set_acl_inode(fi, mode);
-	}
-}
-#else
-#define __setattr_copy setattr_copy
-#endif
-
 int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = dentry->d_inode;
-	struct f2fs_inode_info *fi = F2FS_I(inode);
 	int err;
 
 	err = inode_change_ok(inode, attr);
 	if (err)
 		return err;
 
-	if ((attr->ia_valid & ATTR_SIZE) &&
-			attr->ia_size != i_size_read(inode)) {
-		truncate_setsize(inode, attr->ia_size);
+	if ((attr->ia_valid & ATTR_SIZE)) {
+		if (attr->ia_size != i_size_read(inode))
+			truncate_setsize(inode, attr->ia_size);
 		f2fs_truncate(inode);
 		f2fs_balance_fs(F2FS_SB(inode->i_sb));
 	}
 
-	__setattr_copy(inode, attr);
+	setattr_copy(inode, attr);
 
-	if (attr->ia_valid & ATTR_MODE) {
+	if (attr->ia_valid & ATTR_MODE)
 		err = f2fs_acl_chmod(inode);
-		if (err || is_inode_flag_set(fi, FI_ACL_MODE)) {
-			inode->i_mode = fi->i_acl_mode;
-			clear_inode_flag(fi, FI_ACL_MODE);
-		}
-	}
 
 	mark_inode_dirty(inode);
 	return err;
-- 
1.7.9.5

