From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 7/8] f2fs crypto: migrate into vfs's crypto engine
Date: Mon, 15 Feb 2016 18:13:11 -0800
Message-ID: <1455588792-87825-7-git-send-email-jaegeuk@kernel.org>
References: <1455588792-87825-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aVVAl-0004ek-Pz
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 16 Feb 2016 02:15:27 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aVVAg-00028F-QP
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 16 Feb 2016 02:15:27 +0000
In-Reply-To: <1455588792-87825-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, tytso@mit.edu
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch removes the most parts of internal crypto codes.
And then, it modifies some f2fs-specific crypt codes to use the generic
facility.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/Kconfig         |  10 +-
 fs/f2fs/Makefile        |   2 -
 fs/f2fs/crypto.c        | 473 ------------------------------------------------
 fs/f2fs/crypto_fname.c  | 446 ---------------------------------------------
 fs/f2fs/crypto_key.c    | 267 ---------------------------
 fs/f2fs/crypto_policy.c | 210 ---------------------
 fs/f2fs/data.c          |  31 ++--
 fs/f2fs/dir.c           |  46 ++---
 fs/f2fs/f2fs.h          | 151 +---------------
 fs/f2fs/f2fs_crypto.h   | 151 ----------------
 fs/f2fs/file.c          |  36 ++--
 fs/f2fs/inline.c        |   4 +-
 fs/f2fs/inode.c         |   5 +-
 fs/f2fs/namei.c         |  56 +++---
 fs/f2fs/super.c         |  55 ++++--
 15 files changed, 127 insertions(+), 1816 deletions(-)
 delete mode 100644 fs/f2fs/crypto.c
 delete mode 100644 fs/f2fs/crypto_fname.c
 delete mode 100644 fs/f2fs/crypto_key.c
 delete mode 100644 fs/f2fs/crypto_policy.c
 delete mode 100644 fs/f2fs/f2fs_crypto.h

diff --git a/fs/f2fs/Kconfig b/fs/f2fs/Kconfig
index b0a9dc9..e7fbde6 100644
--- a/fs/f2fs/Kconfig
+++ b/fs/f2fs/Kconfig
@@ -76,15 +76,7 @@ config F2FS_FS_ENCRYPTION
 	bool "F2FS Encryption"
 	depends on F2FS_FS
 	depends on F2FS_FS_XATTR
-	select CRYPTO_AES
-	select CRYPTO_CBC
-	select CRYPTO_ECB
-	select CRYPTO_XTS
-	select CRYPTO_CTS
-	select CRYPTO_CTR
-	select CRYPTO_SHA256
-	select KEYS
-	select ENCRYPTED_KEYS
+	depends on FS_ENCRYPTION
 	help
 	  Enable encryption of f2fs files and directories.  This
 	  feature is similar to ecryptfs, but it is more memory
diff --git a/fs/f2fs/Makefile b/fs/f2fs/Makefile
index 08e101e..ca949ea 100644
--- a/fs/f2fs/Makefile
+++ b/fs/f2fs/Makefile
@@ -7,5 +7,3 @@ f2fs-$(CONFIG_F2FS_STAT_FS) += debug.o
 f2fs-$(CONFIG_F2FS_FS_XATTR) += xattr.o
 f2fs-$(CONFIG_F2FS_FS_POSIX_ACL) += acl.o
 f2fs-$(CONFIG_F2FS_IO_TRACE) += trace.o
