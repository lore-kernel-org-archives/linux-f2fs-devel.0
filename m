From: Gao Xiang <hsiangkao@aol.com>
Subject: Re: [f2fs-dev] [PATCH RFC v2] mkfs.f2fs: binary decision to calculate
 SIT/NAT/SSA
Date: Thu, 11 Jan 2018 00:00:54 +0800
Message-ID: <f6886070-f56e-bac0-05b5-88a2bcd9614e@aol.com>
References: <9047C53C18267742AB12E43B65C7F9F70BCC6DD6@dggemi505-mbs.china.huawei.com>
 <9011adb7-0c76-5172-0e03-d4b3b368b43c@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <9011adb7-0c76-5172-0e03-d4b3b368b43c@kernel.org>
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>, "Gaoxiang (OS)" <gaoxiang25@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>, "Yuchao (T)" <yuchao0@huawei.com>
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, heyunlei <heyunlei@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,


On 2018/1/10 23:08, Chao Yu wrote:
> On 2018/1/10 12:01, Gaoxiang (OS) wrote:
>> Use binary decision approach to calculate SIT/NAT/SSA segments
>> it has some benefits when the partition size >= 512G.
>>
>>                          (bsearch)
>> psize   main_segments   main_seaments
>> ...
>> 512G    261509          261510
>>   1 T    523141          523143
>>   2 T    1046405         1046409
>>   4 T    2092783         2092791
>> ...
>>
>> It also clarify that SIT/NAT/SSA are used for main segment area only.
>>
>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
>> ---
>> Change log from v1:
>>     - use align_down instead of align_up in get_best_main_zones
>>
>>   mkfs/f2fs_format.c | 112 ++++++++++++++++++++++++++++++++++++++---------------
>>   1 file changed, 80 insertions(+), 32 deletions(-)
>>
>> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
>> index a130001..9ca2257 100644
>> --- a/mkfs/f2fs_format.c
>> +++ b/mkfs/f2fs_format.c
>> @@ -145,20 +145,80 @@ static void verify_cur_segs(void)
>>   		c.cur_seg[i] = next_zone(i - 1);
>>   }
>>   
>> +static u_int32_t get_best_main_zones(void)
>> +{
>> +	u_int32_t total_zones = get_sb(segment_count) / (c.segs_per_zone);
>> +	u_int32_t left = 1, right = total_zones - 1;
>> +	u_int32_t candicate = 0;
>> +
>> +	while (left <= right) {
>> +		u_int32_t blocks_for_nat;
>> +		u_int32_t sit_segments, nat_segments, ssa_segments;
>> +		u_int32_t meta_segments, meta_zones;
>> +		u_int32_t max_sit_bitmap_size, max_nat_bitmap_size;
>> +
>> +		u_int32_t main_zones = (left + right) / 2;
> If we start to search zone size from total_zones/2, it can be a little bit
> slow, how about starting from the size that calculated by original method,
> and then expanding main zone until founding the target?
>
> Thanks,
OK, I will tighten the boundary as much as possible tomorrow.

Thanks,
>
>> +		u_int32_t main_segments = c.segs_per_zone * main_zones;
>> +
>> +		sit_segments = SEG_ALIGN(SIZE_ALIGN(main_segments,
>> +			SIT_ENTRY_PER_BLOCK) /* blocks_for_sit */);
>> +
>> +		blocks_for_nat = SIZE_ALIGN(main_segments * c.blks_per_seg,
>> +				NAT_ENTRY_PER_BLOCK);
>> +
>> +		max_sit_bitmap_size = min((u_int32_t)MAX_SIT_BITMAP_SIZE,
>> +			sit_segments * c.blks_per_seg / 8);
>> +
>> +		/*
>> +		 * it's weird because for 1TB storage, payload is still not
>> +		 * used and max_nat_bitmap_blks is only 21472, which means
>> +		 * the total number of nodes is 21472 * 409 = 8782048
>> +		 */
>> +		if (max_sit_bitmap_size > MAX_SIT_BITMAP_SIZE_IN_CKPT)
>> +			max_nat_bitmap_size = CHECKSUM_OFFSET -
>> +					sizeof(struct f2fs_checkpoint) + 1;
>> +		else
>> +			max_nat_bitmap_size =
>> +				CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1
>> +				- max_sit_bitmap_size;
>> +
>> +		nat_segments = min(SEG_ALIGN(blocks_for_nat),
>> +			(max_nat_bitmap_size * 8) / c.blks_per_seg);
>> +
>> +		/* each main segment has a ssa block */
>> +		ssa_segments = SEG_ALIGN(main_segments);
>> +
>> +		meta_segments = (get_sb(segment_count_ckpt) +
>> +			sit_segments * 2 + nat_segments * 2 +
>> +			ssa_segments);
>> +
>> +		meta_zones = ZONE_ALIGN(meta_segments * c.blks_per_seg);
>> +
>> +		if (meta_zones + main_zones == total_zones)
>> +			return main_zones;
>> +
>> +		if (meta_zones + main_zones < total_zones) {
>> +			left = main_zones + 1;
>> +			candicate = main_zones;
>> +		} else
>> +			right = main_zones - 1;
>> +	}
>> +
>> +	return candicate;
>> +}
>> +
>>   static int f2fs_prepare_super_block(void)
>>   {
>>   	u_int32_t blk_size_bytes;
>>   	u_int32_t log_sectorsize, log_sectors_per_block;
>>   	u_int32_t log_blocksize, log_blks_per_seg;
>>   	u_int32_t segment_size_bytes, zone_size_bytes;
>> -	u_int32_t sit_segments;
>> -	u_int32_t blocks_for_sit, blocks_for_nat, blocks_for_ssa;
>> -	u_int32_t total_valid_blks_available;
>> +	u_int32_t blocks_for_sit, blocks_for_nat;
>>   	u_int64_t zone_align_start_offset, diff;
>>   	u_int64_t total_meta_zones, total_meta_segments;
>>   	u_int32_t sit_bitmap_size, max_sit_bitmap_size;
>>   	u_int32_t max_nat_bitmap_size, max_nat_segments;
>> -	u_int32_t total_zones;
>> +	u_int32_t main_zones, main_segments;
>>   	u_int32_t next_ino;
>>   	enum quota_type qtype;
>>   	int i;
>> @@ -256,22 +316,18 @@ static int f2fs_prepare_super_block(void)
>>   	set_sb(sit_blkaddr, get_sb(segment0_blkaddr) +
>>   			get_sb(segment_count_ckpt) * c.blks_per_seg);
>>   
>> -	blocks_for_sit = SIZE_ALIGN(get_sb(segment_count), SIT_ENTRY_PER_BLOCK);
>> +	/* try to do binary decision to get main_zones */
>> +	main_zones = get_best_main_zones();
>> +	main_segments = c.segs_per_zone * main_zones;
>>   
>> -	sit_segments = SEG_ALIGN(blocks_for_sit);
>> -
>> -	set_sb(segment_count_sit, sit_segments * 2);
>> +	blocks_for_sit = SIZE_ALIGN(main_segments, SIT_ENTRY_PER_BLOCK);
>> +	set_sb(segment_count_sit, SEG_ALIGN(blocks_for_sit) * 2);
>>   
>>   	set_sb(nat_blkaddr, get_sb(sit_blkaddr) + get_sb(segment_count_sit) *
>>   			c.blks_per_seg);
>>   
>> -	total_valid_blks_available = (get_sb(segment_count) -
>> -			(get_sb(segment_count_ckpt) +
>> -			get_sb(segment_count_sit))) * c.blks_per_seg;
>> -
>> -	blocks_for_nat = SIZE_ALIGN(total_valid_blks_available,
>> +	blocks_for_nat = SIZE_ALIGN(main_segments * c.blks_per_seg,
>>   			NAT_ENTRY_PER_BLOCK);
>> -
>>   	set_sb(segment_count_nat, SEG_ALIGN(blocks_for_nat));
>>   	/*
>>   	 * The number of node segments should not be exceeded a "Threshold".
>> @@ -312,16 +368,8 @@ static int f2fs_prepare_super_block(void)
>>   	set_sb(ssa_blkaddr, get_sb(nat_blkaddr) + get_sb(segment_count_nat) *
>>   			c.blks_per_seg);
>>   
>> -	total_valid_blks_available = (get_sb(segment_count) -
>> -			(get_sb(segment_count_ckpt) +
>> -			get_sb(segment_count_sit) +
>> -			get_sb(segment_count_nat))) *
>> -			c.blks_per_seg;
>>   
>> -	blocks_for_ssa = total_valid_blks_available /
>> -				c.blks_per_seg + 1;
>> -
>> -	set_sb(segment_count_ssa, SEG_ALIGN(blocks_for_ssa));
>> +	set_sb(segment_count_ssa, SEG_ALIGN(main_segments));
>>   
>>   	total_meta_segments = get_sb(segment_count_ckpt) +
>>   		get_sb(segment_count_sit) +
>> @@ -354,10 +402,7 @@ static int f2fs_prepare_super_block(void)
>>   		}
>>   	}
>>   
>> -	total_zones = get_sb(segment_count) / (c.segs_per_zone) -
>> -							total_meta_zones;
>> -
>> -	set_sb(section_count, total_zones * c.secs_per_zone);
>> +	set_sb(section_count, main_zones * c.secs_per_zone);
>>   
>>   	set_sb(segment_count_main, get_sb(section_count) * c.segs_per_sec);
>>   
>> @@ -373,6 +418,9 @@ static int f2fs_prepare_super_block(void)
>>   		return -1;
>>   	}
>>   
>> +	ASSERT((total_meta_zones + main_zones) * c.segs_per_zone
>> +		== get_sb(segment_count));
>> +
>>   	c.reserved_segments =
>>   			(2 * (100 / c.overprovision + 1) + 6)
>>   			* c.segs_per_sec;
>> @@ -404,15 +452,15 @@ static int f2fs_prepare_super_block(void)
>>   					qtype, next_ino - 1);
>>   	}
>>   
>> -	if (total_zones <= 6) {
>> +	if (main_zones <= 6) {
>>   		MSG(1, "\tError: %d zones: Need more zones "
>> -			"by shrinking zone size\n", total_zones);
>> +			"by shrinking zone size\n", main_zones);
>>   		return -1;
>>   	}
>>   
>>   	if (c.heap) {
>>   		c.cur_seg[CURSEG_HOT_NODE] =
>> -				last_section(last_zone(total_zones));
>> +				last_section(last_zone(main_zones));
>>   		c.cur_seg[CURSEG_WARM_NODE] = prev_zone(CURSEG_HOT_NODE);
>>   		c.cur_seg[CURSEG_COLD_NODE] = prev_zone(CURSEG_WARM_NODE);
>>   		c.cur_seg[CURSEG_HOT_DATA] = prev_zone(CURSEG_COLD_NODE);
>> @@ -424,10 +472,10 @@ static int f2fs_prepare_super_block(void)
>>   		c.cur_seg[CURSEG_COLD_NODE] = next_zone(CURSEG_WARM_NODE);
>>   		c.cur_seg[CURSEG_HOT_DATA] = next_zone(CURSEG_COLD_NODE);
>>   		c.cur_seg[CURSEG_COLD_DATA] =
>> -				max(last_zone((total_zones >> 2)),
>> +				max(last_zone((main_zones >> 2)),
>>   					next_zone(CURSEG_COLD_NODE));
>>   		c.cur_seg[CURSEG_WARM_DATA] =
>> -				max(last_zone((total_zones >> 1)),
>> +				max(last_zone((main_zones >> 1)),
>>   					next_zone(CURSEG_COLD_DATA));
>>   	}
>>   
>>
