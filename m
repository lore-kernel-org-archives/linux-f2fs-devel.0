From: Sheng Yong <shengyong1@huawei.com>
Subject: [RFC PATCH v2 1/2] f2fs: do not set LOST_PINO for newly
 created dir
Date: Mon, 26 Jun 2017 10:41:35 +0800
Message-ID: <20170626024136.211772-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shengyong1@huawei.com>) id 1dPK0R-00070i-KN
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 26 Jun 2017 02:44:03 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1dPK0P-0000ND-TF
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 26 Jun 2017 02:44:03 +0000
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
Cc: linux-f2fs-devel@lists.sourceforge.net

Since directories will be written back with checkpoint and fsync a
directory will always write CP, there is no need to set LOST_PINO
after creating a directory.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fs/f2fs/dir.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 94756f55a97e..37f9c7f55605 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -415,7 +415,8 @@ struct page *init_inode_metadata(struct inode *inode, struct inode *dir,
 	 * We lost i_pino from now on.
 	 */
 	if (is_inode_flag_set(inode, FI_INC_LINK)) {
-		file_lost_pino(inode);
+		if (!S_ISDIR(inode->i_mode))
+			file_lost_pino(inode);
 		/*
 		 * If link the tmpfile to alias through linkat path,
 		 * we should remove this inode from orphan list.
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
