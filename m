From: Daeho Jeong <daeho.jeong@samsung.com>
Subject: [PATCH] f2fs: handle newly created page when revoking inmem pages
Date: Wed, 10 Jan 2018 11:43:54 +0900
Message-ID: <1515552234-27964-1-git-send-email-daeho.jeong@samsung.com>
References: <CGME20180110024336epcas2p1003559800e7f1e59a79496fc5b79cf04@epcas2p1.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Daeho Jeong <daeho.jeong@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

When committing inmem pages is successful, we revoke already committed
blocks in __revoke_inmem_pages() and finally replace the committed
ones with the old blocks using f2fs_replace_block(). However, if
the committed block was newly created one, the address of the old
block is NEW_ADDR and __f2fs_replace_block() cannot handle NEW_ADDR
as new_blkaddr properly and a kernel panic occurrs.

Signed-off-by: Daeho Jeong <daeho.jeong@samsung.com>
Tested-by: Shu Tan <shu.tan@samsung.com>
---
 fs/f2fs/segment.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index c117e09..463f420 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -248,7 +248,11 @@ static int __revoke_inmem_pages(struct inode *inode,
 				goto next;
 			}
 			get_node_info(sbi, dn.nid, &ni);
-			f2fs_replace_block(sbi, &dn, dn.data_blkaddr,
+			if (cur->old_addr == NEW_ADDR) {
+				invalidate_blocks(sbi, dn.data_blkaddr);
+				f2fs_update_data_blkaddr(&dn, NULL_ADDR);
+			} else
+				f2fs_replace_block(sbi, &dn, dn.data_blkaddr,
 					cur->old_addr, ni.version, true, true);
 			f2fs_put_dnode(&dn);
 		}
-- 
1.9.1
