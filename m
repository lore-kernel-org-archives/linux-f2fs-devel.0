From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH] f2fs: check total CP pack block count correctly
Date: Wed, 1 Aug 2018 11:46:22 +0800
Message-ID: <20180801034622.162122-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <shengyong1@huawei.com>) id 1fki5z-0001Ta-Fu
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 01 Aug 2018 03:46:43 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fki5x-004taL-CB
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 01 Aug 2018 03:46:43 +0000
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
Cc: miaoxie@huawei.com, tony.zhangxiaobo@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Fixes: 652d19558a347 ('f2fs: fix to do sanity check with block address in main area')
Reported-by: Zhang Xiaobo <tony.zhangxiaobo@huawei.com>
Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fs/f2fs/checkpoint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 3587aa53dc90..c32ee10a1384 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -809,7 +809,7 @@ static struct page *validate_checkpoint(struct f2fs_sb_info *sbi,
 		goto invalid_cp1;
 
 	if (le32_to_cpu(cp_block->cp_pack_total_block_count) >
-					sbi->log_blocks_per_seg) {
+					sbi->blocks_per_seg - 1) {
 		f2fs_msg(sbi->sb, KERN_WARNING,
 			"invalid cp_pack_total_block_count:%u",
 			le32_to_cpu(cp_block->cp_pack_total_block_count));
-- 
2.17.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
