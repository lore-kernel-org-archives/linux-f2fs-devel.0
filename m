From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH] f2fs: add adaptive ssr/ipu policy as valid blocks in dirty
 segments
Date: Wed, 31 Dec 2014 14:15:22 +0900
Message-ID: <1420002922-6482-1-git-send-email-cm224.lee@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Changman Lee <cm224.lee@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

If there is not enough invalid area in dirty segments, SSR won't get any
gains. In the case, IPU could be better than SSR. This patch is for
changing write style into IPU or SSR according to valid blocks in dirty segments.

Under 98% untilization, performance grows over 5.6%.

[FIO randwrite performance]
before : 338512KB/s, 307784KB/s, 296553KB/s, 287964KB/s, 283813KB/s
after  : 337842KB/s, 321810KB/s, 319700KB/s, 320000KB/s, 320902KB/s

[before]
IPU: 0 blocks
SSR: 1492820 blocks in 17278 segments
LFS: 517638 blocks in 1009 segments
BDF: 80, avg. vblocks: 457

[after]
IPU: 1256249 blocks
SSR: 251079 blocks in 891 segments
LFS: 490825 blocks in 957 segments
BDF: 86, avg. vblocks: 380

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 Documentation/filesystems/f2fs.txt |  2 +-
 fs/f2fs/data.c                     |  2 +-
 fs/f2fs/debug.c                    | 11 +++++++
 fs/f2fs/f2fs.h                     |  4 +++
 fs/f2fs/segment.c                  | 18 +++++++++---
 fs/f2fs/segment.h                  | 60 ++++++++++++++++++++++++++++++++++++--
 fs/f2fs/super.c                    |  2 ++
 7 files changed, 91 insertions(+), 8 deletions(-)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index e0950c4..b832720 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -201,7 +201,7 @@ Files in /sys/fs/f2fs/<devname>
                               updates in f2fs. There are five policies:
                                0x01: F2FS_IPU_FORCE, 0x02: F2FS_IPU_SSR,
                                0x04: F2FS_IPU_UTIL,  0x08: F2FS_IPU_SSR_UTIL,
-                               0x10: F2FS_IPU_FSYNC.
+                               0x10: F2FS_IPU_FSYNC, 0x20: F2FS_IPU_SSR_ADAP.
 
  min_ipu_util                 This parameter controls the threshold to trigger
                               in-place-updates. The number indicates percentage
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6308435..80f42da 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -779,7 +779,7 @@ int do_write_data_page(struct page *page, struct f2fs_io_info *fio)
 	 */
 	if (unlikely(fio->blk_addr != NEW_ADDR &&
 			!is_cold_data(page) &&
-			need_inplace_update(inode))) {
+			need_inplace_update(inode, page))) {
 		rewrite_data_page(page, fio);
 		set_inode_flag(F2FS_I(inode), FI_UPDATE_WRITE);
 	} else {
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index dd7835b..c7e6ef8 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -81,6 +81,9 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	}
 
 	si->inplace_count = atomic_read(&sbi->inplace_count);
+
+	for (i = 0; i < DIRTY; i++)
+		si->ssr_area[i] = get_ssr_area(sbi, i);
 }
 
 /*
@@ -290,6 +293,14 @@ static int stat_show(struct seq_file *s, void *v)
 		seq_printf(s, "\nBDF: %u, avg. vblocks: %u\n",
 			   si->bimodal, si->avg_vblocks);
 
+		seq_puts(s, "SSR area: ");
+		seq_printf(s, "%u/%u/%u, ", si->ssr_area[DIRTY_HOT_DATA],
+				si->ssr_area[DIRTY_WARM_DATA],
+				si->ssr_area[DIRTY_COLD_DATA]);
+		seq_printf(s, "%u/%u/%u\n", si->ssr_area[DIRTY_HOT_NODE],
+				si->ssr_area[DIRTY_WARM_NODE],
+				si->ssr_area[DIRTY_COLD_NODE]);
+
 		/* memory footprint */
 		update_mem_info(si->sbi);
 		seq_printf(s, "\nMemory: %u KB = static: %u + cached: %u\n",
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c48847e..81f88d3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -450,6 +450,8 @@ struct f2fs_sm_info {
 	unsigned int ipu_policy;	/* in-place-update policy */
 	unsigned int min_ipu_util;	/* in-place-update threshold */
 	unsigned int min_fsync_blocks;	/* threshold for fsync */
+	unsigned int min_ssr_area;	/* in-place-update under value */
+	unsigned int vblocks_in_dirty[NR_CURSEG_TYPE];
 
 	/* for flush command control */
 	struct flush_cmd_control *cmd_control_info;
@@ -1417,6 +1419,7 @@ void clear_prefree_segments(struct f2fs_sb_info *);
 void release_discard_addrs(struct f2fs_sb_info *);
 void discard_next_dnode(struct f2fs_sb_info *, block_t);
 int npages_for_summary_flush(struct f2fs_sb_info *, bool);
+int get_segment_type(struct page *, enum page_type);
 void allocate_new_segments(struct f2fs_sb_info *);
 int f2fs_trim_fs(struct f2fs_sb_info *, struct fstrim_range *);
 struct page *get_sum_page(struct f2fs_sb_info *, unsigned int);
@@ -1525,6 +1528,7 @@ struct f2fs_stat_info {
 	int curseg[NR_CURSEG_TYPE];
 	int cursec[NR_CURSEG_TYPE];
 	int curzone[NR_CURSEG_TYPE];
+	unsigned int ssr_area[NR_CURSEG_TYPE];
 
 	unsigned int segment_count[2];
 	unsigned int block_count[2];
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index f995a85..3987e65 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -398,8 +398,10 @@ static void __locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
 			f2fs_bug_on(sbi, 1);
 			return;
 		}
-		if (!test_and_set_bit(segno, dirty_i->dirty_segmap[t]))
+		if (!test_and_set_bit(segno, dirty_i->dirty_segmap[t])) {
 			dirty_i->nr_dirty[t]++;
+			add_vblocks_in_dirty(sbi, sentry);
+		}
 	}
 }
 
