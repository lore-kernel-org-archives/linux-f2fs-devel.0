From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] mkfs.f2fs: fix incorrect cold data location
Date: Wed, 4 Apr 2018 10:49:14 +0800
Message-ID: <20180404024914.60177-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1f3YVK-0000JC-KH
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 04 Apr 2018 02:50:30 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f3YVG-007xfi-KN
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 04 Apr 2018 02:50:30 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

If last_zone((total_zones >> 2)) is equal or less than
next_zone(CURSEG_COLD_NODE), cold data area will be located in the
same position with hot data, fixes it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 mkfs/f2fs_format.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 65692bbe083a..8885f632371d 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -471,7 +471,7 @@ static int f2fs_prepare_super_block(void)
 		c.cur_seg[CURSEG_HOT_DATA] = next_zone(CURSEG_COLD_NODE);
 		c.cur_seg[CURSEG_COLD_DATA] =
 				max(last_zone((total_zones >> 2)),
-					next_zone(CURSEG_COLD_NODE));
+					next_zone(CURSEG_HOT_DATA));
 		c.cur_seg[CURSEG_WARM_DATA] =
 				max(last_zone((total_zones >> 1)),
 					next_zone(CURSEG_COLD_DATA));
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
