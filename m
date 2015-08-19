From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 7/9] f2fs: split __insert_extent_tree_ret for readability
Date: Wed, 19 Aug 2015 19:15:09 +0800
Message-ID: <017b01d0da70$69d01020$3d703060$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch splits __insert_extent_tree_ret into __try_merge_extent_node &
__insert_extent_tree for code readability.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/extent_cache.c | 49 +++++++++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 5b6139f..ab26728 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -294,29 +294,22 @@ static struct extent_node *__lookup_extent_tree_ret(struct extent_tree *et,
 	return NULL;
 }
 
-static struct extent_node *__insert_extent_tree_ret(struct f2fs_sb_info *sbi,
+static struct extent_node *__try_merge_extent_node(struct f2fs_sb_info *sbi,
 				struct extent_tree *et, struct extent_info *ei,
 				struct extent_node **den,
 				struct extent_node *prev_ex,
-				struct extent_node *next_ex,
-				struct rb_node **insert_p,
-				struct rb_node *insert_parent)
+				struct extent_node *next_ex)
 {
-	struct rb_node **p = &et->root.rb_node;
-	struct rb_node *parent = NULL;
 	struct extent_node *en = NULL;
-	int merged = 0;
 
 	if (prev_ex && __is_back_mergeable(ei, &prev_ex->ei)) {
-		f2fs_bug_on(sbi, !den);
-		merged = 1;
 		prev_ex->ei.len += ei->len;
 		ei = &prev_ex->ei;
 		en = prev_ex;
 	}
+
 	if (next_ex && __is_front_mergeable(ei, &next_ex->ei)) {
-		f2fs_bug_on(sbi, !den);
-		if (merged++) {
+		if (en) {
 			__detach_extent_node(sbi, et, prev_ex);
 			*den = prev_ex;
 		}
@@ -325,8 +318,23 @@ static struct extent_node *__insert_extent_tree_ret(struct f2fs_sb_info *sbi,
 		next_ex->ei.len += ei->len;
 		en = next_ex;
 	}
-	if (merged)
-		goto update_out;
+
+	if (en) {
+		if (en->ei.len > et->largest.len)
+			et->largest = en->ei;
+		et->cached_en = en;
+	}
+	return en;
+}
+
+static struct extent_node *__insert_extent_tree(struct f2fs_sb_info *sbi,
+				struct extent_tree *et, struct extent_info *ei,
+				struct rb_node **insert_p,
+				struct rb_node *insert_parent)
+{
+	struct rb_node **p = &et->root.rb_node;
+	struct rb_node *parent = NULL;
+	struct extent_node *en = NULL;
 
 	if (insert_p && insert_parent) {
 		parent = insert_parent;
@@ -349,7 +357,7 @@ do_insert:
 	en = __attach_extent_node(sbi, et, ei, parent, p);
 	if (!en)
 		return NULL;
-update_out:
+
 	if (en->ei.len > et->largest.len)
 		et->largest = en->ei;
 	et->cached_en = en;
@@ -401,8 +409,7 @@ static bool f2fs_update_extent_tree(struct inode *inode, pgoff_t fofs,
 		if (fofs - dei.fofs >= F2FS_MIN_EXTENT_LEN) {
 			set_extent_info(&ei, dei.fofs, dei.blk,
 						fofs - dei.fofs);
-			en1 = __insert_extent_tree_ret(sbi, et, &ei, NULL,
-						NULL, NULL, NULL, NULL);
+			en1 = __insert_extent_tree(sbi, et, &ei, NULL, NULL);
 		}
 
 		/* insert right part of split extent into cache */
@@ -410,8 +417,7 @@ static bool f2fs_update_extent_tree(struct inode *inode, pgoff_t fofs,
 		if (endofs - fofs >= F2FS_MIN_EXTENT_LEN) {
 			set_extent_info(&ei, fofs + 1,
 				fofs - dei.fofs + dei.blk + 1, endofs - fofs);
-			en2 = __insert_extent_tree_ret(sbi, et, &ei, NULL,
-						NULL, NULL, NULL, NULL);
+			en2 = __insert_extent_tree(sbi, et, &ei, NULL, NULL);
 		}
 	}
 
@@ -419,8 +425,11 @@ update_extent:
 	/* 3. update extent in extent cache */
 	if (blkaddr) {
 		set_extent_info(&ei, fofs, blkaddr, 1);
-		en3 = __insert_extent_tree_ret(sbi, et, &ei, &den,
-				prev_ex, next_ex, insert_p, insert_parent);
+		en3 = __try_merge_extent_node(sbi, et, &ei, &den,
+						prev_ex, next_ex);
+		if (!en3)
+			en3 = __insert_extent_tree(sbi, et, &ei,
+						insert_p, insert_parent);
 
 		/* give up extent_cache, if split and small updates happen */
 		if (dei.len >= 1 &&
-- 
2.4.2
