From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH v2 5/7] f2fs: stat dirty regular/symlink inodes
Date: Wed, 16 Dec 2015 13:23:44 +0800
Message-ID: <000001d137c2$05ff5e20$11fe1a60$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Add to stat dirty regular and symlink inode for showing in debugfs.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
v2:
 - rename F2FS_DIRTY_DATAS to F2FS_DIRTY_DATA
---
 fs/f2fs/checkpoint.c | 4 ++++
 fs/f2fs/debug.c      | 4 ++++
 fs/f2fs/f2fs.h       | 8 +++++++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index f33c4d7..b2af2c16 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -735,6 +735,8 @@ static void __add_dirty_inode(struct inode *inode, enum inode_type type)
 	list_add_tail(&fi->dirty_list, &sbi->inode_list[type]);
 	if (type == DIR_INODE)
 		stat_inc_dirty_dir(sbi);
+	else
+		stat_inc_dirty_file(sbi);
 }
 
 static void __remove_dirty_inode(struct inode *inode, enum inode_type type)
@@ -751,6 +753,8 @@ static void __remove_dirty_inode(struct inode *inode, enum inode_type type)
 	clear_inode_flag(fi, flag);
 	if (type == DIR_INODE)
 		stat_dec_dirty_dir(sbi);
+	else
+		stat_dec_dirty_file(sbi);
 }
 
 void update_dirty_page(struct inode *inode, struct page *page)
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index f4a7b9e..780d5ed1 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -42,7 +42,9 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->ext_node = atomic_read(&sbi->total_ext_node);
 	si->ndirty_node = get_pages(sbi, F2FS_DIRTY_NODES);
 	si->ndirty_dent = get_pages(sbi, F2FS_DIRTY_DENTS);
+	si->ndirty_data = get_pages(sbi, F2FS_DIRTY_DATA);
 	si->ndirty_dirs = sbi->n_dirty_dirs;
+	si->ndirty_files = sbi->n_dirty_files;
 	si->ndirty_meta = get_pages(sbi, F2FS_DIRTY_META);
 	si->inmem_pages = get_pages(sbi, F2FS_INMEM_PAGES);
 	si->wb_pages = get_pages(sbi, F2FS_WRITEBACK);
@@ -298,6 +300,8 @@ static int stat_show(struct seq_file *s, void *v)
 			   si->ndirty_node, si->node_pages);
 		seq_printf(s, "  - dents: %4d in dirs:%4d\n",
 			   si->ndirty_dent, si->ndirty_dirs);
+		seq_printf(s, "  - datas: %4d in files:%4d\n",
+			   si->ndirty_data, si->ndirty_files);
 		seq_printf(s, "  - meta: %4d in %4d\n",
 			   si->ndirty_meta, si->meta_pages);
 		seq_printf(s, "  - NATs: %9d/%9d\n  - SITs: %9d/%9d\n",
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c68c4a3..e73ddea 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -818,6 +818,7 @@ struct f2fs_sb_info {
 	atomic_t inline_dir;			/* # of inline_dentry inodes */
 	int bg_gc;				/* background gc calls */
 	unsigned int n_dirty_dirs;		/* # of dir inodes */
+	unsigned int n_dirty_files;		/* # of regular/symlink inodes */
 #endif
 	unsigned int last_victim[2];		/* last victim segment # */
 	spinlock_t stat_lock;			/* lock for stat operations */
@@ -1887,7 +1888,8 @@ struct f2fs_stat_info {
 	unsigned long long hit_largest, hit_cached, hit_rbtree;
 	unsigned long long hit_total, total_ext;
 	int ext_tree, ext_node;
-	int ndirty_node, ndirty_dent, ndirty_dirs, ndirty_meta;
+	int ndirty_node, ndirty_meta;
+	int ndirty_dent, ndirty_dirs, ndirty_data, ndirty_files;
 	int nats, dirty_nats, sits, dirty_sits, fnids;
 	int total_count, utilization;
 	int bg_gc, inmem_pages, wb_pages;
@@ -1922,6 +1924,8 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 #define stat_inc_bggc_count(sbi)	((sbi)->bg_gc++)
 #define stat_inc_dirty_dir(sbi)		((sbi)->n_dirty_dirs++)
 #define stat_dec_dirty_dir(sbi)		((sbi)->n_dirty_dirs--)
+#define stat_inc_dirty_file(sbi)	((sbi)->n_dirty_files++)
+#define stat_dec_dirty_file(sbi)	((sbi)->n_dirty_files--)
 #define stat_inc_total_hit(sbi)		(atomic64_inc(&(sbi)->total_hit_ext))
 #define stat_inc_rbtree_node_hit(sbi)	(atomic64_inc(&(sbi)->read_hit_rbtree))
 #define stat_inc_largest_node_hit(sbi)	(atomic64_inc(&(sbi)->read_hit_largest))
@@ -2004,6 +2008,8 @@ void f2fs_destroy_root_stats(void);
 #define stat_inc_bggc_count(si)
 #define stat_inc_dirty_dir(sbi)
 #define stat_dec_dirty_dir(sbi)
+#define stat_inc_dirty_file(sbi)
+#define stat_dec_dirty_file(sbi)
 #define stat_inc_total_hit(sb)
 #define stat_inc_rbtree_node_hit(sb)
 #define stat_inc_largest_node_hit(sbi)
-- 
2.6.3
