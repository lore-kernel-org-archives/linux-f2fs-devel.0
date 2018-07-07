From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: split discard command in prior to
 block layer
Date: Sat, 7 Jul 2018 09:39:47 +0800
Message-ID: <d9c47755-3d03-3f18-257e-876a672f2932@kernel.org>
References: <20180704153746.2510-1-chao@kernel.org>
 <20180706224533.GC77984@jaegeuk-macbookpro.roam.corp.google.com>
 <fd8f7ecb-a1e7-7e10-f6c6-2b908cf9841b@kernel.org>
 <20180707010834.GA3767@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1fbcCd-0006a7-KQ
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 07 Jul 2018 01:39:59 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fbcCc-00BnKo-5s
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 07 Jul 2018 01:39:59 +0000
In-Reply-To: <20180707010834.GA3767@jaegeuk-macbookpro.roam.corp.google.com>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2018/7/7 9:08, Jaegeuk Kim wrote:
> On 07/07, Chao Yu wrote:
>> Hi Jaegeuk,
>>
>> On 2018/7/7 6:45, Jaegeuk Kim wrote:
>>> On 07/04, Chao Yu wrote:
>>>> From: Chao Yu <yuchao0@huawei.com>
>>>>
>>>> Some devices has small max_{hw,}discard_sectors, so that in
>>>> __blkdev_issue_discard(), one big size discard bio can be split
>>>> into multiple small size discard bios, result in heavy load in IO
>>>> scheduler and device, which can hang other sync IO for long time.
>>>>
>>>> Now, f2fs is trying to control discard commands more elaboratively,
>>>> in order to make less conflict in between discard IO and user IO
>>>> to enhance application's performance, so in this patch, we will
>>>> split discard bio in f2fs in prior to in block layer to reduce
>>>> issuing multiple discard bios in a short time.
>>>
>>> Hi Chao,
>>>
>>> In terms of # of candidates, can we control this when actually issuing
>>> the discard commands?
>>
>> IIUC, you mean once we pick one discard entry in rbtree, if
>> max_{hw,}discard_sectors is smaller than size of this discard, then we can split
>> it into smaller ones by discard_sectors, and just issue one or partials of them?
> 
> Yes, sort of.

Let me try to refactor the patch.

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>> Thanks,
>>>
>>>>
>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>> ---
>>>>  fs/f2fs/f2fs.h    | 13 ++++++-------
>>>>  fs/f2fs/segment.c | 25 ++++++++++++++++++++++---
>>>>  2 files changed, 28 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>> index a9da5a089cb4..a09d2b2d9520 100644
>>>> --- a/fs/f2fs/f2fs.h
>>>> +++ b/fs/f2fs/f2fs.h
>>>> @@ -178,7 +178,6 @@ enum {
>>>>  
>>>>  #define MAX_DISCARD_BLOCKS(sbi)		BLKS_PER_SEC(sbi)
>>>>  #define DEF_MAX_DISCARD_REQUEST		8	/* issue 8 discards per round */
>>>> -#define DEF_MAX_DISCARD_LEN		512	/* Max. 2MB per discard */
>>>>  #define DEF_MIN_DISCARD_ISSUE_TIME	50	/* 50 ms, if exists */
>>>>  #define DEF_MID_DISCARD_ISSUE_TIME	500	/* 500 ms, if device busy */
>>>>  #define DEF_MAX_DISCARD_ISSUE_TIME	60000	/* 60 s, if no candidates */
>>>> @@ -701,22 +700,22 @@ static inline void set_extent_info(struct extent_info *ei, unsigned int fofs,
>>>>  }
>>>>  
>>>>  static inline bool __is_discard_mergeable(struct discard_info *back,
>>>> -						struct discard_info *front)
>>>> +			struct discard_info *front, unsigned int max_len)
>>>>  {
>>>>  	return (back->lstart + back->len == front->lstart) &&
>>>> -		(back->len + front->len < DEF_MAX_DISCARD_LEN);
>>>> +		(back->len + front->len <= max_len);
>>>>  }
>>>>  
>>>>  static inline bool __is_discard_back_mergeable(struct discard_info *cur,
>>>> -						struct discard_info *back)
>>>> +			struct discard_info *back, unsigned int max_len)
>>>>  {
>>>> -	return __is_discard_mergeable(back, cur);
>>>> +	return __is_discard_mergeable(back, cur, max_len);
>>>>  }
>>>>  
>>>>  static inline bool __is_discard_front_mergeable(struct discard_info *cur,
>>>> -						struct discard_info *front)
>>>> +			struct discard_info *front, unsigned int max_len)
>>>>  {
>>>> -	return __is_discard_mergeable(cur, front);
>>>> +	return __is_discard_mergeable(cur, front, max_len);
>>>>  }
>>>>  
>>>>  static inline bool __is_extent_mergeable(struct extent_info *back,
>>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>>> index 4648561e2bfd..8e417a12684d 100644
>>>> --- a/fs/f2fs/segment.c
>>>> +++ b/fs/f2fs/segment.c
>>>> @@ -1086,6 +1086,9 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
>>>>  	struct discard_cmd *dc;
>>>>  	struct discard_info di = {0};
>>>>  	struct rb_node **insert_p = NULL, *insert_parent = NULL;
>>>> +	struct request_queue *q = bdev_get_queue(bdev);
>>>> +	unsigned int max_discard_blocks =
>>>> +			SECTOR_TO_BLOCK(q->limits.max_discard_sectors);
>>>>  	block_t end = lstart + len;
>>>>  
>>>>  	mutex_lock(&dcc->cmd_lock);
>>>> @@ -1129,7 +1132,8 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
>>>>  
>>>>  		if (prev_dc && prev_dc->state == D_PREP &&
>>>>  			prev_dc->bdev == bdev &&
>>>> -			__is_discard_back_mergeable(&di, &prev_dc->di)) {
>>>> +			__is_discard_back_mergeable(&di, &prev_dc->di,
>>>> +							max_discard_blocks)) {
>>>>  			prev_dc->di.len += di.len;
>>>>  			dcc->undiscard_blks += di.len;
>>>>  			__relocate_discard_cmd(dcc, prev_dc);
>>>> @@ -1140,7 +1144,8 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
>>>>  
>>>>  		if (next_dc && next_dc->state == D_PREP &&
>>>>  			next_dc->bdev == bdev &&
>>>> -			__is_discard_front_mergeable(&di, &next_dc->di)) {
>>>> +			__is_discard_front_mergeable(&di, &next_dc->di,
>>>> +							max_discard_blocks)) {
>>>>  			next_dc->di.lstart = di.lstart;
>>>>  			next_dc->di.len += di.len;
>>>>  			next_dc->di.start = di.start;
>>>> @@ -1170,7 +1175,11 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
>>>>  static int __queue_discard_cmd(struct f2fs_sb_info *sbi,
>>>>  		struct block_device *bdev, block_t blkstart, block_t blklen)
>>>>  {
>>>> +	struct request_queue *q = bdev_get_queue(bdev);
>>>> +	unsigned int max_discard_blocks =
>>>> +			SECTOR_TO_BLOCK(q->limits.max_discard_sectors);
>>>>  	block_t lblkstart = blkstart;
>>>> +	block_t total_len = blklen;
>>>>  
>>>>  	trace_f2fs_queue_discard(bdev, blkstart, blklen);
>>>>  
>>>> @@ -1179,7 +1188,17 @@ static int __queue_discard_cmd(struct f2fs_sb_info *sbi,
>>>>  
>>>>  		blkstart -= FDEV(devi).start_blk;
>>>>  	}
>>>> -	__update_discard_tree_range(sbi, bdev, lblkstart, blkstart, blklen);
>>>> +
>>>> +	while (total_len) {
>>>> +		if (blklen > max_discard_blocks)
>>>> +			blklen = max_discard_blocks;
>>>> +		__update_discard_tree_range(sbi, bdev, lblkstart,
>>>> +						blkstart, blklen);
>>>> +		lblkstart += blklen;
>>>> +		blkstart += blklen;
>>>> +		total_len -= blklen;
>>>> +		blklen = total_len;
>>>> +	}
>>>>  	return 0;
>>>>  }
>>>>  
>>>> -- 
>>>> 2.16.2.17.g38e79b1fd

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
