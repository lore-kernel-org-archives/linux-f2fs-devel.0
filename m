From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH 2/2] f2fs: introduce help function {create,
	destroy}_flush_cmd_control
Date: Sun, 27 Apr 2014 14:21:33 +0800
Message-ID: <535CA1ED.4020600@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz.fnst@cn.fujitsu.com>) id 1WeIcU-0000dM-3i
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 27 Apr 2014 06:31:22 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WeIcS-0003T1-QO for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 27 Apr 2014 06:31:22 +0000
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
 fs/f2fs/segment.c |   60 +++++++++++++++++++++++++++++++++-------------------
 fs/f2fs/super.c   |   27 ++---------------------
 3 files changed, 43 insertions(+), 47 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index fa0ec81..1ca958a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1184,8 +1184,9 @@ void destroy_node_manager_caches(void);
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
index 86979d7d..6f19f8c 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -197,7 +197,7 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 		f2fs_sync_fs(sbi->sb, true);
 }
 
-int issue_flush_thread(void *data)
+static int issue_flush_thread(void *data)
 {
 	struct f2fs_sb_info *sbi = data;
 	struct flush_cmd_control *fcc = SM_I(sbi)->cmd_control_info;
@@ -264,6 +264,40 @@ int f2fs_issue_flush(struct f2fs_sb_info *sbi)
 	return ret;
 }
 
+int create_flush_cmd_control(struct f2fs_sb_info *sbi)
+{
+	dev_t dev = sbi->sb->s_bdev->bd_dev;
+	struct flush_cmd_control *fcc;
+	int err = 0;
+
+	fcc = kzalloc(sizeof(struct flush_cmd_control), GFP_KERNEL);
+	if (!fcc)
+		return -ENOMEM;
+	spin_lock_init(&fcc->issue_lock);
+	init_waitqueue_head(&fcc->flush_wait_queue);
+	fcc->f2fs_issue_flush = kthread_run(issue_flush_thread, sbi,
+				"f2fs_flush-%u:%u", MAJOR(dev), MINOR(dev));
+	if (IS_ERR(fcc->f2fs_issue_flush)) {
+		err = PTR_ERR(fcc->f2fs_issue_flush);
+		kfree(fcc);
+		return err;
+	}
+	sbi->sm_info->cmd_control_info = fcc;
+
+	return err;
+}
+
+void destroy_flush_cmd_control(struct f2fs_sb_info *sbi)
+{
+	struct flush_cmd_control *fcc =
+				sbi->sm_info->cmd_control_info;
+
+	if (fcc && fcc->f2fs_issue_flush)
+		kthread_stop(fcc->f2fs_issue_flush);
+	kfree(fcc);
+	sbi->sm_info->cmd_control_info = NULL;
+}
+
 static void __locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
 		enum dirty_type dirty_type)
 {
@@ -1845,7 +1879,6 @@ int build_segment_manager(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
-	dev_t dev = sbi->sb->s_bdev->bd_dev;
 	struct f2fs_sm_info *sm_info;
 	int err;
 
@@ -1874,22 +1907,9 @@ int build_segment_manager(struct f2fs_sb_info *sbi)
 	sm_info->max_discards = 0;
 
 	if (test_opt(sbi, FLUSH_MERGE) && !f2fs_readonly(sbi->sb)) {
-		struct flush_cmd_control *fcc =
-			kzalloc(sizeof(struct flush_cmd_control), GFP_KERNEL);
-
-		if (!fcc)
-			return -ENOMEM;
-		spin_lock_init(&fcc->issue_lock);
-		init_waitqueue_head(&fcc->flush_wait_queue);
-
-		fcc->f2fs_issue_flush = kthread_run(issue_flush_thread, sbi,
-				"f2fs_flush-%u:%u", MAJOR(dev), MINOR(dev));
-		if (IS_ERR(fcc->f2fs_issue_flush)) {
-			err = PTR_ERR(fcc->f2fs_issue_flush);
-			kfree(fcc);
+		err = create_flush_cmd_control(sbi);
+		if (err)
 			return err;
-		}
-		sm_info->cmd_control_info = fcc;
 	}
 
 	err = build_sit_info(sbi);
@@ -1998,14 +2018,10 @@ static void destroy_sit_info(struct f2fs_sb_info *sbi)
 void destroy_segment_manager(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_sm_info *sm_info = SM_I(sbi);
-	struct flush_cmd_control *fcc;
 
 	if (!sm_info)
 		return;
-	fcc = sm_info->cmd_control_info;
-	if (fcc && fcc->f2fs_issue_flush)
-		kthread_stop(fcc->f2fs_issue_flush);
-	kfree(fcc);
+	destroy_flush_cmd_control(sbi);
 	destroy_dirty_segmap(sbi);
 	destroy_curseg(sbi);
 	destroy_free_segmap(sbi);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 98832ef..b2b1863 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -641,33 +641,12 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	 * or if flush_merge is not passed in mount option.
 	 */
 	if ((*flags & MS_RDONLY) || !test_opt(sbi, FLUSH_MERGE)) {
-		struct flush_cmd_control *fcc =
-					sbi->sm_info->cmd_control_info;
-
-		if (fcc && fcc->f2fs_issue_flush)
-			kthread_stop(fcc->f2fs_issue_flush);
-		kfree(fcc);
-		sbi->sm_info->cmd_control_info = NULL;
+		destroy_flush_cmd_control(sbi);
 	} else if (test_opt(sbi, FLUSH_MERGE) &&
 					!sbi->sm_info->cmd_control_info) {
-		dev_t dev = sbi->sb->s_bdev->bd_dev;
-		struct flush_cmd_control *fcc =
-			kzalloc(sizeof(struct flush_cmd_control), GFP_KERNEL);
-
-		if (!fcc) {
-			err = -ENOMEM;
-			goto restore_gc;
-		}
-		spin_lock_init(&fcc->issue_lock);
-		init_waitqueue_head(&fcc->flush_wait_queue);
-		fcc->f2fs_issue_flush = kthread_run(issue_flush_thread, sbi,
-				"f2fs_flush-%u:%u", MAJOR(dev), MINOR(dev));
-		if (IS_ERR(fcc->f2fs_issue_flush)) {
-			err = PTR_ERR(fcc->f2fs_issue_flush);
-			kfree(fcc);
+		err = create_flush_cmd_control(sbi);
+		if (err)
 			goto restore_gc;
-		}
-		sbi->sm_info->cmd_control_info = fcc;
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
