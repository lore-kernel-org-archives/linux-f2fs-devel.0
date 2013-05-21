From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [f2fs-dev] [PATCH 3/3] f2fs: fix wrong condition check
Date: Tue, 21 May 2013 12:56:33 +0900
Message-ID: <1369108593-880-3-git-send-email-jaegeuk.kim@samsung.com>
References: <1369108593-880-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1UediW-0007bv-8S
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 21 May 2013 03:58:28 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UediV-0008JB-Gd for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 21 May 2013 03:58:28 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MN400294R151BI0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 21 May 2013 12:58:17 +0900 (KST)
In-reply-to: <1369108593-880-1-git-send-email-jaegeuk.kim@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

While an orphan inode has zero link_count, f2fs_gc is able to select the inode
for foreground gc.

- f2fs_gc
 - do_garbage_collect
   - gc_data_segment
     : f2fs_iget is failed
     : get_valid_blocks() != 0, so that retry
--> here we got the infinite loop.

This patch resolved this issue.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/inode.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index a18946e..b44a4c1 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -109,12 +109,6 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 	ret = do_read_inode(inode);
 	if (ret)
 		goto bad_inode;
-
-	if (!sbi->por_doing && inode->i_nlink == 0) {
-		ret = -ENOENT;
-		goto bad_inode;
-	}
-
 make_now:
 	if (ino == F2FS_NODE_INO(sbi)) {
 		inode->i_mapping->a_ops = &f2fs_node_aops;
-- 
1.8.1.3.566.gaa39828


------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
