From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: Don't overwrite all types of node to keep
 node chain
Date: Wed, 7 Mar 2018 16:22:50 +0800
Message-ID: <1520410970-21987-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <heyunlei@huawei.com>) id 1etUYm-0019fi-Ss
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 07 Mar 2018 08:36:28 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=huawei.com) by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1etUYk-003J3t-5u
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 07 Mar 2018 08:36:28 +0000
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
Cc: heyunlei@huawei.com

Currently, we enable node SSR by default, and mixed
different types of node segment to do SSR more intensively.
Although reuse warm node is not allowed, warm node chain
will be destroyed by errors introduced by other types
node chain. So we'd better forbid reusing all types
of node to keep warm node chain.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index f61c77b..570e02d 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1862,7 +1862,7 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 			sbi->discard_blks--;
 
 		/* don't overwrite by SSR to keep node chain */
-		if (se->type == CURSEG_WARM_NODE) {
+		if (IS_NODESEG(se->type)) {
 			if (!f2fs_test_and_set_bit(offset, se->ckpt_valid_map))
 				se->ckpt_valid_blocks++;
 		}
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
