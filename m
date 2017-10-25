From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH v2] f2fs: modify for accurate fggc node io stat
Date: Wed, 25 Oct 2017 11:05:03 +0800
Message-ID: <1508900703-30453-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <heyunlei@huawei.com>) id 1e7C2Y-0003UQ-IV
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 25 Oct 2017 03:07:34 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1e7C2U-0004Dw-AI
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 25 Oct 2017 03:07:34 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, yuchao0@huawei.com
Cc: ning.jia@huawei.com, Yunlei He <heyunlei@huawei.com>

modify for accurate fggc node io stat

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/node.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index f44d837..f4f2894 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1259,7 +1259,7 @@ void move_node_page(struct page *node_page, int gc_type)
 		if (!clear_page_dirty_for_io(node_page))
 			goto out_page;
 
-		if (NODE_MAPPING(sbi)->a_ops->writepage(node_page, &wbc))
+		if (__write_node_page(page, false, NULL, &wbc, false, FS_GC_NODE_IO))
 			unlock_page(node_page);
 		goto release_page;
 	} else {
-- 
2.7.4


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
