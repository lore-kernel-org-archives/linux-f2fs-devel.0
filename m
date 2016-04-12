From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/3] fscrypto: don't let data integrity writebacks fail with ENOMEM
Date: Tue, 12 Apr 2016 10:27:22 -0700
Message-ID: <1460482042-14011-3-git-send-email-jaegeuk@kernel.org>
References: <1460482042-14011-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1460482042-14011-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Theodore Ts'o <tytso@mit.edu>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch fixes the issue introduced by the ext4 crypto fix in a same manner.
For F2FS, however, we flush the pending IOs and wait for a while to acquire free
memory.

Fixes: c9af28fdd4492 ("ext4 crypto: don't let data integrity writebacks fail with ENOMEM")
Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/crypto/crypto.c       | 36 ++++++++++++++++++++----------------
 fs/f2fs/data.c           | 16 +++++++++++++---
 include/linux/fscrypto.h |  9 +++++----
 3 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index 58ae0ba..da70520 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -81,13 +81,14 @@ EXPORT_SYMBOL(fscrypt_release_ctx);
 /**
  * fscrypt_get_ctx() - Gets an encryption context
  * @inode:       The inode for which we are doing the crypto
+ * @gfp_flags:   The gfp flag for memory allocation
  *
  * Allocates and initializes an encryption context.
  *
  * Return: An allocated and initialized encryption context on success; error
  * value or NULL otherwise.
  */
