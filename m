From: Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: introduce discard_granularity sysfs entry
Date: Fri, 28 Jul 2017 23:52:46 +0800
Message-ID: <20170728155246.7042-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

Commit d618ebaf0aa8 ("f2fs: enable small discard by default") enables
f2fs to issue 4K size discard in real-time discard mode. However, issuing
smaller discard may cost more flash lifetime but release less free
space in storage. Since f2fs has ability of separating hot/cold data and
garbage collection, we can expect that size of small invalid region may
expand with data ipu/deletion or garbage collection, so it's better to
delay or skip issuing smaller size discard, it could help to reduce
overmuch consumption of IO bandwidth and lifetime of flash storage.

This patch makes f2fs issuing discard with granularity of 64K by default,
and exposes discard granularity as sysfs entry for configuration in
different scenario.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 7 +++++++
 fs/f2fs/f2fs.h                          | 4 ++++
 fs/f2fs/segment.c                       | 4 ++++
 fs/f2fs/sysfs.c                         | 2 ++
 4 files changed, 17 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 84c606fb3ca4..964aaefafc72 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -57,6 +57,13 @@ Contact:	"Jaegeuk Kim" <jaegeuk.kim@samsung.com>
 Description:
 		 Controls the issue rate of small discard commands.
 
+What:          /sys/fs/f2fs/<disk>/discard_granularity
+Date:          July 2017
+Contact:       "Chao Yu" <yuchao0@huawei.com>
+Description:
+		Controls discard granularity of inner discard thread, discard thread
+		will not issue discards with size that is smaller than granularity.
+
 What:		/sys/fs/f2fs/<disk>/max_victim_search
 Date:		January 2014
 Contact:	"Jaegeuk Kim" <jaegeuk.kim@samsung.com>
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d6975b81b96b..0eee2c80ea9f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -196,6 +196,9 @@ struct discard_entry {
 	unsigned char discard_map[SIT_VBLOCK_MAP_SIZE];	/* segment discard bitmap */
 };
 
+/* default discard granularity of inner discard thread, unit: block count */
+#define DEFAULT_DISCARD_GRANULARITY		16
+
 /* max discard pend list number */
 #define MAX_PLIST_NUM		512
 #define plist_idx(blk_num)	((blk_num) >= MAX_PLIST_NUM ?		\
@@ -241,6 +244,7 @@ struct discard_cmd_control {
 	struct mutex cmd_lock;
 	unsigned int nr_discards;		/* # of discards in the list */
 	unsigned int max_discards;		/* max. discards to be issued */
+	unsigned int discard_granularity;	/* discard granularity */
 	unsigned int undiscard_blks;		/* # of undiscard blocks */
 	atomic_t issued_discard;		/* # of issued discard */
 	atomic_t issing_discard;		/* # of issing discard */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index df1bb0c144f1..4a0bf3643e93 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1017,6 +1017,9 @@ static void __issue_discard_cmd(struct f2fs_sb_info *sbi, bool issue_cond)
 		!__check_rb_tree_consistence(sbi, &dcc->root));
 	blk_start_plug(&plug);
 	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
+		if (i + 1 < dcc->discard_granularity)
+			break;
+
 		pend_list = &dcc->pend_list[i];
 		list_for_each_entry_safe(dc, tmp, pend_list, list) {
 			f2fs_bug_on(sbi, dc->state != D_PREP);
@@ -1446,6 +1449,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 	atomic_set(&dcc->discard_cmd_cnt, 0);
 	dcc->nr_discards = 0;
 	dcc->max_discards = MAIN_SEGS(sbi) << sbi->log_blocks_per_seg;
+	dcc->discard_granularity = DEFAULT_DISCARD_GRANULARITY;
 	dcc->undiscard_blks = 0;
 	dcc->root = RB_ROOT;
 
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 9ca898c10d09..f20eeb6b91a6 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -231,6 +231,7 @@ F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_no_gc_sleep_time, no_gc_sleep_time);
 F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_idle, gc_idle);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, reclaim_segments, rec_prefree_segments);
 F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, max_small_discards, max_discards);
+F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, discard_granularity, discard_granularity);
 F2FS_RW_ATTR(RESERVED_BLOCKS, f2fs_sb_info, reserved_blocks, reserved_blocks);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, batched_trim_sections, trim_sections);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, ipu_policy, ipu_policy);
@@ -267,6 +268,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(gc_idle),
 	ATTR_LIST(reclaim_segments),
 	ATTR_LIST(max_small_discards),
+	ATTR_LIST(discard_granularity),
 	ATTR_LIST(batched_trim_sections),
 	ATTR_LIST(ipu_policy),
 	ATTR_LIST(min_ipu_util),
-- 
2.13.0.90.g1eb437020
