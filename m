From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: add a modify discard command function
Date: Mon, 27 Feb 2017 15:08:05 -0800
Message-ID: <20170227230805.GC9106@jaegeuk.local>
References: <20170227071943.32195-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ciUOv-0006I3-LI
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Feb 2017 23:08:17 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ciUOt-0005K6-GV
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Feb 2017 23:08:17 +0000
Content-Disposition: inline
In-Reply-To: <20170227071943.32195-1-heyunlei@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlei He <heyunlei@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 02/27, Yunlei He wrote:
> This patch add a function to modify discard command if one segment
> reuse before discard. Split this segment from multi-segments discard
> range, and discard the left bigger range.

Now MAX_DISCARD_BLOCKS() is set to section size, so there will be no
multi-sections discard range. Am I missing some cases?

Thanks,

> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/segment.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 9006d8e..5af736b 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -672,6 +672,22 @@ static void __remove_discard_cmd(struct f2fs_sb_info *sbi, struct discard_cmd *d
>  	kmem_cache_free(discard_cmd_slab, dc);
>  }
>  
> +static void __modify_discard_cmd(struct f2fs_sb_info *sbi, struct discard_cmd *dc, block_t blkaddr)
> +{
> +	block_t end_block = START_BLOCK(sbi, GET_SEGNO(sbi, blkaddr) + 1);
> +
> +	if (dc->lstart + dc->len <= end_block) {
> +		 __remove_discard_cmd(sbi, dc);
> +		return;
> +	}
> +
> +	if (dc->lstart - blkaddr < dc->lstart + dc->len - end_block) {
> +		dc->lstart = end_block;
> +		dc->len -= (end_block - dc->lstart);
> +	} else
> +		dc->len = blkaddr - dc->lstart;
> +}
> +
>  /* This should be covered by global mutex, &sit_i->sentry_lock */
>  void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
>  {
> @@ -699,7 +715,7 @@ void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
>  			if (dc->state == D_SUBMIT)
>  				wait_for_completion_io(&dc->wait);
>  			else
> -				__remove_discard_cmd(sbi, dc);
> +				__modify_discard_cmd(sbi, dc, blkaddr);
>  		}
>  	}
>  	blk_finish_plug(&plug);
> -- 
> 2.10.1

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
