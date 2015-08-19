From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 8/9] f2fs: lookup neighbor extent nodes for merging later
Date: Wed, 19 Aug 2015 19:16:09 +0800
Message-ID: <017c01d0da70$9d13feb0$d73bfc10$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

In __lookup_extent_tree_ret we will not try to find neighbor nodes if
we find the target node, in this condition, we will lost the chance to
merge the new mapping with exist extent node later.

So our extent cache of inode will be fragmented after overwrite exist
file, we can see the number of extent node increases intensively in
following test case:

dd if=/dev/zero of=/mnt/f2fs/4m bs=4K count=1024

Extent Cache:
  - Hit Count: L1-1:0 L1-2:0 L2:0
  - Hit Ratio: 0% (0 / 3072)
  - Inner Struct Count: tree: 1, node: 1

dd if=/dev/zero of=/mnt/f2fs/4m bs=4K count=1024 conv=notrunc

Extent Cache:
  - Hit Count: L1-1:2048 L1-2:0 L2:0
  - Hit Ratio: 33% (2048 / 6144)
  - Inner Struct Count: tree: 1, node: 961

This patch fixes to lookup neighbors of target node for further
merging.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/extent_cache.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index ab26728..dcfeb43 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -254,13 +254,21 @@ static struct extent_node *__lookup_extent_tree_ret(struct extent_tree *et,
 {
 	struct rb_node **pnode = &et->root.rb_node;
 	struct rb_node *parent = NULL, *tmp_node;
-	struct extent_node *en;
+	struct extent_node *en = et->cached_en;
 
-	if (et->cached_en) {
-		struct extent_info *cei = &et->cached_en->ei;
+	*insert_p = NULL;
+	*insert_parent = NULL;
+	*prev_ex = NULL;
+	*next_ex = NULL;
+
+	if (RB_EMPTY_ROOT(&et->root))
+		return NULL;
+
+	if (en) {
+		struct extent_info *cei = &en->ei;
 
 		if (cei->fofs <= fofs && cei->fofs + cei->len > fofs)
-			return et->cached_en;
+			goto lookup_neighbors;
 	}
 
 	while (*pnode) {
@@ -272,7 +280,7 @@ static struct extent_node *__lookup_extent_tree_ret(struct extent_tree *et,
 		else if (fofs >= en->ei.fofs + en->ei.len)
 			pnode = &(*pnode)->rb_right;
 		else
-			return en;
+			goto lookup_neighbors;
 	}
 
 	*insert_p = pnode;
@@ -290,8 +298,22 @@ static struct extent_node *__lookup_extent_tree_ret(struct extent_tree *et,
 		tmp_node = rb_prev(parent);
 	*prev_ex = tmp_node ?
 		rb_entry(tmp_node, struct extent_node, rb_node) : NULL;
-
 	return NULL;
+
+lookup_neighbors:
+	if (fofs == en->ei.fofs) {
+		/* lookup prev node for merging backward later */
+		tmp_node = rb_prev(&en->rb_node);
+		*prev_ex = tmp_node ?
+			rb_entry(tmp_node, struct extent_node, rb_node) : NULL;
+	}
+	if (fofs == en->ei.fofs + en->ei.len - 1) {
+		/* lookup next node for merging frontward later */
+		tmp_node = rb_next(&en->rb_node);
+		*next_ex = tmp_node ?
+			rb_entry(tmp_node, struct extent_node, rb_node) : NULL;
+	}
+	return en;
 }
 
 static struct extent_node *__try_merge_extent_node(struct f2fs_sb_info *sbi,
-- 
2.4.2
