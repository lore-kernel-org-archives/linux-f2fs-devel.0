From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs crypto: use inode number for xts_tweak
Date: Mon, 11 May 2015 20:51:03 -0700
Message-ID: <1431402663-24809-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Previoulsy when making xts_tweak, page->index was used.
But, when it supports fcollapse, the block address was moved, so that we can
lose the original page->index, which causes decrytion failure.

In order to avoid that, let's use the inode->i_ino for xfs_tweak hint.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/crypto.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/crypto.c b/fs/f2fs/crypto.c
index 1dd0835..35986a5 100644
--- a/fs/f2fs/crypto.c
+++ b/fs/f2fs/crypto.c
@@ -375,7 +375,6 @@ typedef enum {
 static int f2fs_page_crypto(struct f2fs_crypto_ctx *ctx,
 				struct inode *inode,
 				f2fs_direction_t rw,
-				pgoff_t index,
 				struct page *src_page,
 				struct page *dest_page)
 
@@ -420,10 +419,10 @@ static int f2fs_page_crypto(struct f2fs_crypto_ctx *ctx,
 		req, CRYPTO_TFM_REQ_MAY_BACKLOG | CRYPTO_TFM_REQ_MAY_SLEEP,
 		f2fs_crypt_complete, &ecr);
 
-	BUILD_BUG_ON(F2FS_XTS_TWEAK_SIZE < sizeof(index));
-	memcpy(xts_tweak, &index, sizeof(index));
-	memset(&xts_tweak[sizeof(index)], 0,
-			F2FS_XTS_TWEAK_SIZE - sizeof(index));
+	BUILD_BUG_ON(F2FS_XTS_TWEAK_SIZE < sizeof(inode->i_ino));
+	memcpy(xts_tweak, &inode->i_ino, sizeof(inode->i_ino));
+	memset(&xts_tweak[sizeof(inode->i_ino)], 0,
+			F2FS_XTS_TWEAK_SIZE - sizeof(inode->i_ino));
 
 	sg_init_table(&dst, 1);
 	sg_set_page(&dst, dest_page, PAGE_CACHE_SIZE, 0);
@@ -496,7 +495,7 @@ struct page *f2fs_encrypt(struct inode *inode,
 	}
 	ctx->bounce_page = ciphertext_page;
 	ctx->control_page = plaintext_page;
-	err = f2fs_page_crypto(ctx, inode, F2FS_ENCRYPT, plaintext_page->index,
+	err = f2fs_page_crypto(ctx, inode, F2FS_ENCRYPT,
 					plaintext_page, ciphertext_page);
 	if (err) {
 		f2fs_release_crypto_ctx(ctx);
@@ -524,7 +523,7 @@ int f2fs_decrypt(struct f2fs_crypto_ctx *ctx, struct page *page)
 	BUG_ON(!PageLocked(page));
 
 	return f2fs_page_crypto(ctx, page->mapping->host,
-				F2FS_DECRYPT, page->index, page, page);
+					F2FS_DECRYPT, page, page);
 }
 
 /*
-- 
2.1.1
