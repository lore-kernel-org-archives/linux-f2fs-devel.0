From: Changman Lee <cm224.lee@samsung.com>
Subject: Re: [f2fs-dev] [PATCH 4/5] f2fs: write node pages if checkpoint is not
 doing
Date: Mon, 10 Nov 2014 16:37:58 +0900
Message-ID: <20141110073758.GC14659@lcm>
References: <1415518569-20626-1-git-send-email-jaegeuk@kernel.org>
 <1415518569-20626-4-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-disposition: inline
In-reply-to: <1415518569-20626-4-git-send-email-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Sat, Nov 08, 2014 at 11:36:08PM -0800, Jaegeuk Kim wrote:
> It needs to write node pages if checkpoint is not doing in order to avoid
> memory pressure.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/node.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 4ea2c47..6f514fb 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1314,10 +1314,12 @@ static int f2fs_write_node_page(struct page *page,
>  		return 0;
>  	}
>  
> -	if (wbc->for_reclaim)
> -		goto redirty_out;
> -
> -	down_read(&sbi->node_write);
> +	if (wbc->for_reclaim) {
> +		if (!down_read_trylock(&sbi->node_write))
> +			goto redirty_out;

Previously, we skipped write_page for reclaim path, but from now on, we
will write out node page to reclaim memory at any time except checkpoint.
We should remember it may occur to break merging bio.
Got it.

Reviewed-by: Changman Lee <cm224.lee@samsung.com>

> +	} else {
> +		down_read(&sbi->node_write);
> +	}
>  	set_page_writeback(page);
>  	write_node_page(sbi, page, &fio, nid, ni.blk_addr, &new_addr);
>  	set_node_addr(sbi, &ni, new_addr, is_fsync_dnode(page));
> -- 
> 2.1.1
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
