From: Yunlong Song <yunlong.song@huawei.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: update dirty status for CURSEG as
 well
Date: Sat, 14 Oct 2017 20:53:01 +0800
Message-ID: <3c29460d-36c6-45d5-2c02-b38f0afa5ac2@huawei.com>
References: <1507728318-113117-1-git-send-email-yunlong.song@huawei.com>
 <1507900897-156286-1-git-send-email-yunlong.song@huawei.com>
 <72f5511f-dcd4-939b-661f-f333738ee691@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <72f5511f-dcd4-939b-661f-f333738ee691@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>, jaegeuk@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com
Cc: linux-fsdevel@vger.kernel.org, miaoxie@huawei.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Oh, yes it is. I found that problem in a kernel tree which does not have 
commit
c6f82fe90d7458e5fa190a6820bfc24f96b0de4e (Revert "f2fs: put allocate_segment
after refresh_sit_entry"). In that kernel, the allocate_segment is still 
behind
refresh_sit_entry. Now I understand the commit message:
"This makes a leak to register dirty segments. I reproduced the issue by
     modified postmark which injects a lot of file create/delete/update and
     finally triggers huge number of SSR allocations."

The reason is that if refresh_sit_entry is before allocate_segment, then the
dirty status of CURSEG is not updated, as a result, the count of dirty 
segments
is wrong, which is much smaller than its real value. Then the f2fs_gc 
can not
do its work since it can not even get one victim, then the free segments are
used up and then triggers much SSR. So Jay reverts the patch.

It seems there are two options:
(1) keep this patch ([PATCH v2] f2fs: update dirty status for CURSEG as 
well)
and we can recover commit 3436c4bdb30de421d46f58c9174669fbcfd40ce0
(f2fs: put allocate_segment after refresh_sit_entry)
(2) remove this patch at all

It seems (1) is robust, but (2) avoids unnecessary check.

On 2017/10/14 8:14, Chao Yu wrote:
> On 2017/10/13 21:21, Yunlong Song wrote:
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
> Look into this patch again, I found refresh_sit_entry is called after
> ->allocate_segment, so if all 512 blocks were allocated, log header should
> have been moved to another segment, so locate_dirty_segment in
> refresh_sit_entry should update dirty status of previous segment correctly,
> anything I'm missing?
>
> Thanks,
>
>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>> ---
>>   fs/f2fs/segment.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index bfbcff8..0fce076 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -687,7 +687,7 @@ static void __locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
>>   	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
>>   
>>   	/* need not be added */
>> -	if (IS_CURSEG(sbi, segno))
>> +	if (IS_CURSEG(sbi, segno) && dirty_type == PRE)
>>   		return;
>>   
>>   	if (!test_and_set_bit(segno, dirty_i->dirty_segmap[dirty_type]))
>> @@ -737,7 +737,7 @@ static void locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno)
>>   	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
>>   	unsigned short valid_blocks;
>>   
>> -	if (segno == NULL_SEGNO || IS_CURSEG(sbi, segno))
>> +	if (segno == NULL_SEGNO)
>>   		return;
>>   
>>   	mutex_lock(&dirty_i->seglist_lock);
>>
> .
>

-- 
Thanks,
Yunlong Song
