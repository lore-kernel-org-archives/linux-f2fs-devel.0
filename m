From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 06/10] f2fs: show the max number of atomic
	operations
Date: Fri, 30 Dec 2016 10:51:13 -0800
Message-ID: <20161230185117.3832-6-jaegeuk@kernel.org>
References: <20161230185117.3832-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cN2H9-0006CL-Rd
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 30 Dec 2016 18:51:35 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cN2H8-0006es-07
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 30 Dec 2016 18:51:35 +0000
In-Reply-To: <20161230185117.3832-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch adds to show the max number of atomic operations which are
conducting concurrently.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/debug.c |  7 +++++++
 fs/f2fs/f2fs.h  | 17 +++++++++++++++++
 fs/f2fs/file.c  | 12 +++++++++---
 3 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index fbd5184140d0..29cdf0c1da1d 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -50,6 +50,8 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->ndirty_files = sbi->ndirty_inode[FILE_INODE];
 	si->ndirty_all = sbi->ndirty_inode[DIRTY_META];
 	si->inmem_pages = get_pages(sbi, F2FS_INMEM_PAGES);
+	si->aw_cnt = atomic_read(&sbi->aw_cnt);
+	si->max_aw_cnt = atomic_read(&sbi->max_aw_cnt);
 	si->nr_wb_cp_data = get_pages(sbi, F2FS_WB_CP_DATA);
 	si->nr_wb_data = get_pages(sbi, F2FS_WB_DATA);
 	si->total_count = (int)sbi->user_block_count / sbi->blocks_per_seg;
@@ -256,6 +258,8 @@ static int stat_show(struct seq_file *s, void *v)
 			   si->inline_dir);
 		seq_printf(s, "  - Orphan Inode: %u\n",
 			   si->orphans);
+		seq_printf(s, "  - Atomic write count: %4d (Max. %4d)\n",
+			   si->aw_cnt, si->max_aw_cnt);
 		seq_printf(s, "\nMain area: %d segs, %d secs %d zones\n",
 			   si->main_area_segs, si->main_area_sections,
 			   si->main_area_zones);
@@ -414,6 +418,9 @@ int f2fs_build_stats(struct f2fs_sb_info *sbi)
 	atomic_set(&sbi->inline_dir, 0);
 	atomic_set(&sbi->inplace_count, 0);
 
+	atomic_set(&sbi->aw_cnt, 0);
+	atomic_set(&sbi->max_aw_cnt, 0);
+
 	mutex_lock(&f2fs_stat_mutex);
 	list_add_tail(&si->stat_list, &f2fs_stat_list);
 	mutex_unlock(&f2fs_stat_mutex);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 0d7eaddef4a0..bdcfe2a9b532 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -884,6 +884,8 @@ struct f2fs_sb_info {
 	atomic_t inline_xattr;			/* # of inline_xattr inodes */
 	atomic_t inline_inode;			/* # of inline_data inodes */
 	atomic_t inline_dir;			/* # of inline_dentry inodes */
+	atomic_t aw_cnt;			/* # of atomic writes */
+	atomic_t max_aw_cnt;			/* max # of atomic writes */
 	int bg_gc;				/* background gc calls */
 	unsigned int ndirty_inode[NR_INODE_TYPE];	/* # of dirty inodes */
 #endif
@@ -2236,6 +2238,7 @@ struct f2fs_stat_info {
 	int total_count, utilization;
 	int bg_gc, nr_wb_cp_data, nr_wb_data;
 	int inline_xattr, inline_inode, inline_dir, orphans;
+	int aw_cnt, max_aw_cnt;
 	unsigned int valid_count, valid_node_count, valid_inode_count, discard_blks;
 	unsigned int bimodal, avg_vblocks;
 	int util_free, util_valid, util_invalid;
@@ -2307,6 +2310,17 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 		((sbi)->block_count[(curseg)->alloc_type]++)
 #define stat_inc_inplace_blocks(sbi)					\
 		(atomic_inc(&(sbi)->inplace_count))
+#define stat_inc_atomic_write(inode)					\
+		(atomic_inc(&F2FS_I_SB(inode)->aw_cnt));
+#define stat_dec_atomic_write(inode)					\
+		(atomic_dec(&F2FS_I_SB(inode)->aw_cnt));
+#define stat_update_max_atomic_write(inode)				\
+	do {								\
+		int cur = atomic_read(&F2FS_I_SB(inode)->aw_cnt);	\
+		int max = atomic_read(&F2FS_I_SB(inode)->max_aw_cnt);	\
+		if (cur > max)						\
+			atomic_set(&F2FS_I_SB(inode)->max_aw_cnt, cur);	\
+	} while (0)
 #define stat_inc_seg_count(sbi, type, gc_type)				\
 	do {								\
 		struct f2fs_stat_info *si = F2FS_STAT(sbi);		\
@@ -2360,6 +2374,9 @@ void f2fs_destroy_root_stats(void);
 #define stat_dec_inline_inode(inode)
 #define stat_inc_inline_dir(inode)
 #define stat_dec_inline_dir(inode)
+#define stat_inc_atomic_write(inode)
+#define stat_dec_atomic_write(inode)
+#define stat_update_max_atomic_write(inode)
 #define stat_inc_seg_type(sbi, curseg)
 #define stat_inc_block_count(sbi, curseg)
 #define stat_inc_inplace_blocks(sbi)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 49f10dce817d..826fefc05fb1 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1542,6 +1542,8 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 	if (ret)
 		clear_inode_flag(inode, FI_ATOMIC_FILE);
 out:
+	stat_inc_atomic_write(inode);
+	stat_update_max_atomic_write(inode);
 	inode_unlock(inode);
 	mnt_drop_write_file(filp);
 	return ret;
@@ -1571,9 +1573,11 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 			set_inode_flag(inode, FI_ATOMIC_FILE);
 			goto err_out;
 		}
+		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
+		stat_dec_atomic_write(inode);
+	} else {
+		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
 	}
-
-	ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
 err_out:
 	inode_unlock(inode);
 	mnt_drop_write_file(filp);
@@ -1652,8 +1656,10 @@ static int f2fs_ioc_abort_volatile_write(struct file *filp)
 
 	inode_lock(inode);
 
-	if (f2fs_is_atomic_file(inode))
+	if (f2fs_is_atomic_file(inode)) {
 		drop_inmem_pages(inode);
+		stat_dec_atomic_write(inode);
+	}
 	if (f2fs_is_volatile_file(inode)) {
 		clear_inode_flag(inode, FI_VOLATILE_FILE);
 		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
