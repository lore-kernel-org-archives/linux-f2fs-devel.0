From: Chao Yu <chao@kernel.org>
Subject: [PATCH v2 3/6] f2fs: split discard policy
Date: Wed,  4 Oct 2017 09:08:34 +0800
Message-ID: <20171004010837.9809-3-chao@kernel.org>
References: <20171004010837.9809-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <chao@kernel.org>) id 1dzYBC-0004Vl-H3
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 04 Oct 2017 01:08:54 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1dzYBA-0001S7-VV
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 04 Oct 2017 01:08:54 +0000
In-Reply-To: <20171004010837.9809-1-chao@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

There are many different scenarios such as fstrim, umount, urgent or
background where we will issue discards, actually, they need use
different policy in aspect of io aware, discard granularity, delay
interval and so on. But now they just share one common discard policy,
so there will be race when changing policy in between these scenarios,
the interference of changing discard policy will be very serious.

This patch changes to split discard policy for different scenarios.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- rebase on last codes of Jaegeuk's dev-test branch.
 fs/f2fs/f2fs.h    |  17 +++++--
 fs/f2fs/segment.c | 149 ++++++++++++++++++++++++++----------------------------
 fs/f2fs/segment.h |   5 +-
 fs/f2fs/sysfs.c   |  13 -----
 4 files changed, 88 insertions(+), 96 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 67dd6a317384..f274805e231d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -210,10 +210,6 @@ struct discard_entry {
 #define plist_idx(blk_num)	((blk_num) >= MAX_PLIST_NUM ?		\
 					(MAX_PLIST_NUM - 1) : (blk_num - 1))
 
-#define P_ACTIVE	0x01
-#define P_TRIM		0x02
-#define plist_issue(tag)	(((tag) & P_ACTIVE) || ((tag) & P_TRIM))
-
 enum {
 	D_PREP,
 	D_SUBMIT,
@@ -245,13 +241,23 @@ struct discard_cmd {
 	int error;			/* bio error */
 };
 
+enum {
+	DPOLICY_BG,
+	DPOLICY_FORCE,
+	DPOLICY_FSTRIM,
+	DPOLICY_UMOUNT,
+	MAX_DPOLICY,
+};
+
 struct discard_policy {
+	int type;			/* type of discard */
 	unsigned int min_interval;	/* used for candidates exist */
 	unsigned int max_interval;	/* used for candidates not exist */
 	unsigned int max_requests;	/* # of discards issued per round */
 	unsigned int io_aware_gran;	/* minimum granularity discard not be aware of I/O */
 	bool io_aware;			/* issue discard in idle time */
 	bool sync;			/* submit discard with REQ_SYNC flag */
+	unsigned int granularity;	/* discard granularity */
 };
 
 struct discard_cmd_control {
@@ -272,7 +278,6 @@ struct discard_cmd_control {
 	atomic_t issing_discard;		/* # of issing discard */
 	atomic_t discard_cmd_cnt;		/* # of cached cmd count */
 	struct rb_root root;			/* root of discard rb-tree */
-	struct discard_policy dpolicy;		/* current discard policy */
 };
 
 /* for the list of fsync inodes, used only during recovery */
@@ -2556,6 +2561,8 @@ int f2fs_flush_device_cache(struct f2fs_sb_info *sbi);
 void destroy_flush_cmd_control(struct f2fs_sb_info *sbi, bool free);
 void invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr);
 bool is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr);
