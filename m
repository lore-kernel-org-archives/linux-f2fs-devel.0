From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/2] f2fs: refactor shrink flow for extent cache
Date: Tue, 30 Jun 2015 18:42:09 +0800
Message-ID: <00ea01d0b321$854293d0$8fc7bb70$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

For now, in extent cache, we have a global lru list which links all extent
node in the cache, and the list is protected by a global spinlock.

If we want to shrink extent cache, we will:
1. delete all target extent node from global lru list under spinlock;
2. traverse all per-inode extent tree in global radix tree;
	2.a. traverse all extent node in per-inode extent tree, try to free extent
         node if it is not in global lru list already.

This method is inefficient when there is huge number of inode extent tree in
global extent tree.

In this patch we introduce a new method for extent cache shrinking:
When we attach a new extent node, we record extent tree pointer in extent node.
In shrink flow, we can try to find and lock extent tree of inode directly by
this backward pointer, and then detach the extent node from extent tree.

This can help to shrink extent cache more efficiently.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c | 113 ++++++++++++++++++++++++++++++++++-----------------------
 fs/f2fs/f2fs.h |   6 +++
 2 files changed, 73 insertions(+), 46 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e90522a..e96916a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -279,6 +279,7 @@ static struct extent_node *__attach_extent_node(struct f2fs_sb_info *sbi,
 	en->ei = *ei;
 	INIT_LIST_HEAD(&en->list);
 
+	en->et = et;
 	rb_link_node(&en->rb_node, parent, p);
 	rb_insert_color(&en->rb_node, &et->root);
 	et->count++;
@@ -435,7 +436,7 @@ update_out:
 }
 
 static unsigned int __free_extent_tree(struct f2fs_sb_info *sbi,
-					struct extent_tree *et, bool free_all)
+						struct extent_tree *et)
 {
 	struct rb_node *node, *next;
 	struct extent_node *en;
@@ -446,23 +447,42 @@ static unsigned int __free_extent_tree(struct f2fs_sb_info *sbi,
 		next = rb_next(node);
 		en = rb_entry(node, struct extent_node, rb_node);
 
-		if (free_all) {
-			spin_lock(&sbi->extent_lock);
-			if (!list_empty(&en->list))
-				list_del_init(&en->list);
-			spin_unlock(&sbi->extent_lock);
-		}
+		spin_lock(&sbi->extent_lock);
+		if (!list_empty(&en->list))
+			list_del_init(&en->list);
+		spin_unlock(&sbi->extent_lock);
 
-		if (free_all || list_empty(&en->list)) {
-			__detach_extent_node(sbi, et, en);
-			kmem_cache_free(extent_node_slab, en);
-		}
+		__detach_extent_node(sbi, et, en);
+		kmem_cache_free(extent_node_slab, en);
 		node = next;
 	}
 
 	return count - et->count;
 }
 
