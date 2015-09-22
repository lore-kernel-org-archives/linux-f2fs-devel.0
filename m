From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: fix to correct freed section number during gc
Date: Tue, 22 Sep 2015 15:53:52 -0700
Message-ID: <20150922225352.GA31427@jaegeuk-mac02.mot.com>
References: <00d601d0f539$3d893e90$b89bbbb0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <00d601d0f539$3d893e90$b89bbbb0$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

On Tue, Sep 22, 2015 at 09:18:18PM +0800, Chao Yu wrote:
> We pass 'nfree' to has_not_enough_free_secs to check whether there is
> enough free section, but 'nfree' indicates the number of segment gced,
> should alter the value to section number.

Yeah, but I think we need to increase nfree only when an entire section is gced
completely, since sometimes nfree can be increased across sections.

Thanks,

> 
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  fs/f2fs/gc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index e932740..7ad2a60 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -817,7 +817,8 @@ gc_more:
>  	if (unlikely(f2fs_cp_error(sbi)))
>  		goto stop;
>  
> -	if (gc_type == BG_GC && has_not_enough_free_secs(sbi, nfree)) {
> +	if (gc_type == BG_GC &&
> +		has_not_enough_free_secs(sbi, nfree / sbi->segs_per_sec)) {
>  		gc_type = FG_GC;
>  		if (__get_victim(sbi, &segno, gc_type) || prefree_segments(sbi))
>  			write_checkpoint(sbi, &cpc);
> @@ -839,7 +840,7 @@ gc_more:
>  	if (gc_type == FG_GC)
>  		sbi->cur_victim_sec = NULL_SEGNO;
>  
> -	if (has_not_enough_free_secs(sbi, nfree))
> +	if (has_not_enough_free_secs(sbi, nfree / sbi->segs_per_sec))
>  		goto gc_more;
>  
>  	if (gc_type == FG_GC)
> -- 
> 2.5.2
