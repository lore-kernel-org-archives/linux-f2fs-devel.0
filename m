From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: introduce __wait_discard_cmd
Date: Tue, 25 Apr 2017 20:21:38 +0800
Message-ID: <20170425122138.53188-2-yuchao0@huawei.com>
References: <20170425122138.53188-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1d2zUM-0007g7-Ow
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 25 Apr 2017 12:22:38 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188]
	helo=dggrg02-dlp.huawei.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1d2zUL-0000N0-Lw
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 25 Apr 2017 12:22:38 +0000
In-Reply-To: <20170425122138.53188-1-yuchao0@huawei.com>
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
 fs/f2fs/segment.c | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 57989c2c3a6a..c88e7535aede 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1000,6 +1000,22 @@ static void __issue_discard_cmd(struct f2fs_sb_info *sbi, bool issue_cond)
 	mutex_unlock(&dcc->cmd_lock);
 }
 
+static void __wait_discard_cmd(struct f2fs_sb_info *sbi, bool wait_cond)
+{
+	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
+	struct list_head *wait_list = &(dcc->wait_list);
+	struct discard_cmd *dc, *tmp;
+
+	mutex_lock(&dcc->cmd_lock);
+	list_for_each_entry_safe(dc, tmp, wait_list, list) {
+		if (!wait_cond || dc->state == D_DONE) {
+			wait_for_completion_io(&dc->wait);
+			__remove_discard_cmd(sbi, dc);
+		}
+	}
+	mutex_unlock(&dcc->cmd_lock);
+}
+
 /* This should be covered by global mutex, &sit_i->sentry_lock */
 void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
 {
@@ -1021,18 +1037,8 @@ void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
 /* This comes from f2fs_put_super */
 void f2fs_wait_discard_bios(struct f2fs_sb_info *sbi)
 {
-	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
-	struct list_head *wait_list = &(dcc->wait_list);
-	struct discard_cmd *dc, *tmp;
-
 	__issue_discard_cmd(sbi, false);
-
-	mutex_lock(&dcc->cmd_lock);
-	list_for_each_entry_safe(dc, tmp, wait_list, list) {
-		wait_for_completion_io(&dc->wait);
-		__remove_discard_cmd(sbi, dc);
-	}
-	mutex_unlock(&dcc->cmd_lock);
+	__wait_discard_cmd(sbi, false);
 }
 
 static int issue_discard_thread(void *data)
@@ -1040,22 +1046,12 @@ static int issue_discard_thread(void *data)
 	struct f2fs_sb_info *sbi = data;
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	wait_queue_head_t *q = &dcc->discard_wait_queue;
-	struct list_head *wait_list = &dcc->wait_list;
-	struct discard_cmd *dc, *tmp;
 repeat:
 	if (kthread_should_stop())
 		return 0;
 
 	__issue_discard_cmd(sbi, true);
-
-	mutex_lock(&dcc->cmd_lock);
-	list_for_each_entry_safe(dc, tmp, wait_list, list) {
-		if (dc->state == D_DONE) {
-			wait_for_completion_io(&dc->wait);
-			__remove_discard_cmd(sbi, dc);
-		}
-	}
-	mutex_unlock(&dcc->cmd_lock);
+	__wait_discard_cmd(sbi, true);
 
 	congestion_wait(BLK_RW_SYNC, HZ/50);
 
-- 
2.12.2.510.ge1104a5ee539


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
