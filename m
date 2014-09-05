From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH V2] f2fs: use lock-less list(llist) to simplify
	the flush cmd management
Date: Fri,  5 Sep 2014 18:31:00 +0800
Message-ID: <1409913060-883-1-git-send-email-guz.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz@guz>) id 1XPr1S-0002r0-I0
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 05 Sep 2014 10:45:42 +0000
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XPr1O-0005c7-K1
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 05 Sep 2014 10:45:42 +0000
Received: from kw-mxauth.gw.nic.fujitsu.com (unknown [10.0.237.134])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 318963EE1D7
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri,  5 Sep 2014 19:45:32 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
	by kw-mxauth.gw.nic.fujitsu.com (Postfix) with ESMTP id 44957AC09FB
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri,  5 Sep 2014 19:45:29 +0900 (JST)
Received: from s00.gw.fujitsu.co.jp (s00.gw.nic.fujitsu.com [133.161.11.15])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id D428CE0800A
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri,  5 Sep 2014 19:45:28 +0900 (JST)
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
Cc: Gu Zheng <guz.fnst@cn.fujitsu.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

We use flush cmd control to collect many flush cmds, and flush them
together. In this case, we use two list to manage the flush cmds
(collect and dispatch), and one spin lock is used to protect this.
In fact, the lock-less list(llist) is very suitable to this case,
and we use simplify this routine.

---
v2:
-use llist_for_each_entry_safe to fix possible use-after-free issue.
-remove the unused field from struct flush_cmd.
Thanks for Yu's suggestion.
---

Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/f2fs.h    |    8 +++-----
 fs/f2fs/segment.c |   29 +++++++++--------------------
 2 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b389ced..4308bf2 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -338,18 +338,16 @@ enum {
 };
 
 struct flush_cmd {
-	struct flush_cmd *next;
 	struct completion wait;
+	struct llist_node llnode;
 	int ret;
 };
 
 struct flush_cmd_control {
 	struct task_struct *f2fs_issue_flush;	/* flush thread */
 	wait_queue_head_t flush_wait_queue;	/* waiting queue for wake-up */
-	struct flush_cmd *issue_list;		/* list for command issue */
-	struct flush_cmd *dispatch_list;	/* list for command dispatch */
-	spinlock_t issue_lock;			/* for issue list lock */
-	struct flush_cmd *issue_tail;		/* list tail of issue list */
+	struct llist_head issue_list;		/* list for command issue */
+	struct llist_node *dispatch_list;	/* list for command dispatch */
 };
 
 struct f2fs_sm_info {
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 853c8f5..1856da2 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -205,24 +205,20 @@ repeat:
 	if (kthread_should_stop())
 		return 0;
 
-	spin_lock(&fcc->issue_lock);
-	if (fcc->issue_list) {
-		fcc->dispatch_list = fcc->issue_list;
-		fcc->issue_list = fcc->issue_tail = NULL;
-	}
-	spin_unlock(&fcc->issue_lock);
-
-	if (fcc->dispatch_list) {
+	if (!llist_empty(&fcc->issue_list)) {
 		struct bio *bio = bio_alloc(GFP_NOIO, 0);
 		struct flush_cmd *cmd, *next;
 		int ret;
 
+		fcc->dispatch_list = llist_del_all(&fcc->issue_list);
+		fcc->dispatch_list = llist_reverse_order(fcc->dispatch_list);
+
 		bio->bi_bdev = sbi->sb->s_bdev;
 		ret = submit_bio_wait(WRITE_FLUSH, bio);
 
-		for (cmd = fcc->dispatch_list; cmd; cmd = next) {
+		llist_for_each_entry_safe(cmd, next,
+					  fcc->dispatch_list, llnode) {
 			cmd->ret = ret;
-			next = cmd->next;
 			complete(&cmd->wait);
 		}
 		bio_put(bio);
@@ -230,7 +226,7 @@ repeat:
 	}
 
 	wait_event_interruptible(*q,
-			kthread_should_stop() || fcc->issue_list);
+		kthread_should_stop() || !llist_empty(&fcc->issue_list));
 	goto repeat;
 }
 
@@ -249,15 +245,8 @@ int f2fs_issue_flush(struct f2fs_sb_info *sbi)
 		return blkdev_issue_flush(sbi->sb->s_bdev, GFP_KERNEL, NULL);
 
 	init_completion(&cmd.wait);
-	cmd.next = NULL;
 
-	spin_lock(&fcc->issue_lock);
-	if (fcc->issue_list)
-		fcc->issue_tail->next = &cmd;
-	else
-		fcc->issue_list = &cmd;
-	fcc->issue_tail = &cmd;
-	spin_unlock(&fcc->issue_lock);
+	llist_add(&cmd.llnode, &fcc->issue_list);
 
 	if (!fcc->dispatch_list)
 		wake_up(&fcc->flush_wait_queue);
@@ -276,8 +265,8 @@ int create_flush_cmd_control(struct f2fs_sb_info *sbi)
 	fcc = kzalloc(sizeof(struct flush_cmd_control), GFP_KERNEL);
 	if (!fcc)
 		return -ENOMEM;
-	spin_lock_init(&fcc->issue_lock);
 	init_waitqueue_head(&fcc->flush_wait_queue);
+	init_llist_head(&fcc->issue_list);
 	SM_I(sbi)->cmd_control_info = fcc;
 	fcc->f2fs_issue_flush = kthread_run(issue_flush_thread, sbi,
 				"f2fs_flush-%u:%u", MAJOR(dev), MINOR(dev));
-- 
1.7.7


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
