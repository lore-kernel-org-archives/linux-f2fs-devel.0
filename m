From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: fix stale nids in an indirect node block
Date: Mon, 28 Mar 2016 10:41:38 -0700
Message-ID: <1459186898-44288-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1akbAd-0007IH-Ky
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 28 Mar 2016 17:41:43 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1akbAc-0003q0-Lw
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 28 Mar 2016 17:41:43 +0000
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

In truncate_inode_blocks, we can get some stale node block addresses in
the following scenario.

1. ipage = get_node_page(ino)
2. unlock_page(ipage)
3. trundate_dnode()
 - invalidates all the data indices
 - truncate node block
4. lock_page(ipage) and then failed, goto restart
5. -ENOMEM or -EIO between #1 and #3

In this case, we already invalidate node block, but its indirect block still
has its nid.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 118321b..780ce68 100644
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
@@ -840,7 +840,7 @@ restart:
 	}
 
 	set_new_dnode(&dn, inode, page, NULL, 0);
-	unlock_page(page);
+	dn.inode_page_locked = true;
 
 	ri = F2FS_INODE(page);
 	switch (level) {
@@ -895,22 +895,16 @@ skip_partial:
 			goto fail;
 		if (offset[1] == 0 &&
 				ri->i_nid[offset[0] - NODE_DIR1_BLOCK]) {
-			lock_page(page);
-			if (unlikely(page->mapping != NODE_MAPPING(sbi))) {
-				f2fs_put_page(page, 1);
-				goto restart;
-			}
 			f2fs_wait_on_page_writeback(page, NODE, true);
 			ri->i_nid[offset[0] - NODE_DIR1_BLOCK] = 0;
 			set_page_dirty(page);
-			unlock_page(page);
 		}
 		offset[1] = 0;
 		offset[0]++;
 		nofs += err;
 	}
 fail:
-	f2fs_put_page(page, 0);
+	f2fs_put_page(page, 1);
 	trace_f2fs_truncate_inode_blocks_exit(inode, err);
 	return err > 0 ? 0 : err;
 }
-- 
2.6.3


------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785471&iu=/4140
