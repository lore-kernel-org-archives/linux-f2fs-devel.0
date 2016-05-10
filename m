From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/6] f2fs: support in batch multi blocks preallocation
Date: Tue, 10 May 2016 14:41:26 -0700
Message-ID: <20160510214125.GA9867@jaegeuk.gateway>
References: <20160509115635.123946-1-yuchao0@huawei.com>
 <20160509230037.GA6889@jaegeuk.gateway>
 <bcf5439c-88a3-8669-0bc0-6111249e1f27@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bcf5439c-88a3-8669-0bc0-6111249e1f27@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

> >  	valid_block_count =
> > -		sbi->total_valid_block_count + (block_t)count;
> > +		sbi->total_valid_block_count + (block_t)(*count);
> >  	if (unlikely(valid_block_count > sbi->user_block_count)) {
> > -		spin_unlock(&sbi->stat_lock);
> > -		return false;
> > +		*count = sbi->user_block_count - sbi->total_valid_block_count;
> > +		if (!*count) {
> > +			spin_unlock(&sbi->stat_lock);
> > +			return false;
> > +		}
> 
> If we can only allocate partial blocks, we should let f2fs_map_blocks being
> ware of that, otherwise, map->m_len will be updated incorrectly.

Hmm, I've reworked this patch.
Can you review this?

Thanks,

>From c8706b30c2646082f1a1f66e363526bb3d6d8ee4 Mon Sep 17 00:00:00 2001
From: Chao Yu <yuchao0@huawei.com>
Date: Mon, 9 May 2016 19:56:30 +0800
Subject: [PATCH] f2fs: support in batch multi blocks preallocation

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

In x86, with SSD:

time fallocate -l 500G $MNT/testfile

Before : 24.758 s
After  :  1.604 s

Signed-off-by: Chao Yu <yuchao0@huawei.com>
[Jaegeuk Kim: fix bugs and add performance numbers measured in x86.]
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c              | 108 +++++++++++++++++++++++++++++++++-----------
 fs/f2fs/f2fs.h              |  20 +++++---
 include/trace/events/f2fs.h |  14 ++++--
 3 files changed, 104 insertions(+), 38 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 369d953..eb6ce31 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -278,6 +278,16 @@ alloc_new:
 	trace_f2fs_submit_page_mbio(fio->page, fio);
 }
 
+static void __set_data_blkaddr(struct dnode_of_data *dn)
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
+/* dn->ofs_in_node will be returned with up-to-date last block pointer */
+int reserve_new_blocks(struct dnode_of_data *dn, blkcnt_t count)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
 
+	if (!count)
+		return 0;
+
 	if (unlikely(is_inode_flag_set(F2FS_I(dn->inode), FI_NO_ALLOC)))
 		return -EPERM;
-	if (unlikely(!inc_valid_block_count(sbi, dn->inode, 1)))
+	if (unlikely(!inc_valid_block_count(sbi, dn->inode, &count)))
 		return -ENOSPC;
 
-	trace_f2fs_reserve_new_block(dn->inode, dn->nid, dn->ofs_in_node);
+	trace_f2fs_reserve_new_blocks(dn->inode, dn->nid,
+						dn->ofs_in_node, count);
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
+	if (set_page_dirty(dn->node_page))
+		dn->node_changed = true;
 
-	dn->data_blkaddr = NEW_ADDR;
-	set_data_blkaddr(dn);
 	mark_inode_dirty(dn->inode);
 	sync_inode_page(dn);
 	return 0;
 }
 
+/* Should keep dn->ofs_in_node unchanged */
+int reserve_new_block(struct dnode_of_data *dn)
+{
+	unsigned int ofs_in_node = dn->ofs_in_node;
+	int ret;
+
+	ret = reserve_new_blocks(dn, 1);
+	dn->ofs_in_node = ofs_in_node;
+	return ret;
+}
+
 int f2fs_reserve_block(struct dnode_of_data *dn, pgoff_t index)
 {
 	bool need_put = dn->inode_page ? false : true;
@@ -545,6 +574,7 @@ static int __allocate_data_block(struct dnode_of_data *dn)
 	struct node_info ni;
 	int seg = CURSEG_WARM_DATA;
 	pgoff_t fofs;
+	blkcnt_t count = 1;
 
 	if (unlikely(is_inode_flag_set(F2FS_I(dn->inode), FI_NO_ALLOC)))
 		return -EPERM;
@@ -553,7 +583,7 @@ static int __allocate_data_block(struct dnode_of_data *dn)
 	if (dn->data_blkaddr == NEW_ADDR)
 		goto alloc;
 
-	if (unlikely(!inc_valid_block_count(sbi, dn->inode, 1)))
+	if (unlikely(!inc_valid_block_count(sbi, dn->inode, &count)))
 		return -ENOSPC;
 
 alloc:
@@ -621,8 +651,10 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 	struct dnode_of_data dn;
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	int mode = create ? ALLOC_NODE : LOOKUP_NODE_RA;
-	pgoff_t pgofs, end_offset;
+	pgoff_t pgofs, end_offset, end;
 	int err = 0, ofs = 1;
+	unsigned int ofs_in_node;
+	blkcnt_t prealloc;
 	struct extent_info ei;
 	bool allocated = false;
 	block_t blkaddr;
@@ -632,6 +664,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 
 	/* it only supports block size == page size */
 	pgofs =	(pgoff_t)map->m_lblk;
+	end = pgofs + maxblocks;
 
 	if (!create && f2fs_lookup_extent_cache(inode, pgofs, &ei)) {
 		map->m_pblk = ei.blk + pgofs - ei.fofs;
@@ -659,6 +692,8 @@ next_dnode:
 		goto unlock_out;
 	}
 
+	prealloc = 0;
+	ofs_in_node = dn.ofs_in_node;
 	end_offset = ADDRS_PER_PAGE(dn.node_page, inode);
 
 next_block:
@@ -672,16 +707,17 @@ next_block:
 			}
 			if (flag == F2FS_GET_BLOCK_PRE_AIO) {
 				if (blkaddr == NULL_ADDR)
-					err = reserve_new_block(&dn);
+					prealloc++;
 			} else {
 				err = __allocate_data_block(&dn);
-				if (!err)
+				if (!err) {
 					set_inode_flag(F2FS_I(inode),
 							FI_APPEND_WRITE);
+					allocated = true;
+				}
 			}
 			if (err)
 				goto sync_out;
-			allocated = true;
 			map->m_flags = F2FS_MAP_NEW;
 			blkaddr = dn.data_blkaddr;
 		} else {
@@ -700,6 +736,9 @@ next_block:
 		}
 	}
 
+	if (flag == F2FS_GET_BLOCK_PRE_AIO)
+		goto skip;
+
 	if (map->m_len == 0) {
 		/* preallocated unwritten block should be mapped for fiemap. */
 		if (blkaddr == NEW_ADDR)
@@ -711,18 +750,35 @@ next_block:
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
+		unsigned int last_ofs_in_node = dn.ofs_in_node;
+
+		dn.ofs_in_node = ofs_in_node;
+		err = reserve_new_blocks(&dn, prealloc);
+		if (err)
+			goto sync_out;
+
+		map->m_len += dn.ofs_in_node - ofs_in_node;
+		if (prealloc && dn.ofs_in_node != last_ofs_in_node) {
+			err = -ENOSPC;
+			goto sync_out;
+		}
+	}
+
+	if (pgofs < end) {
 		if (dn.ofs_in_node < end_offset)
 			goto next_block;
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 75b0084..1c51f37 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1114,7 +1114,7 @@ static inline bool f2fs_has_xattr_block(unsigned int ofs)
 }
 
 static inline bool inc_valid_block_count(struct f2fs_sb_info *sbi,
-				 struct inode *inode, blkcnt_t count)
+				 struct inode *inode, blkcnt_t *count)
 {
 	block_t	valid_block_count;
 
@@ -1126,14 +1126,19 @@ static inline bool inc_valid_block_count(struct f2fs_sb_info *sbi,
 	}
 #endif
 	valid_block_count =
-		sbi->total_valid_block_count + (block_t)count;
+		sbi->total_valid_block_count + (block_t)(*count);
 	if (unlikely(valid_block_count > sbi->user_block_count)) {
-		spin_unlock(&sbi->stat_lock);
-		return false;
+		*count = sbi->user_block_count - sbi->total_valid_block_count;
+		if (!*count) {
+			spin_unlock(&sbi->stat_lock);
+			return false;
+		}
 	}
-	inode->i_blocks += count;
-	sbi->total_valid_block_count = valid_block_count;
-	sbi->alloc_valid_block_count += (block_t)count;
+	/* *count can be recalculated */
+	inode->i_blocks += *count;
+	sbi->total_valid_block_count =
+		sbi->total_valid_block_count + (block_t)(*count);
+	sbi->alloc_valid_block_count += (block_t)(*count);
 	spin_unlock(&sbi->stat_lock);
 	return true;
 }
@@ -1965,6 +1970,7 @@ int f2fs_submit_page_bio(struct f2fs_io_info *);
 void f2fs_submit_page_mbio(struct f2fs_io_info *);
 void set_data_blkaddr(struct dnode_of_data *);
 void f2fs_update_data_blkaddr(struct dnode_of_data *, block_t);
+int reserve_new_blocks(struct dnode_of_data *, blkcnt_t);
 int reserve_new_block(struct dnode_of_data *);
 int f2fs_get_block(struct dnode_of_data *, pgoff_t);
 ssize_t f2fs_preallocate_blocks(struct kiocb *, struct iov_iter *);
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 0f56584..497e6e8 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -694,28 +694,32 @@ TRACE_EVENT(f2fs_direct_IO_exit,
 		__entry->ret)
 );
 
-TRACE_EVENT(f2fs_reserve_new_block,
+TRACE_EVENT(f2fs_reserve_new_blocks,
 
-	TP_PROTO(struct inode *inode, nid_t nid, unsigned int ofs_in_node),
+	TP_PROTO(struct inode *inode, nid_t nid, unsigned int ofs_in_node,
+							blkcnt_t count),
 
-	TP_ARGS(inode, nid, ofs_in_node),
+	TP_ARGS(inode, nid, ofs_in_node, count),
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
 		__field(nid_t, nid)
 		__field(unsigned int, ofs_in_node)
+		__field(blkcnt_t, count)
 	),
 
 	TP_fast_assign(
 		__entry->dev	= inode->i_sb->s_dev;
 		__entry->nid	= nid;
 		__entry->ofs_in_node = ofs_in_node;
+		__entry->count = count;
 	),
 
-	TP_printk("dev = (%d,%d), nid = %u, ofs_in_node = %u",
+	TP_printk("dev = (%d,%d), nid = %u, ofs_in_node = %u, count = %llu",
 		show_dev(__entry),
 		(unsigned int)__entry->nid,
-		__entry->ofs_in_node)
+		__entry->ofs_in_node,
+		(unsigned long long)__entry->count)
 );
 
 DECLARE_EVENT_CLASS(f2fs__submit_page_bio,
-- 
2.6.3
