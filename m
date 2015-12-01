From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: avoid deadlock in f2fs_shrink_extent_tree
Date: Mon, 30 Nov 2015 16:53:35 -0800
Message-ID: <1448931215-51572-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

While handling extent trees, we can enter into a reclaiming path anytime.
If it tries to release some extent nodes in the same extent tree,
write_lock(&et->lock) would be hanged.
In order to avoid the deadlock, we can just skip it.

Note that, if it is an unreferenced tree, we should get write_lock(&et->lock)
successfully and release all of therein nodes.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/extent_cache.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 7ddba81..21b1b8e 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -615,9 +615,10 @@ unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
 		for (i = 0; i < found; i++) {
 			struct extent_tree *et = treevec[i];
 
-			write_lock(&et->lock);
-			node_cnt += __free_extent_tree(sbi, et, false);
-			write_unlock(&et->lock);
+			if (down_write_trylock(&et->lock)) {
+				node_cnt += __free_extent_tree(sbi, et, false);
+				write_unlock(&et->lock);
+			}
 
 			if (node_cnt + tree_cnt >= nr_shrink)
 				goto unlock_out;
-- 
2.4.9 (Apple Git-60)

