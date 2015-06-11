From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs crypto: add alloc_bounce_page
Date: Thu, 11 Jun 2015 16:03:23 -0700
Message-ID: <1434063803-76042-2-git-send-email-jaegeuk@kernel.org>
References: <1434063803-76042-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Z3BVX-0004Y8-Jk
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 11 Jun 2015 23:03:35 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Z3BVW-0003nf-R9 for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 11 Jun 2015 23:03:35 +0000
In-Reply-To: <1434063803-76042-1-git-send-email-jaegeuk@kernel.org>
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch adds alloc_bounce_page likewise ext4.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/crypto.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/crypto.c b/fs/f2fs/crypto.c
index 75d62ff..4a62ef1 100644
--- a/fs/f2fs/crypto.c
+++ b/fs/f2fs/crypto.c
@@ -376,6 +376,15 @@ static int f2fs_page_crypto(struct f2fs_crypto_ctx *ctx,
 	return 0;
 }
 
+static struct page *alloc_bounce_page(struct f2fs_crypto_ctx *ctx)
+{
+	ctx->w.bounce_page = mempool_alloc(f2fs_bounce_page_pool, GFP_NOWAIT);
+	if (ctx->w.bounce_page == NULL)
+		return ERR_PTR(-ENOMEM);
+	ctx->flags |= F2FS_WRITE_PATH_FL;
+	return ctx->w.bounce_page;
+}
+
 /**
  * f2fs_encrypt() - Encrypts a page
  * @inode:          The inode for which the encryption should take place
@@ -405,19 +414,17 @@ struct page *f2fs_encrypt(struct inode *inode,
 		return (struct page *)ctx;
 
 	/* The encryption operation will require a bounce page. */
-	ciphertext_page = mempool_alloc(f2fs_bounce_page_pool, GFP_NOWAIT);
-	if (!ciphertext_page) {
-		err = -ENOMEM;
+	ciphertext_page = alloc_bounce_page(ctx);
+	if (IS_ERR(ciphertext_page))
 		goto err_out;
-	}
 
-	ctx->flags |= F2FS_WRITE_PATH_FL;
-	ctx->w.bounce_page = ciphertext_page;
 	ctx->w.control_page = plaintext_page;
 	err = f2fs_page_crypto(ctx, inode, F2FS_ENCRYPT, plaintext_page->index,
 					plaintext_page, ciphertext_page);
-	if (err)
+	if (err) {
+		ciphertext_page = ERR_PTR(err);
 		goto err_out;
+	}
 
 	SetPagePrivate(ciphertext_page);
 	set_page_private(ciphertext_page, (unsigned long)ctx);
@@ -426,7 +433,7 @@ struct page *f2fs_encrypt(struct inode *inode,
 
 err_out:
 	f2fs_release_crypto_ctx(ctx);
-	return ERR_PTR(err);
+	return ciphertext_page;
 }
 
 /**
-- 
2.1.1


------------------------------------------------------------------------------
