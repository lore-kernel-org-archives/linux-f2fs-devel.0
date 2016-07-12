From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH 3/7] f2fs: drop any block plugging
Date: Tue, 12 Jul 2016 09:38:11 +0800
Message-ID: <ead95e1c-9fe4-9895-0653-90868f865137@huawei.com>
References: <20160608172444.60371-1-jaegeuk@kernel.org>
 <20160608172444.60371-3-jaegeuk@kernel.org>
 <25e2dc11-3bbc-632a-720a-0d090f77c7d7@huawei.com>
 <20160709163226.GB1837@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160709163226.GB1837@jaegeuk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, chen.chun.yen@huawei.com, hebiao6@huawei.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2016/7/10 0:32, Jaegeuk Kim wrote:
> On Sat, Jul 09, 2016 at 10:28:49AM +0800, Chao Yu wrote:
>> Hi Jaegeuk,
>>
>> On 2016/6/9 1:24, Jaegeuk Kim wrote:
>>> In f2fs, we don't need to keep block plugging for NODE and DATA writes, since
>>> we already merged bios as much as possible.
>>
>> IMO, we can not remove block plug, this is because there are still many
>> conditions which stops us merging r/w IOs into one bio as we expect,
>> theoretically, block plug can hold bios as much as possible, then submitting
>> them into queue in batch, it will reduce racing of grabbing queue->lock during
>> bio submitting, if we drop them, when syncing nodes or flushing datas, we will
>> suffer more lock racing.
>>
>> Or there are something I am missing, do you suffer any performance issue on
>> block plug?
> 
> In the latest patch, I've turned off plugging forcefully, only if the underlying
> device is SMR drive.

Got it.

> And, still I removed other block plugging, since I couldn't see any performance
> regression.

I suspect that in low-end machine with single-queue which is used in block
layer, we will suffer regression.

> Even in some workloads, I could have seen some inverted IOs due to
> race condition between plugged and unplugged IOs.

For data path, what about enabling block plug for IPU/SSR ?

Thanks,

