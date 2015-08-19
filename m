From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 6/9] f2fs: kill dead code in __insert_extent_tree
Date: Wed, 19 Aug 2015 19:14:15 +0800
Message-ID: <017a01d0da70$46ae6150$d40b23f0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

After commit 0f825ee6e873 ("f2fs: add new interfaces for extent tree"),
f2fs_init_extent_tree becomes the only caller of __insert_extent_tree, and
in f2fs_init_extent_tree, we will only insert extent node in an empty tree,
so __try_{back,front}_merge in __insert_extent_tree will never be called.

This patch removes these dead codes, besides, rename __insert_extent_tree
to __init_extent_tree for readability.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/extent_cache.c | 82 ++++----------------------------------------------
 1 file changed, 6 insertions(+), 76 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index d11735a..5b6139f 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -111,87 +111,17 @@ static struct extent_node *__lookup_extent_tree(struct f2fs_sb_info *sbi,
 	return NULL;
 }
 
-static struct extent_node *__try_back_merge(struct f2fs_sb_info *sbi,
-				struct extent_tree *et, struct extent_node *en)
-{
-	struct extent_node *prev;
-	struct rb_node *node;
-
-	node = rb_prev(&en->rb_node);
-	if (!node)
-		return NULL;
-
-	prev = rb_entry(node, struct extent_node, rb_node);
-	if (__is_back_mergeable(&en->ei, &prev->ei)) {
-		en->ei.fofs = prev->ei.fofs;
-		en->ei.blk = prev->ei.blk;
-		en->ei.len += prev->ei.len;
-		__detach_extent_node(sbi, et, prev);
-		return prev;
-	}
-	return NULL;
-}
-
-static struct extent_node *__try_front_merge(struct f2fs_sb_info *sbi,
-				struct extent_tree *et, struct extent_node *en)
-{
-	struct extent_node *next;
-	struct rb_node *node;
-
-	node = rb_next(&en->rb_node);
-	if (!node)
-		return NULL;
-
-	next = rb_entry(node, struct extent_node, rb_node);
-	if (__is_front_mergeable(&en->ei, &next->ei)) {
-		en->ei.len += next->ei.len;
-		__detach_extent_node(sbi, et, next);
-		return next;
-	}
-	return NULL;
-}
-
-static struct extent_node *__insert_extent_tree(struct f2fs_sb_info *sbi,
-				struct extent_tree *et, struct extent_info *ei,
-				struct extent_node **den)
+static struct extent_node *__init_extent_tree(struct f2fs_sb_info *sbi,
+				struct extent_tree *et, struct extent_info *ei)
 {
 	struct rb_node **p = &et->root.rb_node;
-	struct rb_node *parent = NULL;
 	struct extent_node *en;
 
-	while (*p) {
-		parent = *p;
-		en = rb_entry(parent, struct extent_node, rb_node);
-
-		if (ei->fofs < en->ei.fofs) {
-			if (__is_front_mergeable(ei, &en->ei)) {
-				f2fs_bug_on(sbi, !den);
-				en->ei.fofs = ei->fofs;
-				en->ei.blk = ei->blk;
-				en->ei.len += ei->len;
-				*den = __try_back_merge(sbi, et, en);
-				goto update_out;
-			}
-			p = &(*p)->rb_left;
-		} else if (ei->fofs >= en->ei.fofs + en->ei.len) {
-			if (__is_back_mergeable(ei, &en->ei)) {
-				f2fs_bug_on(sbi, !den);
-				en->ei.len += ei->len;
-				*den = __try_front_merge(sbi, et, en);
-				goto update_out;
-			}
-			p = &(*p)->rb_right;
-		} else {
-			f2fs_bug_on(sbi, 1);
-		}
-	}
-
-	en = __attach_extent_node(sbi, et, ei, parent, p);
+	en = __attach_extent_node(sbi, et, ei, NULL, p);
 	if (!en)
 		return NULL;
-update_out:
-	if (en->ei.len > et->largest.len)
-		et->largest = en->ei;
+
+	et->largest = en->ei;
 	et->cached_en = en;
 	return en;
 }
@@ -255,7 +185,7 @@ void f2fs_init_extent_tree(struct inode *inode, struct f2fs_extent *i_ext)
 	if (et->count)
 		goto out;
 
-	en = __insert_extent_tree(sbi, et, &ei, NULL);
+	en = __init_extent_tree(sbi, et, &ei);
 	if (en) {
 		spin_lock(&sbi->extent_lock);
 		list_add_tail(&en->list, &sbi->extent_list);
-- 
2.4.2
