From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH RESEND] f2fs: support soft block reservation
Date: Thu, 26 Oct 2017 17:37:29 +0800
Message-ID: <33bd1621-3584-506d-24f8-993b57ac3cb7@huawei.com>
References: <20171026054837.57721-1-yuchao0@huawei.com>
 <20171026090726.GB54331@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1e7ecT-0007id-8e
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 26 Oct 2017 09:38:33 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1e7ecR-0006pS-3E
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 26 Oct 2017 09:38:33 +0000
In-Reply-To: <20171026090726.GB54331@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/10/26 17:07, Jaegeuk Kim wrote:
> On 10/26, Chao Yu wrote:
>> From: Yunlong Song <yunlong.song@huawei.com>
>>
>> It supports to extend reserved_blocks sysfs interface to be soft
>> threshold, which allows user configure it exceeding current available
>> user space.
> 
> So, how can we change sbi->reserved_blocks?
> Could you please summarize how reserved_blocks and current_reserved_blocks
> are different?

Okay, let me explain this:

Previously, we just support hard reservation of blocks, it means if system
has 200MB free blocks, we only can reserve <= 200MB free blocks through sysfs,
otherwise, reserving will fail.

In this patch, we begin to support soft one, it can reserve blocks exceeding
free blocks, which means, if system has 200MB free blocks, we can reserve >
200MB free blocks.

> 
> What does current_reserved_blocks mean? Isn't "reserved_blocks" current?

So, reserved_blocks means the target block number we want to reserve, and
current_reserved_blocks is current block number we have reserved. Meanwhile
blocks are freed by user, we will reserve more free blocks until
current_reserved_blocks touching the target reserved_blocks.

> We have to make sysfs entry show just one value without any string.

For better analysis? So we need another sysfs entry for current_reserved_blocks
if we can support this feature?

Thanks,

