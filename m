From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH 2/2] f2fs-tools: remove duplicated declaration of
 f2fs_configuration c
Date: Tue, 10 Apr 2018 11:28:20 +0800
Message-ID: <20180410032820.80531-2-shengyong1@huawei.com>
References: <20180410032820.80531-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <shengyong1@huawei.com>) id 1f5jxn-0005c7-GB
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Apr 2018 03:28:55 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f5jxX-006RN1-Jl
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Apr 2018 03:28:55 +0000
In-Reply-To: <20180410032820.80531-1-shengyong1@huawei.com>
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
Cc: linux-f2fs-devel@lists.sourceforge.net

The variable `c' is declared twice in f2fs_fs.h. This patch removes
the second declaration.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 include/f2fs_fs.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 2b0be2d..cbfdab5 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -1232,8 +1232,6 @@ extern int f2fs_get_zone_blocks(int);
 extern int f2fs_check_zones(int);
 extern int f2fs_reset_zones(int);
 
-extern struct f2fs_configuration c;
-
 #define SIZE_ALIGN(val, size)	((val) + (size) - 1) / (size)
 #define SEG_ALIGN(blks)		SIZE_ALIGN(blks, c.blks_per_seg)
 #define ZONE_ALIGN(blks)	SIZE_ALIGN(blks, c.blks_per_seg * \
-- 
2.14.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
