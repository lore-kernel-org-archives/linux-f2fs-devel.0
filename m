From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix ref of discard command
Date: Wed, 14 Jun 2017 23:40:21 +0800
Message-ID: <b7b15c66-6a60-e0d3-53bc-2f1b0b8c94d3@kernel.org>
References: <20170612030449.79290-1-jaegeuk@kernel.org>
 <54b5aaad-1674-8d76-c489-d5eee6ef7f26@huawei.com>
 <20170614142648.GA74571@jaegeuk-macbookpro.roam.corp.google.com>
 <9c37cfd8-3fc1-43b6-91d8-9f9dbf15a4d7@kernel.org>
 <20170614152007.GD74571@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20170614152007.GD74571@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <yuchao0@huawei.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/6/14 23:20, Jaegeuk Kim wrote:
> On 06/14, Chao Yu wrote:
>> On 2017/6/14 22:26, Jaegeuk Kim wrote:
>>> On 06/12, Chao Yu wrote:
>>>> Hi Jaegeuk,
>>>>
>>>> On 2017/6/12 11:04, Jaegeuk Kim wrote:
>>>>> This patch resolves kernel panic for xfstests/081, caused by recent f2fs_bug_on
>>>>>
>>>>>   f2fs: add f2fs_bug_on in __remove_discard_cmd
>>>>>
>>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>>>> ---
>>>>>  fs/f2fs/segment.c | 2 ++
>>>>>  1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>>>> index 86a0c1095939..a6d77388a806 100644
>>>>> --- a/fs/f2fs/segment.c
>>>>> +++ b/fs/f2fs/segment.c
>>>>> @@ -1025,6 +1025,8 @@ static void __wait_discard_cmd(struct f2fs_sb_info *sbi, bool wait_cond)
>>>>>  	list_for_each_entry_safe(dc, tmp, wait_list, list) {
>>>>>  		if (!wait_cond || (dc->state == D_DONE && !dc->ref)) {
>>>>>  			wait_for_completion_io(&dc->wait);
>>>>> +			if (dc->state == D_DONE && dc->ref)
>>>>> +				dc->ref--;
>>>>
>>>> Should set dc->ref to 0 to avoid panic once we add other referrers?
>>>
>>> Sorry, could you please explain this in more detail?
>>
>> Oh, I just assume later we may add another referrer for some reason
>> which will make dc->ref = 2, so dc->ref-- is not enough to avoid the
>> bug_on in __remove_discard_cmd. I think reseting dc->ref is more safe
>> here, how do you think?
> 
> Well, for now, it makes more sense to do like this when considering ref flow,
> IIUC. What will make dc->ref = 2 later? Even in that case, why not making zero

It's just assumption, till now, I do not have it in my mind ;)

> by adding dc->ref-- appropriately?

You mean as below?

dc->ref--;
if (dc->ref > 0)
	dc->ref--;

Thanks,

> 
> Thanks,
> 
>>
>> Thanks,
>>
>>>
>>> Thanks,
>>>
>>>>
>>>> Thanks,
>>>>
>>>>>  			__remove_discard_cmd(sbi, dc);
>>>>>  		} else {
>>>>>  			dc->ref++;
>>>>>
>>>
>>> ------------------------------------------------------------------------------
>>> Check out the vibrant tech community on one of the world's most
>>> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>>> _______________________________________________
>>> Linux-f2fs-devel mailing list
>>> Linux-f2fs-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>>
