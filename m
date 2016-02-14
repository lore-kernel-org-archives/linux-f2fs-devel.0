From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 5/7] f2fs crypto: set up encryption info for new inodes in
 f2fs_inherit_context()
Date: Sun, 14 Feb 2016 18:55:49 +0800
Message-ID: <00fe01d16716$5ec0a540$1c41efc0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, tytso@mit.edu
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch syncs f2fs with commit 555570295532 ("ext4 crypto: set up
encryption info for new inodes in ext4_inherit_context()") from ext4.

Set up the encryption information for newly created inodes immediately
after they inherit their encryption context from their parent
directories.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/crypto_policy.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/crypto_policy.c b/fs/f2fs/crypto_policy.c
index d4a96af..0fb08b0 100644
--- a/fs/f2fs/crypto_policy.c
+++ b/fs/f2fs/crypto_policy.c
@@ -203,7 +203,10 @@ int f2fs_inherit_context(struct inode *parent, struct inode *child,
 			F2FS_KEY_DESCRIPTOR_SIZE);
 
 	get_random_bytes(ctx.nonce, F2FS_KEY_DERIVATION_NONCE_SIZE);
-	return f2fs_setxattr(child, F2FS_XATTR_INDEX_ENCRYPTION,
+	res = f2fs_setxattr(child, F2FS_XATTR_INDEX_ENCRYPTION,
 				F2FS_XATTR_NAME_ENCRYPTION_CONTEXT, &ctx,
 				sizeof(ctx), ipage, XATTR_CREATE);
+	if (!res)
+		res = f2fs_get_encryption_info(child);
+	return res;
 }
-- 
2.7.0.2.g1b0b6dd
