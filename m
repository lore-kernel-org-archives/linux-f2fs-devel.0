From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 05/19] f2fs: add f2fs_map_blocks
Date: Fri,  1 May 2015 17:48:32 -0700
Message-ID: <1430527726-68547-5-git-send-email-jaegeuk@kernel.org>
References: <1430527726-68547-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430527726-68547-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch introduces f2fs_map_blocks structure likewise ext4_map_blocks.
Now, f2fs uses f2fs_map_blocks when handling get_block.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c              | 72 ++++++++++++++++++++++++++-------------------
 fs/f2fs/f2fs.h              | 16 ++++++++++
 include/trace/events/f2fs.h | 28 +++++++++---------
 3 files changed, 71 insertions(+), 45 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 1e1aae6..aa3c079 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -251,19 +251,6 @@ int f2fs_reserve_block(struct dnode_of_data *dn, pgoff_t index)
 	return err;
 }
 
-static void f2fs_map_bh(struct super_block *sb, pgoff_t pgofs,
-			struct extent_info *ei, struct buffer_head *bh_result)
-{
-	unsigned int blkbits = sb->s_blocksize_bits;
-	size_t max_size = bh_result->b_size;
-	size_t mapped_size;
-
-	clear_buffer_new(bh_result);
-	map_bh(bh_result, sb, ei->blk + pgofs - ei->fofs);
-	mapped_size = (ei->fofs + ei->len - pgofs) << blkbits;
-	bh_result->b_size = min(max_size, mapped_size);
-}
-
 static bool lookup_extent_info(struct inode *inode, pgoff_t pgofs,
 							struct extent_info *ei)
 {
@@ -1208,18 +1195,18 @@ out:
 }
 
 /*
- * get_data_block() now supported readahead/bmap/rw direct_IO with mapped bh.
+ * f2fs_map_blocks() now supported readahead/bmap/rw direct_IO with
+ * f2fs_map_blocks structure.
  * If original data blocks are allocated, then give them to blockdev.
  * Otherwise,
  *     a. preallocate requested block addresses
  *     b. do not use extent cache for better performance
  *     c. give the block addresses to blockdev
  */
