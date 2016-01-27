From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: remove vlist in extent node
Date: Wed, 27 Jan 2016 18:04:00 +0800
Message-ID: <00db01d158ea$22b98470$682c8d50$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

For speeding up shrinking extent nodes from lru list, we introduced
additional list node named 'vlist' for each extent node, in order to
link them into victim list and then do the shrink job by traversing
the list, but it makes memory footprint overhead for extent cache.

We change the policy of lru list shrinking to:
1) lock lru list's lock
2) trylock extent tree's lock
3) remove extent node from lru list
4) unlock lru list's lock
5) do shrink
6) repeat 1) to 5)

extent node size:
32-bit machine: decrease from 44 bytes to 36 bytes
64-bit machine: decrease from 80 bytes to 64 bytes

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/extent_cache.c | 59 ++++++++++++++++++++------------------------------
 fs/f2fs/f2fs.h         |  1 -
 2 files changed, 24 insertions(+), 36 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index cf949bb..0cfd13c 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -33,7 +33,6 @@ static struct extent_node *__attach_extent_node(struct f2fs_sb_info *sbi,
 
 	en->ei = *ei;
 	INIT_LIST_HEAD(&en->list);
-	INIT_LIST_HEAD(&en->vlist);
 	en->et = et;
 
 	rb_link_node(&en->rb_node, parent, p);
@@ -47,6 +46,9 @@ static void __detach_extent_node(struct f2fs_sb_info *sbi,
 				struct extent_tree *et, struct extent_node *en)
 {
 	rb_erase(&en->rb_node, &et->root);
+	atomic_dec(&et->node_cnt);
+	atomic_dec(&sbi->total_ext_node);
+	kmem_cache_free(extent_node_slab, en);
 
 	if (et->cached_en == en)
 		et->cached_en = NULL;
@@ -61,21 +63,12 @@ static void __detach_extent_node(struct f2fs_sb_info *sbi,
 static void __release_extent_node(struct f2fs_sb_info *sbi,
 			struct extent_tree *et, struct extent_node *en)
 {
-	bool need_free = false;
-
 	spin_lock(&sbi->extent_lock);
-	if (!list_empty(&en->list)) {
-		list_del_init(&en->list);
-		need_free = true;
-	}
+	f2fs_bug_on(sbi, list_empty(&en->list));
+	list_del_init(&en->list);
 	spin_unlock(&sbi->extent_lock);
 
 	__detach_extent_node(sbi, et, en);
-	if (need_free) {
-		atomic_dec(&et->node_cnt);
-		atomic_dec(&sbi->total_ext_node);
-		kmem_cache_free(extent_node_slab, en);
-	}
 }
 
 static struct extent_tree *__grab_extent_tree(struct inode *inode)
@@ -214,8 +207,6 @@ bool f2fs_init_extent_tree(struct inode *inode, struct f2fs_extent *i_ext)
 	en = __init_extent_tree(sbi, et, &ei);
 	if (en) {
 		spin_lock(&sbi->extent_lock);
-		f2fs_bug_on(sbi, !list_empty(&en->list) ||
-				!list_empty(&en->vlist));
 		list_add_tail(&en->list, &sbi->extent_list);
 		spin_unlock(&sbi->extent_lock);
 	}
@@ -251,7 +242,6 @@ static bool f2fs_lookup_extent_tree(struct inode *inode, pgoff_t pgofs,
 		*ei = en->ei;
 		spin_lock(&sbi->extent_lock);
 		if (!list_empty(&en->list)) {
-			f2fs_bug_on(sbi, !list_empty(&en->vlist));
 			list_move_tail(&en->list, &sbi->extent_list);
 			et->cached_en = en;
 		}
@@ -376,7 +366,6 @@ static struct extent_node *__try_merge_extent_node(struct f2fs_sb_info *sbi,
 
 	spin_lock(&sbi->extent_lock);
 	if (!list_empty(&en->list)) {
-		f2fs_bug_on(sbi, !list_empty(&en->vlist));
 		list_move_tail(&en->list, &sbi->extent_list);
 		et->cached_en = en;
 	}
@@ -419,7 +408,6 @@ do_insert:
 
 	/* update in global extent list */
 	spin_lock(&sbi->extent_lock);
-	f2fs_bug_on(sbi, !list_empty(&en->list) || !list_empty(&en->vlist));
 	list_add_tail(&en->list, &sbi->extent_list);
 	et->cached_en = en;
 	spin_unlock(&sbi->extent_lock);
@@ -552,11 +540,9 @@ static unsigned int f2fs_update_extent_tree_range(struct inode *inode,
 unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
 {
 	struct extent_tree *et, *next;
-	struct extent_node *en, *tmp;
+	struct extent_node *en;
 	unsigned int node_cnt = 0, tree_cnt = 0;
 	int remained;
-	bool do_free = false;
-	LIST_HEAD(victim_extent_node_list);
 
 	if (!test_opt(sbi, EXTENT_CACHE))
 		return 0;
@@ -596,28 +582,31 @@ free_node:
 	remained = nr_shrink - (node_cnt + tree_cnt);
 
 	spin_lock(&sbi->extent_lock);
-	list_for_each_entry_safe(en, tmp, &sbi->extent_list, list) {
-		if (!remained--)
+	for (; remained > 0; remained--) {
+		if (list_empty(&sbi->extent_list))
 			break;
+		en = list_first_entry(&sbi->extent_list,
+					struct extent_node, list);
+		et = en->et;
+		if (!write_trylock(&et->lock)) {
+			/* refresh this extent node's position in extent list */
+			list_move_tail(&en->list, &sbi->extent_list);
+			continue;
+		}
+
 		list_del_init(&en->list);
-		list_move_tail(&en->vlist, &victim_extent_node_list);
-		do_free = true;
-	}
-	spin_unlock(&sbi->extent_lock);
+		spin_unlock(&sbi->extent_lock);
 
-	if (do_free == false)
-		goto unlock_out;
+		__detach_extent_node(sbi, et, en);
 
-	list_for_each_entry_safe(en, tmp, &victim_extent_node_list, vlist) {
-		write_lock(&en->et->lock);
-		__detach_extent_node(sbi, en->et, en);
-		atomic_dec(&en->et->node_cnt);
-		atomic_dec(&sbi->total_ext_node);
-		write_unlock(&en->et->lock);
-		kmem_cache_free(extent_node_slab, en);
+		write_unlock(&et->lock);
 		node_cnt++;
+
 		cond_resched();
+		spin_lock(&sbi->extent_lock);
 	}
+	spin_unlock(&sbi->extent_lock);
+
 unlock_out:
 	up_write(&sbi->extent_tree_lock);
 out:
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4812c47..4e7eab9 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -353,7 +353,6 @@ struct extent_info {
 struct extent_node {
 	struct rb_node rb_node;		/* rb node located in rb-tree */
 	struct list_head list;		/* node in global extent list of sbi */
-	struct list_head vlist;		/* node in local victim list */
 	struct extent_info ei;		/* extent info */
 	struct extent_tree *et;		/* extent tree pointer */
 };
-- 
2.7.0.2.g1b0b6dd
