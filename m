From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/3] f2fs crypto: use per-inode tfm structure
Date: Thu, 21 May 2015 17:40:23 -0700
Message-ID: <1432255225-76792-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Theodore Ts'o <tytso@mit.edu>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch applies the following ext4 patch:

  ext4 crypto: use per-inode tfm structure

As suggested by Herbert Xu, we shouldn't allocate a new tfm each time
we read or write a page.  Instead we can use a single tfm hanging off
the inode's crypt_info structure for all of our encryption needs for
that inode, since the tfm can be used by multiple crypto requests in
parallel.

Also use cmpxchg() to avoid races that could result in crypt_info
structure getting doubly allocated or doubly freed.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/crypto.c       |  82 +++----------------------------------
 fs/f2fs/crypto_fname.c |  48 +---------------------
 fs/f2fs/crypto_key.c   | 107 ++++++++++++++++++++++++++++++++++++-------------
 fs/f2fs/dir.c          |   8 ++--
 fs/f2fs/f2fs.h         |   5 +--
 fs/f2fs/f2fs_crypto.h  |   4 --
 fs/f2fs/inode.c        |   2 +-
 fs/f2fs/namei.c        |   4 +-
 fs/f2fs/super.c        |   3 +-
 9 files changed, 96 insertions(+), 167 deletions(-)

