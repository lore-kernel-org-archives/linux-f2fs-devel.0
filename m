From: Chao Yu <chao@kernel.org>
Subject: [PATCH v2 2/2] f2fs: issue small discard by LBA order
Date: Sun,  8 Jul 2018 22:11:01 +0800
Message-ID: <20180708141101.23676-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

For small granularity discard which size is smaller than 64KB, if we
issue those kind of discards orderly by size, their IOs will be spread
into entire logical address, so that in FTL, L2P table will be updated
randomly, result bad wear rate in the table.

In this patch, we choose to issue small discard by LBA order, by this
way, we can expect that L2P table updates from adjacent discard IOs can
be merged in the cache, so it can reduce lifetime wearing of flash.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- remove unneeded header file.
- don't retry submission if there is queued IO.
 fs/f2fs/f2fs.h    |  2 ++
 fs/f2fs/segment.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index bf5f7a336ace..c48b655d5d8d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -297,6 +297,7 @@ struct discard_policy {
 	unsigned int io_aware_gran;	/* minimum granularity discard not be aware of I/O */
 	bool io_aware;			/* issue discard in idle time */
 	bool sync;			/* submit discard with REQ_SYNC flag */
+	bool ordered;			/* issue discard by lba order */
 	unsigned int granularity;	/* discard granularity */
 };
 
@@ -313,6 +314,7 @@ struct discard_cmd_control {
 	unsigned int max_discards;		/* max. discards to be issued */
 	unsigned int discard_granularity;	/* discard granularity */
 	unsigned int undiscard_blks;		/* # of undiscard blocks */
+	unsigned int next_pos;			/* next discard position */
 	atomic_t issued_discard;		/* # of issued discard */
 	atomic_t issing_discard;		/* # of issing discard */
 	atomic_t discard_cmd_cnt;		/* # of cached cmd count */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index aee198869b1f..f7f56dd091b4 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -936,6 +936,7 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
 	/* common policy */
 	dpolicy->type = discard_type;
 	dpolicy->sync = true;
+	dpolicy->ordered = false;
 	dpolicy->granularity = granularity;
 
 	dpolicy->max_requests = DEF_MAX_DISCARD_REQUEST;
@@ -947,6 +948,7 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
 		dpolicy->max_interval = DEF_MAX_DISCARD_ISSUE_TIME;
 		dpolicy->io_aware = true;
 		dpolicy->sync = false;
+		dpolicy->ordered = true;
 		if (utilization(sbi) > DEF_DISCARD_URGENT_UTIL) {
 			dpolicy->granularity = 1;
 			dpolicy->max_interval = DEF_MIN_DISCARD_ISSUE_TIME;
@@ -1183,6 +1185,63 @@ static int __queue_discard_cmd(struct f2fs_sb_info *sbi,
 	return 0;
 }
 
+static unsigned int __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
+					struct discard_policy *dpolicy)
+{
+	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
+	struct discard_cmd *prev_dc = NULL, *next_dc = NULL;
+	struct rb_node **insert_p = NULL, *insert_parent = NULL;
+	struct discard_cmd *dc;
+	struct blk_plug plug;
+	unsigned int pos = dcc->next_pos;
+	unsigned int issued = 0;
+	bool io_interrupted = false;
+
+	mutex_lock(&dcc->cmd_lock);
+	dc = (struct discard_cmd *)f2fs_lookup_rb_tree_ret(&dcc->root,
+					NULL, pos,
+					(struct rb_entry **)&prev_dc,
+					(struct rb_entry **)&next_dc,
+					&insert_p, &insert_parent, true);
+	if (!dc)
+		dc = next_dc;
+
+	blk_start_plug(&plug);
+
+	while (dc) {
+		struct rb_node *node;
+
+		if (dc->state != D_PREP)
+			goto next;
+
+		if (dpolicy->io_aware && !is_idle(sbi)) {
+			io_interrupted = true;
+			break;
+		}
+
+		dcc->next_pos = dc->lstart + dc->len;
+		__submit_discard_cmd(sbi, dpolicy, dc);
+
+		if (++issued >= dpolicy->max_requests)
+			break;
+next:
+		node = rb_next(&dc->rb_node);
+		dc = rb_entry_safe(node, struct discard_cmd, rb_node);
+	}
+
+	blk_finish_plug(&plug);
+
+	if (!dc)
+		dcc->next_pos = 0;
+
+	mutex_unlock(&dcc->cmd_lock);
+
+	if (!issued && io_interrupted)
+		issued = -1;
+
+	return issued;
+}
+
 static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 					struct discard_policy *dpolicy)
 {
@@ -1196,6 +1255,10 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
 		if (i + 1 < dpolicy->granularity)
 			break;
+
+		if (i < DEFAULT_DISCARD_GRANULARITY && dpolicy->ordered)
+			return __issue_discard_cmd_orderly(sbi, dpolicy);
+
 		pend_list = &dcc->pend_list[i];
 
 		mutex_lock(&dcc->cmd_lock);
@@ -1754,6 +1817,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 	dcc->nr_discards = 0;
 	dcc->max_discards = MAIN_SEGS(sbi) << sbi->log_blocks_per_seg;
 	dcc->undiscard_blks = 0;
+	dcc->next_pos = 0;
 	dcc->root = RB_ROOT;
 	dcc->rbtree_check = false;
 
-- 
2.16.2.17.g38e79b1fd
