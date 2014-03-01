From: Dave Chinner <david@fromorbit.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix dirty page accounting when redirty
Date: Sat, 1 Mar 2014 11:26:43 +1100
Message-ID: <20140301002643.GL30131@dastard>
References: <000001cf342a$95864830$c092d890$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <000001cf342a$95864830$c092d890$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: ??? <jaegeuk.kim@samsung.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Fri, Feb 28, 2014 at 10:12:05AM +0800, Chao Yu wrote:
> We should de-account dirty counters for page when redirty in ->writepage().
> 
> Wu Fengguang described in 'commit 971767caf632190f77a40b4011c19948232eed75':
> "writeback: fix dirtied pages accounting on redirty
> De-account the accumulative dirty counters on page redirty.
> 
> Page redirties (very common in ext4) will introduce mismatch between
> counters (a) and (b)
> 
> a) NR_DIRTIED, BDI_DIRTIED, tsk->nr_dirtied
> b) NR_WRITTEN, BDI_WRITTEN
> 
> This will introduce systematic errors in balanced_rate and result in
> dirty page position errors (ie. the dirty pages are no longer balanced
> around the global/bdi setpoints)."
> 
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  fs/f2fs/checkpoint.c |    1 +
>  fs/f2fs/data.c       |    1 +
>  fs/f2fs/node.c       |    1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index c8516ee..f069249 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -178,6 +178,7 @@ no_write:
>  redirty_out:
>  	dec_page_count(sbi, F2FS_DIRTY_META);
>  	wbc->pages_skipped++;
> +	account_page_redirty(page);
>  	set_page_dirty(page);
>  	return AOP_WRITEPAGE_ACTIVATE;

redirty_page_for_writepage()?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
