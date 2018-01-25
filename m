From: "Gaoxiang (OS)" <gaoxiang25@huawei.com>
Subject: Re: [PATCH RFC v2] f2fs: flush cp pack except cp page2
 at first
Date: Thu, 25 Jan 2018 08:45:46 +0000
Message-ID: <9047C53C18267742AB12E43B65C7F9F70BCD2EE2@dggemi505-mbs.china.huawei.com>
References: <9047C53C18267742AB12E43B65C7F9F70BCD2DE9@dggemi505-mbs.china.huawei.com>
 <c6974458-a5eb-8fad-e7db-644136333f49@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <gaoxiang25@huawei.com>) id 1eedAb-00018b-JG
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 25 Jan 2018 08:46:05 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187] helo=huawei.com)
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eedAY-0003Ms-S0
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 25 Jan 2018 08:46:05 +0000
In-Reply-To: <c6974458-a5eb-8fad-e7db-644136333f49@huawei.com>
Content-Language: zh-CN
Content-ID: <61659B0FADC739499343799F95B5CFD8@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "Yuchao (T)" <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, hutj <hutj@huawei.com>, "Duwei (Device OS)" <weidu.du@huawei.com>, heyunlei <heyunlei@huawei.com>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

Hi Chao,

On 2018/1/25 16:18, Chao Yu wrote:
> On 2018/1/25 15:05, Gaoxiang (OS) wrote:
>> Previously, we attempt to flush the whole cp pack in a single bio,
>> however, when suddenly powering off at this time, we could get into
>> an extreme scenario that cp page1 and cp page2 are updated and
>> latest, but payload or current summaries are still partially outdated.
>> (see reliable write in the UFS specification)
>>
>> This patch submits the whole cp pack except cp page2 at first,
>> and then writes the cp page2 with an extra independent
>> bio with pre-io barrier.
>>
>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
>> ---
>> Change log from v1:
>>    - Apply the review comments from Chao
>>    - time data from "finish block_ops" to " finish checkpoint" (tested on ARM64 with TOSHIBA 128GB UFS):
>>       Before patch: 0.002273  0.001973  0.002789  0.005159  0.002050
>>       After patch: 0.002502  0.001624  0.002487  0.003049  0.002696
> 
> Looks not very stable.
> 
The raw time is as follows, actually I think the time depends on the CPU 
, CPU schedule and some other conditions...

We drop REQ_PREFLUSH and REQ_FUA in the first bio and the second bio is
only 4k..  It would not have obvious performance difference, I think.

before:
    kworker/u16:3-220   [003] ...1   378.093580: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = start block_ops
    kworker/u16:3-220   [003] ...1   378.095468: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = finish block_ops
    kworker/u16:3-220   [003] ...1   378.097741: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = finish checkpoint (1)
    kworker/u16:1-97    [003] ...1   438.190720: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = start block_ops
    kworker/u16:1-97    [003] ...1   438.192693: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = finish block_ops
    kworker/u16:1-97    [003] ...1   438.195540: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = finish checkpoint (2)
    kworker/u16:4-238   [001] ...1   498.301875: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = start block_ops
    kworker/u16:4-238   [001] ...1   498.304664: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = finish block_ops
    kworker/u16:4-238   [001] ...1   498.308997: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = finish checkpoint (3)
    kworker/u16:4-238   [002] ...1   558.414151: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = start block_ops
    kworker/u16:4-238   [002] ...1   558.417236: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = finish block_ops
    kworker/u16:4-238   [002] ...1   558.422395: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = finish checkpoint (4)
    kworker/u16:4-238   [001] ...1   618.525854: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = start block_ops
    kworker/u16:4-238   [001] ...1   618.527882: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = finish block_ops
    kworker/u16:4-238   [000] ...1   618.529932: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = finish checkpoint (5)
    kworker/u16:4-238   [002] ...1   678.639271: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = start block_ops
    kworker/u16:4-238   [002] ...1   678.644787: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = finish block_ops
    kworker/u16:4-238   [003] ...1   678.651480: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = finish checkpoint (6)
    kworker/u16:1-97    [002] ...1   738.765589: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = start block_ops
    kworker/u16:1-97    [002] ...1   738.767638: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = finish block_ops
    kworker/u16:1-97    [000] ...1   738.770752: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = finish checkpoint (7)
    kworker/u16:4-238   [003] ...1   798.895281: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = start block_ops
    kworker/u16:4-238   [003] ...1   798.897615: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = finish block_ops
    kworker/u16:4-238   [001] ...1   798.902006: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = finish checkpoint (8)
    kworker/u16:1-97    [003] ...1   859.021172: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = start block_ops
    kworker/u16:1-97    [003] ...1   859.022934: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = finish block_ops
    kworker/u16:1-97    [003] ...1   859.024095: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = finish checkpoint (9)
    kworker/u16:3-220   [002] ...1   919.133620: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = start block_ops
    kworker/u16:3-220   [002] ...1   919.135558: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = finish block_ops
    kworker/u16:3-220   [002] ...1   919.137182: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = finish checkpoint (10)

