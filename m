From: Hyunchul Lee <hyc.lee@gmail.com>
Subject: [PATCH v2] f2fs: apply write hints to select the type of segment for direct write
Date: Tue, 28 Nov 2017 09:23:00 +0900
Message-ID: <1511828580-574-1-git-send-email-hyc.lee@gmail.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, kernel-team@lge.com, Jens Axboe <axboe@kernel.dk>, Hyunchul Lee <cheol.lee@lge.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Hyunchul Lee <cheol.lee@lge.com>

When blocks are allocated for direct write, select the type of
segment using the kiocb hint. But if an inode has FI_NO_ALLOC,
use the inode hint.

Signed-off-by: Hyunchul Lee <cheol.lee@lge.com>
---
v2: 
- Add a new member, m_seg_type to struct f2fs_map_blocks.
- Assign the segment type to m_seg_type and pass it to f2fs_map_blocks().

 fs/f2fs/data.c | 26 ++++++++++++++++++--------
 fs/f2fs/f2fs.h |  2 ++
 fs/f2fs/file.c |  6 ++++--
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 516fa0d..a7ae418 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -783,7 +783,7 @@ struct page *get_new_data_page(struct inode *inode,
 	return page;
 }
 
-static int __allocate_data_block(struct dnode_of_data *dn)
+static int __allocate_data_block(struct dnode_of_data *dn, int seg_type)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
 	struct f2fs_summary sum;
@@ -808,7 +808,7 @@ static int __allocate_data_block(struct dnode_of_data *dn)
 	set_summary(&sum, dn->nid, dn->ofs_in_node, ni.version);
 
 	allocate_data_block(sbi, NULL, dn->data_blkaddr, &dn->data_blkaddr,
-					&sum, CURSEG_WARM_DATA, NULL, false);
+					&sum, seg_type, NULL, false);
 	set_data_blkaddr(dn);
 
 	/* update i_size */
@@ -851,12 +851,15 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
 		map.m_len = 0;
 
 	map.m_next_pgofs = NULL;
+	map.m_seg_type = NO_CHECK_TYPE;
 
-	if (iocb->ki_flags & IOCB_DIRECT)
+	if (iocb->ki_flags & IOCB_DIRECT) {
+		map.m_seg_type = rw_hint_to_seg_type(iocb->ki_hint);
 		return f2fs_map_blocks(inode, &map, 1,
 			__force_buffered_io(inode, WRITE) ?
 				F2FS_GET_BLOCK_PRE_AIO :
 				F2FS_GET_BLOCK_PRE_DIO);
+	}
 	if (iocb->ki_pos + iov_iter_count(from) > MAX_INLINE_DATA(inode)) {
 		err = f2fs_convert_inline_inode(inode);
 		if (err)
@@ -960,7 +963,8 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 					last_ofs_in_node = dn.ofs_in_node;
 				}
 			} else {
-				err = __allocate_data_block(&dn);
+				err = __allocate_data_block(&dn,
+							map->m_seg_type);
 				if (!err)
 					set_inode_flag(inode, FI_APPEND_WRITE);
 			}
@@ -1053,7 +1057,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 
 static int __get_data_block(struct inode *inode, sector_t iblock,
 			struct buffer_head *bh, int create, int flag,
-			pgoff_t *next_pgofs)
+			pgoff_t *next_pgofs, int seg_type)
 {
 	struct f2fs_map_blocks map;
 	int err;
@@ -1061,6 +1065,7 @@ static int __get_data_block(struct inode *inode, sector_t iblock,
 	map.m_lblk = iblock;
 	map.m_len = bh->b_size >> inode->i_blkbits;
 	map.m_next_pgofs = next_pgofs;
+	map.m_seg_type = seg_type;
 
 	err = f2fs_map_blocks(inode, &map, create, flag);
 	if (!err) {
@@ -1076,14 +1081,17 @@ static int get_data_block(struct inode *inode, sector_t iblock,
 			pgoff_t *next_pgofs)
 {
 	return __get_data_block(inode, iblock, bh_result, create,
-							flag, next_pgofs);
+							flag, next_pgofs,
+							NO_CHECK_TYPE);
 }
 
 static int get_data_block_dio(struct inode *inode, sector_t iblock,
 			struct buffer_head *bh_result, int create)
 {
 	return __get_data_block(inode, iblock, bh_result, create,
-						F2FS_GET_BLOCK_DEFAULT, NULL);
+						F2FS_GET_BLOCK_DEFAULT, NULL,
+						rw_hint_to_seg_type(
+							inode->i_write_hint));
 }
 
 static int get_data_block_bmap(struct inode *inode, sector_t iblock,
@@ -1094,7 +1102,8 @@ static int get_data_block_bmap(struct inode *inode, sector_t iblock,
 		return -EFBIG;
 
 	return __get_data_block(inode, iblock, bh_result, create,
-						F2FS_GET_BLOCK_BMAP, NULL);
+						F2FS_GET_BLOCK_BMAP, NULL,
+						NO_CHECK_TYPE);
 }
 
 static inline sector_t logical_to_blk(struct inode *inode, loff_t offset)
@@ -1214,6 +1223,7 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 	map.m_len = 0;
 	map.m_flags = 0;
 	map.m_next_pgofs = NULL;
+	map.m_seg_type = NO_CHECK_TYPE;
 
 	for (page_idx = 0; nr_pages; page_idx++, nr_pages--) {
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f4e094e..7bcd148 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -542,6 +542,7 @@ struct f2fs_map_blocks {
 	unsigned int m_len;
 	unsigned int m_flags;
 	pgoff_t *m_next_pgofs;		/* point next possible non-hole pgofs */
+	int m_seg_type;
 };
 
 /* for flag in get_data_block */
@@ -2672,6 +2673,7 @@ int lookup_journal_in_cursum(struct f2fs_journal *journal, int type,
 void destroy_segment_manager(struct f2fs_sb_info *sbi);
 int __init create_segment_manager_caches(void);
 void destroy_segment_manager_caches(void);
+int rw_hint_to_seg_type(enum rw_hint hint);
 
 /*
  * checkpoint.c
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 7874bbd..57e4c5e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1436,7 +1436,8 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 					loff_t len, int mode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct f2fs_map_blocks map = { .m_next_pgofs = NULL };
+	struct f2fs_map_blocks map = { .m_next_pgofs = NULL,
+					.m_seg_type = NO_CHECK_TYPE };
 	pgoff_t pg_end;
 	loff_t new_size = i_size_read(inode);
 	loff_t off_end;
@@ -2084,7 +2085,8 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 					struct f2fs_defragment *range)
 {
 	struct inode *inode = file_inode(filp);
-	struct f2fs_map_blocks map = { .m_next_pgofs = NULL };
+	struct f2fs_map_blocks map = { .m_next_pgofs = NULL,
+					.m_seg_type = NO_CHECK_TYPE };
 	struct extent_info ei = {0,0,0};
 	pgoff_t pg_start, pg_end;
 	unsigned int blk_per_seg = sbi->blocks_per_seg;
-- 
1.9.1
