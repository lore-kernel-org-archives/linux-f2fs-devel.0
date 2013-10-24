From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH V2] f2fs: check all ones or zeros bitmap with
 bitops for better mount performance
Date: Thu, 24 Oct 2013 16:21:28 +0800
Message-ID: <000401ced092$28087a90$78196fb0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1VZGBk-0008R6-6D
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Oct 2013 08:22:40 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VZGBh-00085f-WF for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Oct 2013 08:22:40 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0MV500G9CZ97L4T0@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Oct 2013 17:22:20 +0900 (KST)
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
To: jaegeuk.kim@samsung.com
Cc: linux-fsdevel@vger.kernel.org, =?utf-8?B?J+iwreWnnSc=?= <shu.tan@samsung.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Previously, check_block_count check valid_map with bit data type in common scenario that sit has all ones or zeros bitmap, it makes low mount performance.
So let's check the special bitmap with integer data type instead of the bit one.

v2:
    use find_next_bit_le/find_next_zero_bit_le for better performance and readable as Jaegeuk suggested.

Suggested-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Signed-off-by: Tan Shu <shu.tan@samsung.com>
Signed-off-by: Yu Chao <chao2.yu@samsung.com>
---
 fs/f2fs/segment.h |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 7f94d78..d25b6af 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -552,6 +552,23 @@ static inline void check_block_count(struct f2fs_sb_info *sbi,
 	/* check boundary of a given segment number */
 	BUG_ON(segno > end_segno);
 
+	/* check all ones or zeros valid_map */
+	if (GET_SIT_VBLOCKS(raw_sit) == 0) {
+		int pos = find_next_bit_le(&raw_sit->valid_map,
+					sbi->blocks_per_seg,
+					0);
+		if (pos != sbi->blocks_per_seg)
+			BUG();
+		return;
+	} else if (GET_SIT_VBLOCKS(raw_sit) == sbi->blocks_per_seg) {
+		int pos = find_next_zero_bit_le(&raw_sit->valid_map,
+					sbi->blocks_per_seg,
+					0);
+		if (pos != sbi->blocks_per_seg)
+			BUG();
+		return;
+	}
+
 	/* check bitmap with valid block count */
 	for (i = 0; i < sbi->blocks_per_seg; i++)
 		if (f2fs_test_bit(i, raw_sit->valid_map))
-- 
1.7.9.5


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
