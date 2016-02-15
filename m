From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs crypto: avoid unneeded memory allocation when
 {en/de}crypting symlink
Date: Mon, 15 Feb 2016 17:54:26 +0800
Message-ID: <013701d167d6$f2fa0970$d8ee1c50$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch adopts f2fs with codes of ext4, it removes unneeded memory
allocation in creating/accessing path of symlink.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/crypto_fname.c | 21 +++++++++------
 fs/f2fs/f2fs.h         |  1 +
 fs/f2fs/namei.c        | 72 ++++++++++++++++++++++++--------------------------
 3 files changed, 48 insertions(+), 46 deletions(-)

diff --git a/fs/f2fs/crypto_fname.c b/fs/f2fs/crypto_fname.c
index 73741fb..6dfdc97 100644
--- a/fs/f2fs/crypto_fname.c
+++ b/fs/f2fs/crypto_fname.c
@@ -257,6 +257,18 @@ u32 f2fs_fname_crypto_round_up(u32 size, u32 blksize)
 	return ((size + blksize - 1) / blksize) * blksize;
 }
 
+unsigned f2fs_fname_encrypted_size(struct inode *inode, u32 ilen)
+{
+	struct f2fs_crypt_info *ci = F2FS_I(inode)->i_crypt_info;
+	int padding = 32;
+
+	if (ci)
+		padding = 4 << (ci->ci_flags & F2FS_POLICY_FLAGS_PAD_MASK);
+	if (ilen < F2FS_CRYPTO_BLOCK_SIZE)
+		ilen = F2FS_CRYPTO_BLOCK_SIZE;
+	return f2fs_fname_crypto_round_up(ilen, padding);
+}
+
 /**
  * f2fs_fname_crypto_alloc_obuff() -
  *
@@ -266,15 +278,8 @@ u32 f2fs_fname_crypto_round_up(u32 size, u32 blksize)
 int f2fs_fname_crypto_alloc_buffer(struct inode *inode,
 				   u32 ilen, struct f2fs_str *crypto_str)
 {
-	unsigned int olen;
-	int padding = 32;
-	struct f2fs_crypt_info *ci = F2FS_I(inode)->i_crypt_info;
+	unsigned int olen = f2fs_fname_encrypted_size(inode, ilen);
 
-	if (ci)
-		padding = 4 << (ci->ci_flags & F2FS_POLICY_FLAGS_PAD_MASK);
-	if (ilen < F2FS_CRYPTO_BLOCK_SIZE)
-		ilen = F2FS_CRYPTO_BLOCK_SIZE;
-	olen = f2fs_fname_crypto_round_up(ilen, padding);
 	crypto_str->len = olen;
 	if (olen < F2FS_FNAME_CRYPTO_DIGEST_SIZE * 2)
 		olen = F2FS_FNAME_CRYPTO_DIGEST_SIZE * 2;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c4c7bf1..fc302ea 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2225,6 +2225,7 @@ int _f2fs_get_encryption_info(struct inode *inode);
 /* crypto_fname.c */
 bool f2fs_valid_filenames_enc_mode(uint32_t);
 u32 f2fs_fname_crypto_round_up(u32, u32);
+unsigned f2fs_fname_encrypted_size(struct inode *, u32);
 int f2fs_fname_crypto_alloc_buffer(struct inode *, u32, struct f2fs_str *);
 int f2fs_fname_disk_to_usr(struct inode *, f2fs_hash_t *,
 			const struct f2fs_str *, struct f2fs_str *);
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 6f944e5..fcc8c26 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -345,13 +345,23 @@ static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
 	struct inode *inode;
 	size_t len = strlen(symname);
-	size_t p_len;
-	char *p_str;
-	struct f2fs_str disk_link = FSTR_INIT(NULL, 0);
+	struct f2fs_str disk_link = FSTR_INIT((char *)symname, len + 1);
 	struct f2fs_encrypted_symlink_data *sd = NULL;
 	int err;
 
-	if (len > dir->i_sb->s_blocksize)
+	if (f2fs_encrypted_inode(dir)) {
+		err = f2fs_get_encryption_info(dir);
+		if (err)
+			return err;
+
+		if (!f2fs_encrypted_inode(dir))
+			return -EPERM;
+
+		disk_link.len = (f2fs_fname_encrypted_size(dir, len) +
+				sizeof(struct f2fs_encrypted_symlink_data));
+	}
+
+	if (disk_link.len > dir->i_sb->s_blocksize)
 		return -ENAMETOOLONG;
 
 	inode = f2fs_new_inode(dir, S_IFLNK | S_IRWXUGO);
