From: Chao Yu <chao@kernel.org>
Subject: [PATCH v2 1/6] f2fs: support issuing/waiting discard in range
Date: Wed,  4 Oct 2017 09:08:32 +0800
Message-ID: <20171004010837.9809-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

Fstrim intends to trim invalid blocks of filesystem only with specified
range and granularity, but actually, it will issue all previous cached
discard commands which may be out-of-range and be with unmatched
granularity, it's unneeded.

In order to fix above issues, this patch introduces new helps to support
to issue and wait discard in range and adds a new fstrim_list for tracking
in-flight discard from ->fstrim.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- rebase on last codes of Jaegeuk's dev-test branch.
 fs/f2fs/f2fs.h    |   3 +-
 fs/f2fs/segment.c | 127 +++++++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 108 insertions(+), 22 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a3fdcdade50b..6d51e8342513 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -251,6 +251,7 @@ struct discard_cmd_control {
 	struct list_head pend_list[MAX_PLIST_NUM];/* store pending entries */
 	unsigned char pend_list_tag[MAX_PLIST_NUM];/* tag for pending entries */
 	struct list_head wait_list;		/* store on-flushing entries */
+	struct list_head fstrim_list;		/* in-flight discard from fstrim */
 	wait_queue_head_t discard_wait_queue;	/* waiting queue for wake-up */
 	unsigned int discard_wake;		/* to wake up discard thread */
 	struct mutex cmd_lock;
@@ -2547,7 +2548,7 @@ void invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr);
 bool is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr);
 void refresh_sit_entry(struct f2fs_sb_info *sbi, block_t old, block_t new);
 void stop_discard_thread(struct f2fs_sb_info *sbi);
-void f2fs_wait_discard_bios(struct f2fs_sb_info *sbi, bool umount);
+void f2fs_wait_discard_bios(struct f2fs_sb_info *sbi);
 void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc);
 void release_discard_addrs(struct f2fs_sb_info *sbi);
 int npages_for_summary_flush(struct f2fs_sb_info *sbi, bool for_ra);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index d5bad5aedded..a0a0a887fc31 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -873,9 +873,11 @@ void __check_sit_bitmap(struct f2fs_sb_info *sbi,
 
 /* this function is copied from blkdev_issue_discard from block/blk-lib.c */
 static void __submit_discard_cmd(struct f2fs_sb_info *sbi,
-				struct discard_cmd *dc)
+				struct discard_cmd *dc, bool fstrim)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
+	struct list_head *wait_list = fstrim ? &(dcc->fstrim_list) :
+							&(dcc->wait_list);
 	struct bio *bio = NULL;
 
 	if (dc->state != D_PREP)
@@ -897,7 +899,7 @@ static void __submit_discard_cmd(struct f2fs_sb_info *sbi,
 			bio->bi_end_io = f2fs_submit_discard_endio;
 			bio->bi_opf |= REQ_SYNC;
 			submit_bio(bio);
-			list_move_tail(&dc->list, &dcc->wait_list);
+			list_move_tail(&dc->list, wait_list);
 			__check_sit_bitmap(sbi, dc->start, dc->start + dc->len);
 
 			f2fs_update_iostat(sbi, FS_DISCARD, 1);
@@ -1082,6 +1084,68 @@ static int __queue_discard_cmd(struct f2fs_sb_info *sbi,
 	return 0;
 }
 
+static void __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
+					unsigned int start, unsigned int end,
+					unsigned int granularity)
+{
+	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
+	struct discard_cmd *prev_dc = NULL, *next_dc = NULL;
+	struct rb_node **insert_p = NULL, *insert_parent = NULL;
+	struct discard_cmd *dc;
+	struct blk_plug plug;
+	int issued;
+
+next:
+	issued = 0;
+
+	mutex_lock(&dcc->cmd_lock);
+	f2fs_bug_on(sbi, !__check_rb_tree_consistence(sbi, &dcc->root));
+
+	dc = (struct discard_cmd *)__lookup_rb_tree_ret(&dcc->root,
+					NULL, start,
+					(struct rb_entry **)&prev_dc,
+					(struct rb_entry **)&next_dc,
+					&insert_p, &insert_parent, true);
+	if (!dc)
+		dc = next_dc;
+
+	blk_start_plug(&plug);
+
+	while (dc && dc->lstart <= end) {
+		struct rb_node *node;
+
+		if (dc->len < granularity)
+			goto skip;
+
+		if (dc->state != D_PREP) {
+			list_move_tail(&dc->list, &dcc->fstrim_list);
+			goto skip;
+		}
+
+		__submit_discard_cmd(sbi, dc, true);
+
+		if (++issued >= DISCARD_ISSUE_RATE) {
+			start = dc->lstart + dc->len;
+
+			blk_finish_plug(&plug);
+			mutex_unlock(&dcc->cmd_lock);
+
+			schedule();
+
+			goto next;
+		}
+skip:
+		node = rb_next(&dc->rb_node);
+		dc = rb_entry_safe(node, struct discard_cmd, rb_node);
+
+		if (fatal_signal_pending(current))
+			break;
+	}
+
+	blk_finish_plug(&plug);
+	mutex_unlock(&dcc->cmd_lock);
+}
+
 static int __issue_discard_cmd(struct f2fs_sb_info *sbi, bool issue_cond)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
