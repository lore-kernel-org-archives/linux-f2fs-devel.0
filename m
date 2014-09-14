From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 10/10] f2fs: fix double lock for inode page
	during roll-foward recovery
Date: Sun, 14 Sep 2014 15:14:24 -0700
Message-ID: <1410732864-53069-10-git-send-email-jaegeuk@kernel.org>
References: <1410732864-53069-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XTI4B-0001DP-8y
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 14 Sep 2014 22:14:43 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XTI4A-00039r-Bo for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 14 Sep 2014 22:14:43 +0000
In-Reply-To: <1410732864-53069-1-git-send-email-jaegeuk@kernel.org>
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

If the inode is same and its data index are needed to truncate, we can fall into
double lock for its inode page via get_dnode_of_data.

Error case is like this.

1. write data 1, 2, 3, 4, 5 in inode #4.
2. write data 100, 102, 103, 104, 105 in dnode #6 of inode #4.
3. sync
4. update data 100->106 in dnode #6.
5. fsync inode #4.
6. power-cut

-> Then,
1. go back to #3's checkpoint
2. in do_recover_data, get_dnode_of_data() gets inode #4.
3. detect 100->106 in dnode #6.
4. check_index_in_prev_nodes tries to truncate 100 in dnode #6.
5. to trigger truncate_hole, get_dnode_of_data should grab inode #4.
6. detect *kernel hang*

This patch should resolve that bug.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/recovery.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index dbeb32d..5638c05 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -306,16 +306,30 @@ got_it:
 	ino = ino_of_node(node_page);
 	f2fs_put_page(node_page, 1);
 
-	/* Deallocate previous index in the node page */
-	inode = f2fs_iget(sbi->sb, ino);
-	if (IS_ERR(inode))
-		return PTR_ERR(inode);
+	if (ino != dn->inode->i_ino) {
+		/* Deallocate previous index in the node page */
+		inode = f2fs_iget(sbi->sb, ino);
+		if (IS_ERR(inode))
+			return PTR_ERR(inode);
+	} else {
+		inode = dn->inode;
+	}
 
 	bidx = start_bidx_of_node(offset, F2FS_I(inode)) +
-					le16_to_cpu(sum.ofs_in_node);
+			le16_to_cpu(sum.ofs_in_node);
 
-	truncate_hole(inode, bidx, bidx + 1);
-	iput(inode);
+	if (ino != dn->inode->i_ino) {
+		truncate_hole(inode, bidx, bidx + 1);
+		iput(inode);
+	} else {
+		struct dnode_of_data tdn;
+		set_new_dnode(&tdn, inode, dn->inode_page, NULL, 0);
+		if (get_dnode_of_data(&tdn, bidx, LOOKUP_NODE))
+			return 0;
+		if (tdn.data_blkaddr != NULL_ADDR)
+			truncate_data_blocks_range(&tdn, 1);
+		f2fs_put_page(tdn.node_page, 1);
+	}
 	return 0;
 }
 
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
