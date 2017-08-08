From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: fix some cases with reserved_blocks
Date: Tue, 8 Aug 2017 16:13:06 +0800
Message-ID: <6f5a864b-b1e7-370c-c714-8e139c245f43@huawei.com>
References: <1502165548-2023-1-git-send-email-yunlong.song@huawei.com>
 <5cf16cae-e6bd-13e8-7309-c975f5a27c96@huawei.com>
 <0d7c0552-e9d6-ae17-6c9c-bf33b3a7d06d@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0d7c0552-e9d6-ae17-6c9c-bf33b3a7d06d@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/8/8 14:33, Yunlong Song wrote:
> Does this means the reserved_blocks cannot be used by users by can be 
> used by filesystem?

Yup.

> If it can be used by filesystem, then this cannot ensure the flash 
> device really reserve the
> reserved_blocks space, right? The reserved_blocks is just for users?

No, only if we didn't issue any discards, otherwise we can benefit from less GC
overhead in device due to higher over-provision rate.

Thanks,

> 
> On 2017/8/8 14:08, Chao Yu wrote:
>> On 2017/8/8 12:12, Yunlong Song wrote:
>>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>>> ---
>>>   fs/f2fs/recovery.c | 3 ++-
>>>   fs/f2fs/super.c    | 9 +++++----
>>>   2 files changed, 7 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
>>> index a3d0261..e288319 100644
>>> --- a/fs/f2fs/recovery.c
>>> +++ b/fs/f2fs/recovery.c
>>> @@ -51,7 +51,8 @@ bool space_for_roll_forward(struct f2fs_sb_info *sbi)
>>>   {
>>>   	s64 nalloc = percpu_counter_sum_positive(&sbi->alloc_valid_block_count);
>>>   
>>> -	if (sbi->last_valid_block_count + nalloc > sbi->user_block_count)
>>> +	if (sbi->last_valid_block_count + nalloc +
>>> +			sbi->reserved_blocks > sbi->user_block_count)
>> I think we can treat reserved blocks as over-provision space in f2fs, so it
>> would be safe to store invalid data (may become valid during recovery) there.
>> Anyway, it OK to remain old condition judgment.
>>
>>>   		return false;
>>>   	return true;
>>>   }
>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>> index 4c1bdcb..c644bf5 100644
>>> --- a/fs/f2fs/super.c
>>> +++ b/fs/f2fs/super.c
>>> @@ -946,6 +946,7 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
>>>   	u64 id = huge_encode_dev(sb->s_bdev->bd_dev);
>>>   	block_t total_count, user_block_count, start_count, ovp_count;
>>>   	u64 avail_node_count;
>>> +	block_t avail_user_block_count;
>>>   
>>>   	total_count = le64_to_cpu(sbi->raw_super->block_count);
>>>   	user_block_count = sbi->user_block_count;
>>> @@ -953,16 +954,16 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
>>>   	ovp_count = SM_I(sbi)->ovp_segments << sbi->log_blocks_per_seg;
>>>   	buf->f_type = F2FS_SUPER_MAGIC;
>>>   	buf->f_bsize = sbi->blocksize;
>>> +	avail_user_block_count = user_block_count - sbi->reserved_blocks;
>>>   
>>>   	buf->f_blocks = total_count - start_count;
>>>   	buf->f_bfree = user_block_count - valid_user_blocks(sbi) + ovp_count;
>>> -	buf->f_bavail = user_block_count - valid_user_blocks(sbi) -
>>> -						sbi->reserved_blocks;
>>> +	buf->f_bavail = avail_user_block_count - valid_user_blocks(sbi);
>>>   
>>>   	avail_node_count = sbi->total_node_count - F2FS_RESERVED_NODE_NUM;
>>>   
>>> -	if (avail_node_count > user_block_count) {
>>> -		buf->f_files = user_block_count;
>>> +	if (avail_node_count > avail_user_block_count) {
>> Likewise f_blocks calculation, the f_files one doesn't need to consider
>> reserved_blocks.
>>
>> Thanks,
>>
>>> +		buf->f_files = avail_user_block_count;
>>>   		buf->f_ffree = buf->f_bavail;
>>>   	} else {
>>>   		buf->f_files = avail_node_count;
>>>
>>
>> .
>>
> 
