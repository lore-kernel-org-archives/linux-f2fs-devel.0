From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: extract rb-tree operation infrastructure
Date: Tue, 11 Apr 2017 09:25:22 +0800
Message-ID: <20170411012522.52499-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cxkZD-0000aI-Hz
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Apr 2017 01:25:59 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188]
	helo=dggrg02-dlp.huawei.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cxkZB-0002PG-IL
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Apr 2017 01:25:59 +0000
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
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

rb-tree lookup/update functions are deeply coupled into extent cache
codes, it's very hard to reuse these basic functions, this patch
extracts common rb-tree operation infrastructure for latter reusing.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2: use __lookup_rb_tree in f2fs_lookup_extent_tree as Jaegeuk's suggestion.
 fs/f2fs/extent_cache.c | 291 +++++++++++++++++++++++++++----------------------
 fs/f2fs/f2fs.h         |  20 +++-
 2 files changed, 179 insertions(+), 132 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index c6934f014e0f..68e649a31c7d 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -18,6 +18,146 @@
 #include "node.h"
 #include <trace/events/f2fs.h>
 
+static struct rb_entry *__lookup_rb_tree_fast(struct rb_entry *cached_re,
+							unsigned int ofs)
+{
+	if (cached_re) {
+		if (cached_re->ofs <= ofs &&
+				cached_re->ofs + cached_re->len > ofs) {
+			return cached_re;
+		}
+	}
+	return NULL;
+}
+
+static struct rb_entry *__lookup_rb_tree_slow(struct rb_root *root,
+							unsigned int ofs)
+{
+	struct rb_node *node = root->rb_node;
+	struct rb_entry *re;
+
+	while (node) {
+		re = rb_entry(node, struct rb_entry, rb_node);
+
+		if (ofs < re->ofs)
+			node = node->rb_left;
+		else if (ofs >= re->ofs + re->len)
+			node = node->rb_right;
+		else
+			return re;
+	}
+	return NULL;
+}
+
+static struct rb_entry *__lookup_rb_tree(struct rb_root *root,
+				struct rb_entry *cached_re, unsigned int ofs)
+{
+	struct rb_entry *re;
+
+	re = __lookup_rb_tree_fast(cached_re, ofs);
+	if (!re)
+		return __lookup_rb_tree_slow(root, ofs);
+
+	return re;
+}
+
+static struct rb_node **__lookup_rb_tree_for_insert(struct f2fs_sb_info *sbi,
+				struct rb_root *root, struct rb_node **parent,
+				unsigned int ofs)
+{
+	struct rb_node **p = &root->rb_node;
+	struct rb_entry *re;
+
+	while (*p) {
+		*parent = *p;
+		re = rb_entry(*parent, struct rb_entry, rb_node);
+
+		if (ofs < re->ofs)
+			p = &(*p)->rb_left;
+		else if (ofs >= re->ofs + re->len)
+			p = &(*p)->rb_right;
+		else
+			f2fs_bug_on(sbi, 1);
+	}
+
+	return p;
+}
+
+/*
+ * lookup rb entry in position of @ofs in rb-tree,
+ * if hit, return the entry, otherwise, return NULL
+ * @prev_ex: extent before ofs
+ * @next_ex: extent after ofs
+ * @insert_p: insert point for new extent at ofs
+ * in order to simpfy the insertion after.
+ * tree must stay unchanged between lookup and insertion.
+ */
+static struct rb_entry *__lookup_rb_tree_ret(struct rb_root *root,
+				struct rb_entry *cached_re,
+				unsigned int ofs,
+				struct rb_entry **prev_entry,
+				struct rb_entry **next_entry,
+				struct rb_node ***insert_p,
+				struct rb_node **insert_parent)
+{
+	struct rb_node **pnode = &root->rb_node;
+	struct rb_node *parent = NULL, *tmp_node;
+	struct rb_entry *re = cached_re;
+
+	*insert_p = NULL;
+	*insert_parent = NULL;
+	*prev_entry = NULL;
+	*next_entry = NULL;
+
+	if (RB_EMPTY_ROOT(root))
+		return NULL;
+
+	if (re) {
+		if (re->ofs <= ofs && re->ofs + re->len > ofs)
+			goto lookup_neighbors;
+	}
+
+	while (*pnode) {
+		parent = *pnode;
+		re = rb_entry(*pnode, struct rb_entry, rb_node);
+
+		if (ofs < re->ofs)
+			pnode = &(*pnode)->rb_left;
+		else if (ofs >= re->ofs + re->len)
+			pnode = &(*pnode)->rb_right;
+		else
+			goto lookup_neighbors;
+	}
+
+	*insert_p = pnode;
+	*insert_parent = parent;
+
+	re = rb_entry(parent, struct rb_entry, rb_node);
+	tmp_node = parent;
+	if (parent && ofs > re->ofs)
+		tmp_node = rb_next(parent);
+	*next_entry = rb_entry_safe(tmp_node, struct rb_entry, rb_node);
+
+	tmp_node = parent;
+	if (parent && ofs < re->ofs)
+		tmp_node = rb_prev(parent);
+	*prev_entry = rb_entry_safe(tmp_node, struct rb_entry, rb_node);
+	return NULL;
+
+lookup_neighbors:
+	if (ofs == re->ofs) {
+		/* lookup prev node for merging backward later */
+		tmp_node = rb_prev(&re->rb_node);
+		*prev_entry = rb_entry_safe(tmp_node, struct rb_entry, rb_node);
+	}
+	if (ofs == re->ofs + re->len - 1) {
+		/* lookup next node for merging frontward later */
+		tmp_node = rb_next(&re->rb_node);
+		*next_entry = rb_entry_safe(tmp_node, struct rb_entry, rb_node);
+	}
+	return re;
+}
+
 static struct kmem_cache *extent_tree_slab;
 static struct kmem_cache *extent_node_slab;
 
