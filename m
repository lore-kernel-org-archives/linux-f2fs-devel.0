From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH 08/10] f2fs: relax async discard commands more
Date: Fri, 6 Jan 2017 10:06:10 +0800
Message-ID: <97193665-85ae-268f-c50c-8b29bc4b57c7@huawei.com>
References: <20161230185117.3832-1-jaegeuk@kernel.org>
 <20161230185117.3832-8-jaegeuk@kernel.org>
 <a32a776f-00a3-740b-5b62-7137250f4531@huawei.com>
 <f450fd45-1cf9-1969-007e-7cd72b614e08@huawei.com>
 <20170105194604.GA2064@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20170105194604.GA2064@jaegeuk.local>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/1/6 3:46, Jaegeuk Kim wrote:
> On 01/05, Chao Yu wrote:
>> On 2017/1/4 17:29, Chao Yu wrote:
>>> On 2016/12/31 2:51, Jaegeuk Kim wrote:
>>>> This patch relaxes async discard commands to avoid waiting its end_io during
>>>> checkpoint.
>>>> Instead of waiting them during checkpoint, it will be done when actually reusing
>>>> them.
>>>>
>>>> Test on initial partition of nvme drive.
>>>>
>>>>  # time fstrim /mnt/test
>>>>
>>>> Before : 6.158s
>>>> After : 4.822s
>>>>
>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>>
>>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>>>
>>> One comment below,
>>
>> I still have a comment on this patch.
>>
>>>> -void f2fs_wait_all_discard_bio(struct f2fs_sb_info *sbi)
>>>> +/* This should be covered by global mutex, &sit_i->sentry_lock */
>>>> +void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, unsigned int segno)
>>>>  {
>>>>  	struct list_head *wait_list = &(SM_I(sbi)->wait_list);
>>>>  	struct bio_entry *be, *tmp;
>>>> @@ -646,7 +650,15 @@ void f2fs_wait_all_discard_bio(struct f2fs_sb_info *sbi)
>>>>  		struct bio *bio = be->bio;
>>>>  		int err;
>>>>  
>>>> -		wait_for_completion_io(&be->event);
>>>> +		if (!completion_done(&be->event)) {
>>>> +			if ((be->start_segno >= segno &&
>>>> +					be->end_segno <= segno) ||
>>>
>>> segno >= be->start_segno && segno < be->end_segno ?

Still can not understand this judgment condition, we should wait completion of
discard command only when segno is locate in range of [start_segno, end_segno]?

But now, this condition can be true only when segno, start_segno, end_segno have
equal value.

Please correct me if I'm wrong.

Thanks,

>>
>> Can you check this?
> 
> The be->start_segno and be->end_segno are assigned by:
> 
> unsigned int start_segno = GET_SEGNO(sbi, blkstart);
> unsigned int end_segno = GET_SEGNO(sbi, blkstart + blklen);
> 
> in __f2fs_issue_discard_async().
> 
> So, the problem comes when, for example, blkstart = 0 and blklen = 512.
> 
> I should have got the end_segno by:
> 
> unsigned int end_segno = GET_SEGNO(sbi, blkstart + blklen - 1);
> 
> Thanks,
> 
> .
> 

