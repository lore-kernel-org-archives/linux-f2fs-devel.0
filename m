From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs crypto: fix to handle errors likewise ext4
Date: Thu, 11 Jun 2015 16:03:22 -0700
Message-ID: <1434063803-76042-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch makes some error handling policies same with ext4.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/crypto.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/crypto.c b/fs/f2fs/crypto.c
index be6af18..75d62ff 100644
--- a/fs/f2fs/crypto.c
+++ b/fs/f2fs/crypto.c
@@ -112,7 +112,7 @@ struct f2fs_crypto_ctx *f2fs_get_crypto_ctx(struct inode *inode)
 	struct f2fs_crypt_info *ci = F2FS_I(inode)->i_crypt_info;
 
 	if (ci == NULL)
-		return ERR_PTR(-EACCES);
+		return ERR_PTR(-ENOKEY);
 
 	/*
 	 * We first try getting the ctx from a free list because in
@@ -457,8 +457,8 @@ int f2fs_decrypt_one(struct inode *inode, struct page *page)
 	struct f2fs_crypto_ctx *ctx = f2fs_get_crypto_ctx(inode);
 	int ret;
 
-	if (!ctx)
-		return -ENOMEM;
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
 	ret = f2fs_decrypt(ctx, page);
 	f2fs_release_crypto_ctx(ctx);
 	return ret;
-- 
2.1.1
