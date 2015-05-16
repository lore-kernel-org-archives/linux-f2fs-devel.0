From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs crypto: split f2fs_crypto_init/exit with two parts
Date: Fri, 15 May 2015 20:59:37 -0700
Message-ID: <1431748777-19569-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch splits f2fs_crypto_init/exit with two parts: base initialization and
memory allocation.

Firstly, f2fs module declares the base encryption memory pointers.
Then, allocating internal memories is done at the first encrypted inode access.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/crypto.c     | 90 ++++++++++++++++++++++++++++++----------------------
 fs/f2fs/crypto_key.c |  8 ++---
 fs/f2fs/f2fs.h       |  6 ++--
 fs/f2fs/super.c      |  8 ++++-
 4 files changed, 65 insertions(+), 47 deletions(-)

diff --git a/fs/f2fs/crypto.c b/fs/f2fs/crypto.c
index 7f1ee9e..31fe051 100644
--- a/fs/f2fs/crypto.c
+++ b/fs/f2fs/crypto.c
@@ -63,7 +63,7 @@ static mempool_t *f2fs_bounce_page_pool;
 static LIST_HEAD(f2fs_free_crypto_ctxs);
 static DEFINE_SPINLOCK(f2fs_crypto_ctx_lock);
 
-struct workqueue_struct *f2fs_read_workqueue;
+static struct workqueue_struct *f2fs_read_workqueue;
 static DEFINE_MUTEX(crypto_init);
 
 static struct kmem_cache *f2fs_crypto_ctx_cachep;
@@ -225,10 +225,7 @@ void f2fs_end_io_crypto_work(struct f2fs_crypto_ctx *ctx, struct bio *bio)
 	queue_work(f2fs_read_workqueue, &ctx->r.work);
 }
 
-/**
- * f2fs_exit_crypto() - Shutdown the f2fs encryption system
- */
-void f2fs_exit_crypto(void)
+static void f2fs_crypto_destroy(void)
 {
 	struct f2fs_crypto_ctx *pos, *n;
 
@@ -241,73 +238,90 @@ void f2fs_exit_crypto(void)
 	if (f2fs_bounce_page_pool)
 		mempool_destroy(f2fs_bounce_page_pool);
 	f2fs_bounce_page_pool = NULL;
-	if (f2fs_read_workqueue)
-		destroy_workqueue(f2fs_read_workqueue);
-	f2fs_read_workqueue = NULL;
-	if (f2fs_crypto_ctx_cachep)
-		kmem_cache_destroy(f2fs_crypto_ctx_cachep);
-	f2fs_crypto_ctx_cachep = NULL;
-	if (f2fs_crypt_info_cachep)
-		kmem_cache_destroy(f2fs_crypt_info_cachep);
-	f2fs_crypt_info_cachep = NULL;
 }
 
 /**
- * f2fs_init_crypto() - Set up for f2fs encryption.
+ * f2fs_crypto_initialize() - Set up for f2fs encryption.
  *
  * We only call this when we start accessing encrypted files, since it
  * results in memory getting allocated that wouldn't otherwise be used.
  *
  * Return: Zero on success, non-zero otherwise.
  */
-int f2fs_init_crypto(void)
+int f2fs_crypto_initialize(void)
 {
 	int i, res = -ENOMEM;
 
+	if (f2fs_bounce_page_pool)
+		return 0;
+
 	mutex_lock(&crypto_init);
-	if (f2fs_read_workqueue)
+	if (f2fs_bounce_page_pool)
 		goto already_initialized;
 
-	f2fs_read_workqueue = alloc_workqueue("f2fs_crypto", WQ_HIGHPRI, 0);
-	if (!f2fs_read_workqueue)
-		goto fail;
-
-	f2fs_crypto_ctx_cachep = KMEM_CACHE(f2fs_crypto_ctx,
-					    SLAB_RECLAIM_ACCOUNT);
-	if (!f2fs_crypto_ctx_cachep)
-		goto fail;
-
-	f2fs_crypt_info_cachep = KMEM_CACHE(f2fs_crypt_info,
-					    SLAB_RECLAIM_ACCOUNT);
-	if (!f2fs_crypt_info_cachep)
-		goto fail;
-
 	for (i = 0; i < num_prealloc_crypto_ctxs; i++) {
 		struct f2fs_crypto_ctx *ctx;
 
 		ctx = kmem_cache_zalloc(f2fs_crypto_ctx_cachep, GFP_KERNEL);
-		if (!ctx) {
-			res = -ENOMEM;
+		if (!ctx)
 			goto fail;
-		}
 		list_add(&ctx->free_list, &f2fs_free_crypto_ctxs);
 	}
 
+	/* must be allocated at the last step to avoid race condition above */
 	f2fs_bounce_page_pool =
 		mempool_create_page_pool(num_prealloc_crypto_pages, 0);
-	if (!f2fs_bounce_page_pool) {
-		res = -ENOMEM;
+	if (!f2fs_bounce_page_pool)
 		goto fail;
-	}
+
 already_initialized:
 	mutex_unlock(&crypto_init);
 	return 0;
 fail:
-	f2fs_exit_crypto();
+	f2fs_crypto_destroy();
 	mutex_unlock(&crypto_init);
 	return res;
 }
 
