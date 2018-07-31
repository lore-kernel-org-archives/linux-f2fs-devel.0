From: Junling Zheng <zhengjunling@huawei.com>
Subject: [PATCH] f2fs: remove unused cp_blkaddr in
 f2fs_sanity_check_ckpt
Date: Tue, 31 Jul 2018 13:21:52 +0800
Message-ID: <20180731052152.64939-1-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <zhengjunling@huawei.com>) id 1fkN6l-0001m1-Pb
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 Jul 2018 05:22:07 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fkN6j-003TSM-H4
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 31 Jul 2018 05:22:07 +0000
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
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Remove unused cp_blkaddr in f2fs_sanity_check_ckpt().

Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
---
 fs/f2fs/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index d56bc6eb8760..6ee003e87f63 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2297,7 +2297,7 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
 	unsigned int sit_bitmap_size, nat_bitmap_size;
 	unsigned int log_blocks_per_seg;
 	unsigned int segment_count_main;
-	unsigned int cp_pack_start_sum, cp_blkaddr, cp_payload;
+	unsigned int cp_pack_start_sum, cp_payload;
 	block_t user_block_count;
 	int i;
 
@@ -2359,7 +2359,6 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
 	}
 
 	cp_pack_start_sum = __start_sum_addr(sbi);
-	cp_blkaddr = __start_cp_addr(sbi);
 	cp_payload = __cp_payload(sbi);
 	if (cp_pack_start_sum < cp_payload + 1 ||
 		cp_pack_start_sum > blocks_per_seg - 1 -
-- 
2.18.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
