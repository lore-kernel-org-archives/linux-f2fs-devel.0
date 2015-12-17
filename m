From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH v3 5/7] f2fs: stat dirty regular/symlink inodes
Date: Thu, 17 Dec 2015 17:14:44 +0800
Message-ID: <006d01d138ab$75fb6db0$61f24910$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1a9Uep-0003PN-9o
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Dec 2015 09:15:31 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1a9Uen-0007wH-Fy
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Dec 2015 09:15:31 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NZH01Z6KWDI7LD0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Dec 2015 18:15:22 +0900 (KST)
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

Add to stat dirty regular and symlink inode for showing in debugfs.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 v2:
 - rename F2FS_DIRTY_DATAS to F2FS_DIRTY_DATA
 v3:
 - fix compiler warning
---
 fs/f2fs/checkpoint.c |  7 ++-----
 fs/f2fs/debug.c      |  6 +++++-
 fs/f2fs/f2fs.h       | 13 +++++++------
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index a037bbd..53044ea 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -733,13 +733,11 @@ static void __add_dirty_inode(struct inode *inode, enum inode_type type)
 
 	set_inode_flag(fi, flag);
 	list_add_tail(&fi->dirty_list, &sbi->inode_list[type]);
-	if (type == DIR_INODE)
-		stat_inc_dirty_dir(sbi);
+	stat_inc_dirty_inode(sbi, type);
 }
 
 static void __remove_dirty_inode(struct inode *inode, enum inode_type type)
 {
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	int flag = (type == DIR_INODE) ? FI_DIRTY_DIR : FI_DIRTY_FILE;
 
@@ -749,8 +747,7 @@ static void __remove_dirty_inode(struct inode *inode, enum inode_type type)
 
 	list_del_init(&fi->dirty_list);
 	clear_inode_flag(fi, flag);
-	if (type == DIR_INODE)
-		stat_dec_dirty_dir(sbi);
+	stat_dec_dirty_inode(F2FS_I_SB(inode), type);
 }
 
 void update_dirty_page(struct inode *inode, struct page *page)
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index f4a7b9e..bb307e6 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -42,8 +42,10 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->ext_node = atomic_read(&sbi->total_ext_node);
 	si->ndirty_node = get_pages(sbi, F2FS_DIRTY_NODES);
 	si->ndirty_dent = get_pages(sbi, F2FS_DIRTY_DENTS);
-	si->ndirty_dirs = sbi->n_dirty_dirs;
 	si->ndirty_meta = get_pages(sbi, F2FS_DIRTY_META);
+	si->ndirty_data = get_pages(sbi, F2FS_DIRTY_DATA);
+	si->ndirty_dirs = sbi->ndirty_inode[DIR_INODE];
+	si->ndirty_files = sbi->ndirty_inode[FILE_INODE];
 	si->inmem_pages = get_pages(sbi, F2FS_INMEM_PAGES);
 	si->wb_pages = get_pages(sbi, F2FS_WRITEBACK);
 	si->total_count = (int)sbi->user_block_count / sbi->blocks_per_seg;
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
index b1fb8f7..19beabe 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -818,7 +818,7 @@ struct f2fs_sb_info {
 	atomic_t inline_inode;			/* # of inline_data inodes */
 	atomic_t inline_dir;			/* # of inline_dentry inodes */
 	int bg_gc;				/* background gc calls */
-	unsigned int n_dirty_dirs;		/* # of dir inodes */
+	unsigned int ndirty_inode[NR_INODE_TYPE];	/* # of dirty inodes */
 #endif
 	unsigned int last_victim[2];		/* last victim segment # */
 	spinlock_t stat_lock;			/* lock for stat operations */
@@ -1888,7 +1888,8 @@ struct f2fs_stat_info {
 	unsigned long long hit_largest, hit_cached, hit_rbtree;
 	unsigned long long hit_total, total_ext;
 	int ext_tree, ext_node;
-	int ndirty_node, ndirty_dent, ndirty_dirs, ndirty_meta;
+	int ndirty_node, ndirty_meta;
+	int ndirty_dent, ndirty_dirs, ndirty_data, ndirty_files;
 	int nats, dirty_nats, sits, dirty_sits, fnids;
 	int total_count, utilization;
 	int bg_gc, inmem_pages, wb_pages;
@@ -1921,8 +1922,8 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 #define stat_inc_cp_count(si)		((si)->cp_count++)
 #define stat_inc_call_count(si)		((si)->call_count++)
 #define stat_inc_bggc_count(sbi)	((sbi)->bg_gc++)
-#define stat_inc_dirty_dir(sbi)		((sbi)->n_dirty_dirs++)
-#define stat_dec_dirty_dir(sbi)		((sbi)->n_dirty_dirs--)
+#define stat_inc_dirty_inode(sbi, type)	((sbi)->ndirty_inode[type]++)
+#define stat_dec_dirty_inode(sbi, type)	((sbi)->ndirty_inode[type]--)
 #define stat_inc_total_hit(sbi)		(atomic64_inc(&(sbi)->total_hit_ext))
 #define stat_inc_rbtree_node_hit(sbi)	(atomic64_inc(&(sbi)->read_hit_rbtree))
 #define stat_inc_largest_node_hit(sbi)	(atomic64_inc(&(sbi)->read_hit_largest))
@@ -2003,8 +2004,8 @@ void f2fs_destroy_root_stats(void);
 #define stat_inc_cp_count(si)
 #define stat_inc_call_count(si)
 #define stat_inc_bggc_count(si)
-#define stat_inc_dirty_dir(sbi)
-#define stat_dec_dirty_dir(sbi)
+#define stat_inc_dirty_inode(sbi, type)
+#define stat_dec_dirty_inode(sbi, type)
 #define stat_inc_total_hit(sb)
 #define stat_inc_rbtree_node_hit(sb)
 #define stat_inc_largest_node_hit(sbi)
-- 
2.6.3



------------------------------------------------------------------------------
