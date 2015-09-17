From: Fan Li <fanofcode.li@samsung.com>
Subject: [PATCH 2/2] f2fs: optimize code of
 f2fs_update_extent_tree_range
Date: Thu, 17 Sep 2015 18:42:06 +0800
Message-ID: <002e01d0f135$94034f70$bc09ee50$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fanofcode.li@samsung.com>) id 1ZcWeV-0006k0-6w
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Sep 2015 10:42:55 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZcWeS-0006hi-Q7
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Sep 2015 10:42:55 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NUT01UVMHR9JWD0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Sep 2015 19:42:45 +0900 (KST)
Content-language: en-us
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

Fix 2 potential problems:
1. when largest extent needs to be invalidated, it will be reset in
   __drop_largest_extent, which makes __is_extent_same after always
   return false, and largest extent unchanged. Now we update it properly.

2. when extent is split and the latter part remains in tree, next_en
   should be the latter part instead of next extent of original extent.
   It will cause merge failure if there is in-place update, although
   there is not, I think this fix will still makes codes less ambiguous.

This patch also simplifies codes of invalidating extents, and optimizes the
procedues that split extent into two.
There are a few modifications after last patch:
1. prev_en now is updated properly.
2. more codes and branches are simplified.


Signed-off-by: Fan li <fanofcode.li@samsung.com>
---
 fs/f2fs/extent_cache.c |  171 ++++++++++++++++++------------------------------
 1 file changed, 62 insertions(+), 109 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 2f013e2..c9d1cfd 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -400,7 +400,7 @@ static unsigned int f2fs_update_extent_tree_range(struct inode *inode,
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct extent_tree *et = F2FS_I(inode)->extent_tree;
-	struct extent_node *en = NULL, *en1 = NULL, *en2 = NULL, *en3 = NULL;
+	struct extent_node *en = NULL, *en1 = NULL;
 	struct extent_node *prev_en = NULL, *next_en = NULL;
 	struct extent_info ei, dei, prev;
 	struct rb_node **insert_p = NULL, *insert_parent = NULL;
@@ -422,148 +422,101 @@ static unsigned int f2fs_update_extent_tree_range(struct inode *inode,
 	prev = et->largest;
 	dei.len = 0;

-	/* we do not guarantee that the largest extent is cached all the time */
+	/*
+	 * drop largest extent before lookup, in case it's already
+	 * been shrunk from extent tree
+	 */
 	__drop_largest_extent(inode, fofs, len);

 	/* 1. lookup first extent node in range [fofs, fofs + len - 1] */
 	en = __lookup_extent_tree_ret(et, fofs, &prev_en, &next_en,
 					&insert_p, &insert_parent);
-	if (!en) {
-		if (next_en) {
-			en = next_en;
-			f2fs_bug_on(sbi, en->ei.fofs <= pos);
-			pos = en->ei.fofs;
-		} else {
-			/*
-			 * skip searching in the tree since there is no
-			 * larger extent node in the cache.
-			 */
-			goto update_extent;
-		}
-	}
+	if (!en)
+		en = next_en;

 	/* 2. invlidate all extent nodes in range [fofs, fofs + len - 1] */
-	while (en) {
-		struct rb_node *node;
+	while (en && en->ei.fofs < end) {
+		unsigned int org_end;
+		int parts = 0;	/* # of parts current extent split into */

-		if (pos >= end)
-			break;
+		next_en = en1 = NULL;

 		dei = en->ei;
-		en1 = en2 = NULL;
+		org_end = dei.fofs + dei.len;
+		f2fs_bug_on(sbi, pos >= org_end);

-		node = rb_next(&en->rb_node);
+		if (pos > dei.fofs &&	pos - dei.fofs >= F2FS_MIN_EXTENT_LEN) {
+			en->ei.len = pos - en->ei.fofs;
+			prev_en = en;
+			parts = 1;
+		}

-		/*
-		 * 2.1 there are four cases when we invalidate blkaddr in extent
-		 * node, |V: valid address, X: will be invalidated|
-		 */
-		/* case#1, invalidate right part of extent node |VVVVVXXXXX| */
-		if (pos > dei.fofs && end >= dei.fofs + dei.len) {
-			en->ei.len = pos - dei.fofs;
-
-			if (en->ei.len < F2FS_MIN_EXTENT_LEN) {
-				__detach_extent_node(sbi, et, en);
-				insert_p = NULL;
-				insert_parent = NULL;
-				goto update;
+		if (end < org_end && org_end - end >= F2FS_MIN_EXTENT_LEN) {
+			if (parts) {
+				set_extent_info(&ei, end,
+						end - dei.fofs + dei.blk,
+						org_end - end);
+				en1 = __insert_extent_tree(sbi, et, &ei,
+							NULL, NULL);
+				next_en = en1;
+			} else {
+				en->ei.fofs = end;
+				en->ei.blk += end - dei.fofs;
+				en->ei.len -= end - dei.fofs;
+				next_en = en;
 			}
-
-			if (__is_extent_same(&dei, &et->largest))
-				et->largest = en->ei;
-			goto next;
+			parts++;
 		}

-		/* case#2, invalidate left part of extent node |XXXXXVVVVV| */
-		if (pos <= dei.fofs && end < dei.fofs + dei.len) {
-			en->ei.fofs = end;
-			en->ei.blk += end - dei.fofs;
-			en->ei.len -= end - dei.fofs;
-
-			if (en->ei.len < F2FS_MIN_EXTENT_LEN) {
-				__detach_extent_node(sbi, et, en);
-				insert_p = NULL;
-				insert_parent = NULL;
-				goto update;
-			}
+		if (!next_en) {
+			struct rb_node *node = rb_next(&en->rb_node);

-			if (__is_extent_same(&dei, &et->largest))
-				et->largest = en->ei;
-			goto next;
+			next_en = node ?
+				rb_entry(node, struct extent_node, rb_node)
+				: NULL;
 		}

-		__detach_extent_node(sbi, et, en);
-
-		/*
-		 * if we remove node in rb-tree, our parent node pointer may
-		 * point the wrong place, discard them.
-		 */
-		insert_p = NULL;
-		insert_parent = NULL;
-
-		/* case#3, invalidate entire extent node |XXXXXXXXXX| */
-		if (pos <= dei.fofs && end >= dei.fofs + dei.len) {
-			if (__is_extent_same(&dei, &et->largest))
-				et->largest.len = 0;
-			goto update;
+		if (parts) {
+			if (en->ei.len > et->largest.len)
+				et->largest = en->ei;
+		} else {
+			__detach_extent_node(sbi, et, en);
 		}

 		/*
-		 * case#4, invalidate data in the middle of extent node
-		 * |VVVXXXXVVV|
+		 * if original extent is split into zero or two parts, extent
+		 * tree has been altered by deletion or insertion, therefore
+		 * invalidate pointers regard to tree.
 		 */
-		if (dei.len > F2FS_MIN_EXTENT_LEN) {
-			unsigned int endofs;
-
-			/*  insert left part of split extent into cache */
-			if (pos - dei.fofs >= F2FS_MIN_EXTENT_LEN) {
-				set_extent_info(&ei, dei.fofs, dei.blk,
-							pos - dei.fofs);
-				en1 = __insert_extent_tree(sbi, et, &ei,
-								NULL, NULL);
-			}
-
-			/* insert right part of split extent into cache */
-			endofs = dei.fofs + dei.len;
-			if (endofs - end >= F2FS_MIN_EXTENT_LEN) {
-				set_extent_info(&ei, end,
-						end - dei.fofs + dei.blk,
-						endofs - end);
-				en2 = __insert_extent_tree(sbi, et, &ei,
-								NULL, NULL);
-			}
+		if (parts != 1) {
+			insert_p = NULL;
+			insert_parent = NULL;
 		}
-update:
-		/* 2.2 update in global extent list */
+
+		/* update in global extent list */
 		spin_lock(&sbi->extent_lock);
-		if (en && !list_empty(&en->list))
+		if (!parts && !list_empty(&en->list))
 			list_del(&en->list);
 		if (en1)
 			list_add_tail(&en1->list, &sbi->extent_list);
-		if (en2)
-			list_add_tail(&en2->list, &sbi->extent_list);
 		spin_unlock(&sbi->extent_lock);

-		/* 2.3 release extent node */
-		if (en)
+		/* release extent node */
+		if (!parts)
 			kmem_cache_free(extent_node_slab, en);
-next:
-		en = node ? rb_entry(node, struct extent_node, rb_node) : NULL;
-		next_en = en;
-		if (en)
-			pos = en->ei.fofs;
+
+		en = next_en;
 	}

-update_extent:
 	/* 3. update extent in extent cache */
 	if (blkaddr) {
 		struct extent_node *den = NULL;

 		set_extent_info(&ei, fofs, blkaddr, len);
-		en3 = __try_merge_extent_node(sbi, et, &ei, &den,
+		en1 = __try_merge_extent_node(sbi, et, &ei, &den,
 							prev_en, next_en);
-		if (!en3)
-			en3 = __insert_extent_tree(sbi, et, &ei,
+		if (!en1)
+			en1 = __insert_extent_tree(sbi, et, &ei,
 						insert_p, insert_parent);

 		/* give up extent_cache, if split and small updates happen */
@@ -575,11 +528,11 @@ update_extent:
 		}

 		spin_lock(&sbi->extent_lock);
-		if (en3) {
-			if (list_empty(&en3->list))
-				list_add_tail(&en3->list, &sbi->extent_list);
+		if (en1) {
+			if (list_empty(&en1->list))
+				list_add_tail(&en1->list, &sbi->extent_list);
 			else
-				list_move_tail(&en3->list, &sbi->extent_list);
+				list_move_tail(&en1->list, &sbi->extent_list);
 		}
 		if (den && !list_empty(&den->list))
 			list_del(&den->list);
--
1.7.9.5



------------------------------------------------------------------------------
Monitor Your Dynamic Infrastructure at Any Scale With Datadog!
Get real-time metrics from all of your servers, apps and tools
in one place.
SourceForge users - Click here to start your Free Trial of Datadog now!
http://pubads.g.doubleclick.net/gampad/clk?id=241902991&iu=/4140
