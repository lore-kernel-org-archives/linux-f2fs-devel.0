From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 5/5] f2fs: change reclaim rate in percentage
Date: Wed, 19 Mar 2014 17:02:09 +0900
Message-ID: <1395216129-13656-5-git-send-email-jaegeuk.kim@samsung.com>
References: <1395216129-13656-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1WQBTr-0000PH-QQ
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Mar 2014 08:04:07 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WQBTq-0004CT-1x
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Mar 2014 08:04:07 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N2O003AHBQM90D0@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 19 Mar 2014 17:03:58 +0900 (KST)
In-reply-to: <1395216129-13656-1-git-send-email-jaegeuk.kim@samsung.com>
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

It is more reasonable to determine the reclaiming rate of prefree segments
according to the volume size, which is set to 5% by default.
For example, if the volume is 128GB, the prefree segments are reclaimed
when the number reaches to 6.4GB.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 Documentation/filesystems/f2fs.txt | 8 +++++---
 fs/f2fs/segment.c                  | 3 ++-
 fs/f2fs/segment.h                  | 2 +-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index f415b9f..2f6d021 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -169,9 +169,11 @@ Files in /sys/fs/f2fs/<devname>
 
  reclaim_segments             This parameter controls the number of prefree
                               segments to be reclaimed. If the number of prefree
-			      segments is larger than this number, f2fs tries to
-			      conduct checkpoint to reclaim the prefree segments
-			      to free segments. By default, 100 segments, 200MB.
+			      segments is larger than the number of segments
+			      in the proportion to the percentage over total
+			      volume size, f2fs tries to conduct checkpoint to
+			      reclaim the prefree segments to free segments.
+			      By default, 5% over total # of segments.
 
  max_small_discards	      This parameter controls the number of discard
 			      commands that consist small blocks less than 2MB.
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6c5a4f0..e7ff23a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1758,7 +1758,8 @@ int build_segment_manager(struct f2fs_sb_info *sbi)
 	sm_info->ovp_segments = le32_to_cpu(ckpt->overprov_segment_count);
 	sm_info->main_segments = le32_to_cpu(raw_super->segment_count_main);
 	sm_info->ssa_blkaddr = le32_to_cpu(raw_super->ssa_blkaddr);
-	sm_info->rec_prefree_segments = DEF_RECLAIM_PREFREE_SEGMENTS;
+	sm_info->rec_prefree_segments = sm_info->main_segments *
+					DEF_RECLAIM_PREFREE_SEGMENTS / 100;
 	sm_info->ipu_policy = F2FS_IPU_DISABLE;
 	sm_info->min_ipu_util = DEF_MIN_IPU_UTIL;
 
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 9fc46ee..7091204 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -14,7 +14,7 @@
 #define NULL_SEGNO			((unsigned int)(~0))
 #define NULL_SECNO			((unsigned int)(~0))
 
-#define DEF_RECLAIM_PREFREE_SEGMENTS	100	/* 200MB of prefree segments */
+#define DEF_RECLAIM_PREFREE_SEGMENTS	5	/* 5% over total segments */
 
 /* L: Logical segment # in volume, R: Relative segment # in main area */
 #define GET_L2R_SEGNO(free_i, segno)	(segno - free_i->start_segno)
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
