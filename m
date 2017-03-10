From: Yunlei He <heyunlei@huawei.com>
Subject: [dev-test][PATCH 1/2] f2fs: add a missing
	truncate_inode_pages_final
Date: Fri, 10 Mar 2017 17:50:46 +0800
Message-ID: <20170310095047.14540-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1cmH8h-0008MI-UG
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 10 Mar 2017 09:47:11 +0000
Received: from [45.249.212.188] (helo=dggrg02-dlp.huawei.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cmH8f-0007SJ-S5
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 10 Mar 2017 09:47:11 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net

This patch add a missing truncate_inode_pages_final

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index cfb40d3..7ad2606 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -642,6 +642,8 @@ static int f2fs_drop_inode(struct inode *inode)
 			if (f2fs_is_atomic_file(inode))
 				drop_inmem_pages(inode);
 
+			truncate_inode_pages_final(&inode->i_data);
+
 			/* should remain fi->extent_tree for writepage */
 			f2fs_destroy_extent_node(inode);
 
-- 
2.10.1


------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford
