From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5/6] f2fs: add a kernel thread to issue discard
	commands asynchronously
Date: Thu, 12 Jan 2017 14:44:06 -0800
Message-ID: <20170112224407.54026-5-jaegeuk@kernel.org>
References: <20170112224407.54026-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cRo6d-0002zQ-HT
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 12 Jan 2017 22:44:27 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cRo6c-00058f-BJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 12 Jan 2017 22:44:27 +0000
In-Reply-To: <20170112224407.54026-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch adds a kernel thread to issue discard commands.
It proposes three states, D_PREP, D_SUBMIT, and D_DONE to identify current
bio status.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h    |  11 +++++
 fs/f2fs/segment.c | 128 +++++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 108 insertions(+), 31 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e7b403cbd70f..ef5e3709c161 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -129,6 +129,7 @@ enum {
 };
 
 #define MAX_DISCARD_BLOCKS(sbi) (1 << (sbi)->log_blocks_per_seg)
+#define DISCARD_ISSUE_RATE	8
 #define DEF_CP_INTERVAL			60	/* 60 secs */
 #define DEF_IDLE_INTERVAL		5	/* 5 secs */
 
@@ -177,18 +178,28 @@ struct discard_entry {
 	int len;		/* # of consecutive blocks of the discard */
 };
 
+enum {
+	D_PREP,
+	D_SUBMIT,
+	D_DONE,
+};
+
 struct discard_cmd {
 	struct list_head list;		/* command list */
 	struct completion wait;		/* compleation */
 	block_t lstart;			/* logical start address */
 	block_t len;			/* length */
 	struct bio *bio;		/* bio */
+	int state;			/* state */
 };
 
 struct discard_cmd_control {
+	struct task_struct *f2fs_issue_discard;	/* discard thread */
 	struct list_head discard_entry_list;	/* 4KB discard entry list */
 	int nr_discards;			/* # of discards in the list */
 	struct list_head discard_cmd_list;	/* discard cmd list */
+	wait_queue_head_t discard_wait_queue;	/* waiting queue for wake-up */
+	struct mutex cmd_lock;
 	int max_discards;			/* max. discards to be issued */
 };
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index e3bec31de961..74364006bfa6 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -628,7 +628,7 @@ static void locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno)
 	mutex_unlock(&dirty_i->seglist_lock);
 }
 
-static struct discard_cmd *__add_discard_cmd(struct f2fs_sb_info *sbi,
+static void __add_discard_cmd(struct f2fs_sb_info *sbi,
 			struct bio *bio, block_t lstart, block_t len)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
@@ -638,12 +638,30 @@ static struct discard_cmd *__add_discard_cmd(struct f2fs_sb_info *sbi,
 	dc = f2fs_kmem_cache_alloc(discard_cmd_slab, GFP_NOFS);
 	INIT_LIST_HEAD(&dc->list);
 	dc->bio = bio;
+	bio->bi_private = dc;
 	dc->lstart = lstart;
 	dc->len = len;
+	dc->state = D_PREP;
 	init_completion(&dc->wait);
+
+	mutex_lock(&dcc->cmd_lock);
 	list_add_tail(&dc->list, cmd_list);
+	mutex_unlock(&dcc->cmd_lock);
+}
+
+static void __remove_discard_cmd(struct f2fs_sb_info *sbi, struct discard_cmd *dc)
+{
+	int err = dc->bio->bi_error;
 
-	return dc;
+	if (err == -EOPNOTSUPP)
+		err = 0;
+
+	if (err)
+		f2fs_msg(sbi->sb, KERN_INFO,
+				"Issue discard failed, ret: %d", err);
+	bio_put(dc->bio);
+	list_del(&dc->list);
+	kmem_cache_free(discard_cmd_slab, dc);
 }
 
 /* This should be covered by global mutex, &sit_i->sentry_lock */
@@ -653,31 +671,28 @@ void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
 	struct list_head *wait_list = &(dcc->discard_cmd_list);
 	struct discard_cmd *dc, *tmp;
 
+	mutex_lock(&dcc->cmd_lock);
 	list_for_each_entry_safe(dc, tmp, wait_list, list) {
-		struct bio *bio = dc->bio;
-		int err;
 
-		if (!completion_done(&dc->wait)) {
-			if ((dc->lstart <= blkaddr &&
-					blkaddr < dc->lstart + dc->len) ||
-					blkaddr == NULL_ADDR)
+		if (blkaddr == NULL_ADDR) {
+			if (dc->state == D_PREP) {
+				dc->state = D_SUBMIT;
+				submit_bio(dc->bio);
+			}
+			wait_for_completion_io(&dc->wait);
+
+			__remove_discard_cmd(sbi, dc);
+			continue;
+		}
+
+		if (dc->lstart <= blkaddr && blkaddr < dc->lstart + dc->len) {
+			if (dc->state == D_SUBMIT)
 				wait_for_completion_io(&dc->wait);
 			else
-				continue;
+				__remove_discard_cmd(sbi, dc);
 		}
-
-		err = bio->bi_error;
-		if (err == -EOPNOTSUPP)
-			err = 0;
-
-		if (err)
-			f2fs_msg(sbi->sb, KERN_INFO,
-				"Issue discard failed, ret: %d", err);
-
-		bio_put(bio);
-		list_del(&dc->list);
-		kmem_cache_free(discard_cmd_slab, dc);
 	}
+	mutex_unlock(&dcc->cmd_lock);
 }
 
 static void f2fs_submit_discard_endio(struct bio *bio)
@@ -685,8 +700,48 @@ static void f2fs_submit_discard_endio(struct bio *bio)
 	struct discard_cmd *dc = (struct discard_cmd *)bio->bi_private;
 
 	complete(&dc->wait);
+	dc->state = D_DONE;
 }
 
+static int issue_discard_thread(void *data)
+{
+	struct f2fs_sb_info *sbi = data;
+	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
+	wait_queue_head_t *q = &dcc->discard_wait_queue;
+	struct list_head *cmd_list = &dcc->discard_cmd_list;
+	struct discard_cmd *dc, *tmp;
+	struct blk_plug plug;
+	int iter = 0;
+repeat:
+	if (kthread_should_stop())
+		return 0;
+
+	blk_start_plug(&plug);
+
+	mutex_lock(&dcc->cmd_lock);
+	list_for_each_entry_safe(dc, tmp, cmd_list, list) {
+		if (dc->state == D_PREP) {
+			dc->state = D_SUBMIT;
+			submit_bio(dc->bio);
+			if (iter++ > DISCARD_ISSUE_RATE)
+				break;
+		} else if (dc->state == D_DONE) {
+			__remove_discard_cmd(sbi, dc);
+		}
+	}
+	mutex_unlock(&dcc->cmd_lock);
+
+	blk_finish_plug(&plug);
+
+	iter = 0;
+	congestion_wait(BLK_RW_SYNC, HZ/50);
+
+	wait_event_interruptible(*q,
+		kthread_should_stop() || !list_empty(&dcc->discard_cmd_list));
+	goto repeat;
+}
+
+
 /* this function is copied from blkdev_issue_discard from block/blk-lib.c */
 static int __f2fs_issue_discard_async(struct f2fs_sb_info *sbi,
 		struct block_device *bdev, block_t blkstart, block_t blklen)
@@ -707,13 +762,11 @@ static int __f2fs_issue_discard_async(struct f2fs_sb_info *sbi,
 				SECTOR_FROM_BLOCK(blklen),
 				GFP_NOFS, 0, &bio);
 	if (!err && bio) {
-		struct discard_cmd *dc = __add_discard_cmd(sbi, bio,
-						lblkstart, blklen);
-
-		bio->bi_private = dc;
 		bio->bi_end_io = f2fs_submit_discard_endio;
 		bio->bi_opf |= REQ_SYNC;
-		submit_bio(bio);
+
+		__add_discard_cmd(sbi, bio, lblkstart, blklen);
+		wake_up(&SM_I(sbi)->dcc_info->discard_wait_queue);
 	}
 	return err;
 }
@@ -920,14 +973,11 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	struct list_head *head = &(SM_I(sbi)->dcc_info->discard_entry_list);
 	struct discard_entry *entry, *this;
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
-	struct blk_plug plug;
 	unsigned long *prefree_map = dirty_i->dirty_segmap[PRE];
 	unsigned int start = 0, end = -1;
 	unsigned int secno, start_segno;
 	bool force = (cpc->reason == CP_DISCARD);
 
-	blk_start_plug(&plug);
-
 	mutex_lock(&dirty_i->seglist_lock);
 
 	while (1) {
@@ -980,12 +1030,11 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		SM_I(sbi)->dcc_info->nr_discards -= entry->len;
 		kmem_cache_free(discard_entry_slab, entry);
 	}
-
-	blk_finish_plug(&plug);
 }
 
 int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 {
+	dev_t dev = sbi->sb->s_bdev->bd_dev;
 	struct discard_cmd_control *dcc;
 	int err = 0;
 
@@ -1000,11 +1049,22 @@ int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 
 	INIT_LIST_HEAD(&dcc->discard_entry_list);
 	INIT_LIST_HEAD(&dcc->discard_cmd_list);
+	mutex_init(&dcc->cmd_lock);
 	dcc->nr_discards = 0;
 	dcc->max_discards = 0;
 
+	init_waitqueue_head(&dcc->discard_wait_queue);
 	SM_I(sbi)->dcc_info = dcc;
 init_thread:
+	dcc->f2fs_issue_discard = kthread_run(issue_discard_thread, sbi,
+				"f2fs_discard-%u:%u", MAJOR(dev), MINOR(dev));
+	if (IS_ERR(dcc->f2fs_issue_discard)) {
+		err = PTR_ERR(dcc->f2fs_issue_discard);
+		kfree(dcc);
+		SM_I(sbi)->dcc_info = NULL;
+		return err;
+	}
+
 	return err;
 }
 
@@ -1012,6 +1072,12 @@ void destroy_discard_cmd_control(struct f2fs_sb_info *sbi, bool free)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 
+	if (dcc && dcc->f2fs_issue_discard) {
+		struct task_struct *discard_thread = dcc->f2fs_issue_discard;
+
+		dcc->f2fs_issue_discard = NULL;
+		kthread_stop(discard_thread);
+	}
 	if (free) {
 		kfree(dcc);
 		SM_I(sbi)->dcc_info = NULL;
-- 
2.11.0


------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi
