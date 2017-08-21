From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v4] f2fs: introduce discard_granularity sysfs entry
Date: Mon, 21 Aug 2017 13:42:36 -0700
Message-ID: <20170821204236.GA66826@jaegeuk-macbookpro.roam.corp.google.com>
References: <20170807150956.9433-1-chao@kernel.org>
 <20170815034518.GA94478@jaegeuk-macbookpro.roam.corp.google.com>
 <085f08d4-1f46-6bd5-b81e-a09b51499267@huawei.com>
 <20170815175445.GB4293@jaegeuk-macbookpro.roam.corp.google.com>
 <0bb733a8-5f86-950f-9474-edde718b1546@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0bb733a8-5f86-950f-9474-edde718b1546@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>
Cc: Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 08/18, Chao Yu wrote:
> Hi Jaegeuk,
> 
> Sorry for the delay, the modification looks good to me. ;)

We must avoid waking up discard thread caused by # of pending commands
which are never issued.

>From a73f8807248c2f42328a2204eab16a3b8d32c83e Mon Sep 17 00:00:00 2001
From: Chao Yu <yuchao0@huawei.com>
Date: Mon, 7 Aug 2017 23:09:56 +0800
Subject: [PATCH] f2fs: introduce discard_granularity sysfs entry

Commit d618ebaf0aa8 ("f2fs: enable small discard by default") enables
f2fs to issue 4K size discard in real-time discard mode. However, issuing
smaller discard may cost more lifetime but releasing less free space in
flash device. Since f2fs has ability of separating hot/cold data and
garbage collection, we can expect that small-sized invalid region would
expand soon with OPU, deletion or garbage collection on valid datas, so
it's better to delay or skip issuing smaller size discards, it could help
to reduce overmuch consumption of IO bandwidth and lifetime of flash
storage.

This patch makes f2fs selectng 64K size as its default minimal
granularity, and issue discard with the size which is not smaller than
minimal granularity. Also it exposes discard granularity as sysfs entry
for configuration in different scenario.

Jaegeuk Kim:
 We must issue all the accumulated discard commands when fstrim is called.
 So, I've added pend_list_tag[] to indicate whether we should issue the
 commands or not. If tag sets P_ACTIVE or P_TRIM, we have to issue them.
 P_TRIM is set once at a time, given fstrim trigger.
 In addition, issue_discard_thread is calling too much due to the number of
 discard commands remaining in the pending list. I added a timer to control
 it likewise gc_thread.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-f2fs |  9 ++++
 fs/f2fs/f2fs.h                          | 12 +++++
 fs/f2fs/segment.c                       | 91 ++++++++++++++++++++++++++++-----
 fs/f2fs/sysfs.c                         | 23 +++++++++
 4 files changed, 121 insertions(+), 14 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 621da3fc56c5..11b7f4ebea7c 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -57,6 +57,15 @@ Contact:	"Jaegeuk Kim" <jaegeuk.kim@samsung.com>
 Description:
 		 Controls the issue rate of small discard commands.
 
+What:          /sys/fs/f2fs/<disk>/discard_granularity
+Date:          July 2017
+Contact:       "Chao Yu" <yuchao0@huawei.com>
+Description:
+		Controls discard granularity of inner discard thread, inner thread
+		will not issue discards with size that is smaller than granularity.
+		The unit size is one block, now only support configuring in range
+		of [1, 512].
+
 What:		/sys/fs/f2fs/<disk>/max_victim_search
 Date:		January 2014
 Contact:	"Jaegeuk Kim" <jaegeuk.kim@samsung.com>
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e252e5bf9791..4b993961d81d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -148,6 +148,8 @@ enum {
 		(BATCHED_TRIM_SEGMENTS(sbi) << (sbi)->log_blocks_per_seg)
 #define MAX_DISCARD_BLOCKS(sbi)		BLKS_PER_SEC(sbi)
 #define DISCARD_ISSUE_RATE		8
+#define DEF_MIN_DISCARD_ISSUE_TIME	50	/* 50 ms, if exists */
+#define DEF_MAX_DISCARD_ISSUE_TIME	60000	/* 60 s, if no candidates */
 #define DEF_CP_INTERVAL			60	/* 60 secs */
 #define DEF_IDLE_INTERVAL		5	/* 5 secs */
 
@@ -196,11 +198,18 @@ struct discard_entry {
 	unsigned char discard_map[SIT_VBLOCK_MAP_SIZE];	/* segment discard bitmap */
 };
 
+/* default discard granularity of inner discard thread, unit: block count */
+#define DEFAULT_DISCARD_GRANULARITY		16
+
 /* max discard pend list number */
 #define MAX_PLIST_NUM		512
 #define plist_idx(blk_num)	((blk_num) >= MAX_PLIST_NUM ?		\
 					(MAX_PLIST_NUM - 1) : (blk_num - 1))
 
