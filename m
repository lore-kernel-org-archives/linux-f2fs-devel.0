From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 16/18] f2fs crypto: add symlink encryption
Date: Fri,  8 May 2015 21:20:51 -0700
Message-ID: <1431145253-2019-16-git-send-email-jaegeuk@kernel.org>
References: <1431145253-2019-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YqwGw-0002ZX-78
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 May 2015 04:21:54 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YqwGv-0007jK-5G for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 May 2015 04:21:54 +0000
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Theodore Ts'o <tytso@mit.edu>, Uday Savagaonkar <savagaon@google.com>

This patch implements encryption support for symlink.

The codes refered the ext4 symlink path.

Signed-off-by: Uday Savagaonkar <savagaon@google.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs_crypto.h |   2 -
 fs/f2fs/namei.c       | 138 ++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 135 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/f2fs_crypto.h b/fs/f2fs/f2fs_crypto.h
index bad32e6..6e41394 100644
--- a/fs/f2fs/f2fs_crypto.h
+++ b/fs/f2fs/f2fs_crypto.h
@@ -145,8 +145,6 @@ struct f2fs_encrypted_symlink_data {
  */
 static inline u32 encrypted_symlink_data_len(u32 l)
 {
-	if (l < F2FS_CRYPTO_BLOCK_SIZE)
-		l = F2FS_CRYPTO_BLOCK_SIZE;
 	return (l + sizeof(struct f2fs_encrypted_symlink_data) - 1);
 }
 #endif	/* _F2FS_CRYPTO_H */
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index c857f82..e6a6310 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -333,12 +333,102 @@ static void *f2fs_follow_link(struct dentry *dentry, struct nameidata *nd)
 	return page;
 }
 
+#ifdef CONFIG_F2FS_FS_ENCRYPTION
+static void *f2fs_encrypted_follow_link(struct dentry *dentry,
+						struct nameidata *nd)
+{
+	struct page *cpage = NULL;
+	char *caddr, *paddr = NULL;
+	struct f2fs_str cstr, pstr;
+	struct inode *inode = d_inode(dentry);
+	struct f2fs_encrypted_symlink_data *sd;
+	loff_t size = min_t(loff_t, i_size_read(inode), PAGE_SIZE - 1);
+	int res;
+	u32 max_size = inode->i_sb->s_blocksize;
+
+	if (!f2fs_encrypted_inode(inode))
+		return f2fs_follow_link(dentry, nd);
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
+	paddr = kmalloc(cstr.len + 1, GFP_NOFS);
+	if (!paddr) {
+		res = -ENOMEM;
+		goto errout;
+	}
+	pstr.name = paddr;
+	pstr.len = cstr.len;
+	res = f2fs_fname_disk_to_usr(inode, NULL, &cstr, &pstr);
+	if (res < 0)
+		goto errout;
+
+	/* Null-terminate the name */
+	if (res <= cstr.len)
+		paddr[res] = '\0';
+	nd_set_link(nd, paddr);
+	if (cpage) {
+		kunmap(cpage);
+		page_cache_release(cpage);
+	}
+	return NULL;
+errout:
+	if (cpage) {
+		kunmap(cpage);
+		page_cache_release(cpage);
+	}
+	kfree(paddr);
+	return ERR_PTR(res);
+}
+
+static void f2fs_encrypted_put_link(struct dentry *dentry, struct nameidata *nd,
+			  void *cookie)
+{
+	struct page *page = cookie;
+
+	if (!page) {
+		kfree(nd_get_link(nd));
+	} else {
+		kunmap(page);
+		page_cache_release(page);
+	}
+}
+#endif
+
 static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
 					const char *symname)
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
 
 	f2fs_balance_fs(sbi);
@@ -356,7 +446,40 @@ static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
 		goto out;
 	f2fs_unlock_op(sbi);
 
-	err = page_symlink(inode, symname, symlen);
+	if (f2fs_encrypted_inode(dir)) {
+		struct qstr istr = QSTR_INIT(symname, len);
+
+		err = f2fs_inherit_context(dir, inode, NULL);
+		if (err)
+			goto out;
+
+		err = f2fs_setup_fname_crypto(inode);
+		if (err)
+			goto out;
+
+		err = f2fs_fname_crypto_alloc_buffer(inode, len, &disk_link);
+		if (err)
+			goto out;
+
+		err = f2fs_fname_usr_to_disk(inode, &istr, &disk_link);
+		if (err < 0)
+			goto out;
+
+		p_len = encrypted_symlink_data_len(disk_link.len) + 1;
+		sd = kzalloc(p_len, GFP_NOFS);
+		if (!sd) {
+			err = -ENOMEM;
+			goto out;
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
 	alloc_nid_done(sbi, inode->i_ino);
 
 	d_instantiate(dentry, inode);
@@ -371,12 +494,16 @@ static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
 	 * If the symlink path is stored into inline_data, there is no
 	 * performance regression.
 	 */
-	filemap_write_and_wait_range(inode->i_mapping, 0, symlen - 1);
+	filemap_write_and_wait_range(inode->i_mapping, 0, p_len);
 
 	if (IS_DIRSYNC(dir))
 		f2fs_sync_fs(sbi->sb, 1);
+	kfree(sd);
+	f2fs_fname_crypto_free_buffer(&disk_link);
 	return err;
 out:
+	kfree(sd);
+	f2fs_fname_crypto_free_buffer(&disk_link);
 	handle_failed_inode(inode);
 	return err;
 }
@@ -843,8 +970,13 @@ const struct inode_operations f2fs_dir_inode_operations = {
 
 const struct inode_operations f2fs_symlink_inode_operations = {
 	.readlink       = generic_readlink,
+#ifdef CONFIG_F2FS_FS_ENCRYPTION
+	.follow_link    = f2fs_encrypted_follow_link,
+	.put_link       = f2fs_encrypted_put_link,
+#else
 	.follow_link    = f2fs_follow_link,
 	.put_link       = page_put_link,
+#endif
 	.getattr	= f2fs_getattr,
 	.setattr	= f2fs_setattr,
 #ifdef CONFIG_F2FS_FS_XATTR
-- 
2.1.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
