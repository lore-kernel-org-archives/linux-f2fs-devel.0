From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH 1/2 v2] f2fs: fix a missing discard prefree
	segments
Date: Tue, 20 Dec 2016 11:11:34 +0800
Message-ID: <20161220031135.18754-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1cJAnb-0001Pt-3s
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 20 Dec 2016 03:09:07 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cJAna-0002gH-6a
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 20 Dec 2016 03:09:07 +0000
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
 fs/f2fs/segment.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 0738f48..a40a34b 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -916,7 +916,11 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 		dirty_i->nr_dirty[PRE] -= end - start;
 
-		if (force || !test_opt(sbi, DISCARD))
+		if (!test_opt(sbi, DISCARD))
+			continue;
+
+		if (force && start * sbi->blocks_per_seg >= cpc->trim_start &&
+						end * sbi->blocks_per_seg <= cpc->trim_end)
 			continue;
 
 		if (!test_opt(sbi, LFS) || sbi->segs_per_sec == 1) {
-- 
2.10.1


------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today.http://sdm.link/intel
