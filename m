From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH 7/7] f2fs: introduce help function {create,
	destroy}_flush_cmd_control
Date: Fri, 11 Apr 2014 17:50:10 +0800
Message-ID: <5347BAD2.2040003@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz.fnst@cn.fujitsu.com>) id 1WYYFV-0006AF-4h
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Apr 2014 09:59:53 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WYYFR-0005CW-UN for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Apr 2014 09:59:53 +0000
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

Introduce help function {create,destroy}_flush_cmd_control to clean up
the create/destory flush merge operation.

Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/f2fs.h    |    3 +-
 fs/f2fs/segment.c |   55 ++++++++++++++++++++++++++++++++++++----------------
 fs/f2fs/super.c   |   29 ++-------------------------
 3 files changed, 43 insertions(+), 44 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 780d7e2..863fde5 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1178,8 +1178,9 @@ void destroy_node_manager_caches(void);
  */
 void f2fs_balance_fs(struct f2fs_sb_info *);
 void f2fs_balance_fs_bg(struct f2fs_sb_info *);
-int issue_flush_thread(void *);
 int f2fs_issue_flush(struct f2fs_sb_info *);
+int create_flush_cmd_control(struct f2fs_sb_info *);
+void destroy_flush_cmd_control(struct f2fs_sb_info *);
 void invalidate_blocks(struct f2fs_sb_info *, block_t);
 void refresh_sit_entry(struct f2fs_sb_info *, block_t, block_t);
 void clear_prefree_segments(struct f2fs_sb_info *);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 2f9ead7..8458943 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -197,7 +197,7 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 		f2fs_sync_fs(sbi->sb, true);
 }
 
-int issue_flush_thread(void *data)
+static int issue_flush_thread(void *data)
 {
 	struct f2fs_sb_info *sbi = data;
 	struct flush_cmd_control *fcc_i = SM_I(sbi)->cmd_control_info;
@@ -263,6 +263,41 @@ int f2fs_issue_flush(struct f2fs_sb_info *sbi)
 	return ret;
 }
 
+int create_flush_cmd_control(struct f2fs_sb_info *sbi)
+{
+	dev_t dev = sbi->sb->s_bdev->bd_dev;
+	struct flush_cmd_control *fcc_i;
+	int err = 0;
+
+	fcc_i = kzalloc(sizeof(struct flush_cmd_control), GFP_KERNEL);
+	if (!fcc_i)
+		return -ENOMEM;
+	spin_lock_init(&fcc_i->issue_lock);
+	init_waitqueue_head(&fcc_i->flush_wait_queue);
+	fcc_i->f2fs_issue_flush = kthread_run(issue_flush_thread, sbi,
+				"f2fs_flush-%u:%u", MAJOR(dev), MINOR(dev));
+	if (IS_ERR(fcc_i->f2fs_issue_flush)) {
+		err = PTR_ERR(fcc_i->f2fs_issue_flush);
+		kfree(fcc_i);
+		return err;
+	}
+	sbi->sm_info->cmd_control_info = fcc_i;
+
+	return err;
+}
+
+void destroy_flush_cmd_control(struct f2fs_sb_info *sbi)
+{
+	struct flush_cmd_control *fcc_i =
+				sbi->sm_info->cmd_control_info;
+	if (!fcc_i)
+		return;
+
+	if (fcc_i->f2fs_issue_flush)
+		kthread_stop(fcc_i->f2fs_issue_flush);
+	kfree(fcc_i);
+}
+
 static void __locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
 		enum dirty_type dirty_type)
 {
@@ -1831,7 +1866,6 @@ int build_segment_manager(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
-	dev_t dev = sbi->sb->s_bdev->bd_dev;
 	struct f2fs_sm_info *sm_info;
 	int err;
 
@@ -1860,22 +1894,9 @@ int build_segment_manager(struct f2fs_sb_info *sbi)
 	sm_info->max_discards = 0;
 
 	if (test_opt(sbi, FLUSH_MERGE) && !f2fs_readonly(sbi->sb)) {
-		struct flush_cmd_control *fcc_i =
-			kzalloc(sizeof(struct flush_cmd_control), GFP_KERNEL);
-
-		if (!fcc_i)
-			return -ENOMEM;
-		spin_lock_init(&fcc_i->issue_lock);
-		init_waitqueue_head(&fcc_i->flush_wait_queue);
-
-		fcc_i->f2fs_issue_flush = kthread_run(issue_flush_thread, sbi,
-				"f2fs_flush-%u:%u", MAJOR(dev), MINOR(dev));
-		if (IS_ERR(fcc_i->f2fs_issue_flush)) {
-			err = PTR_ERR(fcc_i->f2fs_issue_flush);
-			kfree(fcc_i);
+		err = create_flush_cmd_control(sbi);
+		if (err)
 			return err;
-		}
-		sm_info->cmd_control_info = fcc_i;
 	}
 
 	err = build_sit_info(sbi);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 4d562fb..b2b1863 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -641,35 +641,12 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	 * or if flush_merge is not passed in mount option.
 	 */
 	if ((*flags & MS_RDONLY) || !test_opt(sbi, FLUSH_MERGE)) {
-		struct flush_cmd_control *fcc_i =
-					sbi->sm_info->cmd_control_info;
-
-		if (fcc_i) {
-			if (fcc_i->f2fs_issue_flush)
-				kthread_stop(fcc_i->f2fs_issue_flush);
-			fcc_i->issue_list = fcc_i->dispatch_list = NULL;
-			fcc_i->f2fs_issue_flush = NULL;
-		}
+		destroy_flush_cmd_control(sbi);
 	} else if (test_opt(sbi, FLUSH_MERGE) &&
 					!sbi->sm_info->cmd_control_info) {
-		dev_t dev = sbi->sb->s_bdev->bd_dev;
-		struct flush_cmd_control *fcc_i =
-			kzalloc(sizeof(struct flush_cmd_control), GFP_KERNEL);
-
-		if (!fcc_i) {
-			err = -ENOMEM;
-			goto restore_gc;
-		}
-		spin_lock_init(&fcc_i->issue_lock);
-		init_waitqueue_head(&fcc_i->flush_wait_queue);
-		fcc_i->f2fs_issue_flush = kthread_run(issue_flush_thread, sbi,
-				"f2fs_flush-%u:%u", MAJOR(dev), MINOR(dev));
-		if (IS_ERR(fcc_i->f2fs_issue_flush)) {
-			err = PTR_ERR(fcc_i->f2fs_issue_flush);
-			kfree(fcc_i);
+		err = create_flush_cmd_control(sbi);
+		if (err)
 			goto restore_gc;
-		}
-		sbi->sm_info->cmd_control_info = fcc_i;
 	}
 skip:
 	/* Update the POSIXACL Flag */
-- 
1.7.7



------------------------------------------------------------------------------
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test & Deployment 
Start a new project now. Try Jenkins in the cloud.
http://p.sf.net/sfu/13600_Cloudbees
