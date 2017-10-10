From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs/crypto: drop crypto key at evict_inode only
Date: Tue, 10 Oct 2017 10:56:46 -0700
Message-ID: <20171010175646.9211-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch avoids dropping crypto key in f2fs_drop_inode, so we can guarantee
it happens only at evict_inode.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index dc05b16df514..f10a1b1380c2 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -717,7 +717,6 @@ static int f2fs_drop_inode(struct inode *inode)
 
 			sb_end_intwrite(inode->i_sb);
 
-			fscrypt_put_encryption_info(inode, NULL);
 			spin_lock(&inode->i_lock);
 			atomic_dec(&inode->i_count);
 		}
-- 
2.14.0.rc1.383.gd1ce394fe2-goog