> 
> Thanks,
> 
>>
>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  Documentation/ABI/testing/sysfs-fs-f2fs |  3 ++-
>>  fs/f2fs/f2fs.h                          | 13 +++++++++++--
>>  fs/f2fs/super.c                         |  3 ++-
>>  fs/f2fs/sysfs.c                         | 16 ++++++++++++++--
>>  4 files changed, 29 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
>> index 11b7f4ebea7c..ba282ca5eb15 100644
>> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
>> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
>> @@ -138,7 +138,8 @@ What:		/sys/fs/f2fs/<disk>/reserved_blocks
>>  Date:		June 2017
>>  Contact:	"Chao Yu" <yuchao0@huawei.com>
>>  Description:
>> -		 Controls current reserved blocks in system.
>> +		 Controls current reserved blocks in system, the threshold
>> +		 is soft, it could exceed current available user space.
>>  
>>  What:		/sys/fs/f2fs/<disk>/gc_urgent
>>  Date:		August 2017
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 6d2984abc50f..6680da47fb1a 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -1094,6 +1094,7 @@ struct f2fs_sb_info {
>>  	block_t discard_blks;			/* discard command candidats */
>>  	block_t last_valid_block_count;		/* for recovery */
>>  	block_t reserved_blocks;		/* configurable reserved blocks */
>> +	block_t current_reserved_blocks;	/* current reserved blocks */
>>  
>>  	u32 s_next_generation;			/* for NFS support */
>>  
>> @@ -1575,7 +1576,8 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
>>  
>>  	spin_lock(&sbi->stat_lock);
>>  	sbi->total_valid_block_count += (block_t)(*count);
>> -	avail_user_block_count = sbi->user_block_count - sbi->reserved_blocks;
>> +	avail_user_block_count = sbi->user_block_count -
>> +					sbi->current_reserved_blocks;
>>  	if (unlikely(sbi->total_valid_block_count > avail_user_block_count)) {
>>  		diff = sbi->total_valid_block_count - avail_user_block_count;
>>  		*count -= diff;
>> @@ -1609,6 +1611,10 @@ static inline void dec_valid_block_count(struct f2fs_sb_info *sbi,
>>  	f2fs_bug_on(sbi, sbi->total_valid_block_count < (block_t) count);
>>  	f2fs_bug_on(sbi, inode->i_blocks < sectors);
>>  	sbi->total_valid_block_count -= (block_t)count;
>> +	if (sbi->reserved_blocks &&
>> +		sbi->current_reserved_blocks < sbi->reserved_blocks)
>> +		sbi->current_reserved_blocks = min(sbi->reserved_blocks,
>> +					sbi->current_reserved_blocks + count);
>>  	spin_unlock(&sbi->stat_lock);
>>  	f2fs_i_blocks_write(inode, count, false, true);
>>  }
>> @@ -1755,7 +1761,7 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
>>  	spin_lock(&sbi->stat_lock);
>>  
>>  	valid_block_count = sbi->total_valid_block_count + 1;
>> -	if (unlikely(valid_block_count + sbi->reserved_blocks >
>> +	if (unlikely(valid_block_count + sbi->current_reserved_blocks >
>>  						sbi->user_block_count)) {
>>  		spin_unlock(&sbi->stat_lock);
>>  		goto enospc;
>> @@ -1798,6 +1804,9 @@ static inline void dec_valid_node_count(struct f2fs_sb_info *sbi,
>>  
>>  	sbi->total_valid_node_count--;
>>  	sbi->total_valid_block_count--;
>> +	if (sbi->reserved_blocks &&
>> +		sbi->current_reserved_blocks < sbi->reserved_blocks)
>> +		sbi->current_reserved_blocks++;
>>  
>>  	spin_unlock(&sbi->stat_lock);
>>  
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 3fd62ee53eb7..3fd846ac7268 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -983,7 +983,7 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
>>  	buf->f_blocks = total_count - start_count;
>>  	buf->f_bfree = user_block_count - valid_user_blocks(sbi) + ovp_count;
>>  	buf->f_bavail = user_block_count - valid_user_blocks(sbi) -
>> -						sbi->reserved_blocks;
>> +						sbi->current_reserved_blocks;
>>  
>>  	avail_node_count = sbi->total_node_count - F2FS_RESERVED_NODE_NUM;
>>  
>> @@ -2450,6 +2450,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>>  				le64_to_cpu(sbi->ckpt->valid_block_count);
>>  	sbi->last_valid_block_count = sbi->total_valid_block_count;
>>  	sbi->reserved_blocks = 0;
>> +	sbi->current_reserved_blocks = 0;
>>  
>>  	for (i = 0; i < NR_INODE_TYPE; i++) {
>>  		INIT_LIST_HEAD(&sbi->inode_list[i]);
>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
>> index 751964da2bca..87487ca8f62e 100644
>> --- a/fs/f2fs/sysfs.c
>> +++ b/fs/f2fs/sysfs.c
>> @@ -107,12 +107,23 @@ static ssize_t features_show(struct f2fs_attr *a,
>>  	return len;
>>  }
>>  
>> +static ssize_t f2fs_reserved_blocks_show(struct f2fs_attr *a,
>> +					struct f2fs_sb_info *sbi, char *buf)
>> +{
>> +	return snprintf(buf, PAGE_SIZE,
>> +			"expected:	%u\ncurrent:	%u\n",
>> +			sbi->reserved_blocks, sbi->current_reserved_blocks);
>> +}
>> +
>>  static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
>>  			struct f2fs_sb_info *sbi, char *buf)
>>  {
>>  	unsigned char *ptr = NULL;
>>  	unsigned int *ui;
>>  
>> +	if (a->struct_type == RESERVED_BLOCKS)
>> +		return f2fs_reserved_blocks_show(a, sbi, buf);
>> +
>>  	ptr = __struct_ptr(sbi, a->struct_type);
>>  	if (!ptr)
>>  		return -EINVAL;
>> @@ -146,12 +157,13 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
>>  #endif
>>  	if (a->struct_type == RESERVED_BLOCKS) {
>>  		spin_lock(&sbi->stat_lock);
>> -		if ((unsigned long)sbi->total_valid_block_count + t >
>> -				(unsigned long)sbi->user_block_count) {
>> +		if (t > (unsigned long)sbi->user_block_count) {
>>  			spin_unlock(&sbi->stat_lock);
>>  			return -EINVAL;
>>  		}
>>  		*ui = t;
>> +		sbi->current_reserved_blocks = min(sbi->reserved_blocks,
>> +				sbi->user_block_count - valid_user_blocks(sbi));
>>  		spin_unlock(&sbi->stat_lock);
>>  		return count;
>>  	}
>> -- 
>> 2.13.1.388.g69e6b9b4f4a9
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
