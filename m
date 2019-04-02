From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 2/3 v3] f2fs-tools: Fix multi-device format with
 zoned devices
Date: Tue,  2 Apr 2019 11:44:54 +0900
Message-ID: <20190402024455.2236-3-damien.lemoal@wdc.com>
References: <20190402024455.2236-1-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <prvs=988617210=damien.lemoal@wdc.com>)
 id 1hB9QB-000762-7Q
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 02 Apr 2019 02:45:07 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hB9Q9-00Ath5-Vz
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 02 Apr 2019 02:45:07 +0000
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

There is no need to require conventional zones for a zoned block device
that is not the first device of a multi-device volume. As a result,
there is no need to check the number of conventional zones of the
device if the device index is not 0.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
---
 lib/libf2fs.c       | 2 +-
 lib/libf2fs_zoned.c | 9 ++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 5ca1bb0..b73b685 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -929,7 +929,7 @@ int get_device_info(int i)
 		if (f2fs_get_zoned_model(i) < 0) {
 			free(stat_buf);
 			return -1;
-                }
+		}
 	}
 
 	if (dev->zoned_model != F2FS_ZONED_NONE) {
diff --git a/lib/libf2fs_zoned.c b/lib/libf2fs_zoned.c
index e396a95..97afe0b 100644
--- a/lib/libf2fs_zoned.c
+++ b/lib/libf2fs_zoned.c
@@ -216,7 +216,14 @@ int f2fs_check_zones(int j)
 		goto out;
 	}
 
-	if (dev->zoned_model == F2FS_ZONED_HM &&
+	/*
+	 * For a multi-device volume, fixed position metadata blocks are
+	 * stored * only on the first device of the volume. Checking for the
+	 * presence of * conventional zones (randomly writeabl zones) for
+	 * storing these blocks * on a host-managed device is thus needed only
+	 * for the device index 0.
+	 */
+	if (j == 0 && dev->zoned_model == F2FS_ZONED_HM &&
 			!dev->nr_rnd_zones) {
 		ERR_MSG("No conventional zone for super block\n");
 		ret = -1;
-- 
2.20.1
