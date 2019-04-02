From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 3/3 v3] f2fs-tools: Allow using host-aware
 devices as regular devices
Date: Tue,  2 Apr 2019 11:44:55 +0900
Message-ID: <20190402024455.2236-4-damien.lemoal@wdc.com>
References: <20190402024455.2236-1-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <prvs=988617210=damien.lemoal@wdc.com>)
 id 1hB9QC-0004aL-Ge
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 02 Apr 2019 02:45:08 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hB9QB-00Ath5-4r
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 02 Apr 2019 02:45:08 +0000
In-Reply-To: <20190402024455.2236-1-damien.lemoal@wdc.com>
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
Reviewed-by: Chao Yu <yuchao0@huawei.com>
---
 lib/libf2fs.c | 56 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 45 insertions(+), 11 deletions(-)

diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index b73b685..3afdd47 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -933,15 +933,18 @@ int get_device_info(int i)
 	}
 
 	if (dev->zoned_model != F2FS_ZONED_NONE) {
-		if (dev->zoned_model == F2FS_ZONED_HM)
-			c.zoned_model = F2FS_ZONED_HM;
 
+		/* Get the number of blocks per zones */
 		if (f2fs_get_zone_blocks(i)) {
 			MSG(0, "\tError: Failed to get number of blocks per zone\n");
 			free(stat_buf);
 			return -1;
 		}
 
+		/*
+		 * Check zone configuration: for the first disk of a
+		 * multi-device volume, conventional zones are needed.
+		 */
 		if (f2fs_check_zones(i)) {
 			MSG(0, "\tError: Failed to check zone configuration\n");
 			free(stat_buf);
@@ -1089,22 +1092,53 @@ int f2fs_get_device_info(void)
 		return -1;
 	}
 
+	/*
+	 * Check device types and determine the final volume operation mode:
+	 *   - If all devices are regular block devices, default operation.
+	 *   - If at least one HM device is found, operate in HM mode (BLKZONED
+	 *     feature will be enabled by mkfs).
+	 *   - If an HA device is found, let mkfs decide based on the -m option
+	 *     setting by the user.
+	 */
+	c.zoned_model = F2FS_ZONED_NONE;
 	for (i = 0; i < c.ndevs; i++) {
-		if (c.devices[i].zoned_model != F2FS_ZONED_NONE) {
+		switch (c.devices[i].zoned_model) {
+		case F2FS_ZONED_NONE:
+			continue;
+		case F2FS_ZONED_HM:
+			c.zoned_model = F2FS_ZONED_HM;
+			break;
+		case F2FS_ZONED_HA:
+			if (c.zoned_model != F2FS_ZONED_HM)
+				c.zoned_model = F2FS_ZONED_HA;
+			break;
+		}
+	}
+
+	if (c.zoned_model != F2FS_ZONED_NONE) {
+
+		/*
+		 * For zoned model, the zones sizes of all zoned devices must
+		 * be equal.
+		 */
+		for (i = 0; i < c.ndevs; i++) {
+			if (c.devices[i].zoned_model == F2FS_ZONED_NONE)
+				continue;
 			if (c.zone_blocks &&
-				c.zone_blocks != c.devices[i].zone_blocks) {
-				MSG(0, "\tError: not support different zone sizes!!!\n");
+		    	    c.zone_blocks != c.devices[i].zone_blocks) {
+				MSG(0, "\tError: zones of different size are "
+				       "not supported\n");
 				return -1;
 			}
 			c.zone_blocks = c.devices[i].zone_blocks;
 		}
-	}
 
-	/*
-	 * Align sections to the device zone size
-	 * and align F2FS zones to the device zones.
-	 */
-	if (c.zone_blocks) {
+		/*
+		 * Align sections to the device zone size and align F2FS zones
+		 * to the device zones. For F2FS_ZONED_HA model without the
+		 * BLKZONED feature set at format time, this is only an
+		 * optimization as sequential writes will not be enforced.
+		 */
 		c.segs_per_sec = c.zone_blocks / DEFAULT_BLOCKS_PER_SEGMENT;
 		c.secs_per_zone = 1;
 	} else {
-- 
2.20.1
