From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: allow out-place-update for direct IO
 in LFS mode
Date: Thu, 20 Sep 2018 20:16:59 +0800
Message-ID: <0f643ff0-7d49-6175-a449-f18bd368fbbc@kernel.org>
References: <20180920085718.66966-1-yuchao0@huawei.com>
 <20180920112555.GI22939@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180920112555.GI22939@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sahitya Tummala <stummala@codeaurora.org>, Chao Yu <yuchao0@huawei.com>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/9/20 19:25, Sahitya Tummala wrote:
> On Thu, Sep 20, 2018 at 04:57:18PM +0800, Chao Yu wrote:
>> Normally, DIO uses in-pllace-update, but in LFS mode, f2fs doesn't
>> allow triggering any in-place-update writes, so we fallback direct
>> write to buffered write, result in bad performance of large size
>> write.
>>
>> This patch adds to support triggering out-place-update for direct IO
>> to enhance its performance.
>>
>> Note that it needs to exclude direct read IO during direct write,
>> since new data writing to new block address will no be valid until
>> write finished.
>>
>> storage: zram
>>
>> time xfs_io -f -d /mnt/f2fs/file -c "pwrite 0 1073741824" -c "fsync"
>>
>> Before:
>> real	0m13.061s
>> user	0m0.327s
>> sys	0m12.486s
>>
>> After:
>> real	0m6.448s
>> user	0m0.228s
>> sys	0m6.212s
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>> v2:
>> - don't use direct IO for block zoned device.
>>  fs/f2fs/data.c | 41 +++++++++++++++++++++++++++++++++--------
>>  fs/f2fs/f2fs.h | 45 +++++++++++++++++++++++++++++++++++++++++----
>>  fs/f2fs/file.c |  3 ++-
>>  3 files changed, 76 insertions(+), 13 deletions(-)
>>
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index b96f8588d565..e709f0fbb7a8 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -894,7 +894,7 @@ static int __allocate_data_block(struct dnode_of_data *dn, int seg_type)
>>  
>>  	dn->data_blkaddr = datablock_addr(dn->inode,
>>  				dn->node_page, dn->ofs_in_node);
>> -	if (dn->data_blkaddr == NEW_ADDR)
>> +	if (dn->data_blkaddr != NULL_ADDR)
>>  		goto alloc;
>>  
>>  	if (unlikely((err = inc_valid_block_count(sbi, dn->inode, &count))))
>> @@ -950,7 +950,7 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
>>  
>>  	if (direct_io) {
>>  		map.m_seg_type = f2fs_rw_hint_to_seg_type(iocb->ki_hint);
>> -		flag = f2fs_force_buffered_io(inode, WRITE) ?
>> +		flag = f2fs_force_buffered_io(inode, iocb, from) ?
>>  					F2FS_GET_BLOCK_PRE_AIO :
>>  					F2FS_GET_BLOCK_PRE_DIO;
>>  		goto map_blocks;
>> @@ -1069,7 +1069,15 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>>  		goto sync_out;
>>  	}
>>  
>> -	if (!is_valid_data_blkaddr(sbi, blkaddr)) {
>> +	if (is_valid_data_blkaddr(sbi, blkaddr)) {
>> +		/* use out-place-update for driect IO under LFS mode */
>> +		if (test_opt(sbi, LFS) && create &&
>> +				flag == F2FS_GET_BLOCK_DEFAULT) {
>> +			err = __allocate_data_block(&dn, map->m_seg_type);
>> +			if (!err)
>> +				set_inode_flag(inode, FI_APPEND_WRITE);
>> +		}
>> +	} else {
>>  		if (create) {
>>  			if (unlikely(f2fs_cp_error(sbi))) {
>>  				err = -EIO;
>> @@ -2493,36 +2501,53 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>>  	struct address_space *mapping = iocb->ki_filp->f_mapping;
>>  	struct inode *inode = mapping->host;
>>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>> +	struct f2fs_inode_info *fi = F2FS_I(inode);
>>  	size_t count = iov_iter_count(iter);
>>  	loff_t offset = iocb->ki_pos;
>>  	int rw = iov_iter_rw(iter);
>>  	int err;
>>  	enum rw_hint hint = iocb->ki_hint;
>>  	int whint_mode = F2FS_OPTION(sbi).whint_mode;
>> +	bool lock_read;
>>  
>>  	err = check_direct_IO(inode, iter, offset);
>>  	if (err)
>>  		return err < 0 ? err : 0;
>>  
>> -	if (f2fs_force_buffered_io(inode, rw))
>> +	if (f2fs_force_buffered_io(inode, iocb, iter))
>>  		return 0;
>>  
>> +	lock_read = allow_outplace_dio(inode, iocb, iter);
>> +
>>  	trace_f2fs_direct_IO_enter(inode, offset, count, rw);
>>  
>>  	if (rw == WRITE && whint_mode == WHINT_MODE_OFF)
>>  		iocb->ki_hint = WRITE_LIFE_NOT_SET;
>>  
>> -	if (!down_read_trylock(&F2FS_I(inode)->i_gc_rwsem[rw])) {
>> -		if (iocb->ki_flags & IOCB_NOWAIT) {
>> +	if (iocb->ki_flags & IOCB_NOWAIT) {
>> +		if (!down_read_trylock(&fi->i_gc_rwsem[rw])) {
>> +			iocb->ki_hint = hint;
>> +			err = -EAGAIN;
>> +			goto out;
>> +		}
>> +		if (lock_read && !down_read_trylock(&fi->i_gc_rwsem[READ])) {
>> +			up_read(&fi->i_gc_rwsem[rw]);
>>  			iocb->ki_hint = hint;
>>  			err = -EAGAIN;
>>  			goto out;
>>  		}
>> -		down_read(&F2FS_I(inode)->i_gc_rwsem[rw]);
>> +	} else {
>> +		down_read(&fi->i_gc_rwsem[rw]);
>> +		if (lock_read)
>> +			down_read(&fi->i_gc_rwsem[READ]);
>>  	}
>>  
>>  	err = blockdev_direct_IO(iocb, inode, iter, get_data_block_dio);
>> -	up_read(&F2FS_I(inode)->i_gc_rwsem[rw]);
>> +
>> +	if (lock_read)
>> +		up_read(&fi->i_gc_rwsem[READ]);
>> +
>> +	up_read(&fi->i_gc_rwsem[rw]);
>>  
>>  	if (rw == WRITE) {
> 
> The current code is setting the FI_UPDATE_WRITE inode flag in the success case
> in this if block. I think it needs to be removed as it is over-writing the
> the flag FI_APPEND_WRITE that this patch now sets in f2fs_map_blocks() and it
> now supports out-of-place updates.

Agreed, let me fix this in v3, thanks for catching this.

Thanks,

> 
>>  		if (whint_mode == WHINT_MODE_OFF)
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 63fffd5b105d..39d0b15f2816 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -8,6 +8,7 @@
>>  #ifndef _LINUX_F2FS_H
>>  #define _LINUX_F2FS_H
>>  
>> +#include <linux/uio.h>
>>  #include <linux/types.h>
>>  #include <linux/page-flags.h>
>>  #include <linux/buffer_head.h>
>> @@ -3461,11 +3462,47 @@ static inline bool f2fs_may_encrypt(struct inode *inode)
>>  #endif
>>  }
>>  
>> -static inline bool f2fs_force_buffered_io(struct inode *inode, int rw)
>> +static inline int block_unaligned_IO(struct inode *inode,
>> +				struct kiocb *iocb, struct iov_iter *iter)
>>  {
>> -	return (f2fs_post_read_required(inode) ||
>> -			(rw == WRITE && test_opt(F2FS_I_SB(inode), LFS)) ||
>> -			F2FS_I_SB(inode)->s_ndevs);
>> +	unsigned int i_blkbits = READ_ONCE(inode->i_blkbits);
>> +	unsigned int blocksize_mask = (1 << i_blkbits) - 1;
>> +	loff_t offset = iocb->ki_pos;
>> +	unsigned long align = offset | iov_iter_alignment(iter);
>> +
>> +	return align & blocksize_mask;
>> +}
>> +
>> +static inline int allow_outplace_dio(struct inode *inode,
>> +				struct kiocb *iocb, struct iov_iter *iter)
>> +{
>> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>> +	int rw = iov_iter_rw(iter);
>> +
>> +	return (test_opt(sbi, LFS) && (rw == WRITE) &&
>> +				!block_unaligned_IO(inode, iocb, iter));
>> +}
>> +
>> +static inline bool f2fs_force_buffered_io(struct inode *inode,
>> +				struct kiocb *iocb, struct iov_iter *iter)
>> +{
>> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>> +	int rw = iov_iter_rw(iter);
>> +
>> +	if (f2fs_post_read_required(inode))
>> +		return true;
>> +	if (sbi->s_ndevs)
>> +		return true;
>> +	/*
>> +	 * for blkzoned device, fallback direct IO to buffered IO, so
>> +	 * all IOs can be serialized by log-structured write.
>> +	 */
>> +	if (f2fs_sb_has_blkzoned(sbi))
>> +		return true;
>> +	if (test_opt(sbi, LFS) && (rw == WRITE) &&
>> +				block_unaligned_IO(inode, iocb, iter))
>> +		return true;
>> +	return false;
>>  }
>>  
>>  #ifdef CONFIG_F2FS_FAULT_INJECTION
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 428e7398bd89..70491631e040 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -3018,7 +3018,8 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>>  				if (!f2fs_overwrite_io(inode, iocb->ki_pos,
>>  						iov_iter_count(from)) ||
>>  					f2fs_has_inline_data(inode) ||
>> -					f2fs_force_buffered_io(inode, WRITE)) {
>> +					f2fs_force_buffered_io(inode,
>> +							iocb, from)) {
>>  						clear_inode_flag(inode,
>>  								FI_NO_PREALLOC);
>>  						inode_unlock(inode);
>> -- 
>> 2.18.0.rc1
>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
