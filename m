From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH 1/2] f2fs: introduce struct flush_cmd_control to
 wrap the flush_merge fields
Date: Sun, 27 Apr 2014 14:21:21 +0800
Message-ID: <535CA1E1.5060707@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz.fnst@cn.fujitsu.com>) id 1WeIcQ-0002Wv-KR
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 27 Apr 2014 06:31:18 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WeIcO-0003T1-5m for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 27 Apr 2014 06:31:18 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Kim <jaegeuk.kim@samsung.com>
Cc: fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, f2fs <linux-f2fs-devel@lists.sourceforge.net>

Split the flush_merge fields from sm_i, and use the new struct flush_cmd_control
to wrap it, so that we can igonre these fileds if flush_merge is disable, and
it alse can the structs more neat.

Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/f2fs.h    |   17 ++++++++----
 fs/f2fs/segment.c |   69 ++++++++++++++++++++++++++++++++--------------------
 fs/f2fs/super.c   |   42 +++++++++++++++++--------------
 3 files changed, 76 insertions(+), 52 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 97da71d..fa0ec81 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -325,6 +325,15 @@ struct flush_cmd {
 	int ret;
 };
 
+struct flush_cmd_control {
+	struct task_struct *f2fs_issue_flush;	/* flush thread */
+	wait_queue_head_t flush_wait_queue;	/* waiting queue for wake-up */
+	struct flush_cmd *issue_list;		/* list for command issue */
+	struct flush_cmd *dispatch_list;	/* list for command dispatch */
+	spinlock_t issue_lock;			/* for issue list lock */
+	struct flush_cmd *issue_tail;		/* list tail of issue list */
+};
+
 struct f2fs_sm_info {
 	struct sit_info *sit_info;		/* whole segment information */
 	struct free_segmap_info *free_info;	/* free segment information */
@@ -355,12 +364,8 @@ struct f2fs_sm_info {
 	unsigned int min_ipu_util;	/* in-place-update threshold */
 
 	/* for flush command control */
-	struct task_struct *f2fs_issue_flush;	/* flush thread */
-	wait_queue_head_t flush_wait_queue;	/* waiting queue for wake-up */
-	struct flush_cmd *issue_list;		/* list for command issue */
-	struct flush_cmd *dispatch_list;	/* list for command dispatch */
-	spinlock_t issue_lock;			/* for issue list lock */
-	struct flush_cmd *issue_tail;		/* list tail of issue list */
+	struct flush_cmd_control *cmd_control_info;
+
 };
 
 /*
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index f6816e1..86979d7d 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -200,20 +200,20 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 int issue_flush_thread(void *data)
 {
 	struct f2fs_sb_info *sbi = data;
-	struct f2fs_sm_info *sm_i = SM_I(sbi);
-	wait_queue_head_t *q = &sm_i->flush_wait_queue;
+	struct flush_cmd_control *fcc = SM_I(sbi)->cmd_control_info;
+	wait_queue_head_t *q = &fcc->flush_wait_queue;
 repeat:
 	if (kthread_should_stop())
 		return 0;
 
-	spin_lock(&sm_i->issue_lock);
-	if (sm_i->issue_list) {
-		sm_i->dispatch_list = sm_i->issue_list;
-		sm_i->issue_list = sm_i->issue_tail = NULL;
+	spin_lock(&fcc->issue_lock);
+	if (fcc->issue_list) {
+		fcc->dispatch_list = fcc->issue_list;
+		fcc->issue_list = fcc->issue_tail = NULL;
 	}
-	spin_unlock(&sm_i->issue_lock);
+	spin_unlock(&fcc->issue_lock);
 
-	if (sm_i->dispatch_list) {
+	if (fcc->dispatch_list) {
 		struct bio *bio = bio_alloc(GFP_NOIO, 0);
 		struct flush_cmd *cmd, *next;
 		int ret;
@@ -221,22 +221,23 @@ repeat:
 		bio->bi_bdev = sbi->sb->s_bdev;
 		ret = submit_bio_wait(WRITE_FLUSH, bio);
 
-		for (cmd = sm_i->dispatch_list; cmd; cmd = next) {
+		for (cmd = fcc->dispatch_list; cmd; cmd = next) {
 			cmd->ret = ret;
 			next = cmd->next;
 			complete(&cmd->wait);
 		}
 		bio_put(bio);
-		sm_i->dispatch_list = NULL;
+		fcc->dispatch_list = NULL;
 	}
 
-	wait_event_interruptible(*q, kthread_should_stop() || sm_i->issue_list);
+	wait_event_interruptible(*q,
+			kthread_should_stop() || fcc->issue_list);
 	goto repeat;
 }
 
 int f2fs_issue_flush(struct f2fs_sb_info *sbi)
 {
-	struct f2fs_sm_info *sm_i = SM_I(sbi);
+	struct flush_cmd_control *fcc = SM_I(sbi)->cmd_control_info;
 	struct flush_cmd *cmd;
 	int ret;
 
@@ -246,16 +247,16 @@ int f2fs_issue_flush(struct f2fs_sb_info *sbi)
 	cmd = f2fs_kmem_cache_alloc(flush_cmd_slab, GFP_ATOMIC | __GFP_ZERO);
 	init_completion(&cmd->wait);
 
-	spin_lock(&sm_i->issue_lock);
-	if (sm_i->issue_list)
-		sm_i->issue_tail->next = cmd;
+	spin_lock(&fcc->issue_lock);
+	if (fcc->issue_list)
+		fcc->issue_tail->next = cmd;
 	else
-		sm_i->issue_list = cmd;
-	sm_i->issue_tail = cmd;
-	spin_unlock(&sm_i->issue_lock);
+		fcc->issue_list = cmd;
+	fcc->issue_tail = cmd;
+	spin_unlock(&fcc->issue_lock);
 
-	if (!sm_i->dispatch_list)
-		wake_up(&sm_i->flush_wait_queue);
+	if (!fcc->dispatch_list)
+		wake_up(&fcc->flush_wait_queue);
 
 	wait_for_completion(&cmd->wait);
 	ret = cmd->ret;
@@ -1873,12 +1874,22 @@ int build_segment_manager(struct f2fs_sb_info *sbi)
 	sm_info->max_discards = 0;
 
 	if (test_opt(sbi, FLUSH_MERGE) && !f2fs_readonly(sbi->sb)) {
-		spin_lock_init(&sm_info->issue_lock);
-		init_waitqueue_head(&sm_info->flush_wait_queue);
-		sm_info->f2fs_issue_flush = kthread_run(issue_flush_thread, sbi,
+		struct flush_cmd_control *fcc =
+			kzalloc(sizeof(struct flush_cmd_control), GFP_KERNEL);
+
+		if (!fcc)
+			return -ENOMEM;
+		spin_lock_init(&fcc->issue_lock);
+		init_waitqueue_head(&fcc->flush_wait_queue);
+
+		fcc->f2fs_issue_flush = kthread_run(issue_flush_thread, sbi,
 				"f2fs_flush-%u:%u", MAJOR(dev), MINOR(dev));
-		if (IS_ERR(sm_info->f2fs_issue_flush))
-			return PTR_ERR(sm_info->f2fs_issue_flush);
+		if (IS_ERR(fcc->f2fs_issue_flush)) {
+			err = PTR_ERR(fcc->f2fs_issue_flush);
+			kfree(fcc);
+			return err;
+		}
+		sm_info->cmd_control_info = fcc;
 	}
 
 	err = build_sit_info(sbi);
@@ -1987,10 +1998,14 @@ static void destroy_sit_info(struct f2fs_sb_info *sbi)
 void destroy_segment_manager(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_sm_info *sm_info = SM_I(sbi);
+	struct flush_cmd_control *fcc;
+
 	if (!sm_info)
 		return;
-	if (sm_info->f2fs_issue_flush)
-		kthread_stop(sm_info->f2fs_issue_flush);
+	fcc = sm_info->cmd_control_info;
+	if (fcc && fcc->f2fs_issue_flush)
+		kthread_stop(fcc->f2fs_issue_flush);
+	kfree(fcc);
 	destroy_dirty_segmap(sbi);
 	destroy_curseg(sbi);
 	destroy_free_segmap(sbi);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index bea642a..98832ef 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -641,29 +641,33 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	 * or if flush_merge is not passed in mount option.
 	 */
 	if ((*flags & MS_RDONLY) || !test_opt(sbi, FLUSH_MERGE)) {
-		struct f2fs_sm_info *sm_info = sbi->sm_info;
+		struct flush_cmd_control *fcc =
+					sbi->sm_info->cmd_control_info;
 
-		if (sm_info->f2fs_issue_flush)
-			kthread_stop(sm_info->f2fs_issue_flush);
-		sm_info->issue_list = sm_info->dispatch_list = NULL;
-		sm_info->f2fs_issue_flush = NULL;
-	} else if (test_opt(sbi, FLUSH_MERGE)) {
-		struct f2fs_sm_info *sm_info = sbi->sm_info;
+		if (fcc && fcc->f2fs_issue_flush)
+			kthread_stop(fcc->f2fs_issue_flush);
+		kfree(fcc);
+		sbi->sm_info->cmd_control_info = NULL;
+	} else if (test_opt(sbi, FLUSH_MERGE) &&
+					!sbi->sm_info->cmd_control_info) {
+		dev_t dev = sbi->sb->s_bdev->bd_dev;
+		struct flush_cmd_control *fcc =
+			kzalloc(sizeof(struct flush_cmd_control), GFP_KERNEL);
 
-		if (!sm_info->f2fs_issue_flush) {
-			dev_t dev = sbi->sb->s_bdev->bd_dev;
-
-			spin_lock_init(&sm_info->issue_lock);
-			init_waitqueue_head(&sm_info->flush_wait_queue);
-			sm_info->f2fs_issue_flush =
-				kthread_run(issue_flush_thread, sbi,
+		if (!fcc) {
+			err = -ENOMEM;
+			goto restore_gc;
+		}
+		spin_lock_init(&fcc->issue_lock);
+		init_waitqueue_head(&fcc->flush_wait_queue);
+		fcc->f2fs_issue_flush = kthread_run(issue_flush_thread, sbi,
 				"f2fs_flush-%u:%u", MAJOR(dev), MINOR(dev));
-			if (IS_ERR(sm_info->f2fs_issue_flush)) {
-				err = PTR_ERR(sm_info->f2fs_issue_flush);
-				sm_info->f2fs_issue_flush = NULL;
-				goto restore_gc;
-			}
+		if (IS_ERR(fcc->f2fs_issue_flush)) {
+			err = PTR_ERR(fcc->f2fs_issue_flush);
+			kfree(fcc);
+			goto restore_gc;
 		}
+		sbi->sm_info->cmd_control_info = fcc;
 	}
 skip:
 	/* Update the POSIXACL Flag */
-- 
1.7.7


------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
