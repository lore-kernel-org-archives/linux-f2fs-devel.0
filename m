From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: detect idle time depending on user behavior
Date: Fri,  8 Jan 2016 17:29:23 -0800
Message-ID: <1452302963-23312-2-git-send-email-jaegeuk@kernel.org>
References: <1452302963-23312-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452302963-23312-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch adds last time that user requested filesystem operations.
This information is used to detect whether system is idle or not later.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-f2fs |  6 ++++++
 fs/f2fs/data.c                          |  1 +
 fs/f2fs/dir.c                           |  3 +++
 fs/f2fs/f2fs.h                          | 15 +++++++++++++++
 fs/f2fs/file.c                          |  4 ++++
 fs/f2fs/gc.c                            |  1 -
 fs/f2fs/gc.h                            |  8 --------
 fs/f2fs/segment.c                       |  2 +-
 fs/f2fs/super.c                         |  4 ++++
 9 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 0345f2d..e5200f3 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -87,6 +87,12 @@ Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
 Description:
 		 Controls the checkpoint timing.
 
+What:		/sys/fs/f2fs/<disk>/idle_interval
+Date:		January 2016
+Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
+Description:
+		 Controls the idle timing.
+
 What:		/sys/fs/f2fs/<disk>/ra_nid_pages
 Date:		October 2015
 Contact:	"Chao Yu" <chao2.yu@samsung.com>
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a3bce12..ac9e7c6 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1596,6 +1596,7 @@ static int f2fs_write_end(struct file *file,
 	}
 
 	f2fs_put_page(page, 1);
+	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 	return copied;
 }
 
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 29bb8dd..216dd87 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -636,6 +636,7 @@ fail:
 	f2fs_put_page(dentry_page, 1);
 out:
 	f2fs_fname_free_filename(&fname);
+	f2fs_update_time(F2FS_I_SB(dir), REQ_TIME);
 	return err;
 }
 
@@ -701,6 +702,8 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	int slots = GET_DENTRY_SLOTS(le16_to_cpu(dentry->name_len));
 	int i;
 
+	f2fs_update_time(F2FS_I_SB(dir), REQ_TIME);
+
 	if (f2fs_has_inline_dentry(dir))
 		return f2fs_delete_inline_entry(dentry, page, dir, inode);
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 603266c..ef6e666 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -21,6 +21,7 @@
 #include <linux/sched.h>
 #include <linux/vmalloc.h>
 #include <linux/bio.h>
+#include <linux/blkdev.h>
 
 #ifdef CONFIG_F2FS_CHECK_FS
 #define f2fs_bug_on(sbi, condition)	BUG_ON(condition)
@@ -126,6 +127,7 @@ enum {
 #define BATCHED_TRIM_BLOCKS(sbi)	\
 		(BATCHED_TRIM_SEGMENTS(sbi) << (sbi)->log_blocks_per_seg)
 #define DEF_CP_INTERVAL			60	/* 60 secs */
+#define DEF_IDLE_INTERVAL		120	/* 2 mins */
 
 struct cp_control {
 	int reason;
@@ -723,6 +725,7 @@ enum {
 
 enum {
 	CP_TIME,
+	REQ_TIME,
 	MAX_TIME,
 };
 
@@ -856,6 +859,18 @@ static inline bool f2fs_time_over(struct f2fs_sb_info *sbi, int type)
 	return jiffies > sbi->last_time[type] + interval;
 }
 
+static inline bool is_idle(struct f2fs_sb_info *sbi)
+{
+	struct block_device *bdev = sbi->sb->s_bdev;
+	struct request_queue *q = bdev_get_queue(bdev);
+	struct request_list *rl = &q->root_rl;
+
+	if (rl->count[BLK_RW_SYNC] || rl->count[BLK_RW_ASYNC])
+		return 0;
+
+	return f2fs_time_over(sbi, REQ_TIME);
+}
+
 /*
  * Inline functions
  */
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ff06827..dfaed51 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -96,6 +96,7 @@ mapped:
 	clear_cold_data(page);
 out:
 	sb_end_pagefault(inode->i_sb);
+	f2fs_update_time(sbi, REQ_TIME);
 	return block_page_mkwrite_return(err);
 }
 
@@ -280,6 +281,7 @@ flush_out:
 	remove_ino_entry(sbi, ino, UPDATE_INO);
 	clear_inode_flag(fi, FI_UPDATE_WRITE);
 	ret = f2fs_issue_flush(sbi);
+	f2fs_update_time(sbi, REQ_TIME);
 out:
 	trace_f2fs_sync_file_exit(inode, need_cp, datasync, ret);
 	f2fs_trace_ios(NULL, 1);
@@ -485,6 +487,7 @@ int truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 	}
 	dn->ofs_in_node = ofs;
 
