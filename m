From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH 1/2] f2fs: fix a missing discard prefree segments
Date: Fri, 16 Dec 2016 20:07:18 +0800
Message-ID: <20161216120719.3565-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1cHrF2-0004tq-21
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 16 Dec 2016 12:04:00 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cHrEw-0006Xg-95
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 16 Dec 2016 12:04:00 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, yuchao0@huawei.com
Cc: heyunlei@huwei.com

If userspace issue a fstrim with a range not involve prefree segments,
it will reuse these segments without discard. This patch fix it.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/segment.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index d7d5727..5b4468f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -899,6 +899,9 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	unsigned int secno, start_segno;
 	bool force = (cpc->reason == CP_DISCARD);
 
+	if (!test_opt(sbi, DISCARD))
+		return;
+
 	blk_start_plug(&plug);
 
 	mutex_lock(&dirty_i->seglist_lock);
@@ -910,15 +913,15 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 			break;
 		end = find_next_zero_bit(prefree_map, MAIN_SEGS(sbi),
 								start + 1);
+		if (force && start * sbi->blocks_per_seg >= cpc->trim_start &&
+					end * sbi->blocks_per_seg <= cpc->trim_end)
+			continue;
 
 		for (i = start; i < end; i++)
 			clear_bit(i, prefree_map);
 
 		dirty_i->nr_dirty[PRE] -= end - start;
 
-		if (force || !test_opt(sbi, DISCARD))
-			continue;
-
 		if (!test_opt(sbi, LFS) || sbi->segs_per_sec == 1) {
 			f2fs_issue_discard(sbi, START_BLOCK(sbi, start),
 				(end - start) << sbi->log_blocks_per_seg);
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