diff --git a/fs/f2fs/crypto.c b/fs/f2fs/crypto.c
index c6d1122..2c7819a 100644
--- a/fs/f2fs/crypto.c
+++ b/fs/f2fs/crypto.c
@@ -91,8 +91,6 @@ void f2fs_release_crypto_ctx(struct f2fs_crypto_ctx *ctx)
 	}
 	ctx->w.control_page = NULL;
 	if (ctx->flags & F2FS_CTX_REQUIRES_FREE_ENCRYPT_FL) {
-		if (ctx->tfm)
-			crypto_free_tfm(ctx->tfm);
 		kmem_cache_free(f2fs_crypto_ctx_cachep, ctx);
 	} else {
 		spin_lock_irqsave(&f2fs_crypto_ctx_lock, flags);
@@ -113,7 +111,6 @@ void f2fs_release_crypto_ctx(struct f2fs_crypto_ctx *ctx)
 struct f2fs_crypto_ctx *f2fs_get_crypto_ctx(struct inode *inode)
 {
 	struct f2fs_crypto_ctx *ctx = NULL;
-	int res = 0;
 	unsigned long flags;
 	struct f2fs_crypt_info *ci = F2FS_I(inode)->i_crypt_info;
 
@@ -138,56 +135,13 @@ struct f2fs_crypto_ctx *f2fs_get_crypto_ctx(struct inode *inode)
 	spin_unlock_irqrestore(&f2fs_crypto_ctx_lock, flags);
 	if (!ctx) {
 		ctx = kmem_cache_zalloc(f2fs_crypto_ctx_cachep, GFP_NOFS);
-		if (!ctx) {
-			res = -ENOMEM;
-			goto out;
-		}
+		if (!ctx)
+			return ERR_PTR(-ENOMEM);
 		ctx->flags |= F2FS_CTX_REQUIRES_FREE_ENCRYPT_FL;
 	} else {
 		ctx->flags &= ~F2FS_CTX_REQUIRES_FREE_ENCRYPT_FL;
 	}
 	ctx->flags &= ~F2FS_WRITE_PATH_FL;
-
-	/*
-	 * Allocate a new Crypto API context if we don't already have
-	 * one or if it isn't the right mode.
-	 */
-	if (ctx->tfm && (ctx->mode != ci->ci_data_mode)) {
-		crypto_free_tfm(ctx->tfm);
-		ctx->tfm = NULL;
-		ctx->mode = F2FS_ENCRYPTION_MODE_INVALID;
-	}
-	if (!ctx->tfm) {
-		switch (ci->ci_data_mode) {
-		case F2FS_ENCRYPTION_MODE_AES_256_XTS:
-			ctx->tfm = crypto_ablkcipher_tfm(
-				crypto_alloc_ablkcipher("xts(aes)", 0, 0));
-			break;
-		case F2FS_ENCRYPTION_MODE_AES_256_GCM:
-			/*
-			 * TODO(mhalcrow): AEAD w/ gcm(aes);
-			 * crypto_aead_setauthsize()
-			 */
-			ctx->tfm = ERR_PTR(-ENOTSUPP);
-			break;
-		default:
-			BUG();
-		}
-		if (IS_ERR_OR_NULL(ctx->tfm)) {
-			res = PTR_ERR(ctx->tfm);
-			ctx->tfm = NULL;
-			goto out;
-		}
-		ctx->mode = ci->ci_data_mode;
-	}
-	BUG_ON(ci->ci_size != f2fs_encryption_key_size(ci->ci_data_mode));
-
-out:
-	if (res) {
-		if (!IS_ERR_OR_NULL(ctx))
-			f2fs_release_crypto_ctx(ctx);
-		ctx = ERR_PTR(res);
-	}
 	return ctx;
 }
 
@@ -229,11 +183,8 @@ static void f2fs_crypto_destroy(void)
 {
 	struct f2fs_crypto_ctx *pos, *n;
 
-	list_for_each_entry_safe(pos, n, &f2fs_free_crypto_ctxs, free_list) {
-		if (pos->tfm)
-			crypto_free_tfm(pos->tfm);
+	list_for_each_entry_safe(pos, n, &f2fs_free_crypto_ctxs, free_list)
 		kmem_cache_free(f2fs_crypto_ctx_cachep, pos);
-	}
 	INIT_LIST_HEAD(&f2fs_free_crypto_ctxs);
 	if (f2fs_bounce_page_pool)
 		mempool_destroy(f2fs_bounce_page_pool);
@@ -383,32 +334,11 @@ static int f2fs_page_crypto(struct f2fs_crypto_ctx *ctx,
 	struct ablkcipher_request *req = NULL;
 	DECLARE_F2FS_COMPLETION_RESULT(ecr);
 	struct scatterlist dst, src;
-	struct f2fs_inode_info *fi = F2FS_I(inode);
-	struct crypto_ablkcipher *atfm = __crypto_ablkcipher_cast(ctx->tfm);
+	struct f2fs_crypt_info *ci = F2FS_I(inode)->i_crypt_info;
+	struct crypto_ablkcipher *tfm = ci->ci_ctfm;
 	int res = 0;
 
-	BUG_ON(!ctx->tfm);
-	BUG_ON(ctx->mode != fi->i_crypt_info->ci_data_mode);
-
-	if (ctx->mode != F2FS_ENCRYPTION_MODE_AES_256_XTS) {
-		printk_ratelimited(KERN_ERR
-				"%s: unsupported crypto algorithm: %d\n",
-				__func__, ctx->mode);
-		return -ENOTSUPP;
-	}
-
-	crypto_ablkcipher_clear_flags(atfm, ~0);
-	crypto_tfm_set_flags(ctx->tfm, CRYPTO_TFM_REQ_WEAK_KEY);
-
-	res = crypto_ablkcipher_setkey(atfm, fi->i_crypt_info->ci_raw,
-					fi->i_crypt_info->ci_size);
-	if (res) {
-		printk_ratelimited(KERN_ERR
-				"%s: crypto_ablkcipher_setkey() failed\n",
-				__func__);
-		return res;
-	}
-	req = ablkcipher_request_alloc(atfm, GFP_NOFS);
+	req = ablkcipher_request_alloc(tfm, GFP_NOFS);
 	if (!req) {
 		printk_ratelimited(KERN_ERR
 				"%s: crypto_request_alloc() failed\n",
diff --git a/fs/f2fs/crypto_fname.c b/fs/f2fs/crypto_fname.c
index 016c4b6..81852cc 100644
--- a/fs/f2fs/crypto_fname.c
+++ b/fs/f2fs/crypto_fname.c
@@ -249,52 +249,6 @@ static int digest_decode(const char *src, int len, char *dst)
 	return cp - dst;
 }
 
-int f2fs_setup_fname_crypto(struct inode *inode)
-{
-	struct f2fs_inode_info *fi = F2FS_I(inode);
-	struct f2fs_crypt_info *ci = fi->i_crypt_info;
-	struct crypto_ablkcipher *ctfm;
-	int res;
-
-	/* Check if the crypto policy is set on the inode */
-	res = f2fs_encrypted_inode(inode);
-	if (res == 0)
-		return 0;
-
-	res = f2fs_get_encryption_info(inode);
-	if (res < 0)
-		return res;
-	ci = fi->i_crypt_info;
-
-	if (!ci || ci->ci_ctfm)
-		return 0;
-
-	if (ci->ci_filename_mode != F2FS_ENCRYPTION_MODE_AES_256_CTS) {
-		printk_once(KERN_WARNING "f2fs: unsupported key mode %d\n",
-				ci->ci_filename_mode);
-		return -ENOKEY;
-	}
-
-	ctfm = crypto_alloc_ablkcipher("cts(cbc(aes))", 0, 0);
-	if (!ctfm || IS_ERR(ctfm)) {
-		res = ctfm ? PTR_ERR(ctfm) : -ENOMEM;
-		printk(KERN_DEBUG "%s: error (%d) allocating crypto tfm\n",
-				__func__, res);
-		return res;
-	}
-	crypto_ablkcipher_clear_flags(ctfm, ~0);
-	crypto_tfm_set_flags(crypto_ablkcipher_tfm(ctfm),
-			     CRYPTO_TFM_REQ_WEAK_KEY);
-
-	res = crypto_ablkcipher_setkey(ctfm, ci->ci_raw, ci->ci_size);
-	if (res) {
-		crypto_free_ablkcipher(ctfm);
-		return -EIO;
-	}
-	ci->ci_ctfm = ctfm;
-	return 0;
-}
-
 /**
  * f2fs_fname_crypto_round_up() -
  *
@@ -427,7 +381,7 @@ int f2fs_fname_setup_filename(struct inode *dir, const struct qstr *iname,
 		fname->disk_name.len = iname->len;
 		return 0;
 	}
-	ret = f2fs_setup_fname_crypto(dir);
+	ret = f2fs_get_encryption_info(dir);
 	if (ret)
 		return ret;
 	ci = F2FS_I(dir)->i_crypt_info;
diff --git a/fs/f2fs/crypto_key.c b/fs/f2fs/crypto_key.c
index 8a10569..95b8f93 100644
--- a/fs/f2fs/crypto_key.c
+++ b/fs/f2fs/crypto_key.c
@@ -87,20 +87,31 @@ out:
 	return res;
 }
 
-void f2fs_free_encryption_info(struct inode *inode)
+static void f2fs_free_crypt_info(struct f2fs_crypt_info *ci)
 {
-	struct f2fs_inode_info *fi = F2FS_I(inode);
-	struct f2fs_crypt_info *ci = fi->i_crypt_info;
-
 	if (!ci)
 		return;
 
 	if (ci->ci_keyring_key)
 		key_put(ci->ci_keyring_key);
 	crypto_free_ablkcipher(ci->ci_ctfm);
-	memzero_explicit(&ci->ci_raw, sizeof(ci->ci_raw));
 	kmem_cache_free(f2fs_crypt_info_cachep, ci);
-	fi->i_crypt_info = NULL;
+}
+
+void f2fs_free_encryption_info(struct inode *inode, struct f2fs_crypt_info *ci)
+{
+	struct f2fs_inode_info *fi = F2FS_I(inode);
+	struct f2fs_crypt_info *prev;
+
+	if (ci == NULL)
+		ci = ACCESS_ONCE(fi->i_crypt_info);
+	if (ci == NULL)
+		return;
+	prev = cmpxchg(&fi->i_crypt_info, ci, NULL);
+	if (prev != ci)
+		return;
+
+	f2fs_free_crypt_info(ci);
 }
 
 int _f2fs_get_encryption_info(struct inode *inode)
@@ -113,17 +124,23 @@ int _f2fs_get_encryption_info(struct inode *inode)
 	struct f2fs_encryption_key *master_key;
 	struct f2fs_encryption_context ctx;
 	struct user_key_payload *ukp;
+	struct crypto_ablkcipher *ctfm;
+	const char *cipher_str;
+	char raw_key[F2FS_MAX_KEY_SIZE];
+	char mode;
 	int res;
 
 	res = f2fs_crypto_initialize();
 	if (res)
 		return res;
-
-	if (fi->i_crypt_info) {
-		if (!fi->i_crypt_info->ci_keyring_key ||
-			key_validate(fi->i_crypt_info->ci_keyring_key) == 0)
+retry:
+	crypt_info = ACCESS_ONCE(fi->i_crypt_info);
+	if (crypt_info) {
+		if (!crypt_info->ci_keyring_key ||
+				key_validate(crypt_info->ci_keyring_key) == 0)
 			return 0;
-		f2fs_free_encryption_info(inode);
+		f2fs_free_encryption_info(inode, crypt_info);
+		goto retry;
 	}
 
 	res = f2fs_getxattr(inode, F2FS_XATTR_INDEX_ENCRYPTION,
@@ -143,18 +160,30 @@ int _f2fs_get_encryption_info(struct inode *inode)
 	crypt_info->ci_data_mode = ctx.contents_encryption_mode;
 	crypt_info->ci_filename_mode = ctx.filenames_encryption_mode;
 	crypt_info->ci_ctfm = NULL;
+	crypt_info->ci_keyring_key = NULL;
 	memcpy(crypt_info->ci_master_key, ctx.master_key_descriptor,
 				sizeof(crypt_info->ci_master_key));
 	if (S_ISREG(inode->i_mode))
-		crypt_info->ci_size =
-			f2fs_encryption_key_size(crypt_info->ci_data_mode);
+		mode = crypt_info->ci_data_mode;
 	else if (S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode))
-		crypt_info->ci_size =
-			f2fs_encryption_key_size(crypt_info->ci_filename_mode);
+		mode = crypt_info->ci_filename_mode;
 	else
 		BUG();
 
-	BUG_ON(!crypt_info->ci_size);
+	switch (mode) {
+	case F2FS_ENCRYPTION_MODE_AES_256_XTS:
+		cipher_str = "xts(aes)";
+		break;
+	case F2FS_ENCRYPTION_MODE_AES_256_CTS:
+		cipher_str = "cts(cbc(aes))";
+		break;
+	default:
+		printk_once(KERN_WARNING
+			    "f2fs: unsupported key mode %d (ino %u)\n",
+			    mode, (unsigned) inode->i_ino);
+		res = -ENOKEY;
+		goto out;
+	}
 
 	memcpy(full_key_descriptor, F2FS_KEY_DESC_PREFIX,
 					F2FS_KEY_DESC_PREFIX_SIZE);
@@ -169,6 +198,7 @@ int _f2fs_get_encryption_info(struct inode *inode)
 		keyring_key = NULL;
 		goto out;
 	}
+	crypt_info->ci_keyring_key = keyring_key;
 	BUG_ON(keyring_key->type != &key_type_logon);
 	ukp = ((struct user_key_payload *)keyring_key->payload.data);
 	if (ukp->datalen != sizeof(struct f2fs_encryption_key)) {
@@ -180,19 +210,40 @@ int _f2fs_get_encryption_info(struct inode *inode)
 				F2FS_KEY_DERIVATION_NONCE_SIZE);
 	BUG_ON(master_key->size != F2FS_AES_256_XTS_KEY_SIZE);
 	res = f2fs_derive_key_aes(ctx.nonce, master_key->raw,
-					crypt_info->ci_raw);
-out:
-	if (res < 0) {
-		if (res == -ENOKEY)
-			res = 0;
-		kmem_cache_free(f2fs_crypt_info_cachep, crypt_info);
-	} else {
-		fi->i_crypt_info = crypt_info;
-		crypt_info->ci_keyring_key = keyring_key;
-		keyring_key = NULL;
+				  raw_key);
+	if (res)
+		goto out;
+
+	ctfm = crypto_alloc_ablkcipher(cipher_str, 0, 0);
+	if (!ctfm || IS_ERR(ctfm)) {
+		res = ctfm ? PTR_ERR(ctfm) : -ENOMEM;
+		printk(KERN_DEBUG
+		       "%s: error %d (inode %u) allocating crypto tfm\n",
+		       __func__, res, (unsigned) inode->i_ino);
+		goto out;
 	}
-	if (keyring_key)
-		key_put(keyring_key);
+	crypt_info->ci_ctfm = ctfm;
+	crypto_ablkcipher_clear_flags(ctfm, ~0);
+	crypto_tfm_set_flags(crypto_ablkcipher_tfm(ctfm),
+			     CRYPTO_TFM_REQ_WEAK_KEY);
+	res = crypto_ablkcipher_setkey(ctfm, raw_key,
+					f2fs_encryption_key_size(mode));
+	if (res)
+		goto out;
+
+	memzero_explicit(raw_key, sizeof(raw_key));
+	if (cmpxchg(&fi->i_crypt_info, NULL, crypt_info) != NULL) {
+		f2fs_free_crypt_info(crypt_info);
+		goto retry;
+	}
+	return 0;
+
+out:
+	if (res == -ENOKEY && !S_ISREG(inode->i_mode))
+		res = 0;
+
+	f2fs_free_crypt_info(crypt_info);
+	memzero_explicit(raw_key, sizeof(raw_key));
 	return res;
 }
 
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 3e92376..a34ebd8 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -825,11 +825,11 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 	struct f2fs_str fstr = FSTR_INIT(NULL, 0);
 	int err = 0;
 
-	err = f2fs_setup_fname_crypto(inode);
-	if (err)
-		return err;
-
 	if (f2fs_encrypted_inode(inode)) {
+		err = f2fs_get_encryption_info(inode);
+		if (err)
+			return err;
+
 		err = f2fs_fname_crypto_alloc_buffer(inode, F2FS_NAME_LEN,
 								&fstr);
 		if (err < 0)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 7e93fcf..70cdf7b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2016,7 +2016,7 @@ int f2fs_decrypt_one(struct inode *, struct page *);
 void f2fs_end_io_crypto_work(struct f2fs_crypto_ctx *, struct bio *);
 
 /* crypto_key.c */
-void f2fs_free_encryption_info(struct inode *);
+void f2fs_free_encryption_info(struct inode *, struct f2fs_crypt_info *);
 int _f2fs_get_encryption_info(struct inode *inode);
 
 /* crypto_fname.c */
@@ -2051,7 +2051,6 @@ static inline int f2fs_get_encryption_info(struct inode *inode)
 	return 0;
 }
 
-int f2fs_setup_fname_crypto(struct inode *);
 void f2fs_fname_crypto_free_buffer(struct f2fs_str *);
 int f2fs_fname_setup_filename(struct inode *, const struct qstr *,
 				int lookup, struct f2fs_filename *);
@@ -2065,8 +2064,6 @@ static inline void f2fs_exit_crypto(void) { }
 
 static inline int f2fs_has_encryption_key(struct inode *i) { return 0; }
 static inline int f2fs_get_encryption_info(struct inode *i) { return 0; }
-
-static inline int f2fs_setup_fname_crypto(struct inode *i) { return 0; }
 static inline void f2fs_fname_crypto_free_buffer(struct f2fs_str *p) { }
 
 static inline int f2fs_fname_setup_filename(struct inode *dir,
diff --git a/fs/f2fs/f2fs_crypto.h b/fs/f2fs/f2fs_crypto.h
index e33cec9..be59d91 100644
--- a/fs/f2fs/f2fs_crypto.h
+++ b/fs/f2fs/f2fs_crypto.h
@@ -75,13 +75,11 @@ struct f2fs_encryption_key {
 } __attribute__((__packed__));
 
 struct f2fs_crypt_info {
-	unsigned char	ci_size;
 	char		ci_data_mode;
 	char		ci_filename_mode;
 	char		ci_flags;
 	struct crypto_ablkcipher *ci_ctfm;
 	struct key	*ci_keyring_key;
-	char		ci_raw[F2FS_MAX_KEY_SIZE];
 	char		ci_master_key[F2FS_KEY_DESCRIPTOR_SIZE];
 };
 
@@ -90,7 +88,6 @@ struct f2fs_crypt_info {
 #define F2FS_WRITE_PATH_FL			      0x00000004
 
 struct f2fs_crypto_ctx {
-	struct crypto_tfm *tfm;         /* Crypto API context */
 	union {
 		struct {
 			struct page *bounce_page;       /* Ciphertext page */
@@ -103,7 +100,6 @@ struct f2fs_crypto_ctx {
 		struct list_head free_list;     /* Free list */
 	};
 	char flags;                      /* Flags */
-	char mode;                       /* Encryption mode for tfm */
 };
 
 struct f2fs_completion_result {
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index ea6ba3b..2550868 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -364,7 +364,7 @@ no_delete:
 out_clear:
 #ifdef CONFIG_F2FS_FS_ENCRYPTION
 	if (F2FS_I(inode)->i_crypt_info)
-		f2fs_free_encryption_info(inode);
+		f2fs_free_encryption_info(inode, F2FS_I(inode)->i_crypt_info);
 #endif
 	clear_inode(inode);
 }
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 26e68ad..daed09c 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -364,7 +364,7 @@ static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
 		if (err)
 			goto err_out;
 
-		err = f2fs_setup_fname_crypto(inode);
+		err = f2fs_get_encryption_info(inode);
 		if (err)
 			goto err_out;
 
@@ -927,7 +927,7 @@ static void *f2fs_encrypted_follow_link(struct dentry *dentry,
 	u32 max_size = inode->i_sb->s_blocksize;
 	int res;
 
-	res = f2fs_setup_fname_crypto(inode);
+	res = f2fs_get_encryption_info(inode);
 	if (res)
 		return ERR_PTR(res);
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f596b24..38bb7c6 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -449,7 +449,8 @@ static int f2fs_drop_inode(struct inode *inode)
 
 #ifdef CONFIG_F2FS_FS_ENCRYPTION
 			if (F2FS_I(inode)->i_crypt_info)
-				f2fs_free_encryption_info(inode);
+				f2fs_free_encryption_info(inode,
+					F2FS_I(inode)->i_crypt_info);
 #endif
 			spin_lock(&inode->i_lock);
 		}
-- 
2.1.1