-struct fscrypt_ctx *fscrypt_get_ctx(struct inode *inode)
+struct fscrypt_ctx *fscrypt_get_ctx(struct inode *inode, gfp_t gfp_flags)
 {
 	struct fscrypt_ctx *ctx = NULL;
 	struct fscrypt_info *ci = inode->i_crypt_info;
@@ -113,7 +114,7 @@ struct fscrypt_ctx *fscrypt_get_ctx(struct inode *inode)
 		list_del(&ctx->free_list);
 	spin_unlock_irqrestore(&fscrypt_ctx_lock, flags);
 	if (!ctx) {
-		ctx = kmem_cache_zalloc(fscrypt_ctx_cachep, GFP_NOFS);
+		ctx = kmem_cache_zalloc(fscrypt_ctx_cachep, gfp_flags);
 		if (!ctx)
 			return ERR_PTR(-ENOMEM);
 		ctx->flags |= FS_CTX_REQUIRES_FREE_ENCRYPT_FL;
@@ -147,7 +148,8 @@ typedef enum {
 
 static int do_page_crypto(struct inode *inode,
 			fscrypt_direction_t rw, pgoff_t index,
-			struct page *src_page, struct page *dest_page)
+			struct page *src_page, struct page *dest_page,
+			gfp_t gfp_flags)
 {
 	u8 xts_tweak[FS_XTS_TWEAK_SIZE];
 	struct skcipher_request *req = NULL;
@@ -157,7 +159,7 @@ static int do_page_crypto(struct inode *inode,
 	struct crypto_skcipher *tfm = ci->ci_ctfm;
 	int res = 0;
 
-	req = skcipher_request_alloc(tfm, GFP_NOFS);
+	req = skcipher_request_alloc(tfm, gfp_flags);
 	if (!req) {
 		printk_ratelimited(KERN_ERR
 				"%s: crypto_request_alloc() failed\n",
@@ -199,10 +201,9 @@ static int do_page_crypto(struct inode *inode,
 	return 0;
 }
 
-static struct page *alloc_bounce_page(struct fscrypt_ctx *ctx)
+static struct page *alloc_bounce_page(struct fscrypt_ctx *ctx, gfp_t gfp_flags)
 {
-	ctx->w.bounce_page = mempool_alloc(fscrypt_bounce_page_pool,
-							GFP_NOWAIT);
+	ctx->w.bounce_page = mempool_alloc(fscrypt_bounce_page_pool, gfp_flags);
 	if (ctx->w.bounce_page == NULL)
 		return ERR_PTR(-ENOMEM);
 	ctx->flags |= FS_WRITE_PATH_FL;
@@ -213,6 +214,7 @@ static struct page *alloc_bounce_page(struct fscrypt_ctx *ctx)
  * fscypt_encrypt_page() - Encrypts a page
  * @inode:          The inode for which the encryption should take place
  * @plaintext_page: The page to encrypt. Must be locked.
+ * @gfp_flags:      The gfp flag for memory allocation
  *
  * Allocates a ciphertext page and encrypts plaintext_page into it using the ctx
  * encryption context.
@@ -225,7 +227,7 @@ static struct page *alloc_bounce_page(struct fscrypt_ctx *ctx)
  * error value or NULL.
  */
 struct page *fscrypt_encrypt_page(struct inode *inode,
-				struct page *plaintext_page)
+				struct page *plaintext_page, gfp_t gfp_flags)
 {
 	struct fscrypt_ctx *ctx;
 	struct page *ciphertext_page = NULL;
@@ -233,18 +235,19 @@ struct page *fscrypt_encrypt_page(struct inode *inode,
 
 	BUG_ON(!PageLocked(plaintext_page));
 
-	ctx = fscrypt_get_ctx(inode);
+	ctx = fscrypt_get_ctx(inode, gfp_flags);
 	if (IS_ERR(ctx))
 		return (struct page *)ctx;
 
 	/* The encryption operation will require a bounce page. */
-	ciphertext_page = alloc_bounce_page(ctx);
+	ciphertext_page = alloc_bounce_page(ctx, gfp_flags);
 	if (IS_ERR(ciphertext_page))
 		goto errout;
 
 	ctx->w.control_page = plaintext_page;
 	err = do_page_crypto(inode, FS_ENCRYPT, plaintext_page->index,
-					plaintext_page, ciphertext_page);
+					plaintext_page, ciphertext_page,
+					gfp_flags);
 	if (err) {
 		ciphertext_page = ERR_PTR(err);
 		goto errout;
@@ -275,7 +278,7 @@ int fscrypt_decrypt_page(struct page *page)
 	BUG_ON(!PageLocked(page));
 
 	return do_page_crypto(page->mapping->host,
-			FS_DECRYPT, page->index, page, page);
+			FS_DECRYPT, page->index, page, page, GFP_NOFS);
 }
 EXPORT_SYMBOL(fscrypt_decrypt_page);
 
@@ -289,11 +292,11 @@ int fscrypt_zeroout_range(struct inode *inode, pgoff_t lblk,
 
 	BUG_ON(inode->i_sb->s_blocksize != PAGE_SIZE);
 
-	ctx = fscrypt_get_ctx(inode);
+	ctx = fscrypt_get_ctx(inode, GFP_NOFS);
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 
-	ciphertext_page = alloc_bounce_page(ctx);
+	ciphertext_page = alloc_bounce_page(ctx, GFP_NOWAIT);
 	if (IS_ERR(ciphertext_page)) {
 		err = PTR_ERR(ciphertext_page);
 		goto errout;
@@ -301,11 +304,12 @@ int fscrypt_zeroout_range(struct inode *inode, pgoff_t lblk,
 
 	while (len--) {
 		err = do_page_crypto(inode, FS_ENCRYPT, lblk,
-						ZERO_PAGE(0), ciphertext_page);
+					ZERO_PAGE(0), ciphertext_page,
+					GFP_NOFS);
 		if (err)
 			goto errout;
 
-		bio = bio_alloc(GFP_KERNEL, 1);
+		bio = bio_alloc(GFP_NOWAIT, 1);
 		if (!bio) {
 			err = -ENOMEM;
 			goto errout;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 53fec08..5dafb9c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -992,7 +992,7 @@ submit_and_realloc:
 			if (f2fs_encrypted_inode(inode) &&
 					S_ISREG(inode->i_mode)) {
 
-				ctx = fscrypt_get_ctx(inode);
+				ctx = fscrypt_get_ctx(inode, GFP_NOFS);
 				if (IS_ERR(ctx))
 					goto set_error_page;
 
@@ -1092,14 +1092,24 @@ int do_write_data_page(struct f2fs_io_info *fio)
 	}
 
 	if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode)) {
+		gfp_t gfp_flags = GFP_NOFS;
 
 		/* wait for GCed encrypted page writeback */
 		f2fs_wait_on_encrypted_page_writeback(F2FS_I_SB(inode),
 							fio->old_blkaddr);
-
-		fio->encrypted_page = fscrypt_encrypt_page(inode, fio->page);
+retry_encrypt:
+		fio->encrypted_page = fscrypt_encrypt_page(inode, fio->page,
+								gfp_flags);
 		if (IS_ERR(fio->encrypted_page)) {
 			err = PTR_ERR(fio->encrypted_page);
+			if (err == -ENOMEM) {
+				/* flush pending ios and wait for a while */
+				f2fs_flush_merged_bios(F2FS_I_SB(inode));
+				congestion_wait(BLK_RW_ASYNC, HZ/50);
+				gfp_flags |= __GFP_NOFAIL;
+				err = 0;
+				goto retry_encrypt;
+			}
 			goto out_writepage;
 		}
 	}
diff --git a/include/linux/fscrypto.h b/include/linux/fscrypto.h
index cd91f75..6027f6b 100644
--- a/include/linux/fscrypto.h
+++ b/include/linux/fscrypto.h
@@ -263,9 +263,9 @@ static inline void fscrypt_set_d_op(struct dentry *dentry)
 extern struct kmem_cache *fscrypt_info_cachep;
 int fscrypt_initialize(void);
 
-extern struct fscrypt_ctx *fscrypt_get_ctx(struct inode *);
+extern struct fscrypt_ctx *fscrypt_get_ctx(struct inode *, gfp_t);
 extern void fscrypt_release_ctx(struct fscrypt_ctx *);
-extern struct page *fscrypt_encrypt_page(struct inode *, struct page *);
+extern struct page *fscrypt_encrypt_page(struct inode *, struct page *, gfp_t);
 extern int fscrypt_decrypt_page(struct page *);
 extern void fscrypt_decrypt_bio_pages(struct fscrypt_ctx *, struct bio *);
 extern void fscrypt_pullback_bio_page(struct page **, bool);
@@ -299,7 +299,8 @@ extern int fscrypt_fname_usr_to_disk(struct inode *, const struct qstr *,
 #endif
 
 /* crypto.c */
-static inline struct fscrypt_ctx *fscrypt_notsupp_get_ctx(struct inode *i)
+static inline struct fscrypt_ctx *fscrypt_notsupp_get_ctx(struct inode *i,
+							gfp_t f)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
@@ -310,7 +311,7 @@ static inline void fscrypt_notsupp_release_ctx(struct fscrypt_ctx *c)
 }
 
 static inline struct page *fscrypt_notsupp_encrypt_page(struct inode *i,
-						struct page *p)
+						struct page *p, gfp_t f)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
-- 
2.6.3

