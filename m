From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/6] f2fs: support in batch multi blocks preallocation
Date: Mon, 9 May 2016 19:56:30 +0800
Message-ID: <20160509115635.123946-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch introduces reserve_new_blocks to make preallocation of multi
blocks as in batch operation, so it can avoid lots of redundant
operation, result in better performance.

In virtual machine, with rotational device:

time fallocate -l 32G /mnt/f2fs/file

Before:
real	0m4.584s
user	0m0.000s
sys	0m4.580s

After:
real	0m0.292s
user	0m0.000s
sys	0m0.272s

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c              | 93 +++++++++++++++++++++++++++++++++------------
 include/trace/events/f2fs.h | 14 ++++---
 2 files changed, 78 insertions(+), 29 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 369d953..ea0abdc 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -278,6 +278,16 @@ alloc_new:
 	trace_f2fs_submit_page_mbio(fio->page, fio);
 }
 
+void __set_data_blkaddr(struct dnode_of_data *dn)
+{
+	struct f2fs_node *rn = F2FS_NODE(dn->node_page);
+	__le32 *addr_array;
+
+	/* Get physical address of data block */
+	addr_array = blkaddr_in_node(rn);
+	addr_array[dn->ofs_in_node] = cpu_to_le32(dn->data_blkaddr);
+}
+
 /*
  * Lock ordering for the change of data block address:
  * ->data_page
@@ -286,19 +296,9 @@ alloc_new:
  */
 void set_data_blkaddr(struct dnode_of_data *dn)
 {
-	struct f2fs_node *rn;
-	__le32 *addr_array;
-	struct page *node_page = dn->node_page;
-	unsigned int ofs_in_node = dn->ofs_in_node;
-
-	f2fs_wait_on_page_writeback(node_page, NODE, true);
-
-	rn = F2FS_NODE(node_page);
-
-	/* Get physical address of data block */
-	addr_array = blkaddr_in_node(rn);
-	addr_array[ofs_in_node] = cpu_to_le32(dn->data_blkaddr);
-	if (set_page_dirty(node_page))
+	f2fs_wait_on_page_writeback(dn->node_page, NODE, true);
+	__set_data_blkaddr(dn);
+	if (set_page_dirty(dn->node_page))
 		dn->node_changed = true;
 }
 
@@ -309,24 +309,53 @@ void f2fs_update_data_blkaddr(struct dnode_of_data *dn, block_t blkaddr)
 	f2fs_update_extent_cache(dn);
 }
 
-int reserve_new_block(struct dnode_of_data *dn)
+int reserve_new_blocks(struct dnode_of_data *dn, unsigned int start,
+							unsigned int count)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
+	unsigned int ofs_in_node;
+
+	if (!count)
+		return 0;
 
 	if (unlikely(is_inode_flag_set(F2FS_I(dn->inode), FI_NO_ALLOC)))
 		return -EPERM;
-	if (unlikely(!inc_valid_block_count(sbi, dn->inode, 1)))
+	if (unlikely(!inc_valid_block_count(sbi, dn->inode, count)))
 		return -ENOSPC;
 
-	trace_f2fs_reserve_new_block(dn->inode, dn->nid, dn->ofs_in_node);
+	trace_f2fs_reserve_new_blocks(dn->inode, dn->nid,
+						dn->ofs_in_node, count);
+
+	ofs_in_node = dn->ofs_in_node;
+	dn->ofs_in_node = start;
+
+	f2fs_wait_on_page_writeback(dn->node_page, NODE, true);
+
+	for (; count > 0; dn->ofs_in_node++) {
+		block_t blkaddr =
+			datablock_addr(dn->node_page, dn->ofs_in_node);
+		if (blkaddr == NULL_ADDR) {
+			dn->data_blkaddr = NEW_ADDR;
+			__set_data_blkaddr(dn);
+			count--;
+		}
+	}
+
+	dn->ofs_in_node = ofs_in_node;
+
+	if (set_page_dirty(dn->node_page))
+		dn->node_changed = true;
 
-	dn->data_blkaddr = NEW_ADDR;
-	set_data_blkaddr(dn);
 	mark_inode_dirty(dn->inode);
 	sync_inode_page(dn);
 	return 0;
 }
 
