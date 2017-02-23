From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: replace rw semaphore extent_tree_lock with
	mutex lock
Date: Thu, 23 Feb 2017 19:39:59 +0800
Message-ID: <20170223113959.18436-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1cgrhO-0002N7-F3
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Feb 2017 11:36:38 +0000
Received: from [45.249.212.187] (helo=dggrg01-dlp.huawei.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cgrhM-00058F-NT
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Feb 2017 11:36:38 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net

This patch replace rw semaphore extent_tree_lock with mutex lock
for no read cases with this lock.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/extent_cache.c | 22 +++++++++++-----------
 fs/f2fs/f2fs.h         |  2 +-
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 6ed6424..0ab5518 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -77,7 +77,7 @@ static struct extent_tree *__grab_extent_tree(struct inode *inode)
 	struct extent_tree *et;
 	nid_t ino = inode->i_ino;
 
-	down_write(&sbi->extent_tree_lock);
+	mutex_lock(&sbi->extent_tree_lock);
 	et = radix_tree_lookup(&sbi->extent_tree_root, ino);
 	if (!et) {
 		et = f2fs_kmem_cache_alloc(extent_tree_slab, GFP_NOFS);
@@ -94,7 +94,7 @@ static struct extent_tree *__grab_extent_tree(struct inode *inode)
 		atomic_dec(&sbi->total_zombie_tree);
 		list_del_init(&et->list);
 	}
-	up_write(&sbi->extent_tree_lock);
+	mutex_unlock(&sbi->extent_tree_lock);
 
 	/* never died until evict_inode */
 	F2FS_I(inode)->extent_tree = et;
@@ -548,7 +548,7 @@ unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
 	if (!atomic_read(&sbi->total_zombie_tree))
 		goto free_node;
 
-	if (!down_write_trylock(&sbi->extent_tree_lock))
+	if (!mutex_trylock(&sbi->extent_tree_lock))
 		goto out;
 
 	/* 1. remove unreferenced extent tree */
@@ -570,11 +570,11 @@ unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
 			goto unlock_out;
 		cond_resched();
 	}
-	up_write(&sbi->extent_tree_lock);
+	mutex_unlock(&sbi->extent_tree_lock);
 
 free_node:
 	/* 2. remove LRU extent entries */
-	if (!down_write_trylock(&sbi->extent_tree_lock))
+	if (!mutex_trylock(&sbi->extent_tree_lock))
 		goto out;
 
 	remained = nr_shrink - (node_cnt + tree_cnt);
@@ -604,7 +604,7 @@ unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
 	spin_unlock(&sbi->extent_lock);
 
 unlock_out:
-	up_write(&sbi->extent_tree_lock);
+	mutex_unlock(&sbi->extent_tree_lock);
 out:
 	trace_f2fs_shrink_extent_tree(sbi, node_cnt, tree_cnt);
 
@@ -651,10 +651,10 @@ void f2fs_destroy_extent_tree(struct inode *inode)
 
 	if (inode->i_nlink && !is_bad_inode(inode) &&
 					atomic_read(&et->node_cnt)) {
-		down_write(&sbi->extent_tree_lock);
+		mutex_lock(&sbi->extent_tree_lock);
 		list_add_tail(&et->list, &sbi->zombie_list);
 		atomic_inc(&sbi->total_zombie_tree);
-		up_write(&sbi->extent_tree_lock);
+		mutex_unlock(&sbi->extent_tree_lock);
 		return;
 	}
 
@@ -662,12 +662,12 @@ void f2fs_destroy_extent_tree(struct inode *inode)
 	node_cnt = f2fs_destroy_extent_node(inode);
 
 	/* delete extent tree entry in radix tree */
-	down_write(&sbi->extent_tree_lock);
+	mutex_lock(&sbi->extent_tree_lock);
 	f2fs_bug_on(sbi, atomic_read(&et->node_cnt));
 	radix_tree_delete(&sbi->extent_tree_root, inode->i_ino);
 	kmem_cache_free(extent_tree_slab, et);
 	atomic_dec(&sbi->total_ext_tree);
-	up_write(&sbi->extent_tree_lock);
+	mutex_unlock(&sbi->extent_tree_lock);
 
 	F2FS_I(inode)->extent_tree = NULL;
 
@@ -714,7 +714,7 @@ void f2fs_update_extent_cache_range(struct dnode_of_data *dn,
 void init_extent_cache_info(struct f2fs_sb_info *sbi)
 {
 	INIT_RADIX_TREE(&sbi->extent_tree_root, GFP_NOIO);
-	init_rwsem(&sbi->extent_tree_lock);
+	mutex_init(&sbi->extent_tree_lock);
 	INIT_LIST_HEAD(&sbi->extent_list);
 	spin_lock_init(&sbi->extent_lock);
 	atomic_set(&sbi->total_ext_tree, 0);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5448333..7938c79 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -852,7 +852,7 @@ struct f2fs_sb_info {
 
 	/* for extent tree cache */
 	struct radix_tree_root extent_tree_root;/* cache extent cache entries */
-	struct rw_semaphore extent_tree_lock;	/* locking extent radix tree */
+	struct mutex extent_tree_lock;	/* locking extent radix tree */
 	struct list_head extent_list;		/* lru list for shrinker */
 	spinlock_t extent_lock;			/* locking extent lru list */
 	atomic_t total_ext_tree;		/* extent tree count */
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
