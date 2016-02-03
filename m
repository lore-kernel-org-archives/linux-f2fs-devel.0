From: Fan Li <fanofcode.li@samsung.com>
Subject: [PATCH] f2fs: avoid unnecessary search while finding
	victim in gc
Date: Wed, 03 Feb 2016 16:21:57 +0800
Message-ID: <000d01d15e5c$08ba6310$1a2f2930$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fanofcode.li@samsung.com>) id 1aQsi5-00082u-A3
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 03 Feb 2016 08:22:45 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aQsi3-0006Vz-1y
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 03 Feb 2016 08:22:45 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O1Y01NB0PXGMA70@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 03 Feb 2016 17:22:35 +0900 (KST)
Content-language: en-us
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

variable nsearched in get_victim_by_default() indicates the number of
dirty segments we already checked. There are 2 problems about the way
it updates:
1. When p.ofs_unit is greater than 1, the victim we find consists
   of multiple segments, possibly more than 1 dirty segment. 
   But nsearched always increases by 1.
2. If segments have been found but not been chosen, nsearched won't
   increase. So even we have checked all dirty segments, nsearched
   may still less than p.max_search.
All these problems could cause unnecessary search after all dirty
segments have already been checked.

Signed-off-by: Fan li <fanofcode.li@samsung.com>
---
 fs/f2fs/gc.c |   33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index c958321..47ade35 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -245,6 +245,18 @@ static inline unsigned int get_gc_cost(struct f2fs_sb_info *sbi,
 		return get_cb_cost(sbi, segno);
 }
 
+static unsigned int count_bits(const unsigned long *addr,
+				unsigned int offset, unsigned int len)
+{
+	unsigned int end = offset + len, sum = 0;
+
+	while (offset < end) {
+		if (test_bit(offset++, addr))
+			++sum;
+	}
+	return sum;
+}
+
 /*
  * This function is called from two paths.
  * One is garbage collection and the other is SSR segment selection.
@@ -260,7 +272,7 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 	struct victim_sel_policy p;
 	unsigned int secno, max_cost;
 	unsigned int last_segment = MAIN_SEGS(sbi);
-	int nsearched = 0;
+	unsigned int nsearched = 0;
 
 	mutex_lock(&dirty_i->seglist_lock);
 
@@ -295,26 +307,31 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 		}
 
 		p.offset = segno + p.ofs_unit;
-		if (p.ofs_unit > 1)
+		if (p.ofs_unit > 1) {
 			p.offset -= segno % p.ofs_unit;
+			nsearched += count_bits(p.dirty_segmap,
+						p.offset - p.ofs_unit,
+						p.ofs_unit);
+		} else {
+			nsearched++;
+		}
+
 
 		secno = GET_SECNO(sbi, segno);
 
 		if (sec_usage_check(sbi, secno))
-			continue;
+			goto next;
 		if (gc_type == BG_GC && test_bit(secno, dirty_i->victim_secmap))
-			continue;
+			goto next;
 
 		cost = get_gc_cost(sbi, segno, &p);
 
 		if (p.min_cost > cost) {
 			p.min_segno = segno;
 			p.min_cost = cost;
-		} else if (unlikely(cost == max_cost)) {
-			continue;
 		}
-
-		if (nsearched++ >= p.max_search) {
+next:
+		if (nsearched >= p.max_search) {
 			sbi->last_victim[p.gc_mode] = segno;
 			break;
 		}
-- 
1.7.9.5


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