+int reserve_new_block(struct dnode_of_data *dn)
+{
+	return reserve_new_blocks(dn, dn->ofs_in_node, 1);
+}
+
 int f2fs_reserve_block(struct dnode_of_data *dn, pgoff_t index)
 {
 	bool need_put = dn->inode_page ? false : true;
@@ -621,8 +650,8 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 	struct dnode_of_data dn;
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	int mode = create ? ALLOC_NODE : LOOKUP_NODE_RA;
-	pgoff_t pgofs, end_offset;
-	int err = 0, ofs = 1;
+	pgoff_t pgofs, end_offset, end;
+	int err = 0, ofs = 1, prealloc, start;
 	struct extent_info ei;
 	bool allocated = false;
 	block_t blkaddr;
@@ -632,6 +661,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 
 	/* it only supports block size == page size */
 	pgofs =	(pgoff_t)map->m_lblk;
+	end = pgofs + maxblocks;
 
 	if (!create && f2fs_lookup_extent_cache(inode, pgofs, &ei)) {
 		map->m_pblk = ei.blk + pgofs - ei.fofs;
@@ -659,6 +689,8 @@ next_dnode:
 		goto unlock_out;
 	}
 
+	prealloc = 0;
+	start = dn.ofs_in_node;
 	end_offset = ADDRS_PER_PAGE(dn.node_page, inode);
 
 next_block:
@@ -672,7 +704,7 @@ next_block:
 			}
 			if (flag == F2FS_GET_BLOCK_PRE_AIO) {
 				if (blkaddr == NULL_ADDR)
-					err = reserve_new_block(&dn);
+					prealloc++;
 			} else {
 				err = __allocate_data_block(&dn);
 				if (!err)
@@ -700,6 +732,9 @@ next_block:
 		}
 	}
 
+	if (flag == F2FS_GET_BLOCK_PRE_AIO)
+		goto skip;
+
 	if (map->m_len == 0) {
 		/* preallocated unwritten block should be mapped for fiemap. */
 		if (blkaddr == NEW_ADDR)
@@ -711,18 +746,28 @@ next_block:
 	} else if ((map->m_pblk != NEW_ADDR &&
 			blkaddr == (map->m_pblk + ofs)) ||
 			(map->m_pblk == NEW_ADDR && blkaddr == NEW_ADDR) ||
-			flag == F2FS_GET_BLOCK_PRE_DIO ||
-			flag == F2FS_GET_BLOCK_PRE_AIO) {
+			flag == F2FS_GET_BLOCK_PRE_DIO) {
 		ofs++;
 		map->m_len++;
 	} else {
 		goto sync_out;
 	}
 
+skip:
 	dn.ofs_in_node++;
 	pgofs++;
 
-	if (map->m_len < maxblocks) {
+	/* preallocate blocks in batch for one dnode page */
+	if (flag == F2FS_GET_BLOCK_PRE_AIO &&
+			(pgofs == end || dn.ofs_in_node == end_offset)) {
+		allocated = false;
+		err = reserve_new_blocks(&dn, start, prealloc);
+		if (err)
+			goto sync_out;
+		map->m_len = pgofs - start;
+	}
+
+	if (pgofs < end) {
 		if (dn.ofs_in_node < end_offset)
 			goto next_block;
 
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 0f56584..5f927ff 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -694,28 +694,32 @@ TRACE_EVENT(f2fs_direct_IO_exit,
 		__entry->ret)
 );
 
-TRACE_EVENT(f2fs_reserve_new_block,
+TRACE_EVENT(f2fs_reserve_new_blocks,
 
-	TP_PROTO(struct inode *inode, nid_t nid, unsigned int ofs_in_node),
+	TP_PROTO(struct inode *inode, nid_t nid, unsigned int ofs_in_node,
+						unsigned int count),
 
-	TP_ARGS(inode, nid, ofs_in_node),
+	TP_ARGS(inode, nid, ofs_in_node, count),
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
 		__field(nid_t, nid)
 		__field(unsigned int, ofs_in_node)
+		__field(unsigned int, count)
 	),
 
 	TP_fast_assign(
 		__entry->dev	= inode->i_sb->s_dev;
 		__entry->nid	= nid;
 		__entry->ofs_in_node = ofs_in_node;
+		__entry->count = count;
 	),
 
-	TP_printk("dev = (%d,%d), nid = %u, ofs_in_node = %u",
+	TP_printk("dev = (%d,%d), nid = %u, ofs_in_node = %u, count = %u",
 		show_dev(__entry),
 		(unsigned int)__entry->nid,
-		__entry->ofs_in_node)
+		__entry->ofs_in_node,
+		__entry->count)
 );
 
 DECLARE_EVENT_CLASS(f2fs__submit_page_bio,
-- 
2.8.2.311.gee88674
