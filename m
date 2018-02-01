From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH RFC v4] f2fs: flush cp pack except cp pack 2
 page at first
Date: Thu, 1 Feb 2018 21:56:38 +0800
Message-ID: <349d782c-15e7-2460-fc4e-54d4d76f29da@kernel.org>
References: <9047C53C18267742AB12E43B65C7F9F70BCE500E@dggemi505-mbx.china.huawei.com>
 <ca8fbc75-0163-1879-5071-ebed910fe43f@huawei.com>
 <20180131222835.GE12901@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <chao@kernel.org>) id 1ehFMQ-0007oO-SH
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 01 Feb 2018 13:57:06 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ehFMP-0007Hr-LW
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 01 Feb 2018 13:57:06 +0000
In-Reply-To: <20180131222835.GE12901@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>, heyunlei <heyunlei@huawei.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, hutj <hutj@huawei.com>, "Duwei (Device OS)" <weidu.du@huawei.com>

On 2018/2/1 6:28, Jaegeuk Kim wrote:
> On 01/31, Chao Yu wrote:
>> On 2018/1/31 14:39, Gaoxiang (OS) wrote:
>>> Previously, we attempt to flush the whole cp pack in a single bio,
>>> however, when suddenly powering off at this time, we could get into
>>> an extreme scenario that cp pack 1 page and cp pack 2 page are updated
>>> and latest, but payload or current summaries are still partially
>>> outdated. (see reliable write in the UFS specification)
>>>
>>> This patch submits the whole cp pack except cp pack 2 page at first,
>>> and then writes the cp pack 2 page with an extra independent
>>> bio with pre-io barrier.
>>>
>>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
>>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>>> ---
>>> Change log from v3:
>>>   - further review comments are applied from Jaegeuk and Chao
>>>   - Tested on this patch (without multiple-device): mount, boot Android with f2fs userdata and make fragment
>>>   - If any problem with this patch or I miss something, please kindly share your comments, thanks :)
>>> Change log from v2:
>>>   - Apply the review comments from Chao
>>> Change log from v1:
>>>   - Apply the review comments from Chao
>>>   - time data from "finish block_ops" to " finish checkpoint" (tested on ARM64 with TOSHIBA 128GB UFS):
>>>      Before patch: 0.002273  0.001973  0.002789  0.005159  0.002050
>>>      After patch: 0.002502  0.001624  0.002487  0.003049  0.002696
>>>  fs/f2fs/checkpoint.c | 67 ++++++++++++++++++++++++++++++++++++----------------
>>>  1 file changed, 46 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>>> index 14d2fed..916dc72 100644
>>> --- a/fs/f2fs/checkpoint.c
>>> +++ b/fs/f2fs/checkpoint.c
>>> @@ -1158,6 +1158,39 @@ static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>>  	spin_unlock_irqrestore(&sbi->cp_lock, flags);
>>>  }
>>>  
>>> +static void commit_checkpoint(struct f2fs_sb_info *sbi,
>>> +	void *src, block_t blk_addr)
>>> +{
>>> +	struct writeback_control wbc = {
>>> +		.for_reclaim = 0,
>>> +	};
>>> +
>>> +	/*
>>> +	 * pagevec_lookup_tag and lock_page again will take
>>> +	 * some extra time. Therefore, update_meta_pages and
>>> +	 * sync_meta_pages are combined in this function.
>>> +	 */
>>> +	struct page *page = grab_meta_page(sbi, blk_addr);
>>> +	int err;
>>> +
>>> +	memcpy(page_address(page), src, PAGE_SIZE);
>>> +	set_page_dirty(page);
>>> +
>>> +	f2fs_wait_on_page_writeback(page, META, true);
>>> +	f2fs_bug_on(sbi, PageWriteback(page));
>>> +	if (unlikely(!clear_page_dirty_for_io(page)))
>>> +		f2fs_bug_on(sbi, 1);
>>> +
>>> +	/* writeout cp pack 2 page */
>>> +	err = __f2fs_write_meta_page(page, &wbc, FS_CP_META_IO);
>>> +	f2fs_bug_on(sbi, err);
>>> +
>>> +	f2fs_put_page(page, 0);
>>> +
>>> +	/* submit checkpoint (with barrier if NOBARRIER is not set) */
>>> +	f2fs_submit_merged_write(sbi, META_FLUSH);
>>> +}
>>> +
>>>  static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>>  {
>>>  	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
>>> @@ -1260,16 +1293,6 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>>  		}
>>>  	}
>>>  
>>> -	/* need to wait for end_io results */
>>> -	wait_on_all_pages_writeback(sbi);
>>> -	if (unlikely(f2fs_cp_error(sbi)))
>>> -		return -EIO;
>>> -
>>> -	/* flush all device cache */
>>> -	err = f2fs_flush_device_cache(sbi);
>>> -	if (err)
>>> -		return err;
>>> -
>>>  	/* write out checkpoint buffer at block 0 */
>>>  	update_meta_page(sbi, ckpt, start_blk++);
>>>  
>>> @@ -1297,15 +1320,6 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>>  		start_blk += NR_CURSEG_NODE_TYPE;
>>>  	}
>>>  
>>> -	/* writeout checkpoint block */
>>> -	update_meta_page(sbi, ckpt, start_blk);
>>> -
>>> -	/* wait for previous submitted node/meta pages writeback */
>>> -	wait_on_all_pages_writeback(sbi);
>>> -
>>> -	if (unlikely(f2fs_cp_error(sbi)))
>>> -		return -EIO;
>>> -
>>>  	filemap_fdatawait_range(NODE_MAPPING(sbi), 0, LLONG_MAX);
>>>  	filemap_fdatawait_range(META_MAPPING(sbi), 0, LLONG_MAX);
> 
>  - remove

