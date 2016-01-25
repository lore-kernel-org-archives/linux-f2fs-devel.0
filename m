From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 2/2] f2fs: fix to overcome inline_data floods
Date: Mon, 25 Jan 2016 17:49:06 +0800
Message-ID: <000e01d15755$bb6b1990$32414cb0$@samsung.com>
References: <1453580148-61861-1-git-send-email-jaegeuk@kernel.org>
 <1453580148-61861-2-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <1453580148-61861-2-git-send-email-jaegeuk@kernel.org>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Sunday, January 24, 2016 4:16 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 2/2] f2fs: fix to overcome inline_data floods
> 
> The scenario is:
> 1. create lots of node blocks
> 2. sync
> 3. write lots of inline_data
> -> got panic due to no free space
> 
> In that case, we should flush node blocks when writing inline_data in #3,
> and trigger gc as well.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/gc.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 0204433..8686231 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -838,8 +838,15 @@ gc_more:
> 
>  	if (gc_type == BG_GC && has_not_enough_free_secs(sbi, sec_freed)) {
>  		gc_type = FG_GC;
> +		/*
> +		 * If there is no victim and no prefree segment but still not
> +		 * enough free sections, we should flush dent/node blocks and do
> +		 * garbage collections.
> +		 */
>  		if (__get_victim(sbi, &segno, gc_type) || prefree_segments(sbi))
>  			write_checkpoint(sbi, &cpc);
> +		else if (has_not_enough_free_secs(sbi, 0))

I think this condition make checkpoint been triggered more frequently,
could we trigger cp when dent/node block exceed some threshold?

Thanks,

> +			write_checkpoint(sbi, &cpc);
>  	}
> 
>  	if (segno == NULL_SEGNO && !__get_victim(sbi, &segno, gc_type))
> --
> 2.6.3
> 
> 
> ------------------------------------------------------------------------------
> Site24x7 APM Insight: Get Deep Visibility into Application Performance
> APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
> Monitor end-to-end web transactions and take corrective actions now
> Troubleshoot faster and improve end-user experience. Signup Now!
> http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

