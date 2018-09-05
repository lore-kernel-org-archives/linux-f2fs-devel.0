From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: set 4KB discard granularity by
 default
Date: Wed, 5 Sep 2018 10:33:01 +0800
Message-ID: <548cb018-6d89-9552-34ee-e22cf4182ec5@huawei.com>
References: <20180810100806.9298-1-yuchao0@huawei.com>
 <20180814041329.GB52730@jaegeuk-macbookpro.roam.corp.google.com>
 <8dd153c2-5611-728b-e4a9-0c59486f53a4@huawei.com>
 <CAD14+f15yadDMY-fwSW5TVHRF1JAz-8kKocN0t258H7c1CTDAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD14+f15yadDMY-fwSW5TVHRF1JAz-8kKocN0t258H7c1CTDAw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ju Hyung Park <qkrwngud825@gmail.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

On 2018/9/4 22:36, Ju Hyung Park wrote:
> Hi,
> 
> I was wondering what would be the negatives on reducing the discard granularity

We may send more small-sized discard, which cost more IO times and lifetime, but
without this, we may heap up too many undiscard pages in device, it can make
write GC slower and cost more flash lifetime.

Thanks,

> other than making discard more aggressive(hence higher overhead and latency?).
> 
> Thanks.
> 
> On Tue, Aug 14, 2018 at 4:08 PM Chao Yu <yuchao0@huawei.com> wrote:
>>
>> On 2018/8/14 12:13, Jaegeuk Kim wrote:
>>> On 08/10, Chao Yu wrote:
>>>> Small granularity (size < 64K) fragmentation will cause f2fs suspending
>>>> all pending discards, result in performance regression, so let's set
>>>> 4KB discard granularity by default.
>>>>
>>>> So that without fstrim, we also have the ability to avoid any performance
>>>> regression caused by non-alignment mapping between fs and flash device.
>>>
>>> This is why we added a sysfs entry. Why do we need to change the default
>>> value every time?
>>
>> Of course, I didn't forget it. But, mostly, our user didn't know very well about
>> our filesystem including each configuration's meaning, mechanism, or usage
>> scenario, most of the time, they will choose to test f2fs with all default
>> option, and then make the conclusion.
>>
>> Currently, with default 64k granularity, if we simulate fragmentation scenario
>> of filesystem, like by a)writing 4k file and b)deleting even indexing file, then
>> all 4k discards won't be issued, result in exhaustion of free space of flash
>> storage, and performance degradation.
>>
>> So I think we'd better to consider and set default value of configuration more
>> elaborately to avoid obvious weakness.
>>
>> Thoughts?
>>
>> Thanks,
>>
>>>
>>>>
>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>> ---
>>>>  fs/f2fs/f2fs.h | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>> index 58431b9bfd8f..273ffdaf4891 100644
>>>> --- a/fs/f2fs/f2fs.h
>>>> +++ b/fs/f2fs/f2fs.h
>>>> @@ -248,7 +248,7 @@ struct discard_entry {
>>>>  };
>>>>
>>>>  /* default discard granularity of inner discard thread, unit: block count */
>>>> -#define DEFAULT_DISCARD_GRANULARITY         16
>>>> +#define DEFAULT_DISCARD_GRANULARITY         1
>>>>
>>>>  /* max discard pend list number */
>>>>  #define MAX_PLIST_NUM               512
>>>> --
>>>> 2.18.0.rc1
>>>
>>> .
>>>
>>
>>
>> ------------------------------------------------------------------------------
>> Check out the vibrant tech community on one of the world's most
>> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> .
> 
