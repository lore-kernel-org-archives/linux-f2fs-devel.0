From: Hyunchul Lee <hyc.lee@gmail.com>
Subject: Re: [f2fs-dev] [RFC PATHC 2/2] f2fs: apply write hints to select
 the type of segment for direct write
Date: Mon, 13 Nov 2017 09:07:47 +0900
Message-ID: <5A08E253.50408@gmail.com>
References: <1510206688-12767-1-git-send-email-hyc.lee@gmail.com> <1510206688-12767-3-git-send-email-hyc.lee@gmail.com> <711d3991-47e1-bc1c-4eb8-c9254fec156a@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <711d3991-47e1-bc1c-4eb8-c9254fec156a@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: kernel-team@lge.com, Hyunchul Lee <cheol.lee@lge.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.netkernel-team@lge.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 11/11/2017 09:38 AM, Chao Yu wrote:
> On 2017/11/9 13:51, Hyunchul Lee wrote:
>> From: Hyunchul Lee <cheol.lee@lge.com>
>>
>> Select the type of the segment using write hints, when blocks are
>> allocated for direct write.
>>
>> There are unhandled corner cases. Hints are not applied in
>> in-place update.  And if the blocks of a file is not pre-allocated
>> because of the invalid user buffer, CURSEG_WARM_DATA segment will
>> be selected.
>>
>> Signed-off-by: Hyunchul Lee <cheol.lee@lge.com>
>> ---
>>  fs/f2fs/data.c | 101 ++++++++++++++++++++++++++++++++++-----------------------
>>  fs/f2fs/f2fs.h |   1 +
>>  2 files changed, 61 insertions(+), 41 deletions(-)
>>
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index 36b5352..d06048a 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -783,7 +783,7 @@ struct page *get_new_data_page(struct inode *inode,
>>  	return page;
>>  }
>>  
>> -static int __allocate_data_block(struct dnode_of_data *dn)
>> +static int __allocate_data_block(struct dnode_of_data *dn, int seg_type)
>>  {
>>  	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
>>  	struct f2fs_summary sum;
>> @@ -808,7 +808,7 @@ static int __allocate_data_block(struct dnode_of_data *dn)
>>  	set_summary(&sum, dn->nid, dn->ofs_in_node, ni.version);
>>  
>>  	allocate_data_block(sbi, NULL, dn->data_blkaddr, &dn->data_blkaddr,
>> -					&sum, CURSEG_WARM_DATA, NULL, false);
>> +					&sum, seg_type, NULL, false);
>>  	set_data_blkaddr(dn);
>>  
>>  	/* update i_size */
>> @@ -827,42 +827,6 @@ static inline bool __force_buffered_io(struct inode *inode, int rw)
>>  			F2FS_I_SB(inode)->s_ndevs);
>>  }
>>  
>> -int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
>> -{
>> -	struct inode *inode = file_inode(iocb->ki_filp);
>> -	struct f2fs_map_blocks map;
>> -	int err = 0;
>> -
>> -	if (is_inode_flag_set(inode, FI_NO_PREALLOC))
>> -		return 0;
>> -
>> -	map.m_lblk = F2FS_BLK_ALIGN(iocb->ki_pos);
>> -	map.m_len = F2FS_BYTES_TO_BLK(iocb->ki_pos + iov_iter_count(from));
>> -	if (map.m_len > map.m_lblk)
>> -		map.m_len -= map.m_lblk;
>> -	else
>> -		map.m_len = 0;
>> -
>> -	map.m_next_pgofs = NULL;
>> -
>> -	if (iocb->ki_flags & IOCB_DIRECT) {
>> -		err = f2fs_convert_inline_inode(inode);
>> -		if (err)
>> -			return err;
>> -		return f2fs_map_blocks(inode, &map, 1,
>> -			__force_buffered_io(inode, WRITE) ?
>> -				F2FS_GET_BLOCK_PRE_AIO :
>> -				F2FS_GET_BLOCK_PRE_DIO);
>> -	}
>> -	if (iocb->ki_pos + iov_iter_count(from) > MAX_INLINE_DATA(inode)) {
>> -		err = f2fs_convert_inline_inode(inode);
>> -		if (err)
>> -			return err;
>> -	}
>> -	if (!f2fs_has_inline_data(inode))
>> -		return f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_AIO);
>> -	return err;
>> -}
>>  
>>  static inline void __do_map_lock(struct f2fs_sb_info *sbi, int flag, bool lock)
>>  {
>> @@ -888,8 +852,8 @@ static inline void __do_map_lock(struct f2fs_sb_info *sbi, int flag, bool lock)
>>   *     b. do not use extent cache for better performance
>>   *     c. give the block addresses to blockdev
>>   */
>> -int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>> -						int create, int flag)
>> +static int __f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>> +				int create, int flag, int seg_type)
>>  {
>>  	unsigned int maxblocks = map->m_len;
>>  	struct dnode_of_data dn;
>> @@ -957,7 +921,12 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>>  					last_ofs_in_node = dn.ofs_in_node;
>>  				}
>>  			} else {
>> -				err = __allocate_data_block(&dn);
>> +				/* if this inode is marked with FI_NO_PREALLOC,
>> +				 * @seg_type is NO_CHECK_TYPE
>> +				 */
>> +				if (seg_type == NO_CHECK_TYPE)
>> +					seg_type = CURSEG_WARM_DATA;
>> +				err = __allocate_data_block(&dn, seg_type);
> 
> We need to use inode.i_write_hint instead of ki_hint passed from file.f_write_hint?
> 

The following commit says to use file.f_write_hint if it is available. 
"c75b1d9 fs: add fcntl() interface for setting/getting write life time hints"

And ki_hint is assiged to file.f_write_hint or inode.i_write_hint 
by file_write_hint() in init_sync_kiocb().
So, I think we need to use ki_hint instead of inode.i_write_hint.

Thanks

> Thanks,
> 
>>  				if (!err)
>>  					set_inode_flag(inode, FI_APPEND_WRITE);
>>  			}
>> @@ -1048,6 +1017,51 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>>  	return err;
>>  }
>>  
>> +int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>> +						int create, int flag)
>> +{
>> +	return __f2fs_map_blocks(inode, map, create, flag, NO_CHECK_TYPE);
>> +}
>> +
>> +int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
>> +{
>> +	struct inode *inode = file_inode(iocb->ki_filp);
>> +	struct f2fs_map_blocks map;
>> +	int err = 0;
>> +
>> +	if (is_inode_flag_set(inode, FI_NO_PREALLOC))
>> +		return 0;
>> +
>> +	map.m_lblk = F2FS_BLK_ALIGN(iocb->ki_pos);
>> +	map.m_len = F2FS_BYTES_TO_BLK(iocb->ki_pos + iov_iter_count(from));
>> +	if (map.m_len > map.m_lblk)
>> +		map.m_len -= map.m_lblk;
>> +	else
>> +		map.m_len = 0;
>> +
>> +	map.m_next_pgofs = NULL;
>> +
>> +	if (iocb->ki_flags & IOCB_DIRECT) {
>> +		err = f2fs_convert_inline_inode(inode);
>> +		if (err)
>> +			return err;
>> +		return __f2fs_map_blocks(inode, &map, 1,
>> +			__force_buffered_io(inode, WRITE) ?
>> +				F2FS_GET_BLOCK_PRE_AIO :
>> +				F2FS_GET_BLOCK_PRE_DIO,
>> +				rw_hint_to_seg_type(iocb->ki_hint));
>> +	}
>> +	if (iocb->ki_pos + iov_iter_count(from) > MAX_INLINE_DATA(inode)) {
>> +		err = f2fs_convert_inline_inode(inode);
>> +		if (err)
>> +			return err;
>> +	}
>> +	if (!f2fs_has_inline_data(inode))
>> +		return f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_AIO);
>> +
>> +	return err;
>> +}
>> +
>>  static int __get_data_block(struct inode *inode, sector_t iblock,
>>  			struct buffer_head *bh, int create, int flag,
>>  			pgoff_t *next_pgofs)
>> @@ -2082,6 +2096,11 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>>  
>>  	trace_f2fs_direct_IO_enter(inode, offset, count, rw);
>>  
>> +	/* This is for avoiding the situation that the data of a segment is
>> +	 * passed down to devices with different hints
>> +	 */
>> +	iocb->ki_hint = WRITE_LIFE_NOT_SET;
>> +
>>  	down_read(&F2FS_I(inode)->dio_rwsem[rw]);
>>  	err = blockdev_direct_IO(iocb, inode, iter, get_data_block_dio);
>>  	up_read(&F2FS_I(inode)->dio_rwsem[rw]);
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 4b4a72f..9be5658 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -2562,6 +2562,7 @@ int lookup_journal_in_cursum(struct f2fs_journal *journal, int type,
>>  void destroy_segment_manager(struct f2fs_sb_info *sbi);
>>  int __init create_segment_manager_caches(void);
>>  void destroy_segment_manager_caches(void);
>> +int rw_hint_to_seg_type(enum rw_hint hint);
>>  
>>  /*
>>   * checkpoint.c
>>
> 