+/**
+ * f2fs_exit_crypto() - Shutdown the f2fs encryption system
+ */
+void f2fs_exit_crypto(void)
+{
+	f2fs_crypto_destroy();
+
+	if (f2fs_read_workqueue)
+		destroy_workqueue(f2fs_read_workqueue);
+	if (f2fs_crypto_ctx_cachep)
+		kmem_cache_destroy(f2fs_crypto_ctx_cachep);
+	if (f2fs_crypt_info_cachep)
+		kmem_cache_destroy(f2fs_crypt_info_cachep);
+}
+
+int __init f2fs_init_crypto()
+{
+	int res = -ENOMEM;
+
+	f2fs_read_workqueue = alloc_workqueue("f2fs_crypto", WQ_HIGHPRI, 0);
+	if (!f2fs_read_workqueue)
+		goto fail;
+
+	f2fs_crypto_ctx_cachep = KMEM_CACHE(f2fs_crypto_ctx,
+						SLAB_RECLAIM_ACCOUNT);
+	if (!f2fs_crypto_ctx_cachep)
+		goto fail;
+
+	f2fs_crypt_info_cachep = KMEM_CACHE(f2fs_crypt_info,
+						SLAB_RECLAIM_ACCOUNT);
+	if (!f2fs_crypt_info_cachep)
+		goto fail;
+
+	return 0;
+fail:
+	f2fs_exit_crypto();
+	return res;
+}
+
 void f2fs_restore_and_release_control_page(struct page **page)
 {
 	struct f2fs_crypto_ctx *ctx;
diff --git a/fs/f2fs/crypto_key.c b/fs/f2fs/crypto_key.c
index 5ae9cc8..8a10569 100644
--- a/fs/f2fs/crypto_key.c
+++ b/fs/f2fs/crypto_key.c
@@ -115,11 +115,9 @@ int _f2fs_get_encryption_info(struct inode *inode)
 	struct user_key_payload *ukp;
 	int res;
 
-	if (!f2fs_read_workqueue) {
-		res = f2fs_init_crypto();
-		if (res)
-			return res;
-	}
+	res = f2fs_crypto_initialize();
+	if (res)
+		return res;
 
 	if (fi->i_crypt_info) {
 		if (!fi->i_crypt_info->ci_keyring_key ||
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ce30896..6ed38c0 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2007,7 +2007,6 @@ int f2fs_get_policy(struct inode *, struct f2fs_encryption_policy *);
 
 /* crypt.c */
 extern struct kmem_cache *f2fs_crypt_info_cachep;
-extern struct workqueue_struct *f2fs_read_workqueue;
 bool f2fs_valid_contents_enc_mode(uint32_t);
 uint32_t f2fs_validate_encryption_key_size(uint32_t, uint32_t);
 struct f2fs_crypto_ctx *f2fs_get_crypto_ctx(struct inode *);
@@ -2034,7 +2033,8 @@ int f2fs_fname_usr_to_disk(struct inode *, const struct qstr *,
 void f2fs_restore_and_release_control_page(struct page **);
 void f2fs_restore_control_page(struct page *);
 
-int f2fs_init_crypto(void);
+int __init f2fs_init_crypto(void);
+int f2fs_crypto_initialize(void);
 void f2fs_exit_crypto(void);
 
 int f2fs_has_encryption_key(struct inode *);
@@ -2061,7 +2061,7 @@ void f2fs_fname_free_filename(struct f2fs_filename *);
 static inline void f2fs_restore_and_release_control_page(struct page **p) { }
 static inline void f2fs_restore_control_page(struct page *p) { }
 
-static inline int f2fs_init_crypto(void) { return 0; }
+static inline int __init f2fs_init_crypto(void) { return 0; }
 static inline void f2fs_exit_crypto(void) { }
 
 static inline int f2fs_has_encryption_key(struct inode *i) { return 0; }
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 98af3bf..03f7f54 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1350,13 +1350,18 @@ static int __init init_f2fs_fs(void)
 		err = -ENOMEM;
 		goto free_extent_cache;
 	}
-	err = register_filesystem(&f2fs_fs_type);
+	err = f2fs_init_crypto();
 	if (err)
 		goto free_kset;
+	err = register_filesystem(&f2fs_fs_type);
+	if (err)
+		goto free_crypto;
 	f2fs_create_root_stats();
 	f2fs_proc_root = proc_mkdir("fs/f2fs", NULL);
 	return 0;
 
+free_crypto:
+	f2fs_exit_crypto();
 free_kset:
 	kset_unregister(f2fs_kset);
 free_extent_cache:
@@ -1378,6 +1383,7 @@ static void __exit exit_f2fs_fs(void)
 	remove_proc_entry("fs/f2fs", NULL);
 	f2fs_destroy_root_stats();
 	unregister_filesystem(&f2fs_fs_type);
+	f2fs_exit_crypto();
 	destroy_extent_cache();
 	destroy_checkpoint_caches();
 	destroy_segment_manager_caches();
-- 
2.1.1
