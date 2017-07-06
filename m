From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: don't count inode block in in-memory inode.i_blocks
Date: Thu, 6 Jul 2017 08:15:29 +0800
Message-ID: <2954ca00-7078-5a87-a3f0-cc4795b63ac5@kernel.org>
References: <20170705155733.4257-1-chao@kernel.org>
 <20170705165658.GA30935@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170705165658.GA30935@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/7/6 0:56, Jaegeuk Kim wrote:
> On 07/05, Chao Yu wrote:
>> From: Chao Yu <yuchao0@huawei.com>
>>
>> Previously, we count all inode consumed blocks including inode block,
>> xattr block, index block, data block into i_blocks, for other generic
>> file systems, they won't count inode block into i_blocks, so for
>> userspace applications or quota system, it may detect incorrect block
>> count in inode.
>>
>> This patch changes to count all blocks into inode.i_blocks excluding
>> inode block, for on-disk i_blocks, we keep counting inode block for
>> backward compatibility.
> 
> Good catch!
> I fixed return value of inc_valid_node_count inline below.

Thanks for the review. I confound this patch with the quota one.

Anyway, let me send v2.

Thanks,

> 
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/f2fs.h  | 24 +++++++++++++-----------
>>  fs/f2fs/inode.c |  4 ++--
>>  fs/f2fs/node.c  | 16 ++++++----------
>>  3 files changed, 21 insertions(+), 23 deletions(-)
>>
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index abf9eea67966..9d5b1e4ad5d4 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -1355,8 +1355,6 @@ static inline int check_nid_range(struct f2fs_sb_info *sbi, nid_t nid)
>>  	return 0;
>>  }
>>  
>> -#define F2FS_DEFAULT_ALLOCATED_BLOCKS	1
>> -
>>  /*
>>   * Check whether the inode has blocks or not
>>   */
>> @@ -1364,8 +1362,7 @@ static inline int F2FS_HAS_BLOCKS(struct inode *inode)
>>  {
>>  	block_t xattr_block = F2FS_I(inode)->i_xattr_nid ? 1 : 0;
>>  
>> -	return (inode->i_blocks >> F2FS_LOG_SECTORS_PER_BLOCK) >
>> -			(F2FS_DEFAULT_ALLOCATED_BLOCKS + xattr_block);
>> +	return (inode->i_blocks >> F2FS_LOG_SECTORS_PER_BLOCK) > xattr_block;
>>  }
>>  
>>  static inline bool f2fs_has_xattr_block(unsigned int ofs)
>> @@ -1552,7 +1549,7 @@ static inline block_t __start_sum_addr(struct f2fs_sb_info *sbi)
>>  }
>>  
>>  static inline bool inc_valid_node_count(struct f2fs_sb_info *sbi,
>> -						struct inode *inode)
>> +					struct inode *inode, bool is_inode)
>>  {
>>  	block_t	valid_block_count;
>>  	unsigned int valid_node_count;
>> @@ -1572,27 +1569,32 @@ static inline bool inc_valid_node_count(struct f2fs_sb_info *sbi,
>>  		return false;
>>  	}
>>  
>> -	if (inode)
>> -		f2fs_i_blocks_write(inode, 1, true);
>> +	if (inode) {
>> +		if (is_inode)
>> +			f2fs_mark_inode_dirty_sync(inode, true);
>> +		else
>> +			f2fs_i_blocks_write(inode, 1, true);
>> +	}
>>  
>>  	sbi->total_valid_node_count++;
>>  	sbi->total_valid_block_count++;
>>  	spin_unlock(&sbi->stat_lock);
>>  
>>  	percpu_counter_inc(&sbi->alloc_valid_block_count);
>> -	return true;
>> +	return 0;
> 
> Need to return true.
> 
> Thanks,
> 
>>  }
>>  
>>  static inline void dec_valid_node_count(struct f2fs_sb_info *sbi,
>> -						struct inode *inode)
>> +					struct inode *inode, bool is_inode)
>>  {
>>  	spin_lock(&sbi->stat_lock);
>>  
>>  	f2fs_bug_on(sbi, !sbi->total_valid_block_count);
>>  	f2fs_bug_on(sbi, !sbi->total_valid_node_count);
>> -	f2fs_bug_on(sbi, !inode->i_blocks);
>> +	f2fs_bug_on(sbi, !is_inode && !inode->i_blocks);
>>  
>> -	f2fs_i_blocks_write(inode, 1, false);
>> +	if (!is_inode)
>> +		f2fs_i_blocks_write(inode, 1, false);
>>  	sbi->total_valid_node_count--;
>>  	sbi->total_valid_block_count--;
>>  
>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
>> index 1ff5bd418d87..e42a7a8805dc 100644
>> --- a/fs/f2fs/inode.c
>> +++ b/fs/f2fs/inode.c
>> @@ -130,7 +130,7 @@ static int do_read_inode(struct inode *inode)
>>  	i_gid_write(inode, le32_to_cpu(ri->i_gid));
>>  	set_nlink(inode, le32_to_cpu(ri->i_links));
>>  	inode->i_size = le64_to_cpu(ri->i_size);
>> -	inode->i_blocks = SECTOR_FROM_BLOCK(le64_to_cpu(ri->i_blocks));
>> +	inode->i_blocks = SECTOR_FROM_BLOCK(le64_to_cpu(ri->i_blocks) - 1);
>>  
>>  	inode->i_atime.tv_sec = le64_to_cpu(ri->i_atime);
>>  	inode->i_ctime.tv_sec = le64_to_cpu(ri->i_ctime);
>> @@ -268,7 +268,7 @@ int update_inode(struct inode *inode, struct page *node_page)
>>  	ri->i_gid = cpu_to_le32(i_gid_read(inode));
>>  	ri->i_links = cpu_to_le32(inode->i_nlink);
>>  	ri->i_size = cpu_to_le64(i_size_read(inode));
>> -	ri->i_blocks = cpu_to_le64(SECTOR_TO_BLOCK(inode->i_blocks));
>> +	ri->i_blocks = cpu_to_le64(SECTOR_TO_BLOCK(inode->i_blocks) + 1);
>>  
>>  	if (et) {
>>  		read_lock(&et->lock);
>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>> index fd57ffd88508..b9f14ba6441f 100644
>> --- a/fs/f2fs/node.c
>> +++ b/fs/f2fs/node.c
>> @@ -678,15 +678,11 @@ static void truncate_node(struct dnode_of_data *dn)
>>  	struct node_info ni;
>>  
>>  	get_node_info(sbi, dn->nid, &ni);
>> -	if (dn->inode->i_blocks == 0) {
>> -		f2fs_bug_on(sbi, ni.blk_addr != NULL_ADDR);
>> -		goto invalidate;
>> -	}
>>  	f2fs_bug_on(sbi, ni.blk_addr == NULL_ADDR);
>>  
>>  	/* Deallocate node address */
>>  	invalidate_blocks(sbi, ni.blk_addr);
>> -	dec_valid_node_count(sbi, dn->inode);
>> +	dec_valid_node_count(sbi, dn->inode, dn->nid == dn->inode->i_ino);
>>  	set_node_addr(sbi, &ni, NULL_ADDR, false);
>>  
>>  	if (dn->nid == dn->inode->i_ino) {
>> @@ -694,7 +690,7 @@ static void truncate_node(struct dnode_of_data *dn)
>>  		dec_valid_inode_count(sbi);
>>  		f2fs_inode_synced(dn->inode);
>>  	}
>> -invalidate:
>> +
>>  	clear_node_page_dirty(dn->node_page);
>>  	set_sbi_flag(sbi, SBI_IS_DIRTY);
>>  
>> @@ -1044,7 +1040,7 @@ struct page *new_node_page(struct dnode_of_data *dn,
>>  	if (!page)
>>  		return ERR_PTR(-ENOMEM);
>>  
>> -	if (unlikely(!inc_valid_node_count(sbi, dn->inode))) {
>> +	if (unlikely(!inc_valid_node_count(sbi, dn->inode, !ofs))) {
>>  		err = -ENOSPC;
>>  		goto fail;
>>  	}
>> @@ -2207,14 +2203,14 @@ int recover_xattr_data(struct inode *inode, struct page *page, block_t blkaddr)
>>  	get_node_info(sbi, prev_xnid, &ni);
>>  	f2fs_bug_on(sbi, ni.blk_addr == NULL_ADDR);
>>  	invalidate_blocks(sbi, ni.blk_addr);
>> -	dec_valid_node_count(sbi, inode);
>> +	dec_valid_node_count(sbi, inode, false);
>>  	set_node_addr(sbi, &ni, NULL_ADDR, false);
>>  
>>  recover_xnid:
>>  	/* 2: update xattr nid in inode */
>>  	remove_free_nid(sbi, new_xnid);
>>  	f2fs_i_xnid_write(inode, new_xnid);
>> -	if (unlikely(!inc_valid_node_count(sbi, inode)))
>> +	if (unlikely(!inc_valid_node_count(sbi, inode, false)))
>>  		f2fs_bug_on(sbi, 1);
>>  	update_inode_page(inode);
>>  
>> @@ -2272,7 +2268,7 @@ int recover_inode_page(struct f2fs_sb_info *sbi, struct page *page)
>>  	new_ni = old_ni;
>>  	new_ni.ino = ino;
>>  
>> -	if (unlikely(!inc_valid_node_count(sbi, NULL)))
>> +	if (unlikely(!inc_valid_node_count(sbi, NULL, true)))
>>  		WARN_ON(1);
>>  	set_node_addr(sbi, &new_ni, NEW_ADDR, false);
>>  	inc_valid_inode_count(sbi);
>> -- 
>> 2.13.0.90.g1eb437020
