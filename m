From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: fix BG_GC count stat & f2fs_gc return
 value
Date: Mon, 8 May 2017 13:36:32 -0700
Message-ID: <20170508203632.GA47455@jaegeuk.local>
References: <20170505180728.235186-1-guoweichao@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1d7pOf-0002ij-Ae
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 08 May 2017 20:36:45 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1d7pOb-0004VB-Eb
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 08 May 2017 20:36:45 +0000
Content-Disposition: inline
In-Reply-To: <20170505180728.235186-1-guoweichao@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Weichao Guo <guoweichao@huawei.com>
Cc: huxinwei@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Hi Weichao,

On 05/06, Weichao Guo wrote:
> We should call stat_inc_bggc_count only after BG_GC has been performed
> successfully. Otherwise, BG_GC count may be larger than total count when
> f2fs_gc failed, e.g., no victim was selected.
> 
> By default, f2fs_gc returns EINVAL in some error cases, e.g., no victim was
> selected. However, the default errno may be overwritten in the case of
> BG_GC -> FG_GC.

Please split this patch into two patches per each issue.

> 
> Signed-off-by: Weichao Guo <guoweichao@huawei.com>
> ---
>  fs/f2fs/gc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 0265221..a42cafe 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -81,11 +81,11 @@ static int gc_thread_func(void *data)
>  		else
>  			increase_sleep_time(gc_th, &wait_ms);
>  
> -		stat_inc_bggc_count(sbi);
> -
>  		/* if return value is not zero, no victim was selected */
>  		if (f2fs_gc(sbi, test_opt(sbi, FORCE_FG_GC), true, NULL_SEGNO))
>  			wait_ms = gc_th->no_gc_sleep_time;
> +		else
> +			stat_inc_bggc_count(sbi);
>  
>  		trace_f2fs_background_gc(sbi->sb, wait_ms,
>  				prefree_segments(sbi), free_segments(sbi));
> @@ -987,6 +987,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>  			gc_type = FG_GC;
>  	}
>  
> +	ret = -EINVAL;

It'd be better to set -EINVAL at the beginning of gc_more timing.
Thoughts?

Thanks,

>  	/* f2fs_balance_fs doesn't need to do BG_GC in critical path. */
>  	if (gc_type == BG_GC && !background)
>  		goto stop;
> -- 
> 2.10.1
> 
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
