From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/4] f2fs: record node block allocation in dnode_of_data
Date: Tue, 22 Dec 2015 16:59:47 -0800
Message-ID: <1450832388-29118-3-git-send-email-jaegeuk@kernel.org>
References: <1450832388-29118-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450832388-29118-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch introduces recording node block allocation in dnode_of_data.
This information helps to figure out whether any node block is allocated during
specific file operations.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 1 +
 fs/f2fs/f2fs.h | 1 +
 fs/f2fs/file.c | 1 +
 fs/f2fs/node.c | 4 ++++
 4 files changed, 7 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index cf0c9dd..a7a9a05 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -226,6 +226,7 @@ void set_data_blkaddr(struct dnode_of_data *dn)
 	addr_array = blkaddr_in_node(rn);
 	addr_array[ofs_in_node] = cpu_to_le32(dn->data_blkaddr);
 	set_page_dirty(node_page);
+	dn->node_changed = true;
 }
 
 int reserve_new_block(struct dnode_of_data *dn)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 90fb970..0f4d329 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -547,6 +547,7 @@ struct dnode_of_data {
 	unsigned int ofs_in_node;	/* data offset in the node page */
 	bool inode_page_locked;		/* inode page is locked or not */
 	block_t	data_blkaddr;		/* block address of the node block */
+	bool node_changed;		/* is node block changed */
 };
 
 static inline void set_new_dnode(struct dnode_of_data *dn, struct inode *inode,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f2effe1..10ed357 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -484,6 +484,7 @@ int truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 		dec_valid_block_count(sbi, dn->inode, nr_free);
 		set_page_dirty(dn->node_page);
 		sync_inode_page(dn);
+		dn->node_changed = true;
 	}
 	dn->ofs_in_node = ofs;
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 6cc8ac7..ff2acb1 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -542,6 +542,7 @@ int get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 
 			set_nid(parent, offset[i - 1], nids[i], i == 1);
 			alloc_nid_done(sbi, nids[i]);
+			dn->node_changed = true;
 			done = true;
 		} else if (mode == LOOKUP_NODE_RA && i == level && level > 1) {
 			npage[i] = get_node_page_ra(parent, offset[i - 1]);
@@ -678,6 +679,7 @@ static int truncate_nodes(struct dnode_of_data *dn, unsigned int nofs,
 			if (ret < 0)
 				goto out_err;
 			set_nid(page, i, 0, false);
+			dn->node_changed = true;
 		}
 	} else {
 		child_nofs = nofs + ofs * (NIDS_PER_BLOCK + 1) + 1;
@@ -691,6 +693,7 @@ static int truncate_nodes(struct dnode_of_data *dn, unsigned int nofs,
 			ret = truncate_nodes(&rdn, child_nofs, 0, depth - 1);
 			if (ret == (NIDS_PER_BLOCK + 1)) {
 				set_nid(page, i, 0, false);
+				dn->node_changed = true;
 				child_nofs += ret;
 			} else if (ret < 0 && ret != -ENOENT) {
 				goto out_err;
@@ -752,6 +755,7 @@ static int truncate_partial_nodes(struct dnode_of_data *dn,
 		if (err < 0)
 			goto fail;
 		set_nid(pages[idx], i, 0, false);
+		dn->node_changed = true;
 	}
 
 	if (offset[idx + 1] == 0) {
-- 
2.5.4 (Apple Git-61)
