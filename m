From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: fix BG_GC count stat
Date: Tue, 9 May 2017 10:51:54 -0700
Message-ID: <20170509175154.GA83848@jaegeuk.local>
References: <20170509114008.53236-1-guoweichao@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1d89Iy-0004xm-IE
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 09 May 2017 17:52:12 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1d89It-0003Sw-T1
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 09 May 2017 17:52:12 +0000
Content-Disposition: inline
In-Reply-To: <20170509114008.53236-1-guoweichao@huawei.com>
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
Cc: linux-f2fs-devel@lists.sourceforge.net

On 05/09, Weichao Guo wrote:
> We should call stat_inc_bggc_count only after BG_GC has been performed
> successfully. Otherwise, BG_GC count may be larger than total count
> when f2fs_gc failed, e.g., no victim was selected.

BTW, if we do this, we can't monitor the call count of BGGC. Actually we don't
need to match this with total GC count. How about adding another variable to
show successful GC count which looks like (BG: x/y)?

Thanks,

> 
> Signed-off-by: Weichao Guo <guoweichao@huawei.com>
> ---
>  fs/f2fs/gc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 0265221..fbea046 100644
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
> -- 
> 2.10.1

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