-static int __get_data_block(struct inode *inode, sector_t iblock,
-			struct buffer_head *bh_result, int create, bool fiemap)
+static int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
+			int create, bool fiemap)
 {
-	unsigned int blkbits = inode->i_sb->s_blocksize_bits;
-	unsigned maxblocks = bh_result->b_size >> blkbits;
+	unsigned int maxblocks = map->m_len;
 	struct dnode_of_data dn;
 	int mode = create ? ALLOC_NODE : LOOKUP_NODE_RA;
 	pgoff_t pgofs, end_offset;
@@ -1227,11 +1214,16 @@ static int __get_data_block(struct inode *inode, sector_t iblock,
 	struct extent_info ei;
 	bool allocated = false;
 
-	/* Get the page offset from the block offset(iblock) */
-	pgofs =	(pgoff_t)(iblock >> (PAGE_CACHE_SHIFT - blkbits));
+	map->m_len = 0;
+	map->m_flags = 0;
+
+	/* it only supports block size == page size */
+	pgofs =	(pgoff_t)map->m_lblk;
 
 	if (f2fs_lookup_extent_cache(inode, pgofs, &ei)) {
-		f2fs_map_bh(inode->i_sb, pgofs, &ei, bh_result);
+		map->m_pblk = ei.blk + pgofs - ei.fofs;
+		map->m_len = min((pgoff_t)maxblocks, ei.fofs + ei.len - pgofs);
+		map->m_flags = F2FS_MAP_MAPPED;
 		goto out;
 	}
 
@@ -1250,21 +1242,21 @@ static int __get_data_block(struct inode *inode, sector_t iblock,
 		goto put_out;
 
 	if (dn.data_blkaddr != NULL_ADDR) {
-		clear_buffer_new(bh_result);
-		map_bh(bh_result, inode->i_sb, dn.data_blkaddr);
+		map->m_flags = F2FS_MAP_MAPPED;
+		map->m_pblk = dn.data_blkaddr;
 	} else if (create) {
 		err = __allocate_data_block(&dn);
 		if (err)
 			goto put_out;
 		allocated = true;
-		set_buffer_new(bh_result);
-		map_bh(bh_result, inode->i_sb, dn.data_blkaddr);
+		map->m_flags = F2FS_MAP_NEW | F2FS_MAP_MAPPED;
+		map->m_pblk = dn.data_blkaddr;
 	} else {
 		goto put_out;
 	}
 
 	end_offset = ADDRS_PER_PAGE(dn.node_page, F2FS_I(inode));
-	bh_result->b_size = (((size_t)1) << blkbits);
+	map->m_len = 1;
 	dn.ofs_in_node++;
 	pgofs++;
 
@@ -1288,22 +1280,22 @@ get_next:
 		end_offset = ADDRS_PER_PAGE(dn.node_page, F2FS_I(inode));
 	}
 
-	if (maxblocks > (bh_result->b_size >> blkbits)) {
+	if (maxblocks > map->m_len) {
 		block_t blkaddr = datablock_addr(dn.node_page, dn.ofs_in_node);
 		if (blkaddr == NULL_ADDR && create) {
 			err = __allocate_data_block(&dn);
 			if (err)
 				goto sync_out;
 			allocated = true;
-			set_buffer_new(bh_result);
+			map->m_flags |= F2FS_MAP_NEW;
 			blkaddr = dn.data_blkaddr;
 		}
 		/* Give more consecutive addresses for the readahead */
-		if (blkaddr == (bh_result->b_blocknr + ofs)) {
+		if (map->m_pblk != NEW_ADDR && blkaddr == (map->m_pblk + ofs)) {
 			ofs++;
 			dn.ofs_in_node++;
 			pgofs++;
-			bh_result->b_size += (((size_t)1) << blkbits);
+			map->m_len++;
 			goto get_next;
 		}
 	}
@@ -1316,10 +1308,28 @@ unlock_out:
 	if (create)
 		f2fs_unlock_op(F2FS_I_SB(inode));
 out:
-	trace_f2fs_get_data_block(inode, iblock, bh_result, err);
+	trace_f2fs_map_blocks(inode, map, err);
 	return err;
 }
 
+static int __get_data_block(struct inode *inode, sector_t iblock,
+			struct buffer_head *bh, int create, bool fiemap)
+{
+	struct f2fs_map_blocks map;
+	int ret;
+
+	map.m_lblk = iblock;
+	map.m_len = bh->b_size >> inode->i_blkbits;
+
+	ret = f2fs_map_blocks(inode, &map, create, fiemap);
+	if (!ret) {
+		map_bh(bh, inode->i_sb, map.m_pblk);
+		bh->b_state = (bh->b_state & ~F2FS_MAP_FLAGS) | map.m_flags;
+		bh->b_size = map.m_len << inode->i_blkbits;
+	}
+	return ret;
+}
+
 static int get_data_block(struct inode *inode, sector_t iblock,
 			struct buffer_head *bh_result, int create)
 {
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e1dd986..c98454d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -322,6 +322,22 @@ struct extent_tree {
 };
 
 /*
+ * This structure is taken from ext4_map_blocks.
+ *
+ * Note that, however, f2fs uses NEW and MAPPED flags for f2fs_map_blocks().
+ */
+#define F2FS_MAP_NEW		(1 << BH_New)
+#define F2FS_MAP_MAPPED		(1 << BH_Mapped)
+#define F2FS_MAP_FLAGS		(F2FS_MAP_NEW | F2FS_MAP_MAPPED)
+
+struct f2fs_map_blocks {
+	block_t m_pblk;
+	block_t m_lblk;
+	unsigned int m_len;
+	unsigned int m_flags;
+};
+
+/*
  * i_advise uses FADVISE_XXX_BIT. We can add additional hints later.
  */
 #define FADVISE_COLD_BIT	0x01
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 7a61ccc..04856a2 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -117,6 +117,7 @@ TRACE_DEFINE_ENUM(CP_DISCARD);
 		{ CP_DISCARD,	"Discard" })
 
 struct victim_sel_policy;
+struct f2fs_map_blocks;
 
 DECLARE_EVENT_CLASS(f2fs__inode,
 
@@ -481,36 +482,35 @@ TRACE_EVENT(f2fs_truncate_partial_nodes,
 		__entry->err)
 );
 
-TRACE_EVENT(f2fs_get_data_block,
-	TP_PROTO(struct inode *inode, sector_t iblock,
-				struct buffer_head *bh, int ret),
+TRACE_EVENT(f2fs_map_blocks,
+	TP_PROTO(struct inode *inode, struct f2fs_map_blocks *map, int ret),
 
-	TP_ARGS(inode, iblock, bh, ret),
+	TP_ARGS(inode, map, ret),
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
 		__field(ino_t,	ino)
-		__field(sector_t,	iblock)
-		__field(sector_t,	bh_start)
-		__field(size_t,	bh_size)
+		__field(block_t,	m_lblk)
+		__field(block_t,	m_pblk)
+		__field(unsigned int,	m_len)
 		__field(int,	ret)
 	),
 
 	TP_fast_assign(
 		__entry->dev		= inode->i_sb->s_dev;
 		__entry->ino		= inode->i_ino;
-		__entry->iblock		= iblock;
-		__entry->bh_start	= bh->b_blocknr;
-		__entry->bh_size	= bh->b_size;
+		__entry->m_lblk		= map->m_lblk;
+		__entry->m_pblk		= map->m_pblk;
+		__entry->m_len		= map->m_len;
 		__entry->ret		= ret;
 	),
 
 	TP_printk("dev = (%d,%d), ino = %lu, file offset = %llu, "
-		"start blkaddr = 0x%llx, len = 0x%llx bytes, err = %d",
+		"start blkaddr = 0x%llx, len = 0x%llx, err = %d",
 		show_dev_ino(__entry),
-		(unsigned long long)__entry->iblock,
-		(unsigned long long)__entry->bh_start,
-		(unsigned long long)__entry->bh_size,
+		(unsigned long long)__entry->m_lblk,
+		(unsigned long long)__entry->m_pblk,
+		(unsigned long long)__entry->m_len,
 		__entry->ret)
 );
 
-- 
2.1.1