-f2fs-$(CONFIG_F2FS_FS_ENCRYPTION) += crypto_policy.o crypto.o \
-		crypto_key.o crypto_fname.o
diff --git a/fs/f2fs/crypto.c b/fs/f2fs/crypto.c
deleted file mode 100644
index 3ef3786..0000000
--- a/fs/f2fs/crypto.c
+++ /dev/null
@@ -1,473 +0,0 @@
-/*
- * linux/fs/f2fs/crypto.c
- *
- * Copied from linux/fs/ext4/crypto.c
- *
- * Copyright (C) 2015, Google, Inc.
- * Copyright (C) 2015, Motorola Mobility
- *
- * This contains encryption functions for f2fs
- *
- * Written by Michael Halcrow, 2014.
- *
- * Filename encryption additions
- *	Uday Savagaonkar, 2014
- * Encryption policy handling additions
- *	Ildar Muslukhov, 2014
- * Remove ext4_encrypted_zeroout(),
- *   add f2fs_restore_and_release_control_page()
- *	Jaegeuk Kim, 2015.
- *
- * This has not yet undergone a rigorous security audit.
- *
- * The usage of AES-XTS should conform to recommendations in NIST
- * Special Publication 800-38E and IEEE P1619/D16.
- */
-#include <crypto/hash.h>
-#include <crypto/sha.h>
-#include <keys/user-type.h>
-#include <keys/encrypted-type.h>
-#include <linux/crypto.h>
-#include <linux/ecryptfs.h>
-#include <linux/gfp.h>
-#include <linux/kernel.h>
-#include <linux/key.h>
-#include <linux/list.h>
-#include <linux/mempool.h>
-#include <linux/module.h>
-#include <linux/mutex.h>
-#include <linux/random.h>
-#include <linux/scatterlist.h>
-#include <linux/spinlock_types.h>
-#include <linux/f2fs_fs.h>
-#include <linux/ratelimit.h>
-#include <linux/bio.h>
-
-#include "f2fs.h"
-#include "xattr.h"
-
-/* Encryption added and removed here! (L: */
-
-static unsigned int num_prealloc_crypto_pages = 32;
-static unsigned int num_prealloc_crypto_ctxs = 128;
-
-module_param(num_prealloc_crypto_pages, uint, 0444);
-MODULE_PARM_DESC(num_prealloc_crypto_pages,
-		"Number of crypto pages to preallocate");
-module_param(num_prealloc_crypto_ctxs, uint, 0444);
-MODULE_PARM_DESC(num_prealloc_crypto_ctxs,
-		"Number of crypto contexts to preallocate");
-
-static mempool_t *f2fs_bounce_page_pool;
-
-static LIST_HEAD(f2fs_free_crypto_ctxs);
-static DEFINE_SPINLOCK(f2fs_crypto_ctx_lock);
-
-static struct workqueue_struct *f2fs_read_workqueue;
-static DEFINE_MUTEX(crypto_init);
-
-static struct kmem_cache *f2fs_crypto_ctx_cachep;
-struct kmem_cache *f2fs_crypt_info_cachep;
-
-/**
- * f2fs_release_crypto_ctx() - Releases an encryption context
- * @ctx: The encryption context to release.
- *
- * If the encryption context was allocated from the pre-allocated pool, returns
- * it to that pool. Else, frees it.
- *
- * If there's a bounce page in the context, this frees that.
- */
-void f2fs_release_crypto_ctx(struct f2fs_crypto_ctx *ctx)
-{
-	unsigned long flags;
-
-	if (ctx->flags & F2FS_WRITE_PATH_FL && ctx->w.bounce_page) {
-		mempool_free(ctx->w.bounce_page, f2fs_bounce_page_pool);
-		ctx->w.bounce_page = NULL;
-	}
-	ctx->w.control_page = NULL;
-	if (ctx->flags & F2FS_CTX_REQUIRES_FREE_ENCRYPT_FL) {
-		kmem_cache_free(f2fs_crypto_ctx_cachep, ctx);
-	} else {
-		spin_lock_irqsave(&f2fs_crypto_ctx_lock, flags);
-		list_add(&ctx->free_list, &f2fs_free_crypto_ctxs);
-		spin_unlock_irqrestore(&f2fs_crypto_ctx_lock, flags);
-	}
-}
-
-/**
- * f2fs_get_crypto_ctx() - Gets an encryption context
- * @inode:       The inode for which we are doing the crypto
- *
- * Allocates and initializes an encryption context.
- *
- * Return: An allocated and initialized encryption context on success; error
- * value or NULL otherwise.
- */
-struct f2fs_crypto_ctx *f2fs_get_crypto_ctx(struct inode *inode)
-{
-	struct f2fs_crypto_ctx *ctx = NULL;
-	unsigned long flags;
-	struct f2fs_crypt_info *ci = F2FS_I(inode)->i_crypt_info;
-
-	if (ci == NULL)
-		return ERR_PTR(-ENOKEY);
-
-	/*
-	 * We first try getting the ctx from a free list because in
-	 * the common case the ctx will have an allocated and
-	 * initialized crypto tfm, so it's probably a worthwhile
-	 * optimization. For the bounce page, we first try getting it
-	 * from the kernel allocator because that's just about as fast
-	 * as getting it from a list and because a cache of free pages
-	 * should generally be a "last resort" option for a filesystem
-	 * to be able to do its job.
-	 */
-	spin_lock_irqsave(&f2fs_crypto_ctx_lock, flags);
-	ctx = list_first_entry_or_null(&f2fs_free_crypto_ctxs,
-					struct f2fs_crypto_ctx, free_list);
-	if (ctx)
-		list_del(&ctx->free_list);
-	spin_unlock_irqrestore(&f2fs_crypto_ctx_lock, flags);
-	if (!ctx) {
-		ctx = kmem_cache_zalloc(f2fs_crypto_ctx_cachep, GFP_NOFS);
-		if (!ctx)
-			return ERR_PTR(-ENOMEM);
-		ctx->flags |= F2FS_CTX_REQUIRES_FREE_ENCRYPT_FL;
-	} else {
-		ctx->flags &= ~F2FS_CTX_REQUIRES_FREE_ENCRYPT_FL;
-	}
-	ctx->flags &= ~F2FS_WRITE_PATH_FL;
-	return ctx;
-}
-
-/*
- * Call f2fs_decrypt on every single page, reusing the encryption
- * context.
- */
-static void completion_pages(struct work_struct *work)
-{
-	struct f2fs_crypto_ctx *ctx =
-		container_of(work, struct f2fs_crypto_ctx, r.work);
-	struct bio *bio = ctx->r.bio;
-	struct bio_vec *bv;
-	int i;
-
-	bio_for_each_segment_all(bv, bio, i) {
-		struct page *page = bv->bv_page;
-		int ret = f2fs_decrypt(page);
-
-		if (ret) {
-			WARN_ON_ONCE(1);
-			SetPageError(page);
-		} else
-			SetPageUptodate(page);
-		unlock_page(page);
-	}
-	f2fs_release_crypto_ctx(ctx);
-	bio_put(bio);
-}
-
-void f2fs_end_io_crypto_work(struct f2fs_crypto_ctx *ctx, struct bio *bio)
-{
-	INIT_WORK(&ctx->r.work, completion_pages);
-	ctx->r.bio = bio;
-	queue_work(f2fs_read_workqueue, &ctx->r.work);
-}
-
-static void f2fs_crypto_destroy(void)
-{
-	struct f2fs_crypto_ctx *pos, *n;
-
-	list_for_each_entry_safe(pos, n, &f2fs_free_crypto_ctxs, free_list)
-		kmem_cache_free(f2fs_crypto_ctx_cachep, pos);
-	INIT_LIST_HEAD(&f2fs_free_crypto_ctxs);
-	if (f2fs_bounce_page_pool)
-		mempool_destroy(f2fs_bounce_page_pool);
-	f2fs_bounce_page_pool = NULL;
-}
-
-/**
- * f2fs_crypto_initialize() - Set up for f2fs encryption.
- *
- * We only call this when we start accessing encrypted files, since it
- * results in memory getting allocated that wouldn't otherwise be used.
- *
- * Return: Zero on success, non-zero otherwise.
- */
-int f2fs_crypto_initialize(void)
-{
-	int i, res = -ENOMEM;
-
-	if (f2fs_bounce_page_pool)
-		return 0;
-
-	mutex_lock(&crypto_init);
-	if (f2fs_bounce_page_pool)
-		goto already_initialized;
-
-	for (i = 0; i < num_prealloc_crypto_ctxs; i++) {
-		struct f2fs_crypto_ctx *ctx;
-
-		ctx = kmem_cache_zalloc(f2fs_crypto_ctx_cachep, GFP_KERNEL);
-		if (!ctx)
-			goto fail;
-		list_add(&ctx->free_list, &f2fs_free_crypto_ctxs);
-	}
-
-	/* must be allocated at the last step to avoid race condition above */
-	f2fs_bounce_page_pool =
-		mempool_create_page_pool(num_prealloc_crypto_pages, 0);
-	if (!f2fs_bounce_page_pool)
-		goto fail;
-
-already_initialized:
-	mutex_unlock(&crypto_init);
-	return 0;
-fail:
-	f2fs_crypto_destroy();
-	mutex_unlock(&crypto_init);
-	return res;
-}
-
-/**
- * f2fs_exit_crypto() - Shutdown the f2fs encryption system
- */
-void f2fs_exit_crypto(void)
-{
-	f2fs_crypto_destroy();
-
-	if (f2fs_read_workqueue)
-		destroy_workqueue(f2fs_read_workqueue);
-	if (f2fs_crypto_ctx_cachep)
-		kmem_cache_destroy(f2fs_crypto_ctx_cachep);
-	if (f2fs_crypt_info_cachep)
-		kmem_cache_destroy(f2fs_crypt_info_cachep);
-}
-
-int __init f2fs_init_crypto(void)
-{
-	int res = -ENOMEM;
-
-	f2fs_read_workqueue = alloc_workqueue("f2fs_crypto", WQ_HIGHPRI, 0);
-	if (!f2fs_read_workqueue)
-		goto fail;
-
-	f2fs_crypto_ctx_cachep = KMEM_CACHE(f2fs_crypto_ctx,
-						SLAB_RECLAIM_ACCOUNT);
-	if (!f2fs_crypto_ctx_cachep)
-		goto fail;
-
-	f2fs_crypt_info_cachep = KMEM_CACHE(f2fs_crypt_info,
-						SLAB_RECLAIM_ACCOUNT);
-	if (!f2fs_crypt_info_cachep)
-		goto fail;
-
-	return 0;
-fail:
-	f2fs_exit_crypto();
-	return res;
-}
-
-void f2fs_restore_and_release_control_page(struct page **page)
-{
-	struct f2fs_crypto_ctx *ctx;
-	struct page *bounce_page;
-
-	/* The bounce data pages are unmapped. */
-	if ((*page)->mapping)
-		return;
-
-	/* The bounce data page is unmapped. */
-	bounce_page = *page;
-	ctx = (struct f2fs_crypto_ctx *)page_private(bounce_page);
-
-	/* restore control page */
-	*page = ctx->w.control_page;
-
-	f2fs_restore_control_page(bounce_page);
-}
-
-void f2fs_restore_control_page(struct page *data_page)
-{
-	struct f2fs_crypto_ctx *ctx =
-		(struct f2fs_crypto_ctx *)page_private(data_page);
-
-	set_page_private(data_page, (unsigned long)NULL);
-	ClearPagePrivate(data_page);
-	unlock_page(data_page);
-	f2fs_release_crypto_ctx(ctx);
-}
-
-/**
- * f2fs_crypt_complete() - The completion callback for page encryption
- * @req: The asynchronous encryption request context
- * @res: The result of the encryption operation
- */
-static void f2fs_crypt_complete(struct crypto_async_request *req, int res)
-{
-	struct f2fs_completion_result *ecr = req->data;
-
-	if (res == -EINPROGRESS)
-		return;
-	ecr->res = res;
-	complete(&ecr->completion);
-}
-
-typedef enum {
-	F2FS_DECRYPT = 0,
-	F2FS_ENCRYPT,
-} f2fs_direction_t;
-
-static int f2fs_page_crypto(struct inode *inode,
-				f2fs_direction_t rw,
-				pgoff_t index,
-				struct page *src_page,
-				struct page *dest_page)
-{
-	u8 xts_tweak[F2FS_XTS_TWEAK_SIZE];
-	struct ablkcipher_request *req = NULL;
-	DECLARE_F2FS_COMPLETION_RESULT(ecr);
-	struct scatterlist dst, src;
-	struct f2fs_crypt_info *ci = F2FS_I(inode)->i_crypt_info;
-	struct crypto_ablkcipher *tfm = ci->ci_ctfm;
-	int res = 0;
-
-	req = ablkcipher_request_alloc(tfm, GFP_NOFS);
-	if (!req) {
-		printk_ratelimited(KERN_ERR
-				"%s: crypto_request_alloc() failed\n",
-				__func__);
-		return -ENOMEM;
-	}
-	ablkcipher_request_set_callback(
-		req, CRYPTO_TFM_REQ_MAY_BACKLOG | CRYPTO_TFM_REQ_MAY_SLEEP,
-		f2fs_crypt_complete, &ecr);
-
-	BUILD_BUG_ON(F2FS_XTS_TWEAK_SIZE < sizeof(index));
-	memcpy(xts_tweak, &index, sizeof(index));
-	memset(&xts_tweak[sizeof(index)], 0,
-			F2FS_XTS_TWEAK_SIZE - sizeof(index));
-
-	sg_init_table(&dst, 1);
-	sg_set_page(&dst, dest_page, PAGE_CACHE_SIZE, 0);
-	sg_init_table(&src, 1);
-	sg_set_page(&src, src_page, PAGE_CACHE_SIZE, 0);
-	ablkcipher_request_set_crypt(req, &src, &dst, PAGE_CACHE_SIZE,
-					xts_tweak);
-	if (rw == F2FS_DECRYPT)
-		res = crypto_ablkcipher_decrypt(req);
-	else
-		res = crypto_ablkcipher_encrypt(req);
-	if (res == -EINPROGRESS || res == -EBUSY) {
-		wait_for_completion(&ecr.completion);
-		res = ecr.res;
-	}
-	ablkcipher_request_free(req);
-	if (res) {
-		printk_ratelimited(KERN_ERR
-			"%s: crypto_ablkcipher_encrypt() returned %d\n",
-			__func__, res);
-		return res;
-	}
-	return 0;
-}
-
-static struct page *alloc_bounce_page(struct f2fs_crypto_ctx *ctx)
-{
-	ctx->w.bounce_page = mempool_alloc(f2fs_bounce_page_pool, GFP_NOWAIT);
-	if (ctx->w.bounce_page == NULL)
-		return ERR_PTR(-ENOMEM);
-	ctx->flags |= F2FS_WRITE_PATH_FL;
-	return ctx->w.bounce_page;
-}
-
-/**
- * f2fs_encrypt() - Encrypts a page
- * @inode:          The inode for which the encryption should take place
- * @plaintext_page: The page to encrypt. Must be locked.
- *
- * Allocates a ciphertext page and encrypts plaintext_page into it using the ctx
- * encryption context.
- *
- * Called on the page write path.  The caller must call
- * f2fs_restore_control_page() on the returned ciphertext page to
- * release the bounce buffer and the encryption context.
- *
- * Return: An allocated page with the encrypted content on success. Else, an
- * error value or NULL.
- */
-struct page *f2fs_encrypt(struct inode *inode,
-			  struct page *plaintext_page)
-{
-	struct f2fs_crypto_ctx *ctx;
-	struct page *ciphertext_page = NULL;
-	int err;
-
-	BUG_ON(!PageLocked(plaintext_page));
-
-	ctx = f2fs_get_crypto_ctx(inode);
-	if (IS_ERR(ctx))
-		return (struct page *)ctx;
-
-	/* The encryption operation will require a bounce page. */
-	ciphertext_page = alloc_bounce_page(ctx);
-	if (IS_ERR(ciphertext_page))
-		goto err_out;
-
-	ctx->w.control_page = plaintext_page;
-	err = f2fs_page_crypto(inode, F2FS_ENCRYPT, plaintext_page->index,
-					plaintext_page, ciphertext_page);
-	if (err) {
-		ciphertext_page = ERR_PTR(err);
-		goto err_out;
-	}
-
-	SetPagePrivate(ciphertext_page);
-	set_page_private(ciphertext_page, (unsigned long)ctx);
-	lock_page(ciphertext_page);
-	return ciphertext_page;
-
-err_out:
-	f2fs_release_crypto_ctx(ctx);
-	return ciphertext_page;
-}
-
-/**
- * f2fs_decrypt() - Decrypts a page in-place
- * @ctx:  The encryption context.
- * @page: The page to decrypt. Must be locked.
- *
- * Decrypts page in-place using the ctx encryption context.
- *
- * Called from the read completion callback.
- *
- * Return: Zero on success, non-zero otherwise.
- */
-int f2fs_decrypt(struct page *page)
-{
-	BUG_ON(!PageLocked(page));
-
-	return f2fs_page_crypto(page->mapping->host,
-				F2FS_DECRYPT, page->index, page, page);
-}
-
-bool f2fs_valid_contents_enc_mode(uint32_t mode)
-{
-	return (mode == F2FS_ENCRYPTION_MODE_AES_256_XTS);
-}
-
-/**
- * f2fs_validate_encryption_key_size() - Validate the encryption key size
- * @mode: The key mode.
- * @size: The key size to validate.
- *
- * Return: The validated key size for @mode. Zero if invalid.
- */
-uint32_t f2fs_validate_encryption_key_size(uint32_t mode, uint32_t size)
-{
-	if (size == f2fs_encryption_key_size(mode))
-		return size;
-	return 0;
-}
diff --git a/fs/f2fs/crypto_fname.c b/fs/f2fs/crypto_fname.c
deleted file mode 100644
index 6dfdc97..0000000
--- a/fs/f2fs/crypto_fname.c
+++ /dev/null
@@ -1,446 +0,0 @@
-/*
- * linux/fs/f2fs/crypto_fname.c
- *
- * Copied from linux/fs/ext4/crypto.c
- *
- * Copyright (C) 2015, Google, Inc.
- * Copyright (C) 2015, Motorola Mobility
- *
- * This contains functions for filename crypto management in f2fs
- *
- * Written by Uday Savagaonkar, 2014.
- *
- * Adjust f2fs dentry structure
- *	Jaegeuk Kim, 2015.
- *
- * This has not yet undergone a rigorous security audit.
- */
-#include <crypto/hash.h>
-#include <crypto/sha.h>
-#include <keys/encrypted-type.h>
-#include <keys/user-type.h>
-#include <linux/crypto.h>
-#include <linux/gfp.h>
-#include <linux/kernel.h>
-#include <linux/key.h>
-#include <linux/list.h>
-#include <linux/mempool.h>
-#include <linux/random.h>
-#include <linux/scatterlist.h>
-#include <linux/spinlock_types.h>
-#include <linux/f2fs_fs.h>
-#include <linux/ratelimit.h>
-
-#include "f2fs.h"
-#include "f2fs_crypto.h"
-#include "xattr.h"
-
-/**
- * f2fs_dir_crypt_complete() -
- */
-static void f2fs_dir_crypt_complete(struct crypto_async_request *req, int res)
-{
-	struct f2fs_completion_result *ecr = req->data;
-
-	if (res == -EINPROGRESS)
-		return;
-	ecr->res = res;
-	complete(&ecr->completion);
-}
-
-bool f2fs_valid_filenames_enc_mode(uint32_t mode)
-{
-	return (mode == F2FS_ENCRYPTION_MODE_AES_256_CTS);
-}
-
-static unsigned max_name_len(struct inode *inode)
-{
-	return S_ISLNK(inode->i_mode) ? inode->i_sb->s_blocksize :
-					F2FS_NAME_LEN;
-}
-
-/**
- * f2fs_fname_encrypt() -
- *
- * This function encrypts the input filename, and returns the length of the
- * ciphertext. Errors are returned as negative numbers.  We trust the caller to
- * allocate sufficient memory to oname string.
- */
-static int f2fs_fname_encrypt(struct inode *inode,
-			const struct qstr *iname, struct f2fs_str *oname)
-{
-	u32 ciphertext_len;
-	struct ablkcipher_request *req = NULL;
-	DECLARE_F2FS_COMPLETION_RESULT(ecr);
-	struct f2fs_crypt_info *ci = F2FS_I(inode)->i_crypt_info;
-	struct crypto_ablkcipher *tfm = ci->ci_ctfm;
-	int res = 0;
-	char iv[F2FS_CRYPTO_BLOCK_SIZE];
-	struct scatterlist src_sg, dst_sg;
-	int padding = 4 << (ci->ci_flags & F2FS_POLICY_FLAGS_PAD_MASK);
-	char *workbuf, buf[32], *alloc_buf = NULL;
-	unsigned lim = max_name_len(inode);
-
-	if (iname->len <= 0 || iname->len > lim)
-		return -EIO;
-
-	ciphertext_len = (iname->len < F2FS_CRYPTO_BLOCK_SIZE) ?
-		F2FS_CRYPTO_BLOCK_SIZE : iname->len;
-	ciphertext_len = f2fs_fname_crypto_round_up(ciphertext_len, padding);
-	ciphertext_len = (ciphertext_len > lim) ? lim : ciphertext_len;
-
-	if (ciphertext_len <= sizeof(buf)) {
-		workbuf = buf;
-	} else {
-		alloc_buf = kmalloc(ciphertext_len, GFP_NOFS);
-		if (!alloc_buf)
-			return -ENOMEM;
-		workbuf = alloc_buf;
-	}
-
-	/* Allocate request */
-	req = ablkcipher_request_alloc(tfm, GFP_NOFS);
-	if (!req) {
-		printk_ratelimited(KERN_ERR
-			"%s: crypto_request_alloc() failed\n", __func__);
-		kfree(alloc_buf);
-		return -ENOMEM;
-	}
-	ablkcipher_request_set_callback(req,
-			CRYPTO_TFM_REQ_MAY_BACKLOG | CRYPTO_TFM_REQ_MAY_SLEEP,
-			f2fs_dir_crypt_complete, &ecr);
-
-	/* Copy the input */
-	memcpy(workbuf, iname->name, iname->len);
-	if (iname->len < ciphertext_len)
-		memset(workbuf + iname->len, 0, ciphertext_len - iname->len);
-
-	/* Initialize IV */
-	memset(iv, 0, F2FS_CRYPTO_BLOCK_SIZE);
-
-	/* Create encryption request */
-	sg_init_one(&src_sg, workbuf, ciphertext_len);
-	sg_init_one(&dst_sg, oname->name, ciphertext_len);
-	ablkcipher_request_set_crypt(req, &src_sg, &dst_sg, ciphertext_len, iv);
-	res = crypto_ablkcipher_encrypt(req);
-	if (res == -EINPROGRESS || res == -EBUSY) {
-		wait_for_completion(&ecr.completion);
-		res = ecr.res;
-	}
-	kfree(alloc_buf);
-	ablkcipher_request_free(req);
-	if (res < 0) {
-		printk_ratelimited(KERN_ERR
-				"%s: Error (error code %d)\n", __func__, res);
-	}
-	oname->len = ciphertext_len;
-	return res;
-}
-
-/*
- * f2fs_fname_decrypt()
- *	This function decrypts the input filename, and returns
- *	the length of the plaintext.
- *	Errors are returned as negative numbers.
- *	We trust the caller to allocate sufficient memory to oname string.
- */
-static int f2fs_fname_decrypt(struct inode *inode,
-			const struct f2fs_str *iname, struct f2fs_str *oname)
-{
-	struct ablkcipher_request *req = NULL;
-	DECLARE_F2FS_COMPLETION_RESULT(ecr);
-	struct scatterlist src_sg, dst_sg;
-	struct f2fs_crypt_info *ci = F2FS_I(inode)->i_crypt_info;
-	struct crypto_ablkcipher *tfm = ci->ci_ctfm;
-	int res = 0;
-	char iv[F2FS_CRYPTO_BLOCK_SIZE];
-	unsigned lim = max_name_len(inode);
-
-	if (iname->len <= 0 || iname->len > lim)
-		return -EIO;
-
-	/* Allocate request */
-	req = ablkcipher_request_alloc(tfm, GFP_NOFS);
-	if (!req) {
-		printk_ratelimited(KERN_ERR
-			"%s: crypto_request_alloc() failed\n",  __func__);
-		return -ENOMEM;
-	}
-	ablkcipher_request_set_callback(req,
-		CRYPTO_TFM_REQ_MAY_BACKLOG | CRYPTO_TFM_REQ_MAY_SLEEP,
-		f2fs_dir_crypt_complete, &ecr);
-
-	/* Initialize IV */
-	memset(iv, 0, F2FS_CRYPTO_BLOCK_SIZE);
-
-	/* Create decryption request */
-	sg_init_one(&src_sg, iname->name, iname->len);
-	sg_init_one(&dst_sg, oname->name, oname->len);
-	ablkcipher_request_set_crypt(req, &src_sg, &dst_sg, iname->len, iv);
-	res = crypto_ablkcipher_decrypt(req);
-	if (res == -EINPROGRESS || res == -EBUSY) {
-		wait_for_completion(&ecr.completion);
-		res = ecr.res;
-	}
-	ablkcipher_request_free(req);
-	if (res < 0) {
-		printk_ratelimited(KERN_ERR
-			"%s: Error in f2fs_fname_decrypt (error code %d)\n",
-			__func__, res);
-		return res;
-	}
-
-	oname->len = strnlen(oname->name, iname->len);
-	return oname->len;
-}
-
-static const char *lookup_table =
-	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+,";
-
-/**
- * f2fs_fname_encode_digest() -
- *
- * Encodes the input digest using characters from the set [a-zA-Z0-9_+].
- * The encoded string is roughly 4/3 times the size of the input string.
- */
-static int digest_encode(const char *src, int len, char *dst)
-{
-	int i = 0, bits = 0, ac = 0;
-	char *cp = dst;
-
-	while (i < len) {
-		ac += (((unsigned char) src[i]) << bits);
-		bits += 8;
-		do {
-			*cp++ = lookup_table[ac & 0x3f];
-			ac >>= 6;
-			bits -= 6;
-		} while (bits >= 6);
-		i++;
-	}
-	if (bits)
-		*cp++ = lookup_table[ac & 0x3f];
-	return cp - dst;
-}
-
-static int digest_decode(const char *src, int len, char *dst)
-{
-	int i = 0, bits = 0, ac = 0;
-	const char *p;
-	char *cp = dst;
-
-	while (i < len) {
-		p = strchr(lookup_table, src[i]);
-		if (p == NULL || src[i] == 0)
-			return -2;
-		ac += (p - lookup_table) << bits;
-		bits += 6;
-		if (bits >= 8) {
-			*cp++ = ac & 0xff;
-			ac >>= 8;
-			bits -= 8;
-		}
-		i++;
-	}
-	if (ac)
-		return -1;
-	return cp - dst;
-}
-
-/**
- * f2fs_fname_crypto_round_up() -
- *
- * Return: The next multiple of block size
- */
-u32 f2fs_fname_crypto_round_up(u32 size, u32 blksize)
-{
-	return ((size + blksize - 1) / blksize) * blksize;
-}
-
-unsigned f2fs_fname_encrypted_size(struct inode *inode, u32 ilen)
-{
-	struct f2fs_crypt_info *ci = F2FS_I(inode)->i_crypt_info;
-	int padding = 32;
-
-	if (ci)
-		padding = 4 << (ci->ci_flags & F2FS_POLICY_FLAGS_PAD_MASK);
-	if (ilen < F2FS_CRYPTO_BLOCK_SIZE)
-		ilen = F2FS_CRYPTO_BLOCK_SIZE;
-	return f2fs_fname_crypto_round_up(ilen, padding);
-}
-
-/**
- * f2fs_fname_crypto_alloc_obuff() -
- *
- * Allocates an output buffer that is sufficient for the crypto operation
- * specified by the context and the direction.
- */
-int f2fs_fname_crypto_alloc_buffer(struct inode *inode,
-				   u32 ilen, struct f2fs_str *crypto_str)
-{
-	unsigned int olen = f2fs_fname_encrypted_size(inode, ilen);
-
-	crypto_str->len = olen;
-	if (olen < F2FS_FNAME_CRYPTO_DIGEST_SIZE * 2)
-		olen = F2FS_FNAME_CRYPTO_DIGEST_SIZE * 2;
-	/* Allocated buffer can hold one more character to null-terminate the
-	 * string */
-	crypto_str->name = kmalloc(olen + 1, GFP_NOFS);
-	if (!(crypto_str->name))
-		return -ENOMEM;
-	return 0;
-}
-
-/**
- * f2fs_fname_crypto_free_buffer() -
- *
- * Frees the buffer allocated for crypto operation.
- */
-void f2fs_fname_crypto_free_buffer(struct f2fs_str *crypto_str)
-{
-	if (!crypto_str)
-		return;
-	kfree(crypto_str->name);
-	crypto_str->name = NULL;
-}
-
-/**
- * f2fs_fname_disk_to_usr() - converts a filename from disk space to user space
- */
-int f2fs_fname_disk_to_usr(struct inode *inode,
-			f2fs_hash_t *hash,
-			const struct f2fs_str *iname,
-			struct f2fs_str *oname)
-{
-	const struct qstr qname = FSTR_TO_QSTR(iname);
-	char buf[24];
-	int ret;
-
-	if (is_dot_dotdot(&qname)) {
-		oname->name[0] = '.';
-		oname->name[iname->len - 1] = '.';
-		oname->len = iname->len;
-		return oname->len;
-	}
-	if (iname->len < F2FS_CRYPTO_BLOCK_SIZE) {
-		printk("encrypted inode too small");
-		return -EUCLEAN;
-	}
-	if (F2FS_I(inode)->i_crypt_info)
-		return f2fs_fname_decrypt(inode, iname, oname);
-
-	if (iname->len <= F2FS_FNAME_CRYPTO_DIGEST_SIZE) {
-		ret = digest_encode(iname->name, iname->len, oname->name);
-		oname->len = ret;
-		return ret;
-	}
-	if (hash) {
-		memcpy(buf, hash, 4);
-		memset(buf + 4, 0, 4);
-	} else
-		memset(buf, 0, 8);
-	memcpy(buf + 8, iname->name + iname->len - 16, 16);
-	oname->name[0] = '_';
-	ret = digest_encode(buf, 24, oname->name + 1);
-	oname->len = ret + 1;
-	return ret + 1;
-}
-
-/**
- * f2fs_fname_usr_to_disk() - converts a filename from user space to disk space
- */
-int f2fs_fname_usr_to_disk(struct inode *inode,
-			const struct qstr *iname,
-			struct f2fs_str *oname)
-{
-	int res;
-	struct f2fs_crypt_info *ci = F2FS_I(inode)->i_crypt_info;
-
-	if (is_dot_dotdot(iname)) {
-		oname->name[0] = '.';
-		oname->name[iname->len - 1] = '.';
-		oname->len = iname->len;
-		return oname->len;
-	}
-
-	if (ci) {
-		res = f2fs_fname_encrypt(inode, iname, oname);
-		return res;
-	}
-	/* Without a proper key, a user is not allowed to modify the filenames
-	 * in a directory. Consequently, a user space name cannot be mapped to
-	 * a disk-space name */
-	return -EACCES;
-}
-
-int f2fs_fname_setup_filename(struct inode *dir, const struct qstr *iname,
-			      int lookup, struct f2fs_filename *fname)
-{
-	struct f2fs_crypt_info *ci;
-	int ret = 0, bigname = 0;
-
-	memset(fname, 0, sizeof(struct f2fs_filename));
-	fname->usr_fname = iname;
-
-	if (!f2fs_encrypted_inode(dir) || is_dot_dotdot(iname)) {
-		fname->disk_name.name = (unsigned char *)iname->name;
-		fname->disk_name.len = iname->len;
-		return 0;
-	}
-	ret = f2fs_get_encryption_info(dir);
-	if (ret)
-		return ret;
-	ci = F2FS_I(dir)->i_crypt_info;
-	if (ci) {
-		ret = f2fs_fname_crypto_alloc_buffer(dir, iname->len,
-						     &fname->crypto_buf);
-		if (ret < 0)
-			return ret;
-		ret = f2fs_fname_encrypt(dir, iname, &fname->crypto_buf);
-		if (ret < 0)
-			goto errout;
-		fname->disk_name.name = fname->crypto_buf.name;
-		fname->disk_name.len = fname->crypto_buf.len;
-		return 0;
-	}
-	if (!lookup)
-		return -EACCES;
-
-	/* We don't have the key and we are doing a lookup; decode the
-	 * user-supplied name
-	 */
-	if (iname->name[0] == '_')
-		bigname = 1;
-	if ((bigname && (iname->len != 33)) ||
-	    (!bigname && (iname->len > 43)))
-		return -ENOENT;
-
-	fname->crypto_buf.name = kmalloc(32, GFP_KERNEL);
-	if (fname->crypto_buf.name == NULL)
-		return -ENOMEM;
-	ret = digest_decode(iname->name + bigname, iname->len - bigname,
-				fname->crypto_buf.name);
-	if (ret < 0) {
-		ret = -ENOENT;
-		goto errout;
-	}
-	fname->crypto_buf.len = ret;
-	if (bigname) {
-		memcpy(&fname->hash, fname->crypto_buf.name, 4);
-	} else {
-		fname->disk_name.name = fname->crypto_buf.name;
-		fname->disk_name.len = fname->crypto_buf.len;
-	}
-	return 0;
-errout:
-	f2fs_fname_crypto_free_buffer(&fname->crypto_buf);
-	return ret;
-}
-
-void f2fs_fname_free_filename(struct f2fs_filename *fname)
-{
-	kfree(fname->crypto_buf.name);
-	fname->crypto_buf.name = NULL;
-	fname->usr_fname = NULL;
-	fname->disk_name.name = NULL;
-}
diff --git a/fs/f2fs/crypto_key.c b/fs/f2fs/crypto_key.c
deleted file mode 100644
index 9094fca..0000000
--- a/fs/f2fs/crypto_key.c
+++ /dev/null
@@ -1,267 +0,0 @@
-/*
- * linux/fs/f2fs/crypto_key.c
- *
- * Copied from linux/fs/f2fs/crypto_key.c
- *
- * Copyright (C) 2015, Google, Inc.
- *
- * This contains encryption key functions for f2fs
- *
- * Written by Michael Halcrow, Ildar Muslukhov, and Uday Savagaonkar, 2015.
- */
-#include <keys/encrypted-type.h>
-#include <keys/user-type.h>
-#include <linux/random.h>
-#include <linux/scatterlist.h>
-#include <uapi/linux/keyctl.h>
-#include <crypto/hash.h>
-#include <linux/f2fs_fs.h>
-
-#include "f2fs.h"
-#include "xattr.h"
-
-static void derive_crypt_complete(struct crypto_async_request *req, int rc)
-{
-	struct f2fs_completion_result *ecr = req->data;
-
-	if (rc == -EINPROGRESS)
-		return;
-
-	ecr->res = rc;
-	complete(&ecr->completion);
-}
-
-/**
- * f2fs_derive_key_aes() - Derive a key using AES-128-ECB
- * @deriving_key: Encryption key used for derivation.
- * @source_key:   Source key to which to apply derivation.
- * @derived_key:  Derived key.
- *
- * Return: Zero on success; non-zero otherwise.
- */
-static int f2fs_derive_key_aes(char deriving_key[F2FS_AES_128_ECB_KEY_SIZE],
-				char source_key[F2FS_AES_256_XTS_KEY_SIZE],
-				char derived_key[F2FS_AES_256_XTS_KEY_SIZE])
-{
-	int res = 0;
-	struct ablkcipher_request *req = NULL;
-	DECLARE_F2FS_COMPLETION_RESULT(ecr);
-	struct scatterlist src_sg, dst_sg;
-	struct crypto_ablkcipher *tfm = crypto_alloc_ablkcipher("ecb(aes)", 0,
-								0);
-
-	if (IS_ERR(tfm)) {
-		res = PTR_ERR(tfm);
-		tfm = NULL;
-		goto out;
-	}
-	crypto_ablkcipher_set_flags(tfm, CRYPTO_TFM_REQ_WEAK_KEY);
-	req = ablkcipher_request_alloc(tfm, GFP_NOFS);
-	if (!req) {
-		res = -ENOMEM;
-		goto out;
-	}
-	ablkcipher_request_set_callback(req,
-			CRYPTO_TFM_REQ_MAY_BACKLOG | CRYPTO_TFM_REQ_MAY_SLEEP,
-			derive_crypt_complete, &ecr);
-	res = crypto_ablkcipher_setkey(tfm, deriving_key,
-				F2FS_AES_128_ECB_KEY_SIZE);
-	if (res < 0)
-		goto out;
-
-	sg_init_one(&src_sg, source_key, F2FS_AES_256_XTS_KEY_SIZE);
-	sg_init_one(&dst_sg, derived_key, F2FS_AES_256_XTS_KEY_SIZE);
-	ablkcipher_request_set_crypt(req, &src_sg, &dst_sg,
-					F2FS_AES_256_XTS_KEY_SIZE, NULL);
-	res = crypto_ablkcipher_encrypt(req);
-	if (res == -EINPROGRESS || res == -EBUSY) {
-		wait_for_completion(&ecr.completion);
-		res = ecr.res;
-	}
-out:
-	if (req)
-		ablkcipher_request_free(req);
-	if (tfm)
-		crypto_free_ablkcipher(tfm);
-	return res;
-}
-
-static void f2fs_free_crypt_info(struct f2fs_crypt_info *ci)
-{
-	if (!ci)
-		return;
-
-	key_put(ci->ci_keyring_key);
-	crypto_free_ablkcipher(ci->ci_ctfm);
-	kmem_cache_free(f2fs_crypt_info_cachep, ci);
-}
-
-void f2fs_free_encryption_info(struct inode *inode, struct f2fs_crypt_info *ci)
-{
-	struct f2fs_inode_info *fi = F2FS_I(inode);
-	struct f2fs_crypt_info *prev;
-
-	if (ci == NULL)
-		ci = ACCESS_ONCE(fi->i_crypt_info);
-	if (ci == NULL)
-		return;
-	prev = cmpxchg(&fi->i_crypt_info, ci, NULL);
-	if (prev != ci)
-		return;
-
-	f2fs_free_crypt_info(ci);
-}
-
-int _f2fs_get_encryption_info(struct inode *inode)
-{
-	struct f2fs_inode_info *fi = F2FS_I(inode);
-	struct f2fs_crypt_info *crypt_info;
-	char full_key_descriptor[F2FS_KEY_DESC_PREFIX_SIZE +
-				(F2FS_KEY_DESCRIPTOR_SIZE * 2) + 1];
-	struct key *keyring_key = NULL;
-	struct f2fs_encryption_key *master_key;
-	struct f2fs_encryption_context ctx;
-	const struct user_key_payload *ukp;
-	struct crypto_ablkcipher *ctfm;
-	const char *cipher_str;
-	char raw_key[F2FS_MAX_KEY_SIZE];
-	char mode;
-	int res;
-
-	res = f2fs_crypto_initialize();
-	if (res)
-		return res;
-retry:
-	crypt_info = ACCESS_ONCE(fi->i_crypt_info);
-	if (crypt_info) {
-		if (!crypt_info->ci_keyring_key ||
-				key_validate(crypt_info->ci_keyring_key) == 0)
-			return 0;
-		f2fs_free_encryption_info(inode, crypt_info);
-		goto retry;
-	}
-
-	res = f2fs_getxattr(inode, F2FS_XATTR_INDEX_ENCRYPTION,
-				F2FS_XATTR_NAME_ENCRYPTION_CONTEXT,
-				&ctx, sizeof(ctx), NULL);
-	if (res < 0)
-		return res;
-	else if (res != sizeof(ctx))
-		return -EINVAL;
-	res = 0;
-
-	crypt_info = kmem_cache_alloc(f2fs_crypt_info_cachep, GFP_NOFS);
-	if (!crypt_info)
-		return -ENOMEM;
-
-	crypt_info->ci_flags = ctx.flags;
-	crypt_info->ci_data_mode = ctx.contents_encryption_mode;
-	crypt_info->ci_filename_mode = ctx.filenames_encryption_mode;
-	crypt_info->ci_ctfm = NULL;
-	crypt_info->ci_keyring_key = NULL;
-	memcpy(crypt_info->ci_master_key, ctx.master_key_descriptor,
-				sizeof(crypt_info->ci_master_key));
-	if (S_ISREG(inode->i_mode))
-		mode = crypt_info->ci_data_mode;
-	else if (S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode))
-		mode = crypt_info->ci_filename_mode;
-	else
-		BUG();
-
-	switch (mode) {
-	case F2FS_ENCRYPTION_MODE_AES_256_XTS:
-		cipher_str = "xts(aes)";
-		break;
-	case F2FS_ENCRYPTION_MODE_AES_256_CTS:
-		cipher_str = "cts(cbc(aes))";
-		break;
-	default:
-		printk_once(KERN_WARNING
-			    "f2fs: unsupported key mode %d (ino %u)\n",
-			    mode, (unsigned) inode->i_ino);
-		res = -ENOKEY;
-		goto out;
-	}
-
-	memcpy(full_key_descriptor, F2FS_KEY_DESC_PREFIX,
-					F2FS_KEY_DESC_PREFIX_SIZE);
-	sprintf(full_key_descriptor + F2FS_KEY_DESC_PREFIX_SIZE,
-					"%*phN", F2FS_KEY_DESCRIPTOR_SIZE,
-					ctx.master_key_descriptor);
-	full_key_descriptor[F2FS_KEY_DESC_PREFIX_SIZE +
-					(2 * F2FS_KEY_DESCRIPTOR_SIZE)] = '\0';
-	keyring_key = request_key(&key_type_logon, full_key_descriptor, NULL);
-	if (IS_ERR(keyring_key)) {
-		res = PTR_ERR(keyring_key);
-		keyring_key = NULL;
-		goto out;
-	}
-	crypt_info->ci_keyring_key = keyring_key;
-	if (keyring_key->type != &key_type_logon) {
-		printk_once(KERN_WARNING "f2fs: key type must be logon\n");
-		res = -ENOKEY;
-		goto out;
-	}
-	down_read(&keyring_key->sem);
-	ukp = user_key_payload(keyring_key);
-	if (ukp->datalen != sizeof(struct f2fs_encryption_key)) {
-		res = -EINVAL;
-		up_read(&keyring_key->sem);
-		goto out;
-	}
-	master_key = (struct f2fs_encryption_key *)ukp->data;
-	BUILD_BUG_ON(F2FS_AES_128_ECB_KEY_SIZE !=
-				F2FS_KEY_DERIVATION_NONCE_SIZE);
-	if (master_key->size != F2FS_AES_256_XTS_KEY_SIZE) {
-		printk_once(KERN_WARNING
-				"f2fs: key size incorrect: %d\n",
-				master_key->size);
-		res = -ENOKEY;
-		up_read(&keyring_key->sem);
-		goto out;
-	}
-	res = f2fs_derive_key_aes(ctx.nonce, master_key->raw,
-				  raw_key);
-	up_read(&keyring_key->sem);
-	if (res)
-		goto out;
-
-	ctfm = crypto_alloc_ablkcipher(cipher_str, 0, 0);
-	if (!ctfm || IS_ERR(ctfm)) {
-		res = ctfm ? PTR_ERR(ctfm) : -ENOMEM;
-		printk(KERN_DEBUG
-		       "%s: error %d (inode %u) allocating crypto tfm\n",
-		       __func__, res, (unsigned) inode->i_ino);
-		goto out;
-	}
-	crypt_info->ci_ctfm = ctfm;
-	crypto_ablkcipher_clear_flags(ctfm, ~0);
-	crypto_tfm_set_flags(crypto_ablkcipher_tfm(ctfm),
-			     CRYPTO_TFM_REQ_WEAK_KEY);
-	res = crypto_ablkcipher_setkey(ctfm, raw_key,
-					f2fs_encryption_key_size(mode));
-	if (res)
-		goto out;
-
-	memzero_explicit(raw_key, sizeof(raw_key));
-	if (cmpxchg(&fi->i_crypt_info, NULL, crypt_info) != NULL) {
-		f2fs_free_crypt_info(crypt_info);
-		goto retry;
-	}
-	return 0;
-
-out:
-	if (res == -ENOKEY && !S_ISREG(inode->i_mode))
-		res = 0;
-
-	f2fs_free_crypt_info(crypt_info);
-	memzero_explicit(raw_key, sizeof(raw_key));
-	return res;
-}
-
-int f2fs_has_encryption_key(struct inode *inode)
-{
-	struct f2fs_inode_info *fi = F2FS_I(inode);
-
-	return (fi->i_crypt_info != NULL);
-}
diff --git a/fs/f2fs/crypto_policy.c b/fs/f2fs/crypto_policy.c
deleted file mode 100644
index 596f024..0000000
--- a/fs/f2fs/crypto_policy.c
+++ /dev/null
@@ -1,210 +0,0 @@
-/*
- * copied from linux/fs/ext4/crypto_policy.c
- *
- * Copyright (C) 2015, Google, Inc.
- * Copyright (C) 2015, Motorola Mobility.
- *
- * This contains encryption policy functions for f2fs with some modifications
- * to support f2fs-specific xattr APIs.
- *
- * Written by Michael Halcrow, 2015.
- * Modified by Jaegeuk Kim, 2015.
- */
-#include <linux/random.h>
-#include <linux/string.h>
-#include <linux/types.h>
-#include <linux/f2fs_fs.h>
-
-#include "f2fs.h"
-#include "xattr.h"
-
-static int f2fs_inode_has_encryption_context(struct inode *inode)
-{
-	int res = f2fs_getxattr(inode, F2FS_XATTR_INDEX_ENCRYPTION,
-			F2FS_XATTR_NAME_ENCRYPTION_CONTEXT, NULL, 0, NULL);
-	return (res > 0);
-}
-
-/*
- * check whether the policy is consistent with the encryption context
- * for the inode
- */
-static int f2fs_is_encryption_context_consistent_with_policy(
-	struct inode *inode, const struct f2fs_encryption_policy *policy)
-{
-	struct f2fs_encryption_context ctx;
-	int res = f2fs_getxattr(inode, F2FS_XATTR_INDEX_ENCRYPTION,
-				F2FS_XATTR_NAME_ENCRYPTION_CONTEXT, &ctx,
-				sizeof(ctx), NULL);
-
-	if (res != sizeof(ctx))
-		return 0;
-
-	return (memcmp(ctx.master_key_descriptor, policy->master_key_descriptor,
-				F2FS_KEY_DESCRIPTOR_SIZE) == 0 &&
-			(ctx.flags == policy->flags) &&
-			(ctx.contents_encryption_mode ==
-			 policy->contents_encryption_mode) &&
-			(ctx.filenames_encryption_mode ==
-			 policy->filenames_encryption_mode));
-}
-
-static int f2fs_create_encryption_context_from_policy(
-	struct inode *inode, const struct f2fs_encryption_policy *policy)
-{
-	struct f2fs_encryption_context ctx;
-
-	ctx.format = F2FS_ENCRYPTION_CONTEXT_FORMAT_V1;
-	memcpy(ctx.master_key_descriptor, policy->master_key_descriptor,
-			F2FS_KEY_DESCRIPTOR_SIZE);
-
-	if (!f2fs_valid_contents_enc_mode(policy->contents_encryption_mode)) {
-		printk(KERN_WARNING
-		       "%s: Invalid contents encryption mode %d\n", __func__,
-			policy->contents_encryption_mode);
-		return -EINVAL;
-	}
-
-	if (!f2fs_valid_filenames_enc_mode(policy->filenames_encryption_mode)) {
-		printk(KERN_WARNING
-		       "%s: Invalid filenames encryption mode %d\n", __func__,
-			policy->filenames_encryption_mode);
-		return -EINVAL;
-	}
-
-	if (policy->flags & ~F2FS_POLICY_FLAGS_VALID)
-		return -EINVAL;
-
-	ctx.contents_encryption_mode = policy->contents_encryption_mode;
-	ctx.filenames_encryption_mode = policy->filenames_encryption_mode;
-	ctx.flags = policy->flags;
-	BUILD_BUG_ON(sizeof(ctx.nonce) != F2FS_KEY_DERIVATION_NONCE_SIZE);
-	get_random_bytes(ctx.nonce, F2FS_KEY_DERIVATION_NONCE_SIZE);
-
-	return f2fs_setxattr(inode, F2FS_XATTR_INDEX_ENCRYPTION,
-			F2FS_XATTR_NAME_ENCRYPTION_CONTEXT, &ctx,
-			sizeof(ctx), NULL, XATTR_CREATE);
-}
-
-int f2fs_process_policy(const struct f2fs_encryption_policy *policy,
-			struct inode *inode)
-{
-	if (policy->version != 0)
-		return -EINVAL;
-
-	if (!S_ISDIR(inode->i_mode))
-		return -EINVAL;
-
-	if (!f2fs_inode_has_encryption_context(inode)) {
-		if (!f2fs_empty_dir(inode))
-			return -ENOTEMPTY;
-		return f2fs_create_encryption_context_from_policy(inode,
-								  policy);
-	}
-
-	if (f2fs_is_encryption_context_consistent_with_policy(inode, policy))
-		return 0;
-
-	printk(KERN_WARNING "%s: Policy inconsistent with encryption context\n",
-	       __func__);
-	return -EINVAL;
-}
-
-int f2fs_get_policy(struct inode *inode, struct f2fs_encryption_policy *policy)
-{
-	struct f2fs_encryption_context ctx;
-	int res;
-
-	if (!f2fs_encrypted_inode(inode))
-		return -ENODATA;
-
-	res = f2fs_getxattr(inode, F2FS_XATTR_INDEX_ENCRYPTION,
-				F2FS_XATTR_NAME_ENCRYPTION_CONTEXT,
-				&ctx, sizeof(ctx), NULL);
-	if (res != sizeof(ctx))
-		return -ENODATA;
-	if (ctx.format != F2FS_ENCRYPTION_CONTEXT_FORMAT_V1)
-		return -EINVAL;
-
-	policy->version = 0;
-	policy->contents_encryption_mode = ctx.contents_encryption_mode;
-	policy->filenames_encryption_mode = ctx.filenames_encryption_mode;
-	policy->flags = ctx.flags;
-	memcpy(&policy->master_key_descriptor, ctx.master_key_descriptor,
-			F2FS_KEY_DESCRIPTOR_SIZE);
-	return 0;
-}
-
-int f2fs_is_child_context_consistent_with_parent(struct inode *parent,
-						struct inode *child)
-{
-	struct f2fs_crypt_info *parent_ci, *child_ci;
-	int res;
-
-	if ((parent == NULL) || (child == NULL)) {
-		pr_err("parent %p child %p\n", parent, child);
-		BUG_ON(1);
-	}
-
-	/* no restrictions if the parent directory is not encrypted */
-	if (!f2fs_encrypted_inode(parent))
-		return 1;
-	/* if the child directory is not encrypted, this is always a problem */
-	if (!f2fs_encrypted_inode(child))
-		return 0;
-	res = f2fs_get_encryption_info(parent);
-	if (res)
-		return 0;
-	res = f2fs_get_encryption_info(child);
-	if (res)
-		return 0;
-	parent_ci = F2FS_I(parent)->i_crypt_info;
-	child_ci = F2FS_I(child)->i_crypt_info;
-	if (!parent_ci && !child_ci)
-		return 1;
-	if (!parent_ci || !child_ci)
-		return 0;
-
-	return (memcmp(parent_ci->ci_master_key,
-			child_ci->ci_master_key,
-			F2FS_KEY_DESCRIPTOR_SIZE) == 0 &&
-		(parent_ci->ci_data_mode == child_ci->ci_data_mode) &&
-		(parent_ci->ci_filename_mode == child_ci->ci_filename_mode) &&
-		(parent_ci->ci_flags == child_ci->ci_flags));
-}
-
-/**
- * f2fs_inherit_context() - Sets a child context from its parent
- * @parent: Parent inode from which the context is inherited.
- * @child:  Child inode that inherits the context from @parent.
- *
- * Return: Zero on success, non-zero otherwise
- */
-int f2fs_inherit_context(struct inode *parent, struct inode *child,
-						struct page *ipage)
-{
-	struct f2fs_encryption_context ctx;
-	struct f2fs_crypt_info *ci;
-	int res;
-
-	res = f2fs_get_encryption_info(parent);
-	if (res < 0)
-		return res;
-
-	ci = F2FS_I(parent)->i_crypt_info;
-	if (ci == NULL)
-		return -ENOKEY;
-
-	ctx.format = F2FS_ENCRYPTION_CONTEXT_FORMAT_V1;
-
-	ctx.contents_encryption_mode = ci->ci_data_mode;
-	ctx.filenames_encryption_mode = ci->ci_filename_mode;
-	ctx.flags = ci->ci_flags;
-	memcpy(ctx.master_key_descriptor, ci->ci_master_key,
-			F2FS_KEY_DESCRIPTOR_SIZE);
-
-	get_random_bytes(ctx.nonce, F2FS_KEY_DERIVATION_NONCE_SIZE);
-	return f2fs_setxattr(child, F2FS_XATTR_INDEX_ENCRYPTION,
-				F2FS_XATTR_NAME_ENCRYPTION_CONTEXT, &ctx,
-				sizeof(ctx), ipage, XATTR_CREATE);
-}
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8b46e5d..d3a6cd0 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -34,9 +34,9 @@ static void f2fs_read_end_io(struct bio *bio)
 
 	if (f2fs_bio_encrypted(bio)) {
 		if (bio->bi_error) {
-			f2fs_release_crypto_ctx(bio->bi_private);
+			fscrypt_release_ctx(bio->bi_private);
 		} else {
-			f2fs_end_io_crypto_work(bio->bi_private, bio);
+			fscrypt_decrypt_bio_pages(bio->bi_private, bio);
 			return;
 		}
 	}
