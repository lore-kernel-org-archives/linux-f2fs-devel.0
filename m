From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/6] f2fs: remove batched discard in f2fs_trim_fs
Date: Thu, 12 Jan 2017 14:44:04 -0800
Message-ID: <20170112224407.54026-3-jaegeuk@kernel.org>
References: <20170112224407.54026-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cRo6Y-0002yN-WB
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 12 Jan 2017 22:44:23 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cRo6X-0000AN-S9
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 12 Jan 2017 22:44:22 +0000
In-Reply-To: <20170112224407.54026-1-jaegeuk@kernel.org>
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

We don't need to do multiple checkpoints, since we don't actually wait for
completion of discard commands during checkpoint.
Instead, we still need to avoid very big discard commands, since that large
discard can interfere block allocation.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-f2fs |  6 ------
 fs/f2fs/f2fs.h                          |  9 +-------
 fs/f2fs/segment.c                       | 38 +++++++++++----------------------
 fs/f2fs/super.c                         |  2 --
 4 files changed, 14 insertions(+), 41 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index a809f6005f14..df6b3f6e164a 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -75,12 +75,6 @@ Contact:	"Jaegeuk Kim" <jaegeuk.kim@samsung.com>
 Description:
 		 Controls the memory footprint used by f2fs.
 
-What:		/sys/fs/f2fs/<disk>/trim_sections
-Date:		February 2015
-Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
-Description:
-		 Controls the trimming rate in batch mode.
-
 What:		/sys/fs/f2fs/<disk>/cp_interval
 Date:		October 2015
 Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 548e75d18ec1..a2850bf2a487 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -128,11 +128,7 @@ enum {
 	CP_DISCARD,
 };
 
-#define DEF_BATCHED_TRIM_SECTIONS	2
-#define BATCHED_TRIM_SEGMENTS(sbi)	\
-		(SM_I(sbi)->trim_sections * (sbi)->segs_per_sec)
-#define BATCHED_TRIM_BLOCKS(sbi)	\
-		(BATCHED_TRIM_SEGMENTS(sbi) << (sbi)->log_blocks_per_seg)
+#define MAX_DISCARD_BLOCKS(sbi) (1 << (sbi)->log_blocks_per_seg)
 #define DEF_CP_INTERVAL			60	/* 60 secs */
 #define DEF_IDLE_INTERVAL		5	/* 5 secs */
 
@@ -638,9 +634,6 @@ struct f2fs_sm_info {
 	int nr_discards;			/* # of discards in the list */
 	int max_discards;			/* max. discards to be issued */
 
-	/* for batched trimming */
-	unsigned int trim_sections;		/* # of sections to trim */
-
 	struct list_head sit_entry_set;	/* sit entry set list */
 
 	unsigned int ipu_policy;	/* in-place-update policy */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 73282108fa33..e6f3c6db7616 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -823,7 +823,8 @@ static void __add_discard_entry(struct f2fs_sb_info *sbi,
 	if (!list_empty(head)) {
 		last = list_last_entry(head, struct discard_entry, list);
 		if (START_BLOCK(sbi, cpc->trim_start) + start ==
-						last->blkaddr + last->len) {
+				last->blkaddr + last->len &&
+				last->len <= MAX_DISCARD_BLOCKS(sbi)) {
 			last->len += end - start;
 			goto done;
 		}
@@ -1513,36 +1514,25 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 			"Found FS corruption, run fsck to fix.");
 		goto out;
 	}
+	if (sbi->discard_blks == 0)
+		goto out;
 
 	/* start/end segment number in main_area */
 	start_segno = (start <= MAIN_BLKADDR(sbi)) ? 0 : GET_SEGNO(sbi, start);
 	end_segno = (end >= MAX_BLKADDR(sbi)) ? MAIN_SEGS(sbi) - 1 :
 						GET_SEGNO(sbi, end);
+	/*
+	 * do checkpoint to issue discard commands safely since we now can
+	 * use async discard.
+	 */
 	cpc.reason = CP_DISCARD;
 	cpc.trim_minlen = max_t(__u64, 1, F2FS_BYTES_TO_BLK(range->minlen));
+	cpc.trim_start = start_segno;
+	cpc.trim_end = end_segno;
 
-	/* do checkpoint to issue discard commands safely */
-	for (; start_segno <= end_segno; start_segno = cpc.trim_end + 1) {
-		cpc.trim_start = start_segno;
-
-		if (sbi->discard_blks == 0)
-			break;
-		else if (sbi->discard_blks < BATCHED_TRIM_BLOCKS(sbi))
-			cpc.trim_end = end_segno;
-		else
-			cpc.trim_end = min_t(unsigned int,
-				rounddown(start_segno +
-				BATCHED_TRIM_SEGMENTS(sbi),
-				sbi->segs_per_sec) - 1, end_segno);
-
-		mutex_lock(&sbi->gc_mutex);
-		err = write_checkpoint(sbi, &cpc);
-		mutex_unlock(&sbi->gc_mutex);
-		if (err)
-			break;
-
-		schedule();
-	}
+	mutex_lock(&sbi->gc_mutex);
+	err = write_checkpoint(sbi, &cpc);
+	mutex_unlock(&sbi->gc_mutex);
 out:
 	range->len = F2FS_BLK_TO_BYTES(cpc.trimmed);
 	return err;
@@ -2708,8 +2698,6 @@ int build_segment_manager(struct f2fs_sb_info *sbi)
 	sm_info->nr_discards = 0;
 	sm_info->max_discards = 0;
 
-	sm_info->trim_sections = DEF_BATCHED_TRIM_SECTIONS;
-
 	INIT_LIST_HEAD(&sm_info->sit_entry_set);
 
 	if (test_opt(sbi, FLUSH_MERGE) && !f2fs_readonly(sbi->sb)) {
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 461c29043aec..37d40d8aa9c4 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -284,7 +284,6 @@ F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_no_gc_sleep_time, no_gc_sleep_time);
 F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_idle, gc_idle);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, reclaim_segments, rec_prefree_segments);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, max_small_discards, max_discards);
-F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, batched_trim_sections, trim_sections);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, ipu_policy, ipu_policy);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_ipu_util, min_ipu_util);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_fsync_blocks, min_fsync_blocks);
@@ -309,7 +308,6 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(gc_idle),
 	ATTR_LIST(reclaim_segments),
 	ATTR_LIST(max_small_discards),
-	ATTR_LIST(batched_trim_sections),
 	ATTR_LIST(ipu_policy),
 	ATTR_LIST(min_ipu_util),
 	ATTR_LIST(min_fsync_blocks),
-- 
2.11.0


------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi
