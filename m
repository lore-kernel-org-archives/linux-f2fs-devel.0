From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/5] f2fs crypto: f2fs_page_crypto() doesn't need
	a encryption context
Date: Mon,  8 Feb 2016 17:34:15 -0800
Message-ID: <1454981657-25473-3-git-send-email-jaegeuk@kernel.org>
References: <1454981657-25473-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aSxCI-0005Jp-4G
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 09 Feb 2016 01:34:30 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aSxCH-0003bZ-7W for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 09 Feb 2016 01:34:30 +0000
In-Reply-To: <1454981657-25473-1-git-send-email-jaegeuk@kernel.org>
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

This patch adopts:
	ext4 crypto: ext4_page_crypto() doesn't need a encryption context

Since ext4_page_crypto() doesn't need an encryption context (at least
not any more), this allows us to simplify a number function signature
and also allows us to avoid needing to allocate a context in
ext4_block_write_begin().  It also means we no longer need a separate
ext4_decrypt_one() function.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/crypto.c | 27 +++++----------------------
 fs/f2fs/data.c   |  2 +-
 fs/f2fs/f2fs.h   |  3 +--
 3 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/fs/f2fs/crypto.c b/fs/f2fs/crypto.c
index d879c6c..3ef3786 100644
--- a/fs/f2fs/crypto.c
+++ b/fs/f2fs/crypto.c
@@ -156,7 +156,7 @@ static void completion_pages(struct work_struct *work)
 
 	bio_for_each_segment_all(bv, bio, i) {
 		struct page *page = bv->bv_page;
-		int ret = f2fs_decrypt(ctx, page);
+		int ret = f2fs_decrypt(page);
 
 		if (ret) {
 			WARN_ON_ONCE(1);
@@ -320,8 +320,7 @@ typedef enum {
 	F2FS_ENCRYPT,
 } f2fs_direction_t;
 
-static int f2fs_page_crypto(struct f2fs_crypto_ctx *ctx,
-				struct inode *inode,
+static int f2fs_page_crypto(struct inode *inode,
 				f2fs_direction_t rw,
 				pgoff_t index,
 				struct page *src_page,
@@ -418,7 +417,7 @@ struct page *f2fs_encrypt(struct inode *inode,
 		goto err_out;
 
 	ctx->w.control_page = plaintext_page;
-	err = f2fs_page_crypto(ctx, inode, F2FS_ENCRYPT, plaintext_page->index,
+	err = f2fs_page_crypto(inode, F2FS_ENCRYPT, plaintext_page->index,
 					plaintext_page, ciphertext_page);
 	if (err) {
 		ciphertext_page = ERR_PTR(err);
@@ -446,30 +445,14 @@ err_out:
  *
  * Return: Zero on success, non-zero otherwise.
  */
-int f2fs_decrypt(struct f2fs_crypto_ctx *ctx, struct page *page)
+int f2fs_decrypt(struct page *page)
 {
 	BUG_ON(!PageLocked(page));
 
-	return f2fs_page_crypto(ctx, page->mapping->host,
+	return f2fs_page_crypto(page->mapping->host,
 				F2FS_DECRYPT, page->index, page, page);
 }
 
-/*
- * Convenience function which takes care of allocating and
- * deallocating the encryption context
- */
-int f2fs_decrypt_one(struct inode *inode, struct page *page)
-{
-	struct f2fs_crypto_ctx *ctx = f2fs_get_crypto_ctx(inode);
-	int ret;
-
-	if (IS_ERR(ctx))
-		return PTR_ERR(ctx);
-	ret = f2fs_decrypt(ctx, page);
-	f2fs_release_crypto_ctx(ctx);
-	return ret;
-}
-
 bool f2fs_valid_contents_enc_mode(uint32_t mode)
 {
 	return (mode == F2FS_ENCRYPTION_MODE_AES_256_XTS);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 03f948e..ca99a2a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1592,7 +1592,7 @@ repeat:
 
 		/* avoid symlink page */
 		if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode)) {
-			err = f2fs_decrypt_one(inode, page);
+			err = f2fs_decrypt(page);
 			if (err)
 				goto fail;
 		}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f6a841b..66a87cb 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2213,8 +2213,7 @@ uint32_t f2fs_validate_encryption_key_size(uint32_t, uint32_t);
 struct f2fs_crypto_ctx *f2fs_get_crypto_ctx(struct inode *);
 void f2fs_release_crypto_ctx(struct f2fs_crypto_ctx *);
 struct page *f2fs_encrypt(struct inode *, struct page *);
-int f2fs_decrypt(struct f2fs_crypto_ctx *, struct page *);
-int f2fs_decrypt_one(struct inode *, struct page *);
+int f2fs_decrypt(struct page *);
 void f2fs_end_io_crypto_work(struct f2fs_crypto_ctx *, struct bio *);
 
 /* crypto_key.c */
-- 
2.6.3


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