after:
    kworker/u16:3-222   [000] ...1   137.820152: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = start block_ops
    kworker/u16:3-222   [000] ...1   137.822471: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = finish block_ops
    kworker/u16:3-222   [000] ...1   137.824973: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = finish checkpoint (1)
    kworker/u16:1-96    [002] ...1   197.917060: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = start block_ops
    kworker/u16:1-96    [002] ...1   197.919031: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = finish block_ops
    kworker/u16:1-96    [002] ...1   197.920655: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = finish checkpoint (2)
    kworker/u16:1-96    [002] ...1   258.013014: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = start block_ops
    kworker/u16:1-96    [002] ...1   258.014914: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = finish block_ops
    kworker/u16:1-96    [002] ...1   258.017401: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = finish checkpoint (3)
    kworker/u16:0-6     [002] ...1   318.109930: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = start block_ops
    kworker/u16:0-6     [002] ...1   318.111908: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = finish block_ops
    kworker/u16:0-6     [002] ...1   318.114957: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = finish checkpoint (4)
    kworker/u16:1-96    [003] ...1   378.222490: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = start block_ops
    kworker/u16:1-96    [003] ...1   378.224729: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = finish block_ops
    kworker/u16:1-96    [002] ...1   378.227425: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = finish checkpoint (5)
    kworker/u16:1-96    [001] ...1   438.334204: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = start block_ops
    kworker/u16:1-96    [001] ...1   438.337002: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = finish block_ops
    kworker/u16:1-96    [001] ...1   438.341479: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = finish checkpoint (6)
    kworker/u16:1-96    [002] ...1   498.462207: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = start block_ops
    kworker/u16:1-96    [002] ...1   498.465213: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = finish block_ops
    kworker/u16:1-96    [003] ...1   498.469858: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = finish checkpoint (7)
    kworker/u16:0-6     [003] ...1   558.589039: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = start block_ops
    kworker/u16:0-6     [003] ...1   558.591138: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = finish block_ops
    kworker/u16:0-6     [002] ...1   558.594847: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = finish checkpoint (8)
    kworker/u16:3-222   [003] ...1   618.702535: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = start block_ops
    kworker/u16:3-222   [003] ...1   618.708222: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = finish block_ops
    kworker/u16:3-222   [003] ...1   618.724619: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = finish checkpoint (9)
    kworker/u16:3-222   [002] ...1   678.830550: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = start block_ops
    kworker/u16:3-222   [002] ...1   678.832785: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = finish block_ops
    kworker/u16:3-222   [002] ...1   678.835356: f2fs_write_checkpoint: 
