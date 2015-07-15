From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/2] f2fs: stat inline xattr inode number
Date: Wed, 15 Jul 2015 17:28:53 +0800
Message-ID: <012b01d0bee0$c31920a0$494b61e0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch adds to stat the number of inline xattr inode for
showing in debugfs.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/debug.c |  4 ++++
 fs/f2fs/f2fs.h  | 16 +++++++++++++++-
 fs/f2fs/inode.c |  2 ++
 fs/f2fs/namei.c |  1 +
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 75176e0..2aeaf4e 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -49,6 +49,7 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->valid_count = valid_user_blocks(sbi);
 	si->valid_node_count = valid_node_count(sbi);
 	si->valid_inode_count = valid_inode_count(sbi);
+	si->inline_xattr = atomic_read(&sbi->inline_xattr);
 	si->inline_inode = atomic_read(&sbi->inline_inode);
 	si->inline_dir = atomic_read(&sbi->inline_dir);
 	si->utilization = utilization(sbi);
@@ -226,6 +227,8 @@ static int stat_show(struct seq_file *s, void *v)
 		seq_printf(s, "Other: %u)\n  - Data: %u\n",
 			   si->valid_node_count - si->valid_inode_count,
 			   si->valid_count - si->valid_node_count);
+		seq_printf(s, "  - Inline_xattr Inode: %u\n",
+			   si->inline_xattr);
 		seq_printf(s, "  - Inline_data Inode: %u\n",
 			   si->inline_inode);
 		seq_printf(s, "  - Inline_dentry Inode: %u\n",
@@ -366,6 +369,7 @@ int f2fs_build_stats(struct f2fs_sb_info *sbi)
 	si->sbi = sbi;
 	sbi->stat_info = si;
 
+	atomic_set(&sbi->inline_xattr, 0);
 	atomic_set(&sbi->inline_inode, 0);
 	atomic_set(&sbi->inline_dir, 0);
 	atomic_set(&sbi->inplace_count, 0);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 673623b..b18b852 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -782,6 +782,7 @@ struct f2fs_sb_info {
 	unsigned int block_count[2];		/* # of allocated blocks */
 	atomic_t inplace_count;		/* # of inplace update */
 	int total_hit_ext, read_hit_ext;	/* extent cache hit ratio */
+	atomic_t inline_xattr;			/* # of inline_xattr inodes */
 	atomic_t inline_inode;			/* # of inline_data inodes */
 	atomic_t inline_dir;			/* # of inline_dentry inodes */
 	int bg_gc;				/* background gc calls */
@@ -1804,7 +1805,8 @@ struct f2fs_stat_info {
 	int ndirty_node, ndirty_dent, ndirty_dirs, ndirty_meta;
 	int nats, dirty_nats, sits, dirty_sits, fnids;
 	int total_count, utilization;
-	int bg_gc, inline_inode, inline_dir, inmem_pages, wb_pages;
+	int bg_gc, inmem_pages, wb_pages;
+	int inline_xattr, inline_inode, inline_dir;
 	unsigned int valid_count, valid_node_count, valid_inode_count;
 	unsigned int bimodal, avg_vblocks;
 	int util_free, util_valid, util_invalid;
@@ -1837,6 +1839,16 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 #define stat_dec_dirty_dir(sbi)		((sbi)->n_dirty_dirs--)
 #define stat_inc_total_hit(sb)		((F2FS_SB(sb))->total_hit_ext++)
 #define stat_inc_read_hit(sb)		((F2FS_SB(sb))->read_hit_ext++)
+#define stat_inc_inline_xattr(inode)					\
+	do {								\
+		if (f2fs_has_inline_xattr(inode))			\
+			(atomic_inc(&F2FS_I_SB(inode)->inline_xattr));	\
+	} while (0)
+#define stat_dec_inline_xattr(inode)					\
+	do {								\
+		if (f2fs_has_inline_xattr(inode))			\
+			(atomic_dec(&F2FS_I_SB(inode)->inline_xattr));	\
+	} while (0)
 #define stat_inc_inline_inode(inode)					\
 	do {								\
 		if (f2fs_has_inline_data(inode))			\
@@ -1907,6 +1919,8 @@ void f2fs_destroy_root_stats(void);
 #define stat_dec_dirty_dir(sbi)
 #define stat_inc_total_hit(sb)
 #define stat_inc_read_hit(sb)
+#define stat_inc_inline_xattr(inode)
+#define stat_dec_inline_xattr(inode)
 #define stat_inc_inline_inode(inode)
 #define stat_dec_inline_inode(inode)
 #define stat_inc_inline_dir(inode)
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 978a726..5b7547f 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -155,6 +155,7 @@ static int do_read_inode(struct inode *inode)
 
 	f2fs_put_page(node_page, 1);
 
+	stat_inc_inline_xattr(inode);
 	stat_inc_inline_inode(inode);
 	stat_inc_inline_dir(inode);
 
@@ -350,6 +351,7 @@ void f2fs_evict_inode(struct inode *inode)
 
 	sb_end_intwrite(inode->i_sb);
 no_delete:
+	stat_dec_inline_xattr(inode);
 	stat_dec_inline_dir(inode);
 	stat_dec_inline_inode(inode);
 
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 1856d5e..97e97c4 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -67,6 +67,7 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 
 	f2fs_init_extent_tree(inode, NULL);
 
+	stat_inc_inline_xattr(inode);
 	stat_inc_inline_inode(inode);
 	stat_inc_inline_dir(inode);
 
-- 
2.4.2
