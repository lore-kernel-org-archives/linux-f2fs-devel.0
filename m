From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/8] f2fs: reuse nid if it was cached only
Date: Thu,  2 Jun 2016 20:55:32 -0700
Message-ID: <1464926139-58252-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

If nid's block address is assigned as:
 NULL_ADDR -> NEW_ADDR -> NULL_ADDR, we can reset this nid, since its node page
has never written back.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 16532b3..15f55ae 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -317,10 +317,16 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
 	}
 
 	/* change address */
-	nat_set_blkaddr(e, new_blkaddr);
-	if (new_blkaddr == NEW_ADDR || new_blkaddr == NULL_ADDR)
-		set_nat_flag(e, IS_CHECKPOINTED, false);
-	__set_nat_cache_dirty(nm_i, e);
+	if (nat_get_blkaddr(e) == NEW_ADDR && new_blkaddr == NULL_ADDR) {
+		nat_set_blkaddr(e, new_blkaddr);
+		nat_reset_flag(e);
+		__clear_nat_cache_dirty(nm_i, e);
+	} else {
+		nat_set_blkaddr(e, new_blkaddr);
+		if (new_blkaddr == NEW_ADDR || new_blkaddr == NULL_ADDR)
+			set_nat_flag(e, IS_CHECKPOINTED, false);
+		__set_nat_cache_dirty(nm_i, e);
+	}
 
 	/* update fsync_mark if its inode nat entry is still alive */
 	if (ni->nid != ni->ino)
-- 
2.6.3
