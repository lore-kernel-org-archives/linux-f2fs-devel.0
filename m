From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/6] f2fs: factor out discard command info into discard_cmd_control
Date: Thu, 12 Jan 2017 14:44:05 -0800
Message-ID: <20170112224407.54026-4-jaegeuk@kernel.org>
References: <20170112224407.54026-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170112224407.54026-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch adds discard_cmd_control with the existing discarding controls.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/debug.c   |  2 ++
 fs/f2fs/f2fs.h    | 16 ++++++++-----
 fs/f2fs/segment.c | 68 +++++++++++++++++++++++++++++++++++++++++++------------
 fs/f2fs/super.c   |  5 +++-
 4 files changed, 69 insertions(+), 22 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index cd338ca24941..f9f6b0aeba02 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -196,6 +196,8 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
 	/* build merge flush thread */
 	if (SM_I(sbi)->fcc_info)
 		si->cache_mem += sizeof(struct flush_cmd_control);
+	if (SM_I(sbi)->dcc_info)
+		si->cache_mem += sizeof(struct discard_cmd_control);
 
 	/* free nids */
 	si->cache_mem += (NM_I(sbi)->nid_cnt[FREE_NID_LIST] +
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a2850bf2a487..e7b403cbd70f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -185,6 +185,13 @@ struct discard_cmd {
 	struct bio *bio;		/* bio */
 };
 
+struct discard_cmd_control {
+	struct list_head discard_entry_list;	/* 4KB discard entry list */
+	int nr_discards;			/* # of discards in the list */
+	struct list_head discard_cmd_list;	/* discard cmd list */
+	int max_discards;			/* max. discards to be issued */
+};
+
 /* for the list of fsync inodes, used only during recovery */
 struct fsync_inode_entry {
 	struct list_head list;	/* list head */
@@ -628,12 +635,6 @@ struct f2fs_sm_info {
 	/* a threshold to reclaim prefree segments */
 	unsigned int rec_prefree_segments;
 
-	/* for small discard management */
-	struct list_head discard_entry_list;	/* 4KB discard entry list */
-	struct list_head discard_cmd_list;	/* discard cmd list */
-	int nr_discards;			/* # of discards in the list */
-	int max_discards;			/* max. discards to be issued */
-
 	struct list_head sit_entry_set;	/* sit entry set list */
 
 	unsigned int ipu_policy;	/* in-place-update policy */
@@ -642,6 +643,9 @@ struct f2fs_sm_info {
 
 	/* for flush command control */
 	struct flush_cmd_control *fcc_info;
+
+	/* for discard command control */
+	struct discard_cmd_control *dcc_info;
 };
 
 /*
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index e6f3c6db7616..e3bec31de961 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -631,7 +631,8 @@ static void locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno)
 static struct discard_cmd *__add_discard_cmd(struct f2fs_sb_info *sbi,
 			struct bio *bio, block_t lstart, block_t len)
 {
-	struct list_head *wait_list = &(SM_I(sbi)->discard_cmd_list);
+	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
+	struct list_head *cmd_list = &(dcc->discard_cmd_list);
 	struct discard_cmd *dc;
 
 	dc = f2fs_kmem_cache_alloc(discard_cmd_slab, GFP_NOFS);
@@ -640,7 +641,7 @@ static struct discard_cmd *__add_discard_cmd(struct f2fs_sb_info *sbi,
 	dc->lstart = lstart;
 	dc->len = len;
 	init_completion(&dc->wait);
-	list_add_tail(&dc->list, wait_list);
+	list_add_tail(&dc->list, cmd_list);
 
 	return dc;
 }
@@ -648,7 +649,8 @@ static struct discard_cmd *__add_discard_cmd(struct f2fs_sb_info *sbi,
 /* This should be covered by global mutex, &sit_i->sentry_lock */
 void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
 {
-	struct list_head *wait_list = &(SM_I(sbi)->discard_cmd_list);
+	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
+	struct list_head *wait_list = &(dcc->discard_cmd_list);
 	struct discard_cmd *dc, *tmp;
 
 	list_for_each_entry_safe(dc, tmp, wait_list, list) {
@@ -817,7 +819,7 @@ static void __add_discard_entry(struct f2fs_sb_info *sbi,
 		struct cp_control *cpc, struct seg_entry *se,
 		unsigned int start, unsigned int end)
 {
-	struct list_head *head = &SM_I(sbi)->discard_entry_list;
+	struct list_head *head = &SM_I(sbi)->dcc_info->discard_entry_list;
 	struct discard_entry *new, *last;
 
 	if (!list_empty(head)) {
@@ -836,7 +838,7 @@ static void __add_discard_entry(struct f2fs_sb_info *sbi,
 	new->len = end - start;
 	list_add_tail(&new->list, head);
 done:
-	SM_I(sbi)->nr_discards += end - start;
+	SM_I(sbi)->dcc_info->nr_discards += end - start;
 }
 
 static bool add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc,
@@ -858,7 +860,8 @@ static bool add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc,
 
 	if (!force) {
 		if (!test_opt(sbi, DISCARD) || !se->valid_blocks ||
-		    SM_I(sbi)->nr_discards >= SM_I(sbi)->max_discards)
+			SM_I(sbi)->dcc_info->nr_discards >=
+				SM_I(sbi)->dcc_info->max_discards)
 			return false;
 	}
 
@@ -867,7 +870,8 @@ static bool add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc,
 		dmap[i] = force ? ~ckpt_map[i] & ~discard_map[i] :
 				(cur_map[i] ^ ckpt_map[i]) & ckpt_map[i];
 
-	while (force || SM_I(sbi)->nr_discards <= SM_I(sbi)->max_discards) {
+	while (force || SM_I(sbi)->dcc_info->nr_discards <=
+				SM_I(sbi)->dcc_info->max_discards) {
 		start = __find_rev_next_bit(dmap, max_blocks, end + 1);
 		if (start >= max_blocks)
 			break;
@@ -887,7 +891,7 @@ static bool add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc,
 
 void release_discard_addrs(struct f2fs_sb_info *sbi)
 {
-	struct list_head *head = &(SM_I(sbi)->discard_entry_list);
+	struct list_head *head = &(SM_I(sbi)->dcc_info->discard_entry_list);
 	struct discard_entry *entry, *this;
 
 	/* drop caches */
@@ -913,7 +917,7 @@ static void set_prefree_as_free_segments(struct f2fs_sb_info *sbi)
 
 void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 {
-	struct list_head *head = &(SM_I(sbi)->discard_entry_list);
+	struct list_head *head = &(SM_I(sbi)->dcc_info->discard_entry_list);
 	struct discard_entry *entry, *this;
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
 	struct blk_plug plug;
@@ -973,13 +977,47 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		cpc->trimmed += entry->len;
 skip:
 		list_del(&entry->list);
-		SM_I(sbi)->nr_discards -= entry->len;
+		SM_I(sbi)->dcc_info->nr_discards -= entry->len;
 		kmem_cache_free(discard_entry_slab, entry);
 	}
 
 	blk_finish_plug(&plug);
 }
 
+int create_discard_cmd_control(struct f2fs_sb_info *sbi)
+{
+	struct discard_cmd_control *dcc;
+	int err = 0;
+
+	if (SM_I(sbi)->dcc_info) {
+		dcc = SM_I(sbi)->dcc_info;
+		goto init_thread;
+	}
+
+	dcc = kzalloc(sizeof(struct discard_cmd_control), GFP_KERNEL);
+	if (!dcc)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&dcc->discard_entry_list);
+	INIT_LIST_HEAD(&dcc->discard_cmd_list);
+	dcc->nr_discards = 0;
+	dcc->max_discards = 0;
+
+	SM_I(sbi)->dcc_info = dcc;
+init_thread:
+	return err;
+}
+
+void destroy_discard_cmd_control(struct f2fs_sb_info *sbi, bool free)
+{
+	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
+
+	if (free) {
+		kfree(dcc);
+		SM_I(sbi)->dcc_info = NULL;
+	}
+}
+
 static bool __mark_sit_entry_dirty(struct f2fs_sb_info *sbi, unsigned int segno)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
@@ -2693,11 +2731,6 @@ int build_segment_manager(struct f2fs_sb_info *sbi)
 	sm_info->min_ipu_util = DEF_MIN_IPU_UTIL;
 	sm_info->min_fsync_blocks = DEF_MIN_FSYNC_BLOCKS;
 
-	INIT_LIST_HEAD(&sm_info->discard_entry_list);
-	INIT_LIST_HEAD(&sm_info->discard_cmd_list);
-	sm_info->nr_discards = 0;
-	sm_info->max_discards = 0;
-
 	INIT_LIST_HEAD(&sm_info->sit_entry_set);
 
 	if (test_opt(sbi, FLUSH_MERGE) && !f2fs_readonly(sbi->sb)) {
@@ -2706,6 +2739,10 @@ int build_segment_manager(struct f2fs_sb_info *sbi)
 			return err;
 	}
 
+	err = create_discard_cmd_control(sbi);
+	if (err)
+		return err;
+
 	err = build_sit_info(sbi);
 	if (err)
 		return err;
@@ -2827,6 +2864,7 @@ void destroy_segment_manager(struct f2fs_sb_info *sbi)
 	if (!sm_info)
 		return;
 	destroy_flush_cmd_control(sbi, true);
+	destroy_discard_cmd_control(sbi, true);
 	destroy_dirty_segmap(sbi);
 	destroy_curseg(sbi);
 	destroy_free_segmap(sbi);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 37d40d8aa9c4..2ddd2dc50b08 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -145,6 +145,7 @@ static match_table_t f2fs_tokens = {
 enum {
 	GC_THREAD,	/* struct f2fs_gc_thread */
 	SM_INFO,	/* struct f2fs_sm_info */
+	DCC_INFO,	/* struct discard_cmd_control */
 	NM_INFO,	/* struct f2fs_nm_info */
 	F2FS_SBI,	/* struct f2fs_sb_info */
 #ifdef CONFIG_F2FS_FAULT_INJECTION
@@ -168,6 +169,8 @@ static unsigned char *__struct_ptr(struct f2fs_sb_info *sbi, int struct_type)
 		return (unsigned char *)sbi->gc_thread;
 	else if (struct_type == SM_INFO)
 		return (unsigned char *)SM_I(sbi);
+	else if (struct_type == DCC_INFO)
+		return (unsigned char *)SM_I(sbi)->dcc_info;
 	else if (struct_type == NM_INFO)
 		return (unsigned char *)NM_I(sbi);
 	else if (struct_type == F2FS_SBI)
@@ -283,7 +286,7 @@ F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_max_sleep_time, max_sleep_time);
 F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_no_gc_sleep_time, no_gc_sleep_time);
 F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_idle, gc_idle);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, reclaim_segments, rec_prefree_segments);
-F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, max_small_discards, max_discards);
+F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, max_small_discards, max_discards);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, ipu_policy, ipu_policy);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_ipu_util, min_ipu_util);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_fsync_blocks, min_fsync_blocks);
-- 
2.11.0
