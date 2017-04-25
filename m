From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: introduce __issue_discard_cmd
Date: Tue, 25 Apr 2017 20:21:37 +0800
Message-ID: <20170425122138.53188-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1d2zUK-0001O2-7W
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 25 Apr 2017 12:22:36 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188]
	helo=dggrg02-dlp.huawei.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1d2zUD-0005TB-VO
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 25 Apr 2017 12:22:36 +0000
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

Just cleanup, no logic change.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 63 ++++++++++++++++++++++++++-----------------------------
 1 file changed, 30 insertions(+), 33 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 68a9f8d4d628..57989c2c3a6a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -974,6 +974,32 @@ static int __queue_discard_cmd(struct f2fs_sb_info *sbi,
 	return 0;
 }
 
+static void __issue_discard_cmd(struct f2fs_sb_info *sbi, bool issue_cond)
+{
+	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
+	struct list_head *pend_list;
+	struct discard_cmd *dc, *tmp;
+	struct blk_plug plug;
+	int i, iter = 0;
+
+	mutex_lock(&dcc->cmd_lock);
+	blk_start_plug(&plug);
+	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
+		pend_list = &dcc->pend_list[i];
+		list_for_each_entry_safe(dc, tmp, pend_list, list) {
+			f2fs_bug_on(sbi, dc->state != D_PREP);
+
+			if (!issue_cond || is_idle(sbi))
+				__submit_discard_cmd(sbi, dc);
+			if (issue_cond && iter++ > DISCARD_ISSUE_RATE)
+				goto out;
+		}
+	}
+out:
+	blk_finish_plug(&plug);
+	mutex_unlock(&dcc->cmd_lock);
+}
+
 /* This should be covered by global mutex, &sit_i->sentry_lock */
 void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
 {
@@ -996,27 +1022,16 @@ void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
 void f2fs_wait_discard_bios(struct f2fs_sb_info *sbi)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
-	struct list_head *pend_list;
 	struct list_head *wait_list = &(dcc->wait_list);
 	struct discard_cmd *dc, *tmp;
-	struct blk_plug plug;
-	int i;
 
-	mutex_lock(&dcc->cmd_lock);
-
-	blk_start_plug(&plug);
-	for (i = 0; i < MAX_PLIST_NUM; i++) {
-		pend_list = &dcc->pend_list[i];
-		list_for_each_entry_safe(dc, tmp, pend_list, list)
-			__submit_discard_cmd(sbi, dc);
-	}
-	blk_finish_plug(&plug);
+	__issue_discard_cmd(sbi, false);
 
+	mutex_lock(&dcc->cmd_lock);
 	list_for_each_entry_safe(dc, tmp, wait_list, list) {
 		wait_for_completion_io(&dc->wait);
 		__remove_discard_cmd(sbi, dc);
 	}
-
 	mutex_unlock(&dcc->cmd_lock);
 }
 
@@ -1025,32 +1040,15 @@ static int issue_discard_thread(void *data)
 	struct f2fs_sb_info *sbi = data;
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	wait_queue_head_t *q = &dcc->discard_wait_queue;
-	struct list_head *pend_list;
 	struct list_head *wait_list = &dcc->wait_list;
 	struct discard_cmd *dc, *tmp;
-	struct blk_plug plug;
-	int iter = 0, i;
 repeat:
 	if (kthread_should_stop())
 		return 0;
 
-	mutex_lock(&dcc->cmd_lock);
-	blk_start_plug(&plug);
-	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
-		pend_list = &dcc->pend_list[i];
-		list_for_each_entry_safe(dc, tmp, pend_list, list) {
-			f2fs_bug_on(sbi, dc->state != D_PREP);
-
-			if (is_idle(sbi))
-				__submit_discard_cmd(sbi, dc);
-
-			if (iter++ > DISCARD_ISSUE_RATE)
-				goto next_step;
-		}
-	}
-next_step:
-	blk_finish_plug(&plug);
+	__issue_discard_cmd(sbi, true);
 
+	mutex_lock(&dcc->cmd_lock);
 	list_for_each_entry_safe(dc, tmp, wait_list, list) {
 		if (dc->state == D_DONE) {
 			wait_for_completion_io(&dc->wait);
@@ -1059,7 +1057,6 @@ static int issue_discard_thread(void *data)
 	}
 	mutex_unlock(&dcc->cmd_lock);
 
-	iter = 0;
 	congestion_wait(BLK_RW_SYNC, HZ/50);
 
 	wait_event_interruptible(*q, kthread_should_stop() ||
-- 
2.12.2.510.ge1104a5ee539


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
