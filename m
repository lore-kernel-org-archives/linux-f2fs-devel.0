From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/5] f2fs: add maximum prefree segments
Date: Thu, 14 Jul 2016 17:46:28 -0700
Message-ID: <20160715004629.43143-4-jaegeuk@kernel.org>
References: <20160715004629.43143-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bNrHH-0004XJ-Hk
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 15 Jul 2016 00:46:51 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bNrH9-00063k-2e
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 15 Jul 2016 00:46:51 +0000
In-Reply-To: <20160715004629.43143-1-jaegeuk@kernel.org>
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

In 1TB storage, we need to admit 22841 prefree segments, which can consume
too much segments.
This patch sets 8GB in max. prefree segments in that case.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 3 +++
 fs/f2fs/segment.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 08f6c0b..e87aa05 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2409,6 +2409,9 @@ int build_segment_manager(struct f2fs_sb_info *sbi)
 	sm_info->ssa_blkaddr = le32_to_cpu(raw_super->ssa_blkaddr);
 	sm_info->rec_prefree_segments = sm_info->main_segments *
 					DEF_RECLAIM_PREFREE_SEGMENTS / 100;
+	if (sm_info->rec_prefree_segments > DEF_MAX_RECLAIM_PREFREE_SEGMENTS)
+		sm_info->rec_prefree_segments = DEF_MAX_RECLAIM_PREFREE_SEGMENTS;
+
 	if (!test_opt(sbi, LFS))
 		sm_info->ipu_policy = 1 << F2FS_IPU_FSYNC;
 	sm_info->min_ipu_util = DEF_MIN_IPU_UTIL;
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 57d450f..b33f73e 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -16,6 +16,7 @@
 #define NULL_SECNO			((unsigned int)(~0))
 
 #define DEF_RECLAIM_PREFREE_SEGMENTS	5	/* 5% over total segments */
+#define DEF_MAX_RECLAIM_PREFREE_SEGMENTS	4096	/* 8GB in maximum */
 
 /* L: Logical segment # in volume, R: Relative segment # in main area */
 #define GET_L2R_SEGNO(free_i, segno)	(segno - free_i->start_segno)
-- 
2.8.3


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity planning
reports.http://sdm.link/zohodev2dev
