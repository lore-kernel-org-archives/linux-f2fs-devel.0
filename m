From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5/6] f2fs crypto: shrink size of the
	f2fs_crypto_ctx structure
Date: Tue, 12 May 2015 17:40:33 -0700
Message-ID: <1431477634-48111-5-git-send-email-jaegeuk@kernel.org>
References: <1431477634-48111-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YsKjR-0001fo-99
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 13 May 2015 00:41:05 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YsKjQ-0003zW-9T for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 13 May 2015 00:41:05 +0000
In-Reply-To: <1431477634-48111-1-git-send-email-jaegeuk@kernel.org>
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Theodore Ts'o <tytso@mit.edu>

This patch integrates the below patch into f2fs.

"ext4 crypto: shrink size of the ext4_crypto_ctx structure

Some fields are only used when the crypto_ctx is being used on the
read path, some are only used on the write path, and some are only
used when the structure is on free list.  Optimize memory use by using
a union."

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/crypto.c      | 40 ++++++++++++++++++----------------------
 fs/f2fs/f2fs_crypto.h | 21 ++++++++++++++-------
 fs/f2fs/segment.c     |  2 +-
 3 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/fs/f2fs/crypto.c b/fs/f2fs/crypto.c
index c1a5c6f..e36eddd 100644
--- a/fs/f2fs/crypto.c
+++ b/fs/f2fs/crypto.c
@@ -82,14 +82,14 @@ void f2fs_release_crypto_ctx(struct f2fs_crypto_ctx *ctx)
 {
 	unsigned long flags;
 
-	if (ctx->bounce_page) {
+	if (ctx->flags & F2FS_WRITE_PATH_FL && ctx->w.bounce_page) {
 		if (ctx->flags & F2FS_BOUNCE_PAGE_REQUIRES_FREE_ENCRYPT_FL)
-			__free_page(ctx->bounce_page);
+			__free_page(ctx->w.bounce_page);
 		else
-			mempool_free(ctx->bounce_page, f2fs_bounce_page_pool);
-		ctx->bounce_page = NULL;
+			mempool_free(ctx->w.bounce_page, f2fs_bounce_page_pool);
+		ctx->w.bounce_page = NULL;
 	}
-	ctx->control_page = NULL;
+	ctx->w.control_page = NULL;
 	if (ctx->flags & F2FS_CTX_REQUIRES_FREE_ENCRYPT_FL) {
 		if (ctx->tfm)
 			crypto_free_tfm(ctx->tfm);
@@ -146,6 +146,7 @@ struct f2fs_crypto_ctx *f2fs_get_crypto_ctx(struct inode *inode)
 	} else {
 		ctx->flags &= ~F2FS_CTX_REQUIRES_FREE_ENCRYPT_FL;
 	}
+	ctx->flags &= ~F2FS_WRITE_PATH_FL;
 
 	/*
 	 * Allocate a new Crypto API context if we don't already have
@@ -181,12 +182,6 @@ struct f2fs_crypto_ctx *f2fs_get_crypto_ctx(struct inode *inode)
 	}
 	BUG_ON(ci->ci_size != f2fs_encryption_key_size(ci->ci_data_mode));
 
-	/*
-	 * There shouldn't be a bounce page attached to the crypto
-	 * context at this point.
-	 */
-	BUG_ON(ctx->bounce_page);
-
 out:
 	if (res) {
 		if (!IS_ERR_OR_NULL(ctx))
@@ -203,8 +198,8 @@ out:
 static void completion_pages(struct work_struct *work)
 {
 	struct f2fs_crypto_ctx *ctx =
-		container_of(work, struct f2fs_crypto_ctx, work);
-	struct bio *bio	= ctx->bio;
+		container_of(work, struct f2fs_crypto_ctx, r.work);
+	struct bio *bio = ctx->r.bio;
 	struct bio_vec *bv;
 	int i;
 
@@ -225,9 +220,9 @@ static void completion_pages(struct work_struct *work)
 
 void f2fs_end_io_crypto_work(struct f2fs_crypto_ctx *ctx, struct bio *bio)
 {
-	INIT_WORK(&ctx->work, completion_pages);
-	ctx->bio = bio;
-	queue_work(f2fs_read_workqueue, &ctx->work);
+	INIT_WORK(&ctx->r.work, completion_pages);
+	ctx->r.bio = bio;
+	queue_work(f2fs_read_workqueue, &ctx->r.work);
 }
 
 /**
@@ -238,12 +233,12 @@ void f2fs_exit_crypto(void)
 	struct f2fs_crypto_ctx *pos, *n;
 
 	list_for_each_entry_safe(pos, n, &f2fs_free_crypto_ctxs, free_list) {
-		if (pos->bounce_page) {
+		if (pos->w.bounce_page) {
 			if (pos->flags &
 				F2FS_BOUNCE_PAGE_REQUIRES_FREE_ENCRYPT_FL)
-				__free_page(pos->bounce_page);
+				__free_page(pos->w.bounce_page);
 			else
-				mempool_free(pos->bounce_page,
+				mempool_free(pos->w.bounce_page,
 						f2fs_bounce_page_pool);
 		}
 		if (pos->tfm)
@@ -335,7 +330,7 @@ void f2fs_restore_and_release_control_page(struct page **page)
 	ctx = (struct f2fs_crypto_ctx *)page_private(bounce_page);
 
 	/* restore control page */
-	*page = ctx->control_page;
+	*page = ctx->w.control_page;
 
 	f2fs_restore_control_page(bounce_page);
 }
@@ -492,8 +487,9 @@ struct page *f2fs_encrypt(struct inode *inode,
 	} else {
 		ctx->flags |= F2FS_BOUNCE_PAGE_REQUIRES_FREE_ENCRYPT_FL;
 	}
-	ctx->bounce_page = ciphertext_page;
-	ctx->control_page = plaintext_page;
+	ctx->flags |= F2FS_WRITE_PATH_FL;
+	ctx->w.bounce_page = ciphertext_page;
+	ctx->w.control_page = plaintext_page;
 	err = f2fs_page_crypto(ctx, inode, F2FS_ENCRYPT, plaintext_page->index,
 					plaintext_page, ciphertext_page);
 	if (err) {
diff --git a/fs/f2fs/f2fs_crypto.h b/fs/f2fs/f2fs_crypto.h
index 58682d2..e33cec9 100644
--- a/fs/f2fs/f2fs_crypto.h
+++ b/fs/f2fs/f2fs_crypto.h
@@ -87,16 +87,23 @@ struct f2fs_crypt_info {
 
 #define F2FS_CTX_REQUIRES_FREE_ENCRYPT_FL             0x00000001
 #define F2FS_BOUNCE_PAGE_REQUIRES_FREE_ENCRYPT_FL     0x00000002
+#define F2FS_WRITE_PATH_FL			      0x00000004
 
 struct f2fs_crypto_ctx {
 	struct crypto_tfm *tfm;         /* Crypto API context */
-	struct page *bounce_page;       /* Ciphertext page on write path */
-	struct page *control_page;      /* Original page on write path */
-	struct bio *bio;                /* The bio for this context */
-	struct work_struct work;        /* Work queue for read complete path */
-	struct list_head free_list;     /* Free list */
-	int flags;                      /* Flags */
-	int mode;                       /* Encryption mode for tfm */
+	union {
+		struct {
+			struct page *bounce_page;       /* Ciphertext page */
+			struct page *control_page;      /* Original page  */
+		} w;
+		struct {
+			struct bio *bio;
+			struct work_struct work;
+		} r;
+		struct list_head free_list;     /* Free list */
+	};
+	char flags;                      /* Flags */
+	char mode;                       /* Encryption mode for tfm */
 };
 
 struct f2fs_completion_result {
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 17e89ba..70d1ccb 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1369,7 +1369,7 @@ static inline bool is_merged_page(struct f2fs_sb_info *sbi,
 			/* encrypted page */
 			ctx = (struct f2fs_crypto_ctx *)page_private(
 								bvec->bv_page);
-			target = ctx->control_page;
+			target = ctx->w.control_page;
 		}
 
 		if (page == target) {
-- 
2.1.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
