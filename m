From: Sheng Yong <shengyong1@huawei.com>
Subject: [RFC PATCH 2/5] f2fs-tools: init f2fs_configuration as 0
Date: Tue, 6 Feb 2018 12:31:22 +0800
Message-ID: <20180206043125.134191-3-shengyong1@huawei.com>
References: <20180206043125.134191-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <shengyong1@huawei.com>) id 1eiuvE-0006iv-2m
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 06 Feb 2018 04:31:56 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eiuvC-00007E-Ry
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 06 Feb 2018 04:31:56 +0000
In-Reply-To: <20180206043125.134191-1-shengyong1@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: heyunlei@huawei.com, miaoxie@huawei.com, shengyong1@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 lib/libf2fs.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index e8b1842..0c684d5 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -586,24 +586,17 @@ void f2fs_init_configuration(void)
 {
 	int i;
 
+	memset(&c, 0, sizeof(struct f2fs_configuration));
 	c.ndevs = 1;
-	c.total_sectors = 0;
-	c.sector_size = 0;
 	c.sectors_per_blk = DEFAULT_SECTORS_PER_BLOCK;
 	c.blks_per_seg = DEFAULT_BLOCKS_PER_SEGMENT;
 	c.rootdev_name = get_rootdev();
 	c.wanted_total_sectors = -1;
-	c.zoned_mode = 0;
-	c.zoned_model = 0;
-	c.zone_blocks = 0;
-#ifdef WITH_ANDROID
-	c.preserve_limits = 0;
-#else
+#ifndef WITH_ANDROID
 	c.preserve_limits = 1;
 #endif
 
 	for (i = 0; i < MAX_DEVICES; i++) {
-		memset(&c.devices[i], 0, sizeof(struct device_info));
 		c.devices[i].fd = -1;
 		c.devices[i].sector_size = DEFAULT_SECTOR_SIZE;
 		c.devices[i].end_blkaddr = -1;
@@ -611,19 +604,12 @@ void f2fs_init_configuration(void)
 	}
 
 	/* calculated by overprovision ratio */
-	c.reserved_segments = 0;
-	c.overprovision = 0;
 	c.segs_per_sec = 1;
 	c.secs_per_zone = 1;
 	c.segs_per_zone = 1;
-	c.heap = 0;
 	c.vol_label = "";
 	c.trim = 1;
-	c.trimmed = 0;
-	c.ro = 0;
 	c.kd = -1;
-	c.dry_run = 0;
-	c.large_nat_bitmap = 0;
 	c.fixed_time = -1;
 }
 
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
