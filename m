From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH 5/7] f2fs: add the flush_merge handle in the
	remount flow
Date: Fri, 11 Apr 2014 17:50:00 +0800
Message-ID: <5347BAC8.8090600@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz.fnst@cn.fujitsu.com>) id 1WYYFB-0002xd-CB
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Apr 2014 09:59:33 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WYYF7-00049E-Ln for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Apr 2014 09:59:33 +0000
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

Add the *remount* handle of flush_merge option, so that the users
can enable flush_merge in the runtime, such as the underlying device
handles the cache_flush command relatively slowly.

Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/f2fs.h    |    1 +
 fs/f2fs/segment.c |    2 +-
 fs/f2fs/super.c   |   45 +++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 90109fa..1130f9c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1174,6 +1174,7 @@ void destroy_node_manager_caches(void);
  */
 void f2fs_balance_fs(struct f2fs_sb_info *);
 void f2fs_balance_fs_bg(struct f2fs_sb_info *);
+int issue_flush_thread(void *);
 int f2fs_issue_flush(struct f2fs_sb_info *);
 void invalidate_blocks(struct f2fs_sb_info *, block_t);
 void refresh_sit_entry(struct f2fs_sb_info *, block_t, block_t);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6672570..5c30255 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -197,7 +197,7 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 		f2fs_sync_fs(sbi->sb, true);
 }
 
-static int issue_flush_thread(void *data)
+int issue_flush_thread(void *data)
 {
 	struct f2fs_sb_info *sbi = data;
 	struct f2fs_sm_info *sm_i = SM_I(sbi);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 5e20d2a..bea642a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -594,6 +594,8 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 	struct f2fs_mount_info org_mount_opt;
 	int err, active_logs;
+	bool need_restart_gc = false;
+	bool need_stop_gc = false;
 
 	sync_filesystem(sb);
 
@@ -611,7 +613,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 
 	/*
 	 * Previous and new state of filesystem is RO,
-	 * so no point in checking GC conditions.
+	 * so skip checking GC and FLUSH_MERGE conditions.
 	 */
 	if ((sb->s_flags & MS_RDONLY) && (*flags & MS_RDONLY))
 		goto skip;
@@ -625,18 +627,57 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		if (sbi->gc_thread) {
 			stop_gc_thread(sbi);
 			f2fs_sync_fs(sb, 1);
+			need_restart_gc = true;
 		}
 	} else if (test_opt(sbi, BG_GC) && !sbi->gc_thread) {
 		err = start_gc_thread(sbi);
 		if (err)
 			goto restore_opts;
+		need_stop_gc = true;
+	}
+
+	/*
+	 * We stop issue flush thread if FS is mounted as RO
+	 * or if flush_merge is not passed in mount option.
+	 */
+	if ((*flags & MS_RDONLY) || !test_opt(sbi, FLUSH_MERGE)) {
+		struct f2fs_sm_info *sm_info = sbi->sm_info;
+
+		if (sm_info->f2fs_issue_flush)
+			kthread_stop(sm_info->f2fs_issue_flush);
+		sm_info->issue_list = sm_info->dispatch_list = NULL;
+		sm_info->f2fs_issue_flush = NULL;
+	} else if (test_opt(sbi, FLUSH_MERGE)) {
+		struct f2fs_sm_info *sm_info = sbi->sm_info;
+
+		if (!sm_info->f2fs_issue_flush) {
+			dev_t dev = sbi->sb->s_bdev->bd_dev;
+
+			spin_lock_init(&sm_info->issue_lock);
+			init_waitqueue_head(&sm_info->flush_wait_queue);
+			sm_info->f2fs_issue_flush =
+				kthread_run(issue_flush_thread, sbi,
+				"f2fs_flush-%u:%u", MAJOR(dev), MINOR(dev));
+			if (IS_ERR(sm_info->f2fs_issue_flush)) {
+				err = PTR_ERR(sm_info->f2fs_issue_flush);
+				sm_info->f2fs_issue_flush = NULL;
+				goto restore_gc;
+			}
+		}
 	}
 skip:
 	/* Update the POSIXACL Flag */
 	 sb->s_flags = (sb->s_flags & ~MS_POSIXACL) |
 		(test_opt(sbi, POSIX_ACL) ? MS_POSIXACL : 0);
 	return 0;
-
+restore_gc:
+	if (need_restart_gc) {
+		if (start_gc_thread(sbi))
+			f2fs_msg(sbi->sb, KERN_WARNING,
+				"background gc thread is stop");
+	} else if (need_stop_gc) {
+		stop_gc_thread(sbi);
+	}
 restore_opts:
 	sbi->mount_opt = org_mount_opt;
 	sbi->active_logs = active_logs;
-- 
1.7.7


------------------------------------------------------------------------------
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test & Deployment 
Start a new project now. Try Jenkins in the cloud.
http://p.sf.net/sfu/13600_Cloudbees
