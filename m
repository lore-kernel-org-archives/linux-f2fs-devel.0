From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 5/9] f2fs: adjust showing of extent cache stat
Date: Wed, 19 Aug 2015 19:13:25 +0800
Message-ID: <017901d0da70$28f6a730$7ae3f590$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZS1Jt-0005RV-Hy
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Aug 2015 11:14:13 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZS1Jr-0007Jc-HD
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Aug 2015 11:14:13 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NTB01X10TVGGME0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Aug 2015 20:14:04 +0900 (KST)
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

This patch alters to replace total hit stat with rbtree hit stat,
and then adjust showing of extent cache stat:

Hit Count:
L1-1: for largest node hit count;
L1-2: for last cached node hit count;
L2: for extent node hit after lookuping in rbtree.

Hit Ratio:
ratio (hit count / total lookup count)

Inner Struct Count:
tree count, node count.

Before:
Extent Hit Ratio: 0 / 2

Extent Tree Count: 3

Extent Node Count: 2

Patched:
Exten Cacache:
  - Hit Count: L1-1:4871 L1-2:2074 L2:208
  - Hit Ratio: 1% (7153 / 550751)
  - Inner Struct Count: tree: 26560, node: 11824

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/debug.c        | 18 ++++++++++++------
 fs/f2fs/extent_cache.c | 10 +++++-----
 fs/f2fs/f2fs.h         |  9 +++++----
 3 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 1a1a4c6..d013d84 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -35,7 +35,8 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	/* validation check of the segment numbers */
 	si->hit_largest = atomic_read(&sbi->read_hit_largest);
 	si->hit_cached = atomic_read(&sbi->read_hit_cached);
-	si->hit_ext = atomic_read(&sbi->read_hit_ext);
+	si->hit_rbtree = atomic_read(&sbi->read_hit_rbtree);
+	si->hit_total = si->hit_largest + si->hit_cached + si->hit_rbtree;
 	si->total_ext = atomic_read(&sbi->total_hit_ext);
 	si->ext_tree = sbi->total_ext_tree;
 	si->ext_node = atomic_read(&sbi->total_ext_node);
@@ -281,11 +282,16 @@ static int stat_show(struct seq_file *s, void *v)
 				si->bg_data_blks);
 		seq_printf(s, "  - node blocks : %d (%d)\n", si->node_blks,
 				si->bg_node_blks);
-		seq_printf(s, "\nExtent Hit Ratio: L1-1:%d L1-2:%d L2:%d / %d\n",
+		seq_puts(s, "\nExtent Cache:\n");
+		seq_printf(s, "  - Hit Count: L1-1:%d L1-2:%d L2:%d\n",
 				si->hit_largest, si->hit_cached,
-				si->hit_ext, si->total_ext);
-		seq_printf(s, "\nExtent Tree Count: %d\n", si->ext_tree);
-		seq_printf(s, "\nExtent Node Count: %d\n", si->ext_node);
+				si->hit_rbtree);
+		seq_printf(s, "  - Hit Ratio: %d%% (%d / %d)\n",
+				!si->total_ext ? 0 :
+				(si->hit_total * 100) / si->total_ext,
+				si->hit_total, si->total_ext);
+		seq_printf(s, "  - Inner Struct Count: tree: %d, node: %d\n",
+				si->ext_tree, si->ext_node);
 		seq_puts(s, "\nBalancing F2FS Async:\n");
 		seq_printf(s, "  - inmem: %4d, wb: %4d\n",
 			   si->inmem_pages, si->wb_pages);
@@ -373,7 +379,7 @@ int f2fs_build_stats(struct f2fs_sb_info *sbi)
 	sbi->stat_info = si;
 
 	atomic_set(&sbi->total_hit_ext, 0);
-	atomic_set(&sbi->read_hit_ext, 0);
+	atomic_set(&sbi->read_hit_rbtree, 0);
 	atomic_set(&sbi->read_hit_largest, 0);
 	atomic_set(&sbi->read_hit_cached, 0);
 
diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 5cf217f..d11735a 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -99,12 +99,14 @@ static struct extent_node *__lookup_extent_tree(struct f2fs_sb_info *sbi,
 	while (node) {
 		en = rb_entry(node, struct extent_node, rb_node);
 
-		if (fofs < en->ei.fofs)
+		if (fofs < en->ei.fofs) {
 			node = node->rb_left;
-		else if (fofs >= en->ei.fofs + en->ei.len)
+		} else if (fofs >= en->ei.fofs + en->ei.len) {
 			node = node->rb_right;
-		else
+		} else {
+			stat_inc_rbtree_node_hit(sbi);
 			return en;
+		}
 	}
 	return NULL;
 }
@@ -281,7 +283,6 @@ static bool f2fs_lookup_extent_tree(struct inode *inode, pgoff_t pgofs,
 			et->largest.fofs + et->largest.len > pgofs) {
 		*ei = et->largest;
 		ret = true;
-		stat_inc_read_hit(sbi);
 		stat_inc_largest_node_hit(sbi);
 		goto out;
 	}
@@ -295,7 +296,6 @@ static bool f2fs_lookup_extent_tree(struct inode *inode, pgoff_t pgofs,
 		et->cached_en = en;
 		spin_unlock(&sbi->extent_lock);
 		ret = true;
-		stat_inc_read_hit(sbi);
 	}
 out:
 	stat_inc_total_hit(sbi);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 632cc37..68c5acd 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -793,7 +793,7 @@ struct f2fs_sb_info {
 	unsigned int block_count[2];		/* # of allocated blocks */
 	atomic_t inplace_count;		/* # of inplace update */
 	atomic_t total_hit_ext;			/* # of lookup extent cache */
-	atomic_t read_hit_ext;			/* # of hit extent cache */
+	atomic_t read_hit_rbtree;		/* # of hit rbtree extent node */
 	atomic_t read_hit_largest;		/* # of hit largest extent node */
 	atomic_t read_hit_cached;		/* # of hit cached extent node */
 	atomic_t inline_xattr;			/* # of inline_xattr inodes */
@@ -1841,7 +1841,8 @@ struct f2fs_stat_info {
 	struct f2fs_sb_info *sbi;
 	int all_area_segs, sit_area_segs, nat_area_segs, ssa_area_segs;
 	int main_area_segs, main_area_sections, main_area_zones;
-	int hit_largest, hit_cached, hit_ext, total_ext, ext_tree, ext_node;
+	int hit_largest, hit_cached, hit_rbtree, hit_total, total_ext;
+	int ext_tree, ext_node;
 	int ndirty_node, ndirty_dent, ndirty_dirs, ndirty_meta;
 	int nats, dirty_nats, sits, dirty_sits, fnids;
 	int total_count, utilization;
@@ -1878,7 +1879,7 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 #define stat_inc_dirty_dir(sbi)		((sbi)->n_dirty_dirs++)
 #define stat_dec_dirty_dir(sbi)		((sbi)->n_dirty_dirs--)
 #define stat_inc_total_hit(sbi)		(atomic_inc(&(sbi)->total_hit_ext))
-#define stat_inc_read_hit(sbi)		(atomic_inc(&(sbi)->read_hit_ext))
+#define stat_inc_rbtree_node_hit(sbi)	(atomic_inc(&(sbi)->read_hit_rbtree))
 #define stat_inc_largest_node_hit(sbi)	(atomic_inc(&(sbi)->read_hit_largest))
 #define stat_inc_cached_node_hit(sbi)	(atomic_inc(&(sbi)->read_hit_cached))
 #define stat_inc_inline_xattr(inode)					\
@@ -1960,7 +1961,7 @@ void f2fs_destroy_root_stats(void);
 #define stat_inc_dirty_dir(sbi)
 #define stat_dec_dirty_dir(sbi)
 #define stat_inc_total_hit(sb)
-#define stat_inc_read_hit(sb)
+#define stat_inc_rbtree_node_hit(sb)
 #define stat_inc_largest_node_hit(sbi)
 #define stat_inc_cached_node_hit(sbi)
 #define stat_inc_inline_xattr(inode)
-- 
2.4.2



------------------------------------------------------------------------------
