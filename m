From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 6/8] f2fs: stat dirty regular/symlink inodes
Date: Tue, 15 Dec 2015 13:34:32 +0800
Message-ID: <00f901d136fa$5de94e70$19bbeb50$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1a8iGd-0003u2-SN
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Dec 2015 05:35:19 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1a8iGc-0007S4-NI
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Dec 2015 05:35:19 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NZD029AAWUK2WC0@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Dec 2015 14:35:11 +0900 (KST)
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
 fs/f2fs/checkpoint.c | 4 ++++
 fs/f2fs/debug.c      | 4 ++++
 fs/f2fs/f2fs.h       | 8 +++++++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 217571f..a73909c 100644
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
index f4a7b9e..80a40dd 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -42,7 +42,9 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->ext_node = atomic_read(&sbi->total_ext_node);
 	si->ndirty_node = get_pages(sbi, F2FS_DIRTY_NODES);
 	si->ndirty_dent = get_pages(sbi, F2FS_DIRTY_DENTS);
+	si->ndirty_data = get_pages(sbi, F2FS_DIRTY_DATAS);
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
index 2477b2f5..4d44732 100644
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
@@ -1892,7 +1893,8 @@ struct f2fs_stat_info {
 	unsigned long long hit_largest, hit_cached, hit_rbtree;
 	unsigned long long hit_total, total_ext;
 	int ext_tree, ext_node;
-	int ndirty_node, ndirty_dent, ndirty_dirs, ndirty_meta;
+	int ndirty_node, ndirty_meta;
+	int ndirty_dent, ndirty_dirs, ndirty_data, ndirty_files;
 	int nats, dirty_nats, sits, dirty_sits, fnids;
 	int total_count, utilization;
 	int bg_gc, inmem_pages, wb_pages;
@@ -1927,6 +1929,8 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 #define stat_inc_bggc_count(sbi)	((sbi)->bg_gc++)
 #define stat_inc_dirty_dir(sbi)		((sbi)->n_dirty_dirs++)
 #define stat_dec_dirty_dir(sbi)		((sbi)->n_dirty_dirs--)
+#define stat_inc_dirty_file(sbi)	((sbi)->n_dirty_files++)
+#define stat_dec_dirty_file(sbi)	((sbi)->n_dirty_files--)
 #define stat_inc_total_hit(sbi)		(atomic64_inc(&(sbi)->total_hit_ext))
 #define stat_inc_rbtree_node_hit(sbi)	(atomic64_inc(&(sbi)->read_hit_rbtree))
 #define stat_inc_largest_node_hit(sbi)	(atomic64_inc(&(sbi)->read_hit_largest))
@@ -2009,6 +2013,8 @@ void f2fs_destroy_root_stats(void);
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



------------------------------------------------------------------------------
