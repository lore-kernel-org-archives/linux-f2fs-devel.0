From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/2] f2fs: introduce time and interval
	facility
Date: Mon, 11 Jan 2016 15:47:51 -0800
Message-ID: <20160111234751.GA34409@jaegeuk.granlibakkenguest>
References: <1452302963-23312-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aImBs-0006fw-0L
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 11 Jan 2016 23:48:00 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aImBq-0004cO-Pu for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 11 Jan 2016 23:47:59 +0000
Content-Disposition: inline
In-Reply-To: <1452302963-23312-1-git-send-email-jaegeuk@kernel.org>
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

Change log from v1:
 - use time_after

>From 6beceb5427aa8731f958d2484e0fd8ff21d604dc Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Fri, 8 Jan 2016 15:51:50 -0800
Subject: [PATCH] f2fs: introduce time and interval facility

This patch adds time and interval arrays to store some timing variables.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c |  2 +-
 fs/f2fs/f2fs.h       | 21 ++++++++++++++++++++-
 fs/f2fs/segment.c    |  2 +-
 fs/f2fs/super.c      |  7 +++----
 4 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 5dbafd5..3842af9 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1139,7 +1139,7 @@ int write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 			"checkpoint: version = %llx", ckpt_ver);
 
 	/* do checkpoint periodically */
-	sbi->cp_expires = round_jiffies_up(jiffies + HZ * sbi->cp_interval);
+	f2fs_update_time(sbi, CP_TIME);
 	trace_f2fs_write_checkpoint(sbi->sb, cpc->reason, "finish checkpoint");
 out:
 	mutex_unlock(&sbi->cp_mutex);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ae0007d..5bbb6a4 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -721,6 +721,11 @@ enum {
 	SBI_POR_DOING,				/* recovery is doing or not */
 };
 
+enum {
+	CP_TIME,
+	MAX_TIME,
+};
+
 struct f2fs_sb_info {
 	struct super_block *sb;			/* pointer to VFS super block */
 	struct proc_dir_entry *s_proc;		/* proc entry */
@@ -747,7 +752,8 @@ struct f2fs_sb_info {
 	struct rw_semaphore node_write;		/* locking node writes */
 	struct mutex writepages;		/* mutex for writepages() */
 	wait_queue_head_t cp_wait;
-	long cp_expires, cp_interval;		/* next expected periodic cp */
+	unsigned long last_time[MAX_TIME];	/* to store time in jiffies */
+	long interval_time[MAX_TIME];		/* to store thresholds */
 
 	struct inode_management im[MAX_INO_ENTRY];      /* manage inode cache */
 
@@ -837,6 +843,19 @@ struct f2fs_sb_info {
 	unsigned int shrinker_run_no;
 };
 
+static inline void f2fs_update_time(struct f2fs_sb_info *sbi, int type)
+{
+	sbi->last_time[type] = jiffies;
+}
+
+static inline bool f2fs_time_over(struct f2fs_sb_info *sbi, int type)
+{
+	struct timespec ts = {sbi->interval_time[type], 0};
+	unsigned long interval = timespec_to_jiffies(&ts);
+
+	return time_after(jiffies, sbi->last_time[type] + interval);
+}
+
 /*
  * Inline functions
  */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index c7bbc91..fed23d5 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -293,7 +293,7 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 	if (!available_free_memory(sbi, NAT_ENTRIES) ||
 			excess_prefree_segs(sbi) ||
 			!available_free_memory(sbi, INO_ENTRIES) ||
-			jiffies > sbi->cp_expires) {
+			f2fs_time_over(sbi, CP_TIME)) {
 		if (test_opt(sbi, DATA_FLUSH))
 			sync_dirty_inodes(sbi, FILE_INODE);
 		f2fs_sync_fs(sbi->sb, true);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f5cc790..787047f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -218,7 +218,7 @@ F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, ram_thresh, ram_thresh);
 F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, ra_nid_pages, ra_nid_pages);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, max_victim_search, max_victim_search);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, dir_level, dir_level);
-F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, cp_interval, cp_interval);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, cp_interval, interval_time[CP_TIME]);
 
 #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
 static struct attribute *f2fs_attrs[] = {
@@ -1122,7 +1122,7 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 		atomic_set(&sbi->nr_pages[i], 0);
 
 	sbi->dir_level = DEF_DIR_LEVEL;
-	sbi->cp_interval = DEF_CP_INTERVAL;
+	sbi->interval_time[CP_TIME] = DEF_CP_INTERVAL;
 	clear_sbi_flag(sbi, SBI_NEED_FSCK);
 
 	INIT_LIST_HEAD(&sbi->s_list);
@@ -1467,8 +1467,7 @@ try_onemore:
 		f2fs_commit_super(sbi, true);
 	}
 
-	sbi->cp_expires = round_jiffies_up(jiffies);
-
+	f2fs_update_time(sbi, CP_TIME);
 	return 0;
 
 free_kobj:
-- 
2.6.3


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
