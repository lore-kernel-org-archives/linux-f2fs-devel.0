From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/6] f2fs: support in batch multi blocks preallocation
Date: Tue, 10 May 2016 20:55:16 +0800
Message-ID: <bcf5439c-88a3-8669-0bc0-6111249e1f27@huawei.com>
References: <20160509115635.123946-1-yuchao0@huawei.com>
 <20160509230037.GA6889@jaegeuk.gateway>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160509230037.GA6889@jaegeuk.gateway>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

On 2016/5/10 7:00, Jaegeuk Kim wrote:
> Hi Chao,
> 
> On Mon, May 09, 2016 at 07:56:30PM +0800, Chao Yu wrote:
>> This patch introduces reserve_new_blocks to make preallocation of multi
>> blocks as in batch operation, so it can avoid lots of redundant
>> operation, result in better performance.
>>
>> In virtual machine, with rotational device:
>>
>> time fallocate -l 32G /mnt/f2fs/file
>>
>> Before:
>> real	0m4.584s
>> user	0m0.000s
>> sys	0m4.580s
>>
>> After:
>> real	0m0.292s
>> user	0m0.000s
>> sys	0m0.272s
> 
> It's cool.
> Let me add my test results as well.
> 
> In x86, with SSD:
> 
> time fallocate -l 500G $MNT/testfile
> 
> Before : 24.758 s
> After  :  1.604 s
> 
> By the way, there is one thing we should consider, which is the ENOSPC case.
> Could you check this out on top of your patch?
> 
> If you don't mind, let me integrate this into your patch.

No problem. :)

And see below comments please.

