From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: flush cp pack except cp pack 2 page
 at first
Date: Wed, 31 Jan 2018 13:47:14 +0800
Message-ID: <56370690-0c2d-232e-c5fb-5d0c5eb2f8db@huawei.com>
References: <cd1124ea-707a-4f33-10a0-5478082479df@huawei.com>
 <9047C53C18267742AB12E43B65C7F9F70BCD37C5@dggemi505-mbs.china.huawei.com>
 <20180131021821.GC86468@jaegeuk-macbookpro.roam.corp.google.com>
 <9047C53C18267742AB12E43B65C7F9F70BCE43DE@dggemi505-mbx.china.huawei.com>
 <20180131023949.GB87929@jaegeuk-macbookpro.roam.corp.google.com>
 <9047C53C18267742AB12E43B65C7F9F70BCE44AE@dggemi505-mbx.china.huawei.com>
 <20180131025221.GC87929@jaegeuk-macbookpro.roam.corp.google.com>
 <9047C53C18267742AB12E43B65C7F9F70BCE451F@dggemi505-mbx.china.huawei.com>
 <20180131025949.GA90561@jaegeuk-macbookpro.roam.corp.google.com>
 <cf4301b5-48ae-00fd-6b0d-26f886ae926b@huawei.com>
 <20180131035131.GB93573@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20180131035131.GB93573@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: "Gaoxiang (OS)" <gaoxiang25@huawei.com>, Chao Yu <chao@kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, heyunlei <heyunlei@huawei.com>, hutj <hutj@huawei.com>, "Duwei (Device OS)" <weidu.du@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/1/31 11:51, Jaegeuk Kim wrote:
> On 01/31, Chao Yu wrote:
>> On 2018/1/31 10:59, Jaegeuk Kim wrote:
>>> On 01/31, Gaoxiang (OS) wrote:
>>>>
>>>>
>>>> On 2018/1/31 10:52, Jaegeuk Kim wrote:
>>>>> On 01/31, Gaoxiang (OS) wrote:
>>>>>> Hi Jaegeuk,
>>>>>>
>>>>>> On 2018/1/31 10:39, Jaegeuk Kim wrote:
>>>>>>> On 01/31, Gaoxiang (OS) wrote:
>>>>>>>> Hi Jaegeuk,
>>>>>>>>
>>>>>>>> On 2018/1/31 10:18, Jaegeuk Kim wrote:
>>>>>>>>> On 01/26, Gaoxiang (OS) wrote:
>>>>>>>>>> Hi Jaegeuk and Chao,
>>>>>>>>>>
>>>>>>>>>> On 2018/1/26 9:36, Chao Yu wrote:
>>>>>>>>>>> On 2018/1/26 6:06, Jaegeuk Kim wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> Then, we don't need to wait for this as well as wait_on_all_pages_writeback()
>>>>>>>>>>>> in the early stage in do_checkpoint()?
>>>>>>>>>>>>
>>>>>>>>>>>> So, it seems like we can modify like below:
>>>>>>>>>>>>
>>>>>>>>>>>> ---
>>>>>>>>>>>> 1. while (get_pages())
>>>>>>>>>>>> 	sync_meta_pages()
>>>>>>>>>>>> 2. if (enabled_nat_bits())
>>>>>>>>>>>> 	while (get_pages())
>>>>>>>>>>>> 		sync_meta_pages()
>>>>>>>>>>>>
>>>>>>>>>>>> 3. wait_on_all_pages_writeback()
>>>>>>>>>>>>      -> remove
>>>>>>>>>>>
>>>>>>>>>>> Would meta area across two devices? if it would, we need to wait all meta
>>>>>>>>>>> be persisted in second device before f2fs_flush_device_cache?
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> 4. f2fs_flush_device_cache()
>>>>>>>>>
>>>>>>>>>          -> remove
>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> 5. update_meta_page() <- for first cp_block
>>>>>>>>>>>>
>>>>>>>>>>>> 6. update_meta_page()... <- payload
>>>>>>>>>>>>
>>>>>>>>>>>> 7. orphan writes
>>>>>>>>>>>>
>>>>>>>>>>>> 8. node_summary writes
>>>>>>>>>>>>
>>>>>>>>>>>> 9. update_meta_page() <- for last cp_block
>>>>>>>>>>>>      -> remove
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> -       /* writeout checkpoint block */
>>>>>>>>>> -       update_meta_page(sbi, ckpt, start_blk);
>>>>>>>>>> -
>>>>>>>>>> -       /* wait for previous submitted node/meta pages writeback */
>>>>>>>>>> -       wait_on_all_pages_writeback(sbi);
>>>>>>>>>> -
>>>>>>>>>> -       if (unlikely(f2fs_cp_error(sbi)))
>>>>>>>>>> -               return -EIO;
>>>>>>>>>> -
>>>>>>>>>> Could also be removed, too?
>>>>>>>>>>
>>>>>>>>>>             filemap_fdatawait_range(NODE_MAPPING(sbi), 0, LLONG_MAX);
>>>>>>>>>>             filemap_fdatawait_range(META_MAPPING(sbi), 0, LLONG_MAX);
>>>>>>>>>
>>>>>>>>>         -> remove
>>>>>>>>>
>>>>>>>>> Hmm, think so.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>> 9.1 sync_meta_pages(META) to make sure all meta IOs are issued.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> If I understand correctly, I have the same questions with Chao.
>>>>>>>>>> It seems that META doesn't have another flush mechanism (eg. flush
>>>>>>>>>> thread) other than sync_meta_pages?
>>>>>>>>>
>>>>>>>>>       9.2 f2fs_flush_device_cache(), if we have multiple devices.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> 10. wait_on_all_pages_writeback()
>>>>>>>>>
>>>>>>>>>        10.1. (f2fs_cp_error())
>>>>>>>>>        	    return -EIO;
>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> ----
>>>>>>>>>>>> Add) 11. commit_checkpoint()
>>>>>>>>>>>>       - update_meta_page() <- for last cp_block
>>>>>>>>>>>>       - sync_meta_pages(META_FLUSH)
>>>>>>>>>>>>
>>>>>>>>>>>> We don't need to wait for page_writeback any more.
>>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Apart from that, I think we should "wait_on_all_pages_writeback(sbi);"
>>>>>>>>>> after META_FLUSH in case for pulluting the next checkpoint when the last
>>>>>>>>>> cp block is failed to write with FUA?
>>>>>>>>>
>>>>>>>>> Next cp block won't be written by 10.1.
>>>>>>>>>
>>>>>>>>
>>>>>>>> I think that 10.1 ensures the cp pack before the last cp_block was done.
>>>>>>>> However, what if the last cp block writes fail later without FUA?
>>>>>>>
>>>>>>> Without FUA? The last cp_block is written by FUA, no?
>>>>>>
>>>>>> quote "
>>>>>> Apart from that, I think we should "wait_on_all_pages_writeback(sbi);"
>>>>>> after META_FLUSH in case for pulluting the next checkpoint when the last
>>>>>> cp block is failed to write with FUA?
>>>>>> "
>>>>>>
>>>>>> what I meant is that the last cp_block should be written by FUA.
>>>>>> we need to use META_FLUSH to write last cp_block, right? :)
>>>>>
>>>>> Add) 11. commit_checkpoint()
>>>>>       - update_meta_page() <- for last cp_block
>>>>>       - sync_meta_pages(META_FLUSH)
>>>>>
>>>>> What do you mean? I added META_FLUSH.
>>>>>
>>>>> 9.1 sync_meta_pages(META);
>>>>>   -> 10. wait_on_all_pages_writeback();
>>>>>    -> 11. sync_meta_pages(META_FLUSH);
>>>>>
>>>>>      -> 9.1 sync_meta_pages(META);
>>>>>        -> 10. wait_on_all_pages_writeback();
>>>>>          -> 10.1 f2fs_cp_error() -> return -EIO;
>>>>>
>>>>
>>>> What I mean is
>>>> should we need to ensure FUA writing to medium (using the last
>>>> "wait_on_all_pages_writeback(sbi)") and then unblock_operation
>>>> ,quit write_checkpoint, go on fs operations
>>>>
>>>> 11. commit_checkpoint()
>>>> - update_meta_page() <- for last cp_block
>>>> - sync_meta_pages(META_FLUSH)
>>>> *12. wait_on_all_pages_writeback() *
>>>
>>> I'm saying we don't need this.
>>
>> I think we need this, because w/o this end_io can be called after
>> f2fs_cp_error, then we can not be aware of result of last IO in
>> current checkpoint.
> 
> Sigh, why do we have to get this error? The next checkpoint won't be
> succeeded.

