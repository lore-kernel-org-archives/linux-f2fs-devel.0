From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH] f2fs: remove unnecessary segment bitmap updates
Date: Mon, 28 Oct 2013 14:06:47 +0900
Message-ID: <1382936807-4778-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1Vaf3K-0004OW-J3
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 28 Oct 2013 05:07:46 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vaf3I-0007e0-Eo for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 28 Oct 2013 05:07:46 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MVD000E84WJRMN0@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 28 Oct 2013 14:07:31 +0900 (KST)
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

From: Changman Lee <cm224.lee@samsung.com>

From: Changman Lee <cm224.lee@samsung.com>

Only one dirty type is set in __locate_dirty_segment and we can know
dirty type of segment. So we don't need to check other dirty types.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/segment.c | 31 ++++++++-----------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 487af61..8f92c18 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -58,20 +58,10 @@ static void __locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
 
 	if (dirty_type == DIRTY) {
 		struct seg_entry *sentry = get_seg_entry(sbi, segno);
-		enum dirty_type t = DIRTY_HOT_DATA;
+		enum dirty_type t = sentry->type;
 
-		dirty_type = sentry->type;
-
-		if (!test_and_set_bit(segno, dirty_i->dirty_segmap[dirty_type]))
-			dirty_i->nr_dirty[dirty_type]++;
-
-		/* Only one bitmap should be set */
-		for (; t <= DIRTY_COLD_NODE; t++) {
-			if (t == dirty_type)
-				continue;
-			if (test_and_clear_bit(segno, dirty_i->dirty_segmap[t]))
-				dirty_i->nr_dirty[t]--;
-		}
+		if (!test_and_set_bit(segno, dirty_i->dirty_segmap[t]))
+			dirty_i->nr_dirty[t]++;
 	}
 }
 
@@ -84,16 +74,11 @@ static void __remove_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
 		dirty_i->nr_dirty[dirty_type]--;
 
 	if (dirty_type == DIRTY) {
-		enum dirty_type t = DIRTY_HOT_DATA;
-
-		/* clear its dirty bitmap */
-		for (; t <= DIRTY_COLD_NODE; t++) {
-			if (test_and_clear_bit(segno,
-						dirty_i->dirty_segmap[t])) {
-				dirty_i->nr_dirty[t]--;
-				break;
-			}
-		}
+		struct seg_entry *sentry = get_seg_entry(sbi, segno);
+		enum dirty_type t = sentry->type;
+
+		if (test_and_clear_bit(segno, dirty_i->dirty_segmap[t]))
+			dirty_i->nr_dirty[t]--;
 
 		if (get_valid_blocks(sbi, segno, sbi->segs_per_sec) == 0)
 			clear_bit(GET_SECNO(sbi, segno),
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
