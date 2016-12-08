From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: fix to access nullified flush_cmd_control
	pointer
Date: Wed,  7 Dec 2016 19:05:55 -0800
Message-ID: <20161208030555.67709-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cEp26-0004HP-Bw
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 08 Dec 2016 03:06:06 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cEp25-0006tl-4o
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 08 Dec 2016 03:06:06 +0000
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

f2fs_sync_file()             remount_ro
 - f2fs_readonly
                               - destroy_flush_cmd_control
 - f2fs_issue_flush
   - no fcc pointer!

So, this patch doesn't free fcc in this case, but just stop its kernel thread
which sends flush commands.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h    |  2 +-
 fs/f2fs/segment.c | 33 +++++++++++++++++++++++++--------
 fs/f2fs/super.c   |  5 +++--
 3 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 35dbab157ec3..137bbf0ae4c6 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2103,7 +2103,7 @@ void f2fs_balance_fs(struct f2fs_sb_info *, bool);
 void f2fs_balance_fs_bg(struct f2fs_sb_info *);
 int f2fs_issue_flush(struct f2fs_sb_info *);
 int create_flush_cmd_control(struct f2fs_sb_info *);
-void destroy_flush_cmd_control(struct f2fs_sb_info *);
+void destroy_flush_cmd_control(struct f2fs_sb_info *, bool);
 void invalidate_blocks(struct f2fs_sb_info *, block_t);
 bool is_checkpointed_data(struct f2fs_sb_info *, block_t);
 void refresh_sit_entry(struct f2fs_sb_info *, block_t, block_t);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8affc5621181..d7d5727fe8b2 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -489,8 +489,13 @@ int f2fs_issue_flush(struct f2fs_sb_info *sbi)
 	if (!fcc->dispatch_list)
 		wake_up(&fcc->flush_wait_queue);
 
-	wait_for_completion(&cmd.wait);
-	atomic_dec(&fcc->submit_flush);
+	if (fcc->f2fs_issue_flush) {
+		wait_for_completion(&cmd.wait);
+		atomic_dec(&fcc->submit_flush);
+	} else {
+		llist_del_all(&fcc->issue_list);
+		atomic_set(&fcc->submit_flush, 0);
+	}
 
 	return cmd.ret;
 }
@@ -501,6 +506,11 @@ int create_flush_cmd_control(struct f2fs_sb_info *sbi)
 	struct flush_cmd_control *fcc;
 	int err = 0;
 
+	if (SM_I(sbi)->cmd_control_info) {
+		fcc = SM_I(sbi)->cmd_control_info;
+		goto init_thread;
+	}
+
 	fcc = kzalloc(sizeof(struct flush_cmd_control), GFP_KERNEL);
 	if (!fcc)
 		return -ENOMEM;
@@ -508,6 +518,7 @@ int create_flush_cmd_control(struct f2fs_sb_info *sbi)
 	init_waitqueue_head(&fcc->flush_wait_queue);
 	init_llist_head(&fcc->issue_list);
 	SM_I(sbi)->cmd_control_info = fcc;
+init_thread:
 	fcc->f2fs_issue_flush = kthread_run(issue_flush_thread, sbi,
 				"f2fs_flush-%u:%u", MAJOR(dev), MINOR(dev));
 	if (IS_ERR(fcc->f2fs_issue_flush)) {
@@ -520,14 +531,20 @@ int create_flush_cmd_control(struct f2fs_sb_info *sbi)
 	return err;
 }
 
-void destroy_flush_cmd_control(struct f2fs_sb_info *sbi)
+void destroy_flush_cmd_control(struct f2fs_sb_info *sbi, bool free)
 {
 	struct flush_cmd_control *fcc = SM_I(sbi)->cmd_control_info;
 
-	if (fcc && fcc->f2fs_issue_flush)
-		kthread_stop(fcc->f2fs_issue_flush);
-	kfree(fcc);
-	SM_I(sbi)->cmd_control_info = NULL;
+	if (fcc && fcc->f2fs_issue_flush) {
+		struct task_struct *flush_thread = fcc->f2fs_issue_flush;
+
+		fcc->f2fs_issue_flush = NULL;
+		kthread_stop(flush_thread);
+	}
+	if (free) {
+		kfree(fcc);
+		SM_I(sbi)->cmd_control_info = NULL;
+	}
 }
 
 static void __locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
@@ -2738,7 +2755,7 @@ void destroy_segment_manager(struct f2fs_sb_info *sbi)
 
 	if (!sm_info)
 		return;
-	destroy_flush_cmd_control(sbi);
+	destroy_flush_cmd_control(sbi, true);
 	destroy_dirty_segmap(sbi);
 	destroy_curseg(sbi);
 	destroy_free_segmap(sbi);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1a526474b332..b62c10d28e06 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1102,8 +1102,9 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	 * or if flush_merge is not passed in mount option.
 	 */
 	if ((*flags & MS_RDONLY) || !test_opt(sbi, FLUSH_MERGE)) {
-		destroy_flush_cmd_control(sbi);
-	} else if (!SM_I(sbi)->cmd_control_info) {
+		clear_opt(sbi, FLUSH_MERGE);
+		destroy_flush_cmd_control(sbi, false);
+	} else {
 		err = create_flush_cmd_control(sbi);
 		if (err)
 			goto restore_gc;
-- 
2.11.0


------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today.http://sdm.link/xeonphi
