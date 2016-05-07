From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: introduce f2fs_reserve_blocks to speedup fallocate
Date: Sat, 7 May 2016 10:44:01 -0700
Message-ID: <20160507174401.GA92790@jaegeuk.gateway>
References: <20160507081634.96677-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160507081634.96677-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

Good catch, but I've been already testing a patch which uses f2fs_map_blocks().
We don't need to add whole things redundantly. :)

>From b150a6e02785ea28a5139bd2d1a1debd8aad84e7 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Fri, 6 May 2016 15:30:38 -0700
Subject: [PATCH] f2fs: fallocate data blocks in single locked node page

This patch is to improve the expand_inode speed in fallocate by allocating
data blocks as many as possible in single locked node page.

In SSD,
 # time fallocate -l 500G $MNT/testfile

Before : 1m 33.410 s
After  : 24.758 s

Reported-by: Stephen Bates <stephen.bates@microsemi.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 51 ++++++++++++++++++++++-----------------------------
 1 file changed, 22 insertions(+), 29 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index efa544d..5ead254 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1196,10 +1196,11 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 					loff_t len, int mode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	pgoff_t index, pg_start, pg_end;
+	struct f2fs_map_blocks map = { .m_next_pgofs = NULL };
+	pgoff_t pg_end;
 	loff_t new_size = i_size_read(inode);
-	loff_t off_start, off_end;
-	int ret = 0;
+	loff_t off_end;
+	int ret;
 
 	ret = inode_newsize_ok(inode, (len + offset));
 	if (ret)
@@ -1211,43 +1212,35 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 
 	f2fs_balance_fs(sbi, true);
 
-	pg_start = ((unsigned long long) offset) >> PAGE_SHIFT;
-	pg_end = ((unsigned long long) offset + len) >> PAGE_SHIFT;
-
-	off_start = offset & (PAGE_SIZE - 1);
+	pg_end = ((unsigned long long)offset + len) >> PAGE_SHIFT;
 	off_end = (offset + len) & (PAGE_SIZE - 1);
 
-	f2fs_lock_op(sbi);
+	map.m_lblk = ((unsigned long long)offset) >> PAGE_SHIFT;
+	map.m_len = pg_end - map.m_lblk;
+	if (off_end)
+		map.m_len++;
 
-	for (index = pg_start; index <= pg_end; index++) {
-		struct dnode_of_data dn;
+	ret = f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_AIO);
+	if (ret) {
+		pgoff_t last_off;
 
-		if (index == pg_end && !off_end)
-			goto noalloc;
+		if (!map.m_len)
+			return ret;
 
-		set_new_dnode(&dn, inode, NULL, NULL, 0);
-		ret = f2fs_reserve_block(&dn, index);
-		if (ret)
-			break;
-noalloc:
-		if (pg_start == pg_end)
-			new_size = offset + len;
-		else if (index == pg_start && off_start)
-			new_size = (loff_t)(index + 1) << PAGE_SHIFT;
-		else if (index == pg_end)
-			new_size = ((loff_t)index << PAGE_SHIFT) +
-								off_end;
-		else
-			new_size += PAGE_SIZE;
+		last_off = map.m_lblk + map.m_len - 1;
+
+		/* update new size to the failed position */
+		new_size = (last_off == pg_end) ? offset + len:
+					(loff_t)(last_off + 1) << PAGE_SHIFT;
+	} else {
+		new_size = ((loff_t)pg_end << PAGE_SHIFT) + off_end;
 	}
 
-	if (!(mode & FALLOC_FL_KEEP_SIZE) &&
-		i_size_read(inode) < new_size) {
+	if (!(mode & FALLOC_FL_KEEP_SIZE) && i_size_read(inode) < new_size) {
 		i_size_write(inode, new_size);
 		mark_inode_dirty(inode);
 		update_inode_page(inode);
 	}
-	f2fs_unlock_op(sbi);
 
 	return ret;
 }
-- 
2.6.3

