From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 10/10] f2fs: return fs_trim if there is no
 candidate
Date: Thu, 23 Feb 2017 10:12:12 +0800
Message-ID: <57af549a-0e71-3181-ee0b-0f7c0a0bf87d@huawei.com>
References: <20161230185117.3832-1-jaegeuk@kernel.org>
	<20161230185117.3832-10-jaegeuk@kernel.org>
	<3ac2d369-bf84-13a6-713d-e5e6e1206993@huawei.com>
	<20170222212639.GB4003@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cgitV-0002jE-8P
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Feb 2017 02:12:33 +0000
Received: from [45.249.212.187] (helo=dggrg01-dlp.huawei.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cgitT-0006Ck-F7
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Feb 2017 02:12:33 +0000
In-Reply-To: <20170222212639.GB4003@jaegeuk.local>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

On 2017/2/23 5:26, Jaegeuk Kim wrote:
> Hi Chao,
> 
> On 02/22, Chao Yu wrote:
>> On 2016/12/31 2:51, Jaegeuk Kim wrote:
>>> If there is no candidate to submit discard command during f2sf_trim_fs, let's
>>> return without checkpoint.
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>
>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>>
>> Please see comments below.
>>
>>> ---
>>>  fs/f2fs/checkpoint.c |  5 +++++
>>>  fs/f2fs/f2fs.h       |  1 +
>>>  fs/f2fs/segment.c    | 28 +++++++++++++++++++++++-----
>>>  3 files changed, 29 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>>> index 917b5c5053ae..ccea40763d9d 100644
>>> --- a/fs/f2fs/checkpoint.c
>>> +++ b/fs/f2fs/checkpoint.c
>>> @@ -1249,6 +1249,11 @@ int write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>>  
>>>  	/* this is the case of multiple fstrims without any changes */
>>>  	if (cpc->reason == CP_DISCARD) {
>>> +		if (!exist_trim_candidates(sbi, cpc)) {
>>> +			unblock_operations(sbi);
>>> +			goto out;
>>> +		}
>>> +
>>>  		if (NM_I(sbi)->dirty_nat_cnt == 0 &&
>>>  				SIT_I(sbi)->dirty_sentries == 0 &&
>>>  				prefree_segments(sbi) == 0) {
>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>> index f2f40fce9d31..04d113f0d6bf 100644
>>> --- a/fs/f2fs/f2fs.h
>>> +++ b/fs/f2fs/f2fs.h
>>> @@ -2119,6 +2119,7 @@ void release_discard_addrs(struct f2fs_sb_info *);
>>>  int npages_for_summary_flush(struct f2fs_sb_info *, bool);
>>>  void allocate_new_segments(struct f2fs_sb_info *);
>>>  int f2fs_trim_fs(struct f2fs_sb_info *, struct fstrim_range *);
>>> +bool exist_trim_candidates(struct f2fs_sb_info *, struct cp_control *);
>>>  struct page *get_sum_page(struct f2fs_sb_info *, unsigned int);
>>>  void update_meta_page(struct f2fs_sb_info *, void *, block_t);
>>>  void write_meta_page(struct f2fs_sb_info *, struct page *);
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index 9a38424c3c1f..82078734f379 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -836,7 +836,8 @@ static void __add_discard_entry(struct f2fs_sb_info *sbi,
>>>  	SM_I(sbi)->nr_discards += end - start;
>>>  }
>>>  
>>> -static void add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>> +static bool add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc,
>>> +							bool check_only)
>>>  {
>>>  	int entries = SIT_VBLOCK_MAP_SIZE / sizeof(unsigned long);
>>>  	int max_blocks = sbi->blocks_per_seg;
>>> @@ -850,12 +851,12 @@ static void add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>>  	int i;
>>>  
>>>  	if (se->valid_blocks == max_blocks || !f2fs_discard_en(sbi))
>>> -		return;
>>> +		return false;
>>>  
>>>  	if (!force) {
>>>  		if (!test_opt(sbi, DISCARD) || !se->valid_blocks ||
>>>  		    SM_I(sbi)->nr_discards >= SM_I(sbi)->max_discards)
>>> -			return;
>>> +			return false;
>>>  	}
>>>  
>>>  	/* SIT_VBLOCK_MAP_SIZE should be multiple of sizeof(unsigned long) */
>>> @@ -873,8 +874,12 @@ static void add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>>  					&& (end - start) < cpc->trim_minlen)
>>>  			continue;
>>>  
>>> +		if (check_only)
>>> +			return true;
>>> +
>>>  		__add_discard_entry(sbi, cpc, se, start, end);
>>>  	}
>>> +	return false;
>>>  }
>>>  
>>>  void release_discard_addrs(struct f2fs_sb_info *sbi)
>>> @@ -1455,6 +1460,19 @@ static const struct segment_allocation default_salloc_ops = {
>>>  	.allocate_segment = allocate_segment_by_default,
>>>  };
>>>  
>>> +bool exist_trim_candidates(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>> +{
>>> +	__u64 trim_start = cpc->trim_start;
>>
>> bool has_candidate = false;
>>
>>> +
>>> +	mutex_lock(&SIT_I(sbi)->sentry_lock);
>>> +	for (; trim_start <= cpc->trim_end; trim_start++)
>>> +		if (add_discard_addrs(sbi, cpc, true))
>>> +			break;
>>
>> for (; cpc->trim_start <= cpc->trim_end; cpc->trim_start++)
>> 	if (add_discard_addrs(sbi, cpc, true)) {
>> 		has_candidate = true;
>> 		break;
>> 	}
> 
> Why do we need to do like this in which needs additional variable with multiple
> assignment?

Because add_discard_addrs will check segment which cpc->trim_start points to,
but if we do not increase cpc->trim_start in loop, we will always check one
segment, right?

Thanks,

> 
> Thanks,
> 
>>
>> cpc->trim_start = trim_start;
>>
>>> +	mutex_unlock(&SIT_I(sbi)->sentry_lock);
>>> +
>>> +	return trim_start <= cpc->trim_end;
>>
>> return has_candidate;
>>
>> Thanks,
>>
>>> +}
>>> +
>>>  int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
>>>  {
>>>  	__u64 start = F2FS_BYTES_TO_BLK(range->start);
>>> @@ -2251,7 +2269,7 @@ void flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>>  			/* add discard candidates */
>>>  			if (cpc->reason != CP_DISCARD) {
>>>  				cpc->trim_start = segno;
>>> -				add_discard_addrs(sbi, cpc);
>>> +				add_discard_addrs(sbi, cpc, false);
>>>  			}
>>>  
>>>  			if (to_journal) {
>>> @@ -2289,7 +2307,7 @@ void flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>>  		__u64 trim_start = cpc->trim_start;
>>>  
>>>  		for (; cpc->trim_start <= cpc->trim_end; cpc->trim_start++)
>>> -			add_discard_addrs(sbi, cpc);
>>> +			add_discard_addrs(sbi, cpc, false);
>>>  
>>>  		cpc->trim_start = trim_start;
>>>  	}
>>>
>>
>>
>> ------------------------------------------------------------------------------
>> Check out the vibrant tech community on one of the world's most
>> engaging tech sites, SlashDot.org! http://sdm.link/slashdot
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
