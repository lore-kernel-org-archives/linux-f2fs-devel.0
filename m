From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: update inode info to inode page for new
 file
Date: Wed, 3 Jan 2018 18:03:04 +0800
Message-ID: <1514973784-16037-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <heyunlei@huawei.com>) id 1eWg6g-0000UW-BC
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 03 Jan 2018 10:17:10 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eWg6e-0001x7-AH
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 03 Jan 2018 10:17:10 +0000
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
Cc: ning.jia@huawei.com, heyunlei@huawei.com

			|
			| 1. creat a new file A ,(with dirty inode
			|    && dirty inode page && xattr info)
			| 2. backgroud wb write back file A inode
	last checkpoint	|    page (without update from inode cache)
			| 3. fsync file A, write back inode page of
			|    file A with inode cache info
			| 4. sudden power off before new checkpoint

In this case, recovery process will try to recover a zero inode
page. Inline xattr flag of file A will be miss and xattr info
will be taken as blkaddr index.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/dir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 724304d..d04dcac 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -427,6 +427,8 @@ struct page *init_inode_metadata(struct inode *inode, struct inode *dir,
 			remove_orphan_inode(F2FS_I_SB(dir), inode->i_ino);
 		f2fs_i_links_write(inode, true);
 	}
+
+	update_inode(inode, page);
 	return page;
 
 put_error:
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