> 
> Thanks,
> 
>>
>> Thanks,
>>
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>  fs/f2fs/checkpoint.c |  4 ----
>>>  fs/f2fs/data.c       | 17 ++++++++++-------
>>>  fs/f2fs/gc.c         |  5 -----
>>>  fs/f2fs/segment.c    |  7 +------
>>>  4 files changed, 11 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>>> index 5ddd15c..4179c7b 100644
>>> --- a/fs/f2fs/checkpoint.c
>>> +++ b/fs/f2fs/checkpoint.c
>>> @@ -897,11 +897,8 @@ static int block_operations(struct f2fs_sb_info *sbi)
>>>  		.nr_to_write = LONG_MAX,
>>>  		.for_reclaim = 0,
>>>  	};
>>> -	struct blk_plug plug;
>>>  	int err = 0;
>>>  
>>> -	blk_start_plug(&plug);
>>> -
>>>  retry_flush_dents:
>>>  	f2fs_lock_all(sbi);
>>>  	/* write all the dirty dentry pages */
>>> @@ -938,7 +935,6 @@ retry_flush_nodes:
>>>  		goto retry_flush_nodes;
>>>  	}
>>>  out:
>>> -	blk_finish_plug(&plug);
>>>  	return err;
>>>  }
>>>  
>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>> index 30dc448..5f655d0 100644
>>> --- a/fs/f2fs/data.c
>>> +++ b/fs/f2fs/data.c
>>> @@ -98,10 +98,13 @@ static struct bio *__bio_alloc(struct f2fs_sb_info *sbi, block_t blk_addr,
>>>  }
>>>  
>>>  static inline void __submit_bio(struct f2fs_sb_info *sbi, int rw,
>>> -						struct bio *bio)
>>> +			struct bio *bio, enum page_type type)
>>>  {
>>> -	if (!is_read_io(rw))
>>> +	if (!is_read_io(rw)) {
>>>  		atomic_inc(&sbi->nr_wb_bios);
>>> +		if (current->plug && (type == DATA || type == NODE))
>>> +			blk_finish_plug(current->plug);
>>> +	}
>>>  	submit_bio(rw, bio);
>>>  }
>>>  
>>> @@ -117,7 +120,7 @@ static void __submit_merged_bio(struct f2fs_bio_info *io)
>>>  	else
>>>  		trace_f2fs_submit_write_bio(io->sbi->sb, fio, io->bio);
>>>  
>>> -	__submit_bio(io->sbi, fio->rw, io->bio);
>>> +	__submit_bio(io->sbi, fio->rw, io->bio, fio->type);
>>>  	io->bio = NULL;
>>>  }
>>>  
>>> @@ -235,7 +238,7 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
>>>  		return -EFAULT;
>>>  	}
>>>  
>>> -	__submit_bio(fio->sbi, fio->rw, bio);
>>> +	__submit_bio(fio->sbi, fio->rw, bio, fio->type);
>>>  	return 0;
>>>  }
>>>  
>>> @@ -1040,7 +1043,7 @@ got_it:
>>>  		 */
>>>  		if (bio && (last_block_in_bio != block_nr - 1)) {
>>>  submit_and_realloc:
>>> -			__submit_bio(F2FS_I_SB(inode), READ, bio);
>>> +			__submit_bio(F2FS_I_SB(inode), READ, bio, DATA);
>>>  			bio = NULL;
>>>  		}
>>>  		if (bio == NULL) {
>>> @@ -1083,7 +1086,7 @@ set_error_page:
>>>  		goto next_page;
>>>  confused:
>>>  		if (bio) {
>>> -			__submit_bio(F2FS_I_SB(inode), READ, bio);
>>> +			__submit_bio(F2FS_I_SB(inode), READ, bio, DATA);
>>>  			bio = NULL;
>>>  		}
>>>  		unlock_page(page);
>>> @@ -1093,7 +1096,7 @@ next_page:
>>>  	}
>>>  	BUG_ON(pages && !list_empty(pages));
>>>  	if (bio)
>>> -		__submit_bio(F2FS_I_SB(inode), READ, bio);
>>> +		__submit_bio(F2FS_I_SB(inode), READ, bio, DATA);
>>>  	return 0;
>>>  }
>>>  
>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>> index 4a03076..67fd285 100644
>>> --- a/fs/f2fs/gc.c
>>> +++ b/fs/f2fs/gc.c
>>> @@ -777,7 +777,6 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>>>  {
>>>  	struct page *sum_page;
>>>  	struct f2fs_summary_block *sum;
>>> -	struct blk_plug plug;
>>>  	unsigned int segno = start_segno;
>>>  	unsigned int end_segno = start_segno + sbi->segs_per_sec;
>>>  	int seg_freed = 0;
>>> @@ -795,8 +794,6 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>>>  		unlock_page(sum_page);
>>>  	}
>>>  
>>> -	blk_start_plug(&plug);
>>> -
>>>  	for (segno = start_segno; segno < end_segno; segno++) {
>>>  		/* find segment summary of victim */
>>>  		sum_page = find_get_page(META_MAPPING(sbi),
>>> @@ -830,8 +827,6 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>>>  		f2fs_submit_merged_bio(sbi,
>>>  				(type == SUM_TYPE_NODE) ? NODE : DATA, WRITE);
>>>  
>>> -	blk_finish_plug(&plug);
>>> -
>>>  	if (gc_type == FG_GC) {
>>>  		while (start_segno < end_segno)
>>>  			if (get_valid_blocks(sbi, start_segno++, 1) == 0)
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index 7b58bfb..eff046a 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -379,13 +379,8 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
>>>  			excess_prefree_segs(sbi) ||
>>>  			excess_dirty_nats(sbi) ||
>>>  			(is_idle(sbi) && f2fs_time_over(sbi, CP_TIME))) {
>>> -		if (test_opt(sbi, DATA_FLUSH)) {
>>> -			struct blk_plug plug;
>>> -
>>> -			blk_start_plug(&plug);
>>> +		if (test_opt(sbi, DATA_FLUSH))
>>>  			sync_dirty_inodes(sbi, FILE_INODE);
>>> -			blk_finish_plug(&plug);
>>> -		}
>>>  		f2fs_sync_fs(sbi->sb, true);
>>>  		stat_inc_bg_cp_count(sbi->stat_info);
>>>  	}
>>>
> 
> .
> 