This interface should be synchronized, if checkpoint failed, but user get
a return value indicates successful, that would be inconsistent.

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>>>
>>>> Sorry about my expression is not clear.
>>>>
>>>> Thanks,
>>>>
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>>>
>>>>>>>> Should we need to ensure the last cp block going into device medium
>>>>>>>> rather than device cache before switching to go into the next checkpoint
>>>>>>>> (I mean we need to ensure writing to medium and then unblock_operation
>>>>>>>> and quit write_checkpoint and go on fs operations)?
>>>>>>>>
>>>>>>>> Other parts seems OK for me :), I will sort out and resent a new patch.
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Thanks all,
>>>>>>>>>>
>>>>>>>>>>>>>      
>>>>>>>>>>>>> @@ -1313,10 +1337,15 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>>>>>>>>>>>>      	sbi->last_valid_block_count = sbi->total_valid_block_count;
>>>>>>>>>>>>>      	percpu_counter_set(&sbi->alloc_valid_block_count, 0);
>>>>>>>>>>>>>      
>>>>>>>>>>>>> -	/* Here, we only have one bio having CP pack */
>>>>>>>>>>>>> -	sync_meta_pages(sbi, META_FLUSH, LONG_MAX, FS_CP_META_IO);
>>>>>>>>>>>>> +	/* Here, we have one bio having CP pack except cp pack 2 page */
>>>>>>>>>>>>> +	sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
>>>>>>>>>>>>>      
>>>>>>>>>>>>>      	/* wait for previous submitted meta pages writeback */
>>>>>>>>>>>>> +	if (!test_opt(sbi, NOBARRIER))
>>>>>>>>>>>>
>>>>>>>>>>>> The above has nothing to do with this patch.
>>>>>>>>>>>
>>>>>>>>>>> We only need to use wait_on_all_pages_writeback to keep writeback order of
>>>>>>>>>>> previous metadata and last cp pack metadata if barrier is on?
>>>>>>>>>>>
>>>>>>>>>>> Thanks,
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>> +		wait_on_all_pages_writeback(sbi);
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +	/* barrier and flush checkpoint cp pack 2 page */
>>>>>>>>>>>>> +	commit_checkpoint(sbi, ckpt, start_blk);
>>>>>>>>>>>>>      	wait_on_all_pages_writeback(sbi);
>>>>>>>>>>>>>      
>>>>>>>>>>>>>      	release_ino_entry(sbi, false);
>>>>>>>>>>>>> -- 
>>>>>>>>>>>>> 2.1.4
>>>>>>>>>>>>
>>>>>>>>>>>> .
>>>>>>>>>>>>
>>>>>>>>>>>
>>>
>>> .
>>>
> 
> .
> 
