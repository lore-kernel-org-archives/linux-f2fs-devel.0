From: "Gaoxiang (OS)" <gaoxiang25@huawei.com>
Subject: Re: [PATCH v3] f2fs: flush cp pack except cp pack 2 page
 at first
Date: Fri, 26 Jan 2018 02:03:53 +0000
Message-ID: <9047C53C18267742AB12E43B65C7F9F70BCD37C5@dggemi505-mbs.china.huawei.com>
References: <9047C53C18267742AB12E43B65C7F9F70BCD2F67@dggemi505-mbs.china.huawei.com>
 <20180125220600.GB22514@jaegeuk-macbookpro.roam.corp.google.com>
 <cd1124ea-707a-4f33-10a0-5478082479df@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <gaoxiang25@huawei.com>) id 1eetNC-0000Ix-37
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 26 Jan 2018 02:04:10 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189] helo=huawei.com)
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eetNA-00063h-Gm
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 26 Jan 2018 02:04:10 +0000
In-Reply-To: <cd1124ea-707a-4f33-10a0-5478082479df@huawei.com>
Content-Language: zh-CN
Content-ID: <780B30FC75A33941BDB21A299A7CE332@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "Yuchao (T)" <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>, heyunlei <heyunlei@huawei.com>, hutj <hutj@huawei.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "Duwei (Device OS)" <weidu.du@huawei.com>

Hi Jaegeuk and Chao,

On 2018/1/26 9:36, Chao Yu wrote:
> On 2018/1/26 6:06, Jaegeuk Kim wrote:
>>
>> Then, we don't need to wait for this as well as wait_on_all_pages_writeback()
>> in the early stage in do_checkpoint()?
>>
>> So, it seems like we can modify like below:
>>
>> ---
>> 1. while (get_pages())
>> 	sync_meta_pages()
>> 2. if (enabled_nat_bits())
>> 	while (get_pages())
>> 		sync_meta_pages()
>>
>> 3. wait_on_all_pages_writeback()
>>   -> remove
> 
> Would meta area across two devices? if it would, we need to wait all meta
> be persisted in second device before f2fs_flush_device_cache?
> 
>>
>> 4. f2fs_flush_device_cache()
>>
>> 5. update_meta_page() <- for first cp_block
>>
>> 6. update_meta_page()... <- payload
>>
>> 7. orphan writes
>>
>> 8. node_summary writes
>>
>> 9. update_meta_page() <- for last cp_block
>>   -> remove
> 

-       /* writeout checkpoint block */
-       update_meta_page(sbi, ckpt, start_blk);
-
-       /* wait for previous submitted node/meta pages writeback */
-       wait_on_all_pages_writeback(sbi);
-
-       if (unlikely(f2fs_cp_error(sbi)))
-               return -EIO;
-
Could also be removed, too?

         filemap_fdatawait_range(NODE_MAPPING(sbi), 0, LLONG_MAX);
         filemap_fdatawait_range(META_MAPPING(sbi), 0, LLONG_MAX);


> 9.1 sync_meta_pages(META) to make sure all meta IOs are issued.
> 

If I understand correctly, I have the same questions with Chao.
It seems that META doesn't have another flush mechanism (eg. flush 
thread) other than sync_meta_pages?

>>
>> 10. wait_on_all_pages_writeback()
>>
>> ----
>> Add) 11. commit_checkpoint()
>>    - update_meta_page() <- for last cp_block
>>    - sync_meta_pages(META_FLUSH)
>>
>> We don't need to wait for page_writeback any more.
>>


Apart from that, I think we should "wait_on_all_pages_writeback(sbi);" 
after META_FLUSH in case for pulluting the next checkpoint when the last 
cp block is failed to write with FUA?


Thanks all,

>>>   
>>> @@ -1313,10 +1337,15 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>>   	sbi->last_valid_block_count = sbi->total_valid_block_count;
>>>   	percpu_counter_set(&sbi->alloc_valid_block_count, 0);
>>>   
>>> -	/* Here, we only have one bio having CP pack */
>>> -	sync_meta_pages(sbi, META_FLUSH, LONG_MAX, FS_CP_META_IO);
>>> +	/* Here, we have one bio having CP pack except cp pack 2 page */
>>> +	sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
>>>   
>>>   	/* wait for previous submitted meta pages writeback */
>>> +	if (!test_opt(sbi, NOBARRIER))
>>
>> The above has nothing to do with this patch.
> 
> We only need to use wait_on_all_pages_writeback to keep writeback order of
> previous metadata and last cp pack metadata if barrier is on?
> 
> Thanks,
> 
>>
>>> +		wait_on_all_pages_writeback(sbi);
>>> +
>>> +	/* barrier and flush checkpoint cp pack 2 page */
>>> +	commit_checkpoint(sbi, ckpt, start_blk);
>>>   	wait_on_all_pages_writeback(sbi);
>>>   
>>>   	release_ino_entry(sbi, false);
>>> -- 
>>> 2.1.4
>>
>> .
>>
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
