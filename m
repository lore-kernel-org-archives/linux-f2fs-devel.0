From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: introduce nid cache
Date: Wed, 15 Feb 2017 10:25:44 +0800
Message-ID: <36e910e1-a9c6-2e9a-20e9-1b7f617587ee@huawei.com>
References: <20170122095331.58427-1-yuchao0@huawei.com>
 <20170124043500.GC1566@jaegeuk.local>
 <452624a9-8b9a-843c-98df-00187a8f795a@huawei.com>
 <5c8999e9-f405-7e23-0d1a-209b24f040d8@kernel.org>
 <20170209012840.GB10747@jaegeuk.local>
 <c90c4d25-02cc-0a55-82e4-d1815b606dd9@huawei.com>
 <20170214002500.GA14533@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170214002500.GA14533@jaegeuk.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, houpengyang <houpengyang@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/2/14 8:25, Jaegeuk Kim wrote:
> On 02/11, Chao Yu wrote:
>> On 2017/2/9 9:28, Jaegeuk Kim wrote:
>>> On 02/08, Chao Yu wrote:
>>>> On 2017/2/7 15:24, Chao Yu wrote:
>>>>> Hi Jaegeuk,
>>>>>
>>>>> Happy Chinese New Year! :)
>>>>>
>>>>> On 2017/1/24 12:35, Jaegeuk Kim wrote:
>>>>>> Hi Chao,
>>>>>>
>>>>>> On 01/22, Chao Yu wrote:
>>>>>>> In scenario of intensively node allocation, free nids will be ran out
>>>>>>> soon, then it needs to stop to load free nids by traversing NAT blocks,
>>>>>>> in worse case, if NAT blocks does not be cached in memory, it generates
>>>>>>> IOs which slows down our foreground operations.
>>>>>>>
>>>>>>> In order to speed up node allocation, in this patch we introduce a new
>>>>>>> option named "nid cache", when turns on this option, it will load all
>>>>>>> nat entries in NAT blocks when doing mount, and organize all free nids
>>>>>>> in a bitmap, for any operations related to free nid, we will query and
>>>>>>> set the new prebuilded bitmap instead of reading and lookuping NAT
>>>>>>> blocks, so performance of node allocation can be improved.
>>>>>>>
>>>>>>
>>>>>> How does this affect mount time and memory consumption?
>>>>>
>>>>> Sorry for the delay.
>>>>>
>>>>> Let me figure out some numbers later.
>>>>
>>>> a. mount time
>>>>
>>>> I choose slow device (Kingston 16GB SD card) to see how this option affect mount
>>>> time when there is not enough bandwidth in low level,
>>>>
>>>> Before the test, I change readahead window size of NAT pages from FREE_NID_PAGES
>>>> * 8 to sbi->blocks_per_seg for better ra performance, so the result is:
>>>>
>>>> time mount -t f2fs -o nid_cache /dev/sde /mnt/f2fs/
>>>>
>>>> before:
>>>> real	0m0.204s
>>>> user	0m0.004s
>>>> sys	0m0.020s
>>>>
>>>> after:
>>>> real	0m3.792s
>>>
>>> Oops, we can't accept this even only for 16GB, right? :(
>>
>> Pengyang Hou help testing this patch in 64GB UFS, the result of mount time is:
>>
>> Before:	110 ms
>> After:	770 ms
>>
>> So these test results shows that we'd better not set nid_cache option by default
>> in upstream since anyway it slows down mount procedure obviously, but still
>> users can decide whether use it or not depending on their requirement. e.g.:
>> a. For readonly case, this option is complete no needed.
>> b. For in batch node allocation/deletion case, this option is recommended.
>>
>>>
>>>> user	0m0.000s
>>>> sys	0m0.140s
>>>>
>>>> b. memory consumption
>>>>
>>>> For 16GB size image, there is total 34 NAT pages, so memory footprint is:
>>>> 34 / 2 * 512 * 455 / 8 = 495040 bytes = 483.4 KB
>>>>
>>>> Increasing of memory footprint is liner with total user valid blocks in image,
>>>> and at most it will eat 3900 * 8 * 455 / 8 = 1774500 bytes = 1732.9 KB
>>>
>>> How about adding two bitmaps for whole NAT pages and storing the bitmaps in
>>> checkpoint pack, which needs at most two blocks additionally?
>>>
>>> 1. full-assigned NAT bitmap, where 1 means there is no free nids.
>>> 2. empty NAT bitmap, where 1 means whole there-in nids are free.
>>>
>>> With these bitmaps, build_free_nids() can scan from 0'th NAT block by:
>>>
>>> 	if (full-assigned NAT)
>>> 		skip;
>>> 	else if (empty NAT)
>>> 		add_free_nid(all);
>>> 	else
>>> 		read NAT page and add_free_nid();
>>>
>>> The flush_nat_entries() has to change its bitmaps accordingly.
>>>
>>> With this approach, I expect we can reuse nids as much as possible while
>>> getting cached NAT pages more effectively.
>>
>> Good idea! :)
>>
>> And there is another approach which do not need to change disk layout is:
>>
>> We can allocate free_nid_bitmap[NAT_BLOCKS_COUNT][455] array, each bitmap
>> indicates usage of free nids in one NAT block, and we introduce another
>> nat_block_bitmap[NAT_BLOCKS_COUNT] to indicate each NAT block is loaded or not,
>> if it is loaded and we can do lookup in free_nid_bitmap correspondingly. So I
>> expect that we will load one NAT block from disk one time at most, it will:
>> - not increase mount latency
>> - after loading NAT blocks from disk, we will build its bitmap inside memory to
>> reduce lookup time for second time
> 
> Yup, I think both of them are doable together. Meanwhile, I've written patches
> which support the bitmaps for NAT pages and started to test them. Could you
> write a patch to introduce free_nid_bitmap[][] as well?

No problem. :)

Thanks,

> 
> Thanks,
> 
>>
>> Thoughts? Which one is preferred?
>>
>> Thanks,
>>
>>>
>>> Thanks,
>>>
>>>>
>>>> Thanks,
>>>>
>>>>>
>>>>>> IMO, if those do not
>>>>>> raise huge concerns, we would be able to consider just replacing current free
>>>>>> nid list with this bitmap.
>>>>>
>>>>> Yup, I agree with you.
>>>>>
>>>>> Thanks,
>>>>>
>>>
>>> .
>>>
> 
> .
> 
