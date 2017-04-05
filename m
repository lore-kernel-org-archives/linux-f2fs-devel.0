From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v3 1/4] f2fs: split discard_cmd_list
Date: Wed, 5 Apr 2017 18:19:48 +0800
Message-ID: <20170405101949.59292-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cvi30-0003kp-TD
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 05 Apr 2017 10:20:18 +0000
Received: from [45.249.212.189] (helo=dggrg03-dlp.huawei.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cvi2z-0000eg-6M
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 05 Apr 2017 10:20:18 +0000
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

Split discard_cmd_list to discard_{pend,wait}_list, so while sending/waiting
discard command, we can avoid traversing unneeded entries in original list.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
v3: handle discard command correctly in f2fs_wait_discard_bio
 fs/f2fs/f2fs.h    |  3 ++-
 fs/f2fs/segment.c | 47 ++++++++++++++++++++++++++++++-----------------
 2 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6fbdcac01d9a..68e55bd6b50e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -210,7 +210,8 @@ struct discard_cmd_control {
 	struct task_struct *f2fs_issue_discard;	/* discard thread */
 	struct list_head discard_entry_list;	/* 4KB discard entry list */
 	int nr_discards;			/* # of discards in the list */
-	struct list_head discard_cmd_list;	/* discard cmd list */
+	struct list_head discard_pend_list;	/* store pending entries */
+	struct list_head discard_wait_list;	/* store on-flushing entries */
 	wait_queue_head_t discard_wait_queue;	/* waiting queue for wake-up */
 	struct mutex cmd_lock;
 	int max_discards;			/* max. discards to be issued */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index c5f0075764bf..07dddcb0d03d 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -670,7 +670,7 @@ static void __add_discard_cmd(struct f2fs_sb_info *sbi,
 		block_t start, block_t len)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
-	struct list_head *cmd_list = &(dcc->discard_cmd_list);
+	struct list_head *pend_list = &(dcc->discard_pend_list);
 	struct discard_cmd *dc;
 
 	dc = f2fs_kmem_cache_alloc(discard_cmd_slab, GFP_NOFS);
@@ -684,7 +684,7 @@ static void __add_discard_cmd(struct f2fs_sb_info *sbi,
 	init_completion(&dc->wait);
 
 	mutex_lock(&dcc->cmd_lock);
-	list_add_tail(&dc->list, cmd_list);
+	list_add_tail(&dc->list, pend_list);
 	mutex_unlock(&dcc->cmd_lock);
 }
 
@@ -736,6 +736,7 @@ static void __submit_discard_cmd(struct f2fs_sb_info *sbi,
 			bio->bi_end_io = f2fs_submit_discard_endio;
 			bio->bi_opf |= REQ_SYNC;
 			submit_bio(bio);
+			list_move_tail(&dc->list, &dcc->discard_wait_list);
 		}
 	} else {
 		__remove_discard_cmd(sbi, dc);
@@ -782,31 +783,37 @@ static void __punch_discard_cmd(struct f2fs_sb_info *sbi,
 void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
-	struct list_head *wait_list = &(dcc->discard_cmd_list);
+	struct list_head *pend_list = &(dcc->discard_pend_list);
+	struct list_head *wait_list = &(dcc->discard_wait_list);
 	struct discard_cmd *dc, *tmp;
 	struct blk_plug plug;
 
 	mutex_lock(&dcc->cmd_lock);
 
-	blk_start_plug(&plug);
-
-	list_for_each_entry_safe(dc, tmp, wait_list, list) {
+	if (blkaddr == NULL_ADDR)
+		goto release_discard;
 
-		if (blkaddr == NULL_ADDR) {
-			__submit_discard_cmd(sbi, dc);
-			continue;
-		}
+	list_for_each_entry_safe(dc, tmp, pend_list, list) {
+		if (dc->lstart <= blkaddr && blkaddr < dc->lstart + dc->len)
+			__punch_discard_cmd(sbi, dc, blkaddr);
+	}
 
+	list_for_each_entry_safe(dc, tmp, wait_list, list) {
 		if (dc->lstart <= blkaddr && blkaddr < dc->lstart + dc->len) {
 			if (dc->state == D_SUBMIT)
 				wait_for_completion_io(&dc->wait);
 			__punch_discard_cmd(sbi, dc, blkaddr);
 		}
 	}
-	blk_finish_plug(&plug);
 
+release_discard:
 	/* this comes from f2fs_put_super */
 	if (blkaddr == NULL_ADDR) {
+		blk_start_plug(&plug);
+		list_for_each_entry_safe(dc, tmp, pend_list, list)
+			__submit_discard_cmd(sbi, dc);
+		blk_finish_plug(&plug);
+
 		list_for_each_entry_safe(dc, tmp, wait_list, list) {
 			wait_for_completion_io(&dc->wait);
 			__remove_discard_cmd(sbi, dc);
@@ -820,7 +827,8 @@ static int issue_discard_thread(void *data)
 	struct f2fs_sb_info *sbi = data;
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	wait_queue_head_t *q = &dcc->discard_wait_queue;
-	struct list_head *cmd_list = &dcc->discard_cmd_list;
+	struct list_head *pend_list = &dcc->discard_pend_list;
+	struct list_head *wait_list = &dcc->discard_wait_list;
 	struct discard_cmd *dc, *tmp;
 	struct blk_plug plug;
 	int iter = 0;
@@ -831,13 +839,17 @@ static int issue_discard_thread(void *data)
 	blk_start_plug(&plug);
 
 	mutex_lock(&dcc->cmd_lock);
-	list_for_each_entry_safe(dc, tmp, cmd_list, list) {
+	list_for_each_entry_safe(dc, tmp, pend_list, list) {
+		f2fs_bug_on(sbi, dc->state != D_PREP);
 
 		if (is_idle(sbi))
 			__submit_discard_cmd(sbi, dc);
 
-		if (dc->state == D_PREP && iter++ > DISCARD_ISSUE_RATE)
+		if (iter++ > DISCARD_ISSUE_RATE)
 			break;
+	}
+
+	list_for_each_entry_safe(dc, tmp, wait_list, list) {
 		if (dc->state == D_DONE)
 			__remove_discard_cmd(sbi, dc);
 	}
@@ -848,8 +860,8 @@ static int issue_discard_thread(void *data)
 	iter = 0;
 	congestion_wait(BLK_RW_SYNC, HZ/50);
 
-	wait_event_interruptible(*q,
-		kthread_should_stop() || !list_empty(&dcc->discard_cmd_list));
+	wait_event_interruptible(*q, kthread_should_stop() ||
+			!list_empty(pend_list) || !list_empty(wait_list));
 	goto repeat;
 }
 
@@ -1133,7 +1145,8 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 		return -ENOMEM;
 
 	INIT_LIST_HEAD(&dcc->discard_entry_list);
-	INIT_LIST_HEAD(&dcc->discard_cmd_list);
+	INIT_LIST_HEAD(&dcc->discard_pend_list);
+	INIT_LIST_HEAD(&dcc->discard_wait_list);
 	mutex_init(&dcc->cmd_lock);
 	atomic_set(&dcc->submit_discard, 0);
 	dcc->nr_discards = 0;
-- 
2.12.2.510.ge1104a5ee539


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
