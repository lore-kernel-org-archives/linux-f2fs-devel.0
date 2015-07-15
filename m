From: Fan Li <fanofcode.li@samsung.com>
Subject: [PATCH] f2fs: add new interfaces for extent tree
Date: Wed, 15 Jul 2015 18:05:17 +0800
Message-ID: <001901d0bee5$d6279190$8276b4b0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fanofcode.li@samsung.com>) id 1ZFJa0-0006CR-B0
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 15 Jul 2015 10:06:20 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZFJZy-0002fB-2j
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 15 Jul 2015 10:06:20 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NRI01X20XDUXT10@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 15 Jul 2015 19:05:54 +0900 (KST)
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

Add a lookup and a insertion interface for extent tree.
The new lookup return the insert position and the prev/next 
extents closest to the offset we lookup when find no match.
The new insertion uses above parameters to improve performance.

There are three possible insertions after the lookup in 
f2fs_update_extent_tree, two of them insert parts of removed extent 
back to tree, since no merge happens during this process, new insertion 
skips the merge check in this scanario; the another insertion inserts a 
new extent to tree, new insertion uses prev/next extent and insert 
position to insert this extent directly, and save the time of searching 
down the tree.

As long as tree remains unchanged between lookup and insertion, this 
would work fine. And the new lookup would be useful when add 
multi-blocks extent support for insertion interface.

Signed-off-by: Fan li <fanofcode.li@samsung.com>
---
 fs/f2fs/extent_cache.c |  140
+++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 133 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 5f78fc1..753adf4 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -302,6 +302,127 @@ out:
 	return ret;
 }
 
+
+/*
+ * lookup extent at @fofs, if hit, return the extent
+ * if not, return NULL and
+ * @prev_ex: extent before fofs
+ * @next_ex: extent after fofs
+ * @insert_p: insert point for new extent at fofs
+ * in order to simpfy the insertion after.
+ * tree must stay unchanged between lookup and insertion.
+ */
+static struct extent_node *__lookup_extent_tree_ret(struct extent_tree *et,
+				unsigned int fofs, struct extent_node
**prev_ex,
+				struct extent_node **next_ex,
+				struct rb_node ***insert_p,
+				struct rb_node **insert_parent)
+{
+	struct rb_node **pnode = &et->root.rb_node;
+	struct rb_node *parent = NULL, *tmp_node;
+	struct extent_node *en;
+
+	if (et->cached_en) {
+		struct extent_info *cei = &et->cached_en->ei;
+
+		if (cei->fofs <= fofs && cei->fofs + cei->len > fofs)
+			return et->cached_en;
+	}
+
+	while (*pnode) {
+		parent = *pnode;
+		en = rb_entry(*pnode, struct extent_node, rb_node);
+
+		if (fofs < en->ei.fofs)
+			pnode = &(*pnode)->rb_left;
+		else if (fofs >= en->ei.fofs + en->ei.len)
+			pnode = &(*pnode)->rb_right;
+		else
+			return en;
+	}
+
+	*insert_p = pnode;
+	*insert_parent = parent;
+
+	en = rb_entry(parent, struct extent_node, rb_node);
+	tmp_node = parent;
+	if (parent && fofs > en->ei.fofs)
+		tmp_node = rb_next(parent);
+	*next_ex = tmp_node ?
+		rb_entry(tmp_node, struct extent_node, rb_node) : NULL;
+
+	tmp_node = parent;
+	if (parent && fofs < en->ei.fofs)
+		tmp_node = rb_prev(parent);
+	*prev_ex = tmp_node ?
+		rb_entry(tmp_node, struct extent_node, rb_node) : NULL;
+
+	return NULL;
+}
+
+static struct extent_node *__insert_extent_tree_ret(struct f2fs_sb_info
*sbi,
+				struct extent_tree *et, struct extent_info
*ei,
+				struct extent_node **den,
+				struct extent_node *prev_ex,
+				struct extent_node *next_ex,
+				struct rb_node **insert_p,
+				struct rb_node *insert_parent)
+{
+	struct rb_node **p = &et->root.rb_node;
+	struct rb_node *parent = NULL;
+	struct extent_node *en = NULL;
+	int merged = 0;
+
+	if (prev_ex && __is_back_mergeable(ei, &prev_ex->ei)) {
+		f2fs_bug_on(sbi, !den);
+		merged = 1;
+		prev_ex->ei.len += ei->len;
+		ei = &prev_ex->ei;
+		en = prev_ex;
+	}
+	if (next_ex && __is_front_mergeable(ei, &next_ex->ei)) {
+		f2fs_bug_on(sbi, !den);
+		if (merged++) {
+			__detach_extent_node(sbi, et, prev_ex);
+			*den = prev_ex;
+		}
+		next_ex->ei.fofs = ei->fofs;
+		next_ex->ei.blk = ei->blk;
+		next_ex->ei.len += ei->len;
+		en = next_ex;
+	}
+	if (merged)
+		goto update_out;
+
+	if (insert_p && insert_parent) {
+		parent = insert_parent;
+		p = insert_p;
+		goto do_insert;
+	}
+
+	while (*p) {
+		parent = *p;
+		en = rb_entry(parent, struct extent_node, rb_node);
+
+		if (ei->fofs < en->ei.fofs)
+			p = &(*p)->rb_left;
+		else if (ei->fofs >= en->ei.fofs + en->ei.len)
+			p = &(*p)->rb_right;
+		else
+			f2fs_bug_on(sbi, 1);
+	}
+do_insert:
+	en = __attach_extent_node(sbi, et, ei, parent, p);
+	if (!en)
+		return NULL;
+update_out:
+	if (en->ei.len > et->largest.len)
+		et->largest = en->ei;
+	et->cached_en = en;
+	return en;
+}
+
+
 /* return true, if on-disk extent should be updated */
 static bool f2fs_update_extent_tree(struct inode *inode, pgoff_t fofs,
 							block_t blkaddr)