+	f2fs_update_time(sbi, REQ_TIME);
 	trace_f2fs_truncate_data_blocks_range(dn->inode, dn->nid,
 					 dn->ofs_in_node, nr_free);
 	return nr_free;
@@ -1236,6 +1239,7 @@ static long f2fs_fallocate(struct file *file, int mode,
 	if (!ret) {
 		inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 		mark_inode_dirty(inode);
+		f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 	}
 
 out:
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index c09be33..f610c2a 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -16,7 +16,6 @@
 #include <linux/kthread.h>
 #include <linux/delay.h>
 #include <linux/freezer.h>
-#include <linux/blkdev.h>
 
 #include "f2fs.h"
 #include "node.h"
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index b4a65be..a993967 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -100,11 +100,3 @@ static inline bool has_enough_invalid_blocks(struct f2fs_sb_info *sbi)
 		return true;
 	return false;
 }
-
-static inline int is_idle(struct f2fs_sb_info *sbi)
-{
-	struct block_device *bdev = sbi->sb->s_bdev;
-	struct request_queue *q = bdev_get_queue(bdev);
-	struct request_list *rl = &q->root_rl;
-	return !(rl->count[BLK_RW_SYNC]) && !(rl->count[BLK_RW_ASYNC]);
-}
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index fed23d5..d8ad1ab 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -293,7 +293,7 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 	if (!available_free_memory(sbi, NAT_ENTRIES) ||
 			excess_prefree_segs(sbi) ||
 			!available_free_memory(sbi, INO_ENTRIES) ||
-			f2fs_time_over(sbi, CP_TIME)) {
+			(is_idle(sbi) && f2fs_time_over(sbi, CP_TIME))) {
 		if (test_opt(sbi, DATA_FLUSH))
 			sync_dirty_inodes(sbi, FILE_INODE);
 		f2fs_sync_fs(sbi->sb, true);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 787047f..3bf990b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -219,6 +219,7 @@ F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, ra_nid_pages, ra_nid_pages);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, max_victim_search, max_victim_search);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, dir_level, dir_level);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, cp_interval, interval_time[CP_TIME]);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, idle_interval, interval_time[REQ_TIME]);
 
 #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
 static struct attribute *f2fs_attrs[] = {
@@ -237,6 +238,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(ram_thresh),
 	ATTR_LIST(ra_nid_pages),
 	ATTR_LIST(cp_interval),
+	ATTR_LIST(idle_interval),
 	NULL,
 };
 
@@ -1123,6 +1125,7 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 
 	sbi->dir_level = DEF_DIR_LEVEL;
 	sbi->interval_time[CP_TIME] = DEF_CP_INTERVAL;
+	sbi->interval_time[REQ_TIME] = DEF_IDLE_INTERVAL;
 	clear_sbi_flag(sbi, SBI_NEED_FSCK);
 
 	INIT_LIST_HEAD(&sbi->s_list);
@@ -1468,6 +1471,7 @@ try_onemore:
 	}
 
 	f2fs_update_time(sbi, CP_TIME);
+	f2fs_update_time(sbi, REQ_TIME);
 	return 0;
 
 free_kobj:
-- 
2.6.3