@@ -64,7 +64,7 @@ static void f2fs_write_end_io(struct bio *bio)
 	bio_for_each_segment_all(bvec, bio, i) {
 		struct page *page = bvec->bv_page;
 
-		f2fs_restore_and_release_control_page(&page);
+		fscrypt_pullback_bio_page(&page, true);
 
 		if (unlikely(bio->bi_error)) {
 			set_bit(AS_EIO, &page->mapping->flags);
@@ -129,16 +129,10 @@ static bool __has_merged_page(struct f2fs_bio_info *io, struct inode *inode,
 
 	bio_for_each_segment_all(bvec, io->bio, i) {
 
-		if (bvec->bv_page->mapping) {
+		if (bvec->bv_page->mapping)
 			target = bvec->bv_page;
-		} else {
-			struct f2fs_crypto_ctx *ctx;
-
-			/* encrypted page */
-			ctx = (struct f2fs_crypto_ctx *)page_private(
-								bvec->bv_page);
-			target = ctx->w.control_page;
-		}
+		else
+			target = fscrypt_control_page(bvec->bv_page);
 
 		if (inode && inode == target->mapping->host)
 			return true;
@@ -213,7 +207,8 @@ void f2fs_submit_merged_bio_cond(struct f2fs_sb_info *sbi,
 int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 {
 	struct bio *bio;
-	struct page *page = fio->encrypted_page ? fio->encrypted_page : fio->page;
+	struct page *page = fio->encrypted_page ?
+			fio->encrypted_page : fio->page;
 
 	trace_f2fs_submit_page_bio(page, fio);
 	f2fs_trace_ios(fio, 0);
@@ -975,12 +970,12 @@ submit_and_realloc:
 			bio = NULL;
 		}
 		if (bio == NULL) {
-			struct f2fs_crypto_ctx *ctx = NULL;
+			struct fscrypt_ctx *ctx = NULL;
 
 			if (f2fs_encrypted_inode(inode) &&
 					S_ISREG(inode->i_mode)) {
 
-				ctx = f2fs_get_crypto_ctx(inode);
+				ctx = fscrypt_get_ctx(inode);
 				if (IS_ERR(ctx))
 					goto set_error_page;
 
@@ -993,7 +988,7 @@ submit_and_realloc:
 				min_t(int, nr_pages, BIO_MAX_PAGES));
 			if (!bio) {
 				if (ctx)
-					f2fs_release_crypto_ctx(ctx);
+					fscrypt_release_ctx(ctx);
 				goto set_error_page;
 			}
 			bio->bi_bdev = bdev;
@@ -1086,7 +1081,7 @@ int do_write_data_page(struct f2fs_io_info *fio)
 		f2fs_wait_on_encrypted_page_writeback(F2FS_I_SB(inode),
 							fio->blk_addr);
 
-		fio->encrypted_page = f2fs_encrypt(inode, fio->page);
+		fio->encrypted_page = fscrypt_encrypt_page(inode, fio->page);
 		if (IS_ERR(fio->encrypted_page)) {
 			err = PTR_ERR(fio->encrypted_page);
 			goto out_writepage;
@@ -1593,7 +1588,7 @@ repeat:
 
 		/* avoid symlink page */
 		if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode)) {
-			err = f2fs_decrypt(page);
+			err = fscrypt_decrypt_page(page);
 			if (err)
 				goto fail;
 		}
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 8f09da0..aa06700 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -77,7 +77,7 @@ static unsigned long dir_block_index(unsigned int level,
 }
 
 static struct f2fs_dir_entry *find_in_block(struct page *dentry_page,
-				struct f2fs_filename *fname,
+				struct fscrypt_name *fname,
 				f2fs_hash_t namehash,
 				int *max_slots,
 				struct page **res_page)
@@ -103,15 +103,15 @@ static struct f2fs_dir_entry *find_in_block(struct page *dentry_page,
 	return de;
 }
 
-struct f2fs_dir_entry *find_target_dentry(struct f2fs_filename *fname,
+struct f2fs_dir_entry *find_target_dentry(struct fscrypt_name *fname,
 			f2fs_hash_t namehash, int *max_slots,
 			struct f2fs_dentry_ptr *d)
 {
 	struct f2fs_dir_entry *de;
 	unsigned long bit_pos = 0;
 	int max_len = 0;
-	struct f2fs_str de_name = FSTR_INIT(NULL, 0);
-	struct f2fs_str *name = &fname->disk_name;
+	struct fscrypt_str de_name = FSTR_INIT(NULL, 0);
+	struct fscrypt_str *name = &fname->disk_name;
 
 	if (max_slots)
 		*max_slots = 0;
@@ -157,7 +157,7 @@ found:
 
 static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 					unsigned int level,
-					struct f2fs_filename *fname,
+					struct fscrypt_name *fname,
 					struct page **res_page)
 {
 	struct qstr name = FSTR_TO_QSTR(&fname->disk_name);
@@ -218,12 +218,12 @@ struct f2fs_dir_entry *f2fs_find_entry(struct inode *dir,
 	struct f2fs_dir_entry *de = NULL;
 	unsigned int max_depth;
 	unsigned int level;
-	struct f2fs_filename fname;
+	struct fscrypt_name fname;
 	int err;
 
 	*res_page = NULL;
 
-	err = f2fs_fname_setup_filename(dir, child, 1, &fname);
+	err = fscrypt_setup_filename(dir, child, 1, &fname);
 	if (err)
 		return NULL;
 
@@ -251,7 +251,7 @@ struct f2fs_dir_entry *f2fs_find_entry(struct inode *dir,
 			break;
 	}
 out:
-	f2fs_fname_free_filename(&fname);
+	fscrypt_free_filename(&fname);
 	return de;
 }
 
@@ -413,7 +413,7 @@ struct page *init_inode_metadata(struct inode *inode, struct inode *dir,
 			goto put_error;
 
 		if (f2fs_encrypted_inode(dir) && f2fs_may_encrypt(inode)) {
-			err = f2fs_inherit_context(dir, inode, page);
+			err = fscrypt_inherit_context(dir, inode, page, false);
 			if (err)
 				goto put_error;
 		}
@@ -536,11 +536,11 @@ int __f2fs_add_link(struct inode *dir, const struct qstr *name,
 	struct f2fs_dentry_block *dentry_blk = NULL;
 	struct f2fs_dentry_ptr d;
 	struct page *page = NULL;
-	struct f2fs_filename fname;
+	struct fscrypt_name fname;
 	struct qstr new_name;
 	int slots, err;
 
-	err = f2fs_fname_setup_filename(dir, name, 0, &fname);
+	err = fscrypt_setup_filename(dir, name, 0, &fname);
 	if (err)
 		return err;
 
@@ -639,7 +639,7 @@ fail:
 	kunmap(dentry_page);
 	f2fs_put_page(dentry_page, 1);
 out:
-	f2fs_fname_free_filename(&fname);
+	fscrypt_free_filename(&fname);
 	f2fs_update_time(F2FS_I_SB(dir), REQ_TIME);
 	return err;
 }
@@ -781,12 +781,12 @@ bool f2fs_empty_dir(struct inode *dir)
 }
 
 bool f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
-				unsigned int start_pos, struct f2fs_str *fstr)
+			unsigned int start_pos, struct fscrypt_str *fstr)
 {
 	unsigned char d_type = DT_UNKNOWN;
 	unsigned int bit_pos;
 	struct f2fs_dir_entry *de = NULL;
-	struct f2fs_str de_name = FSTR_INIT(NULL, 0);
+	struct fscrypt_str de_name = FSTR_INIT(NULL, 0);
 
 	bit_pos = ((unsigned long)ctx->pos % d->max);
 
@@ -820,8 +820,9 @@ bool f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 
 			memcpy(de_name.name, d->filename[bit_pos], de_name.len);
 
-			ret = f2fs_fname_disk_to_usr(d->inode, &de->hash_code,
-							&de_name, fstr);
+			ret = fscrypt_fname_disk_to_usr(d->inode,
+						(u32)de->hash_code, 0,
+						&de_name, fstr);
 			kfree(de_name.name);
 			if (ret < 0)
 				return true;
@@ -849,16 +850,15 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 	struct file_ra_state *ra = &file->f_ra;
 	unsigned int n = ((unsigned long)ctx->pos / NR_DENTRY_IN_BLOCK);
 	struct f2fs_dentry_ptr d;
-	struct f2fs_str fstr = FSTR_INIT(NULL, 0);
+	struct fscrypt_str fstr = FSTR_INIT(NULL, 0);
 	int err = 0;
 
 	if (f2fs_encrypted_inode(inode)) {
-		err = f2fs_get_encryption_info(inode);
-		if (err)
+		err = fscrypt_get_encryption_info(inode);
+		if (err && err != -EOPNOTSUPP)
 			return err;
 
-		err = f2fs_fname_crypto_alloc_buffer(inode, F2FS_NAME_LEN,
-								&fstr);
+		err = fscrypt_fname_alloc_buffer(inode, F2FS_NAME_LEN, &fstr);
 		if (err < 0)
 			return err;
 	}
@@ -898,14 +898,14 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 		f2fs_put_page(dentry_page, 1);
 	}
 out:
-	f2fs_fname_crypto_free_buffer(&fstr);
+	fscrypt_fname_free_buffer(&fstr);
 	return err;
 }
 
 static int f2fs_dir_open(struct inode *inode, struct file *filp)
 {
 	if (f2fs_encrypted_inode(inode))
-		return f2fs_get_encryption_info(inode) ? -EACCES : 0;
+		return fscrypt_get_encryption_info(inode) ? -EACCES : 0;
 	return 0;
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f9c294e..2b7adb8 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -22,6 +22,7 @@
 #include <linux/vmalloc.h>
 #include <linux/bio.h>
 #include <linux/blkdev.h>
+#include <linux/fscrypto.h>
 
 #ifdef CONFIG_F2FS_CHECK_FS
 #define f2fs_bug_on(sbi, condition)	BUG_ON(condition)
@@ -233,12 +234,9 @@ static inline bool __has_cursum_space(struct f2fs_summary_block *sum, int size,
 #define F2FS_IOC_WRITE_CHECKPOINT	_IO(F2FS_IOCTL_MAGIC, 7)
 #define F2FS_IOC_DEFRAGMENT		_IO(F2FS_IOCTL_MAGIC, 8)
 
-#define F2FS_IOC_SET_ENCRYPTION_POLICY					\
-		_IOR('f', 19, struct f2fs_encryption_policy)
-#define F2FS_IOC_GET_ENCRYPTION_PWSALT					\
-		_IOW('f', 20, __u8[16])
-#define F2FS_IOC_GET_ENCRYPTION_POLICY					\
-		_IOW('f', 21, struct f2fs_encryption_policy)
+#define F2FS_IOC_SET_ENCRYPTION_POLICY	FS_IOC_SET_ENCRYPTION_POLICY
+#define F2FS_IOC_GET_ENCRYPTION_POLICY	FS_IOC_GET_ENCRYPTION_POLICY
+#define F2FS_IOC_GET_ENCRYPTION_PWSALT	FS_IOC_GET_ENCRYPTION_PWSALT
 
 /*
  * should be same as XFS_IOC_GOINGDOWN.
@@ -268,25 +266,6 @@ struct f2fs_defragment {
  * For INODE and NODE manager
  */
 /* for directory operations */
-struct f2fs_str {
-	unsigned char *name;
-	u32 len;
-};
-
-struct f2fs_filename {
-	const struct qstr *usr_fname;
-	struct f2fs_str disk_name;
-	f2fs_hash_t hash;
-#ifdef CONFIG_F2FS_FS_ENCRYPTION
-	struct f2fs_str crypto_buf;
-#endif
-};
-
-#define FSTR_INIT(n, l)		{ .name = n, .len = l }
-#define FSTR_TO_QSTR(f)		QSTR_INIT((f)->name, (f)->len)
-#define fname_name(p)		((p)->disk_name.name)
-#define fname_len(p)		((p)->disk_name.len)
-
 struct f2fs_dentry_ptr {
 	struct inode *inode;
 	const void *bitmap;
@@ -414,15 +393,6 @@ struct f2fs_map_blocks {
 #define file_enc_name(inode)	is_file(inode, FADVISE_ENC_NAME_BIT)
 #define file_set_enc_name(inode) set_file(inode, FADVISE_ENC_NAME_BIT)
 
-/* Encryption algorithms */
-#define F2FS_ENCRYPTION_MODE_INVALID		0
-#define F2FS_ENCRYPTION_MODE_AES_256_XTS	1
-#define F2FS_ENCRYPTION_MODE_AES_256_GCM	2
-#define F2FS_ENCRYPTION_MODE_AES_256_CBC	3
-#define F2FS_ENCRYPTION_MODE_AES_256_CTS	4
-
-#include "f2fs_crypto.h"
-
 #define DEF_DIR_LEVEL		0
 
 struct f2fs_inode_info {
@@ -446,13 +416,7 @@ struct f2fs_inode_info {
 	struct list_head dirty_list;	/* linked in global dirty list */
 	struct list_head inmem_pages;	/* inmemory pages managed by f2fs */
 	struct mutex inmem_lock;	/* lock for inmemory pages */
-
 	struct extent_tree *extent_tree;	/* cached extent_tree entry */
-
-#ifdef CONFIG_F2FS_FS_ENCRYPTION
-	/* Encryption params */
-	struct f2fs_crypt_info *i_crypt_info;
-#endif
 };
 
 static inline void get_extent_info(struct extent_info *ext,
@@ -1743,10 +1707,10 @@ struct dentry *f2fs_get_parent(struct dentry *child);
 extern unsigned char f2fs_filetype_table[F2FS_FT_MAX];
 void set_de_type(struct f2fs_dir_entry *, umode_t);
 
-struct f2fs_dir_entry *find_target_dentry(struct f2fs_filename *,
+struct f2fs_dir_entry *find_target_dentry(struct fscrypt_name *,
 			f2fs_hash_t, int *, struct f2fs_dentry_ptr *);
 bool f2fs_fill_dentries(struct dir_context *, struct f2fs_dentry_ptr *,
-			unsigned int, struct f2fs_str *);
+			unsigned int, struct fscrypt_str *);
 void do_make_empty_dir(struct inode *, struct inode *,
 			struct f2fs_dentry_ptr *);
 struct page *init_inode_metadata(struct inode *, struct inode *,
@@ -2118,7 +2082,7 @@ int f2fs_convert_inline_inode(struct inode *);
 int f2fs_write_inline_data(struct inode *, struct page *);
 bool recover_inline_data(struct inode *, struct page *);
 struct f2fs_dir_entry *find_in_inline_dir(struct inode *,
-				struct f2fs_filename *, struct page **);
+				struct fscrypt_name *, struct page **);
 struct f2fs_dir_entry *f2fs_parent_inline_dir(struct inode *, struct page **);
 int make_empty_inline_dir(struct inode *inode, struct inode *, struct page *);
 int f2fs_add_inline_entry(struct inode *, const struct qstr *, struct inode *,
@@ -2127,7 +2091,7 @@ void f2fs_delete_inline_entry(struct f2fs_dir_entry *, struct page *,
 						struct inode *, struct inode *);
 bool f2fs_empty_inline_dir(struct inode *);
 int f2fs_read_inline_dir(struct file *, struct dir_context *,
-						struct f2fs_str *);
+						struct fscrypt_str *);
 int f2fs_inline_data_fiemap(struct inode *,
 		struct fiemap_extent_info *, __u64, __u64);
 
@@ -2157,13 +2121,9 @@ void destroy_extent_cache(void);
 /*
  * crypto support
  */
-static inline int f2fs_encrypted_inode(struct inode *inode)
+static inline bool f2fs_encrypted_inode(struct inode *inode)
 {
-#ifdef CONFIG_F2FS_FS_ENCRYPTION
 	return file_is_encrypt(inode);
-#else
-	return 0;
-#endif
 }
 
 static inline void f2fs_set_encrypted_inode(struct inode *inode)
@@ -2175,20 +2135,12 @@ static inline void f2fs_set_encrypted_inode(struct inode *inode)
 
 static inline bool f2fs_bio_encrypted(struct bio *bio)
 {
-#ifdef CONFIG_F2FS_FS_ENCRYPTION
-	return unlikely(bio->bi_private != NULL);
-#else
-	return false;
-#endif
+	return bio->bi_private != NULL;
 }
 
 static inline int f2fs_sb_has_crypto(struct super_block *sb)
 {
-#ifdef CONFIG_F2FS_FS_ENCRYPTION
 	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_ENCRYPT);
-#else
-	return 0;
-#endif
 }
 
 static inline bool f2fs_may_encrypt(struct inode *inode)
@@ -2201,87 +2153,4 @@ static inline bool f2fs_may_encrypt(struct inode *inode)
 	return 0;
 #endif
 }
-
-/* crypto_policy.c */
-int f2fs_is_child_context_consistent_with_parent(struct inode *,
-							struct inode *);
-int f2fs_inherit_context(struct inode *, struct inode *, struct page *);
-int f2fs_process_policy(const struct f2fs_encryption_policy *, struct inode *);
-int f2fs_get_policy(struct inode *, struct f2fs_encryption_policy *);
-
-/* crypt.c */
-extern struct kmem_cache *f2fs_crypt_info_cachep;
-bool f2fs_valid_contents_enc_mode(uint32_t);
-uint32_t f2fs_validate_encryption_key_size(uint32_t, uint32_t);
-struct f2fs_crypto_ctx *f2fs_get_crypto_ctx(struct inode *);
-void f2fs_release_crypto_ctx(struct f2fs_crypto_ctx *);
-struct page *f2fs_encrypt(struct inode *, struct page *);
-int f2fs_decrypt(struct page *);
-void f2fs_end_io_crypto_work(struct f2fs_crypto_ctx *, struct bio *);
-
-/* crypto_key.c */
-void f2fs_free_encryption_info(struct inode *, struct f2fs_crypt_info *);
-int _f2fs_get_encryption_info(struct inode *inode);
-
-/* crypto_fname.c */
-bool f2fs_valid_filenames_enc_mode(uint32_t);
-u32 f2fs_fname_crypto_round_up(u32, u32);
-unsigned f2fs_fname_encrypted_size(struct inode *, u32);
-int f2fs_fname_crypto_alloc_buffer(struct inode *, u32, struct f2fs_str *);
-int f2fs_fname_disk_to_usr(struct inode *, f2fs_hash_t *,
-			const struct f2fs_str *, struct f2fs_str *);
-int f2fs_fname_usr_to_disk(struct inode *, const struct qstr *,
-			struct f2fs_str *);
-
-#ifdef CONFIG_F2FS_FS_ENCRYPTION
-void f2fs_restore_and_release_control_page(struct page **);
-void f2fs_restore_control_page(struct page *);
-
-int __init f2fs_init_crypto(void);
-int f2fs_crypto_initialize(void);
-void f2fs_exit_crypto(void);
-
-int f2fs_has_encryption_key(struct inode *);
-
-static inline int f2fs_get_encryption_info(struct inode *inode)
-{
-	struct f2fs_crypt_info *ci = F2FS_I(inode)->i_crypt_info;
-
-	if (!ci ||
-		(ci->ci_keyring_key &&
-		 (ci->ci_keyring_key->flags & ((1 << KEY_FLAG_INVALIDATED) |
-					       (1 << KEY_FLAG_REVOKED) |
-					       (1 << KEY_FLAG_DEAD)))))
-		return _f2fs_get_encryption_info(inode);
-	return 0;
-}
-
-void f2fs_fname_crypto_free_buffer(struct f2fs_str *);
-int f2fs_fname_setup_filename(struct inode *, const struct qstr *,
-				int lookup, struct f2fs_filename *);
-void f2fs_fname_free_filename(struct f2fs_filename *);
-#else
-static inline void f2fs_restore_and_release_control_page(struct page **p) { }
-static inline void f2fs_restore_control_page(struct page *p) { }
-
-static inline int __init f2fs_init_crypto(void) { return 0; }
-static inline void f2fs_exit_crypto(void) { }
-
-static inline int f2fs_has_encryption_key(struct inode *i) { return 0; }
-static inline int f2fs_get_encryption_info(struct inode *i) { return 0; }
-static inline void f2fs_fname_crypto_free_buffer(struct f2fs_str *p) { }
-
-static inline int f2fs_fname_setup_filename(struct inode *dir,
-					const struct qstr *iname,
-					int lookup, struct f2fs_filename *fname)
-{
-	memset(fname, 0, sizeof(struct f2fs_filename));
-	fname->usr_fname = iname;
-	fname->disk_name.name = (unsigned char *)iname->name;
-	fname->disk_name.len = iname->len;
-	return 0;
-}
-
-static inline void f2fs_fname_free_filename(struct f2fs_filename *fname) { }
-#endif
 #endif
diff --git a/fs/f2fs/f2fs_crypto.h b/fs/f2fs/f2fs_crypto.h
deleted file mode 100644
index c2c1c2b..0000000
--- a/fs/f2fs/f2fs_crypto.h
+++ /dev/null
@@ -1,151 +0,0 @@
-/*
- * linux/fs/f2fs/f2fs_crypto.h
- *
- * Copied from linux/fs/ext4/ext4_crypto.h
- *
- * Copyright (C) 2015, Google, Inc.
- *
- * This contains encryption header content for f2fs
- *
- * Written by Michael Halcrow, 2015.
- * Modified by Jaegeuk Kim, 2015.
- */
-#ifndef _F2FS_CRYPTO_H
-#define _F2FS_CRYPTO_H
-
-#include <linux/fs.h>
-
-#define F2FS_KEY_DESCRIPTOR_SIZE	8
-
-/* Policy provided via an ioctl on the topmost directory */
-struct f2fs_encryption_policy {
-	char version;
-	char contents_encryption_mode;
-	char filenames_encryption_mode;
-	char flags;
-	char master_key_descriptor[F2FS_KEY_DESCRIPTOR_SIZE];
-} __attribute__((__packed__));
-
-#define F2FS_ENCRYPTION_CONTEXT_FORMAT_V1	1
-#define F2FS_KEY_DERIVATION_NONCE_SIZE		16
-
-#define F2FS_POLICY_FLAGS_PAD_4		0x00
-#define F2FS_POLICY_FLAGS_PAD_8		0x01
-#define F2FS_POLICY_FLAGS_PAD_16	0x02
-#define F2FS_POLICY_FLAGS_PAD_32	0x03
-#define F2FS_POLICY_FLAGS_PAD_MASK	0x03
-#define F2FS_POLICY_FLAGS_VALID		0x03
-
-/**
- * Encryption context for inode
- *
- * Protector format:
- *  1 byte: Protector format (1 = this version)
- *  1 byte: File contents encryption mode
- *  1 byte: File names encryption mode
- *  1 byte: Flags
- *  8 bytes: Master Key descriptor
- *  16 bytes: Encryption Key derivation nonce
- */
-struct f2fs_encryption_context {
-	char format;
-	char contents_encryption_mode;
-	char filenames_encryption_mode;
-	char flags;
-	char master_key_descriptor[F2FS_KEY_DESCRIPTOR_SIZE];
-	char nonce[F2FS_KEY_DERIVATION_NONCE_SIZE];
-} __attribute__((__packed__));
-
-/* Encryption parameters */
-#define F2FS_XTS_TWEAK_SIZE 16
-#define F2FS_AES_128_ECB_KEY_SIZE 16
-#define F2FS_AES_256_GCM_KEY_SIZE 32
-#define F2FS_AES_256_CBC_KEY_SIZE 32
-#define F2FS_AES_256_CTS_KEY_SIZE 32
-#define F2FS_AES_256_XTS_KEY_SIZE 64
-#define F2FS_MAX_KEY_SIZE 64
-
-#define F2FS_KEY_DESC_PREFIX "f2fs:"
-#define F2FS_KEY_DESC_PREFIX_SIZE 5
-
-struct f2fs_encryption_key {
-	__u32 mode;
-	char raw[F2FS_MAX_KEY_SIZE];
-	__u32 size;
-} __attribute__((__packed__));
-
-struct f2fs_crypt_info {
-	char		ci_data_mode;
-	char		ci_filename_mode;
-	char		ci_flags;
-	struct crypto_ablkcipher *ci_ctfm;
-	struct key	*ci_keyring_key;
-	char		ci_master_key[F2FS_KEY_DESCRIPTOR_SIZE];
-};
-
-#define F2FS_CTX_REQUIRES_FREE_ENCRYPT_FL             0x00000001
-#define F2FS_WRITE_PATH_FL			      0x00000002
-
-struct f2fs_crypto_ctx {
-	union {
-		struct {
-			struct page *bounce_page;       /* Ciphertext page */
-			struct page *control_page;      /* Original page  */
-		} w;
-		struct {
-			struct bio *bio;
-			struct work_struct work;
-		} r;
-		struct list_head free_list;     /* Free list */
-	};
-	char flags;                      /* Flags */
-};
-
-struct f2fs_completion_result {
-	struct completion completion;
-	int res;
-};
-
-#define DECLARE_F2FS_COMPLETION_RESULT(ecr) \
-	struct f2fs_completion_result ecr = { \
-		COMPLETION_INITIALIZER((ecr).completion), 0 }
-
-static inline int f2fs_encryption_key_size(int mode)
-{
-	switch (mode) {
-	case F2FS_ENCRYPTION_MODE_AES_256_XTS:
-		return F2FS_AES_256_XTS_KEY_SIZE;
-	case F2FS_ENCRYPTION_MODE_AES_256_GCM:
-		return F2FS_AES_256_GCM_KEY_SIZE;
-	case F2FS_ENCRYPTION_MODE_AES_256_CBC:
-		return F2FS_AES_256_CBC_KEY_SIZE;
-	case F2FS_ENCRYPTION_MODE_AES_256_CTS:
-		return F2FS_AES_256_CTS_KEY_SIZE;
-	default:
-		BUG();
-	}
-	return 0;
-}
-
-#define F2FS_FNAME_NUM_SCATTER_ENTRIES	4
-#define F2FS_CRYPTO_BLOCK_SIZE		16
-#define F2FS_FNAME_CRYPTO_DIGEST_SIZE	32
-
-/**
- * For encrypted symlinks, the ciphertext length is stored at the beginning
- * of the string in little-endian format.
- */
-struct f2fs_encrypted_symlink_data {
-	__le16 len;
-	char encrypted_path[1];
-} __attribute__((__packed__));
-
-/**
- * This function is used to calculate the disk space required to
- * store a filename of length l in encrypted symlink format.
- */
-static inline u32 encrypted_symlink_data_len(u32 l)
-{
-	return (l + sizeof(struct f2fs_encrypted_symlink_data) - 1);
-}
-#endif	/* _F2FS_CRYPTO_H */
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 8dea195..aa30ff0 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -421,7 +421,7 @@ static int f2fs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	int err;
 
 	if (f2fs_encrypted_inode(inode)) {
-		err = f2fs_get_encryption_info(inode);
+		err = fscrypt_get_encryption_info(inode);
 		if (err)
 			return 0;
 		if (!f2fs_encrypted_inode(inode))
@@ -443,7 +443,7 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
 	int ret = generic_file_open(inode, filp);
 
 	if (!ret && f2fs_encrypted_inode(inode)) {
-		ret = f2fs_get_encryption_info(inode);
+		ret = fscrypt_get_encryption_info(inode);
 		if (ret)
 			return -EACCES;
 		if (!f2fs_encrypted_inode(inode))
@@ -526,7 +526,8 @@ static int truncate_partial_data_page(struct inode *inode, u64 from,
 truncate_out:
 	f2fs_wait_on_page_writeback(page, DATA, true);
 	zero_user(page, offset, PAGE_CACHE_SIZE - offset);
-	if (!cache_only || !f2fs_encrypted_inode(inode) || !S_ISREG(inode->i_mode))
+	if (!cache_only || !f2fs_encrypted_inode(inode) ||
+					!S_ISREG(inode->i_mode))
 		set_page_dirty(page);
 	f2fs_put_page(page, 1);
 	return 0;
@@ -674,7 +675,7 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 
 	if (attr->ia_valid & ATTR_SIZE) {
 		if (f2fs_encrypted_inode(inode) &&
-				f2fs_get_encryption_info(inode))
+				fscrypt_get_encryption_info(inode))
 			return -EACCES;
 
 		if (attr->ia_size <= i_size_read(inode)) {
@@ -1538,39 +1539,30 @@ static bool uuid_is_nonzero(__u8 u[16])
 
 static int f2fs_ioc_set_encryption_policy(struct file *filp, unsigned long arg)
 {
-#ifdef CONFIG_F2FS_FS_ENCRYPTION
-	struct f2fs_encryption_policy policy;
+	struct fscrypt_policy policy;
 	struct inode *inode = file_inode(filp);
 
-	if (copy_from_user(&policy, (struct f2fs_encryption_policy __user *)arg,
-				sizeof(policy)))
+	if (copy_from_user(&policy, (struct fscrypt_policy __user *)arg,
+							sizeof(policy)))
 		return -EFAULT;
 
 	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
-	return f2fs_process_policy(&policy, inode);
-#else
-	return -EOPNOTSUPP;
-#endif
+	return fscrypt_process_policy(inode, &policy);
 }
 
 static int f2fs_ioc_get_encryption_policy(struct file *filp, unsigned long arg)
 {
-#ifdef CONFIG_F2FS_FS_ENCRYPTION
-	struct f2fs_encryption_policy policy;
+	struct fscrypt_policy policy;
 	struct inode *inode = file_inode(filp);
 	int err;
 
-	err = f2fs_get_policy(inode, &policy);
+	err = fscrypt_get_policy(inode, &policy);
 	if (err)
 		return err;
 
-	if (copy_to_user((struct f2fs_encryption_policy __user *)arg, &policy,
-							sizeof(policy)))
+	if (copy_to_user((struct fscrypt_policy __user *)arg, &policy, sizeof(policy)))
 		return -EFAULT;
 	return 0;
-#else
-	return -EOPNOTSUPP;
-#endif
 }
 
 static int f2fs_ioc_get_encryption_pwsalt(struct file *filp, unsigned long arg)
@@ -1882,8 +1874,8 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	ssize_t ret;
 
 	if (f2fs_encrypted_inode(inode) &&
-				!f2fs_has_encryption_key(inode) &&
-				f2fs_get_encryption_info(inode))
+				!fscrypt_has_encryption_key(inode) &&
+				fscrypt_get_encryption_info(inode))
 		return -EACCES;
 
 	inode_lock(inode);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 0be4a9b..d27347e 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -293,7 +293,7 @@ process_inline:
 }
 
 struct f2fs_dir_entry *find_in_inline_dir(struct inode *dir,
-			struct f2fs_filename *fname, struct page **res_page)
+			struct fscrypt_name *fname, struct page **res_page)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(dir->i_sb);
 	struct f2fs_inline_dentry *inline_dentry;
@@ -551,7 +551,7 @@ bool f2fs_empty_inline_dir(struct inode *dir)
 }
 
 int f2fs_read_inline_dir(struct file *file, struct dir_context *ctx,
-				struct f2fs_str *fstr)
+				struct fscrypt_str *fstr)
 {
 	struct inode *inode = file_inode(file);
 	struct f2fs_inline_dentry *inline_dentry = NULL;
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index d447707..cb269c4 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -389,10 +389,7 @@ no_delete:
 		}
 	}
 out_clear:
-#ifdef CONFIG_F2FS_FS_ENCRYPTION
-	if (fi->i_crypt_info)
-		f2fs_free_encryption_info(inode, fi->i_crypt_info);
-#endif
+	fscrypt_put_encryption_info(inode, NULL);
 	clear_inode(inode);
 }
 
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index fcc8c26..825114a 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -169,7 +169,7 @@ static int f2fs_link(struct dentry *old_dentry, struct inode *dir,
 	int err;
 
 	if (f2fs_encrypted_inode(dir) &&
-		!f2fs_is_child_context_consistent_with_parent(dir, inode))
+			!fscrypt_has_permitted_context(dir, inode))
 		return -EPERM;
 
 	f2fs_balance_fs(sbi, true);
@@ -345,20 +345,20 @@ static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
 	struct inode *inode;
 	size_t len = strlen(symname);
-	struct f2fs_str disk_link = FSTR_INIT((char *)symname, len + 1);
-	struct f2fs_encrypted_symlink_data *sd = NULL;
+	struct fscrypt_str disk_link = FSTR_INIT((char *)symname, len + 1);
+	struct fscrypt_symlink_data *sd = NULL;
 	int err;
 
 	if (f2fs_encrypted_inode(dir)) {
-		err = f2fs_get_encryption_info(dir);
+		err = fscrypt_get_encryption_info(dir);
 		if (err)
 			return err;
 
-		if (!f2fs_encrypted_inode(dir))
+		if (!fscrypt_has_encryption_key(dir))
 			return -EPERM;
 
-		disk_link.len = (f2fs_fname_encrypted_size(dir, len) +
-				sizeof(struct f2fs_encrypted_symlink_data));
+		disk_link.len = (fscrypt_fname_encrypted_size(dir, len) +
+				sizeof(struct fscrypt_symlink_data));
 	}
 
 	if (disk_link.len > dir->i_sb->s_blocksize)
@@ -386,7 +386,7 @@ static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
 
 	if (f2fs_encrypted_inode(inode)) {
 		struct qstr istr = QSTR_INIT(symname, len);
-		struct f2fs_str ostr;
+		struct fscrypt_str ostr;
 
 		sd = kzalloc(disk_link.len, GFP_NOFS);
 		if (!sd) {
@@ -394,18 +394,18 @@ static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
 			goto err_out;
 		}
 
-		err = f2fs_get_encryption_info(inode);
+		err = fscrypt_get_encryption_info(inode);
 		if (err)
 			goto err_out;
 
-		if (!f2fs_encrypted_inode(inode)) {
+		if (!fscrypt_has_encryption_key(inode)) {
 			err = -EPERM;
 			goto err_out;
 		}
 
 		ostr.name = sd->encrypted_path;
 		ostr.len = disk_link.len;
-		err = f2fs_fname_usr_to_disk(inode, &istr, &ostr);
+		err = fscrypt_fname_usr_to_disk(inode, &istr, &ostr);
 		if (err < 0)
 			goto err_out;
 
@@ -586,7 +586,7 @@ out:
 static int f2fs_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
 	if (f2fs_encrypted_inode(dir)) {
-		int err = f2fs_get_encryption_info(dir);
+		int err = fscrypt_get_encryption_info(dir);
 		if (err)
 			return err;
 	}
@@ -615,8 +615,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	int err = -ENOENT;
 
 	if ((old_dir != new_dir) && f2fs_encrypted_inode(new_dir) &&
-		!f2fs_is_child_context_consistent_with_parent(new_dir,
-							old_inode)) {
+			!fscrypt_has_permitted_context(new_dir, old_inode)) {
 		err = -EPERM;
 		goto out;
 	}
@@ -775,11 +774,9 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 	int err = -ENOENT;
 
 	if ((f2fs_encrypted_inode(old_dir) || f2fs_encrypted_inode(new_dir)) &&
-		(old_dir != new_dir) &&
-		(!f2fs_is_child_context_consistent_with_parent(new_dir,
-								old_inode) ||
-		!f2fs_is_child_context_consistent_with_parent(old_dir,
-								new_inode)))
+			(old_dir != new_dir) &&
+			(!fscrypt_has_permitted_context(new_dir, old_inode) ||
+			 !fscrypt_has_permitted_context(old_dir, new_inode)))
 		return -EPERM;
 
 	old_entry = f2fs_find_entry(old_dir, &old_dentry->d_name, &old_page);
@@ -941,16 +938,15 @@ static int f2fs_rename2(struct inode *old_dir, struct dentry *old_dentry,
 	return f2fs_rename(old_dir, old_dentry, new_dir, new_dentry, flags);
 }
 
-#ifdef CONFIG_F2FS_FS_ENCRYPTION
 static const char *f2fs_encrypted_get_link(struct dentry *dentry,
 					   struct inode *inode,
 					   struct delayed_call *done)
 {
 	struct page *cpage = NULL;
 	char *caddr, *paddr = NULL;
-	struct f2fs_str cstr = FSTR_INIT(NULL, 0);
-	struct f2fs_str pstr = FSTR_INIT(NULL, 0);
-	struct f2fs_encrypted_symlink_data *sd;
+	struct fscrypt_str cstr = FSTR_INIT(NULL, 0);
+	struct fscrypt_str pstr = FSTR_INIT(NULL, 0);
+	struct fscrypt_symlink_data *sd;
 	loff_t size = min_t(loff_t, i_size_read(inode), PAGE_SIZE - 1);
 	u32 max_size = inode->i_sb->s_blocksize;
 	int res;
@@ -958,7 +954,7 @@ static const char *f2fs_encrypted_get_link(struct dentry *dentry,
 	if (!dentry)
 		return ERR_PTR(-ECHILD);
 
-	res = f2fs_get_encryption_info(inode);
+	res = fscrypt_get_encryption_info(inode);
 	if (res)
 		return ERR_PTR(res);
 
@@ -969,7 +965,7 @@ static const char *f2fs_encrypted_get_link(struct dentry *dentry,
 	caddr[size] = 0;
 
 	/* Symlink is encrypted */
-	sd = (struct f2fs_encrypted_symlink_data *)caddr;
+	sd = (struct fscrypt_symlink_data *)caddr;
 	cstr.name = sd->encrypted_path;
 	cstr.len = le16_to_cpu(sd->len);
 
@@ -985,17 +981,16 @@ static const char *f2fs_encrypted_get_link(struct dentry *dentry,
 		goto errout;
 	}
 
-	if ((cstr.len + sizeof(struct f2fs_encrypted_symlink_data) - 1) >
-								max_size) {
+	if ((cstr.len + sizeof(struct fscrypt_symlink_data) - 1) > max_size) {
 		/* Symlink data on the disk is corrupted */
 		res = -EIO;
 		goto errout;
 	}
-	res = f2fs_fname_crypto_alloc_buffer(inode, cstr.len, &pstr);
+	res = fscrypt_fname_alloc_buffer(inode, cstr.len, &pstr);
 	if (res)
 		goto errout;
 
-	res = f2fs_fname_disk_to_usr(inode, NULL, &cstr, &pstr);
+	res = fscrypt_fname_disk_to_usr(inode, 0, 0, &cstr, &pstr);
 	if (res < 0)
 		goto errout;
 
@@ -1008,7 +1003,7 @@ static const char *f2fs_encrypted_get_link(struct dentry *dentry,
 	set_delayed_call(done, kfree_link, paddr);
 	return paddr;
 errout:
-	f2fs_fname_crypto_free_buffer(&pstr);
+	fscrypt_fname_free_buffer(&pstr);
 	page_cache_release(cpage);
 	return ERR_PTR(res);
 }
@@ -1025,7 +1020,6 @@ const struct inode_operations f2fs_encrypted_symlink_inode_operations = {
 	.removexattr	= generic_removexattr,
 #endif
 };
-#endif
 
 const struct inode_operations f2fs_dir_inode_operations = {
 	.create		= f2fs_create,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index fa4bbe0..c319484 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -470,10 +470,6 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 
 	/* Will be used by directory only */
 	fi->i_dir_level = F2FS_SB(sb)->dir_level;
-
-#ifdef CONFIG_F2FS_FS_ENCRYPTION
-	fi->i_crypt_info = NULL;
-#endif
 	return &fi->vfs_inode;
 }
 
@@ -507,11 +503,7 @@ static int f2fs_drop_inode(struct inode *inode)
 
 			sb_end_intwrite(inode->i_sb);
 
-#ifdef CONFIG_F2FS_FS_ENCRYPTION
-			if (F2FS_I(inode)->i_crypt_info)
-				f2fs_free_encryption_info(inode,
-					F2FS_I(inode)->i_crypt_info);
-#endif
+			fscrypt_put_encryption_info(inode, NULL);
 			spin_lock(&inode->i_lock);
 			atomic_dec(&inode->i_count);
 		}
@@ -894,6 +886,41 @@ static struct super_operations f2fs_sops = {
 	.remount_fs	= f2fs_remount,
 };
 
+#ifdef CONFIG_F2FS_FS_ENCRYPTION
+static int f2fs_get_context(struct inode *inode, void *ctx, size_t len)
+{
+	return f2fs_getxattr(inode, F2FS_XATTR_INDEX_ENCRYPTION,
+				F2FS_XATTR_NAME_ENCRYPTION_CONTEXT,
+				ctx, len, NULL);
+}
+
+static int f2fs_set_context(struct inode *inode, void *ctx, size_t len,
+							void *fs_data)
+{
+	return f2fs_setxattr(inode, F2FS_XATTR_INDEX_ENCRYPTION,
+				F2FS_XATTR_NAME_ENCRYPTION_CONTEXT,
+				ctx, len, fs_data, XATTR_CREATE);
+}
+
+static unsigned f2fs_max_namelen(struct inode *inode)
+{
+	return S_ISLNK(inode->i_mode) ?
+			inode->i_sb->s_blocksize : F2FS_NAME_LEN;
+}
+
+static struct fscrypt_operations f2fs_cryptops = {
+	.get_context	= f2fs_get_context,
+	.set_context	= f2fs_set_context,
+	.is_encrypted	= f2fs_encrypted_inode,
+	.empty_dir	= f2fs_empty_dir,
+	.max_namelen	= f2fs_max_namelen,
+};
+#else
+static struct fscrypt_operations f2fs_cryptops = {
+	.is_encrypted	= f2fs_encrypted_inode,
+};
+#endif
+
 static struct inode *f2fs_nfs_get_inode(struct super_block *sb,
 		u64 ino, u32 generation)
 {
@@ -1318,6 +1345,7 @@ try_onemore:
 	get_random_bytes(&sbi->s_next_generation, sizeof(u32));
 
 	sb->s_op = &f2fs_sops;
+	sb->s_cop = &f2fs_cryptops;
 	sb->s_xattr = f2fs_xattr_handlers;
 	sb->s_export_op = &f2fs_export_ops;
 	sb->s_magic = F2FS_SUPER_MAGIC;
@@ -1629,13 +1657,9 @@ static int __init init_f2fs_fs(void)
 		err = -ENOMEM;
 		goto free_extent_cache;
 	}
-	err = f2fs_init_crypto();
-	if (err)
-		goto free_kset;
-
 	err = register_shrinker(&f2fs_shrinker_info);
 	if (err)
-		goto free_crypto;
+		goto free_kset;
 
 	err = register_filesystem(&f2fs_fs_type);
 	if (err)
@@ -1650,8 +1674,6 @@ free_filesystem:
 	unregister_filesystem(&f2fs_fs_type);
 free_shrinker:
 	unregister_shrinker(&f2fs_shrinker_info);
-free_crypto:
-	f2fs_exit_crypto();
 free_kset:
 	kset_unregister(f2fs_kset);
 free_extent_cache:
@@ -1674,7 +1696,6 @@ static void __exit exit_f2fs_fs(void)
 	f2fs_destroy_root_stats();
 	unregister_shrinker(&f2fs_shrinker_info);
 	unregister_filesystem(&f2fs_fs_type);
-	f2fs_exit_crypto();
 	destroy_extent_cache();
 	destroy_checkpoint_caches();
 	destroy_segment_manager_caches();
-- 
2.6.3


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
