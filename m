From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] resize.f2fs: replace the overprovision
	calculation method
Date: Tue, 26 Apr 2016 13:25:08 +0800
Message-ID: <1461648308-13065-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1auvRk-0005xE-3o
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Apr 2016 05:22:04 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1auvRc-000886-E2
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Apr 2016 05:22:04 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, yuchao@huawei.com

This patch replace the overprovision calculation method from
mkfs tool.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fsck/resize.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fsck/resize.c b/fsck/resize.c
index 0803024..d2fd467 100644
--- a/fsck/resize.c
+++ b/fsck/resize.c
@@ -406,14 +406,19 @@ static void rebuild_checkpoint(struct f2fs_sb_info *sbi,
 	ASSERT(buf);
 
 	/* ovp / free segments */
-	set_cp(overprov_segment_count, config.new_overprovision);
 	set_cp(rsvd_segment_count, config.new_reserved_segments);
+	set_cp(overprov_segment_count, (get_newsb(segment_count_main) -
+			get_cp(rsvd_segment_count)) *
+			config.new_overprovision / 100);
+	set_cp(overprov_segment_count, get_cp(overprov_segment_count) +
+						get_cp(rsvd_segment_count));
+
 	free_segment_count = get_cp(free_segment_count);
 	new_segment_count = get_newsb(segment_count_main) -
 					get_sb(segment_count_main);
 
 	set_cp(free_segment_count, free_segment_count + new_segment_count);
-	set_cp(user_block_count, ((get_sb(segment_count_main) -
+	set_cp(user_block_count, ((get_newsb(segment_count_main) -
 			get_cp(overprov_segment_count)) * config.blks_per_seg));
 
 	if (is_set_ckpt_flags(cp, CP_ORPHAN_PRESENT_FLAG))
-- 
1.9.1


------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
