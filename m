From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: use atomic64_t for extent cache hit stat
Date: Wed, 30 Sep 2015 17:38:48 +0800
Message-ID: <00fb01d0fb63$e67d2680$b3777380$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZhDrN-0002QW-Po
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Sep 2015 09:39:37 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZhDrL-0001js-K4
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Sep 2015 09:39:37 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NVH02UGLHHK1U30@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Sep 2015 18:39:27 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Our hit stat of extent cache will increase all the time until remount,
and we use atomic_t type for the stat variable, so it may easily incur
overflow when we query extent cache frequently in a long time running
fs.

So to avoid that, this patch uses atomic64_t for hit stat variables.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/debug.c | 22 +++++++++++-----------
 fs/f2fs/f2fs.h  | 19 ++++++++++---------
 2 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 615a307..478e5d5 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -33,11 +33,11 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	int i;
 
 	/* validation check of the segment numbers */
-	si->hit_largest = atomic_read(&sbi->read_hit_largest);
-	si->hit_cached = atomic_read(&sbi->read_hit_cached);
-	si->hit_rbtree = atomic_read(&sbi->read_hit_rbtree);
+	si->hit_largest = atomic64_read(&sbi->read_hit_largest);
+	si->hit_cached = atomic64_read(&sbi->read_hit_cached);
+	si->hit_rbtree = atomic64_read(&sbi->read_hit_rbtree);
 	si->hit_total = si->hit_largest + si->hit_cached + si->hit_rbtree;
-	si->total_ext = atomic_read(&sbi->total_hit_ext);
+	si->total_ext = atomic64_read(&sbi->total_hit_ext);
 	si->ext_tree = sbi->total_ext_tree;
 	si->ext_node = atomic_read(&sbi->total_ext_node);
 	si->ndirty_node = get_pages(sbi, F2FS_DIRTY_NODES);
@@ -283,12 +283,12 @@ static int stat_show(struct seq_file *s, void *v)
 		seq_printf(s, "  - node blocks : %d (%d)\n", si->node_blks,
 				si->bg_node_blks);
 		seq_puts(s, "\nExtent Cache:\n");
-		seq_printf(s, "  - Hit Count: L1-1:%d L1-2:%d L2:%d\n",
+		seq_printf(s, "  - Hit Count: L1-1:%llu L1-2:%llu L2:%llu\n",
 				si->hit_largest, si->hit_cached,
 				si->hit_rbtree);
-		seq_printf(s, "  - Hit Ratio: %d%% (%d / %d)\n",
+		seq_printf(s, "  - Hit Ratio: %llu%% (%llu / %llu)\n",
 				!si->total_ext ? 0 :
-				(si->hit_total * 100) / si->total_ext,
+				div64_u64(si->hit_total * 100, si->total_ext),
 				si->hit_total, si->total_ext);
 		seq_printf(s, "  - Inner Struct Count: tree: %d, node: %d\n",
 				si->ext_tree, si->ext_node);
@@ -378,10 +378,10 @@ int f2fs_build_stats(struct f2fs_sb_info *sbi)
 	si->sbi = sbi;
 	sbi->stat_info = si;
 
-	atomic_set(&sbi->total_hit_ext, 0);
-	atomic_set(&sbi->read_hit_rbtree, 0);
-	atomic_set(&sbi->read_hit_largest, 0);
-	atomic_set(&sbi->read_hit_cached, 0);
+	atomic64_set(&sbi->total_hit_ext, 0);
+	atomic64_set(&sbi->read_hit_rbtree, 0);
+	atomic64_set(&sbi->read_hit_largest, 0);
+	atomic64_set(&sbi->read_hit_cached, 0);
 
 	atomic_set(&sbi->inline_xattr, 0);
 	atomic_set(&sbi->inline_inode, 0);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3961211..391e86b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -801,10 +801,10 @@ struct f2fs_sb_info {
 	unsigned int segment_count[2];		/* # of allocated segments */
 	unsigned int block_count[2];		/* # of allocated blocks */
 	atomic_t inplace_count;		/* # of inplace update */
-	atomic_t total_hit_ext;			/* # of lookup extent cache */
-	atomic_t read_hit_rbtree;		/* # of hit rbtree extent node */
-	atomic_t read_hit_largest;		/* # of hit largest extent node */
-	atomic_t read_hit_cached;		/* # of hit cached extent node */
+	atomic64_t total_hit_ext;		/* # of lookup extent cache */
+	atomic64_t read_hit_rbtree;		/* # of hit rbtree extent node */
+	atomic64_t read_hit_largest;		/* # of hit largest extent node */
+	atomic64_t read_hit_cached;		/* # of hit cached extent node */
 	atomic_t inline_xattr;			/* # of inline_xattr inodes */
 	atomic_t inline_inode;			/* # of inline_data inodes */
 	atomic_t inline_dir;			/* # of inline_dentry inodes */
@@ -1856,7 +1856,8 @@ struct f2fs_stat_info {
 	struct f2fs_sb_info *sbi;
 	int all_area_segs, sit_area_segs, nat_area_segs, ssa_area_segs;
 	int main_area_segs, main_area_sections, main_area_zones;
-	int hit_largest, hit_cached, hit_rbtree, hit_total, total_ext;
+	unsigned long long hit_largest, hit_cached, hit_rbtree;
+	unsigned long long hit_total, total_ext;
 	int ext_tree, ext_node;
 	int ndirty_node, ndirty_dent, ndirty_dirs, ndirty_meta;
 	int nats, dirty_nats, sits, dirty_sits, fnids;
@@ -1893,10 +1894,10 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 #define stat_inc_bggc_count(sbi)	((sbi)->bg_gc++)
 #define stat_inc_dirty_dir(sbi)		((sbi)->n_dirty_dirs++)
 #define stat_dec_dirty_dir(sbi)		((sbi)->n_dirty_dirs--)
-#define stat_inc_total_hit(sbi)		(atomic_inc(&(sbi)->total_hit_ext))
-#define stat_inc_rbtree_node_hit(sbi)	(atomic_inc(&(sbi)->read_hit_rbtree))
-#define stat_inc_largest_node_hit(sbi)	(atomic_inc(&(sbi)->read_hit_largest))
-#define stat_inc_cached_node_hit(sbi)	(atomic_inc(&(sbi)->read_hit_cached))
+#define stat_inc_total_hit(sbi)		(atomic64_inc(&(sbi)->total_hit_ext))
+#define stat_inc_rbtree_node_hit(sbi)	(atomic64_inc(&(sbi)->read_hit_rbtree))
+#define stat_inc_largest_node_hit(sbi)	(atomic64_inc(&(sbi)->read_hit_largest))
+#define stat_inc_cached_node_hit(sbi)	(atomic64_inc(&(sbi)->read_hit_cached))
 #define stat_inc_inline_xattr(inode)					\
 	do {								\
 		if (f2fs_has_inline_xattr(inode))			\
-- 
2.5.2



------------------------------------------------------------------------------
