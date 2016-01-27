From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: remove vlist in extent node
Date: Wed, 27 Jan 2016 13:38:23 -0800
Message-ID: <20160127213823.GA62463@jaegeuk.gateway>
References: <00db01d158ea$22b98470$682c8d50$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aOXnN-0001eh-Qu
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 27 Jan 2016 21:38:33 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aOXnM-00074o-GY for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 27 Jan 2016 21:38:33 +0000
Content-Disposition: inline
In-Reply-To: <00db01d158ea$22b98470$682c8d50$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Chao,

Hmm. The original patch was just going under testing, and we couldn't post
them since there is a kernel panic issue.
This patch seems quite better approach, so I think we can integrate both of
the patches together.

So, how about this patch?
Hope you don't mind this.

Thanks,

>From a7844e0438db9ea9d12b7c0c40b655c3371bd6c9 Mon Sep 17 00:00:00 2001
From: Hou Pengyang <houpengyang@huawei.com>
Date: Tue, 26 Jan 2016 12:56:26 +0000
Subject: [PATCH] f2fs: improve shrink performance of extent nodes

On the worst case, we need to scan the whole radix tree and every rb-tree to
free the victimed extent_nodes when shrinking.

Pengyang initially introduced a victim_list to record the victimed extent_nodes,
and free these extent_nodes by just scanning a list.

Later, Chao Yu enhances the original patch to improve memory footprint by
removing victim list.

