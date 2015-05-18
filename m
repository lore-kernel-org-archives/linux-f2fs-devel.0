From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/2] f2fs: support RENAME_WHITEOUT
Date: Mon, 18 May 2015 13:54:22 +0800
Message-ID: <002e01d0912f$30fc5cc0$92f51640$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

As the description of rename in manual, RENAME_WHITEOUT is a special operation
that only makes sense for overlay/union type filesystem.

When performing rename with RENAME_WHITEOUT, dst will be replace with src, and
meanwhile, a 'whiteout' will be create with name of src.

A "whiteout" is designed to be a char device with 0,0 device number, it has
specially meaning for stackable filesystem. In these filesystems, there are
multiple layers exist, and only top of these can be modified. So a whiteout
in top layer is used to hide a corresponding file in lower layer, as well
removal of whiteout will make the file appear.

Now in overlayfs, when we rename a file which is exist in lower layer, it
will be copied up to upper if it is not on upper layer yet, and then rename
it on upper layer, source file will be whiteouted to hide corresponding file
in lower layer at the same time.

So in upper layer filesystem, implementation of RENAME_WHITEOUT provide a
atomic operation for stackable filesystem to support rename operation.

There are multiple ways to implement RENAME_WHITEOUT in log of this commit:
7dcf5c3e4527 ("xfs: add RENAME_WHITEOUT support") which pointed out by
Dave Chinner.

For now, we just try to follow the way that xfs/ext4 use.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/namei.c | 140 ++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 90 insertions(+), 50 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 16b74da..bed0cb0 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -510,14 +510,80 @@ out:
 	return err;
 }
 
+static int __f2fs_tmpfile(struct inode *dir, struct dentry *dentry,
+					umode_t mode, struct inode **whiteout)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
+	struct inode *inode;
+	int err;
+
+	inode = f2fs_new_inode(dir, mode);
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
+
+	if (whiteout) {
+		init_special_inode(inode, inode->i_mode, WHITEOUT_DEV);
+		inode->i_op = &f2fs_special_inode_operations;
+	} else {
+		inode->i_op = &f2fs_file_inode_operations;
+		inode->i_fop = &f2fs_file_operations;
+		inode->i_mapping->a_ops = &f2fs_dblock_aops;
+	}
+
+	f2fs_lock_op(sbi);
+	err = acquire_orphan_inode(sbi);
+	if (err)
+		goto out;
+
+	err = f2fs_do_tmpfile(inode, dir);
+	if (err)
+		goto release_out;
+
+	/*
+	 * add this non-linked tmpfile to orphan list, in this way we could
+	 * remove all unused data of tmpfile after abnormal power-off.
+	 */
+	add_orphan_inode(sbi, inode->i_ino);
+	f2fs_unlock_op(sbi);
+
+	alloc_nid_done(sbi, inode->i_ino);
+
+	if (whiteout) {
+		inode_dec_link_count(inode);
+		*whiteout = inode;
+	} else {
+		d_tmpfile(dentry, inode);
+	}
+	unlock_new_inode(inode);
+	return 0;
+
+release_out:
+	release_orphan_inode(sbi);
+out:
+	handle_failed_inode(inode);
+	return err;
+}
+
+static int f2fs_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
+{
+	return __f2fs_tmpfile(dir, dentry, mode, NULL);
+}
+
+static int f2fs_create_whiteout(struct inode *dir, struct inode **whiteout)
+{
+	return __f2fs_tmpfile(dir, NULL, S_IFCHR | WHITEOUT_MODE, whiteout);
+}
+
 static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
-			struct inode *new_dir, struct dentry *new_dentry)
+			struct inode *new_dir, struct dentry *new_dentry,
+			unsigned int flags)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(old_dir);
 	struct inode *old_inode = d_inode(old_dentry);
 	struct inode *new_inode = d_inode(new_dentry);
+	struct inode *whiteout = NULL;
 	struct page *old_dir_page;
