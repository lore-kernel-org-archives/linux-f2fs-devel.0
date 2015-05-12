From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 16/18 v2] f2fs crypto: add symlink encryption
Date: Mon, 11 May 2015 20:48:26 -0700
Message-ID: <20150512034826.GA24106@jaegeuk-mac02>
References: <1431145253-2019-1-git-send-email-jaegeuk@kernel.org>
 <1431145253-2019-16-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1431145253-2019-16-git-send-email-jaegeuk@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Uday Savagaonkar <savagaon@google.com>, Theodore Ts'o <tytso@mit.edu>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Chage log from v1:
 o split inode_operations suggested by Al

This patch implements encryption support for symlink.

Signed-off-by: Uday Savagaonkar <savagaon@google.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h  |   1 +
 fs/f2fs/inode.c |   5 +-
 fs/f2fs/namei.c | 145 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 145 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 686517d..5809590 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1920,6 +1920,7 @@ extern const struct address_space_operations f2fs_node_aops;
 extern const struct address_space_operations f2fs_meta_aops;
 extern const struct inode_operations f2fs_dir_inode_operations;
 extern const struct inode_operations f2fs_symlink_inode_operations;
+extern const struct inode_operations f2fs_encrypted_symlink_inode_operations;
 extern const struct inode_operations f2fs_special_inode_operations;
 extern struct kmem_cache *inode_entry_slab;
 
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index e622ec9..13936f9 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -198,7 +198,10 @@ make_now:
 		inode->i_mapping->a_ops = &f2fs_dblock_aops;
 		mapping_set_gfp_mask(inode->i_mapping, GFP_F2FS_HIGH_ZERO);
 	} else if (S_ISLNK(inode->i_mode)) {
-		inode->i_op = &f2fs_symlink_inode_operations;
+		if (f2fs_encrypted_inode(inode))
+			inode->i_op = &f2fs_encrypted_symlink_inode_operations;
+		else
+			inode->i_op = &f2fs_symlink_inode_operations;
 		inode->i_mapping->a_ops = &f2fs_dblock_aops;
 	} else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
 			S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index c857f82..5287818 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -338,16 +338,26 @@ static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
 	struct inode *inode;
-	size_t symlen = strlen(symname) + 1;
+	size_t len = strlen(symname);
+	size_t p_len;
+	char *p_str;
+	struct f2fs_str disk_link = FSTR_INIT(NULL, 0);
+	struct f2fs_encrypted_symlink_data *sd = NULL;
 	int err;
 
+	if (len > dir->i_sb->s_blocksize)
+		return -ENAMETOOLONG;
+
 	f2fs_balance_fs(sbi);
 
 	inode = f2fs_new_inode(dir, S_IFLNK | S_IRWXUGO);
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
-	inode->i_op = &f2fs_symlink_inode_operations;
+	if (f2fs_encrypted_inode(inode))
+		inode->i_op = &f2fs_encrypted_symlink_inode_operations;
+	else
+		inode->i_op = &f2fs_symlink_inode_operations;
 	inode->i_mapping->a_ops = &f2fs_dblock_aops;
 
 	f2fs_lock_op(sbi);
@@ -355,10 +365,50 @@ static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
 	if (err)
 		goto out;
 	f2fs_unlock_op(sbi);
-
-	err = page_symlink(inode, symname, symlen);
 	alloc_nid_done(sbi, inode->i_ino);
 
+	if (f2fs_encrypted_inode(dir)) {
+		struct qstr istr = QSTR_INIT(symname, len);
+
+		err = f2fs_inherit_context(dir, inode, NULL);
+		if (err)
+			goto err_out;
+
+		err = f2fs_setup_fname_crypto(inode);
+		if (err)
+			goto err_out;
+
+		err = f2fs_fname_crypto_alloc_buffer(inode, len, &disk_link);
+		if (err)
+			goto err_out;
+
+		err = f2fs_fname_usr_to_disk(inode, &istr, &disk_link);
+		if (err < 0)
+			goto err_out;
+
+		p_len = encrypted_symlink_data_len(disk_link.len) + 1;
+
+		if (p_len > dir->i_sb->s_blocksize) {
+			err = -ENAMETOOLONG;
+			goto err_out;
+		}
+
+		sd = kzalloc(p_len, GFP_NOFS);
+		if (!sd) {
+			err = -ENOMEM;
+			goto err_out;
+		}
+		memcpy(sd->encrypted_path, disk_link.name, disk_link.len);
+		sd->len = cpu_to_le16(disk_link.len);
+		p_str = (char *)sd;
+	} else {
+		p_len = len + 1;
+		p_str = (char *)symname;
+	}
+
+	err = page_symlink(inode, p_str, p_len);
+
+err_out:
 	d_instantiate(dentry, inode);
 	unlock_new_inode(inode);
 
