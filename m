From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/3] f2fs: simplify f2fs_map_blocks
Date: Tue, 19 Jan 2016 18:53:25 +0800
Message-ID: <001701d152a7$b73efe70$25bcfb50$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

In f2fs_map_blocks, we use duplicated codes to handle first block mapping
and the following blocks mapping, it's unnecessary. This patch simplifies
f2fs_map_blocks to avoid using copied codes.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c | 101 ++++++++++++++++++---------------------------------------
 1 file changed, 32 insertions(+), 69 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ac9e7c6..3564e8e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -595,6 +595,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 		goto out;
 	}
 
+next_dnode:
 	if (create)
 		f2fs_lock_op(sbi);
 
@@ -607,47 +608,57 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 		goto unlock_out;
 	}
 
-	if (dn.data_blkaddr == NEW_ADDR || dn.data_blkaddr == NULL_ADDR) {
+	end_offset = ADDRS_PER_PAGE(dn.node_page, F2FS_I(inode));
+
+next_block:
+	blkaddr = datablock_addr(dn.node_page, dn.ofs_in_node);
+
+	if (blkaddr == NEW_ADDR || blkaddr == NULL_ADDR) {
 		if (create) {
 			if (unlikely(f2fs_cp_error(sbi))) {
 				err = -EIO;
-				goto put_out;
+				goto sync_out;
 			}
 			err = __allocate_data_block(&dn);
 			if (err)
-				goto put_out;
+				goto sync_out;
 			allocated = true;
 			map->m_flags = F2FS_MAP_NEW;
+			blkaddr = dn.data_blkaddr;
 		} else {
 			if (flag != F2FS_GET_BLOCK_FIEMAP ||
-						dn.data_blkaddr != NEW_ADDR) {
+						blkaddr != NEW_ADDR) {
 				if (flag == F2FS_GET_BLOCK_BMAP)
 					err = -ENOENT;
-				goto put_out;
+				goto sync_out;
 			}
-
-			/*
-			 * preallocated unwritten block should be mapped
-			 * for fiemap.
-			 */
-			if (dn.data_blkaddr == NEW_ADDR)
-				map->m_flags = F2FS_MAP_UNWRITTEN;
 		}
 	}
 
-	map->m_flags |= F2FS_MAP_MAPPED;
-	map->m_pblk = dn.data_blkaddr;
-	map->m_len = 1;
+	if (map->m_len == 0) {
+		/* preallocated unwritten block should be mapped for fiemap. */
+		if (blkaddr == NEW_ADDR)
+			map->m_flags |= F2FS_MAP_UNWRITTEN;
+		map->m_flags |= F2FS_MAP_MAPPED;
+
+		map->m_pblk = blkaddr;
+		map->m_len = 1;
+	} else if ((map->m_pblk != NEW_ADDR &&
+			blkaddr == (map->m_pblk + ofs)) ||
+			(map->m_pblk == NEW_ADDR && blkaddr == NEW_ADDR)) {
+		ofs++;
+		map->m_len++;
+	} else {
+		goto sync_out;
+	}
 
-	end_offset = ADDRS_PER_PAGE(dn.node_page, F2FS_I(inode));
 	dn.ofs_in_node++;
 	pgofs++;
 
-get_next:
-	if (map->m_len >= maxblocks)
-		goto sync_out;
+	if (map->m_len < maxblocks) {
+		if (dn.ofs_in_node < end_offset)
+			goto next_block;
 
-	if (dn.ofs_in_node >= end_offset) {
 		if (allocated)
 			sync_inode_page(&dn);
 		allocated = false;
@@ -656,61 +667,13 @@ get_next:
 		if (create) {
 			f2fs_unlock_op(sbi);
 			f2fs_balance_fs(sbi, dn.node_changed);
-			f2fs_lock_op(sbi);
-		}
-
-		set_new_dnode(&dn, inode, NULL, NULL, 0);
-		err = get_dnode_of_data(&dn, pgofs, mode);
-		if (err) {
-			if (err == -ENOENT)
-				err = 0;
-			goto unlock_out;
-		}
-
-		end_offset = ADDRS_PER_PAGE(dn.node_page, F2FS_I(inode));
-	}
-
-	blkaddr = datablock_addr(dn.node_page, dn.ofs_in_node);
-
-	if (blkaddr == NEW_ADDR || blkaddr == NULL_ADDR) {
-		if (create) {
-			if (unlikely(f2fs_cp_error(sbi))) {
-				err = -EIO;
-				goto sync_out;
-			}
-			err = __allocate_data_block(&dn);
-			if (err)
-				goto sync_out;
-			allocated = true;
-			map->m_flags |= F2FS_MAP_NEW;
-			blkaddr = dn.data_blkaddr;
-		} else {
-			/*
-			 * we only merge preallocated unwritten blocks
-			 * for fiemap.
-			 */
-			if (flag != F2FS_GET_BLOCK_FIEMAP ||
-					blkaddr != NEW_ADDR)
-				goto sync_out;
 		}
-	}
-
-	/* Give more consecutive addresses for the readahead */
-	if ((map->m_pblk != NEW_ADDR &&
-			blkaddr == (map->m_pblk + ofs)) ||
-			(map->m_pblk == NEW_ADDR &&
-			blkaddr == NEW_ADDR)) {
-		ofs++;
-		dn.ofs_in_node++;
-		pgofs++;
-		map->m_len++;
-		goto get_next;
+		goto next_dnode;
 	}
 
 sync_out:
 	if (allocated)
 		sync_inode_page(&dn);
-put_out:
 	f2fs_put_dnode(&dn);
 unlock_out:
 	if (create) {
-- 
2.6.3
