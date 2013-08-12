From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 1/2] f2fs: check the free space first in
	new_node_page
Date: Mon, 12 Aug 2013 16:58:53 +0900
Message-ID: <1376294334-11699-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1V8n1n-0005x6-TX
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 12 Aug 2013 07:58:59 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V8n1l-0000Ue-Vk for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 12 Aug 2013 07:58:59 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MRE0009FRHUW4G0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 12 Aug 2013 16:58:51 +0900 (KST)
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

Let's check the free space in prior to the main process of allocating a new node
page.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/node.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index bb8fbda..858a333 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -833,29 +833,29 @@ struct page *new_node_page(struct dnode_of_data *dn,
 	if (!page)
 		return ERR_PTR(-ENOMEM);
 
-	get_node_info(sbi, dn->nid, &old_ni);
+	if (!inc_valid_node_count(sbi, dn->inode, 1)) {
+		err = -ENOSPC;
+		goto fail;
+	}
 
-	SetPageUptodate(page);
-	fill_node_footer(page, dn->nid, dn->inode->i_ino, ofs, true);
+	get_node_info(sbi, dn->nid, &old_ni);
 
 	/* Reinitialize old_ni with new node page */
 	BUG_ON(old_ni.blk_addr != NULL_ADDR);
 	new_ni = old_ni;
 	new_ni.ino = dn->inode->i_ino;
-
-	if (!inc_valid_node_count(sbi, dn->inode, 1)) {
-		err = -ENOSPC;
-		goto fail;
-	}
 	set_node_addr(sbi, &new_ni, NEW_ADDR);
+
+	fill_node_footer(page, dn->nid, dn->inode->i_ino, ofs, true);
 	set_cold_node(dn->inode, page);
+	SetPageUptodate(page);
+	set_page_dirty(page);
 
 	dn->node_page = page;
 	if (ipage)
 		update_inode(dn->inode, ipage);
 	else
 		sync_inode_page(dn);
-	set_page_dirty(page);
 	if (ofs == 0)
 		inc_valid_inode_count(sbi);
 
-- 
1.8.3.1.437.g0dbd812


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
