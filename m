From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 4/9] f2fs: add largest/cached stat in extent cache
Date: Wed, 19 Aug 2015 19:12:20 +0800
Message-ID: <017801d0da70$02e2ba70$08a82f50$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch adds to stat the hit count of largest/cached node for showing
in debugfs.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/debug.c        |  9 +++++++--
 fs/f2fs/extent_cache.c | 14 +++++++++-----
 fs/f2fs/f2fs.h         |  8 +++++++-
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index bc215fd..1a1a4c6 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -33,6 +33,8 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	int i;
 
 	/* validation check of the segment numbers */
+	si->hit_largest = atomic_read(&sbi->read_hit_largest);
+	si->hit_cached = atomic_read(&sbi->read_hit_cached);
 	si->hit_ext = atomic_read(&sbi->read_hit_ext);
 	si->total_ext = atomic_read(&sbi->total_hit_ext);
 	si->ext_tree = sbi->total_ext_tree;
@@ -279,8 +281,9 @@ static int stat_show(struct seq_file *s, void *v)
 				si->bg_data_blks);
 		seq_printf(s, "  - node blocks : %d (%d)\n", si->node_blks,
 				si->bg_node_blks);
-		seq_printf(s, "\nExtent Hit Ratio: %d / %d\n",
-			   si->hit_ext, si->total_ext);
+		seq_printf(s, "\nExtent Hit Ratio: L1-1:%d L1-2:%d L2:%d / %d\n",
+				si->hit_largest, si->hit_cached,
+				si->hit_ext, si->total_ext);
 		seq_printf(s, "\nExtent Tree Count: %d\n", si->ext_tree);
 		seq_printf(s, "\nExtent Node Count: %d\n", si->ext_node);
 		seq_puts(s, "\nBalancing F2FS Async:\n");
@@ -371,6 +374,8 @@ int f2fs_build_stats(struct f2fs_sb_info *sbi)
 
 	atomic_set(&sbi->total_hit_ext, 0);
 	atomic_set(&sbi->read_hit_ext, 0);
+	atomic_set(&sbi->read_hit_largest, 0);
+	atomic_set(&sbi->read_hit_cached, 0);
 
 	atomic_set(&sbi->inline_xattr, 0);
 	atomic_set(&sbi->inline_inode, 0);
diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index cea5813..5cf217f 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -81,8 +81,8 @@ static struct extent_tree *__grab_extent_tree(struct inode *inode)
 	return et;
 }
 
-static struct extent_node *__lookup_extent_tree(struct extent_tree *et,
-							unsigned int fofs)
+static struct extent_node *__lookup_extent_tree(struct f2fs_sb_info *sbi,
+				struct extent_tree *et, unsigned int fofs)
 {
 	struct rb_node *node = et->root.rb_node;
 	struct extent_node *en = et->cached_en;
@@ -90,8 +90,10 @@ static struct extent_node *__lookup_extent_tree(struct extent_tree *et,
 	if (en) {
 		struct extent_info *cei = &en->ei;
 
-		if (cei->fofs <= fofs && cei->fofs + cei->len > fofs)
+		if (cei->fofs <= fofs && cei->fofs + cei->len > fofs) {
+			stat_inc_cached_node_hit(sbi);
 			return en;
+		}
 	}
 
 	while (node) {
@@ -280,10 +282,11 @@ static bool f2fs_lookup_extent_tree(struct inode *inode, pgoff_t pgofs,
 		*ei = et->largest;
 		ret = true;
 		stat_inc_read_hit(sbi);
+		stat_inc_largest_node_hit(sbi);
 		goto out;
 	}
 
-	en = __lookup_extent_tree(et, pgofs);
+	en = __lookup_extent_tree(sbi, et, pgofs);
 	if (en) {
 		*ei = en->ei;
 		spin_lock(&sbi->extent_lock);
@@ -313,7 +316,8 @@ out:
  * tree must stay unchanged between lookup and insertion.
  */
 static struct extent_node *__lookup_extent_tree_ret(struct extent_tree *et,
-				unsigned int fofs, struct extent_node **prev_ex,
+				unsigned int fofs,
+				struct extent_node **prev_ex,
 				struct extent_node **next_ex,
 				struct rb_node ***insert_p,
 				struct rb_node **insert_parent)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 7a62f6c..632cc37 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -794,6 +794,8 @@ struct f2fs_sb_info {
 	atomic_t inplace_count;		/* # of inplace update */
 	atomic_t total_hit_ext;			/* # of lookup extent cache */
 	atomic_t read_hit_ext;			/* # of hit extent cache */
+	atomic_t read_hit_largest;		/* # of hit largest extent node */
+	atomic_t read_hit_cached;		/* # of hit cached extent node */
 	atomic_t inline_xattr;			/* # of inline_xattr inodes */
 	atomic_t inline_inode;			/* # of inline_data inodes */
 	atomic_t inline_dir;			/* # of inline_dentry inodes */
@@ -1839,7 +1841,7 @@ struct f2fs_stat_info {
 	struct f2fs_sb_info *sbi;
 	int all_area_segs, sit_area_segs, nat_area_segs, ssa_area_segs;
 	int main_area_segs, main_area_sections, main_area_zones;
-	int hit_ext, total_ext, ext_tree, ext_node;
+	int hit_largest, hit_cached, hit_ext, total_ext, ext_tree, ext_node;
 	int ndirty_node, ndirty_dent, ndirty_dirs, ndirty_meta;
 	int nats, dirty_nats, sits, dirty_sits, fnids;
 	int total_count, utilization;
@@ -1877,6 +1879,8 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 #define stat_dec_dirty_dir(sbi)		((sbi)->n_dirty_dirs--)
 #define stat_inc_total_hit(sbi)		(atomic_inc(&(sbi)->total_hit_ext))
 #define stat_inc_read_hit(sbi)		(atomic_inc(&(sbi)->read_hit_ext))
+#define stat_inc_largest_node_hit(sbi)	(atomic_inc(&(sbi)->read_hit_largest))
+#define stat_inc_cached_node_hit(sbi)	(atomic_inc(&(sbi)->read_hit_cached))
 #define stat_inc_inline_xattr(inode)					\
 	do {								\
 		if (f2fs_has_inline_xattr(inode))			\
@@ -1957,6 +1961,8 @@ void f2fs_destroy_root_stats(void);
 #define stat_dec_dirty_dir(sbi)
 #define stat_inc_total_hit(sb)
 #define stat_inc_read_hit(sb)
+#define stat_inc_largest_node_hit(sbi)
+#define stat_inc_cached_node_hit(sbi)
 #define stat_inc_inline_xattr(inode)
 #define stat_dec_inline_xattr(inode)
 #define stat_inc_inline_inode(inode)
-- 
2.4.2
