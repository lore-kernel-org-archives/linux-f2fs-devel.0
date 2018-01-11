From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH 2/3] mkfs.f2fs: set seed for random checkpoint_ver
Date: Thu, 11 Jan 2018 10:17:20 +0800
Message-ID: <20180111021721.210437-2-shengyong1@huawei.com>
References: <20180111021721.210437-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <shengyong1@huawei.com>) id 1eZSRG-00069m-Pm
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 11 Jan 2018 02:17:54 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eZSRF-0000BW-IO
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 11 Jan 2018 02:17:54 +0000
In-Reply-To: <20180111021721.210437-1-shengyong1@huawei.com>
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
Cc: shengyong1@huawei.com, linux-f2fs-devel@lists.sourceforge.net

If seed is not set, rand always uses 1 as the default seed.

Signed-off-by: Liu Xue <liuxueliu.liu@huawei.com>
Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 mkfs/f2fs_format.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index a130001..9d7e180 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -574,6 +574,7 @@ static int f2fs_write_check_point_pack(void)
 	}
 
 	/* 1. cp page 1 of checkpoint pack 1 */
+	srand(time(NULL));
 	cp->checkpoint_ver = cpu_to_le64(rand() | 0x1);
 	set_cp(cur_node_segno[0], c.cur_seg[CURSEG_HOT_NODE]);
 	set_cp(cur_node_segno[1], c.cur_seg[CURSEG_WARM_NODE]);
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
