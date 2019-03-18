From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 4/5] f2fs-tools: Allow using host-aware devices
 as regular devices
Date: Mon, 18 Mar 2019 15:39:58 +0900
Message-ID: <20190318063959.21369-5-damien.lemoal@wdc.com>
References: <20190318063959.21369-1-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <prvs=973cf3254=damien.lemoal@wdc.com>)
 id 1h5lwT-0005LM-7D
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 18 Mar 2019 06:40:13 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h5lwR-00AHPl-Oy
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 18 Mar 2019 06:40:13 +0000
In-Reply-To: <20190318063959.21369-1-damien.lemoal@wdc.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net

Host-aware zoned block devices can accept random writes anywhere and so
do not require to be handled under F2FS_ZONED_HM mode. Allow host aware
disks to be treated as regular devices if c.zoned_mode is false, that
is, if the -m option is not specified in mkfs.f2fs.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 lib/libf2fs.c | 43 ++++++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 5ca1bb0..214c921 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -933,9 +933,21 @@ int get_device_info(int i)
 	}
 
 	if (dev->zoned_model != F2FS_ZONED_NONE) {
-		if (dev->zoned_model == F2FS_ZONED_HM)
+		if (dev->zoned_model == F2FS_ZONED_HM) {
 			c.zoned_model = F2FS_ZONED_HM;
+		} else {
+			/* F2FS_ZONED_HA */
+			if (c.zoned_mode) {
+				c.zoned_model = F2FS_ZONED_HM;
+			} else {
+				MSG(0, "Info: treating host-aware zoned block "
+				    "device as regular device\n");
+				dev->zoned_model = F2FS_ZONED_NONE;
+			}
+		}
+	}
 
+	if (c.zoned_model == F2FS_ZONED_HM) {
 		if (f2fs_get_zone_blocks(i)) {
 			MSG(0, "\tError: Failed to get number of blocks per zone\n");
 			free(stat_buf);
@@ -1071,6 +1083,7 @@ int get_device_info(int i)
 
 int f2fs_get_device_info(void)
 {
+	bool zoned = false;
 	int i;
 
 	for (i = 0; i < c.ndevs; i++)
@@ -1089,22 +1102,26 @@ int f2fs_get_device_info(void)
 		return -1;
 	}
 
+	/* For zoned devices, the zones sizes must be equal */
 	for (i = 0; i < c.ndevs; i++) {
-		if (c.devices[i].zoned_model != F2FS_ZONED_NONE) {
-			if (c.zone_blocks &&
-				c.zone_blocks != c.devices[i].zone_blocks) {
-				MSG(0, "\tError: not support different zone sizes!!!\n");
-				return -1;
-			}
-			c.zone_blocks = c.devices[i].zone_blocks;
+		if (c.devices[i].zoned_model != F2FS_ZONED_HM)
+			continue;
+
+		zoned = true;
+
+		if (c.zone_blocks &&
+		    c.zone_blocks != c.devices[i].zone_blocks) {
+			MSG(0, "\tError: zones of different size are not supported\n");
+			return -1;
 		}
+		c.zone_blocks = c.devices[i].zone_blocks;
 	}
 
-	/*
-	 * Align sections to the device zone size
-	 * and align F2FS zones to the device zones.
-	 */
-	if (c.zone_blocks) {
+	if (zoned) {
+		/*
+		 * Align sections to the device zone size
+		 * and align F2FS zones to the device zones.
+		 */
 		c.segs_per_sec = c.zone_blocks / DEFAULT_BLOCKS_PER_SEGMENT;
 		c.secs_per_zone = 1;
 	} else {
-- 
2.20.1
