From: Changman Lee <cm224.lee@samsung.com>
Subject: RE: [f2fs-dev] [PATCH V2 RESEND] f2fs: check all ones or zeros bitmap
 with bitops for better mount performance
Date: Wed, 30 Oct 2013 08:15:18 +0900
Message-ID: <016701ced4fc$bb7afe10$3270fa30$@samsung.com>
References: <001f01ced473$4c5cc9c0$e5165d40$@samsung.com>
 <002a01ced479$925505e0$b6ff11a0$@samsung.com>
 <002301ced48e$c615e010$5241a030$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <002301ced48e$c615e010$5241a030$@samsung.com>
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: 'Chao Yu' <chao2.yu@samsung.com>, jaegeuk.kim@samsung.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net


Firstly,
Thanks. You're right. And I don't know it would be optimized but considering
pipeline.

for ( i =0; i < SIT_VBLOCK_MAP_SIZE; i += 4) {
    valid_blocks += bit_count_byte(raw_sit->valid_map[i];
    valid_blocks += bit_count_byte(raw_sit->valid_map[i+1];
    valid_blocks += bit_count_byte(raw_sit->valid_map[i+2];
    valid_blocks += bit_count_byte(raw_sit->valid_map[i+3];
}

Secondly,
I think also your patch is good in lots of case NOT aging for long time.

-----Original Message-----
From: Chao Yu [mailto:chao2.yu@samsung.com] 
Sent: Tuesday, October 29, 2013 7:07 PM
To: 'Changman Lee'; jaegeuk.kim@samsung.com
Cc: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org;
linux-f2fs-devel@lists.sourceforge.net
Subject: RE: [f2fs-dev] [PATCH V2 RESEND] f2fs: check all ones or zeros
bitmap with bitops for better mount performance

Hi Lee,

It's a good point.

Firstly, In your patch:
	/* check bitmap with valid block count */
 	for (i = 0; i < sbi->blocks_per_seg; i++)
-		if (f2fs_test_bit(i, raw_sit->valid_map))
-			valid_blocks++;
+		valid_blocks += bit_count_byte(raw_sit->valid_map[i]);
+
 	BUG_ON(GET_SIT_VBLOCKS(raw_sit) != valid_blocks);  }

for (i = 0; i < sbi->blocks_per_seg; i++) should be replace with for (i = 0;
i < SIT_VBLOCK_MAP_SIZE; i++)

Secondly, I tested your patch and mine
with SD and emmc with all zeros bitmap.
It shows my patch takes litter time.
Could you test and compare the performance of two patches.

--
1.7.10.4


> -----Original Message-----
> From: Changman Lee [mailto:cm224.lee@samsung.com]
> Sent: Tuesday, October 29, 2013 3:36 PM
> To: 'Chao Yu'; jaegeuk.kim@samsung.com
> Cc: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: RE: [f2fs-dev] [PATCH V2 RESEND] f2fs: check all ones or zeros
bitmap
> with bitops for better mount performance
> 
> Review attached patch, please.
> 
> -----Original Message-----
> From: Chao Yu [mailto:chao2.yu@samsung.com]
> Sent: Tuesday, October 29, 2013 3:51 PM
> To: jaegeuk.kim@samsung.com
> Cc: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: [f2fs-dev] [PATCH V2 RESEND] f2fs: check all ones or zeros bitmap
with
> bitops for better mount performance
> 
> Previously, check_block_count check valid_map with bit data type in common
> scenario that sit has all ones or zeros bitmap, it makes low mount
> performance.
> So let's check the special bitmap with integer data type instead of the
bit one.
> 
> v1-->v2:
>     use find_next_{zero_}bit_le for better performance and readable as
> Jaegeuk suggested.
> 	use neat logogram in comment as Gu Zheng suggested.
> 	search continuous ones or zeros for better performance when checking
> mixed bitmap.
> 
> Suggested-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
> Signed-off-by: Shu Tan <shu.tan@samsung.com>
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  fs/f2fs/segment.h |   19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h index abe7094..a7abfa8
> 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -550,8 +550,9 @@ static inline void check_block_count(struct
> f2fs_sb_info *sbi,  {
>  	struct f2fs_sm_info *sm_info = SM_I(sbi);
>  	unsigned int end_segno = sm_info->segment_count - 1;
> +	bool is_valid  = test_bit_le(0, raw_sit->valid_map) ? true : false;
>  	int valid_blocks = 0;
> -	int i;
> +	int cur_pos = 0, next_pos;
> 
>  	/* check segment usage */
>  	BUG_ON(GET_SIT_VBLOCKS(raw_sit) > sbi->blocks_per_seg); @@ -560,9
> +561,19 @@ static inline void check_block_count(struct f2fs_sb_info
> +*sbi,
>  	BUG_ON(segno > end_segno);
> 
>  	/* check bitmap with valid block count */
> -	for (i = 0; i < sbi->blocks_per_seg; i++)
> -		if (f2fs_test_bit(i, raw_sit->valid_map))
> -			valid_blocks++;
> +	do {
> +		if (is_valid) {
> +			next_pos =
> find_next_zero_bit_le(&raw_sit->valid_map,
> +					sbi->blocks_per_seg,
> +					cur_pos);
> +			valid_blocks += next_pos - cur_pos;
> +		} else
> +			next_pos = find_next_bit_le(&raw_sit->valid_map,
> +					sbi->blocks_per_seg,
> +					cur_pos);
> +		cur_pos = next_pos;
> +		is_valid = !is_valid;
> +	} while (cur_pos < sbi->blocks_per_seg);
>  	BUG_ON(GET_SIT_VBLOCKS(raw_sit) != valid_blocks);  }
> 
> --
> 1.7.9.5
> 
> 
>
----------------------------------------------------------------------------
> --
> Android is increasing in popularity, but the open development platform
that
> developers love is also attractive to malware creators. Download this
white
> paper to learn more about secure code signing practices that can help keep
> Android apps secure.
> http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktr
> k
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
