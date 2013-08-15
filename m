From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch v2] f2fs: alloc_page() doesn't return an ERR_PTR
Date: Thu, 15 Aug 2013 08:54:56 +0300
Message-ID: <20130815055456.GD23580@elgon.mountain>
References: <1376486676.2354.5.camel@kjgkr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <dan.carpenter@oracle.com>) id 1V9qWn-00089Y-8t
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 15 Aug 2013 05:55:21 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1V9qWi-0006J3-Ig
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 15 Aug 2013 05:55:21 +0000
Content-Disposition: inline
In-Reply-To: <1376486676.2354.5.camel@kjgkr>
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
---
v2: fix the calls in recovery.c as well.

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
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 639eb34..889b4bd 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -129,8 +129,8 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head)
 
 	/* read node page */
 	page = alloc_page(GFP_F2FS_ZERO);
-	if (IS_ERR(page))
-		return PTR_ERR(page);
+	if (!page)
+		return -ENOMEM;
 	lock_page(page);
 
 	while (1) {
@@ -367,7 +367,7 @@ static int recover_data(struct f2fs_sb_info *sbi,
 
 	/* read node page */
 	page = alloc_page(GFP_NOFS | __GFP_ZERO);
-	if (IS_ERR(page))
+	if (!page)
 		return -ENOMEM;
 
 	lock_page(page);


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
