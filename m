From: Yunlong Song <yunlong.song@huawei.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: update dirty status for CURSEG as well
Date: Fri, 13 Oct 2017 19:15:56 +0800
Message-ID: <93303124-c68e-6092-03c1-82fd026d0344@huawei.com>
References: <1507728318-113117-1-git-send-email-yunlong.song@huawei.com>
 <19ac8324-6743-34bf-a670-d20fec2cfd7f@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <19ac8324-6743-34bf-a670-d20fec2cfd7f@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>, jaegeuk@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com
Cc: linux-fsdevel@vger.kernel.org, miaoxie@huawei.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Correct, I will update the patch.

On 2017/10/13 19:08, Chao Yu wrote:
> Hi Yunlong,
>
> On 2017/10/11 21:25, Yunlong Song wrote:
>> Without this patch, it will cause all the free segments using up in some
>> corner case. For example, there are 100 segments, and 20 of them are
>> reserved for ovp. If 79 segments are full of data, segment 80 becomes
>> CURSEG segment, write 512 blocks and then delete 511 blocks. Since it is
>> CURSEG segment, the __locate_dirty_segment will not update its dirty
>> status. Then the dirty_segments(sbi) is 0, f2fs_gc will fail to
>> get_victim, and f2fs_balance_fs will fail to trigger gc action. After
>> f2fs_balance_fs returns, f2fs can continue to write data to segment 81.
>> Again, segment 81 becomes CURSEG segment, write 512 blocks and delete
>> 511 blocks, the dirty_segments(sbi) is 0 and f2fs_gc fail again. This
>> can finally use up all the free segments and cause panic.
> Should we also remove the check in locate_dirty_segment?
>
> Thanks,
>
>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>> ---
>>   fs/f2fs/segment.c | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index bfbcff8..0ff52d5 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -686,10 +686,6 @@ static void __locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
>>   {
>>   	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
>>   
>> -	/* need not be added */
>> -	if (IS_CURSEG(sbi, segno))
>> -		return;
>> -
>>   	if (!test_and_set_bit(segno, dirty_i->dirty_segmap[dirty_type]))
>>   		dirty_i->nr_dirty[dirty_type]++;
>>   
>>
> .
>

-- 
Thanks,
Yunlong Song
