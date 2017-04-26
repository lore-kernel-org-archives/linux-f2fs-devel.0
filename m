From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: don't hold cmd_lock during waiting
	discard command
Date: Wed, 26 Apr 2017 17:39:54 +0800
Message-ID: <20170426093955.48144-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1d3JR3-00073q-S2
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 26 Apr 2017 09:40:33 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188]
	helo=dggrg02-dlp.huawei.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1d3JQz-0001Hg-63
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 26 Apr 2017 09:40:33 +0000
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

Previously, with protection of cmd_lock, we will wait for end io of
discard command which potentially may lead long latency, making worse
concurrency.

So, in this patch, we try to add reference into discard entry to prevent
the entry being released by other thread, then we can avoid holding
global cmd_lock during waiting discard to finish.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h    |  1 +
 fs/f2fs/segment.c | 25 ++++++++++++++++++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 95fb347e7abe..e0c8e0074224 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -219,6 +219,7 @@ struct discard_cmd {
 	struct list_head list;		/* command list */
 	struct completion wait;		/* compleation */
 	struct block_device *bdev;	/* bdev */
+	unsigned short ref;		/* reference count */
 	int state;			/* state */
 	int error;			/* bio error */
 };
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index c95673c54b4e..6a1581ed4ea8 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -689,6 +689,7 @@ static struct discard_cmd *__create_discard_cmd(struct f2fs_sb_info *sbi,
 	dc->lstart = lstart;
 	dc->start = start;
 	dc->len = len;
+	dc->ref = 0;
 	dc->state = D_PREP;
 	dc->error = 0;
 	init_completion(&dc->wait);
@@ -1009,6 +1010,8 @@ static void __wait_discard_cmd(struct f2fs_sb_info *sbi, bool wait_cond)
 	mutex_lock(&dcc->cmd_lock);
 	list_for_each_entry_safe(dc, tmp, wait_list, list) {
 		if (!wait_cond || dc->state == D_DONE) {
+			if (dc->ref)
+				continue;
 			wait_for_completion_io(&dc->wait);
 			__remove_discard_cmd(sbi, dc);
 		}
@@ -1021,17 +1024,29 @@ void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	struct discard_cmd *dc;
+	bool need_wait = false;
 
 	mutex_lock(&dcc->cmd_lock);
-
 	dc = (struct discard_cmd *)__lookup_rb_tree(&dcc->root, NULL, blkaddr);
 	if (dc) {
-		if (dc->state != D_PREP)
-			wait_for_completion_io(&dc->wait);
-		__punch_discard_cmd(sbi, dc, blkaddr);
+		if (dc->state == D_PREP) {
+			__punch_discard_cmd(sbi, dc, blkaddr);
+		} else {
+			dc->ref++;
+			need_wait = true;
+		}
 	}
-
 	mutex_unlock(&dcc->cmd_lock);
+
+	if (need_wait) {
+		wait_for_completion_io(&dc->wait);
+		mutex_lock(&dcc->cmd_lock);
+		f2fs_bug_on(sbi, dc->state != D_DONE);
+		dc->ref--;
+		if (!dc->ref)
+			__remove_discard_cmd(sbi, dc);
+		mutex_unlock(&dcc->cmd_lock);
+	}
 }
 
 /* This comes from f2fs_put_super */
-- 
2.12.2.510.ge1104a5ee539


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
