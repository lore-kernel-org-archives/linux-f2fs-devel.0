From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: show the max number of volatile
	operations
Date: Wed, 22 Mar 2017 17:23:45 +0800
Message-ID: <20170322092346.115258-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cqcV6-0002FH-Mg
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 Mar 2017 09:24:16 +0000
Received: from [45.249.212.188] (helo=dggrg02-dlp.huawei.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cqcV4-0002Jp-VW
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 Mar 2017 09:24:16 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch adds to show the max number of volatile operations which are
conducting concurrently.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/debug.c | 10 ++++++++--
 fs/f2fs/f2fs.h  | 18 +++++++++++++++++-
 fs/f2fs/file.c  |  5 +++++
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index ef1179df05d9..0baa3ee39392 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -51,7 +51,9 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->ndirty_all = sbi->ndirty_inode[DIRTY_META];
 	si->inmem_pages = get_pages(sbi, F2FS_INMEM_PAGES);
 	si->aw_cnt = atomic_read(&sbi->aw_cnt);
+	si->vw_cnt = atomic_read(&sbi->vw_cnt);
 	si->max_aw_cnt = atomic_read(&sbi->max_aw_cnt);
+	si->max_vw_cnt = atomic_read(&sbi->max_vw_cnt);
 	si->nr_wb_cp_data = get_pages(sbi, F2FS_WB_CP_DATA);
 	si->nr_wb_data = get_pages(sbi, F2FS_WB_DATA);
 	if (SM_I(sbi) && SM_I(sbi)->fcc_info)
@@ -337,8 +339,10 @@ static int stat_show(struct seq_file *s, void *v)
 		seq_printf(s, "  - IO (CP: %4d, Data: %4d, Flush: %4d, Discard: %4d)\n",
 			   si->nr_wb_cp_data, si->nr_wb_data,
 			   si->nr_flush, si->nr_discard);
-		seq_printf(s, "  - inmem: %4d, atomic IO: %4d (Max. %4d)\n",
-			   si->inmem_pages, si->aw_cnt, si->max_aw_cnt);
+		seq_printf(s, "  - inmem: %4d, atomic IO: %4d (Max. %4d), "
+			"volatile IO: %4d (Max. %4d)\n",
+			   si->inmem_pages, si->aw_cnt, si->max_aw_cnt,
+			   si->vw_cnt, si->max_vw_cnt);
 		seq_printf(s, "  - nodes: %4d in %4d\n",
 			   si->ndirty_node, si->node_pages);
 		seq_printf(s, "  - dents: %4d in dirs:%4d (%4d)\n",
@@ -438,7 +442,9 @@ int f2fs_build_stats(struct f2fs_sb_info *sbi)
 	atomic_set(&sbi->inplace_count, 0);
 
 	atomic_set(&sbi->aw_cnt, 0);
+	atomic_set(&sbi->vw_cnt, 0);
 	atomic_set(&sbi->max_aw_cnt, 0);
+	atomic_set(&sbi->max_vw_cnt, 0);
 
 	mutex_lock(&f2fs_stat_mutex);
 	list_add_tail(&si->stat_list, &f2fs_stat_list);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 82ddf5649d68..9ea230f7a0c3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -921,7 +921,9 @@ struct f2fs_sb_info {
 	atomic_t inline_inode;			/* # of inline_data inodes */
 	atomic_t inline_dir;			/* # of inline_dentry inodes */
 	atomic_t aw_cnt;			/* # of atomic writes */
+	atomic_t vw_cnt;			/* # of volatile writes */
 	atomic_t max_aw_cnt;			/* max # of atomic writes */
+	atomic_t max_vw_cnt;			/* max # of volatile writes */
 	int bg_gc;				/* background gc calls */
 	unsigned int ndirty_inode[NR_INODE_TYPE];	/* # of dirty inodes */
 #endif
@@ -2334,7 +2336,7 @@ struct f2fs_stat_info {
 	int total_count, utilization;
 	int bg_gc, nr_wb_cp_data, nr_wb_data, nr_flush, nr_discard;
 	int inline_xattr, inline_inode, inline_dir, append, update, orphans;
-	int aw_cnt, max_aw_cnt;
+	int aw_cnt, max_aw_cnt, vw_cnt, max_vw_cnt;
 	unsigned int valid_count, valid_node_count, valid_inode_count, discard_blks;
 	unsigned int bimodal, avg_vblocks;
 	int util_free, util_valid, util_invalid;
@@ -2417,6 +2419,17 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 		if (cur > max)						\
 			atomic_set(&F2FS_I_SB(inode)->max_aw_cnt, cur);	\
 	} while (0)
+#define stat_inc_volatile_write(inode)					\
+		(atomic_inc(&F2FS_I_SB(inode)->vw_cnt))
+#define stat_dec_volatile_write(inode)					\
+		(atomic_dec(&F2FS_I_SB(inode)->vw_cnt))
+#define stat_update_max_volatile_write(inode)				\
+	do {								\
+		int cur = atomic_read(&F2FS_I_SB(inode)->vw_cnt);	\
+		int max = atomic_read(&F2FS_I_SB(inode)->max_vw_cnt);	\
+		if (cur > max)						\
+			atomic_set(&F2FS_I_SB(inode)->max_vw_cnt, cur);	\
+	} while (0)
 #define stat_inc_seg_count(sbi, type, gc_type)				\
 	do {								\
 		struct f2fs_stat_info *si = F2FS_STAT(sbi);		\
@@ -2473,6 +2486,9 @@ void f2fs_destroy_root_stats(void);
 #define stat_inc_atomic_write(inode)
 #define stat_dec_atomic_write(inode)
 #define stat_update_max_atomic_write(inode)
+#define stat_inc_volatile_write(inode)
+#define stat_dec_volatile_write(inode)
+#define stat_update_max_volatile_write(inode)
 #define stat_inc_seg_type(sbi, curseg)
 #define stat_inc_block_count(sbi, curseg)
 #define stat_inc_inplace_blocks(sbi)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 1b310c1c417b..113e0c03d66d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1427,6 +1427,7 @@ static int f2fs_release_file(struct inode *inode, struct file *filp)
 		drop_inmem_pages(inode);
 	if (f2fs_is_volatile_file(inode)) {
 		clear_inode_flag(inode, FI_VOLATILE_FILE);
+		stat_dec_volatile_write(inode);
 		set_inode_flag(inode, FI_DROP_CACHE);
 		filemap_fdatawrite(inode->i_mapping);
 		clear_inode_flag(inode, FI_DROP_CACHE);
@@ -1614,6 +1615,9 @@ static int f2fs_ioc_start_volatile_write(struct file *filp)
 	if (ret)
 		goto out;
 
+	stat_inc_volatile_write(inode);
+	stat_update_max_volatile_write(inode);
+
 	set_inode_flag(inode, FI_VOLATILE_FILE);
 	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 out:
@@ -1669,6 +1673,7 @@ static int f2fs_ioc_abort_volatile_write(struct file *filp)
 		drop_inmem_pages(inode);
 	if (f2fs_is_volatile_file(inode)) {
 		clear_inode_flag(inode, FI_VOLATILE_FILE);
+		stat_dec_volatile_write(inode);
 		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
 	}
 
-- 
2.8.2.295.g3f1c1d0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
