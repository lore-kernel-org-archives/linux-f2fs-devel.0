From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] f2fs: alloc_page() doesn't return an ERR_PTR
Date: Wed, 14 Aug 2013 14:41:36 +0300
Message-ID: <20130814114136.GA8044@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <dan.carpenter@oracle.com>) id 1V9ZSe-0007Yz-6j
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 14 Aug 2013 11:41:56 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1V9ZSc-0001q6-CV
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 14 Aug 2013 11:41:56 +0000
Content-Disposition: inline
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Cc: kernel-janitors@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

alloc_page() returns a NULL on failure, it never returns an ERR_PTR.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index f5172e2..3e87fe0 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1515,8 +1515,8 @@ int restore_node_summary(struct f2fs_sb_info *sbi,
 
 	/* alloc temporal page for read node */
 	page = alloc_page(GFP_NOFS | __GFP_ZERO);
-	if (IS_ERR(page))
-		return PTR_ERR(page);
+	if (!page)
+		return -ENOMEM;
 	lock_page(page);
 
 	/* scan the node segment */

------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