Agreed.

> 
>>>  
>>> @@ -1313,12 +1327,23 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>>  	sbi->last_valid_block_count = sbi->total_valid_block_count;
>>>  	percpu_counter_set(&sbi->alloc_valid_block_count, 0);
>>>  
>>> -	/* Here, we only have one bio having CP pack */
>>> -	sync_meta_pages(sbi, META_FLUSH, LONG_MAX, FS_CP_META_IO);
>>> +	/* Here, we have one bio having CP pack except cp pack 2 page */
>>> +	sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
>>> +
>>> +	/* flush all device cache */
>>> +	err = f2fs_flush_device_cache(sbi);
>>> +	if (err)
>>> +		return err;
>>>  
>>>  	/* wait for previous submitted meta pages writeback */
>>>  	wait_on_all_pages_writeback(sbi);
>>
>> Move f2fs_flush_device_cache here? since meta area can cross the multiple
>> devices, we should make sure all metadata were in device cache at least, and
>> then trigger the flush.
> 
> Agreed, and need to flush, only if we have multiple devices.

f2fs_flush_device_cache is designed as only flushing devices except the first
one when f2fs enables multiple device. Calling it directly will be OK. :)

> 
>>
>>>  
>>> +	if (unlikely(f2fs_cp_error(sbi)))
>>> +		return -EIO;
>>> +
>>> +	/* barrier and flush checkpoint cp pack 2 page if it can */
>>> +	commit_checkpoint(sbi, ckpt, start_blk);
>>
>> Jaegeuk, are we really allow to make critical do_checkpoint which is on path of
>> fsync()/sync() be asynchronous?
> 
> Yeah, so we need to wait end_io on synchronous paths like f2fs_sync_fs(1).

I think we should consider the case Xiang mentioned:

1. write async checkpoint #1 from gc;
2. write sync checkpoint #2 from sync_fs, end_io finished w/ error; -> cp #2 becomes corrupted
3. checkpoint #1's end_io finished w/ error; -> cp #1 becomes corrupted

Then, entire filesystem becomes corrupted now.

Thanks,

> 
>>
>> Thanks,
>>
>>> +
>>>  	release_ino_entry(sbi, false);
>>>  
>>>  	if (unlikely(f2fs_cp_error(sbi)))
>>>

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
