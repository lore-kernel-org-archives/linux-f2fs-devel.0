From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/3 v2] f2fs crypto: use bounce pages from mempool first
Date: Wed, 27 May 2015 21:21:25 -0700
Message-ID: <20150528042125.GA7853@jaegeuk-mac02.mot.com>
References: <1432255225-76792-1-git-send-email-jaegeuk@kernel.org>
 <1432255225-76792-2-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1432255225-76792-2-git-send-email-jaegeuk@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Change log from v1:
 o remain the existing emergecy mempool
 o add a new mempool for writeback pages

>From ab8c49a79c4a6cd0ca1093d5e42cb93b55b35bfd Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Wed, 20 May 2015 19:12:30 -0700
Subject: [PATCH] f2fs crypto: introduce a mempool for bounce pages

If a lot of write streams are triggered, alloc_page and __free_page are
costly called, resulting in high memory pressure.

In order to avoid that, this patch introduces an additional mempool for writeback pages.
Note that, the existing mempool is used for the emergency purpose.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/crypto.c      | 43 +++++++++++++++++++++++++++++++------------
 fs/f2fs/f2fs_crypto.h | 10 +++++++---
 2 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/fs/f2fs/crypto.c b/fs/f2fs/crypto.c
index 2c7819a..e823593 100644
--- a/fs/f2fs/crypto.c
+++ b/fs/f2fs/crypto.c
@@ -48,8 +48,9 @@
 
 /* Encryption added and removed here! (L: */
 
-static unsigned int num_prealloc_crypto_pages = 32;
 static unsigned int num_prealloc_crypto_ctxs = 128;
+static unsigned int num_prealloc_crypto_pages = BIO_MAX_PAGES;
+static unsigned int num_prealloc_emergent_pages = 32;
 
 module_param(num_prealloc_crypto_pages, uint, 0444);
 MODULE_PARM_DESC(num_prealloc_crypto_pages,
@@ -58,7 +59,7 @@ module_param(num_prealloc_crypto_ctxs, uint, 0444);
 MODULE_PARM_DESC(num_prealloc_crypto_ctxs,
 		"Number of crypto contexts to preallocate");
 
-static mempool_t *f2fs_bounce_page_pool;
+static mempool_t *f2fs_bounce_page_pool, *f2fs_emergent_page_pool;
 
 static LIST_HEAD(f2fs_free_crypto_ctxs);
 static DEFINE_SPINLOCK(f2fs_crypto_ctx_lock);
@@ -83,10 +84,13 @@ void f2fs_release_crypto_ctx(struct f2fs_crypto_ctx *ctx)
 	unsigned long flags;
 
 	if (ctx->flags & F2FS_WRITE_PATH_FL && ctx->w.bounce_page) {
-		if (ctx->flags & F2FS_BOUNCE_PAGE_REQUIRES_FREE_ENCRYPT_FL)
-			__free_page(ctx->w.bounce_page);
-		else
+		if (ctx->flags & F2FS_BOUNCE_PAGE_POOL_FREE_ENCRYPT_FL)
 			mempool_free(ctx->w.bounce_page, f2fs_bounce_page_pool);
+		else if (ctx->flags & F2FS_EMERGENT_PAGE_POOL_FREE_ENCRYPT_FL)
+			mempool_free(ctx->w.bounce_page,
+					f2fs_emergent_page_pool);
+		else
+			__free_page(ctx->w.bounce_page);
 		ctx->w.bounce_page = NULL;
 	}
 	ctx->w.control_page = NULL;
@@ -189,6 +193,9 @@ static void f2fs_crypto_destroy(void)
 	if (f2fs_bounce_page_pool)
 		mempool_destroy(f2fs_bounce_page_pool);
 	f2fs_bounce_page_pool = NULL;
+	if (f2fs_emergent_page_pool)
+		mempool_destroy(f2fs_emergent_page_pool);
+	f2fs_emergent_page_pool = NULL;
 }
 
 /**
@@ -225,6 +232,11 @@ int f2fs_crypto_initialize(void)
 	if (!f2fs_bounce_page_pool)
 		goto fail;
 
+	f2fs_emergent_page_pool =
+		mempool_create_page_pool(num_prealloc_emergent_pages, 0);
+	if (!f2fs_emergent_page_pool)
+		goto fail;
+
 already_initialized:
 	mutex_unlock(&crypto_init);
 	return 0;
@@ -408,21 +420,28 @@ struct page *f2fs_encrypt(struct inode *inode,
 		return (struct page *)ctx;
 
 	/* The encryption operation will require a bounce page. */
