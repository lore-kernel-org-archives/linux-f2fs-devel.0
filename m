From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH 4/7] f2fs: enable flush_merge only in f2fs is not
	read-only
Date: Fri, 11 Apr 2014 17:49:55 +0800
Message-ID: <5347BAC3.3090608@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz.fnst@cn.fujitsu.com>) id 1WYYF5-0003wP-8N
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Apr 2014 09:59:27 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WYYF4-00049E-A2 for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Apr 2014 09:59:27 +0000
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

Enable flush_merge only in f2fs is not read-only, so does the mount
option show.

Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/segment.c |    3 +--
 fs/f2fs/super.c   |    4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index ff8f987..6672570 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1858,10 +1858,9 @@ int build_segment_manager(struct f2fs_sb_info *sbi)
 	sm_info->nr_discards = 0;
 	sm_info->max_discards = 0;
 
-	if (test_opt(sbi, FLUSH_MERGE)) {
+	if (test_opt(sbi, FLUSH_MERGE) && !f2fs_readonly(sbi->sb)) {
 		spin_lock_init(&sm_info->issue_lock);
 		init_waitqueue_head(&sm_info->flush_wait_queue);
-
 		sm_info->f2fs_issue_flush = kthread_run(issue_flush_thread, sbi,
 				"f2fs_flush-%u:%u", MAJOR(dev), MINOR(dev));
 		if (IS_ERR(sm_info->f2fs_issue_flush))
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index c756923..5e20d2a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -514,7 +514,7 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(root->d_sb);
 
-	if (!(root->d_sb->s_flags & MS_RDONLY) && test_opt(sbi, BG_GC))
+	if (!f2fs_readonly(sbi->sb) && test_opt(sbi, BG_GC))
 		seq_printf(seq, ",background_gc=%s", "on");
 	else
 		seq_printf(seq, ",background_gc=%s", "off");
@@ -542,7 +542,7 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_puts(seq, ",disable_ext_identify");
 	if (test_opt(sbi, INLINE_DATA))
 		seq_puts(seq, ",inline_data");
-	if (test_opt(sbi, FLUSH_MERGE))
+	if (!f2fs_readonly(sbi->sb) && test_opt(sbi, FLUSH_MERGE))
 		seq_puts(seq, ",flush_merge");
 	seq_printf(seq, ",active_logs=%u", sbi->active_logs);
 
-- 
1.7.7


------------------------------------------------------------------------------
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test & Deployment 
Start a new project now. Try Jenkins in the cloud.
http://p.sf.net/sfu/13600_Cloudbees
