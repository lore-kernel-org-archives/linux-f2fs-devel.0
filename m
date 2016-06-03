From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 6/8] f2fs: avoid data race between FI_DIRTY_INODE
	flag and update_inode
Date: Thu,  2 Jun 2016 20:55:37 -0700
Message-ID: <1464926139-58252-6-git-send-email-jaegeuk@kernel.org>
References: <1464926139-58252-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1b8gDD-000104-PP
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 03 Jun 2016 03:55:55 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1b8gDD-00051O-2E
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 03 Jun 2016 03:55:55 +0000
In-Reply-To: <1464926139-58252-1-git-send-email-jaegeuk@kernel.org>
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

FI_DIRTY_INODE flag is not covered by inode page lock, so it can be unset
at any time like below.

Thread #1                        Thread #2
- lock_page(ipage)
- update i_fields
                                 - update i_size/i_blocks/and so on
				 - set FI_DIRTY_INODE
- reset FI_DIRTY_INODE
- set_page_dirty(ipage)

In this case, we can lose the latest i_field information.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index fb3d9bd..63c4326 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -231,6 +231,8 @@ int update_inode(struct inode *inode, struct page *node_page)
 {
 	struct f2fs_inode *ri;
 
+	f2fs_inode_synced(inode);
+
 	f2fs_wait_on_page_writeback(node_page, NODE, true);
 
 	ri = F2FS_INODE(node_page);
@@ -265,7 +267,6 @@ int update_inode(struct inode *inode, struct page *node_page)
 
 	__set_inode_rdev(inode, ri);
 	set_cold_node(inode, node_page);
-	f2fs_inode_synced(inode);
 
 	/* deleted inode */
 	if (inode->i_nlink == 0)
-- 
2.6.3


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity 
planning reports. https://ad.doubleclick.net/ddm/clk/305295220;132659582;e
