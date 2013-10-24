From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: Re: [f2fs-dev] [PATCH V2] f2fs: check all ones or zeros bitmap with
 bitops for better mount performance
Date: Thu, 24 Oct 2013 18:03:33 +0800
Message-ID: <5268F075.3000206@cn.fujitsu.com>
References: <000401ced092$28087a90$78196fb0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <000401ced092$28087a90$78196fb0$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: jaegeuk.kim@samsung.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, =?UTF-8?B?J+iwreWnnSc=?= <shu.tan@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Yu,
On 10/24/2013 04:21 PM, Chao Yu wrote:

> Previously, check_block_count check valid_map with bit data type in common scenario that sit has all ones or zeros bitmap, it makes low mount performance.
> So let's check the special bitmap with integer data type instead of the bit one.
> 
> v2:
>     use find_next_bit_le/find_next_zero_bit_le for better performance and readable as Jaegeuk suggested.

If so, how about using find_first_{zero_}bit_le instead? It's more neat.

Regards,
Gu

> 
> Suggested-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
> Signed-off-by: Tan Shu <shu.tan@samsung.com>
> Signed-off-by: Yu Chao <chao2.yu@samsung.com>
> ---
>  fs/f2fs/segment.h |   17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 7f94d78..d25b6af 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -552,6 +552,23 @@ static inline void check_block_count(struct f2fs_sb_info *sbi,
>  	/* check boundary of a given segment number */
>  	BUG_ON(segno > end_segno);
>  
> +	/* check all ones or zeros valid_map */
> +	if (GET_SIT_VBLOCKS(raw_sit) == 0) {
> +		int pos = find_next_bit_le(&raw_sit->valid_map,
> +					sbi->blocks_per_seg,
> +					0);
> +		if (pos != sbi->blocks_per_seg)
> +			BUG();
> +		return;
> +	} else if (GET_SIT_VBLOCKS(raw_sit) == sbi->blocks_per_seg) {
> +		int pos = find_next_zero_bit_le(&raw_sit->valid_map,
> +					sbi->blocks_per_seg,
> +					0);
> +		if (pos != sbi->blocks_per_seg)
> +			BUG();
> +		return;
> +	}
> +
>  	/* check bitmap with valid block count */
>  	for (i = 0; i < sbi->blocks_per_seg; i++)
>  		if (f2fs_test_bit(i, raw_sit->valid_map))
