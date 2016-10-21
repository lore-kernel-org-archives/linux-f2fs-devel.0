From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/3] f2fs: remove percpu_count due to performance regression
Date: Thu, 20 Oct 2016 19:28:47 -0700
Message-ID: <20161021022847.55629-3-jaegeuk@kernel.org>
References: <20161021022847.55629-1-jaegeuk@kernel.org>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20161021022847.55629-1-jaegeuk@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch removes percpu_count usage due to performance regression in iozone.

Fixes: 523be8a6b3 ("f2fs: use percpu_counter for page counters")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/debug.c | 12 ++++++------
 fs/f2fs/f2fs.h  | 12 ++++++------
 fs/f2fs/super.c | 16 +++++-----------
 3 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 6af146c..2fdf233 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -313,17 +313,17 @@ static int stat_show(struct seq_file *s, void *v)
 		seq_printf(s, "  - Inner Struct Count: tree: %d(%d), node: %d\n",
 				si->ext_tree, si->zombie_tree, si->ext_node);
 		seq_puts(s, "\nBalancing F2FS Async:\n");
-		seq_printf(s, "  - inmem: %4lld, wb_bios: %4d\n",
+		seq_printf(s, "  - inmem: %4d, wb_bios: %4d\n",
 			   si->inmem_pages, si->wb_bios);
-		seq_printf(s, "  - nodes: %4lld in %4d\n",
+		seq_printf(s, "  - nodes: %4d in %4d\n",
 			   si->ndirty_node, si->node_pages);
-		seq_printf(s, "  - dents: %4lld in dirs:%4d (%4d)\n",
+		seq_printf(s, "  - dents: %4d in dirs:%4d (%4d)\n",
 			   si->ndirty_dent, si->ndirty_dirs, si->ndirty_all);
-		seq_printf(s, "  - datas: %4lld in files:%4d\n",
+		seq_printf(s, "  - datas: %4d in files:%4d\n",
 			   si->ndirty_data, si->ndirty_files);
-		seq_printf(s, "  - meta: %4lld in %4d\n",
+		seq_printf(s, "  - meta: %4d in %4d\n",
 			   si->ndirty_meta, si->meta_pages);
-		seq_printf(s, "  - imeta: %4lld\n",
+		seq_printf(s, "  - imeta: %4d\n",
 			   si->ndirty_imeta);
 		seq_printf(s, "  - NATs: %9d/%9d\n  - SITs: %9d/%9d\n",
 			   si->dirty_nats, si->nats, si->dirty_sits, si->sits);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b66a04c..27b78d4 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -824,7 +824,7 @@ struct f2fs_sb_info {
 	atomic_t nr_wb_bios;			/* # of writeback bios */
 
 	/* # of pages, see count_type */
-	struct percpu_counter nr_pages[NR_COUNT_TYPE];
+	atomic_t nr_pages[NR_COUNT_TYPE];
 	/* # of allocated blocks */
 	struct percpu_counter alloc_valid_block_count;
 
@@ -1238,7 +1238,7 @@ static inline void dec_valid_block_count(struct f2fs_sb_info *sbi,
 
 static inline void inc_page_count(struct f2fs_sb_info *sbi, int count_type)
 {
-	percpu_counter_inc(&sbi->nr_pages[count_type]);
+	atomic_inc(&sbi->nr_pages[count_type]);
 
 	if (count_type == F2FS_DIRTY_DATA || count_type == F2FS_INMEM_PAGES)
 		return;
@@ -1255,7 +1255,7 @@ static inline void inode_inc_dirty_pages(struct inode *inode)
 
 static inline void dec_page_count(struct f2fs_sb_info *sbi, int count_type)
 {
-	percpu_counter_dec(&sbi->nr_pages[count_type]);
+	atomic_dec(&sbi->nr_pages[count_type]);
 }
 
 static inline void inode_dec_dirty_pages(struct inode *inode)
@@ -1271,7 +1271,7 @@ static inline void inode_dec_dirty_pages(struct inode *inode)
 
 static inline s64 get_pages(struct f2fs_sb_info *sbi, int count_type)
 {
-	return percpu_counter_sum_positive(&sbi->nr_pages[count_type]);
+	return atomic_read(&sbi->nr_pages[count_type]);
 }
 
 static inline s64 get_dirty_pages(struct inode *inode)
@@ -2239,8 +2239,8 @@ struct f2fs_stat_info {
 	unsigned long long hit_largest, hit_cached, hit_rbtree;
 	unsigned long long hit_total, total_ext;
 	int ext_tree, zombie_tree, ext_node;
-	s64 ndirty_node, ndirty_dent, ndirty_meta, ndirty_data, ndirty_imeta;
-	s64 inmem_pages;
+	int ndirty_node, ndirty_dent, ndirty_meta, ndirty_data, ndirty_imeta;
+	int inmem_pages;
 	unsigned int ndirty_dirs, ndirty_files, ndirty_all;
 	int nats, dirty_nats, sits, dirty_sits, free_nids, alloc_nids;
 	int total_count, utilization;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f8e2f31..9749758 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -696,10 +696,6 @@ static void f2fs_destroy_inode(struct inode *inode)
 
 static void destroy_percpu_info(struct f2fs_sb_info *sbi)
 {
-	int i;
-
-	for (i = 0; i < NR_COUNT_TYPE; i++)
-		percpu_counter_destroy(&sbi->nr_pages[i]);
 	percpu_counter_destroy(&sbi->alloc_valid_block_count);
 	percpu_counter_destroy(&sbi->total_valid_inode_count);
 }
@@ -1449,6 +1445,7 @@ int sanity_check_ckpt(struct f2fs_sb_info *sbi)
 static void init_sb_info(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_super_block *raw_super = sbi->raw_super;
+	int i;
 
 	sbi->log_sectors_per_block =
 		le32_to_cpu(raw_super->log_sectors_per_block);
@@ -1473,6 +1470,9 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 	sbi->interval_time[REQ_TIME] = DEF_IDLE_INTERVAL;
 	clear_sbi_flag(sbi, SBI_NEED_FSCK);
 
+	for (i = 0; i < NR_COUNT_TYPE; i++)
+		atomic_set(&sbi->nr_pages[i], 0);
+
 	INIT_LIST_HEAD(&sbi->s_list);
 	mutex_init(&sbi->umount_mutex);
 	mutex_init(&sbi->wio_mutex[NODE]);
@@ -1488,13 +1488,7 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 
 static int init_percpu_info(struct f2fs_sb_info *sbi)
 {
-	int i, err;
-
-	for (i = 0; i < NR_COUNT_TYPE; i++) {
-		err = percpu_counter_init(&sbi->nr_pages[i], 0, GFP_KERNEL);
-		if (err)
-			return err;
-	}
+	int err;
 
 	err = percpu_counter_init(&sbi->alloc_valid_block_count, 0, GFP_KERNEL);
 	if (err)
-- 
2.8.3