+void init_discard_policy(struct discard_policy *dpolicy, int discard_type,
+						unsigned int granularity);
 void refresh_sit_entry(struct f2fs_sb_info *sbi, block_t old, block_t new);
 void stop_discard_thread(struct f2fs_sb_info *sbi);
 void f2fs_wait_discard_bios(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 5853187230e7..e8fcc1eb4e0a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -873,13 +873,14 @@ void __check_sit_bitmap(struct f2fs_sb_info *sbi,
 
 /* this function is copied from blkdev_issue_discard from block/blk-lib.c */
 static void __submit_discard_cmd(struct f2fs_sb_info *sbi,
-				struct discard_cmd *dc, bool fstrim)
+						struct discard_policy *dpolicy,
+						struct discard_cmd *dc)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
-	struct list_head *wait_list = fstrim ? &(dcc->fstrim_list) :
-							&(dcc->wait_list);
+	struct list_head *wait_list = (dpolicy->type == DPOLICY_FSTRIM) ?
+					&(dcc->fstrim_list) : &(dcc->wait_list);
 	struct bio *bio = NULL;
-	int flag = dcc->dpolicy.sync ? REQ_SYNC : 0;
+	int flag = dpolicy->sync ? REQ_SYNC : 0;
 
 	if (dc->state != D_PREP)
 		return;
@@ -1086,14 +1087,13 @@ static int __queue_discard_cmd(struct f2fs_sb_info *sbi,
 }
 
 static void __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
-					unsigned int start, unsigned int end,
-					unsigned int granularity)
+					struct discard_policy *dpolicy,
+					unsigned int start, unsigned int end)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	struct discard_cmd *prev_dc = NULL, *next_dc = NULL;
 	struct rb_node **insert_p = NULL, *insert_parent = NULL;
 	struct discard_cmd *dc;
-	struct discard_policy *dpolicy = &dcc->dpolicy;
 	struct blk_plug plug;
 	int issued;
 
@@ -1116,7 +1116,7 @@ static void __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
 	while (dc && dc->lstart <= end) {
 		struct rb_node *node;
 
-		if (dc->len < granularity)
+		if (dc->len < dpolicy->granularity)
 			goto skip;
 
 		if (dc->state != D_PREP) {
@@ -1124,7 +1124,7 @@ static void __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
 			goto skip;
 		}
 
-		__submit_discard_cmd(sbi, dc, true);
+		__submit_discard_cmd(sbi, dpolicy, dc);
 
 		if (++issued >= dpolicy->max_requests) {
 			start = dc->lstart + dc->len;
@@ -1148,54 +1148,39 @@ static void __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
 	mutex_unlock(&dcc->cmd_lock);
 }
 
-static int __issue_discard_cmd(struct f2fs_sb_info *sbi, bool issue_cond)
+static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
+					struct discard_policy *dpolicy)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	struct list_head *pend_list;
 	struct discard_cmd *dc, *tmp;
 	struct blk_plug plug;
-	struct discard_policy *dpolicy = &dcc->dpolicy;
-	int iter = 0, issued = 0;
-	int i;
+	int i, iter = 0, issued = 0;
 	bool io_interrupted = false;
 
 	mutex_lock(&dcc->cmd_lock);
 	f2fs_bug_on(sbi,
 		!__check_rb_tree_consistence(sbi, &dcc->root));
 	blk_start_plug(&plug);
-	for (i = MAX_PLIST_NUM - 1;
-			i >= 0 && plist_issue(dcc->pend_list_tag[i]); i--) {
+	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
+		if (i + 1 < dpolicy->granularity)
+			break;
 		pend_list = &dcc->pend_list[i];
 		list_for_each_entry_safe(dc, tmp, pend_list, list) {
 			f2fs_bug_on(sbi, dc->state != D_PREP);
 
-			/* Hurry up to finish fstrim */
-			if (dcc->pend_list_tag[i] & P_TRIM) {
-				__submit_discard_cmd(sbi, dc, false);
-				issued++;
-				continue;
-			}
-
-			if (!issue_cond) {
-				__submit_discard_cmd(sbi, dc, false);
-				issued++;
-				continue;
-			}
-
 			if (dpolicy->io_aware && i < dpolicy->io_aware_gran &&
 								!is_idle(sbi)) {
 				io_interrupted = true;
 				goto skip;
 			}
 
-			__submit_discard_cmd(sbi, dc, false);
+			__submit_discard_cmd(sbi, dpolicy, dc);
 			issued++;
 skip:
 			if (++iter >= dpolicy->max_requests)
 				goto out;
 		}
-		if (list_empty(pend_list) && dcc->pend_list_tag[i] & P_TRIM)
-			dcc->pend_list_tag[i] &= (~P_TRIM);
 	}
 out:
 	blk_finish_plug(&plug);
