From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 2/4] f2fs: set buffer_new when new blocks are
	allocated
Date: Wed, 18 Mar 2015 10:24:18 +0800
Message-ID: <006e01d06122$bce68270$36b38750$@samsung.com>
References: <1426611461-690-1-git-send-email-jaegeuk@kernel.org>
 <1426611461-690-2-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <1426611461-690-2-git-send-email-jaegeuk@kernel.org>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Wednesday, March 18, 2015 12:58 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 2/4] f2fs: set buffer_new when new blocks are allocated
> 
> This patch modifies to call set_buffer_new, if new blocks are allocated.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/data.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index ba70a78..cefaa67 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -257,7 +257,6 @@ static void f2fs_map_bh(struct super_block *sb, pgoff_t pgofs,
>  	unsigned int blkbits = sb->s_blocksize_bits;
>  	size_t count;
> 
> -	set_buffer_new(bh_result);
>  	map_bh(bh_result, sb, ei->blk + pgofs - ei->fofs);
>  	count = ei->fofs + ei->len - pgofs;
>  	if (count < (UINT_MAX >> blkbits))
> @@ -1139,7 +1138,7 @@ static int __get_data_block(struct inode *inode, sector_t iblock,
>  		goto put_out;
> 
>  	if (dn.data_blkaddr != NULL_ADDR) {
> -		set_buffer_new(bh_result);
> +		clear_buffer_new(bh_result);

Add clear_buffer_new in f2fs_map_bh?

Thanks,

>  		map_bh(bh_result, inode->i_sb, dn.data_blkaddr);
>  	} else if (create) {
>  		err = __allocate_data_block(&dn);
> @@ -1184,6 +1183,7 @@ get_next:
>  			if (err)
>  				goto sync_out;
>  			allocated = true;
> +			set_buffer_new(bh_result);
>  			blkaddr = dn.data_blkaddr;
>  		}
>  		/* Give more consecutive addresses for the readahead */
> --
> 2.1.1

