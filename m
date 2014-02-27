From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: readahead contiguous SSA blocks for f2fs_gc
Date: Thu, 27 Feb 2014 19:12:24 +0800
Message-ID: <001201cf33ac$e5d61dc0$b1825940$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1WIyu4-0003CG-B1
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 27 Feb 2014 11:13:24 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WIyu2-00032q-Ca
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 27 Feb 2014 11:13:24 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N1N009XIJ628C40@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 27 Feb 2014 20:13:14 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: ??? <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

If there are multi segments in one section, we will read those SSA blocks which
have contiguous address one by one in f2fs_gc. It may lost performance, let's
read ahead SSA blocks by merge multi read request.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/checkpoint.c |    6 ++++--
 fs/f2fs/f2fs.h       |    5 +++--
 fs/f2fs/gc.c         |    5 +++++
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 757b77b..c8516ee 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -82,6 +82,7 @@ inline int get_max_meta_blks(struct f2fs_sb_info *sbi, int type)
 		return NM_I(sbi)->max_nid / NAT_ENTRY_PER_BLOCK;
 	case META_SIT:
 		return SIT_BLK_CNT(sbi);
+	case META_SSA:
 	case META_CP:
 		return 0;
 	default:
@@ -90,7 +91,7 @@ inline int get_max_meta_blks(struct f2fs_sb_info *sbi, int type)
 }
 
 /*
- * Readahead CP/NAT/SIT pages
+ * Readahead CP/NAT/SIT/SSA pages
  */
 int ra_meta_pages(struct f2fs_sb_info *sbi, int start, int nrpages, int type)
 {
@@ -125,8 +126,9 @@ int ra_meta_pages(struct f2fs_sb_info *sbi, int start, int nrpages, int type)
 				goto out;
 			prev_blk_addr = blk_addr;
 			break;
+		case META_SSA:
 		case META_CP:
-			/* get cp block addr */
+			/* get ssa/cp block addr */
 			blk_addr = blkno;
 			break;
 		default:
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4beedcc..cc0b27f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -89,12 +89,13 @@ enum {
 };
 
 /*
- * For CP/NAT/SIT readahead
+ * For CP/NAT/SIT/SSA readahead
  */
 enum {
 	META_CP,
 	META_NAT,
-	META_SIT
+	META_SIT,
+	META_SSA
 };
 
 /* for the list of orphan inodes */
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index b161db4..d94acbc 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -708,6 +708,11 @@ gc_more:
 		goto stop;
 	ret = 0;
 
+	/* readahead multi ssa blocks those have contiguous address */
+	if (sbi->segs_per_sec > 1)
+		ra_meta_pages(sbi, GET_SUM_BLOCK(sbi, segno), sbi->segs_per_sec,
+								META_SSA);
+
 	for (i = 0; i < sbi->segs_per_sec; i++)
 		do_garbage_collect(sbi, segno + i, &ilist, gc_type);
 
-- 
1.7.9.5


------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
