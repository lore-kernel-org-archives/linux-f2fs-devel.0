From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 3/5] f2fs-tools: Improve zoned model check
Date: Mon, 18 Mar 2019 15:39:57 +0900
Message-ID: <20190318063959.21369-4-damien.lemoal@wdc.com>
References: <20190318063959.21369-1-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <prvs=973cf3254=damien.lemoal@wdc.com>)
 id 1h5lwR-0003lQ-P9
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 18 Mar 2019 06:40:11 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h5lwQ-00AHPl-49
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 18 Mar 2019 06:40:11 +0000
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

Return an error if an unknown zoned model is reported for a device.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 include/f2fs_fs.h   |  2 +-
 lib/libf2fs.c       |  8 ++++++--
 lib/libf2fs_zoned.c | 20 +++++++++++---------
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index e073723..97ad774 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -1257,7 +1257,7 @@ blk_zone_cond_str(struct blk_zone *blkz)
 
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
index 6e32f32..1a6c5df 100644
--- a/lib/libf2fs_zoned.c
+++ b/lib/libf2fs_zoned.c
@@ -24,39 +24,41 @@
 
 #ifdef HAVE_LINUX_BLKZONED_H
 
-void f2fs_get_zoned_model(int i)
+int f2fs_get_zoned_model(int i)
 {
 	struct device_info *dev = c.devices + i;
 	char str[128];
 	FILE *file;
 	int res;
 
+	/* Assume regular device */
+	dev->zoned_model = F2FS_ZONED_NONE;
+
 	/* Check that this is a zoned block device */
 	snprintf(str, sizeof(str),
 		 "/sys/block/%s/queue/zoned",
 		 basename(dev->path));
 	file = fopen(str, "r");
 	if (!file)
-		goto not_zoned;
+		return 0;
 
 	memset(str, 0, sizeof(str));
 	res = fscanf(file, "%s", str);
 	fclose(file);
 
 	if (res != 1)
-		goto not_zoned;
+		return 0;
 
 	if (strcmp(str, "host-aware") == 0) {
 		dev->zoned_model = F2FS_ZONED_HA;
-		return;
-	}
-	if (strcmp(str, "host-managed") == 0) {
+	} else if (strcmp(str, "host-managed") == 0) {
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
