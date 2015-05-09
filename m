From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 10/18] f2fs crypto: activate encryption support
	for fs APIs
Date: Fri,  8 May 2015 21:20:45 -0700
Message-ID: <1431145253-2019-10-git-send-email-jaegeuk@kernel.org>
References: <1431145253-2019-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YqwGZ-0007hU-G0
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 May 2015 04:21:31 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YqwGY-0004er-B8 for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 May 2015 04:21:31 +0000
In-Reply-To: <1431145253-2019-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Michael Halcrow <mhalcrow@google.com>, Theodore Ts'o <tytso@mit.edu>

This patch activates the following APIs for encryption support.

The rules quoted by ext4 are:
 - An unencrypted directory may contain encrypted or unencrypted files
   or directories.
 - All files or directories in a directory must be protected using the
   same key as their containing directory.
 - Encrypted inode for regular file should not have inline_data.
 - Encrypted symlink and directory may have inline_data and inline_dentry.

This patch activates the following APIs.
1. f2fs_link              : validate context
2. f2fs_lookup            :      ''
3. f2fs_rename            :      ''
4. f2fs_create/f2fs_mkdir : inherit its dir's context
5. f2fs_direct_IO         : do buffered io for regular files
6. f2fs_open              : check encryption info
7. f2fs_file_mmap         :      ''
8. f2fs_setattr           :      ''
9. f2fs_file_write_iter   :      ''           (Called by sys_io_submit)

Signed-off-by: Michael Halcrow <mhalcrow@google.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c   |  3 +++
 fs/f2fs/dir.c    |  6 ++++++
 fs/f2fs/f2fs.h   | 11 +++++++++++
 fs/f2fs/file.c   | 34 ++++++++++++++++++++++++++++++++--
 fs/f2fs/inline.c |  3 +++
 fs/f2fs/namei.c  | 38 ++++++++++++++++++++++++++++++++------
 6 files changed, 87 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 842fcdd..473b4d4 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1982,6 +1982,9 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 			return err;
 	}
 
+	if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
+		return 0;
+
 	if (check_direct_IO(inode, iter, offset))
 		return 0;
 
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 9d558d2..f7293a2 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -390,6 +390,12 @@ struct page *init_inode_metadata(struct inode *inode, struct inode *dir,
 		err = f2fs_init_security(inode, dir, name, page);
 		if (err)
 			goto put_error;
+
+		if (f2fs_encrypted_inode(dir) && f2fs_may_encrypt(inode)) {
+			err = f2fs_inherit_context(dir, inode, page);
+			if (err)
+				goto put_error;
+		}
 	} else {
 		page = get_node_page(F2FS_I_SB(dir), inode->i_ino);
 		if (IS_ERR(page))
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e99205b..544766e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1975,6 +1975,17 @@ static inline int f2fs_sb_has_crypto(struct super_block *sb)
 #endif
 }
 
+static inline bool f2fs_may_encrypt(struct inode *inode)
+{
+#ifdef CONFIG_F2FS_FS_ENCRYPTION
+	mode_t mode = inode->i_mode;
+
+	return (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode));
+#else
+	return 0;
+#endif
+}
+
 /* crypto_policy.c */
 int f2fs_is_child_context_consistent_with_parent(struct inode *,
 							struct inode *);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 7236be4..9f4b34c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -408,6 +408,12 @@ static int f2fs_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct inode *inode = file_inode(file);
 
+	if (f2fs_encrypted_inode(inode)) {
+		int err = f2fs_get_encryption_info(inode);
+		if (err)
+			return 0;
+	}
+
 	/* we don't need to use inline_data strictly */
 	if (f2fs_has_inline_data(inode)) {
 		int err = f2fs_convert_inline_inode(inode);
@@ -420,6 +426,14 @@ static int f2fs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	return 0;
 }
 
