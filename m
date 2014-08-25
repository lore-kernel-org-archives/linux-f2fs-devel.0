From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: truncate stale block for inline_data
Date: Mon, 25 Aug 2014 15:33:40 -0700
Message-ID: <1409006020-5120-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XM2pe-0004Fo-NK
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 25 Aug 2014 22:33:46 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XM2pd-0001Ix-He for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 25 Aug 2014 22:33:46 +0000
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

This verifies to truncate any allocated blocks, offset[0], by inline_data.
Not figured out, but for making sure.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 044395c..4537819 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -823,22 +823,26 @@ int truncate_xattr_node(struct inode *inode, struct page *page)
  */
 void remove_inode_page(struct inode *inode)
 {
-	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
-	struct page *page;
-	nid_t ino = inode->i_ino;
 	struct dnode_of_data dn;
 
-	page = get_node_page(sbi, ino);
-	if (IS_ERR(page))
+	set_new_dnode(&dn, inode, NULL, NULL, inode->i_ino);
+	if (get_dnode_of_data(&dn, 0, LOOKUP_NODE))
 		return;
 
-	if (truncate_xattr_node(inode, page)) {
-		f2fs_put_page(page, 1);
+	if (truncate_xattr_node(inode, dn.inode_page)) {
+		f2fs_put_dnode(&dn);
 		return;
 	}
+
+	/* remove potential inline_data blocks */
+	if (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
+				S_ISLNK(inode->i_mode))
+		truncate_data_blocks_range(&dn, 1);
+
 	/* 0 is possible, after f2fs_new_inode() has failed */
 	f2fs_bug_on(inode->i_blocks != 0 && inode->i_blocks != 1);
-	set_new_dnode(&dn, inode, page, page, ino);
+
+	/* will put inode & node pages */
 	truncate_node(&dn);
 }
 
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
