From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/6] f2fs crypto: use slab caches
Date: Tue, 12 May 2015 17:40:31 -0700
Message-ID: <1431477634-48111-3-git-send-email-jaegeuk@kernel.org>
References: <1431477634-48111-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431477634-48111-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Theodore Ts'o <tytso@mit.edu>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch integrates the below patch into f2fs.

"ext4 crypto: use slab caches

Use slab caches the ext4_crypto_ctx and ext4_crypt_info structures for
slighly better memory efficiency and debuggability."

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/crypto.c     | 58 ++++++++++++++++++++++++++--------------------------
 fs/f2fs/crypto_key.c |  6 +++---
 fs/f2fs/f2fs.h       |  1 +
 3 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/fs/f2fs/crypto.c b/fs/f2fs/crypto.c
index 64c4139..5491d1e 100644
--- a/fs/f2fs/crypto.c
+++ b/fs/f2fs/crypto.c
@@ -66,6 +66,9 @@ static DEFINE_SPINLOCK(f2fs_crypto_ctx_lock);
 static struct workqueue_struct *f2fs_read_workqueue;
 static DEFINE_MUTEX(crypto_init);
 
+static struct kmem_cache *f2fs_crypto_ctx_cachep;
+struct kmem_cache *f2fs_crypt_info_cachep;
+
 /**
  * f2fs_release_crypto_ctx() - Releases an encryption context
  * @ctx: The encryption context to release.
@@ -90,7 +93,7 @@ void f2fs_release_crypto_ctx(struct f2fs_crypto_ctx *ctx)
 	if (ctx->flags & F2FS_CTX_REQUIRES_FREE_ENCRYPT_FL) {
 		if (ctx->tfm)
 			crypto_free_tfm(ctx->tfm);
-		kfree(ctx);
+		kmem_cache_free(f2fs_crypto_ctx_cachep, ctx);
 	} else {
 		spin_lock_irqsave(&f2fs_crypto_ctx_lock, flags);
 		list_add(&ctx->free_list, &f2fs_free_crypto_ctxs);
@@ -99,23 +102,6 @@ void f2fs_release_crypto_ctx(struct f2fs_crypto_ctx *ctx)
 }
 
 /**
- * f2fs_alloc_and_init_crypto_ctx() - Allocates and inits an encryption context
- * @mask: The allocation mask.
- *
- * Return: An allocated and initialized encryption context on success. An error
- * value or NULL otherwise.
- */
-static struct f2fs_crypto_ctx *f2fs_alloc_and_init_crypto_ctx(gfp_t mask)
-{
-	struct f2fs_crypto_ctx *ctx = kzalloc(sizeof(struct f2fs_crypto_ctx),
-						mask);
-
-	if (!ctx)
-		return ERR_PTR(-ENOMEM);
-	return ctx;
-}
-
-/**
  * f2fs_get_crypto_ctx() - Gets an encryption context
  * @inode:       The inode for which we are doing the crypto
  *
@@ -151,9 +137,9 @@ struct f2fs_crypto_ctx *f2fs_get_crypto_ctx(struct inode *inode)
 		list_del(&ctx->free_list);
 	spin_unlock_irqrestore(&f2fs_crypto_ctx_lock, flags);
 	if (!ctx) {
-		ctx = f2fs_alloc_and_init_crypto_ctx(GFP_NOFS);
-		if (IS_ERR(ctx)) {
-			res = PTR_ERR(ctx);
+		ctx = kmem_cache_zalloc(f2fs_crypto_ctx_cachep, GFP_NOFS);
+		if (!ctx) {
+			res = -ENOMEM;
 			goto out;
 		}
 		ctx->flags |= F2FS_CTX_REQUIRES_FREE_ENCRYPT_FL;
@@ -263,7 +249,7 @@ void f2fs_exit_crypto(void)
 		}
 		if (pos->tfm)
 			crypto_free_tfm(pos->tfm);
-		kfree(pos);
+		kmem_cache_free(f2fs_crypto_ctx_cachep, pos);
 	}
 	INIT_LIST_HEAD(&f2fs_free_crypto_ctxs);
 	if (f2fs_bounce_page_pool)
@@ -272,6 +258,12 @@ void f2fs_exit_crypto(void)
 	if (f2fs_read_workqueue)
 		destroy_workqueue(f2fs_read_workqueue);
 	f2fs_read_workqueue = NULL;
+	if (f2fs_crypto_ctx_cachep)
+		kmem_cache_destroy(f2fs_crypto_ctx_cachep);
+	f2fs_crypto_ctx_cachep = NULL;
+	if (f2fs_crypt_info_cachep)
+		kmem_cache_destroy(f2fs_crypt_info_cachep);
+	f2fs_crypt_info_cachep = NULL;
 }
 
 /**
@@ -284,24 +276,32 @@ void f2fs_exit_crypto(void)
  */
 int __init f2fs_init_crypto(void)
 {
-	int i, res;
+	int i, res = -ENOMEM;
 
 	mutex_lock(&crypto_init);
 	if (f2fs_read_workqueue)
 		goto already_initialized;
 
 	f2fs_read_workqueue = alloc_workqueue("f2fs_crypto", WQ_HIGHPRI, 0);
-	if (!f2fs_read_workqueue) {
-		res = -ENOMEM;
+	if (!f2fs_read_workqueue)
+		goto fail;
+
+	f2fs_crypto_ctx_cachep = KMEM_CACHE(f2fs_crypto_ctx,
+					    SLAB_RECLAIM_ACCOUNT);
+	if (!f2fs_crypto_ctx_cachep)
+		goto fail;
+
+	f2fs_crypt_info_cachep = KMEM_CACHE(f2fs_crypt_info,
+					    SLAB_RECLAIM_ACCOUNT);
+	if (!f2fs_crypt_info_cachep)
 		goto fail;
-	}
 
 	for (i = 0; i < num_prealloc_crypto_ctxs; i++) {
 		struct f2fs_crypto_ctx *ctx;
 
-		ctx = f2fs_alloc_and_init_crypto_ctx(GFP_KERNEL);
-		if (IS_ERR(ctx)) {
-			res = PTR_ERR(ctx);
+		ctx = kmem_cache_zalloc(f2fs_crypto_ctx_cachep, GFP_KERNEL);
+		if (!ctx) {
+			res = -ENOMEM;
 			goto fail;
 		}
 		list_add(&ctx->free_list, &f2fs_free_crypto_ctxs);
diff --git a/fs/f2fs/crypto_key.c b/fs/f2fs/crypto_key.c
index aec7e17..2bdcae5 100644
--- a/fs/f2fs/crypto_key.c
+++ b/fs/f2fs/crypto_key.c
@@ -99,7 +99,7 @@ void f2fs_free_encryption_info(struct inode *inode)
 		key_put(ci->ci_keyring_key);
 	crypto_free_ablkcipher(ci->ci_ctfm);
 	memzero_explicit(&ci->ci_raw, sizeof(ci->ci_raw));
-	kfree(ci);
+	kmem_cache_free(f2fs_crypt_info_cachep, ci);
 	fi->i_crypt_info = NULL;
 }
 
@@ -131,7 +131,7 @@ int _f2fs_get_encryption_info(struct inode *inode)
 		return -EINVAL;
 	res = 0;
 
-	crypt_info = kmalloc(sizeof(struct f2fs_crypt_info), GFP_NOFS);
+	crypt_info = kmem_cache_alloc(f2fs_crypt_info_cachep, GFP_NOFS);
 	if (!crypt_info)
 		return -ENOMEM;
 
@@ -181,7 +181,7 @@ out:
 	if (res < 0) {
 		if (res == -ENOKEY)
 			res = 0;
-		kfree(crypt_info);
+		kmem_cache_free(f2fs_crypt_info_cachep, crypt_info);
 	} else {
 		fi->i_crypt_info = crypt_info;
 		crypt_info->ci_keyring_key = keyring_key;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5809590..8f1f21a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2004,6 +2004,7 @@ int f2fs_process_policy(const struct f2fs_encryption_policy *, struct inode *);
 int f2fs_get_policy(struct inode *, struct f2fs_encryption_policy *);
 
 /* crypt.c */
+extern struct kmem_cache *f2fs_crypt_info_cachep;
 bool f2fs_valid_contents_enc_mode(uint32_t);
 uint32_t f2fs_validate_encryption_key_size(uint32_t, uint32_t);
 struct f2fs_crypto_ctx *f2fs_get_crypto_ctx(struct inode *);
-- 
2.1.1
