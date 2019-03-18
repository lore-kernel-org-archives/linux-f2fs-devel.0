From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 5/5] f2fs-tools: Fix multi-device format with
 zoned devices
Date: Mon, 18 Mar 2019 15:39:59 +0900
Message-ID: <20190318063959.21369-6-damien.lemoal@wdc.com>
References: <20190318063959.21369-1-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <prvs=973cf3254=damien.lemoal@wdc.com>)
 id 1h5lwV-0003mG-6K
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 18 Mar 2019 06:40:15 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h5lwT-00AHPl-D0
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 18 Mar 2019 06:40:15 +0000
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

There is no need to require conventional zones for a zoned block device
that is not the first device of a multi-device volume. So exclude the
check on the number of conventional zones of the device if the device
index is not 0.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 lib/libf2fs_zoned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/libf2fs_zoned.c b/lib/libf2fs_zoned.c
index 1a6c5df..2d8244f 100644
--- a/lib/libf2fs_zoned.c
+++ b/lib/libf2fs_zoned.c
@@ -204,7 +204,7 @@ int f2fs_check_zones(int j)
 		goto out;
 	}
 
-	if (dev->zoned_model == F2FS_ZONED_HM &&
+	if (j == 0 && dev->zoned_model == F2FS_ZONED_HM &&
 			!dev->nr_rnd_zones) {
 		ERR_MSG("No conventional zone for super block\n");
 		ret = -1;
-- 
2.20.1