> Let me know.
> 
> Thanks,
> 
> ---
>  fs/f2fs/data.c              |  9 +++++----
>  fs/f2fs/f2fs.h              | 20 +++++++++++++-------
>  include/trace/events/f2fs.h |  8 ++++----
>  3 files changed, 22 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index ea0abdc..da640e1 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -278,7 +278,7 @@ alloc_new:
>  	trace_f2fs_submit_page_mbio(fio->page, fio);
>  }
>  
> -void __set_data_blkaddr(struct dnode_of_data *dn)
> +static void __set_data_blkaddr(struct dnode_of_data *dn)
>  {
>  	struct f2fs_node *rn = F2FS_NODE(dn->node_page);
>  	__le32 *addr_array;
> @@ -310,7 +310,7 @@ void f2fs_update_data_blkaddr(struct dnode_of_data *dn, block_t blkaddr)
>  }
>  
>  int reserve_new_blocks(struct dnode_of_data *dn, unsigned int start,
> -							unsigned int count)
> +							blkcnt_t count)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
>  	unsigned int ofs_in_node;
> @@ -320,7 +320,7 @@ int reserve_new_blocks(struct dnode_of_data *dn, unsigned int start,
>  
>  	if (unlikely(is_inode_flag_set(F2FS_I(dn->inode), FI_NO_ALLOC)))
>  		return -EPERM;
> -	if (unlikely(!inc_valid_block_count(sbi, dn->inode, count)))
> +	if (unlikely(!inc_valid_block_count(sbi, dn->inode, &count)))
>  		return -ENOSPC;
>  
>  	trace_f2fs_reserve_new_blocks(dn->inode, dn->nid,
> @@ -574,6 +574,7 @@ static int __allocate_data_block(struct dnode_of_data *dn)
>  	struct node_info ni;
>  	int seg = CURSEG_WARM_DATA;
>  	pgoff_t fofs;
> +	blkcnt_t count = 1;
>  
>  	if (unlikely(is_inode_flag_set(F2FS_I(dn->inode), FI_NO_ALLOC)))
>  		return -EPERM;
> @@ -582,7 +583,7 @@ static int __allocate_data_block(struct dnode_of_data *dn)
>  	if (dn->data_blkaddr == NEW_ADDR)
>  		goto alloc;
>  
> -	if (unlikely(!inc_valid_block_count(sbi, dn->inode, 1)))
> +	if (unlikely(!inc_valid_block_count(sbi, dn->inode, &count)))
>  		return -ENOSPC;
>  
>  alloc:
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 75b0084..00fe63c 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1114,7 +1114,7 @@ static inline bool f2fs_has_xattr_block(unsigned int ofs)
>  }
>  
>  static inline bool inc_valid_block_count(struct f2fs_sb_info *sbi,
> -				 struct inode *inode, blkcnt_t count)
> +				 struct inode *inode, blkcnt_t *count)
>  {
>  	block_t	valid_block_count;
>  
> @@ -1126,14 +1126,19 @@ static inline bool inc_valid_block_count(struct f2fs_sb_info *sbi,
>  	}
>  #endif
>  	valid_block_count =
> -		sbi->total_valid_block_count + (block_t)count;
> +		sbi->total_valid_block_count + (block_t)(*count);
>  	if (unlikely(valid_block_count > sbi->user_block_count)) {
> -		spin_unlock(&sbi->stat_lock);
> -		return false;
> +		*count = sbi->user_block_count - sbi->total_valid_block_count;
> +		if (!*count) {
> +			spin_unlock(&sbi->stat_lock);
> +			return false;
> +		}

If we can only allocate partial blocks, we should let f2fs_map_blocks being
ware of that, otherwise, map->m_len will be updated incorrectly.

Thanks,

>  	}
> -	inode->i_blocks += count;
> -	sbi->total_valid_block_count = valid_block_count;
> -	sbi->alloc_valid_block_count += (block_t)count;
> +	/* *count can be recalculated */
> +	inode->i_blocks += *count;
> +	sbi->total_valid_block_count =
> +		sbi->total_valid_block_count + (block_t)(*count);
> +	sbi->alloc_valid_block_count += (block_t)(*count);
>  	spin_unlock(&sbi->stat_lock);
>  	return true;
>  }
> @@ -1965,6 +1970,7 @@ int f2fs_submit_page_bio(struct f2fs_io_info *);
>  void f2fs_submit_page_mbio(struct f2fs_io_info *);
>  void set_data_blkaddr(struct dnode_of_data *);
>  void f2fs_update_data_blkaddr(struct dnode_of_data *, block_t);
> +int reserve_new_blocks(struct dnode_of_data *, unsigned int, blkcnt_t);
>  int reserve_new_block(struct dnode_of_data *);
>  int f2fs_get_block(struct dnode_of_data *, pgoff_t);
>  ssize_t f2fs_preallocate_blocks(struct kiocb *, struct iov_iter *);
> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> index 5f927ff..497e6e8 100644
> --- a/include/trace/events/f2fs.h
> +++ b/include/trace/events/f2fs.h
> @@ -697,7 +697,7 @@ TRACE_EVENT(f2fs_direct_IO_exit,
>  TRACE_EVENT(f2fs_reserve_new_blocks,
>  
>  	TP_PROTO(struct inode *inode, nid_t nid, unsigned int ofs_in_node,
> -						unsigned int count),
> +							blkcnt_t count),
>  
>  	TP_ARGS(inode, nid, ofs_in_node, count),
>  
> @@ -705,7 +705,7 @@ TRACE_EVENT(f2fs_reserve_new_blocks,
>  		__field(dev_t,	dev)
>  		__field(nid_t, nid)
>  		__field(unsigned int, ofs_in_node)
> -		__field(unsigned int, count)
> +		__field(blkcnt_t, count)
>  	),
>  
>  	TP_fast_assign(
> @@ -715,11 +715,11 @@ TRACE_EVENT(f2fs_reserve_new_blocks,
>  		__entry->count = count;
>  	),
>  
> -	TP_printk("dev = (%d,%d), nid = %u, ofs_in_node = %u, count = %u",
> +	TP_printk("dev = (%d,%d), nid = %u, ofs_in_node = %u, count = %llu",
>  		show_dev(__entry),
>  		(unsigned int)__entry->nid,
>  		__entry->ofs_in_node,
> -		__entry->count)
> +		(unsigned long long)__entry->count)
>  );
>  
>  DECLARE_EVENT_CLASS(f2fs__submit_page_bio,
> 
