From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/6] f2fs crypto: get rid of ci_mode from struct
	f2fs_crypt_info
Date: Tue, 12 May 2015 17:40:32 -0700
Message-ID: <1431477634-48111-4-git-send-email-jaegeuk@kernel.org>
References: <1431477634-48111-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YsKjO-0005g4-LW
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 13 May 2015 00:41:02 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YsKjN-0007nW-Ks for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 13 May 2015 00:41:02 +0000
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

"ext4 crypto: get rid of ci_mode from struct ext4_crypt_info

The ci_mode field was superfluous, and getting rid of it gets rid of
an unused hole in the structure."

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/crypto.c       | 11 +++++------
 fs/f2fs/crypto_fname.c |  4 ++--
 fs/f2fs/crypto_key.c   | 12 ++++++------
 fs/f2fs/f2fs_crypto.h  |  1 -
 4 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/fs/f2fs/crypto.c b/fs/f2fs/crypto.c
index 5491d1e..c1a5c6f 100644
--- a/fs/f2fs/crypto.c
+++ b/fs/f2fs/crypto.c
@@ -151,14 +151,13 @@ struct f2fs_crypto_ctx *f2fs_get_crypto_ctx(struct inode *inode)
 	 * Allocate a new Crypto API context if we don't already have
 	 * one or if it isn't the right mode.
 	 */
-	BUG_ON(ci->ci_mode == F2FS_ENCRYPTION_MODE_INVALID);
-	if (ctx->tfm && (ctx->mode != ci->ci_mode)) {
+	if (ctx->tfm && (ctx->mode != ci->ci_data_mode)) {
 		crypto_free_tfm(ctx->tfm);
 		ctx->tfm = NULL;
 		ctx->mode = F2FS_ENCRYPTION_MODE_INVALID;
 	}
 	if (!ctx->tfm) {
-		switch (ci->ci_mode) {
+		switch (ci->ci_data_mode) {
 		case F2FS_ENCRYPTION_MODE_AES_256_XTS:
 			ctx->tfm = crypto_ablkcipher_tfm(
 				crypto_alloc_ablkcipher("xts(aes)", 0, 0));
@@ -178,9 +177,9 @@ struct f2fs_crypto_ctx *f2fs_get_crypto_ctx(struct inode *inode)
 			ctx->tfm = NULL;
 			goto out;
 		}
-		ctx->mode = ci->ci_mode;
+		ctx->mode = ci->ci_data_mode;
 	}
-	BUG_ON(ci->ci_size != f2fs_encryption_key_size(ci->ci_mode));
+	BUG_ON(ci->ci_size != f2fs_encryption_key_size(ci->ci_data_mode));
 
 	/*
 	 * There shouldn't be a bounce page attached to the crypto
@@ -388,7 +387,7 @@ static int f2fs_page_crypto(struct f2fs_crypto_ctx *ctx,
 	int res = 0;
 
 	BUG_ON(!ctx->tfm);
-	BUG_ON(ctx->mode != fi->i_crypt_info->ci_mode);
+	BUG_ON(ctx->mode != fi->i_crypt_info->ci_data_mode);
 
 	if (ctx->mode != F2FS_ENCRYPTION_MODE_AES_256_XTS) {
 		printk_ratelimited(KERN_ERR
diff --git a/fs/f2fs/crypto_fname.c b/fs/f2fs/crypto_fname.c
index 8f3ff9b..e3a1bdc 100644
--- a/fs/f2fs/crypto_fname.c
+++ b/fs/f2fs/crypto_fname.c
@@ -269,9 +269,9 @@ int f2fs_setup_fname_crypto(struct inode *inode)
 	if (!ci || ci->ci_ctfm)
 		return 0;
 
-	if (ci->ci_mode != F2FS_ENCRYPTION_MODE_AES_256_CTS) {
+	if (ci->ci_filename_mode != F2FS_ENCRYPTION_MODE_AES_256_CTS) {
 		printk_once(KERN_WARNING "f2fs: unsupported key mode %d\n",
-				ci->ci_mode);
+				ci->ci_filename_mode);
 		return -ENOKEY;
 	}
 
diff --git a/fs/f2fs/crypto_key.c b/fs/f2fs/crypto_key.c
index 2bdcae5..dbfc616 100644
--- a/fs/f2fs/crypto_key.c
+++ b/fs/f2fs/crypto_key.c
@@ -142,14 +142,14 @@ int _f2fs_get_encryption_info(struct inode *inode)
 	memcpy(crypt_info->ci_master_key, ctx.master_key_descriptor,
 				sizeof(crypt_info->ci_master_key));
 	if (S_ISREG(inode->i_mode))
-		crypt_info->ci_mode = ctx.contents_encryption_mode;
+		crypt_info->ci_size =
+			f2fs_encryption_key_size(crypt_info->ci_data_mode);
 	else if (S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode))
-		crypt_info->ci_mode = ctx.filenames_encryption_mode;
-	else {
-		printk(KERN_ERR "f2fs crypto: Unsupported inode type.\n");
+		crypt_info->ci_size =
+			f2fs_encryption_key_size(crypt_info->ci_filename_mode);
+	else
 		BUG();
-	}
-	crypt_info->ci_size = f2fs_encryption_key_size(crypt_info->ci_mode);
+
 	BUG_ON(!crypt_info->ci_size);
 
 	memcpy(full_key_descriptor, F2FS_KEY_DESC_PREFIX,
diff --git a/fs/f2fs/f2fs_crypto.h b/fs/f2fs/f2fs_crypto.h
index 6e41394..58682d2 100644
--- a/fs/f2fs/f2fs_crypto.h
+++ b/fs/f2fs/f2fs_crypto.h
@@ -75,7 +75,6 @@ struct f2fs_encryption_key {
 } __attribute__((__packed__));
 
 struct f2fs_crypt_info {
-	unsigned char	ci_mode;
 	unsigned char	ci_size;
 	char		ci_data_mode;
 	char		ci_filename_mode;
-- 
2.1.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
