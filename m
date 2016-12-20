From: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH] f2fs: use rb_entry_safe
Date: Tue, 20 Dec 2016 21:57:42 +0800
Message-ID: <1e433cd03b01a3e89a22de5aa160b3442ff0cf16.1482222608.git.geliangtang@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: Geliang Tang <geliangtang@gmail.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Use rb_entry_safe() instead of open-coding it.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 fs/f2fs/extent_cache.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 4db44da..f79bfb2 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -311,28 +311,24 @@ static struct extent_node *__lookup_extent_tree_ret(struct extent_tree *et,
 	tmp_node = parent;
 	if (parent && fofs > en->ei.fofs)
 		tmp_node = rb_next(parent);
-	*next_ex = tmp_node ?
-		rb_entry(tmp_node, struct extent_node, rb_node) : NULL;
+	*next_ex = rb_entry_safe(tmp_node, struct extent_node, rb_node);
 
 	tmp_node = parent;
 	if (parent && fofs < en->ei.fofs)
 		tmp_node = rb_prev(parent);
-	*prev_ex = tmp_node ?
-		rb_entry(tmp_node, struct extent_node, rb_node) : NULL;
+	*prev_ex = rb_entry_safe(tmp_node, struct extent_node, rb_node);
 	return NULL;
 
 lookup_neighbors:
 	if (fofs == en->ei.fofs) {
 		/* lookup prev node for merging backward later */
 		tmp_node = rb_prev(&en->rb_node);
-		*prev_ex = tmp_node ?
-			rb_entry(tmp_node, struct extent_node, rb_node) : NULL;
+		*prev_ex = rb_entry_safe(tmp_node, struct extent_node, rb_node);
 	}
 	if (fofs == en->ei.fofs + en->ei.len - 1) {
 		/* lookup next node for merging frontward later */
 		tmp_node = rb_next(&en->rb_node);
-		*next_ex = tmp_node ?
-			rb_entry(tmp_node, struct extent_node, rb_node) : NULL;
+		*next_ex = rb_entry_safe(tmp_node, struct extent_node, rb_node);
 	}
 	return en;
 }
@@ -492,9 +488,8 @@ static unsigned int f2fs_update_extent_tree_range(struct inode *inode,
 		if (!next_en) {
 			struct rb_node *node = rb_next(&en->rb_node);
 
-			next_en = node ?
-				rb_entry(node, struct extent_node, rb_node)
-				: NULL;
+			next_en = rb_entry_safe(node, struct extent_node,
+						rb_node);
 		}
 
 		if (parts)
-- 
2.9.3