@@ -1104,22 +1168,19 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi, bool issue_cond)
 
 			/* Hurry up to finish fstrim */
 			if (dcc->pend_list_tag[i] & P_TRIM) {
-				__submit_discard_cmd(sbi, dc);
+				__submit_discard_cmd(sbi, dc, false);
 				issued++;
-
-				if (fatal_signal_pending(current))
-					break;
 				continue;
 			}
 
 			if (!issue_cond) {
-				__submit_discard_cmd(sbi, dc);
+				__submit_discard_cmd(sbi, dc, false);
 				issued++;
 				continue;
 			}
 
 			if (is_idle(sbi)) {
-				__submit_discard_cmd(sbi, dc);
+				__submit_discard_cmd(sbi, dc, false);
 				issued++;
 			} else {
 				io_interrupted = true;
@@ -1173,10 +1234,14 @@ static void __wait_one_discard_bio(struct f2fs_sb_info *sbi,
 	mutex_unlock(&dcc->cmd_lock);
 }
 
-static void __wait_discard_cmd(struct f2fs_sb_info *sbi, bool wait_cond)
+static void __wait_discard_cmd_range(struct f2fs_sb_info *sbi, bool wait_cond,
+						block_t start, block_t end,
+						unsigned int granularity,
+						bool fstrim)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
-	struct list_head *wait_list = &(dcc->wait_list);
+	struct list_head *wait_list = fstrim ? &(dcc->fstrim_list) :
+							&(dcc->wait_list);
 	struct discard_cmd *dc, *tmp;
 	bool need_wait;
 
@@ -1185,6 +1250,10 @@ static void __wait_discard_cmd(struct f2fs_sb_info *sbi, bool wait_cond)
 
 	mutex_lock(&dcc->cmd_lock);
 	list_for_each_entry_safe(dc, tmp, wait_list, list) {
+		if (dc->lstart + dc->len <= start || end <= dc->lstart)
+			continue;
+		if (dc->len < granularity)
+			continue;
 		if (!wait_cond || (dc->state == D_DONE && !dc->ref)) {
 			wait_for_completion_io(&dc->wait);
 			__remove_discard_cmd(sbi, dc);
@@ -1202,6 +1271,11 @@ static void __wait_discard_cmd(struct f2fs_sb_info *sbi, bool wait_cond)
 	}
 }
 
+static void __wait_all_discard_cmd(struct f2fs_sb_info *sbi, bool wait_cond)
+{
+	__wait_discard_cmd_range(sbi, wait_cond, 0, UINT_MAX, 1, false);
+}
+
 /* This should be covered by global mutex, &sit_i->sentry_lock */
 void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
 {
@@ -1237,12 +1311,12 @@ void stop_discard_thread(struct f2fs_sb_info *sbi)
 	}
 }
 