On Sat, May 07, 2016 at 04:16:34PM +0800, Chao Yu wrote:
> Preallocation operation in ->fallocate seems quite slow, since for all
> new preallocated blocks, f2fs will update them one by one in direct nodes,
> 
> This patch introduces f2fs_reserve_blocks to make all preallocated blocks
> belongs to one direct node updating in batch, so it can save a lot of
> cpu cycle.
> 
> In virtual machine, with 32g loop device:
> 
> 1. touch file
> 2. time fallocate -l 24G file
> 
> Before:
> real	0m3.881s
> user	0m0.000s
> sys	0m3.881s
> 
> After:
> real	0m0.054s
> user	0m0.000s
> sys	0m0.041s
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/data.c              | 87 ++++++++++++++++++++++++++++++++++++++-------
>  fs/f2fs/f2fs.h              |  1 +
>  fs/f2fs/file.c              |  5 +--
>  include/trace/events/f2fs.h | 12 ++++---
>  4 files changed, 86 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 96b0353..a2e7629 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -278,6 +278,16 @@ alloc_new:
>  	trace_f2fs_submit_page_mbio(fio->page, fio);
>  }
>  
> +void __set_data_blkaddr(struct dnode_of_data *dn)
> +{
> +	struct f2fs_node *rn = F2FS_NODE(dn->node_page);
> +	__le32 *addr_array;
> +
> +	/* Get physical address of data block */
> +	addr_array = blkaddr_in_node(rn);
> +	addr_array[dn->ofs_in_node] = cpu_to_le32(dn->data_blkaddr);
> +}
> +
>  /*
>   * Lock ordering for the change of data block address:
>   * ->data_page
> @@ -286,19 +296,10 @@ alloc_new:
>   */
>  void set_data_blkaddr(struct dnode_of_data *dn)
>  {
> -	struct f2fs_node *rn;
> -	__le32 *addr_array;
> -	struct page *node_page = dn->node_page;
> -	unsigned int ofs_in_node = dn->ofs_in_node;
> -
> -	f2fs_wait_on_page_writeback(node_page, NODE, true);
> +	f2fs_wait_on_page_writeback(dn->node_page, NODE, true);
>  
> -	rn = F2FS_NODE(node_page);
> -
> -	/* Get physical address of data block */
> -	addr_array = blkaddr_in_node(rn);
> -	addr_array[ofs_in_node] = cpu_to_le32(dn->data_blkaddr);
> -	if (set_page_dirty(node_page))
> +	__set_data_blkaddr(dn);
> +	if (set_page_dirty(dn->node_page))
>  		dn->node_changed = true;
>  }
>  
> @@ -318,7 +319,7 @@ int reserve_new_block(struct dnode_of_data *dn)
>  	if (unlikely(!inc_valid_block_count(sbi, dn->inode, 1)))
>  		return -ENOSPC;
>  
> -	trace_f2fs_reserve_new_block(dn->inode, dn->nid, dn->ofs_in_node);
> +	trace_f2fs_reserve_new_block(dn->inode, dn->nid, dn->ofs_in_node, 1);
>  
>  	dn->data_blkaddr = NEW_ADDR;
>  	set_data_blkaddr(dn);
> @@ -343,6 +344,66 @@ int f2fs_reserve_block(struct dnode_of_data *dn, pgoff_t index)
>  	return err;
>  }
>  
> +int f2fs_reserve_blocks(struct dnode_of_data *dn, pgoff_t *start, pgoff_t end)
> +{
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
> +	pgoff_t end_offset, index = *start;
> +	unsigned int max_blocks, count = 0, i, ofs_in_node;
> +	int err;
> +
> +	err = get_dnode_of_data(dn, index, ALLOC_NODE);
> +	if (err)
> +		return err;
> +
> +	if (unlikely(is_inode_flag_set(F2FS_I(dn->inode), FI_NO_ALLOC))) {
> +		err = -EPERM;
> +		goto out;
> +	}
> +
> +	end_offset = ADDRS_PER_PAGE(dn->node_page, dn->inode);
> +	max_blocks = min(end_offset - dn->ofs_in_node, end - index + 1);
> +	ofs_in_node = dn->ofs_in_node;
> +
> +	for (i = 0; i < max_blocks; i++, ofs_in_node++) {
> +		if (datablock_addr(dn->node_page, ofs_in_node) == NULL_ADDR)
> +			count++;
> +	}
> +
> +	if (!count)
> +		goto out_update;
> +
> +	if (unlikely(!inc_valid_block_count(sbi, dn->inode, count))) {
> +		err = -ENOSPC;
> +		goto out;
> +	}
> +
> +	trace_f2fs_reserve_new_block(dn->inode, dn->nid,
> +						dn->ofs_in_node, count);
> +
> +	f2fs_wait_on_page_writeback(dn->node_page, NODE, true);
> +
> +	for (i = 0; i < max_blocks; i++, dn->ofs_in_node++) {
> +		dn->data_blkaddr =
> +			datablock_addr(dn->node_page, dn->ofs_in_node);
> +
> +		if (dn->data_blkaddr == NULL_ADDR) {
> +			dn->data_blkaddr = NEW_ADDR;
> +			__set_data_blkaddr(dn);
> +		}
> +	}
> +
> +	if (set_page_dirty(dn->node_page))
> +		dn->node_changed = true;
> +
> +	mark_inode_dirty(dn->inode);
> +	sync_inode_page(dn);
> +out_update:
> +	*start = index + max_blocks - 1;
> +out:
> +	f2fs_put_dnode(dn);
> +	return err;
> +}
> +
>  int f2fs_get_block(struct dnode_of_data *dn, pgoff_t index)
>  {
>  	struct extent_info ei;
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 75b0084..5654d0e 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1969,6 +1969,7 @@ int reserve_new_block(struct dnode_of_data *);
>  int f2fs_get_block(struct dnode_of_data *, pgoff_t);
>  ssize_t f2fs_preallocate_blocks(struct kiocb *, struct iov_iter *);
>  int f2fs_reserve_block(struct dnode_of_data *, pgoff_t);
> +int f2fs_reserve_blocks(struct dnode_of_data *, pgoff_t *, pgoff_t);
>  struct page *get_read_data_page(struct inode *, pgoff_t, int, bool);
>  struct page *find_data_page(struct inode *, pgoff_t);
>  struct page *get_lock_data_page(struct inode *, pgoff_t, bool);
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 00af85f..071fe2b 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1226,7 +1226,8 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
>  			goto noalloc;
>  
>  		set_new_dnode(&dn, inode, NULL, NULL, 0);
> -		ret = f2fs_reserve_block(&dn, index);
> +		ret = f2fs_reserve_blocks(&dn, &index,
> +					off_end ? pg_end : pg_end - 1);
>  		if (ret)
>  			break;
>  noalloc:
> @@ -1238,7 +1239,7 @@ noalloc:
>  			new_size = ((loff_t)index << PAGE_SHIFT) +
>  								off_end;
>  		else
> -			new_size += PAGE_SIZE;
> +			new_size = (loff_t)index << PAGE_SHIFT;
>  	}
>  
>  	if (!(mode & FALLOC_FL_KEEP_SIZE) &&
> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> index 0f56584..8b8dd9e 100644
> --- a/include/trace/events/f2fs.h
> +++ b/include/trace/events/f2fs.h
> @@ -696,26 +696,30 @@ TRACE_EVENT(f2fs_direct_IO_exit,
>  
>  TRACE_EVENT(f2fs_reserve_new_block,
>  
> -	TP_PROTO(struct inode *inode, nid_t nid, unsigned int ofs_in_node),
> +	TP_PROTO(struct inode *inode, nid_t nid, unsigned int ofs_in_node,
> +						unsigned int count),
>  
> -	TP_ARGS(inode, nid, ofs_in_node),
> +	TP_ARGS(inode, nid, ofs_in_node, count),
>  
>  	TP_STRUCT__entry(
>  		__field(dev_t,	dev)
>  		__field(nid_t, nid)
>  		__field(unsigned int, ofs_in_node)
> +		__field(unsigned int, count)
>  	),
>  
>  	TP_fast_assign(
>  		__entry->dev	= inode->i_sb->s_dev;
>  		__entry->nid	= nid;
>  		__entry->ofs_in_node = ofs_in_node;
> +		__entry->count = count;
>  	),
>  
> -	TP_printk("dev = (%d,%d), nid = %u, ofs_in_node = %u",
> +	TP_printk("dev = (%d,%d), nid = %u, ofs_in_node = %u, count = %u",
>  		show_dev(__entry),
>  		(unsigned int)__entry->nid,
> -		__entry->ofs_in_node)
> +		__entry->ofs_in_node,
> +		__entry->count)
>  );
>  
>  DECLARE_EVENT_CLASS(f2fs__submit_page_bio,
> -- 
> 2.8.2.311.gee88674
