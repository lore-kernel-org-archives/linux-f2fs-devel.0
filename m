From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/3] f2fs: introduce a periodic checkpoint flow
Date: Mon,  5 Oct 2015 15:44:00 -0700
Message-ID: <1444085040-12843-3-git-send-email-jaegeuk@kernel.org>
References: <1444085040-12843-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZjEUY-0002Ie-Sm
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 05 Oct 2015 22:44:22 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZjEUX-00075y-Vi for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 05 Oct 2015 22:44:22 +0000
In-Reply-To: <1444085040-12843-1-git-send-email-jaegeuk@kernel.org>
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

This patch introduces a periodic checkpoint feature.
Note that, this is not enforcing to conduct checkpoints very strictly in terms
of trigger timing, instead just hope to help user experiences.
The default value is 60 seconds.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 6 ++++++
 fs/f2fs/checkpoint.c                    | 3 +++
 fs/f2fs/f2fs.h                          | 2 ++
 fs/f2fs/segment.c                       | 4 +++-
 fs/f2fs/super.c                         | 3 +++
 5 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 2c4cc42..e066281d 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -80,3 +80,9 @@ Date:		February 2015
 Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
 Description:
 		 Controls the trimming rate in batch mode.
+
+What:		/sys/fs/f2fs/<disk>/cp_interval
+Date:		October 2015
+Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
+Description:
+		 Controls the checkpoint timing.
diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index da5ee7e..70a4780 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1120,6 +1120,9 @@ void write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	if (cpc->reason == CP_RECOVERY)
 		f2fs_msg(sbi->sb, KERN_NOTICE,
 			"checkpoint: version = %llx", ckpt_ver);
+
+	/* do checkpoint periodically */
+	sbi->cp_expires = round_jiffies_up(jiffies + HZ * sbi->cp_interval);
 out:
 	mutex_unlock(&sbi->cp_mutex);
 	trace_f2fs_write_checkpoint(sbi->sb, cpc->reason, "finish checkpoint");
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 00bd470..aad4720 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -124,6 +124,7 @@ enum {
 		(SM_I(sbi)->trim_sections * (sbi)->segs_per_sec)
 #define BATCHED_TRIM_BLOCKS(sbi)	\
 		(BATCHED_TRIM_SEGMENTS(sbi) << (sbi)->log_blocks_per_seg)
+#define DEF_CP_INTERVAL			60	/* 60 secs */
 
 struct cp_control {
 	int reason;
@@ -734,6 +735,7 @@ struct f2fs_sb_info {
 	struct rw_semaphore node_write;		/* locking node writes */
 	struct mutex writepages;		/* mutex for writepages() */
 	wait_queue_head_t cp_wait;
+	long cp_expires, cp_interval;		/* next expected periodic cp */
 
 	struct inode_management im[MAX_INO_ENTRY];      /* manage inode cache */
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6b8edf2..1d86a35 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -15,6 +15,7 @@
 #include <linux/prefetch.h>
 #include <linux/kthread.h>
 #include <linux/swap.h>
+#include <linux/timer.h>
 
 #include "f2fs.h"
 #include "segment.h"
@@ -315,7 +316,8 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 	/* checkpoint is the only way to shrink partial cached entries */
 	if (!available_free_memory(sbi, NAT_ENTRIES) ||
 			excess_prefree_segs(sbi) ||
-			!available_free_memory(sbi, INO_ENTRIES))
+			!available_free_memory(sbi, INO_ENTRIES) ||
+			jiffies > sbi->cp_expires)
 		f2fs_sync_fs(sbi->sb, true);
 }
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index ba058d0..e275634 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -215,6 +215,7 @@ F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_fsync_blocks, min_fsync_blocks);
 F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, ram_thresh, ram_thresh);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, max_victim_search, max_victim_search);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, dir_level, dir_level);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, cp_interval, cp_interval);
 
 #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
 static struct attribute *f2fs_attrs[] = {
@@ -231,6 +232,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(max_victim_search),
 	ATTR_LIST(dir_level),
 	ATTR_LIST(ram_thresh),
+	ATTR_LIST(cp_interval),
 	NULL,
 };
 
@@ -1014,6 +1016,7 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 		atomic_set(&sbi->nr_pages[i], 0);
 
 	sbi->dir_level = DEF_DIR_LEVEL;
+	sbi->cp_interval = DEF_CP_INTERVAL;
 	clear_sbi_flag(sbi, SBI_NEED_FSCK);
 
 	INIT_LIST_HEAD(&sbi->s_list);
-- 
2.1.1


------------------------------------------------------------------------------