@@ -415,8 +417,10 @@ static void __remove_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
 		struct seg_entry *sentry = get_seg_entry(sbi, segno);
 		enum dirty_type t = sentry->type;
 
-		if (test_and_clear_bit(segno, dirty_i->dirty_segmap[t]))
+		if (test_and_clear_bit(segno, dirty_i->dirty_segmap[t])) {
 			dirty_i->nr_dirty[t]--;
+			del_vblocks_in_dirty(sbi, sentry);
+		}
 
 		if (get_valid_blocks(sbi, segno, sbi->segs_per_sec) == 0)
 			clear_bit(GET_SECNO(sbi, segno),
@@ -658,6 +662,8 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 	f2fs_bug_on(sbi, (new_vblocks >> (sizeof(unsigned short) << 3) ||
 				(new_vblocks > sbi->blocks_per_seg)));
 
+	update_vblocks_in_dirty(sbi, se, segno, del);
+
 	se->valid_blocks = new_vblocks;
 	se->mtime = get_mtime(sbi);
 	SIT_I(sbi)->max_mtime = se->mtime;
@@ -1128,7 +1134,7 @@ static int __get_segment_type_6(struct page *page, enum page_type p_type)
 	}
 }
 
-static int __get_segment_type(struct page *page, enum page_type p_type)
+int get_segment_type(struct page *page, enum page_type p_type)
 {
 	switch (F2FS_P_SB(page)->active_logs) {
 	case 2:
@@ -1187,7 +1193,7 @@ static void do_write_page(struct f2fs_sb_info *sbi, struct page *page,
 			struct f2fs_summary *sum,
 			struct f2fs_io_info *fio)
 {
-	int type = __get_segment_type(page, fio->type);
+	int type = get_segment_type(page, fio->type);
 
 	allocate_data_block(sbi, page, fio->blk_addr, &fio->blk_addr, sum, type);
 
@@ -2003,6 +2009,9 @@ static void init_dirty_segmap(struct f2fs_sb_info *sbi)
 	unsigned int segno = 0, offset = 0;
 	unsigned short valid_blocks;
 
+	memset(SM_I(sbi)->vblocks_in_dirty, 0,
+			sizeof(SM_I(sbi)->vblocks_in_dirty));
+
 	while (1) {
 		/* find dirty segment based on free segmap */
 		segno = find_next_inuse(free_i, MAIN_SEGS(sbi), offset);
@@ -2111,6 +2120,7 @@ int build_segment_manager(struct f2fs_sb_info *sbi)
 	sm_info->ipu_policy = 1 << F2FS_IPU_FSYNC;
 	sm_info->min_ipu_util = DEF_MIN_IPU_UTIL;
 	sm_info->min_fsync_blocks = DEF_MIN_FSYNC_BLOCKS;
+	sm_info->min_ssr_area = DEF_MIN_SSR_AREA;
 
 	INIT_LIST_HEAD(&sm_info->discard_list);
 	sm_info->nr_discards = 0;
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 7f327c0..7bbb78c 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -490,10 +490,12 @@ static inline int utilization(struct f2fs_sb_info *sbi)
  * F2FS_IPU_FSYNC - activated in fsync path only for high performance flash
  *                     storages. IPU will be triggered only if the # of dirty
  *                     pages over min_fsync_blocks.
+ * F2FS_IPU_SSR_ADAP - if SSR mode is enabled and SSR area is under threshold
  * F2FS_IPUT_DISABLE - disable IPU. (=default option)
  */
 #define DEF_MIN_IPU_UTIL	70
 #define DEF_MIN_FSYNC_BLOCKS	8
+#define DEF_MIN_SSR_AREA	384
 
 enum {
 	F2FS_IPU_FORCE,
@@ -501,9 +503,60 @@ enum {
 	F2FS_IPU_UTIL,
 	F2FS_IPU_SSR_UTIL,
 	F2FS_IPU_FSYNC,
+	F2FS_IPU_SSR_ADAP,
 };
 
-static inline bool need_inplace_update(struct inode *inode)
+/*
+ * This function accumulates valid blocks in dirty segments
+ */
+static inline void add_vblocks_in_dirty(struct f2fs_sb_info *sbi,
+		struct seg_entry *se)
+{
+	SM_I(sbi)->vblocks_in_dirty[se->type] += se->valid_blocks;
+}
+
+static inline void del_vblocks_in_dirty(struct f2fs_sb_info *sbi,
+		struct seg_entry *se)
+{
+	SM_I(sbi)->vblocks_in_dirty[se->type] -= se->valid_blocks;
+}
+
+static inline void update_vblocks_in_dirty(struct f2fs_sb_info *sbi,
+		struct seg_entry *se, int segno, int del)
+{
+	enum dirty_type t = se->type;
+	unsigned int vblocks;
+
+	if (IS_CURSEG(sbi, segno))
+		return;
+
+	mutex_lock(&DIRTY_I(sbi)->seglist_lock);
+	if (test_bit(segno, DIRTY_I(sbi)->dirty_segmap[t])) {
+		vblocks = SM_I(sbi)->vblocks_in_dirty[t];
+		f2fs_bug_on(sbi, vblocks == 0 && del < 0);
+		SM_I(sbi)->vblocks_in_dirty[t] += del;
+	}
+	mutex_unlock(&DIRTY_I(sbi)->seglist_lock);
+}
+
+static inline unsigned int get_ssr_area(struct f2fs_sb_info *sbi, int type)
+{
+	unsigned int nr_dirty = DIRTY_I(sbi)->nr_dirty[type];
+	unsigned int vblocks_in_dirty = SM_I(sbi)->vblocks_in_dirty[type];
+	unsigned int avg_vblks;
+
+	if (nr_dirty == 0)
+		return 0;
+	avg_vblks = vblocks_in_dirty / nr_dirty;
+	if (unlikely(avg_vblks > sbi->blocks_per_seg)) {
+		f2fs_msg(sbi->sb, KERN_WARNING, "vblocks/dirty = %u/%u = %u\n",
+				vblocks_in_dirty, nr_dirty, avg_vblks);
+		return 0;
+	}
+	return sbi->blocks_per_seg - avg_vblks;
+}
+
+static inline bool need_inplace_update(struct inode *inode, struct page *page)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	unsigned int policy = SM_I(sbi)->ipu_policy;
@@ -522,7 +575,10 @@ static inline bool need_inplace_update(struct inode *inode)
 	if (policy & (0x1 << F2FS_IPU_SSR_UTIL) && need_SSR(sbi) &&
 			utilization(sbi) > SM_I(sbi)->min_ipu_util)
 		return true;
-
+	if (policy & (0x1 << F2FS_IPU_SSR_ADAP) && need_SSR(sbi) &&
+			get_ssr_area(sbi, get_segment_type(page, DATA)) <
+			SM_I(sbi)->min_ssr_area)
+		return true;
 	/* this is only set during fdatasync */
 	if (policy & (0x1 << F2FS_IPU_FSYNC) &&
 			is_inode_flag_set(F2FS_I(inode), FI_NEED_IPU))
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 0ae6a2f..fb92073 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -199,6 +199,7 @@ F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_fsync_blocks, min_fsync_blocks);
 F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, ram_thresh, ram_thresh);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, max_victim_search, max_victim_search);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, dir_level, dir_level);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sm_info, min_ssr_area, min_ssr_area);
 
 #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
 static struct attribute *f2fs_attrs[] = {
@@ -214,6 +215,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(max_victim_search),
 	ATTR_LIST(dir_level),
 	ATTR_LIST(ram_thresh),
+	ATTR_LIST(min_ssr_area),
 	NULL,
 };
 
-- 
1.9.1