The policy of lru list shrinking becomes:
1) lock lru list's lock
2) trylock extent tree's lock
3) remove extent node from lru list
4) unlock lru list's lock
5) do shrink
6) repeat 1) to 5)

Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
Signed-off-by: Chao Yu <chao2.yu@samsung.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/extent_cache.c | 87 +++++++++++++++++++++-----------------------------
 fs/f2fs/f2fs.h         |  1 +
 2 files changed, 37 insertions(+), 51 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index aae99f2..759b1b1 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -33,6 +33,7 @@ static struct extent_node *__attach_extent_node(struct f2fs_sb_info *sbi,
 
 	en->ei = *ei;
 	INIT_LIST_HEAD(&en->list);
+	en->et = et;
 
 	rb_link_node(&en->rb_node, parent, p);
 	rb_insert_color(&en->rb_node, &et->root);
@@ -63,8 +64,8 @@ static void __release_extent_node(struct f2fs_sb_info *sbi,
 			struct extent_tree *et, struct extent_node *en)
 {
 	spin_lock(&sbi->extent_lock);
-	if (!list_empty(&en->list))
-		list_del_init(&en->list);
+	f2fs_bug_on(sbi, list_empty(&en->list));
+	list_del_init(&en->list);
 	spin_unlock(&sbi->extent_lock);
 
 	__detach_extent_node(sbi, et, en);
@@ -147,7 +148,7 @@ static struct extent_node *__init_extent_tree(struct f2fs_sb_info *sbi,
 }
 
 static unsigned int __free_extent_tree(struct f2fs_sb_info *sbi,
-					struct extent_tree *et, bool free_all)
+					struct extent_tree *et)
 {
 	struct rb_node *node, *next;
 	struct extent_node *en;
@@ -157,11 +158,7 @@ static unsigned int __free_extent_tree(struct f2fs_sb_info *sbi,
 	while (node) {
 		next = rb_next(node);
 		en = rb_entry(node, struct extent_node, rb_node);
-
-		if (free_all)
-			__release_extent_node(sbi, et, en);
-		else if (list_empty(&en->list))
-			__detach_extent_node(sbi, et, en);
+		__release_extent_node(sbi, et, en);
 		node = next;
 	}
 
@@ -532,7 +529,7 @@ static unsigned int f2fs_update_extent_tree_range(struct inode *inode,
 	}
 
 	if (is_inode_flag_set(F2FS_I(inode), FI_NO_EXTENT))
-		__free_extent_tree(sbi, et, true);
+		__free_extent_tree(sbi, et);
 
 	write_unlock(&et->lock);
 
@@ -541,14 +538,10 @@ static unsigned int f2fs_update_extent_tree_range(struct inode *inode,
 
 unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
 {
-	struct extent_tree *treevec[EXT_TREE_VEC_SIZE];
 	struct extent_tree *et, *next;
-	struct extent_node *en, *tmp;
-	unsigned long ino = F2FS_ROOT_INO(sbi);
-	unsigned int found;
+	struct extent_node *en;
 	unsigned int node_cnt = 0, tree_cnt = 0;
 	int remained;
-	bool do_free = false;
 
 	if (!test_opt(sbi, EXTENT_CACHE))
 		return 0;
@@ -561,11 +554,11 @@ unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
 
 	/* 1. remove unreferenced extent tree */
 	list_for_each_entry_safe(et, next, &sbi->zombie_list, list) {
-		if (atomic_read(&et->node_cnt)) {
-			write_lock(&et->lock);
-			node_cnt += __free_extent_tree(sbi, et, true);
-			write_unlock(&et->lock);
-		}
+		write_lock(&et->lock);
+		node_cnt += __free_extent_tree(sbi, et);
+		write_unlock(&et->lock);
+		if (atomic_read(&et->node_cnt) > 0)
+			goto unlock_out;
 
 		list_del_init(&et->list);
 		radix_tree_delete(&sbi->extent_tree_root, et->ino);
@@ -587,42 +580,29 @@ free_node:
 	remained = nr_shrink - (node_cnt + tree_cnt);
 
 	spin_lock(&sbi->extent_lock);
-	list_for_each_entry_safe(en, tmp, &sbi->extent_list, list) {
-		if (!remained--)
+	for (; remained > 0; remained--) {
+		if (list_empty(&sbi->extent_list))
 			break;
-		list_del_init(&en->list);
-		do_free = true;
-	}
-	spin_unlock(&sbi->extent_lock);
-
-	if (do_free == false)
-		goto unlock_out;
-
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
+		en = list_first_entry(&sbi->extent_list,
+					struct extent_node, list);
+		et = en->et;
+		if (!write_trylock(&et->lock)) {
+			/* refresh this extent node's position in extent list */
+			list_move_tail(&en->list, &sbi->extent_list);
+			continue;
+		}
 
-			if (!atomic_read(&et->node_cnt))
-				continue;
+		list_del_init(&en->list);
+		spin_unlock(&sbi->extent_lock);
 
-			if (write_trylock(&et->lock)) {
-				node_cnt += __free_extent_tree(sbi, et, false);
-				write_unlock(&et->lock);
-			}
+		__detach_extent_node(sbi, et, en);
 
-			if (node_cnt + tree_cnt >= nr_shrink)
-				goto unlock_out;
-		}
+		write_unlock(&et->lock);
+		node_cnt++;
+		spin_lock(&sbi->extent_lock);
 	}
+	spin_unlock(&sbi->extent_lock);
+
 unlock_out:
 	up_write(&sbi->extent_tree_lock);
 out:
@@ -641,7 +621,7 @@ unsigned int f2fs_destroy_extent_node(struct inode *inode)
 		return 0;
 
 	write_lock(&et->lock);
-	node_cnt = __free_extent_tree(sbi, et, true);
+	node_cnt = __free_extent_tree(sbi, et);
 	write_unlock(&et->lock);
 
 	return node_cnt;
@@ -666,10 +646,15 @@ void f2fs_destroy_extent_tree(struct inode *inode)
 	}
 
 	/* free all extent info belong to this extent tree */
+free_more:
 	node_cnt = f2fs_destroy_extent_node(inode);
 
 	/* delete extent tree entry in radix tree */
 	down_write(&sbi->extent_tree_lock);
+	if (atomic_read(&et->node_cnt) > 0) {
+		up_write(&sbi->extent_tree_lock);
+		goto free_more;
+	}
 	f2fs_bug_on(sbi, atomic_read(&et->node_cnt));
 	radix_tree_delete(&sbi->extent_tree_root, inode->i_ino);
 	kmem_cache_free(extent_tree_slab, et);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c4e723b..4e7eab9 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -354,6 +354,7 @@ struct extent_node {
 	struct rb_node rb_node;		/* rb node located in rb-tree */
 	struct list_head list;		/* node in global extent list of sbi */
 	struct extent_info ei;		/* extent info */
+	struct extent_tree *et;		/* extent tree pointer */
 };
 
 struct extent_tree {
-- 
2.6.3


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