dev = (259,44), checkpoint for Sync, state = finish checkpoint (10)
>>   fs/f2fs/checkpoint.c | 41 ++++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 36 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>> index 14d2fed..70deb09 100644
>> --- a/fs/f2fs/checkpoint.c
>> +++ b/fs/f2fs/checkpoint.c
>> @@ -300,6 +300,36 @@ static int f2fs_write_meta_pages(struct address_space *mapping,
>>   	return 0;
>>   }
>>   
>> +static void commit_checkpoint_with_barrier(struct f2fs_sb_info *sbi,
> 
> Minor, {commit,sync}_checkpoint will be OK to me, since we will decide to
> keep barrier in more deep places according to NOBARRIER mount option,
> instead of this function.
OK, I agree.

> 
>> +	void *src, block_t blk_addr)
>> +{
>> +	struct writeback_control wbc = {
>> +		.for_reclaim = 0,
>> +	};
>> +	struct page *page = grab_meta_page(sbi, blk_addr);
>> +	int err;
>> +
>> +	memcpy(page_address(page), src, PAGE_SIZE);
>> +	set_page_dirty(page);
>> +
>> +	f2fs_wait_on_page_writeback(page, META, true);
>> +	BUG_ON(PageWriteback(page));
>> +	if (unlikely(!clear_page_dirty_for_io(page)))
>> +		BUG();
> 
> f2fs_bug_on(sbi, PageWriteback(page));
Will fix.

> f2fs_bug_on(sbi, unlikely(!clear_page_dirty_for_io(page)));
>

I attempt to use
if (unlikely(!clear_page_dirty_for_io(page))
     f2fs_bug_on(1);
since It is better to contain judgement only for assert-like functions 
(In case that clear_page_dirty_for_io could be omited by changing BUG_ON 
definition in the future).

>> +
>> +	/* writeout cp page2 */
> 
> Please keep defined terms as the same in all places:
> 
> s/cp page2/cp pack 2 page
> 
>> +	err = __f2fs_write_meta_page(page, &wbc, FS_CP_META_IO);
>> +	if (err) {
>> +		f2fs_put_page(page, 1);
>> +		f2fs_stop_checkpoint(sbi, false);
>> +		return;
> 
> How about f2fs_bug_on(sbi, err), since we should not fail in
> __f2fs_write_meta_page, right?
OK, will fix in that way.

> 
>> +	}
>> +	f2fs_put_page(page, 0);
>> +
>> +	/* submit checkpoint with barrier */
>> +	f2fs_submit_merged_write(sbi, META_FLUSH);
>> +}
>> +
>>   long sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
>>   				long nr_to_write, enum iostat_type io_type)
>>   {
>> @@ -1297,9 +1327,6 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>   		start_blk += NR_CURSEG_NODE_TYPE;
>>   	}
>>   
>> -	/* writeout checkpoint block */
>> -	update_meta_page(sbi, ckpt, start_blk);
>> -
>>   	/* wait for previous submitted node/meta pages writeback */
>>   	wait_on_all_pages_writeback(sbi);
>>   
>> @@ -1313,12 +1340,16 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>   	sbi->last_valid_block_count = sbi->total_valid_block_count;
>>   	percpu_counter_set(&sbi->alloc_valid_block_count, 0);
>>   
>> -	/* Here, we only have one bio having CP pack */
>> -	sync_meta_pages(sbi, META_FLUSH, LONG_MAX, FS_CP_META_IO);
>> +	/* Here, we have one bio having CP pack except cp page2 */
>> +	sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
>>   
>>   	/* wait for previous submitted meta pages writeback */
>>   	wait_on_all_pages_writeback(sbi);
> 
> /* wait for previous submitted meta pages writeback */
> if (!test_opt(sbi, NOBARRIER)
> 	wait_on_all_pages_writeback(sbi);
> 
OK.

Thanks,

> Thanks,
> 
>>   
>> +	/* barrier and flush checkpoint cp page2 */
>> +	commit_checkpoint_with_barrier(sbi, ckpt, start_blk);
>> +	wait_on_all_pages_writeback(sbi);
>> +
>>   	release_ino_entry(sbi, false);
>>   
>>   	if (unlikely(f2fs_cp_error(sbi)))
>>
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
