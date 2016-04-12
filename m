From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/5] f2fs: add BUG_ON to avoid unnecessary flow
Date: Tue, 12 Apr 2016 10:42:37 -0700
Message-ID: <1460482960-14227-2-git-send-email-jaegeuk@kernel.org>
References: <1460482960-14227-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aq2L7-0007BK-0q
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 Apr 2016 17:43:01 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aq2L6-000793-9a
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 Apr 2016 17:43:00 +0000
In-Reply-To: <1460482960-14227-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch adds BUG_ON instead of retrying loop.
In the case of node pages, we already got this inode page, but unlocked it.
By the fact that we don't truncate any node pages in operations, the page's
mapping should be unchangeable.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index ade221c..095fc2c 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -832,7 +832,7 @@ int truncate_inode_blocks(struct inode *inode, pgoff_t from)
 	trace_f2fs_truncate_inode_blocks_enter(inode, from);
 
 	level = get_node_path(inode, from, offset, noffset);
-restart:
+
 	page = get_node_page(sbi, inode->i_ino);
 	if (IS_ERR(page)) {
 		trace_f2fs_truncate_inode_blocks_exit(inode, PTR_ERR(page));
@@ -896,10 +896,7 @@ skip_partial:
 		if (offset[1] == 0 &&
 				ri->i_nid[offset[0] - NODE_DIR1_BLOCK]) {
 			lock_page(page);
-			if (unlikely(page->mapping != NODE_MAPPING(sbi))) {
-				f2fs_put_page(page, 1);
-				goto restart;
-			}
+			BUG_ON(page->mapping != NODE_MAPPING(sbi));
 			f2fs_wait_on_page_writeback(page, NODE, true);
 			ri->i_nid[offset[0] - NODE_DIR1_BLOCK] = 0;
 			set_page_dirty(page);
-- 
2.6.3


------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
