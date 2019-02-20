From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't clear CP_QUOTA_NEED_FSCK_FLAG
Date: Wed, 20 Feb 2019 15:31:15 +0800
Message-ID: <7580aa2e-b2eb-a686-a19d-4e82a713944a@huawei.com>
References: <20190212023343.52215-1-jaegeuk@kernel.org>
 <df77f830-e5dd-5943-d5b0-e21ced3a7df2@huawei.com>
 <20190216045530.GA57019@jaegeuk-macbookpro.roam.corp.google.com>
 <29a4fd24-6340-41df-7199-6e89b70c6341@huawei.com>
 <20190220070855.GA91331@jaegeuk-macbookpro.roam.corp.google.com>
 <c39a995f-9bfd-e68a-7d04-11bd8c0f8e64@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c39a995f-9bfd-e68a-7d04-11bd8c0f8e64@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2019/2/20 15:25, Chao Yu wrote:
> On 2019/2/20 15:08, Jaegeuk Kim wrote:
>> On 02/18, Chao Yu wrote:
>>> On 2019/2/16 12:55, Jaegeuk Kim wrote:
>>>> On 02/13, Chao Yu wrote:
>>>>> On 2019/2/12 10:33, Jaegeuk Kim wrote:
>>>>>> If we met this once, let fsck.f2fs clear this only.
>>>>>> Note that, this addresses all the subtle fault injection test.
>>>>>>
>>>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>>>>> ---
>>>>>>  fs/f2fs/checkpoint.c | 2 --
>>>>>>  1 file changed, 2 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>>>>>> index 03fea4efd64b..10a3ada28715 100644
>>>>>> --- a/fs/f2fs/checkpoint.c
>>>>>> +++ b/fs/f2fs/checkpoint.c
>>>>>> @@ -1267,8 +1267,6 @@ static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>>>>>  
>>>>>>  	if (is_sbi_flag_set(sbi, SBI_QUOTA_SKIP_FLUSH))
>>>>>>  		__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
>>>>>> -	else
>>>>>> -		__clear_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
>>>>>
>>>>> I didn't get it, previously, if we didn't persist all quota file's data in
>>>>> checkpoint, then we will tag CP_QUOTA_NEED_FSCK_FLAG in CP area, but in current
>>>>> checkpoint, we have persisted all quota file's data, quota files are consistent
>>>>> with all other files in filesystem, why we can't remove this NEED_FSCK flag..?
>>>>
>>>> I said it's subtle. So, I guessed 1) set CP_QUOTA_NEED_FSCK_FLAG, 2) clear
>>>
>>> I know it's subtle... and I agreed we can fix it like this in upstream
>>> first, but in our product, it's not rare that we hit the
>>> QUOTA_SKIP_FLUSH(its value is 4) case, later we may encounter long latency
>>> caused by quota repairing of fsck.
>>>
>>>> SBI_QUOTA_SKIP_FLUSH by checkpoint, 3) clear CP_QUOTA_NEED_FSCK_FLAG by another
>>>> checkpoint?
>>>
>>> But later if QUOTA_NEED_REPAIR is set, we will set QUOTA_NEED_FSCK_FLAG
>>> again, right?
>>>
>>> if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_REPAIR))
>>> 	__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
>>>
>>>
>>> So in order to figure out whether this is caused by out-of-order execution
>>> of below assignments:
>>>
>>> 	if (is_sbi_flag_set(sbi, SBI_QUOTA_SKIP_FLUSH))
>>> 		__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
>>> 	else
>>> 		__clear_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG); --- clear flag later
>>>
>>> 	if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_REPAIR))
>>> 		__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG); --- set flag first
>>>
>>>
>>> Could you have a try:
>>>
>>> 	if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_REPAIR) ||
>>> 			is_sbi_flag_set(sbi, SBI_QUOTA_SKIP_FLUSH))
>>> 		__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
>>> 	else
>>> 		__clear_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
>>
>> What does this mean? I'm in doubt we have a missing case where we clear this
> 
> Cpu pipeline / compiler can make code out-of-order execution, which means:
> 
> a = 1;
> b = 2;
> 
> may actually be executed as the order of:
> 
> b = 2;
> a = 1;
> 
> So I doubt that below two line codes can be executed out-of-order:
> 
> else
> 	__clear_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG); --- clear flag later
> 
> if ()
> 	__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG); --- set flag first
> 
>> flag, CP_QUOTA_NEED_FSCK_FLAG.
> 
> Agreed, I've checked each operation in f2fs_quota_operations yesterday, and
> didn't find any missing places yet...

Oh, I mean the place where set SBI_QUOTA_NEED_REPAIR, I also doubt we
missed to set the flag.

Thanks,

> 
> Thanks,
> 
>>
>>>
>>> Thanks,
>>>
>>>>
>>>>>
>>>>> Thanks,
>>>>>
>>>>>>  
>>>>>>  	if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_REPAIR))
>>>>>>  		__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
>>>>>>
>>>>
>>>> .
>>>>
>>
>> .
>>
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> .
> 
