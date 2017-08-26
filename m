From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: fix a infinite loop in writting checkpoint
Date: Sat, 26 Aug 2017 12:15:35 +0800
Message-ID: <1503720935-23349-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <heyunlei@huawei.com>) id 1dlSil-0004in-96
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 26 Aug 2017 04:29:19 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1dlSij-0003mM-9C
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 26 Aug 2017 04:29:19 +0000
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

The loop reason is DIRTY IMETA always equal to 1:

Thread A:
-write_checkpoint
   -block_operations
       -f2fs_sync_inode_meta
           -igrab       <--- here igrab return NULL

Thread B:
-f2fs_evict_inode
   -remove_inode_page
       -truncate_xattr_node
          -__get_node_page
             -read_node_page   <---- here return -ENOENT

This patch walk around this cause.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/node.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 2654c91..ec7a0e0 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -973,8 +973,9 @@ int truncate_xattr_node(struct inode *inode, struct page *page)
 		return 0;
 
 	npage = get_node_page(sbi, nid);
-	if (IS_ERR(npage))
+	if (IS_ERR(npage) && PTR_ERR(npage) != -ENOENT) {
 		return PTR_ERR(npage);
+	}
 
 	f2fs_i_xnid_write(inode, 0);
 
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
