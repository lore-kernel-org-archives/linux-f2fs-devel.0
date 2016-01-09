From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: introduce time and interval facility
Date: Fri,  8 Jan 2016 17:29:22 -0800
Message-ID: <1452302963-23312-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

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
index ae0007d..603266c 100644
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
+	return jiffies > sbi->last_time[type] + interval;
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