@@ -371,10 +421,14 @@ static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
 	 * If the symlink path is stored into inline_data, there is no
 	 * performance regression.
 	 */
-	filemap_write_and_wait_range(inode->i_mapping, 0, symlen - 1);
+	if (!err)
+		filemap_write_and_wait_range(inode->i_mapping, 0, p_len - 1);
 
 	if (IS_DIRSYNC(dir))
 		f2fs_sync_fs(sbi->sb, 1);
+
+	kfree(sd);
+	f2fs_fname_crypto_free_buffer(&disk_link);
 	return err;
 out:
 	handle_failed_inode(inode);
@@ -818,6 +872,87 @@ out:
 	return err;
 }
 
+#ifdef CONFIG_F2FS_FS_ENCRYPTION
+static void *f2fs_encrypted_follow_link(struct dentry *dentry,
+						struct nameidata *nd)
+{
+	struct page *cpage = NULL;
+	char *caddr, *paddr = NULL;
+	struct f2fs_str cstr;
+	struct f2fs_str pstr = FSTR_INIT(NULL, 0);
+	struct inode *inode = d_inode(dentry);
+	struct f2fs_encrypted_symlink_data *sd;
+	loff_t size = min_t(loff_t, i_size_read(inode), PAGE_SIZE - 1);
+	u32 max_size = inode->i_sb->s_blocksize;
+	int res;
+
+	res = f2fs_setup_fname_crypto(inode);
+	if (res)
+		return ERR_PTR(res);
+
+	cpage = read_mapping_page(inode->i_mapping, 0, NULL);
+	if (IS_ERR(cpage))
+		return cpage;
+	caddr = kmap(cpage);
+	caddr[size] = 0;
+
+	/* Symlink is encrypted */
+	sd = (struct f2fs_encrypted_symlink_data *)caddr;
+	cstr.name = sd->encrypted_path;
+	cstr.len = le16_to_cpu(sd->len);
+
+	/* this is broken symlink case */
+	if (cstr.name[0] == 0 && cstr.len == 0) {
+		res = -ENOENT;
+		goto errout;
+	}
+
+	if ((cstr.len + sizeof(struct f2fs_encrypted_symlink_data) - 1) >
+								max_size) {
+		/* Symlink data on the disk is corrupted */
+		res = -EIO;
+		goto errout;
+	}
+	res = f2fs_fname_crypto_alloc_buffer(inode, cstr.len, &pstr);
+	if (res)
+		goto errout;
+
+	res = f2fs_fname_disk_to_usr(inode, NULL, &cstr, &pstr);
+	if (res < 0)
+		goto errout;
+
+	paddr = pstr.name;
+
+	/* Null-terminate the name */
+	if (res <= cstr.len)
+		paddr[res] = '\0';
+	nd_set_link(nd, paddr);
+
+	kunmap(cpage);
+	page_cache_release(cpage);
+	return NULL;
+errout:
+	f2fs_fname_crypto_free_buffer(&pstr);
+	kunmap(cpage);
+	page_cache_release(cpage);
+	return ERR_PTR(res);
+}
+
+const struct inode_operations f2fs_encrypted_symlink_inode_operations = {
+	.readlink       = generic_readlink,
+	.follow_link    = f2fs_encrypted_follow_link,
+	.put_link       = kfree_put_link,
+	.getattr	= f2fs_getattr,
+	.setattr	= f2fs_setattr,
+#ifdef CONFIG_F2FS_FS_XATTR
+	.setxattr	= generic_setxattr,
+	.getxattr	= generic_getxattr,
+	.listxattr	= f2fs_listxattr,
+	.removexattr	= generic_removexattr,
+#endif
+};
+#endif
+
 const struct inode_operations f2fs_dir_inode_operations = {
 	.create		= f2fs_create,
 	.lookup		= f2fs_lookup,
-- 
2.1.1

