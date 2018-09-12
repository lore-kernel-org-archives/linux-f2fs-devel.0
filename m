From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add new idle interval timing for
 discard and gc paths
Date: Wed, 12 Sep 2018 17:50:31 +0800
Message-ID: <d79bf580-361f-7a13-7c86-a04637f27653@huawei.com>
References: <1536551252-24256-1-git-send-email-stummala@codeaurora.org>
 <5d74d46b-8141-f048-9c0a-459c82b2c449@kernel.org>
 <20180911220958.GC55456@jaegeuk-macbookpro.roam.corp.google.com>
 <20180912082740.GB22939@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180912082740.GB22939@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sahitya Tummala <stummala@codeaurora.org>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/9/12 16:27, Sahitya Tummala wrote:
> On Tue, Sep 11, 2018 at 03:09:58PM -0700, Jaegeuk Kim wrote:
>> On 09/11, Chao Yu wrote:
>>> On 2018/9/10 11:47, Sahitya Tummala wrote:
>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>> index abf9256..6070681 100644
>>>> --- a/fs/f2fs/f2fs.h
>>>> +++ b/fs/f2fs/f2fs.h
>>>> @@ -1093,6 +1093,8 @@ enum {
>>>>  enum {
>>>>  	CP_TIME,
>>>>  	REQ_TIME,
>>>> +	DISCARD_TIME,
>>>> +	GC_TIME,
>>>>  	MAX_TIME,
>>>>  };
>>>>  
>>>> @@ -1347,14 +1349,35 @@ static inline void f2fs_update_time(struct f2fs_sb_info *sbi, int type)
>>>>  	sbi->last_time[type] = jiffies;
>>>>  }
>>>>  
>>>> -static inline bool f2fs_time_over(struct f2fs_sb_info *sbi, int type)
>>>> +static inline bool f2fs_time_over_cp(struct f2fs_sb_info *sbi)
>>
>> I don't see why we need this separately.
> 
> Yes, not really required. I will update it.
> 
>>
>>>> +{
>>>> +	unsigned long interval = sbi->interval_time[CP_TIME] * HZ;
>>>> +
>>>> +	return time_after(jiffies, sbi->last_time[CP_TIME] + interval);
>>>> +}
>>>> +
>>>> +static inline bool f2fs_time_over_req(struct f2fs_sb_info *sbi, int type)
>>>> +{
>>>> +	unsigned long interval = sbi->interval_time[type] * HZ;
>>>> +
>>>> +	return time_after(jiffies, sbi->last_time[REQ_TIME] + interval);
>>>> +}
>>>> +
>>>> +static inline unsigned int f2fs_get_wait_time(struct f2fs_sb_info *sbi,
>>>> +						int type)
>>
>> f2fs_time_to_wait()?
> 
> Sure.
> 
>>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>>> index 5c8d004..c0bafea 100644
>>>> --- a/fs/f2fs/gc.c
>>>> +++ b/fs/f2fs/gc.c
>>>> @@ -83,8 +83,10 @@ static int gc_thread_func(void *data)
>>>>  		if (!mutex_trylock(&sbi->gc_mutex))
>>>>  			goto next;
>>>>  
>>>> -		if (!is_idle(sbi)) {
>>>> -			increase_sleep_time(gc_th, &wait_ms);
>>>> +		if (!is_idle(sbi, GC_TIME)) {
>>>> +			wait_ms = f2fs_get_wait_time(sbi, GC_TIME);
>>>
>>> It seems this patch changes the method of increasing wait_ms here, if device is
>>> busy, we may wake up GC thread earlier than before, not sure we should do this.
>>>
>>> To Jaegeuk, how do you think of this?
>>
>> Yes, please let us discuss this in another patch.
> 
> Sure, I will submit this in another patch for discussion.

It's fine to me. :)

> 