@@ -374,42 +384,36 @@ static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
 	f2fs_unlock_op(sbi);
 	alloc_nid_done(sbi, inode->i_ino);
 
-	if (f2fs_encrypted_inode(dir)) {
+	if (f2fs_encrypted_inode(inode)) {
 		struct qstr istr = QSTR_INIT(symname, len);
+		struct f2fs_str ostr;
 
-		err = f2fs_get_encryption_info(inode);
-		if (err)
+		sd = kzalloc(disk_link.len, GFP_NOFS);
+		if (!sd) {
+			err = -ENOMEM;
 			goto err_out;
+		}
 
-		err = f2fs_fname_crypto_alloc_buffer(inode, len, &disk_link);
+		err = f2fs_get_encryption_info(inode);
 		if (err)
 			goto err_out;
 
-		err = f2fs_fname_usr_to_disk(inode, &istr, &disk_link);
-		if (err < 0)
-			goto err_out;
-
-		p_len = encrypted_symlink_data_len(disk_link.len) + 1;
-
-		if (p_len > dir->i_sb->s_blocksize) {
-			err = -ENAMETOOLONG;
+		if (!f2fs_encrypted_inode(inode)) {
+			err = -EPERM;
 			goto err_out;
 		}
 
-		sd = kzalloc(p_len, GFP_NOFS);
-		if (!sd) {
-			err = -ENOMEM;
+		ostr.name = sd->encrypted_path;
+		ostr.len = disk_link.len;
+		err = f2fs_fname_usr_to_disk(inode, &istr, &ostr);
+		if (err < 0)
 			goto err_out;
-		}
-		memcpy(sd->encrypted_path, disk_link.name, disk_link.len);
-		sd->len = cpu_to_le16(disk_link.len);
-		p_str = (char *)sd;
-	} else {
-		p_len = len + 1;
-		p_str = (char *)symname;
+
+		sd->len = cpu_to_le16(ostr.len);
+		disk_link.name = (char *)sd;
 	}
 
-	err = page_symlink(inode, p_str, p_len);
+	err = page_symlink(inode, disk_link.name, disk_link.len);
 
 err_out:
 	d_instantiate(dentry, inode);
@@ -425,7 +429,8 @@ err_out:
 	 * performance regression.
 	 */
 	if (!err) {
-		filemap_write_and_wait_range(inode->i_mapping, 0, p_len - 1);
+		filemap_write_and_wait_range(inode->i_mapping, 0,
+							disk_link.len - 1);
 
 		if (IS_DIRSYNC(dir))
 			f2fs_sync_fs(sbi->sb, 1);
@@ -434,7 +439,6 @@ err_out:
 	}
 
 	kfree(sd);
-	f2fs_fname_crypto_free_buffer(&disk_link);
 	return err;
 out:
 	handle_failed_inode(inode);
@@ -966,6 +970,7 @@ static const char *f2fs_encrypted_get_link(struct dentry *dentry,
 
 	/* Symlink is encrypted */
 	sd = (struct f2fs_encrypted_symlink_data *)caddr;
+	cstr.name = sd->encrypted_path;
 	cstr.len = le16_to_cpu(sd->len);
 
 	/* this is broken symlink case */
@@ -973,12 +978,6 @@ static const char *f2fs_encrypted_get_link(struct dentry *dentry,
 		res = -ENOENT;
 		goto errout;
 	}
-	cstr.name = kmalloc(cstr.len, GFP_NOFS);
-	if (!cstr.name) {
-		res = -ENOMEM;
-		goto errout;
-	}
-	memcpy(cstr.name, sd->encrypted_path, cstr.len);
 
 	/* this is broken symlink case */
 	if (unlikely(cstr.name[0] == 0)) {
@@ -1000,8 +999,6 @@ static const char *f2fs_encrypted_get_link(struct dentry *dentry,
 	if (res < 0)
 		goto errout;
 
-	kfree(cstr.name);
-
 	paddr = pstr.name;
 
 	/* Null-terminate the name */
@@ -1011,7 +1008,6 @@ static const char *f2fs_encrypted_get_link(struct dentry *dentry,
 	set_delayed_call(done, kfree_link, paddr);
 	return paddr;
 errout:
-	kfree(cstr.name);
 	f2fs_fname_crypto_free_buffer(&pstr);
 	page_cache_release(cpage);
 	return ERR_PTR(res);
-- 
2.7.0
