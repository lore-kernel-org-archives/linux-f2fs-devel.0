From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH] f2fs: introduce sysfs entry to control
	in-place-update policy
Date: Thu, 12 Dec 2013 11:11:32 +0900
Message-ID: <1386814292-25175-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1Vqvlf-0004pO-UP
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 12 Dec 2013 02:12:47 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1Vqvld-0002cg-92
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 12 Dec 2013 02:12:47 +0000
Received: from epcpsbgr2.samsung.com
	(u142.gpu120.samsung.co.kr [203.254.230.142])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MXO003CI8T1UT70@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 12 Dec 2013 11:12:37 +0900 (KST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch introduces new sysfs entries for users to control the policy of
in-place-updates, namely IPU, in f2fs.

Sometimes f2fs suffers from performance degradation due to its out-of-place
update policy that produces many additional node block writes.
If the storage performance is very dependant on the amount of data writes
instead of IO patterns, we'd better drop this out-of-place update policy.

This patch suggests 5 polcies and their triggering conditions as follows.

[sysfs entry name = ipu_policy]

0: F2FS_IPU_FORCE       all the time,
1: F2FS_IPU_SSR         if SSR mode is activated,
2: F2FS_IPU_UTIL        if FS utilization is over threashold,
3: F2FS_IPU_SSR_UTIL    if SSR mode is activated and FS utilization is over
                        threashold,
4: F2FS_IPUT_DISABLE    disable IPU. (=default option)

[sysfs entry name = min_ipu_util]

This parameter controls the threshold to trigger in-place-updates.
The number indicates percentage of the filesystem utilization, and used by
F2FS_IPU_UTIL and F2FS_IPU_SSR_UTIL policies.

For more details, see need_inplace_update() in segment.h.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 Documentation/filesystems/f2fs.txt | 11 ++++++++++
 fs/f2fs/f2fs.h                     |  3 +++
 fs/f2fs/segment.c                  |  2 ++
 fs/f2fs/segment.h                  | 44 ++++++++++++++++++++++++++++++++------
 fs/f2fs/super.c                    |  4 ++++
 5 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index a3fe811..4f9b146 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -171,6 +171,17 @@ Files in /sys/fs/f2fs/<devname>
 			      conduct checkpoint to reclaim the prefree segments
 			      to free segments. By default, 100 segments, 200MB.
 
+ ipu_policy                   This parameter controls the policy of in-place
+                              updates in f2fs. There are five policies:
+                               0: F2FS_IPU_FORCE, 1: F2FS_IPU_SSR,
+                               2: F2FS_IPU_UTIL,  3: F2FS_IPU_SSR_UTIL,
+                               4: F2FS_IPUT_DISABLE.
+
+ min_ipu_util                 This parameter controls the threshold to trigger
+                              in-place-updates. The number indicates percentage
+                              of the filesystem utilization, and used by
+                              F2FS_IPU_UTIL and F2FS_IPU_SSR_UTIL policies.
+
 ================================================================================
 USAGE
 ================================================================================
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 022ce32..1b05a62 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -325,6 +325,9 @@ struct f2fs_sm_info {
 	struct list_head discard_list;		/* 4KB discard list */
 	int nr_discards;			/* # of discards in the list */
 	int max_discards;			/* max. discards to be issued */
+
+	unsigned int ipu_policy;	/* in-place-update policy */
+	unsigned int min_ipu_util;	/* in-place-update threshold */
 };
 
 /*
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 0b2e8ce..5b890ce 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1799,6 +1799,8 @@ int build_segment_manager(struct f2fs_sb_info *sbi)
 	sm_info->main_segments = le32_to_cpu(raw_super->segment_count_main);
 	sm_info->ssa_blkaddr = le32_to_cpu(raw_super->ssa_blkaddr);
 	sm_info->rec_prefree_segments = DEF_RECLAIM_PREFREE_SEGMENTS;
+	sm_info->ipu_policy = F2FS_IPU_DISABLE;
+	sm_info->min_ipu_util = DEF_MIN_IPU_UTIL;
 
 	INIT_LIST_HEAD(&sm_info->discard_list);
 	sm_info->nr_discards = 0;
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index ea56376..e9a10bd 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -476,19 +476,51 @@ static inline int utilization(struct f2fs_sb_info *sbi)
 
 /*
  * Sometimes f2fs may be better to drop out-of-place update policy.
- * So, if fs utilization is over MIN_IPU_UTIL, then f2fs tries to write
- * data in the original place likewise other traditional file systems.
- * But, currently set 100 in percentage, which means it is disabled.
- * See below need_inplace_update().
+ * And, users can control the policy through sysfs entries.
+ * There are five policies with triggering conditions as follows.
+ * F2FS_IPU_FORCE - all the time,
+ * F2FS_IPU_SSR - if SSR mode is activated,
+ * F2FS_IPU_UTIL - if FS utilization is over threashold,
+ * F2FS_IPU_SSR_UTIL - if SSR mode is activated and FS utilization is over
+ *                     threashold,
+ * F2FS_IPUT_DISABLE - disable IPU. (=default option)
  */
-#define MIN_IPU_UTIL		100
+#define DEF_MIN_IPU_UTIL	70
+
+enum {
+	F2FS_IPU_FORCE,
+	F2FS_IPU_SSR,
+	F2FS_IPU_UTIL,
+	F2FS_IPU_SSR_UTIL,
+	F2FS_IPU_DISABLE,
+};
+
 static inline bool need_inplace_update(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
+
+	/* IPU can be done only for the user data */
 	if (S_ISDIR(inode->i_mode))
 		return false;
-	if (need_SSR(sbi) && utilization(sbi) > MIN_IPU_UTIL)
+
+	switch (SM_I(sbi)->ipu_policy) {
+	case F2FS_IPU_FORCE:
 		return true;
+	case F2FS_IPU_SSR:
+		if (need_SSR(sbi))
+			return true;
+		break;
+	case F2FS_IPU_UTIL:
+		if (utilization(sbi) > SM_I(sbi)->min_ipu_util)
+			return true;
+		break;
+	case F2FS_IPU_SSR_UTIL:
+		if (need_SSR(sbi) && utilization(sbi) > SM_I(sbi)->min_ipu_util)
+			return true;
+		break;
+	case F2FS_IPU_DISABLE:
+		break;
+	}
 	return false;
 }
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 5c574fa..f16da92 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -178,6 +178,8 @@ F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_no_gc_sleep_time, no_gc_sleep_time);
 F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_idle, gc_idle);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, reclaim_segments, rec_prefree_segments);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, max_small_discards, max_discards);
+F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, ipu_policy, ipu_policy);
+F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_ipu_util, min_ipu_util);
 
 #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
 static struct attribute *f2fs_attrs[] = {
@@ -187,6 +189,8 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(gc_idle),
 	ATTR_LIST(reclaim_segments),
 	ATTR_LIST(max_small_discards),
+	ATTR_LIST(ipu_policy),
+	ATTR_LIST(min_ipu_util),
 	NULL,
 };
 
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
