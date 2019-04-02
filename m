From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 1/3 v3] f2fs-tools: Improve zoned model check
Date: Tue,  2 Apr 2019 11:44:53 +0900
Message-ID: <20190402024455.2236-2-damien.lemoal@wdc.com>
References: <20190402024455.2236-1-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <prvs=988617210=damien.lemoal@wdc.com>)
 id 1hB9QA-0001oh-23
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 02 Apr 2019 02:45:06 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hB9Q8-00Ath5-9Y
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 02 Apr 2019 02:45:05 +0000
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

Return an error if an unknown zoned model is reported for a device or
if parsing of the device zoned model fails. Also add comments to
briefly explain the zone models and what to do in the absence of a
kernel reported zoned model for a device.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 include/f2fs_fs.h   |  2 +-
 lib/libf2fs.c       |  8 ++++++--
 lib/libf2fs_zoned.c | 38 ++++++++++++++++++++++++++------------
 3 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index e84cccc..c6669c9 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -1260,7 +1260,7 @@ blk_zone_cond_str(struct blk_zone *blkz)
 
 #endif
 
-extern void f2fs_get_zoned_model(int);
+extern int f2fs_get_zoned_model(int);
 extern int f2fs_get_zone_blocks(int);
 extern int f2fs_check_zones(int);
 extern int f2fs_reset_zones(int);
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 60b84e0..5ca1bb0 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -925,8 +925,12 @@ int get_device_info(int i)
 	}
 
 #if !defined(WITH_ANDROID) && defined(__linux__)
-	if (S_ISBLK(stat_buf->st_mode))
-		f2fs_get_zoned_model(i);
+	if (S_ISBLK(stat_buf->st_mode)) {
+		if (f2fs_get_zoned_model(i) < 0) {
+			free(stat_buf);
+			return -1;
+                }
+	}
 
 	if (dev->zoned_model != F2FS_ZONED_NONE) {
 		if (dev->zoned_model == F2FS_ZONED_HM)
diff --git a/lib/libf2fs_zoned.c b/lib/libf2fs_zoned.c
index 6e32f32..e396a95 100644
--- a/lib/libf2fs_zoned.c
+++ b/lib/libf2fs_zoned.c
@@ -24,7 +24,7 @@
 
 #ifdef HAVE_LINUX_BLKZONED_H
 
-void f2fs_get_zoned_model(int i)
+int f2fs_get_zoned_model(int i)
 {
 	struct device_info *dev = c.devices + i;
 	char str[128];
@@ -36,27 +36,41 @@ void f2fs_get_zoned_model(int i)
 		 "/sys/block/%s/queue/zoned",
 		 basename(dev->path));
 	file = fopen(str, "r");
-	if (!file)
-		goto not_zoned;
+	if (!file) {
+		/*
+		 * The kernel does not support zoned block devices, but we have
+		 * a block device file. This means that the device is not zoned
+		 * or is zoned but can be randomly written (i.e. host-aware
+		 * zoned model). Treat the device as a regular block device.
+		 */
+		dev->zoned_model = F2FS_ZONED_NONE;
+		return 0;
+	}
 
 	memset(str, 0, sizeof(str));
 	res = fscanf(file, "%s", str);
 	fclose(file);
 
-	if (res != 1)
-		goto not_zoned;
+	if (res != 1) {
+		MSG(0, "\tError: Failed to parse the device zoned model\n");
+		return -1;
+	}
 
-	if (strcmp(str, "host-aware") == 0) {
+	if (strcmp(str, "none") == 0) {
+		/* Regular block device */
+		dev->zoned_model = F2FS_ZONED_NONE;
+	} else if (strcmp(str, "host-aware") == 0) {
+		/* Host-aware zoned block device: can be randomly written */
 		dev->zoned_model = F2FS_ZONED_HA;
-		return;
-	}
-	if (strcmp(str, "host-managed") == 0) {
+	} else if (strcmp(str, "host-managed") == 0) {
+		/* Host-managed zoned block device: sequential writes needed */
 		dev->zoned_model = F2FS_ZONED_HM;
-		return;
+	} else {
+		MSG(0, "\tError: Unsupported device zoned model\n");
+		return -1;
 	}
 
-not_zoned:
-	dev->zoned_model = F2FS_ZONED_NONE;
+	return 0;
 }
 
 int f2fs_get_zone_blocks(int i)
-- 
2.20.1