@@ -1239,14 +1224,13 @@ static void __wait_one_discard_bio(struct f2fs_sb_info *sbi,
 	mutex_unlock(&dcc->cmd_lock);
 }
 
-static void __wait_discard_cmd_range(struct f2fs_sb_info *sbi, bool wait_cond,
-						block_t start, block_t end,
-						unsigned int granularity,
-						bool fstrim)
+static void __wait_discard_cmd_range(struct f2fs_sb_info *sbi,
+						struct discard_policy *dpolicy,
+						block_t start, block_t end)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
-	struct list_head *wait_list = fstrim ? &(dcc->fstrim_list) :
-							&(dcc->wait_list);
+	struct list_head *wait_list = (dpolicy->type == DPOLICY_FSTRIM) ?
+					&(dcc->fstrim_list) : &(dcc->wait_list);
 	struct discard_cmd *dc, *tmp;
 	bool need_wait;
 
@@ -1257,9 +1241,9 @@ static void __wait_discard_cmd_range(struct f2fs_sb_info *sbi, bool wait_cond,
 	list_for_each_entry_safe(dc, tmp, wait_list, list) {
 		if (dc->lstart + dc->len <= start || end <= dc->lstart)
 			continue;
-		if (dc->len < granularity)
+		if (dc->len < dpolicy->granularity)
 			continue;
-		if (!wait_cond || (dc->state == D_DONE && !dc->ref)) {
+		if (dc->state == D_DONE && !dc->ref) {
 			wait_for_completion_io(&dc->wait);
 			__remove_discard_cmd(sbi, dc);
 		} else {
@@ -1276,9 +1260,10 @@ static void __wait_discard_cmd_range(struct f2fs_sb_info *sbi, bool wait_cond,
 	}
 }
 
-static void __wait_all_discard_cmd(struct f2fs_sb_info *sbi, bool wait_cond)
+static void __wait_all_discard_cmd(struct f2fs_sb_info *sbi,
+						struct discard_policy *dpolicy)
 {
-	__wait_discard_cmd_range(sbi, wait_cond, 0, UINT_MAX, 1, false);
+	__wait_discard_cmd_range(sbi, dpolicy, 0, UINT_MAX);
 }
 
 /* This should be covered by global mutex, &sit_i->sentry_lock */
@@ -1318,21 +1303,14 @@ void stop_discard_thread(struct f2fs_sb_info *sbi)
 
 /* This comes from f2fs_put_super */
 void f2fs_wait_discard_bios(struct f2fs_sb_info *sbi)
-{
-	__issue_discard_cmd(sbi, false);
-	__drop_discard_cmd(sbi);
-	__wait_all_discard_cmd(sbi, false);
-}
-
-static void mark_discard_range_all(struct f2fs_sb_info *sbi)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
-	int i;
+	struct discard_policy dpolicy;
 
-	mutex_lock(&dcc->cmd_lock);
-	for (i = 0; i < MAX_PLIST_NUM; i++)
-		dcc->pend_list_tag[i] |= P_TRIM;
-	mutex_unlock(&dcc->cmd_lock);
+	init_discard_policy(&dpolicy, DPOLICY_UMOUNT, dcc->discard_granularity);
+	__issue_discard_cmd(sbi, &dpolicy);
+	__drop_discard_cmd(sbi);
+	__wait_all_discard_cmd(sbi, &dpolicy);
 }
 
 static int issue_discard_thread(void *data)
@@ -1340,13 +1318,16 @@ static int issue_discard_thread(void *data)
 	struct f2fs_sb_info *sbi = data;
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	wait_queue_head_t *q = &dcc->discard_wait_queue;
-	struct discard_policy *dpolicy = &dcc->dpolicy;
+	struct discard_policy dpolicy;
 	unsigned int wait_ms = DEF_MIN_DISCARD_ISSUE_TIME;
 	int issued;
 
 	set_freezable();
 
 	do {
+		init_discard_policy(&dpolicy, DPOLICY_BG,
+					dcc->discard_granularity);
+
 		wait_event_interruptible_timeout(*q,
 				kthread_should_stop() || freezing(current) ||
 				dcc->discard_wake,
@@ -1359,17 +1340,18 @@ static int issue_discard_thread(void *data)
 		if (dcc->discard_wake) {
 			dcc->discard_wake = 0;
 			if (sbi->gc_thread && sbi->gc_thread->gc_urgent)
-				mark_discard_range_all(sbi);
+				init_discard_policy(&dpolicy,
+							DPOLICY_FORCE, 1);
 		}
 
 		sb_start_intwrite(sbi->sb);
 
-		issued = __issue_discard_cmd(sbi, true);
+		issued = __issue_discard_cmd(sbi, &dpolicy);
 		if (issued) {
-			__wait_all_discard_cmd(sbi, true);
-			wait_ms = dpolicy->min_interval;
+			__wait_all_discard_cmd(sbi, &dpolicy);
+			wait_ms = dpolicy.min_interval;
 		} else {
-			wait_ms = dpolicy->max_interval;
+			wait_ms = dpolicy.max_interval;
 		}
 
 		sb_end_intwrite(sbi->sb);
@@ -1654,16 +1636,35 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	wake_up_discard_thread(sbi, false);
 }
 
-static void inline init_discard_policy(struct discard_cmd_control *dcc)
+void init_discard_policy(struct discard_policy *dpolicy,
+				int discard_type, unsigned int granularity)
 {
-	struct discard_policy *dpolicy = &dcc->dpolicy;
-
-	dpolicy->min_interval = DEF_MIN_DISCARD_ISSUE_TIME;
-	dpolicy->max_interval = DEF_MAX_DISCARD_ISSUE_TIME;
-	dpolicy->max_requests = DEF_MAX_DISCARD_REQUEST;
-	dpolicy->io_aware_gran = MAX_PLIST_NUM;
-	dpolicy->io_aware = true;
+	/* common policy */
+	dpolicy->type = discard_type;
 	dpolicy->sync = true;
+	dpolicy->granularity = granularity;
+
+	if (discard_type == DPOLICY_BG) {
+		dpolicy->min_interval = DEF_MIN_DISCARD_ISSUE_TIME;
+		dpolicy->max_interval = DEF_MAX_DISCARD_ISSUE_TIME;
+		dpolicy->max_requests = DEF_MAX_DISCARD_REQUEST;
+		dpolicy->io_aware_gran = MAX_PLIST_NUM;
+		dpolicy->io_aware = true;
+	} else if (discard_type == DPOLICY_FORCE) {
+		dpolicy->min_interval = DEF_MIN_DISCARD_ISSUE_TIME;
+		dpolicy->max_interval = DEF_MAX_DISCARD_ISSUE_TIME;
+		dpolicy->max_requests = DEF_MAX_DISCARD_REQUEST;
+		dpolicy->io_aware_gran = MAX_PLIST_NUM;
+		dpolicy->io_aware = false;
+	} else if (discard_type == DPOLICY_FSTRIM) {
+		dpolicy->max_requests = DEF_MAX_DISCARD_REQUEST;
+		dpolicy->io_aware_gran = MAX_PLIST_NUM;
+		dpolicy->io_aware = false;
+	} else if (discard_type == DPOLICY_UMOUNT) {
+		dpolicy->max_requests = DEF_MAX_DISCARD_REQUEST;
+		dpolicy->io_aware_gran = MAX_PLIST_NUM;
+		dpolicy->io_aware = false;
+	}
 }
 
 static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
@@ -1683,11 +1684,8 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 
 	dcc->discard_granularity = DEFAULT_DISCARD_GRANULARITY;
 	INIT_LIST_HEAD(&dcc->entry_list);
-	for (i = 0; i < MAX_PLIST_NUM; i++) {
+	for (i = 0; i < MAX_PLIST_NUM; i++)
 		INIT_LIST_HEAD(&dcc->pend_list[i]);
-		if (i >= dcc->discard_granularity - 1)
-			dcc->pend_list_tag[i] |= P_ACTIVE;
-	}
 	INIT_LIST_HEAD(&dcc->wait_list);
 	INIT_LIST_HEAD(&dcc->fstrim_list);
 	mutex_init(&dcc->cmd_lock);
@@ -1699,8 +1697,6 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 	dcc->undiscard_blks = 0;
 	dcc->root = RB_ROOT;
 
-	init_discard_policy(dcc);
-
 	init_waitqueue_head(&dcc->discard_wait_queue);
 	SM_I(sbi)->dcc_info = dcc;
 init_thread:
@@ -2322,6 +2318,7 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 	unsigned int start_segno, end_segno, cur_segno;
 	block_t start_block, end_block;
 	struct cp_control cpc;
+	struct discard_policy dpolicy;
 	int err = 0;
 
 	if (start >= MAX_BLKADDR(sbi) || range->len < sbi->blocksize)
@@ -2375,9 +2372,9 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 	start_block = START_BLOCK(sbi, start_segno);
 	end_block = START_BLOCK(sbi, min(cur_segno, end_segno) + 1);
 
-	__issue_discard_cmd_range(sbi, start_block, end_block, cpc.trim_minlen);
-	__wait_discard_cmd_range(sbi, true, start_block, end_block,
-						cpc.trim_minlen, true);
+	init_discard_policy(&dpolicy, DPOLICY_FSTRIM, cpc.trim_minlen);
+	__issue_discard_cmd_range(sbi, &dpolicy, start_block, end_block);
+	__wait_discard_cmd_range(sbi, &dpolicy, start_block, end_block);
 out:
 	range->len = F2FS_BLK_TO_BYTES(cpc.trimmed);
 	return err;
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index e0a6cc23ace3..5a1f7b9c8a72 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -796,8 +796,9 @@ static inline void wake_up_discard_thread(struct f2fs_sb_info *sbi, bool force)
 		goto wake_up;
 
 	mutex_lock(&dcc->cmd_lock);
-	for (i = MAX_PLIST_NUM - 1;
-			i >= 0 && plist_issue(dcc->pend_list_tag[i]); i--) {
+	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
+		if (i + 1 < dcc->discard_granularity)
+			break;
 		if (!list_empty(&dcc->pend_list[i])) {
 			wakeup = true;
 			break;
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index bf5829c5e9c6..ca74bfdfd4eb 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -157,23 +157,10 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
 	}
 
 	if (!strcmp(a->attr.name, "discard_granularity")) {
-		struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
-		int i;
-
 		if (t == 0 || t > MAX_PLIST_NUM)
 			return -EINVAL;
 		if (t == *ui)
 			return count;
-
-		mutex_lock(&dcc->cmd_lock);
-		for (i = 0; i < MAX_PLIST_NUM; i++) {
-			if (i >= t - 1)
-				dcc->pend_list_tag[i] |= P_ACTIVE;
-			else
-				dcc->pend_list_tag[i] &= (~P_ACTIVE);
-		}
-		mutex_unlock(&dcc->cmd_lock);
-
 		*ui = t;
 		return count;
 	}
-- 
2.14.1.145.gb3622a4ee


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
