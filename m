From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v4] f2fs: introduce discard_granularity sysfs entry
Date: Tue, 15 Aug 2017 10:54:45 -0700
Message-ID: <20170815175445.GB4293@jaegeuk-macbookpro.roam.corp.google.com>
References: <20170807150956.9433-1-chao@kernel.org>
 <20170815034518.GA94478@jaegeuk-macbookpro.roam.corp.google.com>
 <085f08d4-1f46-6bd5-b81e-a09b51499267@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <085f08d4-1f46-6bd5-b81e-a09b51499267@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 08/15, Chao Yu wrote:
> On 2017/8/15 11:45, Jaegeuk Kim wrote:
> > On 08/07, Chao Yu wrote:
> >> From: Chao Yu <yuchao0@huawei.com>
> >>
> >> Commit d618ebaf0aa8 ("f2fs: enable small discard by default") enables
> >> f2fs to issue 4K size discard in real-time discard mode. However, issuing
> >> smaller discard may cost more lifetime but releasing less free space in
> >> flash device. Since f2fs has ability of separating hot/cold data and
> >> garbage collection, we can expect that small-sized invalid region would
> >> expand soon with OPU, deletion or garbage collection on valid datas, so
> >> it's better to delay or skip issuing smaller size discards, it could help
> >> to reduce overmuch consumption of IO bandwidth and lifetime of flash
> >> storage.
> >>
> >> This patch makes f2fs selectng 64K size as its default minimal
> >> granularity, and issue discard with the size which is not smaller than
> >> minimal granularity. Also it exposes discard granularity as sysfs entry
> >> for configuration in different scenario.
> > 
> > Hi Chao,
> > 
> > I'd like to change the default value to 1 in order to keep the original
> > behavior, since we must avoid performance fluctuation after this single
> > patch. Instead, you probably can change the value through sysfs.
> 
> As I know, in fragmented filesystem space, there are may dozens of thousand
> discard, in scenario of cellphone user are using, 30% is above 64K size, but
> occupy 75% space of all undiscard space, so I changed discard_granularity to 64K
> just to release bulk space in device. For other small-sized discards, I expect
> that they may extend and cross the granularity threshold soon, and fstrim of
> android could cover them in the night.

Yup, I thought that, but this patch prevents fstrim from issuing small discards
due to the granularity check. And, low-end device likes to issue small discards
much more. How about this?

>From a0f38a8574a35995ba9e9e81ae5138919bb672a8 Mon Sep 17 00:00:00 2001
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

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-f2fs |  9 +++++++
 fs/f2fs/f2fs.h                          |  9 +++++++
 fs/f2fs/segment.c                       | 43 +++++++++++++++++++++++++++++++--
 fs/f2fs/sysfs.c                         | 23 ++++++++++++++++++
 4 files changed, 82 insertions(+), 2 deletions(-)

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
index e252e5bf9791..336021b9b93e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -196,11 +196,18 @@ struct discard_entry {
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
@@ -236,11 +243,13 @@ struct discard_cmd_control {
 	struct task_struct *f2fs_issue_discard;	/* discard thread */
 	struct list_head entry_list;		/* 4KB discard entry list */
 	struct list_head pend_list[MAX_PLIST_NUM];/* store pending entries */
+	unsigned char pend_list_tag[MAX_PLIST_NUM];/* tag for pending entries */
 	struct list_head wait_list;		/* store on-flushing entries */
 	wait_queue_head_t discard_wait_queue;	/* waiting queue for wake-up */
 	struct mutex cmd_lock;
 	unsigned int nr_discards;		/* # of discards in the list */
 	unsigned int max_discards;		/* max. discards to be issued */
+	unsigned int discard_granularity;	/* discard granularity */
 	unsigned int undiscard_blks;		/* # of undiscard blocks */
 	atomic_t issued_discard;		/* # of issued discard */
 	atomic_t issing_discard;		/* # of issing discard */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 05144b3a7f62..8c90b69dcd6d 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1028,22 +1028,49 @@ static void __issue_discard_cmd(struct f2fs_sb_info *sbi, bool issue_cond)
 	f2fs_bug_on(sbi,
 		!__check_rb_tree_consistence(sbi, &dcc->root));
 	blk_start_plug(&plug);
-	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
+	for (i = MAX_PLIST_NUM - 1;
+			i >= 0 && plist_issue(dcc->pend_list_tag[i]); i--) {
 		pend_list = &dcc->pend_list[i];
 		list_for_each_entry_safe(dc, tmp, pend_list, list) {
 			f2fs_bug_on(sbi, dc->state != D_PREP);
 
+			/* Hurry up to finish fstrim */
+			if (dcc->pend_list_tag[i] & P_TRIM) {
+				__submit_discard_cmd(sbi, dc);
+				continue;
+			}
+
 			if (!issue_cond || is_idle(sbi))
 				__submit_discard_cmd(sbi, dc);
 			if (issue_cond && iter++ > DISCARD_ISSUE_RATE)
 				goto out;
 		}
+		if (list_empty(pend_list) && dcc->pend_list_tag[i] & P_TRIM)
+			dcc->pend_list_tag[i] &= (~P_TRIM);
 	}
 out:
 	blk_finish_plug(&plug);
 	mutex_unlock(&dcc->cmd_lock);
 }
 
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
+}
+
 static void __wait_one_discard_bio(struct f2fs_sb_info *sbi,
 							struct discard_cmd *dc)
 {
@@ -1126,6 +1153,7 @@ void stop_discard_thread(struct f2fs_sb_info *sbi)
 void f2fs_wait_discard_bios(struct f2fs_sb_info *sbi)
 {
 	__issue_discard_cmd(sbi, false);
+	__drop_discard_cmd(sbi);
 	__wait_discard_cmd(sbi, false);
 }
 
@@ -1448,9 +1476,13 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
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
@@ -2079,11 +2111,13 @@ bool exist_trim_candidates(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 {
+	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	__u64 start = F2FS_BYTES_TO_BLK(range->start);
 	__u64 end = start + F2FS_BYTES_TO_BLK(range->len) - 1;
 	unsigned int start_segno, end_segno;
 	struct cp_control cpc;
 	int err = 0;
+	int i;
 
 	if (start >= MAX_BLKADDR(sbi) || range->len < sbi->blocksize)
 		return -EINVAL;
@@ -2127,6 +2161,11 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 
 		schedule();
 	}
+	/* It's time to issue all the filed discards */
+	mutex_lock(&dcc->cmd_lock);
+	for (i = 0; i < MAX_PLIST_NUM; i++)
+		dcc->pend_list_tag[i] |= P_TRIM;
+	mutex_unlock(&dcc->cmd_lock);
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