@@ -102,36 +242,6 @@ static struct extent_tree *__grab_extent_tree(struct inode *inode)
 	return et;
 }
 
-static struct extent_node *__lookup_extent_tree(struct f2fs_sb_info *sbi,
-				struct extent_tree *et, unsigned int fofs)
-{
-	struct rb_node *node = et->root.rb_node;
-	struct extent_node *en = et->cached_en;
-
-	if (en) {
-		struct extent_info *cei = &en->ei;
-
-		if (cei->fofs <= fofs && cei->fofs + cei->len > fofs) {
-			stat_inc_cached_node_hit(sbi);
-			return en;
-		}
-	}
-
-	while (node) {
-		en = rb_entry(node, struct extent_node, rb_node);
-
-		if (fofs < en->ei.fofs) {
-			node = node->rb_left;
-		} else if (fofs >= en->ei.fofs + en->ei.len) {
-			node = node->rb_right;
-		} else {
-			stat_inc_rbtree_node_hit(sbi);
-			return en;
-		}
-	}
-	return NULL;
-}
-
 static struct extent_node *__init_extent_tree(struct f2fs_sb_info *sbi,
 				struct extent_tree *et, struct extent_info *ei)
 {
@@ -237,17 +347,24 @@ static bool f2fs_lookup_extent_tree(struct inode *inode, pgoff_t pgofs,
 		goto out;
 	}
 
-	en = __lookup_extent_tree(sbi, et, pgofs);
-	if (en) {
-		*ei = en->ei;
-		spin_lock(&sbi->extent_lock);
-		if (!list_empty(&en->list)) {
-			list_move_tail(&en->list, &sbi->extent_list);
-			et->cached_en = en;
-		}
-		spin_unlock(&sbi->extent_lock);
-		ret = true;
+	en = (struct extent_node *)__lookup_rb_tree(&et->root,
+				(struct rb_entry *)et->cached_en, pgofs);
+	if (!en)
+		goto out;
+
+	if (en == et->cached_en)
+		stat_inc_cached_node_hit(sbi);
+	else
+		stat_inc_rbtree_node_hit(sbi);
+
+	*ei = en->ei;
+	spin_lock(&sbi->extent_lock);
+	if (!list_empty(&en->list)) {
+		list_move_tail(&en->list, &sbi->extent_list);
+		et->cached_en = en;
 	}
+	spin_unlock(&sbi->extent_lock);
+	ret = true;
 out:
 	stat_inc_total_hit(sbi);
 	read_unlock(&et->lock);
@@ -256,83 +373,6 @@ static bool f2fs_lookup_extent_tree(struct inode *inode, pgoff_t pgofs,
 	return ret;
 }
 
-
-/*
- * lookup extent at @fofs, if hit, return the extent
- * if not, return NULL and
- * @prev_ex: extent before fofs
- * @next_ex: extent after fofs
- * @insert_p: insert point for new extent at fofs
- * in order to simpfy the insertion after.
- * tree must stay unchanged between lookup and insertion.
- */
-static struct extent_node *__lookup_extent_tree_ret(struct extent_tree *et,
-				unsigned int fofs,
-				struct extent_node **prev_ex,
-				struct extent_node **next_ex,
-				struct rb_node ***insert_p,
-				struct rb_node **insert_parent)
-{
-	struct rb_node **pnode = &et->root.rb_node;
-	struct rb_node *parent = NULL, *tmp_node;
-	struct extent_node *en = et->cached_en;
-
-	*insert_p = NULL;
-	*insert_parent = NULL;
-	*prev_ex = NULL;
-	*next_ex = NULL;
-
-	if (RB_EMPTY_ROOT(&et->root))
-		return NULL;
-
-	if (en) {
-		struct extent_info *cei = &en->ei;
-
-		if (cei->fofs <= fofs && cei->fofs + cei->len > fofs)
-			goto lookup_neighbors;
-	}
-
-	while (*pnode) {
-		parent = *pnode;
-		en = rb_entry(*pnode, struct extent_node, rb_node);
-
-		if (fofs < en->ei.fofs)
-			pnode = &(*pnode)->rb_left;
-		else if (fofs >= en->ei.fofs + en->ei.len)
-			pnode = &(*pnode)->rb_right;
-		else
-			goto lookup_neighbors;
-	}
-
-	*insert_p = pnode;
-	*insert_parent = parent;
-
-	en = rb_entry(parent, struct extent_node, rb_node);
-	tmp_node = parent;
-	if (parent && fofs > en->ei.fofs)
-		tmp_node = rb_next(parent);
-	*next_ex = rb_entry_safe(tmp_node, struct extent_node, rb_node);
-
-	tmp_node = parent;
-	if (parent && fofs < en->ei.fofs)
-		tmp_node = rb_prev(parent);
-	*prev_ex = rb_entry_safe(tmp_node, struct extent_node, rb_node);
-	return NULL;
-
-lookup_neighbors:
-	if (fofs == en->ei.fofs) {
-		/* lookup prev node for merging backward later */
-		tmp_node = rb_prev(&en->rb_node);
-		*prev_ex = rb_entry_safe(tmp_node, struct extent_node, rb_node);
-	}
-	if (fofs == en->ei.fofs + en->ei.len - 1) {
-		/* lookup next node for merging frontward later */
-		tmp_node = rb_next(&en->rb_node);
-		*next_ex = rb_entry_safe(tmp_node, struct extent_node, rb_node);
-	}
-	return en;
-}
-
 static struct extent_node *__try_merge_extent_node(struct inode *inode,
 				struct extent_tree *et, struct extent_info *ei,
 				struct extent_node *prev_ex,
@@ -387,17 +427,7 @@ static struct extent_node *__insert_extent_tree(struct inode *inode,
 		goto do_insert;
 	}
 
-	while (*p) {
-		parent = *p;
-		en = rb_entry(parent, struct extent_node, rb_node);
-
-		if (ei->fofs < en->ei.fofs)
-			p = &(*p)->rb_left;
-		else if (ei->fofs >= en->ei.fofs + en->ei.len)
-			p = &(*p)->rb_right;
-		else
-			f2fs_bug_on(sbi, 1);
-	}
+	p = __lookup_rb_tree_for_insert(sbi, &et->root, &parent, ei->fofs);
 do_insert:
 	en = __attach_extent_node(sbi, et, ei, parent, p);
 	if (!en)
@@ -447,7 +477,10 @@ static void f2fs_update_extent_tree_range(struct inode *inode,
 	__drop_largest_extent(inode, fofs, len);
 
 	/* 1. lookup first extent node in range [fofs, fofs + len - 1] */
-	en = __lookup_extent_tree_ret(et, fofs, &prev_en, &next_en,
+	en = (struct extent_node *)__lookup_rb_tree_ret(&et->root,
+					(struct rb_entry *)et->cached_en, fofs,
+					(struct rb_entry **)&prev_en,
+					(struct rb_entry **)&next_en,
 					&insert_p, &insert_parent);
 	if (!en)
 		en = next_en;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4615c96f8e39..562db8989a4e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -377,16 +377,30 @@ enum {
 /* number of extent info in extent cache we try to shrink */
 #define EXTENT_CACHE_SHRINK_NUMBER	128
 
+struct rb_entry {
+	struct rb_node rb_node;		/* rb node located in rb-tree */
+	unsigned int ofs;		/* start offset of the entry */
+	unsigned int len;		/* length of the entry */
+};
+
 struct extent_info {
 	unsigned int fofs;		/* start offset in a file */
-	u32 blk;			/* start block address of the extent */
 	unsigned int len;		/* length of the extent */
+	u32 blk;			/* start block address of the extent */
 };
 
 struct extent_node {
-	struct rb_node rb_node;		/* rb node located in rb-tree */
+	struct rb_node rb_node;
+	union {
+		struct {
+			unsigned int fofs;
+			unsigned int len;
+			u32 blk;
+		};
+		struct extent_info ei;	/* extent info */
+
+	};
 	struct list_head list;		/* node in global extent list of sbi */
-	struct extent_info ei;		/* extent info */
 	struct extent_tree *et;		/* extent tree pointer */
 };
 
-- 
2.12.2.510.ge1104a5ee539


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
