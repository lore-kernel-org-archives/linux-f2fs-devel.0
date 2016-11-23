From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: fix overflow due to condition check order
Date: Wed, 23 Nov 2016 12:35:15 -0800
Message-ID: <20161123203515.43720-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: stable@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

In the last ilen case, i was already increased, resulting in accessing out-
of-boundary entry of do_replace and blkaddr.
Fix to check ilen first to exit the loop.

Fixes: 2aa8fbb9693020 ("f2fs: refactor __exchange_data_block for speed up")
Cc: stable@vger.kernel.org # 4.8+
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c786507..0237217 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -967,7 +967,7 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
 				new_size = (dst + i) << PAGE_SHIFT;
 				if (dst_inode->i_size < new_size)
 					f2fs_i_size_write(dst_inode, new_size);
-			} while ((do_replace[i] || blkaddr[i] == NULL_ADDR) && --ilen);
+			} while (--ilen && (do_replace[i] || blkaddr[i] == NULL_ADDR));
 
 			f2fs_put_dnode(&dn);
 		} else {
-- 
2.8.3
