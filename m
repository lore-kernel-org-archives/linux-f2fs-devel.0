From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2] f2fs: avoid deadlock in f2fs_shrink_extent_tree
Date: Mon, 30 Nov 2015 17:46:22 -0800
Message-ID: <20151201014622.GA51854@jaegeuk.local>
References: <1448931215-51572-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1448931215-51572-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Change log from v1:
 o fix bug

>From 8cd63b5e91daeeccc1f158425c74de0f462c96af Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Mon, 30 Nov 2015 16:26:44 -0800
Subject: [PATCH] f2fs: avoid deadlock in f2fs_shrink_extent_tree

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
index 7ddba81..de063f2 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -615,9 +615,10 @@ unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
 		for (i = 0; i < found; i++) {
 			struct extent_tree *et = treevec[i];
 
-			write_lock(&et->lock);
-			node_cnt += __free_extent_tree(sbi, et, false);
-			write_unlock(&et->lock);
+			if (write_trylock(&et->lock)) {
+				node_cnt += __free_extent_tree(sbi, et, false);
+				write_unlock(&et->lock);
+			}
 
 			if (node_cnt + tree_cnt >= nr_shrink)
 				goto unlock_out;
-- 
2.4.9 (Apple Git-60)

