From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/6] f2fs: speed up shrinking extent_node cache
Date: Mon, 25 Jan 2016 14:05:26 -0800
Message-ID: <1453759531-16076-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch speeds up extent_node shrinker by introducing linked list.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/extent_cache.c | 74 ++++++++++++++++++++++----------------------------
 fs/f2fs/f2fs.h         |  2 ++
 2 files changed, 35 insertions(+), 41 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index ccd5c63..18311ff 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -32,7 +32,9 @@ static struct extent_node *__attach_extent_node(struct f2fs_sb_info *sbi,
 		return NULL;
 
 	en->ei = *ei;
+	en->et = et;
 	INIT_LIST_HEAD(&en->list);
+	INIT_LIST_HEAD(&en->vlist);
 
 	rb_link_node(&en->rb_node, parent, p);
 	rb_insert_color(&en->rb_node, &et->root);
@@ -129,7 +131,7 @@ static struct extent_node *__init_extent_tree(struct f2fs_sb_info *sbi,
 }
 
 static unsigned int __free_extent_tree(struct f2fs_sb_info *sbi,
-					struct extent_tree *et, bool free_all)
+					struct extent_tree *et)
 {
 	struct rb_node *node, *next;
 	struct extent_node *en;
@@ -137,17 +139,19 @@ static unsigned int __free_extent_tree(struct f2fs_sb_info *sbi,
 
 	node = rb_first(&et->root);
 	while (node) {
+		bool need_free = false;
+
 		next = rb_next(node);
 		en = rb_entry(node, struct extent_node, rb_node);
 
-		if (free_all) {
-			spin_lock(&sbi->extent_lock);
-			if (!list_empty(&en->list))
-				list_del_init(&en->list);
-			spin_unlock(&sbi->extent_lock);
+		spin_lock(&sbi->extent_lock);
+		if (!list_empty(&en->list)) {
+			list_del_init(&en->list);
+			need_free = true;
 		}
+		spin_unlock(&sbi->extent_lock);
 
-		if (free_all || list_empty(&en->list)) {
+		if (need_free) {
 			__detach_extent_node(sbi, et, en);
 			kmem_cache_free(extent_node_slab, en);
 		}
@@ -438,6 +442,7 @@ static unsigned int f2fs_update_extent_tree_range(struct inode *inode,
 	while (en && en->ei.fofs < end) {
 		unsigned int org_end;
 		int parts = 0;	/* # of parts current extent split into */
+		bool need_free = false;
 
 		next_en = en1 = NULL;
 
@@ -493,14 +498,16 @@ static unsigned int f2fs_update_extent_tree_range(struct inode *inode,
 
 		/* update in global extent list */
 		spin_lock(&sbi->extent_lock);
-		if (!parts && !list_empty(&en->list))
+		if (!parts && !list_empty(&en->list)) {
 			list_del(&en->list);
+			need_free = true;
+		}
 		if (en1)
 			list_add_tail(&en1->list, &sbi->extent_list);
 		spin_unlock(&sbi->extent_lock);
 
 		/* release extent node */
-		if (!parts)
+		if (!parts && need_free)
 			kmem_cache_free(extent_node_slab, en);
 
 		en = next_en;
@@ -509,6 +516,7 @@ static unsigned int f2fs_update_extent_tree_range(struct inode *inode,
 	/* 3. update extent in extent cache */
 	if (blkaddr) {
 		struct extent_node *den = NULL;
+		bool need_free = false;
 
 		set_extent_info(&ei, fofs, blkaddr, len);
 		en1 = __try_merge_extent_node(sbi, et, &ei, &den,
@@ -532,16 +540,18 @@ static unsigned int f2fs_update_extent_tree_range(struct inode *inode,
 			else
 				list_move_tail(&en1->list, &sbi->extent_list);
 		}
-		if (den && !list_empty(&den->list))
+		if (den && !list_empty(&den->list)) {
 			list_del(&den->list);
+			need_free = true;
+		}
 		spin_unlock(&sbi->extent_lock);
 
-		if (den)
+		if (den && need_free)
 			kmem_cache_free(extent_node_slab, den);
 	}
 
 	if (is_inode_flag_set(F2FS_I(inode), FI_NO_EXTENT))
-		__free_extent_tree(sbi, et, true);
+		__free_extent_tree(sbi, et);
 
 	write_unlock(&et->lock);
 
@@ -550,14 +560,12 @@ static unsigned int f2fs_update_extent_tree_range(struct inode *inode,
 
 unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
 {
-	struct extent_tree *treevec[EXT_TREE_VEC_SIZE];
 	struct extent_tree *et, *next;
 	struct extent_node *en, *tmp;
-	unsigned long ino = F2FS_ROOT_INO(sbi);
-	unsigned int found;
 	unsigned int node_cnt = 0, tree_cnt = 0;
 	int remained;
 	bool do_free = false;
+	LIST_HEAD(victim_list);
 
 	if (!test_opt(sbi, EXTENT_CACHE))
 		return 0;
@@ -572,7 +580,7 @@ unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
 	list_for_each_entry_safe(et, next, &sbi->zombie_list, list) {
 		if (atomic_read(&et->node_cnt)) {
 			write_lock(&et->lock);
-			node_cnt += __free_extent_tree(sbi, et, true);
+			node_cnt += __free_extent_tree(sbi, et);
 			write_unlock(&et->lock);
 		}
 
@@ -600,6 +608,8 @@ free_node:
 		if (!remained--)
 			break;
 		list_del_init(&en->list);
+		list_add_tail(&en->vlist, &victim_list);
+		tree_cnt++;
 		do_free = true;
 	}
 	spin_unlock(&sbi->extent_lock);
@@ -607,31 +617,13 @@ free_node:
 	if (do_free == false)
 		goto unlock_out;
 
-	/*
-	 * reset ino for searching victims from beginning of global extent tree.
-	 */
-	ino = F2FS_ROOT_INO(sbi);
-
-	while ((found = radix_tree_gang_lookup(&sbi->extent_tree_root,
-				(void **)treevec, ino, EXT_TREE_VEC_SIZE))) {
-		unsigned i;
-
-		ino = treevec[found - 1]->ino + 1;
-		for (i = 0; i < found; i++) {
-			struct extent_tree *et = treevec[i];
-
-			if (!atomic_read(&et->node_cnt))
-				continue;
-
-			if (write_trylock(&et->lock)) {
-				node_cnt += __free_extent_tree(sbi, et, false);
-				write_unlock(&et->lock);
-			}
-
-			if (node_cnt + tree_cnt >= nr_shrink)
-				goto unlock_out;
-		}
+	list_for_each_entry_safe(en, tmp, &victim_list, vlist) {
+		write_lock(&en->et->lock);
+		__detach_extent_node(sbi, en->et, en);
+		write_unlock(&en->et->lock);
+		kmem_cache_free(extent_node_slab, en);
 	}
+
 unlock_out:
 	up_write(&sbi->extent_tree_lock);
 out:
@@ -650,7 +642,7 @@ unsigned int f2fs_destroy_extent_node(struct inode *inode)
 		return 0;
 
 	write_lock(&et->lock);
-	node_cnt = __free_extent_tree(sbi, et, true);
+	node_cnt = __free_extent_tree(sbi, et);
 	write_unlock(&et->lock);
 
 	return node_cnt;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c4e723b..0bbbfed 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -353,7 +353,9 @@ struct extent_info {
 struct extent_node {
 	struct rb_node rb_node;		/* rb node located in rb-tree */
 	struct list_head list;		/* node in global extent list of sbi */
+	struct list_head vlist;		/* node in victim extent list */
 	struct extent_info ei;		/* extent info */
+	struct extent_tree *et;		/* extent tree pointer */
 };
 
 struct extent_tree {
-- 
2.6.3
