From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: add to account meta IO
Date: Sat, 29 Sep 2018 18:31:27 +0800
Message-ID: <20180929103128.31307-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch supports to account meta IO, it enables to show write IO
from f2fs more comprehensively via 'status' debugfs entry.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/debug.c   | 13 +++++++++++++
 fs/f2fs/f2fs.h    | 15 +++++++++++++++
 fs/f2fs/segment.c |  1 +
 3 files changed, 29 insertions(+)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index d3c402183e3c..da1cabbc4973 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -118,6 +118,9 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 		si->curzone[i] = GET_ZONE_FROM_SEC(sbi, si->cursec[i]);
 	}
 
+	for (i = META_CP; i < META_MAX; i++)
+		si->meta_count[i] = atomic_read(&sbi->meta_count[i]);
+
 	for (i = 0; i < 2; i++) {
 		si->segment_count[i] = sbi->segment_count[i];
 		si->block_count[i] = sbi->block_count[i];
@@ -329,6 +332,13 @@ static int stat_show(struct seq_file *s, void *v)
 			   si->prefree_count, si->free_segs, si->free_secs);
 		seq_printf(s, "CP calls: %d (BG: %d)\n",
 				si->cp_count, si->bg_cp_count);
+		seq_printf(s, "  - cp blocks : %u\n", si->meta_count[META_CP]);
+		seq_printf(s, "  - sit blocks : %u\n",
+				si->meta_count[META_SIT]);
+		seq_printf(s, "  - nat blocks : %u\n",
+				si->meta_count[META_NAT]);
+		seq_printf(s, "  - ssa blocks : %u\n",
+				si->meta_count[META_SSA]);
 		seq_printf(s, "GC calls: %d (BG: %d)\n",
 			   si->call_count, si->bg_gc);
 		seq_printf(s, "  - data segments : %d (%d)\n",
@@ -441,6 +451,7 @@ int f2fs_build_stats(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
 	struct f2fs_stat_info *si;
+	int i;
 
 	si = f2fs_kzalloc(sbi, sizeof(struct f2fs_stat_info), GFP_KERNEL);
 	if (!si)
@@ -466,6 +477,8 @@ int f2fs_build_stats(struct f2fs_sb_info *sbi)
 	atomic_set(&sbi->inline_inode, 0);
 	atomic_set(&sbi->inline_dir, 0);
 	atomic_set(&sbi->inplace_count, 0);
+	for (i = META_CP; i < META_MAX; i++)
+		atomic_set(&sbi->meta_count[i], 0);
 
 	atomic_set(&sbi->aw_cnt, 0);
 	atomic_set(&sbi->vw_cnt, 0);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b1738113e821..0f82f342e514 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -202,6 +202,7 @@ enum {
 	META_NAT,
 	META_SIT,
 	META_SSA,
+	META_MAX,
 	META_POR,
 	DATA_GENERIC,
 	META_GENERIC,
@@ -1267,6 +1268,7 @@ struct f2fs_sb_info {
 	 */
 #ifdef CONFIG_F2FS_STAT_FS
 	struct f2fs_stat_info *stat_info;	/* FS status information */
+	atomic_t meta_count[META_MAX];		/* # of meta blocks */
 	unsigned int segment_count[2];		/* # of allocated segments */
 	unsigned int block_count[2];		/* # of allocated blocks */
 	atomic_t inplace_count;		/* # of inplace update */
@@ -3146,6 +3148,7 @@ struct f2fs_stat_info {
 	int cursec[NR_CURSEG_TYPE];
 	int curzone[NR_CURSEG_TYPE];
 
+	unsigned int meta_count[META_MAX];
 	unsigned int segment_count[2];
 	unsigned int block_count[2];
 	unsigned int inplace_count;
@@ -3197,6 +3200,17 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 		if (f2fs_has_inline_dentry(inode))			\
 			(atomic_dec(&F2FS_I_SB(inode)->inline_dir));	\
 	} while (0)
+#define stat_inc_meta_count(sbi, blkaddr)				\
+	do {								\
+		if (blkaddr < SIT_I(sbi)->sit_base_addr)		\
+			atomic_inc(&(sbi)->meta_count[META_CP]);	\
+		else if (blkaddr < NM_I(sbi)->nat_blkaddr)		\
+			atomic_inc(&(sbi)->meta_count[META_SIT]);	\
+		else if (blkaddr < SM_I(sbi)->ssa_blkaddr)		\
+			atomic_inc(&(sbi)->meta_count[META_NAT]);	\
+		else if (blkaddr < SM_I(sbi)->main_blkaddr)		\
+			atomic_inc(&(sbi)->meta_count[META_SSA]);	\
+	} while (0)
 #define stat_inc_seg_type(sbi, curseg)					\
 		((sbi)->segment_count[(curseg)->alloc_type]++)
 #define stat_inc_block_count(sbi, curseg)				\
@@ -3284,6 +3298,7 @@ void f2fs_destroy_root_stats(void);
 #define stat_inc_volatile_write(inode)			do { } while (0)
 #define stat_dec_volatile_write(inode)			do { } while (0)
 #define stat_update_max_volatile_write(inode)		do { } while (0)
+#define stat_inc_meta_count(sbi, blkaddr)		do { } while (0)
 #define stat_inc_seg_type(sbi, curseg)			do { } while (0)
 #define stat_inc_block_count(sbi, curseg)		do { } while (0)
 #define stat_inc_inplace_blocks(sbi)			do { } while (0)
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 230da5ee02e0..e16dae0f0a5b 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3018,6 +3018,7 @@ void f2fs_do_write_meta_page(struct f2fs_sb_info *sbi, struct page *page,
 	ClearPageError(page);
 	f2fs_submit_page_write(&fio);
 
+	stat_inc_meta_count(sbi, page->index);
 	f2fs_update_iostat(sbi, io_type, F2FS_BLKSIZE);
 }
 
-- 
2.18.0.rc1