-	struct page *old_page, *new_page;
+	struct page *old_page, *new_page = NULL;
 	struct f2fs_dir_entry *old_dir_entry = NULL;
 	struct f2fs_dir_entry *old_entry;
 	struct f2fs_dir_entry *new_entry;
@@ -543,6 +609,12 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 			goto out_old;
 	}
 
+	if (flags & RENAME_WHITEOUT) {
+		err = f2fs_create_whiteout(old_dir, &whiteout);
+		if (err)
+			goto out_dir;
+	}
+
 	if (new_inode) {
 
 		err = -ENOTEMPTY;
@@ -611,8 +683,17 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	f2fs_delete_entry(old_entry, old_page, old_dir, NULL);
 
+	if (whiteout) {
+		whiteout->i_state |= I_LINKABLE;
+		set_inode_flag(F2FS_I(whiteout), FI_INC_LINK);
+		err = f2fs_add_link(old_dentry, whiteout);
+		if (err)
+			goto put_out_dir;
+		whiteout->i_state &= ~I_LINKABLE;
+	}
+
 	if (old_dir_entry) {
-		if (old_dir != new_dir) {
+		if (old_dir != new_dir && !whiteout) {
 			f2fs_set_link(old_inode, old_dir_entry,
 						old_dir_page, new_dir);
 			update_inode_page(old_inode);
@@ -633,8 +714,10 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 put_out_dir:
 	f2fs_unlock_op(sbi);
-	f2fs_dentry_kunmap(new_dir, new_page);
-	f2fs_put_page(new_page, 0);
+	if (new_page) {
+		f2fs_dentry_kunmap(new_dir, new_page);
+		f2fs_put_page(new_page, 0);
+	}
 out_dir:
 	if (old_dir_entry) {
 		f2fs_dentry_kunmap(old_inode, old_dir_page);
@@ -805,7 +888,7 @@ static int f2fs_rename2(struct inode *old_dir, struct dentry *old_dentry,
 			struct inode *new_dir, struct dentry *new_dentry,
 			unsigned int flags)
 {
-	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE))
+	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
 		return -EINVAL;
 
 	if (flags & RENAME_EXCHANGE) {
@@ -816,50 +899,7 @@ static int f2fs_rename2(struct inode *old_dir, struct dentry *old_dentry,
 	 * VFS has already handled the new dentry existence case,
 	 * here, we just deal with "RENAME_NOREPLACE" as regular rename.
 	 */
-	return f2fs_rename(old_dir, old_dentry, new_dir, new_dentry);
-}
-
-static int f2fs_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
-{
-	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
-	struct inode *inode;
-	int err;
-
-	inode = f2fs_new_inode(dir, mode);
-	if (IS_ERR(inode))
-		return PTR_ERR(inode);
-
-	inode->i_op = &f2fs_file_inode_operations;
-	inode->i_fop = &f2fs_file_operations;
-	inode->i_mapping->a_ops = &f2fs_dblock_aops;
-
-	f2fs_lock_op(sbi);
-	err = acquire_orphan_inode(sbi);
-	if (err)
-		goto out;
-
-	err = f2fs_do_tmpfile(inode, dir);
-	if (err)
-		goto release_out;
-
-	/*
-	 * add this non-linked tmpfile to orphan list, in this way we could
-	 * remove all unused data of tmpfile after abnormal power-off.
-	 */
-	add_orphan_inode(sbi, inode->i_ino);
-	f2fs_unlock_op(sbi);
-
-	alloc_nid_done(sbi, inode->i_ino);
-
-	d_tmpfile(dentry, inode);
-	unlock_new_inode(inode);
-	return 0;
-
-release_out:
-	release_orphan_inode(sbi);
-out:
-	handle_failed_inode(inode);
-	return err;
+	return f2fs_rename(old_dir, old_dentry, new_dir, new_dentry, flags);
 }
 
 #ifdef CONFIG_F2FS_FS_ENCRYPTION
-- 
2.3.3
