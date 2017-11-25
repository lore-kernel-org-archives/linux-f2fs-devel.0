From: Zhikang Zhang <zhangzhikang1@huawei.com>
Subject: [PATCH] f2fs: remove repeated f2fs_bug_on
Date: Sun, 26 Nov 2017 02:34:28 +0800
Message-ID: <1511634868-29349-1-git-send-email-zhangzhikang1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <zhangzhikang1@huawei.com>) id 1eIXuE-0003u6-JN
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 25 Nov 2017 10:41:54 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.89) id 1eIXuC-0004BL-OG
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 25 Nov 2017 10:41:54 +0000
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
Cc: ning.jia@huawei.com, heyunlei@huawei.com, shengyong1@huawei.com

f2fs: remove repeated f2fs_bug_on which has already existed
      in function invalidate_blocks.

Signed-off-by: Zhikang Zhang <zhangzhikang1@huawei.com>
---
 fs/f2fs/node.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index d332275..804c542 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -702,7 +702,6 @@ static void truncate_node(struct dnode_of_data *dn)
 	struct node_info ni;
 
 	get_node_info(sbi, dn->nid, &ni);
-	f2fs_bug_on(sbi, ni.blk_addr == NULL_ADDR);
 
 	/* Deallocate node address */
 	invalidate_blocks(sbi, ni.blk_addr);
@@ -2233,7 +2232,6 @@ int recover_xattr_data(struct inode *inode, struct page *page, block_t blkaddr)
 
 	/* 1: invalidate the previous xattr nid */
 	get_node_info(sbi, prev_xnid, &ni);
-	f2fs_bug_on(sbi, ni.blk_addr == NULL_ADDR);
 	invalidate_blocks(sbi, ni.blk_addr);
 	dec_valid_node_count(sbi, inode, false);
 	set_node_addr(sbi, &ni, NULL_ADDR, false);
-- 
2.7.4


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
