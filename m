From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH 3/3] dump.f2fs: do not write nat bits when
 dumping info
Date: Thu, 11 Jan 2018 10:17:21 +0800
Message-ID: <20180111021721.210437-3-shengyong1@huawei.com>
References: <20180111021721.210437-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <shengyong1@huawei.com>) id 1eZSRH-0005UD-2r
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 11 Jan 2018 02:17:55 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eZSRF-0005rA-Kn
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 11 Jan 2018 02:17:55 +0000
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

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fsck/mount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index 971fc5a..52dd6c3 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -2353,7 +2353,7 @@ int f2fs_do_mount(struct f2fs_sb_info *sbi)
 	}
 
 	/* Check nat_bits */
-	if (is_set_ckpt_flags(cp, CP_NAT_BITS_FLAG)) {
+	if (c.func != DUMP && is_set_ckpt_flags(cp, CP_NAT_BITS_FLAG)) {
 		u_int32_t nat_bits_bytes, nat_bits_blocks;
 		__le64 *kaddr;
 		u_int32_t blk;
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
