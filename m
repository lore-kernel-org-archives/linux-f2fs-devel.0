From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 4/4 v2] f2fs-tools: Fix multi-device format with
 zoned devices
Date: Wed, 27 Mar 2019 16:54:10 +0900
Message-ID: <20190327075410.15784-5-damien.lemoal@wdc.com>
References: <20190327075410.15784-1-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <prvs=9824208ba=damien.lemoal@wdc.com>)
 id 1h93OB-0004GM-DU
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 27 Mar 2019 07:54:23 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h93OA-00F4ud-7F
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 27 Mar 2019 07:54:23 +0000
In-Reply-To: <20190327075410.15784-1-damien.lemoal@wdc.com>
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
---
 lib/libf2fs_zoned.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

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
