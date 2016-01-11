From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/2] f2fs: detect idle time depending on user
	behavior
Date: Mon, 11 Jan 2016 15:59:18 -0800
Message-ID: <20160111235918.GA35051@jaegeuk.granlibakkenguest>
References: <1452302963-23312-1-git-send-email-jaegeuk@kernel.org>
	<1452302963-23312-2-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aImMy-0003Yi-Ll
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 11 Jan 2016 23:59:28 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aImMx-0007sl-5n for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 11 Jan 2016 23:59:28 +0000
Content-Disposition: inline
In-Reply-To: <1452302963-23312-2-git-send-email-jaegeuk@kernel.org>
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
 - add more cases

>From d0239e1bf5204d602281f93c01d46bcf3531098d Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Fri, 8 Jan 2016 16:57:48 -0800
Subject: [PATCH] f2fs: detect idle time depending on user behavior

This patch adds last time that user requested filesystem operations.
This information is used to detect whether system is idle or not later.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-f2fs |  6 ++++++
 fs/f2fs/data.c                          |  1 +
 fs/f2fs/dir.c                           |  4 ++++
 fs/f2fs/f2fs.h                          | 15 +++++++++++++++
 fs/f2fs/file.c                          | 12 ++++++++++++
 fs/f2fs/gc.c                            |  1 -
 fs/f2fs/gc.h                            |  8 --------
 fs/f2fs/segment.c                       |  2 +-
 fs/f2fs/super.c                         |  4 ++++
 fs/f2fs/xattr.c                         |  1 +
 10 files changed, 44 insertions(+), 10 deletions(-)

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
index 29bb8dd..faa7495 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -636,6 +636,7 @@ fail:
 	f2fs_put_page(dentry_page, 1);
 out:
 	f2fs_fname_free_filename(&fname);
+	f2fs_update_time(F2FS_I_SB(dir), REQ_TIME);
 	return err;
 }
 
@@ -657,6 +658,7 @@ int f2fs_do_tmpfile(struct inode *inode, struct inode *dir)
 	clear_inode_flag(F2FS_I(inode), FI_NEW_INODE);
 fail:
 	up_write(&F2FS_I(inode)->i_sem);
+	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 	return err;
 }
 
@@ -701,6 +703,8 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	int slots = GET_DENTRY_SLOTS(le16_to_cpu(dentry->name_len));
 	int i;
 
+	f2fs_update_time(F2FS_I_SB(dir), REQ_TIME);
+
 	if (f2fs_has_inline_dentry(dir))
 		return f2fs_delete_inline_entry(dentry, page, dir, inode);
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5bbb6a4..4331b9f 100644
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
 	return time_after(jiffies, sbi->last_time[type] + interval);
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
index ff06827..3d43857 100644
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
@@ -1351,6 +1355,8 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 		return ret;
 
 	set_inode_flag(F2FS_I(inode), FI_ATOMIC_FILE);
+	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
+
 	return 0;
 }
 
@@ -1398,6 +1404,7 @@ static int f2fs_ioc_start_volatile_write(struct file *filp)
 		return ret;
 
 	set_inode_flag(F2FS_I(inode), FI_VOLATILE_FILE);
+	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 	return 0;
 }
 
@@ -1439,6 +1446,7 @@ static int f2fs_ioc_abort_volatile_write(struct file *filp)
 	}
 
 	mnt_drop_write_file(filp);
+	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 	return ret;
 }
 
@@ -1478,6 +1486,7 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 	default:
 		return -EINVAL;
 	}
+	f2fs_update_time(sbi, REQ_TIME);
 	return 0;
 }
 
@@ -1508,6 +1517,7 @@ static int f2fs_ioc_fitrim(struct file *filp, unsigned long arg)
 	if (copy_to_user((struct fstrim_range __user *)arg, &range,
 				sizeof(range)))
 		return -EFAULT;
+	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 	return 0;
 }
 
@@ -1531,6 +1541,7 @@ static int f2fs_ioc_set_encryption_policy(struct file *filp, unsigned long arg)
 				sizeof(policy)))
 		return -EFAULT;
 
+	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 	return f2fs_process_policy(&policy, inode);
 #else
 	return -EOPNOTSUPP;
@@ -1807,6 +1818,7 @@ static int f2fs_ioc_defragment(struct file *filp, unsigned long arg)
 	}
 
 	err = f2fs_defragment_range(sbi, filp, &range);
+	f2fs_update_time(sbi, REQ_TIME);
 	if (err < 0)
 		goto out;
 
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
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 822a8af..0108f48 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -618,5 +618,6 @@ int f2fs_setxattr(struct inode *inode, int index, const char *name,
 	up_write(&F2FS_I(inode)->i_sem);
 	f2fs_unlock_op(sbi);
 
+	f2fs_update_time(sbi, REQ_TIME);
 	return err;
 }
-- 
2.6.3


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
