From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v2] f2fs: free_user_blocks should use reserved_segments
 instead
Date: Fri, 18 Aug 2017 23:19:53 +0800
Message-ID: <42326662-a08f-d140-89f0-d7364e088903@kernel.org>
References: <1502702552-78497-1-git-send-email-yunlong.song@huawei.com>
 <1502781273-97035-1-git-send-email-yunlong.song@huawei.com>
 <624b1f95-1b48-1b2e-4e9a-27d19859b878@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <624b1f95-1b48-1b2e-4e9a-27d19859b878@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Yunlong,

I think you have changed original implication of the function, IMO, it would be
more accurate to use user_free_segment_blocks instead of free_user_blocks.

Thanks,

On 2017/8/18 18:02, Yunlong Song wrote:
> ping...
> 
> On 2017/8/15 15:14, Yunlong Song wrote:
>> The part (overprovision_segments - reserved_segments) can still be used for LFS
>> in some case, e.g., there are lots of invalid block from dirty segments, then
>> the part (overprovision_segments - reserved_segments) can be safely used. So
>> free_use_blocks should use reserved_segments instead, rather than directly use
>> overprovision_segments. BTW, we also add the constraint of sbi->reserved_blocks.
>>
>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>> ---
>>   fs/f2fs/gc.h | 18 +++++++++++++++---
>>   1 file changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
>> index 9325191..542612a 100644
>> --- a/fs/f2fs/gc.h
>> +++ b/fs/f2fs/gc.h
>> @@ -49,11 +49,23 @@ struct gc_inode_list {
>>    */
>>   static inline block_t free_user_blocks(struct f2fs_sb_info *sbi)
>>   {
>> -    if (free_segments(sbi) < overprovision_segments(sbi))
>> +    block_t avail_user_block_count, free_blocks, avail_free_blocks;
>> +    block_t reserved_blocks;
>> +
>> +    avail_user_block_count = sbi->user_block_count - sbi->reserved_blocks;
>> +
>> +    if (unlikely(sbi->total_valid_block_count > avail_user_block_count))
>> +        return 0;
>> +
>> +    free_blocks = free_segments(sbi) << sbi->log_blocks_per_seg;
>> +    avail_free_blocks = min(free_blocks, avail_user_block_count -
>> +                                sbi->total_valid_block_count);
>> +    reserved_blocks = reserved_segments(sbi) << sbi->log_blocks_per_seg;
>> +
>> +    if (avail_free_blocks < reserved_blocks)
>>           return 0;
>>       else
>> -        return (free_segments(sbi) - overprovision_segments(sbi))
>> -            << sbi->log_blocks_per_seg;
>> +        return avail_free_blocks - reserved_blocks;
>>   }
>>     static inline block_t limit_invalid_user_blocks(struct f2fs_sb_info *sbi)
> 
