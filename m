From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/3] f2fs: avoid reading NAT page by get_node_info
Date: Mon, 13 Feb 2017 18:06:44 -0800
Message-ID: <20170214020644.18189-3-jaegeuk@kernel.org>
References: <20170214020644.18189-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cdSWE-0003Fi-Jy
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 14 Feb 2017 02:07:02 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cdSWC-0004ic-Ak
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 14 Feb 2017 02:07:02 +0000
In-Reply-To: <20170214020644.18189-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

We've not seen this buggy case for a long time, so it's time to avoid this
unnecessary get_node_info() call which reading NAT page to cache nat entry.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index e001d084667f..b63bdb85ad66 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1033,7 +1033,7 @@ struct page *new_node_page(struct dnode_of_data *dn,
 				unsigned int ofs, struct page *ipage)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
-	struct node_info old_ni, new_ni;
+	struct node_info new_ni;
 	struct page *page;
 	int err;
 
@@ -1049,12 +1049,11 @@ struct page *new_node_page(struct dnode_of_data *dn,
 		goto fail;
 	}
 
-	get_node_info(sbi, dn->nid, &old_ni);
-
-	/* Reinitialize old_ni with new node page */
-	f2fs_bug_on(sbi, old_ni.blk_addr != NULL_ADDR);
-	new_ni = old_ni;
+	new_ni.nid = dn->nid;
 	new_ni.ino = dn->inode->i_ino;
+	new_ni.blk_addr = NULL_ADDR;
+	new_ni.flag = 0;
+	new_ni.version = 0;
 	set_node_addr(sbi, &new_ni, NEW_ADDR, false);
 
 	f2fs_wait_on_page_writeback(page, NODE, true);
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
