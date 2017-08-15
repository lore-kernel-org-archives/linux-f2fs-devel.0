From: Yunlong Song <yunlong.song@huawei.com>
Subject: Re: [PATCH] f2fs: free_user_blocks should use reserved_segments
 instead
Date: Tue, 15 Aug 2017 15:17:44 +0800
Message-ID: <367fde95-a6f6-5600-5eda-df254e4ed03b@huawei.com>
References: <1502702552-78497-1-git-send-email-yunlong.song@huawei.com>
 <20170815033258.GD91145@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170815033258.GD91145@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Consider this, I have sent another patch v2, please review.

The part (overprovision_segments - reserved_segments) can still be used for LFS
in some case, e.g., there are lots of invalid block from dirty segments, then
the part (overprovision_segments - reserved_segments) can be safely used. So
free_use_blocks should use reserved_segments instead, rather than directly use
overprovision_segments. BTW, we also add the constraint of sbi->reserved_blocks.


On 2017/8/15 11:32, Jaegeuk Kim wrote:
> On 08/14, Yunlong Song wrote:
>> The part (overprovision_segments - reserved_segments) can still be used for LFS,
>> so free_use_blocks should use reserved_segments instead, rather than use
>> overprovision_segments.
>>
>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>> ---
>>   fs/f2fs/gc.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
>> index 9325191..6258305 100644
>> --- a/fs/f2fs/gc.h
>> +++ b/fs/f2fs/gc.h
>> @@ -49,10 +49,10 @@ struct gc_inode_list {
>>    */
>>   static inline block_t free_user_blocks(struct f2fs_sb_info *sbi)
> NAK. This gives user-visible block count.
>
>>   {
>> -	if (free_segments(sbi) < overprovision_segments(sbi))
>> +	if (free_segments(sbi) < reserved_segments(sbi))
>>   		return 0;
>>   	else
>> -		return (free_segments(sbi) - overprovision_segments(sbi))
>> +		return (free_segments(sbi) - reserved_segments(sbi))
>>   			<< sbi->log_blocks_per_seg;
>>   }
>>   
>> -- 
>> 1.8.5.2
> .
>

-- 
Thanks,
Yunlong Song