+static bool __try_free_extent_tree(struct f2fs_sb_info *sbi, nid_t ino)
+{
+	struct extent_tree *et;
+
+	if (!down_write_trylock(&sbi->extent_tree_lock))
+		return false;
+
+	et = radix_tree_lookup(&sbi->extent_tree_root, ino);
+	if (!et)
+		goto out;
+
+	if (__can_free_extent_tree(et)) {
+		radix_tree_delete(&sbi->extent_tree_root, ino);
+		kmem_cache_free(extent_tree_slab, et);
+		sbi->total_ext_tree--;
+		up_write(&sbi->extent_tree_lock);
+		return true;
+	}
+out:
+	up_write(&sbi->extent_tree_lock);
+	return false;
+}
+
 static void __drop_largest_extent(struct inode *inode, pgoff_t fofs)
 {
 	struct extent_info *largest = &F2FS_I(inode)->extent_tree->largest;
@@ -633,7 +653,7 @@ update_extent:
 		kmem_cache_free(extent_node_slab, den);
 
 	if (is_inode_flag_set(F2FS_I(inode), FI_NO_EXTENT))
-		__free_extent_tree(sbi, et, true);
+		__free_extent_tree(sbi, et);
 
 	write_unlock(&et->lock);
 
@@ -642,48 +662,49 @@ update_extent:
 
 unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
 {
-	struct extent_tree *treevec[EXT_TREE_VEC_SIZE];
-	struct extent_node *en, *tmp;
-	unsigned long ino = F2FS_ROOT_INO(sbi);
-	struct radix_tree_root *root = &sbi->extent_tree_root;
-	unsigned int found;
+	struct extent_tree *et;
+	struct extent_node *en;
 	unsigned int node_cnt = 0, tree_cnt = 0;
 
 	if (!test_opt(sbi, EXTENT_CACHE))
 		return 0;
 
 	spin_lock(&sbi->extent_lock);
-	list_for_each_entry_safe(en, tmp, &sbi->extent_list, list) {
-		if (!nr_shrink--)
-			break;
-		list_del_init(&en->list);
-	}
-	spin_unlock(&sbi->extent_lock);
+	for (; nr_shrink > 0; nr_shrink--) {
+		nid_t ino;
+		bool can_free;
 
-	if (!down_write_trylock(&sbi->extent_tree_lock))
-		goto out;
+		if (list_empty(&sbi->extent_list))
+			break;
+		en = list_first_entry(&sbi->extent_list, struct extent_node,
+								list);
+		et = en->et;
 
-	while ((found = radix_tree_gang_lookup(root,
-				(void **)treevec, ino, EXT_TREE_VEC_SIZE))) {
-		unsigned i;
-
-		ino = treevec[found - 1]->ino + 1;
-		for (i = 0; i < found; i++) {
-			struct extent_tree *et = treevec[i];
-
-			write_lock(&et->lock);
-			node_cnt += __free_extent_tree(sbi, et, false);
-			write_unlock(&et->lock);
-			if (!atomic_read(&et->refcount) && !et->count) {
-				radix_tree_delete(root, et->ino);
-				kmem_cache_free(extent_tree_slab, et);
-				sbi->total_ext_tree--;
-				tree_cnt++;
-			}
+		if (!write_trylock(&et->lock)) {
+			/* refresh this extent node's position in extent list */
+			list_move_tail(&en->list, &sbi->extent_list);
+			continue;
 		}
+
+		list_del(&en->list);
+		spin_unlock(&sbi->extent_lock);
+
+		__detach_extent_node(sbi, et, en);
+		kmem_cache_free(extent_node_slab, en);
+
+		ino = et->ino;
+		can_free = __can_free_extent_tree(et);
+		write_unlock(&et->lock);
+
+		node_cnt++;
+
+		if (can_free && __try_free_extent_tree(sbi, ino))
+			tree_cnt++;
+
+		spin_lock(&sbi->extent_lock);
 	}
-	up_write(&sbi->extent_tree_lock);
-out:
+	spin_unlock(&sbi->extent_lock);
+
 	trace_f2fs_shrink_extent_tree(sbi, node_cnt, tree_cnt);
 
 	return node_cnt + tree_cnt;
@@ -699,7 +720,7 @@ void f2fs_destroy_extent_node(struct inode *inode)
 		return;
 
 	write_lock(&et->lock);
-	node_cnt = __free_extent_tree(sbi, et, true);
+	node_cnt = __free_extent_tree(sbi, et);
 	write_unlock(&et->lock);
 }
 
@@ -723,7 +744,7 @@ void f2fs_destroy_extent_tree(struct inode *inode)
 	/* delete extent tree entry in radix tree */
 	down_write(&sbi->extent_tree_lock);
 	atomic_dec(&et->refcount);
-	f2fs_bug_on(sbi, atomic_read(&et->refcount) || et->count);
+	f2fs_bug_on(sbi, !__can_free_extent_tree(et));
 	radix_tree_delete(&sbi->extent_tree_root, inode->i_ino);
 	kmem_cache_free(extent_tree_slab, et);
 	sbi->total_ext_tree--;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2baca08..ee4c04a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -343,6 +343,7 @@ struct extent_node {
 	struct rb_node rb_node;		/* rb node located in rb-tree */
 	struct list_head list;		/* node in global extent list of sbi */
 	struct extent_info ei;		/* extent info */
+	struct extent_tree *et;         /* backref extent tree for shrinker */
 };
 
 struct extent_tree {
@@ -485,6 +486,11 @@ static inline bool __is_front_mergeable(struct extent_info *cur,
 	return __is_extent_mergeable(cur, front);
 }
 
+static inline bool __can_free_extent_tree(struct extent_tree *et)
+{
+	return (!atomic_read(&et->refcount) && !et->count);
+}
+
 struct f2fs_nm_info {
 	block_t nat_blkaddr;		/* base disk address of NAT */
 	nid_t max_nid;			/* maximum possible node ids */
-- 
2.4.2
