From: Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: don't split checkpoint in fstrim
Date: Sun,  8 Apr 2018 08:20:31 +0800
Message-ID: <20180408002031.15571-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1f59L8-0002Zp-Ee
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 08 Apr 2018 12:22:34 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f59L6-00ANHG-OT
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 08 Apr 2018 12:22:34 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

Now, we issue discard asynchronously in separated thread instead of in
checkpoint, after that, we won't encounter long latency in checkpoint
due to huge number of synchronous discard command handling, so, we don't
need to split checkpoint to do trim in batch, merge it and obsolete
related sysfs entry.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs |  1 +
 fs/f2fs/f2fs.h                          |  5 -----
 fs/f2fs/segment.c                       | 33 +++++++++------------------------
 fs/f2fs/sysfs.c                         |  3 +++
 4 files changed, 13 insertions(+), 29 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 540553c933b6..372b88f4e706 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -101,6 +101,7 @@ Date:		February 2015
 Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
 Description:
 		 Controls the trimming rate in batch mode.
+		 <deprecated>
 
 What:		/sys/fs/f2fs/<disk>/cp_interval
 Date:		October 2015
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 0aaf70955c77..f414f7ab8ddb 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -178,11 +178,6 @@ enum {
 #define	CP_DISCARD	0x00000010
 #define CP_TRIMMED	0x00000020
 
-#define DEF_BATCHED_TRIM_SECTIONS	2048
-#define BATCHED_TRIM_SEGMENTS(sbi)	\
-		(GET_SEG_FROM_SEC(sbi, SM_I(sbi)->trim_sections))
-#define BATCHED_TRIM_BLOCKS(sbi)	\
-		(BATCHED_TRIM_SEGMENTS(sbi) << (sbi)->log_blocks_per_seg)
 #define MAX_DISCARD_BLOCKS(sbi)		BLKS_PER_SEC(sbi)
 #define DEF_MAX_DISCARD_REQUEST		8	/* issue 8 discards per round */
 #define DEF_MIN_DISCARD_ISSUE_TIME	50	/* 50 ms, if exists */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 2aff7834d821..7150ab22f968 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2450,30 +2450,17 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 
 	cpc.reason = CP_DISCARD;
 	cpc.trim_minlen = max_t(__u64, 1, F2FS_BYTES_TO_BLK(range->minlen));
+	cpc.trim_start = start_segno;
+	cpc.trim_end = end_segno;
 
-	/* do checkpoint to issue discard commands safely */
-	for (cur_segno = start_segno; cur_segno <= end_segno;
-					cur_segno = cpc.trim_end + 1) {
-		cpc.trim_start = cur_segno;
-
-		if (sbi->discard_blks == 0)
-			break;
-		else if (sbi->discard_blks < BATCHED_TRIM_BLOCKS(sbi))
-			cpc.trim_end = end_segno;
-		else
-			cpc.trim_end = min_t(unsigned int,
-				rounddown(cur_segno +
-				BATCHED_TRIM_SEGMENTS(sbi),
-				sbi->segs_per_sec) - 1, end_segno);
-
-		mutex_lock(&sbi->gc_mutex);
-		err = write_checkpoint(sbi, &cpc);
-		mutex_unlock(&sbi->gc_mutex);
-		if (err)
-			break;
+	if (sbi->discard_blks == 0)
+		goto out;
 
-		schedule();
-	}
+	mutex_lock(&sbi->gc_mutex);
+	err = write_checkpoint(sbi, &cpc);
+	mutex_unlock(&sbi->gc_mutex);
+	if (err)
+		goto out;
 
 	start_block = START_BLOCK(sbi, start_segno);
 	end_block = START_BLOCK(sbi, min(cur_segno, end_segno) + 1);
@@ -3869,8 +3856,6 @@ int build_segment_manager(struct f2fs_sb_info *sbi)
 	sm_info->min_hot_blocks = DEF_MIN_HOT_BLOCKS;
 	sm_info->min_ssr_sections = reserved_sections(sbi);
 
-	sm_info->trim_sections = DEF_BATCHED_TRIM_SECTIONS;
-
 	INIT_LIST_HEAD(&sm_info->sit_entry_set);
 
 	init_rwsem(&sm_info->curseg_lock);
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index ab54990d057d..2130d9b031a2 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -251,6 +251,9 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "trim_sections"))
+		return -EINVAL;
+
 	*ui = t;
 
 	if (!strcmp(a->attr.name, "iostat_enable") && *ui == 0)
-- 
2.16.2.17.g38e79b1fd


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
