From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/3] f2fs: switch to check FI_NO_EXTENT in
 f2fs_{lookup,update}_extent_cache
Date: Thu, 05 Feb 2015 18:02:44 +0800
Message-ID: <000901d0412a$fcc1de20$f6459a60$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch switch to check FI_NO_EXTENT in f2fs_{lookup,update}_extent_cache
instead of f2fs_{lookup,update}_extent_tree or {lookup,update}_extent_info.

No functionality modification in this patch.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 112db9c..45b97a5 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -273,9 +273,6 @@ static bool lookup_extent_info(struct inode *inode, pgoff_t pgofs,
 	pgoff_t start_fofs, end_fofs;
 	block_t start_blkaddr;
 
-	if (is_inode_flag_set(fi, FI_NO_EXTENT))
-		return false;
-
 	read_lock(&fi->ext_lock);
 	if (fi->ext.len == 0) {
 		read_unlock(&fi->ext_lock);
@@ -306,9 +303,6 @@ static bool update_extent_info(struct inode *inode, pgoff_t fofs,
 	block_t start_blkaddr, end_blkaddr;
 	int need_update = true;
 
-	if (is_inode_flag_set(fi, FI_NO_EXTENT))
-		return false;
-
 	write_lock(&fi->ext_lock);
 
 	start_fofs = fi->ext.fofs;
@@ -542,9 +536,6 @@ static bool f2fs_lookup_extent_tree(struct inode *inode, pgoff_t pgofs,
 	struct extent_tree *et;
 	struct extent_node *en;
 
-	if (is_inode_flag_set(F2FS_I(inode), FI_NO_EXTENT))
-		return false;
-
 	trace_f2fs_lookup_extent_tree_start(inode, pgofs);
 
 	down_read(&sbi->extent_tree_lock);
@@ -586,9 +577,6 @@ static void f2fs_update_extent_tree(struct inode *inode, pgoff_t fofs,
 	struct extent_info ei, dei;
 	unsigned int endofs;
 
-	if (is_inode_flag_set(F2FS_I(inode), FI_NO_EXTENT))
-		return;
-
 	trace_f2fs_update_extent_tree(inode, fofs, blkaddr);
 
 	down_write(&sbi->extent_tree_lock);
@@ -780,6 +768,9 @@ out:
 static bool f2fs_lookup_extent_cache(struct inode *inode, pgoff_t pgofs,
 							struct extent_info *ei)
 {
+	if (is_inode_flag_set(F2FS_I(inode), FI_NO_EXTENT))
+		return false;
+
 	if (test_opt(F2FS_I_SB(inode), EXTENT_CACHE))
 		return f2fs_lookup_extent_tree(inode, pgofs, ei);
 
@@ -796,6 +787,9 @@ void f2fs_update_extent_cache(struct dnode_of_data *dn)
 	/* Update the page address in the parent node */
 	__set_data_blkaddr(dn);
 
+	if (is_inode_flag_set(fi, FI_NO_EXTENT))
+		return;
+
 	fofs = start_bidx_of_node(ofs_of_node(dn->node_page), fi) +
 							dn->ofs_in_node;
 
-- 
2.2.1
