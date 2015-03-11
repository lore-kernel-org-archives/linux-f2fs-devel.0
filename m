From: Wanpeng Li <wanpeng.li@linux.intel.com>
Subject: [PATCH RFC] f2fs: add fast symlink
Date: Wed, 11 Mar 2015 19:52:21 +0800
Message-ID: <1426074741-31296-1-git-send-email-wanpeng.li@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Changman Lee <cm224.lee@samsung.com>, Chao Yu <chao2.yu@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Wanpeng Li <wanpeng.li@linux.intel.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch add fast symlink for f2fs, I'm not sure if inline 
interference with fast symlink, f2fs_follow_link can't be called 
in my patch, so my patch still can't work correctly, please help 
review and give comments to help me out.

Signed-off-by: Wanpeng Li <wanpeng.li@linux.intel.com>
---
 fs/f2fs/f2fs.h  |  9 +++++++++
 fs/f2fs/file.c  |  2 ++
 fs/f2fs/inode.c | 15 +++++++++++++--
 fs/f2fs/namei.c | 44 +++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 65 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 511d6cd..5938318 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1370,6 +1370,14 @@ static inline void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi)
 	sbi->sb->s_flags |= MS_RDONLY;
 }
 
+/*
+ * Test whether an inode is a fast symlink.
+ */
+static inline int f2fs_inode_is_fast_symlink(struct inode *inode)
+{
+	return (S_ISLNK(inode->i_mode) && inode->i_blocks == 0);
+}
+
 #define get_inode_mode(i) \
 	((is_inode_flag_set(F2FS_I(i), FI_ACL_MODE)) ? \
 	 (F2FS_I(i)->i_acl_mode) : ((i)->i_mode))
@@ -1746,6 +1754,7 @@ extern const struct address_space_operations f2fs_node_aops;
 extern const struct address_space_operations f2fs_meta_aops;
 extern const struct inode_operations f2fs_dir_inode_operations;
 extern const struct inode_operations f2fs_symlink_inode_operations;
+extern const struct inode_operations f2fs_fast_symlink_inode_operations;
 extern const struct inode_operations f2fs_special_inode_operations;
 extern struct kmem_cache *inode_entry_slab;
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f1341c7..05a3d4f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -546,6 +546,8 @@ void f2fs_truncate(struct inode *inode)
 	if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
 				S_ISLNK(inode->i_mode)))
 		return;
+	if (f2fs_inode_is_fast_symlink(inode))
+		return;
 
 	trace_f2fs_truncate(inode);
 
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index b508744..627fe6b 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -13,6 +13,7 @@
 #include <linux/buffer_head.h>
 #include <linux/writeback.h>
 #include <linux/bitops.h>
+#include <linux/namei.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -188,8 +189,18 @@ make_now:
 		inode->i_mapping->a_ops = &f2fs_dblock_aops;
 		mapping_set_gfp_mask(inode->i_mapping, GFP_F2FS_HIGH_ZERO);
 	} else if (S_ISLNK(inode->i_mode)) {
-		inode->i_op = &f2fs_symlink_inode_operations;
-		inode->i_mapping->a_ops = &f2fs_dblock_aops;
+		if (f2fs_inode_is_fast_symlink(inode)) {
+			struct page *node_page;
+
+			node_page = get_node_page(sbi, inode->i_ino);
+			inode->i_op = &f2fs_fast_symlink_inode_operations;
+			nd_terminate_link(F2FS_INODE(node_page)->i_addr,
+				inode->i_size,
+				sizeof(F2FS_INODE(node_page)->i_addr) - 1);
+		} else {
+			inode->i_op = &f2fs_symlink_inode_operations;
+			inode->i_mapping->a_ops = &f2fs_dblock_aops;
+		}
 	} else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
 			S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
 		inode->i_op = &f2fs_special_inode_operations;
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 1e2ae21..ffc0d52 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -14,6 +14,7 @@
 #include <linux/sched.h>
 #include <linux/ctype.h>
 #include <linux/dcache.h>
+#include <linux/namei.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -247,6 +248,16 @@ fail:
 	return err;
 }
 
+static void *f2fs_follow_link(struct dentry *dentry, struct nameidata *nd)
+{
+	struct page *node_page;
+
+	node_page = get_node_page(F2FS_I_SB(dentry->d_inode),
+				dentry->d_inode->i_ino);
+	nd_set_link(nd, (char *)(F2FS_INODE(node_page)->i_addr));
+	return NULL;
+}
+
 static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
 					const char *symname)
 {
@@ -254,6 +265,7 @@ static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
 	struct inode *inode;
 	size_t symlen = strlen(symname) + 1;
 	int err;
+	struct page *node_page;
 
 	f2fs_balance_fs(sbi);
 
@@ -261,16 +273,28 @@ static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
-	inode->i_op = &f2fs_symlink_inode_operations;
-	inode->i_mapping->a_ops = &f2fs_dblock_aops;
 
+	clear_inode_flag(F2FS_I(inode), FI_INLINE_DATA);
+	clear_inode_flag(F2FS_I(inode), FI_INLINE_DENTRY);
 	f2fs_lock_op(sbi);
 	err = f2fs_add_link(dentry, inode);
 	if (err)
 		goto out;
 	f2fs_unlock_op(sbi);
 
-	err = page_symlink(inode, symname, symlen);
+	node_page = get_node_page(sbi, inode->i_ino);
+
+	if (symlen > sizeof(F2FS_INODE(node_page)->i_addr)) {
+		/* slow symlink */
+		inode->i_op = &f2fs_symlink_inode_operations;
+		inode->i_mapping->a_ops = &f2fs_dblock_aops;
+		err = page_symlink(inode, symname, symlen);
+	} else {
+		/* fast symlink */
+		inode->i_op = &f2fs_fast_symlink_inode_operations;
+		memcpy((char *)&F2FS_INODE(node_page)->i_addr, symname, symlen);
+		inode->i_size = symlen-1;
+	}
 	alloc_nid_done(sbi, inode->i_ino);
 
 	d_instantiate(dentry, inode);
@@ -743,6 +767,20 @@ const struct inode_operations f2fs_symlink_inode_operations = {
 #endif
 };
 
+const struct inode_operations f2fs_fast_symlink_inode_operations = {
+	.readlink       = generic_readlink,
+	.follow_link    = f2fs_follow_link,
+	.put_link       = page_put_link,
+	.getattr	= f2fs_getattr,
+	.setattr	= f2fs_setattr,
+#ifdef CONFIG_F2FS_FS_XATTR
+	.setxattr	= generic_setxattr,
+	.getxattr	= generic_getxattr,
+	.listxattr	= f2fs_listxattr,
+	.removexattr	= generic_removexattr,
+#endif
+};
+
 const struct inode_operations f2fs_special_inode_operations = {
 	.getattr	= f2fs_getattr,
 	.setattr        = f2fs_setattr,
-- 
2.1.0
