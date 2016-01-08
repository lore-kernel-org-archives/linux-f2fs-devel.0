From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/3] f2fs: use atomic type for node count in extent tree
Date: Fri, 08 Jan 2016 20:22:52 +0800
Message-ID: <005a01d14a0f$63b7cd90$2b2768b0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

1. rename field in struct extent_tree from count to node_cnt for
   readability.
2. alter to use atomic type for node_cnt.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/extent_cache.c | 17 +++++++++--------
 fs/f2fs/f2fs.h         |  2 +-
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 4dee2be..9febbc6 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -36,7 +36,7 @@ static struct extent_node *__attach_extent_node(struct f2fs_sb_info *sbi,
 
 	rb_link_node(&en->rb_node, parent, p);
 	rb_insert_color(&en->rb_node, &et->root);
-	et->count++;
+	atomic_inc(&et->node_cnt);
 	atomic_inc(&sbi->total_ext_node);
 	return en;
 }
@@ -45,7 +45,7 @@ static void __detach_extent_node(struct f2fs_sb_info *sbi,
 				struct extent_tree *et, struct extent_node *en)
 {
 	rb_erase(&en->rb_node, &et->root);
-	et->count--;
+	atomic_dec(&et->node_cnt);
 	atomic_dec(&sbi->total_ext_node);
 
 	if (et->cached_en == en)
@@ -69,7 +69,7 @@ static struct extent_tree *__grab_extent_tree(struct inode *inode)
 		et->cached_en = NULL;
 		rwlock_init(&et->lock);
 		INIT_LIST_HEAD(&et->list);
-		et->count = 0;
+		atomic_set(&et->node_cnt, 0);
 		atomic_inc(&sbi->total_ext_tree);
 	} else {
 		atomic_dec(&sbi->total_zombie_tree);
@@ -133,7 +133,7 @@ static unsigned int __free_extent_tree(struct f2fs_sb_info *sbi,
 {
 	struct rb_node *node, *next;
 	struct extent_node *en;
-	unsigned int count = et->count;
+	unsigned int count = atomic_read(&et->node_cnt);
 
 	node = rb_first(&et->root);
 	while (node) {
@@ -154,7 +154,7 @@ static unsigned int __free_extent_tree(struct f2fs_sb_info *sbi,
 		node = next;
 	}
 
-	return count - et->count;
+	return count - atomic_read(&et->node_cnt);
 }
 
 static void __drop_largest_extent(struct inode *inode,
@@ -192,7 +192,7 @@ bool f2fs_init_extent_tree(struct inode *inode, struct f2fs_extent *i_ext)
 		le32_to_cpu(i_ext->blk), le32_to_cpu(i_ext->len));
 
 	write_lock(&et->lock);
-	if (et->count)
+	if (atomic_read(&et->node_cnt))
 		goto out;
 
 	en = __init_extent_tree(sbi, et, &ei);
@@ -660,7 +660,8 @@ void f2fs_destroy_extent_tree(struct inode *inode)
 	if (!et)
 		return;
 
-	if (inode->i_nlink && !is_bad_inode(inode) && et->count) {
+	if (inode->i_nlink && !is_bad_inode(inode) &&
+					atomic_read(&et->node_cnt)) {
 		down_write(&sbi->extent_tree_lock);
 		list_add_tail(&et->list, &sbi->zombie_list);
 		atomic_inc(&sbi->total_zombie_tree);
@@ -673,7 +674,7 @@ void f2fs_destroy_extent_tree(struct inode *inode)
 
 	/* delete extent tree entry in radix tree */
 	down_write(&sbi->extent_tree_lock);
-	f2fs_bug_on(sbi, et->count);
+	f2fs_bug_on(sbi, atomic_read(&et->node_cnt));
 	radix_tree_delete(&sbi->extent_tree_root, inode->i_ino);
 	kmem_cache_free(extent_tree_slab, et);
 	atomic_dec(&sbi->total_ext_tree);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4128654..ae0007d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -361,7 +361,7 @@ struct extent_tree {
 	struct extent_info largest;	/* largested extent info */
 	struct list_head list;		/* to be used by sbi->zombie_list */
 	rwlock_t lock;			/* protect extent info rb-tree */
-	unsigned int count;		/* # of extent node in rb-tree*/
+	atomic_t node_cnt;		/* # of extent node in rb-tree*/
 };
 
 /*
-- 
2.6.3
