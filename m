From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/4] f2fs crypto: preallocate a tfm for the data path
Date: Tue, 19 May 2015 17:43:23 -0700
Message-ID: <1432082606-55975-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch is to avoid memory allocation during data path for crypto structure
such as tfm.

In order to do that, it introduces f2fs_setup_crypto() which allocates tfm and
generates the key likewise f2fs_setup_fname_crypto().
And, f2fs_setup_crypto is called by user APIs.

Then, in the data path, f2fs_crypto_ctx will be used to allocate pages for
actual crypto stuffs.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/crypto.c      | 126 ++++++++++++++++++++------------------------------
 fs/f2fs/f2fs.h        |   1 +
 fs/f2fs/f2fs_crypto.h |   2 -
 fs/f2fs/file.c        |  20 ++++----
 fs/f2fs/segment.c     |   3 +-
 5 files changed, 64 insertions(+), 88 deletions(-)

diff --git a/fs/f2fs/crypto.c b/fs/f2fs/crypto.c
index c6d1122..c0c5fd2 100644
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
@@ -101,6 +99,51 @@ void f2fs_release_crypto_ctx(struct f2fs_crypto_ctx *ctx)
 	}
 }
 
+int f2fs_setup_crypto(struct inode *inode)
+{
+	struct f2fs_inode_info *fi = F2FS_I(inode);
+	struct f2fs_crypt_info *ci;
+	struct crypto_ablkcipher *ctfm;
+	int res;
+
+	res = f2fs_get_encryption_info(inode);
+	if (res < 0)
+		return res;
+
+	if (!fi->i_crypt_info)
+		return -EACCES;
+
+	ci = fi->i_crypt_info;
+
+	if (ci->ci_data_mode != F2FS_ENCRYPTION_MODE_AES_256_XTS) {
+		printk_once(KERN_WARNING "f2fs: unsupported key mode %d\n",
+				ci->ci_data_mode);
+		return -ENOTSUPP;
+	}
+
+	ctfm = crypto_alloc_ablkcipher("xts(aes)", 0, 0);
+	if (!ctfm || IS_ERR(ctfm)) {
+		res = ctfm ? PTR_ERR(ctfm) : -ENOMEM;
+		printk(KERN_DEBUG "%s: error (%d) allocating crypto tfm\n",
+				__func__, res);
+		return res;
+	}
+
+	BUG_ON(ci->ci_size != f2fs_encryption_key_size(ci->ci_data_mode));
+
+	crypto_ablkcipher_clear_flags(ctfm, ~0);
+	crypto_tfm_set_flags(crypto_ablkcipher_tfm(ctfm),
+					CRYPTO_TFM_REQ_WEAK_KEY);
+
+	res = crypto_ablkcipher_setkey(ctfm, ci->ci_raw, ci->ci_size);
+	if (res) {
+		crypto_free_ablkcipher(ctfm);
+		return -EIO;
+	}
+	ci->ci_ctfm = ctfm;
+	return 0;
+}
+
 /**
  * f2fs_get_crypto_ctx() - Gets an encryption context
  * @inode:       The inode for which we are doing the crypto
@@ -113,11 +156,9 @@ void f2fs_release_crypto_ctx(struct f2fs_crypto_ctx *ctx)
 struct f2fs_crypto_ctx *f2fs_get_crypto_ctx(struct inode *inode)
 {
 	struct f2fs_crypto_ctx *ctx = NULL;
-	int res = 0;
 	unsigned long flags;
-	struct f2fs_crypt_info *ci = F2FS_I(inode)->i_crypt_info;
 
-	if (ci == NULL)
+	if (F2FS_I(inode)->i_crypt_info == NULL)
 		return ERR_PTR(-EACCES);
 
 	/*
@@ -138,56 +179,13 @@ struct f2fs_crypto_ctx *f2fs_get_crypto_ctx(struct inode *inode)
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
 
@@ -229,11 +227,8 @@ static void f2fs_crypto_destroy(void)
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
@@ -384,30 +379,9 @@ static int f2fs_page_crypto(struct f2fs_crypto_ctx *ctx,
 	DECLARE_F2FS_COMPLETION_RESULT(ecr);
 	struct scatterlist dst, src;
 	struct f2fs_inode_info *fi = F2FS_I(inode);
-	struct crypto_ablkcipher *atfm = __crypto_ablkcipher_cast(ctx->tfm);
+	struct crypto_ablkcipher *atfm = fi->i_crypt_info->ci_ctfm;
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
 	req = ablkcipher_request_alloc(atfm, GFP_NOFS);
 	if (!req) {
 		printk_ratelimited(KERN_ERR
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 7e93fcf..801afcb 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2008,6 +2008,7 @@ int f2fs_get_policy(struct inode *, struct f2fs_encryption_policy *);
 extern struct kmem_cache *f2fs_crypt_info_cachep;
 bool f2fs_valid_contents_enc_mode(uint32_t);
 uint32_t f2fs_validate_encryption_key_size(uint32_t, uint32_t);
+int f2fs_setup_crypto(struct inode *);
 struct f2fs_crypto_ctx *f2fs_get_crypto_ctx(struct inode *);
 void f2fs_release_crypto_ctx(struct f2fs_crypto_ctx *);
 struct page *f2fs_encrypt(struct inode *, struct page *);
diff --git a/fs/f2fs/f2fs_crypto.h b/fs/f2fs/f2fs_crypto.h
index e33cec9..6022269 100644
--- a/fs/f2fs/f2fs_crypto.h
+++ b/fs/f2fs/f2fs_crypto.h
@@ -90,7 +90,6 @@ struct f2fs_crypt_info {
 #define F2FS_WRITE_PATH_FL			      0x00000004
 
 struct f2fs_crypto_ctx {
-	struct crypto_tfm *tfm;         /* Crypto API context */
 	union {
 		struct {
 			struct page *bounce_page;       /* Ciphertext page */
@@ -103,7 +102,6 @@ struct f2fs_crypto_ctx {
 		struct list_head free_list;     /* Free list */
 	};
 	char flags;                      /* Flags */
-	char mode;                       /* Encryption mode for tfm */
 };
 
 struct f2fs_completion_result {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index cb0d6b6..35a3b26 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -411,7 +411,7 @@ static int f2fs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	struct inode *inode = file_inode(file);
 
 	if (f2fs_encrypted_inode(inode)) {
-		int err = f2fs_get_encryption_info(inode);
+		int err = f2fs_setup_crypto(inode);
 		if (err)
 			return 0;
 	}
@@ -433,7 +433,7 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
 	int ret = generic_file_open(inode, filp);
 
 	if (!ret && f2fs_encrypted_inode(inode)) {
-		ret = f2fs_get_encryption_info(inode);
+		ret = f2fs_setup_crypto(inode);
 		if (ret)
 			ret = -EACCES;
 	}
@@ -647,9 +647,11 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 		return err;
 
 	if (attr->ia_valid & ATTR_SIZE) {
-		if (f2fs_encrypted_inode(inode) &&
-				f2fs_get_encryption_info(inode))
-			return -EACCES;
+		if (f2fs_encrypted_inode(inode)) {
+			err = f2fs_setup_crypto(inode);
+			if (err)
+				return err == -EINVAL ? -EACCES : err;
+		}
 
 		if (attr->ia_size != i_size_read(inode)) {
 			truncate_setsize(inode, attr->ia_size);
@@ -1500,9 +1502,11 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct inode *inode = file_inode(iocb->ki_filp);
 
 	if (f2fs_encrypted_inode(inode) &&
-				!f2fs_has_encryption_key(inode) &&
-				f2fs_get_encryption_info(inode))
-		return -EACCES;
+				!f2fs_has_encryption_key(inode)) {
+		int err = f2fs_setup_crypto(inode);
+		if (err)
+			return err == -EINVAL ? -EACCES : err;
+	}
 
 	return generic_file_write_iter(iocb, from);
 }
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 88428e6..59566ae 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -797,8 +797,7 @@ struct page *get_sum_page(struct f2fs_sb_info *sbi, unsigned int segno)
 	return get_meta_page(sbi, GET_SUM_BLOCK(sbi, segno));
 }
 
-void update_meta_page(struct f2fs_sb_info *sbi, void *src,
-							block_t blk_addr)
+void update_meta_page(struct f2fs_sb_info *sbi, void *src, block_t blk_addr)
 {
 	struct page *page = grab_meta_page(sbi, blk_addr);
 	void *dst = page_address(page);
-- 
2.1.1
