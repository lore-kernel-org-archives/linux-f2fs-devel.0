From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/5] f2fs: fix mismatching lock and unlock pages for roll-forward recovery
Date: Thu,  2 Apr 2015 10:49:21 -0700
Message-ID: <1427996965-10578-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Previously, inode page is not correctly locked and unlocked in pair during
the roll-forward recovery.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/recovery.c | 48 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index e60ffaa..c69de88 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -258,6 +258,7 @@ static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
 	struct f2fs_summary_block *sum_node;
 	struct f2fs_summary sum;
 	struct page *sum_page, *node_page;
+	struct dnode_of_data tdn = *dn;
 	nid_t ino, nid;
 	struct inode *inode;
 	unsigned int offset;
@@ -285,17 +286,15 @@ got_it:
 	/* Use the locked dnode page and inode */
 	nid = le32_to_cpu(sum.nid);
 	if (dn->inode->i_ino == nid) {
-		struct dnode_of_data tdn = *dn;
 		tdn.nid = nid;
+		if (!dn->inode_page_locked)
+			lock_page(dn->inode_page);
 		tdn.node_page = dn->inode_page;
 		tdn.ofs_in_node = le16_to_cpu(sum.ofs_in_node);
-		truncate_data_blocks_range(&tdn, 1);
-		return 0;
+		goto truncate_out;
 	} else if (dn->nid == nid) {
-		struct dnode_of_data tdn = *dn;
 		tdn.ofs_in_node = le16_to_cpu(sum.ofs_in_node);
-		truncate_data_blocks_range(&tdn, 1);
-		return 0;
+		goto truncate_out;
 	}
 
 	/* Get the node page */
@@ -319,18 +318,33 @@ got_it:
 	bidx = start_bidx_of_node(offset, F2FS_I(inode)) +
 			le16_to_cpu(sum.ofs_in_node);
 
-	if (ino != dn->inode->i_ino) {
-		truncate_hole(inode, bidx, bidx + 1);
+	/*
+	 * if inode page is locked, unlock temporarily, but its reference
+	 * count keeps alive.
+	 */
+	if (ino == dn->inode->i_ino && dn->inode_page_locked)
+		unlock_page(dn->inode_page);
+
+	set_new_dnode(&tdn, inode, NULL, NULL, 0);
+	if (get_dnode_of_data(&tdn, bidx, LOOKUP_NODE))
+		goto out;
+
+	if (tdn.data_blkaddr == blkaddr)
+		truncate_data_blocks_range(&tdn, 1);
+
+	f2fs_put_dnode(&tdn);
+out:
+	if (ino != dn->inode->i_ino)
 		iput(inode);
-	} else {
-		struct dnode_of_data tdn;
-		set_new_dnode(&tdn, inode, dn->inode_page, NULL, 0);
-		if (get_dnode_of_data(&tdn, bidx, LOOKUP_NODE))
-			return 0;
-		if (tdn.data_blkaddr != NULL_ADDR)
-			truncate_data_blocks_range(&tdn, 1);
-		f2fs_put_page(tdn.node_page, 1);
-	}
+	else if (dn->inode_page_locked)
+		lock_page(dn->inode_page);
+	return 0;
+
+truncate_out:
+	if (datablock_addr(tdn.node_page, tdn.ofs_in_node) == blkaddr)
+		truncate_data_blocks_range(&tdn, 1);
+	if (dn->inode->i_ino == nid && !dn->inode_page_locked)
+		unlock_page(dn->inode_page);
 	return 0;
 }
 
-- 
2.1.1

