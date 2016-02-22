From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: remain last victim segment number
	ascending order
Date: Mon, 22 Feb 2016 09:44:38 -0800
Message-ID: <1456163078-15523-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aXuXM-00088Y-3G
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 22 Feb 2016 17:44:44 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aXuXL-0005S3-82
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 22 Feb 2016 17:44:44 +0000
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

This patch avoids to remain inefficient victim segment number selected by
a victim.

For example, if all the dirty segments has same valid blocks, we can get
the victim segments descending order due to keeping wrong last segment number.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 47ade35..c013534 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -270,7 +270,7 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 {
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
 	struct victim_sel_policy p;
-	unsigned int secno, max_cost;
+	unsigned int secno, max_cost, last_victim;
 	unsigned int last_segment = MAIN_SEGS(sbi);
 	unsigned int nsearched = 0;
 
@@ -285,6 +285,7 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 	if (p.max_search == 0)
 		goto out;
 
+	last_victim = sbi->last_victim[p.gc_mode];
 	if (p.alloc_mode == LFS && gc_type == FG_GC) {
 		p.min_segno = check_bg_victims(sbi);
 		if (p.min_segno != NULL_SEGNO)
@@ -332,7 +333,10 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 		}
 next:
 		if (nsearched >= p.max_search) {
-			sbi->last_victim[p.gc_mode] = segno;
+			if (!sbi->last_victim[p.gc_mode] && segno <= last_victim)
+				sbi->last_victim[p.gc_mode] = last_victim + 1;
+			else
+				sbi->last_victim[p.gc_mode] = segno + 1;
 			break;
 		}
 	}
-- 
2.6.3


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