+	ctx->flags &= ~F2FS_MASK_PAGE_POOL_FREE_ENCRYPT_FL;
+
+	ciphertext_page = mempool_alloc(f2fs_bounce_page_pool, GFP_NOFS);
+	if (ciphertext_page) {
+		ctx->flags |= F2FS_BOUNCE_PAGE_POOL_FREE_ENCRYPT_FL;
+		goto got_it;
+	}
+
 	ciphertext_page = alloc_page(GFP_NOFS);
 	if (!ciphertext_page) {
 		/*
 		 * This is a potential bottleneck, but at least we'll have
 		 * forward progress.
 		 */
-		ciphertext_page = mempool_alloc(f2fs_bounce_page_pool,
-							GFP_NOFS);
+		ciphertext_page = mempool_alloc(f2fs_emergent_page_pool,
+								GFP_NOFS);
 		if (WARN_ON_ONCE(!ciphertext_page))
-			ciphertext_page = mempool_alloc(f2fs_bounce_page_pool,
-						GFP_NOFS | __GFP_WAIT);
-		ctx->flags &= ~F2FS_BOUNCE_PAGE_REQUIRES_FREE_ENCRYPT_FL;
-	} else {
-		ctx->flags |= F2FS_BOUNCE_PAGE_REQUIRES_FREE_ENCRYPT_FL;
+			ciphertext_page = mempool_alloc(f2fs_emergent_page_pool,
+						GFP_NOFS | __GFP_NOFAIL);
+		ctx->flags |= F2FS_EMERGENT_PAGE_POOL_FREE_ENCRYPT_FL;
 	}
+got_it:
 	ctx->flags |= F2FS_WRITE_PATH_FL;
 	ctx->w.bounce_page = ciphertext_page;
 	ctx->w.control_page = plaintext_page;
diff --git a/fs/f2fs/f2fs_crypto.h b/fs/f2fs/f2fs_crypto.h
index be59d91..5b05a53 100644
--- a/fs/f2fs/f2fs_crypto.h
+++ b/fs/f2fs/f2fs_crypto.h
@@ -83,9 +83,13 @@ struct f2fs_crypt_info {
 	char		ci_master_key[F2FS_KEY_DESCRIPTOR_SIZE];
 };
 
-#define F2FS_CTX_REQUIRES_FREE_ENCRYPT_FL             0x00000001
-#define F2FS_BOUNCE_PAGE_REQUIRES_FREE_ENCRYPT_FL     0x00000002
-#define F2FS_WRITE_PATH_FL			      0x00000004
+#define F2FS_CTX_REQUIRES_FREE_ENCRYPT_FL		0x00000001
+#define F2FS_WRITE_PATH_FL				0x00000002
+#define F2FS_BOUNCE_PAGE_POOL_FREE_ENCRYPT_FL		0x00000004
+#define F2FS_EMERGENT_PAGE_POOL_FREE_ENCRYPT_FL		0x00000008
+#define F2FS_MASK_PAGE_POOL_FREE_ENCRYPT_FL				\
+		(F2FS_BOUNCE_PAGE_POOL_FREE_ENCRYPT_FL |		\
+		F2FS_EMERGENT_PAGE_POOL_FREE_ENCRYPT_FL)
 
 struct f2fs_crypto_ctx {
 	union {
-- 
2.1.1

