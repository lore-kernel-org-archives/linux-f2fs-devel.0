From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5/5] f2fs: introduce zombie list for fast
	shrinking extent trees
Date: Thu, 31 Dec 2015 15:49:54 -0800
Message-ID: <1451605794-5636-5-git-send-email-jaegeuk@kernel.org>
References: <1451605794-5636-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aEmyy-0004AC-RU
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 31 Dec 2015 23:50:12 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aEmyx-0003Y5-U2 for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 31 Dec 2015 23:50:12 +0000
In-Reply-To: <1451605794-5636-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch removes refcount, and instead, adds zombie_list to shrink directly
without radix tree traverse.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/extent_cache.c | 49 +++++++++++++++++++++----------------------------
 fs/f2fs/f2fs.h         |  3 ++-
 2 files changed, 23 insertions(+), 29 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index b37184f..4dee2be 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -68,13 +68,13 @@ static struct extent_tree *__grab_extent_tree(struct inode *inode)
 		et->root = RB_ROOT;
 		et->cached_en = NULL;
 		rwlock_init(&et->lock);
-		atomic_set(&et->refcount, 0);
+		INIT_LIST_HEAD(&et->list);
 		et->count = 0;
 		atomic_inc(&sbi->total_ext_tree);
 	} else {
 		atomic_dec(&sbi->total_zombie_tree);
+		list_del_init(&et->list);
 	}
-	atomic_inc(&et->refcount);
 	up_write(&sbi->extent_tree_lock);
 
 	/* never died until evict_inode */
@@ -551,9 +551,9 @@ static unsigned int f2fs_update_extent_tree_range(struct inode *inode,
 unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
 {
 	struct extent_tree *treevec[EXT_TREE_VEC_SIZE];
+	struct extent_tree *et, *next;
 	struct extent_node *en, *tmp;
 	unsigned long ino = F2FS_ROOT_INO(sbi);
-	struct radix_tree_root *root = &sbi->extent_tree_root;
 	unsigned int found;
 	unsigned int node_cnt = 0, tree_cnt = 0;
 	int remained;
@@ -569,29 +569,20 @@ unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
 		goto out;
 
 	/* 1. remove unreferenced extent tree */
-	while ((found = radix_tree_gang_lookup(root,
-				(void **)treevec, ino, EXT_TREE_VEC_SIZE))) {
-		unsigned i;
-
-		ino = treevec[found - 1]->ino + 1;
-		for (i = 0; i < found; i++) {
-			struct extent_tree *et = treevec[i];
-
-			if (!atomic_read(&et->refcount)) {
-				write_lock(&et->lock);
-				node_cnt += __free_extent_tree(sbi, et, true);
-				write_unlock(&et->lock);
+	list_for_each_entry_safe(et, next, &sbi->zombie_list, list) {
+		write_lock(&et->lock);
+		node_cnt += __free_extent_tree(sbi, et, true);
+		write_unlock(&et->lock);
 
-				radix_tree_delete(root, et->ino);
-				kmem_cache_free(extent_tree_slab, et);
-				atomic_dec(&sbi->total_ext_tree);
-				atomic_dec(&sbi->total_zombie_tree);
-				tree_cnt++;
+		list_del_init(&et->list);
+		radix_tree_delete(&sbi->extent_tree_root, et->ino);
+		kmem_cache_free(extent_tree_slab, et);
+		atomic_dec(&sbi->total_ext_tree);
+		atomic_dec(&sbi->total_zombie_tree);
+		tree_cnt++;
 
-				if (node_cnt + tree_cnt >= nr_shrink)
-					goto unlock_out;
-			}
-		}
+		if (node_cnt + tree_cnt >= nr_shrink)
+			goto unlock_out;
 	}
 	up_write(&sbi->extent_tree_lock);
 
@@ -619,7 +610,7 @@ free_node:
 	 */
 	ino = F2FS_ROOT_INO(sbi);
 
-	while ((found = radix_tree_gang_lookup(root,
+	while ((found = radix_tree_gang_lookup(&sbi->extent_tree_root,
 				(void **)treevec, ino, EXT_TREE_VEC_SIZE))) {
 		unsigned i;
 
@@ -670,8 +661,10 @@ void f2fs_destroy_extent_tree(struct inode *inode)
 		return;
 
 	if (inode->i_nlink && !is_bad_inode(inode) && et->count) {
-		atomic_dec(&et->refcount);
+		down_write(&sbi->extent_tree_lock);
+		list_add_tail(&et->list, &sbi->zombie_list);
 		atomic_inc(&sbi->total_zombie_tree);
+		up_write(&sbi->extent_tree_lock);
 		return;
 	}
 
@@ -680,8 +673,7 @@ void f2fs_destroy_extent_tree(struct inode *inode)
 
 	/* delete extent tree entry in radix tree */
 	down_write(&sbi->extent_tree_lock);
-	atomic_dec(&et->refcount);
-	f2fs_bug_on(sbi, atomic_read(&et->refcount) || et->count);
+	f2fs_bug_on(sbi, et->count);
 	radix_tree_delete(&sbi->extent_tree_root, inode->i_ino);
 	kmem_cache_free(extent_tree_slab, et);
 	atomic_dec(&sbi->total_ext_tree);
@@ -737,6 +729,7 @@ void init_extent_cache_info(struct f2fs_sb_info *sbi)
 	INIT_LIST_HEAD(&sbi->extent_list);
 	spin_lock_init(&sbi->extent_lock);
 	atomic_set(&sbi->total_ext_tree, 0);
+	INIT_LIST_HEAD(&sbi->zombie_list);
 	atomic_set(&sbi->total_zombie_tree, 0);
 	atomic_set(&sbi->total_ext_node, 0);
 }
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d81bf5a..e2990c9 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -359,8 +359,8 @@ struct extent_tree {
 	struct rb_root root;		/* root of extent info rb-tree */
 	struct extent_node *cached_en;	/* recently accessed extent node */
 	struct extent_info largest;	/* largested extent info */
+	struct list_head list;		/* to be used by sbi->zombie_list */
 	rwlock_t lock;			/* protect extent info rb-tree */
-	atomic_t refcount;		/* reference count of rb-tree */
 	unsigned int count;		/* # of extent node in rb-tree*/
 };
 
@@ -764,6 +764,7 @@ struct f2fs_sb_info {
 	struct list_head extent_list;		/* lru list for shrinker */
 	spinlock_t extent_lock;			/* locking extent lru list */
 	atomic_t total_ext_tree;		/* extent tree count */
+	struct list_head zombie_list;		/* extent zombie tree list */
 	atomic_t total_zombie_tree;		/* extent zombie tree count */
 	atomic_t total_ext_node;		/* extent info count */
 
-- 
2.6.3


------------------------------------------------------------------------------
