From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] fsck.f2fs: write back last cp block in the end
Date: Wed, 23 Aug 2017 12:13:04 +0800
Message-ID: <1503461584-4449-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <heyunlei@huawei.com>) id 1dkNFX-0002tV-9W
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 23 Aug 2017 04:26:39 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1dkNFV-0003Ej-NF
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 23 Aug 2017 04:26:39 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net
Cc: heyunlei@huawei.com, morgan.wang@huawei.com

Write back last cp block in the end in case of sudden power off
during fsck process

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fsck/mount.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index a0b0bea..700a4ff 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1918,13 +1918,16 @@ void write_checkpoint(struct f2fs_sb_info *sbi)
 		ASSERT(ret >= 0);
 	}
 
-	/* write the last cp */
-	ret = dev_write_block(cp, cp_blk_no++);
-	ASSERT(ret >= 0);
-
 	/* Write nat bits */
 	if (flags & CP_NAT_BITS_FLAG)
 		write_nat_bits(sbi, sb, cp, sbi->cur_cp);
+
+	/* in case of sudden power off */
+	f2fs_finalize_device();
+
+	/* write the last cp */
+	ret = dev_write_block(cp, cp_blk_no++);
+	ASSERT(ret >= 0);
 }
 
 void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
