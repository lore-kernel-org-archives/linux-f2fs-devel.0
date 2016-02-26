From: Junling Zheng <zhengjunling@huawei.com>
Subject: [RFC PATCH] fsck.f2fs: calculate the total size correctly
Date: Fri, 26 Feb 2016 20:05:27 +0800
Message-ID: <1456488327-20407-1-git-send-email-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zhengjunling@huawei.com>) id 1aZHKg-0004Lx-5u
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 26 Feb 2016 12:17:18 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1aZHKW-00054P-1s
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 26 Feb 2016 12:17:18 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, chao2.yu@samsung.com

Correctly calculate the total FS size in init_sb_info, for sector
size may not be 512 bytes.

Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
---
 fsck/mount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index 4c807f9..3adaa8a 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -367,7 +367,7 @@ int init_sb_info(struct f2fs_sb_info *sbi)
 
 	total_sectors = get_sb(block_count) << sbi->log_sectors_per_block;
 	MSG(0, "Info: total FS sectors = %"PRIu64" (%"PRIu64" MB)\n",
-				total_sectors, total_sectors >> 11);
+				total_sectors, total_sectors * config.sector_size >> 20);
 	return 0;
 }
 
-- 
1.9.1


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
