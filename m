From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/4] f2fs: limit b_size of mapped bh in f2fs_map_bh
Date: Mon, 23 Mar 2015 21:42:11 -0700
Message-ID: <20150324044211.GA35842@jaegeuk-mac02.hsd1.ca.comcast.net>
References: <002201d06511$16e17c70$44a47550$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <002201d06511$16e17c70$44a47550$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: Changman Lee <cm224.lee@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

On Mon, Mar 23, 2015 at 10:28:00AM +0800, Chao Yu wrote:
> Map bh over max size which caller defined is not needed, limit it in
> f2fs_map_bh.
> 
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  fs/f2fs/data.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index f0a18a0..a99bc7f 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -255,15 +255,16 @@ static void f2fs_map_bh(struct super_block *sb, pgoff_t pgofs,
>  			struct extent_info *ei, struct buffer_head *bh_result)
>  {
>  	unsigned int blkbits = sb->s_blocksize_bits;
> +	unsigned int maxblocks = bh_result->b_size >> blkbits;
>  	size_t count;
>  
>  	clear_buffer_new(bh_result);
>  	map_bh(bh_result, sb, ei->blk + pgofs - ei->fofs);
>  	count = ei->fofs + ei->len - pgofs;
> -	if (count < (UINT_MAX >> blkbits))
> -		bh_result->b_size = (count << blkbits);
> +	if (count > maxblocks)
> +		bh_result->b_size = maxblocks << blkbits;
>  	else
> -		bh_result->b_size = UINT_MAX;
> +		bh_result->b_size = count << blkbits;

How about using min()?

Thanks,

>  }
>  
>  static bool lookup_extent_info(struct inode *inode, pgoff_t pgofs,
> -- 
> 2.3.3
