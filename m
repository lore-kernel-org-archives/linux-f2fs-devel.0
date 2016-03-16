From: Junling Zheng <zhengjunling@huawei.com>
Subject: [PATCH v3] mkfs.f2fs: set segment_count in super block
	correctly
Date: Wed, 16 Mar 2016 10:25:36 +0800
Message-ID: <1458095136-25117-1-git-send-email-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zhengjunling@huawei.com>) id 1ag1Ko-0002MX-Sn
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 16 Mar 2016 02:37:18 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ag1Kk-0007uC-A7
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 16 Mar 2016 02:37:18 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org

From: Fan Li <fanofcode.li@samsung.com>

Now f2fs will check statistics recorded in super block in
sanity_check_area_boundary() during mount. If the number of segments
per zone is greater than 1, and the disk space isn't aligned with zone,
mount will fail due to following condition:

main_blkaddr + (segment_count_main << log_blocks_per_seg) !=
		segment0_blkaddr + (segment_count << log_blocks_per_seg)

This is because when the length of main area isn't aligned with zone,
mkfs doesn't add those excess segments to segment_count_main, but adds
them to segment_count.

Here align segment_count with zone size as well as segment_count_main
to prevent such problem.

Signed-off-by: Fan Li <fanofcode.li@samsung.com>
Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
---
 mkfs/f2fs_format.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 4f38f03..960031e 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -175,7 +175,8 @@ static int f2fs_prepare_super_block(void)
 	}
 
 	set_sb(segment_count, (config.total_sectors * config.sector_size -
-				zone_align_start_offset) / segment_size_bytes);
+				zone_align_start_offset) / segment_size_bytes /
+				config.segs_per_zone * config.segs_per_zone);
 
 	set_sb(segment0_blkaddr, zone_align_start_offset / blk_size_bytes);
 	sb->cp_blkaddr = sb->segment0_blkaddr;
-- 
1.9.1


------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785231&iu=/4140