@@ -309,8 +430,9 @@ static bool f2fs_update_extent_tree(struct inode *inode,
pgoff_t fofs,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct extent_tree *et = F2FS_I(inode)->extent_tree;
 	struct extent_node *en = NULL, *en1 = NULL, *en2 = NULL, *en3 =
NULL;
-	struct extent_node *den = NULL;
+	struct extent_node *den = NULL, *prev_ex = NULL, *next_ex = NULL;
 	struct extent_info ei, dei, prev;
+	struct rb_node **insert_p = NULL, *insert_parent = NULL;
 	unsigned int endofs;
 
 	if (!et)
@@ -332,20 +454,22 @@ static bool f2fs_update_extent_tree(struct inode
*inode, pgoff_t fofs,
 	f2fs_drop_largest_extent(inode, fofs);
 
 	/* 1. lookup and remove existing extent info in cache */
-	en = __lookup_extent_tree(et, fofs);
+	en = __lookup_extent_tree_ret(et, fofs, &prev_ex, &next_ex,
+					&insert_p, &insert_parent);
 	if (!en)
 		goto update_extent;
 
 	dei = en->ei;
 	__detach_extent_node(sbi, et, en);
 
-	/* 2. if extent can be split more, split and insert the left part */
+	/* 2. if extent can be split, try to split it */
 	if (dei.len > F2FS_MIN_EXTENT_LEN) {
 		/*  insert left part of split extent into cache */
 		if (fofs - dei.fofs >= F2FS_MIN_EXTENT_LEN) {
 			set_extent_info(&ei, dei.fofs, dei.blk,
-							fofs - dei.fofs);
-			en1 = __insert_extent_tree(sbi, et, &ei, NULL);
+						fofs - dei.fofs);
+			en1 = __insert_extent_tree_ret(sbi, et, &ei, NULL,
+						NULL, NULL, NULL, NULL);
 		}
 
 		/* insert right part of split extent into cache */
@@ -353,7 +477,8 @@ static bool f2fs_update_extent_tree(struct inode *inode,
pgoff_t fofs,
 		if (endofs - fofs >= F2FS_MIN_EXTENT_LEN) {
 			set_extent_info(&ei, fofs + 1,
 				fofs - dei.fofs + dei.blk + 1, endofs -
fofs);
-			en2 = __insert_extent_tree(sbi, et, &ei, NULL);
+			en2 = __insert_extent_tree_ret(sbi, et, &ei, NULL,
+						NULL, NULL, NULL, NULL);
 		}
 	}
 
@@ -361,7 +486,8 @@ update_extent:
 	/* 3. update extent in extent cache */
 	if (blkaddr) {
 		set_extent_info(&ei, fofs, blkaddr, 1);
-		en3 = __insert_extent_tree(sbi, et, &ei, &den);
+		en3 = __insert_extent_tree_ret(sbi, et, &ei, &den,
+				prev_ex, next_ex, insert_p, insert_parent);
 
 		/* give up extent_cache, if split and small updates happen
*/
 		if (dei.len >= 1 &&
-- 
1.7.9.5


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