+#define P_ACTIVE	0x01
+#define P_TRIM		0x02
+#define plist_issue(tag)	(((tag) & P_ACTIVE) || ((tag) & P_TRIM))
+
 enum {
 	D_PREP,
 	D_SUBMIT,
@@ -236,11 +245,14 @@ struct discard_cmd_control {
 	struct task_struct *f2fs_issue_discard;	/* discard thread */
 	struct list_head entry_list;		/* 4KB discard entry list */
 	struct list_head pend_list[MAX_PLIST_NUM];/* store pending entries */
+	unsigned char pend_list_tag[MAX_PLIST_NUM];/* tag for pending entries */
 	struct list_head wait_list;		/* store on-flushing entries */
 	wait_queue_head_t discard_wait_queue;	/* waiting queue for wake-up */
+	unsigned int discard_wake;		/* to wake up discard thread */
 	struct mutex cmd_lock;
 	unsigned int nr_discards;		/* # of discards in the list */
 	unsigned int max_discards;		/* max. discards to be issued */
+	unsigned int discard_granularity;	/* discard granularity */
 	unsigned int undiscard_blks;		/* # of undiscard blocks */
 	atomic_t issued_discard;		/* # of issued discard */
 	atomic_t issing_discard;		/* # of issing discard */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 05144b3a7f62..1387925a0d83 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1016,32 +1016,65 @@ static int __queue_discard_cmd(struct f2fs_sb_info *sbi,
 	return 0;
 }
 
-static void __issue_discard_cmd(struct f2fs_sb_info *sbi, bool issue_cond)
+static int __issue_discard_cmd(struct f2fs_sb_info *sbi, bool issue_cond)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	struct list_head *pend_list;
 	struct discard_cmd *dc, *tmp;
 	struct blk_plug plug;
-	int i, iter = 0;
+	int iter = 0, issued = 0;
+	int i;
 
 	mutex_lock(&dcc->cmd_lock);
 	f2fs_bug_on(sbi,
 		!__check_rb_tree_consistence(sbi, &dcc->root));
 	blk_start_plug(&plug);
-	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
+	for (i = MAX_PLIST_NUM - 1;
+			i >= 0 && plist_issue(dcc->pend_list_tag[i]); i--) {
 		pend_list = &dcc->pend_list[i];
 		list_for_each_entry_safe(dc, tmp, pend_list, list) {
 			f2fs_bug_on(sbi, dc->state != D_PREP);
 
-			if (!issue_cond || is_idle(sbi))
+			/* Hurry up to finish fstrim */
+			if (dcc->pend_list_tag[i] & P_TRIM) {
+				__submit_discard_cmd(sbi, dc);
+				issued++;
+				continue;
+			}
+
+			if (!issue_cond || is_idle(sbi)) {
+				issued++;
 				__submit_discard_cmd(sbi, dc);
+			}
 			if (issue_cond && iter++ > DISCARD_ISSUE_RATE)
 				goto out;
 		}
+		if (list_empty(pend_list) && dcc->pend_list_tag[i] & P_TRIM)
+			dcc->pend_list_tag[i] &= (~P_TRIM);
 	}
 out:
 	blk_finish_plug(&plug);
 	mutex_unlock(&dcc->cmd_lock);
+
+	return issued;
+}
+
+static void __drop_discard_cmd(struct f2fs_sb_info *sbi)
+{
+	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
+	struct list_head *pend_list;
+	struct discard_cmd *dc, *tmp;
+	int i;
+
+	mutex_lock(&dcc->cmd_lock);
+	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
+		pend_list = &dcc->pend_list[i];
+		list_for_each_entry_safe(dc, tmp, pend_list, list) {
+			f2fs_bug_on(sbi, dc->state != D_PREP);
+			__remove_discard_cmd(sbi, dc);
+		}
+	}
+	mutex_unlock(&dcc->cmd_lock);
 }
 
 static void __wait_one_discard_bio(struct f2fs_sb_info *sbi,
@@ -1126,34 +1159,56 @@ void stop_discard_thread(struct f2fs_sb_info *sbi)
 void f2fs_wait_discard_bios(struct f2fs_sb_info *sbi)
 {
 	__issue_discard_cmd(sbi, false);
+	__drop_discard_cmd(sbi);
 	__wait_discard_cmd(sbi, false);
 }
 
+static void mark_discard_range_all(struct f2fs_sb_info *sbi)
+{
+	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
+	int i;
+
+	mutex_lock(&dcc->cmd_lock);
+	for (i = 0; i < MAX_PLIST_NUM; i++)
+		dcc->pend_list_tag[i] |= P_TRIM;
+	mutex_unlock(&dcc->cmd_lock);
+}
+
 static int issue_discard_thread(void *data)
 {
 	struct f2fs_sb_info *sbi = data;
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	wait_queue_head_t *q = &dcc->discard_wait_queue;
+	unsigned int wait_ms = DEF_MIN_DISCARD_ISSUE_TIME;
+	int issued;
 
 	set_freezable();
 
 	do {
-		wait_event_interruptible(*q, kthread_should_stop() ||
-					freezing(current) ||
-					atomic_read(&dcc->discard_cmd_cnt));
+		wait_event_interruptible_timeout(*q,
+				kthread_should_stop() || freezing(current) ||
+				dcc->discard_wake,
+				msecs_to_jiffies(wait_ms));
 		if (try_to_freeze())
 			continue;
 		if (kthread_should_stop())
 			return 0;
 
+		if (dcc->discard_wake)
+			dcc->discard_wake = 0;
+
 		sb_start_intwrite(sbi->sb);
 
-		__issue_discard_cmd(sbi, true);
-		__wait_discard_cmd(sbi, true);
+		issued = __issue_discard_cmd(sbi, true);
+		if (issued) {
+			__wait_discard_cmd(sbi, true);
+			wait_ms = DEF_MIN_DISCARD_ISSUE_TIME;
+		} else {
+			wait_ms = DEF_MAX_DISCARD_ISSUE_TIME;
+		}
 
 		sb_end_intwrite(sbi->sb);
 
-		congestion_wait(BLK_RW_SYNC, HZ/50);
 	} while (!kthread_should_stop());
 	return 0;
 }
@@ -1344,7 +1399,8 @@ static void set_prefree_as_free_segments(struct f2fs_sb_info *sbi)
 
 void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 {
-	struct list_head *head = &(SM_I(sbi)->dcc_info->entry_list);
+	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
+	struct list_head *head = &dcc->entry_list;
 	struct discard_entry *entry, *this;
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
 	unsigned long *prefree_map = dirty_i->dirty_segmap[PRE];
@@ -1426,11 +1482,12 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 			goto find_next;
 
 		list_del(&entry->list);
-		SM_I(sbi)->dcc_info->nr_discards -= total_len;
+		dcc->nr_discards -= total_len;
 		kmem_cache_free(discard_entry_slab, entry);
 	}
 
-	wake_up(&SM_I(sbi)->dcc_info->discard_wait_queue);
+	dcc->discard_wake = 1;
+	wake_up_interruptible_all(&dcc->discard_wait_queue);
 }
 
 static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
