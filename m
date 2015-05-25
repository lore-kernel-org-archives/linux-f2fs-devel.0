From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 3/3] f2fs crypto: allow setting encryption policy once
Date: Mon, 25 May 2015 18:09:03 +0800
Message-ID: <00d601d096d2$ee2c65d0$ca853170$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch add XATTR_CREATE flag in setxattr when setting encryption
context for inode. Without this flag the context could be set more than
once, this should never happen. So, fix it.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/crypto_policy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/crypto_policy.c b/fs/f2fs/crypto_policy.c
index 56b2ac0..71b3a5a 100644
--- a/fs/f2fs/crypto_policy.c
+++ b/fs/f2fs/crypto_policy.c
@@ -83,7 +83,7 @@ static int f2fs_create_encryption_context_from_policy(
 
 	return f2fs_setxattr(inode, F2FS_XATTR_INDEX_ENCRYPTION,
 			F2FS_XATTR_NAME_ENCRYPTION_CONTEXT, &ctx,
-			sizeof(ctx), NULL, 0);
+			sizeof(ctx), NULL, XATTR_CREATE);
 }
 
 int f2fs_process_policy(const struct f2fs_encryption_policy *policy,
@@ -202,5 +202,5 @@ int f2fs_inherit_context(struct inode *parent, struct inode *child,
 	get_random_bytes(ctx.nonce, F2FS_KEY_DERIVATION_NONCE_SIZE);
 	return f2fs_setxattr(child, F2FS_XATTR_INDEX_ENCRYPTION,
 				F2FS_XATTR_NAME_ENCRYPTION_CONTEXT, &ctx,
-				sizeof(ctx), ipage, 0);
+				sizeof(ctx), ipage, XATTR_CREATE);
 }
-- 
2.3.0