-/* This comes from f2fs_put_super and f2fs_trim_fs */
-void f2fs_wait_discard_bios(struct f2fs_sb_info *sbi, bool umount)
+/* This comes from f2fs_put_super */
+void f2fs_wait_discard_bios(struct f2fs_sb_info *sbi)
 {
 	__issue_discard_cmd(sbi, false);
 	__drop_discard_cmd(sbi);
-	__wait_discard_cmd(sbi, !umount);
+	__wait_all_discard_cmd(sbi, false);
 }
 
 static void mark_discard_range_all(struct f2fs_sb_info *sbi)
@@ -1286,7 +1360,7 @@ static int issue_discard_thread(void *data)
 
 		issued = __issue_discard_cmd(sbi, true);
 		if (issued) {
-			__wait_discard_cmd(sbi, true);
+			__wait_all_discard_cmd(sbi, true);
 			wait_ms = DEF_MIN_DISCARD_ISSUE_TIME;
 		} else {
 			wait_ms = DEF_MAX_DISCARD_ISSUE_TIME;
@@ -1597,6 +1671,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 			dcc->pend_list_tag[i] |= P_ACTIVE;
 	}
 	INIT_LIST_HEAD(&dcc->wait_list);
+	INIT_LIST_HEAD(&dcc->fstrim_list);
 	mutex_init(&dcc->cmd_lock);
 	atomic_set(&dcc->issued_discard, 0);
 	atomic_set(&dcc->issing_discard, 0);
@@ -2224,7 +2299,8 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 {
 	__u64 start = F2FS_BYTES_TO_BLK(range->start);
 	__u64 end = start + F2FS_BYTES_TO_BLK(range->len) - 1;
-	unsigned int start_segno, end_segno;
+	unsigned int start_segno, end_segno, cur_segno;
+	block_t start_block, end_block;
 	struct cp_control cpc;
 	int err = 0;
 
@@ -2245,12 +2321,17 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 	start_segno = (start <= MAIN_BLKADDR(sbi)) ? 0 : GET_SEGNO(sbi, start);
 	end_segno = (end >= MAX_BLKADDR(sbi)) ? MAIN_SEGS(sbi) - 1 :
 						GET_SEGNO(sbi, end);
+
+	start_block = START_BLOCK(sbi, start_segno);
+	end_block = START_BLOCK(sbi, end_segno + 1);
+
 	cpc.reason = CP_DISCARD;
 	cpc.trim_minlen = max_t(__u64, 1, F2FS_BYTES_TO_BLK(range->minlen));
 
 	/* do checkpoint to issue discard commands safely */
-	for (; start_segno <= end_segno; start_segno = cpc.trim_end + 1) {
-		cpc.trim_start = start_segno;
+	for (cur_segno = start_segno; cur_segno <= end_segno;
+					cur_segno = cpc.trim_end + 1) {
+		cpc.trim_start = cur_segno;
 
 		if (sbi->discard_blks == 0)
 			break;
@@ -2258,7 +2339,7 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 			cpc.trim_end = end_segno;
 		else
 			cpc.trim_end = min_t(unsigned int,
-				rounddown(start_segno +
+				rounddown(cur_segno +
 				BATCHED_TRIM_SEGMENTS(sbi),
 				sbi->segs_per_sec) - 1, end_segno);
 
@@ -2270,9 +2351,13 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 
 		schedule();
 	}
-	/* It's time to issue all the filed discards */
-	mark_discard_range_all(sbi);
-	f2fs_wait_discard_bios(sbi, false);
+
+	start_block = START_BLOCK(sbi, start_segno);
+	end_block = START_BLOCK(sbi, min(cur_segno, end_segno) + 1);
+
+	__issue_discard_cmd_range(sbi, start_block, end_block, cpc.trim_minlen);
+	__wait_discard_cmd_range(sbi, true, start_block, end_block,
+						cpc.trim_minlen, true);
 out:
 	range->len = F2FS_BLK_TO_BYTES(cpc.trimmed);
 	return err;
-- 
2.14.1.145.gb3622a4ee
