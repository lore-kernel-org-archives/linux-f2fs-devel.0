From: Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 02/13] fscrypt: remove the "write" part of struct
 fscrypt_ctx
Date: Wed,  1 May 2019 15:45:04 -0700
Message-ID: <20190501224515.43059-3-ebiggers@kernel.org>
References: <20190501224515.43059-1-ebiggers@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1hLxzQ-0005Tl-JD
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 01 May 2019 22:46:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hLxzP-002XuT-AK
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 01 May 2019 22:46:12 +0000
In-Reply-To: <20190501224515.43059-1-ebiggers@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-fscrypt@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-mtd@lists.infradead.org, Chandan Rajendra <chandan@linux.ibm.com>, linux-f2fs-devel@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

Now that fscrypt_ctx is not used for writes, remove the 'w' fields.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/bio.c         | 11 +++++------
 fs/crypto/crypto.c      | 14 +++++++-------
 include/linux/fscrypt.h |  7 ++-----
 3 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 9107e8fe55897..548ec6bb569cf 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -54,9 +54,8 @@ EXPORT_SYMBOL(fscrypt_decrypt_bio);
 
 static void completion_pages(struct work_struct *work)
 {
-	struct fscrypt_ctx *ctx =
-		container_of(work, struct fscrypt_ctx, r.work);
-	struct bio *bio = ctx->r.bio;
+	struct fscrypt_ctx *ctx = container_of(work, struct fscrypt_ctx, work);
+	struct bio *bio = ctx->bio;
 
 	__fscrypt_decrypt_bio(bio, true);
 	fscrypt_release_ctx(ctx);
@@ -65,9 +64,9 @@ static void completion_pages(struct work_struct *work)
 
 void fscrypt_enqueue_decrypt_bio(struct fscrypt_ctx *ctx, struct bio *bio)
 {
-	INIT_WORK(&ctx->r.work, completion_pages);
-	ctx->r.bio = bio;
-	fscrypt_enqueue_decrypt_work(&ctx->r.work);
+	INIT_WORK(&ctx->work, completion_pages);
+	ctx->bio = bio;
+	fscrypt_enqueue_decrypt_work(&ctx->work);
 }
 EXPORT_SYMBOL(fscrypt_enqueue_decrypt_bio);
 
diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index 4b076f8daab75..ebfa13cfecb7d 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -58,11 +58,11 @@ void fscrypt_enqueue_decrypt_work(struct work_struct *work)
 EXPORT_SYMBOL(fscrypt_enqueue_decrypt_work);
 
 /**
- * fscrypt_release_ctx() - Releases an encryption context
- * @ctx: The encryption context to release.
+ * fscrypt_release_ctx() - Release a decryption context
+ * @ctx: The decryption context to release.
  *
- * If the encryption context was allocated from the pre-allocated pool, returns
- * it to that pool. Else, frees it.
+ * If the decryption context was allocated from the pre-allocated pool, return
+ * it to that pool.  Else, free it.
  */
 void fscrypt_release_ctx(struct fscrypt_ctx *ctx)
 {
@@ -79,12 +79,12 @@ void fscrypt_release_ctx(struct fscrypt_ctx *ctx)
 EXPORT_SYMBOL(fscrypt_release_ctx);
 
 /**
- * fscrypt_get_ctx() - Gets an encryption context
+ * fscrypt_get_ctx() - Get a decryption context
  * @gfp_flags:   The gfp flag for memory allocation
  *
- * Allocates and initializes an encryption context.
+ * Allocate and initialize a decryption context.
  *
- * Return: A new encryption context on success; an ERR_PTR() otherwise.
+ * Return: A new decryption context on success; an ERR_PTR() otherwise.
  */
 struct fscrypt_ctx *fscrypt_get_ctx(gfp_t gfp_flags)
 {
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 77837e72e4add..11e7187fa2e52 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -63,16 +63,13 @@ struct fscrypt_operations {
 	unsigned int max_namelen;
 };
 
+/* Decryption work */
 struct fscrypt_ctx {
 	union {
-		struct {
-			struct page *bounce_page;	/* Ciphertext page */
-			struct page *control_page;	/* Original page  */
-		} w;
 		struct {
 			struct bio *bio;
 			struct work_struct work;
-		} r;
+		};
 		struct list_head free_list;	/* Free list */
 	};
 	u8 flags;				/* Flags */
-- 
2.21.0.593.g511ec345e18-goog
