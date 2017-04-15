From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/3] f2fs: in prior to issue big discard
Date: Sat, 15 Apr 2017 14:09:37 +0800
Message-ID: <20170415060938.43694-2-yuchao0@huawei.com>
References: <20170415060938.43694-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1czGuS-0006DL-Bv
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 15 Apr 2017 06:10:12 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187]
	helo=dggrg01-dlp.huawei.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1czGuO-0000OD-AE
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 15 Apr 2017 06:10:12 +0000
In-Reply-To: <20170415060938.43694-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Keep issuing big size discard in prior instead of the one with random
size, so that we expect that it will help to:
- be quick to recycle unused large space in flash storage device.
- give a chance for
  a) wait to merge small piece discards into bigger one, or
  b) avoid issuing discards while they have being reallocated by SSR.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h    |  7 ++++++-
 fs/f2fs/segment.c | 54 +++++++++++++++++++++++++++++++++++++++---------------
 2 files changed, 45 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index bc32c1b8ad67..bd3519059ae8 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -188,6 +188,11 @@ struct discard_entry {
 	unsigned char discard_map[SIT_VBLOCK_MAP_SIZE];	/* segment discard bitmap */
 };
 
+/* max discard pend list number */
+#define MAX_PLIST_NUM		512
+#define plist_idx(blk_num)	((blk_num) >= MAX_PLIST_NUM ?		\
+					(MAX_PLIST_NUM - 1) : (blk_num - 1))
+
 enum {
 	D_PREP,
 	D_SUBMIT,
@@ -221,7 +226,7 @@ struct discard_cmd {
 struct discard_cmd_control {
 	struct task_struct *f2fs_issue_discard;	/* discard thread */
 	struct list_head entry_list;		/* 4KB discard entry list */
-	struct list_head pend_list;		/* store pending entries */
+	struct list_head pend_list[MAX_PLIST_NUM];/* store pending entries */
 	struct list_head wait_list;		/* store on-flushing entries */
 	wait_queue_head_t discard_wait_queue;	/* waiting queue for wake-up */
 	struct mutex cmd_lock;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 84648a716b01..8a2fa3076df5 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -677,9 +677,13 @@ static struct discard_cmd *__create_discard_cmd(struct f2fs_sb_info *sbi,
 		block_t start, block_t len)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
-	struct list_head *pend_list = &(dcc->pend_list);
+	struct list_head *pend_list;
 	struct discard_cmd *dc;
 
+	f2fs_bug_on(sbi, !len);
+
+	pend_list = &dcc->pend_list[plist_idx(len)];
+
 	dc = f2fs_kmem_cache_alloc(discard_cmd_slab, GFP_NOFS);
 	INIT_LIST_HEAD(&dc->list);
 	dc->bdev = bdev;
@@ -806,9 +810,16 @@ static struct discard_cmd *__insert_discard_tree(struct f2fs_sb_info *sbi,
 	return dc;
 }
 
+static void __relocate_discard_cmd(struct discard_cmd_control *dcc,
+						struct discard_cmd *dc)
+{
+	list_move_tail(&dc->list, &dcc->pend_list[plist_idx(dc->len)]);
+}
+
 static void __punch_discard_cmd(struct f2fs_sb_info *sbi,
 				struct discard_cmd *dc, block_t blkaddr)
 {
+	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	struct discard_info di = dc->di;
 	bool modified = false;
 
@@ -819,6 +830,7 @@ static void __punch_discard_cmd(struct f2fs_sb_info *sbi,
 
 	if (blkaddr > di.lstart) {
 		dc->len = blkaddr - dc->lstart;
+		__relocate_discard_cmd(dcc, dc);
 		modified = true;
 	}
 
@@ -832,6 +844,7 @@ static void __punch_discard_cmd(struct f2fs_sb_info *sbi,
 			dc->lstart++;
 			dc->len--;
 			dc->start++;
+			__relocate_discard_cmd(dcc, dc);
 		}
 	}
 }
@@ -890,6 +903,7 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
 			prev_dc->bdev == bdev &&
 			__is_discard_back_mergeable(&di, &prev_dc->di)) {
 			prev_dc->di.len += di.len;
+			__relocate_discard_cmd(dcc, prev_dc);
 			di = prev_dc->di;
 			tdc = prev_dc;
 			merged = true;
@@ -901,6 +915,7 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
 			next_dc->di.lstart = di.lstart;
 			next_dc->di.len += di.len;
 			next_dc->di.start = di.start;
+			__relocate_discard_cmd(dcc, next_dc);
 			if (tdc)
 				__remove_discard_cmd(sbi, tdc);
 
@@ -961,16 +976,20 @@ void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
 void f2fs_wait_discard_bios(struct f2fs_sb_info *sbi)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
-	struct list_head *pend_list = &(dcc->pend_list);
+	struct list_head *pend_list;
 	struct list_head *wait_list = &(dcc->wait_list);
 	struct discard_cmd *dc, *tmp;
 	struct blk_plug plug;
+	int i;
 
 	mutex_lock(&dcc->cmd_lock);
 
 	blk_start_plug(&plug);
-	list_for_each_entry_safe(dc, tmp, pend_list, list)
-		__submit_discard_cmd(sbi, dc);
+	for (i = 0; i < MAX_PLIST_NUM; i++) {
+		pend_list = &dcc->pend_list[i];
+		list_for_each_entry_safe(dc, tmp, pend_list, list)
+			__submit_discard_cmd(sbi, dc);
+	}
 	blk_finish_plug(&plug);
 
 	list_for_each_entry_safe(dc, tmp, wait_list, list) {
@@ -986,26 +1005,30 @@ static int issue_discard_thread(void *data)
 	struct f2fs_sb_info *sbi = data;
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	wait_queue_head_t *q = &dcc->discard_wait_queue;
-	struct list_head *pend_list = &dcc->pend_list;
+	struct list_head *pend_list;
 	struct list_head *wait_list = &dcc->wait_list;
 	struct discard_cmd *dc, *tmp;
 	struct blk_plug plug;
-	int iter = 0;
+	int iter = 0, i;
 repeat:
 	if (kthread_should_stop())
 		return 0;
 
 	mutex_lock(&dcc->cmd_lock);
 	blk_start_plug(&plug);
-	list_for_each_entry_safe(dc, tmp, pend_list, list) {
-		f2fs_bug_on(sbi, dc->state != D_PREP);
+	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
+		pend_list = &dcc->pend_list[i];
+		list_for_each_entry_safe(dc, tmp, pend_list, list) {
+			f2fs_bug_on(sbi, dc->state != D_PREP);
 
-		if (is_idle(sbi))
-			__submit_discard_cmd(sbi, dc);
+			if (is_idle(sbi))
+				__submit_discard_cmd(sbi, dc);
 
-		if (iter++ > DISCARD_ISSUE_RATE)
-			break;
+			if (iter++ > DISCARD_ISSUE_RATE)
+				goto next_step;
+		}
 	}
+next_step:
 	blk_finish_plug(&plug);
 
 	list_for_each_entry_safe(dc, tmp, wait_list, list) {
@@ -1020,7 +1043,7 @@ static int issue_discard_thread(void *data)
 	congestion_wait(BLK_RW_SYNC, HZ/50);
 
 	wait_event_interruptible(*q, kthread_should_stop() ||
-			!list_empty(pend_list) || !list_empty(wait_list));
+				atomic_read(&dcc->discard_cmd_cnt));
 	goto repeat;
 }
 
@@ -1300,7 +1323,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 {
 	dev_t dev = sbi->sb->s_bdev->bd_dev;
 	struct discard_cmd_control *dcc;
-	int err = 0;
+	int err = 0, i;
 
 	if (SM_I(sbi)->dcc_info) {
 		dcc = SM_I(sbi)->dcc_info;
@@ -1312,7 +1335,8 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 		return -ENOMEM;
 
 	INIT_LIST_HEAD(&dcc->entry_list);
-	INIT_LIST_HEAD(&dcc->pend_list);
+	for (i = 0; i < MAX_PLIST_NUM; i++)
+		INIT_LIST_HEAD(&dcc->pend_list[i]);
 	INIT_LIST_HEAD(&dcc->wait_list);
 	mutex_init(&dcc->cmd_lock);
 	atomic_set(&dcc->issued_discard, 0);
-- 
2.12.2.510.ge1104a5ee539


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