@@ -1448,9 +1505,13 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 	if (!dcc)
 		return -ENOMEM;
 
+	dcc->discard_granularity = DEFAULT_DISCARD_GRANULARITY;
 	INIT_LIST_HEAD(&dcc->entry_list);
-	for (i = 0; i < MAX_PLIST_NUM; i++)
+	for (i = 0; i < MAX_PLIST_NUM; i++) {
 		INIT_LIST_HEAD(&dcc->pend_list[i]);
+		if (i >= dcc->discard_granularity - 1)
+			dcc->pend_list_tag[i] |= P_ACTIVE;
+	}
 	INIT_LIST_HEAD(&dcc->wait_list);
 	mutex_init(&dcc->cmd_lock);
 	atomic_set(&dcc->issued_discard, 0);
@@ -2127,6 +2188,8 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 
 		schedule();
 	}
+	/* It's time to issue all the filed discards */
+	mark_discard_range_all(sbi);
 out:
 	range->len = F2FS_BLK_TO_BYTES(cpc.trimmed);
 	return err;
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index c40e5d24df9f..4bcaa9059026 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -152,6 +152,27 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
 		spin_unlock(&sbi->stat_lock);
 		return count;
 	}
+
+	if (!strcmp(a->attr.name, "discard_granularity")) {
+		struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
+		int i;
+
+		if (t == 0 || t > MAX_PLIST_NUM)
+			return -EINVAL;
+		if (t == *ui)
+			return count;
+
+		mutex_lock(&dcc->cmd_lock);
+		for (i = 0; i < MAX_PLIST_NUM; i++) {
+			if (i >= t - 1)
+				dcc->pend_list_tag[i] |= P_ACTIVE;
+			else
+				dcc->pend_list_tag[i] &= (~P_ACTIVE);
+		}
+		mutex_unlock(&dcc->cmd_lock);
+		return count;
+	}
+
 	*ui = t;
 
 	if (!strcmp(a->attr.name, "iostat_enable") && *ui == 0)
@@ -248,6 +269,7 @@ F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_idle, gc_idle);
 F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_urgent, gc_urgent);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, reclaim_segments, rec_prefree_segments);
 F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, max_small_discards, max_discards);
+F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, discard_granularity, discard_granularity);
 F2FS_RW_ATTR(RESERVED_BLOCKS, f2fs_sb_info, reserved_blocks, reserved_blocks);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, batched_trim_sections, trim_sections);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, ipu_policy, ipu_policy);
@@ -290,6 +312,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(gc_urgent),
 	ATTR_LIST(reclaim_segments),
 	ATTR_LIST(max_small_discards),
+	ATTR_LIST(discard_granularity),
 	ATTR_LIST(batched_trim_sections),
 	ATTR_LIST(ipu_policy),
 	ATTR_LIST(min_ipu_util),
-- 
2.14.0.rc1.383.gd1ce394fe2-goog
