From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: clear cold data flag if IO is not
 counted
Date: Wed, 17 Oct 2018 09:30:12 +0800
Message-ID: <b3f5fe2f-e082-5641-372a-2a7bb331a20c@huawei.com>
References: <20181010212217.52289-1-jaegeuk@kernel.org>
 <3f08031e-d195-5bc1-67e1-f3b6eab3506b@huawei.com>
 <20181015230807.GC1296@jaegeuk-macbookpro.roam.corp.google.com>
 <405b1521-cbfb-9f09-0d16-ae837b756cbb@huawei.com>
 <20181016031052.GA19956@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181016031052.GA19956@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/10/16 11:10, Jaegeuk Kim wrote:
> On 10/16, Chao Yu wrote:
>> On 2018/10/16 7:08, Jaegeuk Kim wrote:
>>> On 10/15, Chao Yu wrote:
>>>> On 2018/10/11 5:22, Jaegeuk Kim wrote:
>>>>> If we clear the cold data flag out of the writeback flow, we can miscount
>>>>> -1 by end_io.
>>>>
>>>> I didn't get it, which count do you mean?
>>>
>>> It's the number of dirty pages.
>>>
>>> Balancing F2FS Async:
>>>   - IO (CP:    1, Data:   -1, Flush: (   0    0    1), Discard: (   0 129304)) cmd:    0 undiscard:   0

Better to add such info in commit message. :)

>>>
>>
>> So I guess the race should be:
>>
>> GC thread:				IRQ
>> - move_data_page()
>>  - set_page_dirty()
>>   - clear_cold_data()
>> 					- f2fs_write_end_io()
>> 					 - type = WB_DATA_TYPE(page);
>> 					   here, we get wrong type
>> 					 - dec_page_count(sbi, type);
>>  - f2fs_wait_on_page_writeback()
>>
>> How about relocate wait_writeback & set_page_dirty to avoid above race:
> 
> Well, wait_on_stable_page() doesn't guarantee its end_io. So, I'm not sure
> this is the only case.

Yes, you're right, I missed that case.

Can you use git-revert to generate the patch? so we can remain original
commit info for better backward tracking.

How do you think pick up original patch I submitted:

https://lkml.org/lkml/2018/7/27/415

Thanks,

> 
>>
>> move_data_page()
>>
>> retry:
>> 		f2fs_wait_on_page_writeback(page, DATA, true);
>> 		set_page_dirty(page);
>>
>> Thanks,
>>
>>>>
>>>> Thanks,
>>>>
>>>>>
>>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>>>> ---
>>>>>  fs/f2fs/data.c | 4 ----
>>>>>  1 file changed, 4 deletions(-)
>>>>>
>>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>>>> index 29a9d3b8f709..4102799b5558 100644
>>>>> --- a/fs/f2fs/data.c
>>>>> +++ b/fs/f2fs/data.c
>>>>> @@ -2636,10 +2636,6 @@ static int f2fs_set_data_page_dirty(struct page *page)
>>>>>  	if (!PageUptodate(page))
>>>>>  		SetPageUptodate(page);
>>>>>  
>>>>> -	/* don't remain PG_checked flag which was set during GC */
>>>>> -	if (is_cold_data(page))
>>>>> -		clear_cold_data(page);
>>>>> -
>>>>>  	if (f2fs_is_atomic_file(inode) && !f2fs_is_commit_atomic_write(inode)) {
>>>>>  		if (!IS_ATOMIC_WRITTEN_PAGE(page)) {
>>>>>  			f2fs_register_inmem_page(inode, page);
>>>>>
>>>
>>> .
>>>
> 
> .
> 