+static int f2fs_file_open(struct inode *inode, struct file *filp)
+{
+	if (f2fs_encrypted_inode(inode) && f2fs_get_encryption_info(inode))
+		return -EACCES;
+
+	return generic_file_open(inode, filp);
+}
+
 int truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 {
 	int nr_free = 0, ofs = dn->ofs_in_node;
@@ -627,6 +641,10 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 		return err;
 
 	if (attr->ia_valid & ATTR_SIZE) {
+		if (f2fs_encrypted_inode(inode) &&
+				f2fs_get_encryption_info(inode))
+			return -EACCES;
+
 		if (attr->ia_size != i_size_read(inode)) {
 			truncate_setsize(inode, attr->ia_size);
 			f2fs_truncate(inode);
@@ -1466,6 +1484,18 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	}
 }
 
+static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	if (f2fs_encrypted_inode(inode) &&
+				!f2fs_has_encryption_key(inode) &&
+				f2fs_get_encryption_info(inode))
+		return -EACCES;
+
+	return generic_file_write_iter(iocb, from);
+}
+
 #ifdef CONFIG_COMPAT
 long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
@@ -1486,8 +1516,8 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 const struct file_operations f2fs_file_operations = {
 	.llseek		= f2fs_llseek,
 	.read_iter	= generic_file_read_iter,
-	.write_iter	= generic_file_write_iter,
-	.open		= generic_file_open,
+	.write_iter	= f2fs_file_write_iter,
+	.open		= f2fs_file_open,
 	.release	= f2fs_release_file,
 	.mmap		= f2fs_file_mmap,
 	.fsync		= f2fs_sync_file,
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index d9b3033..5f5b34b 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -27,6 +27,9 @@ bool f2fs_may_inline_data(struct inode *inode)
 	if (i_size_read(inode) > MAX_INLINE_DATA)
 		return false;
 
+	if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
+		return false;
+
 	return true;
 }
 
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 90a9640..bc8992e 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -56,6 +56,10 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 		goto out;
 	}
 
+	/* If the directory encrypted, then we should encrypt the inode. */
+	if (f2fs_encrypted_inode(dir) && f2fs_may_encrypt(inode))
+		f2fs_set_encrypted_inode(inode);
+
 	if (f2fs_may_inline_data(inode))
 		set_inode_flag(F2FS_I(inode), FI_INLINE_DATA);
 	if (f2fs_may_inline_dentry(inode))
@@ -157,6 +161,10 @@ static int f2fs_link(struct dentry *old_dentry, struct inode *dir,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
 	int err;
 
+	if (f2fs_encrypted_inode(dir) &&
+		!f2fs_is_child_context_consistent_with_parent(dir, inode))
+		return -EPERM;
+
 	f2fs_balance_fs(sbi);
 
 	inode->i_ctime = CURRENT_TIME;
@@ -235,6 +243,7 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 	struct f2fs_dir_entry *de;
 	struct page *page;
 	nid_t ino;
+	int err = 0;
 
 	if (dentry->d_name.len > F2FS_NAME_LEN)
 		return ERR_PTR(-ENAMETOOLONG);
@@ -251,16 +260,26 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 
-	if (f2fs_has_inline_dots(inode)) {
-		int err;
+	if (f2fs_encrypted_inode(dir) && f2fs_may_encrypt(inode) &&
+		!f2fs_is_child_context_consistent_with_parent(dir, inode)) {
+		iput(inode);
+		f2fs_msg(inode->i_sb, KERN_WARNING,
+				"Inconsistent encryption contexts: %lu/%lu\n",
+				(unsigned long)dir->i_ino,
+				(unsigned long)inode->i_ino);
+		return ERR_PTR(-EPERM);
+	}
 
+	if (f2fs_has_inline_dots(inode)) {
 		err = __recover_dot_dentries(inode, dir->i_ino);
-		if (err) {
-			iget_failed(inode);
-			return ERR_PTR(err);
-		}
+		if (err)
+			goto err_out;
 	}
 	return d_splice_alias(inode, dentry);
+
+err_out:
+	iget_failed(inode);
+	return ERR_PTR(err);
 }
 
 static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
@@ -460,6 +479,13 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	struct f2fs_dir_entry *new_entry;
 	int err = -ENOENT;
 
+	if ((old_dir != new_dir) && f2fs_encrypted_inode(new_dir) &&
+		!f2fs_is_child_context_consistent_with_parent(new_dir,
+							old_inode)) {
+		err = -EPERM;
+		goto out;
+	}
+
 	f2fs_balance_fs(sbi);
 
 	old_entry = f2fs_find_entry(old_dir, &old_dentry->d_name, &old_page);
-- 
2.1.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
