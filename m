From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 2/3] f2fs crypto: use bounce pages from mempool
	first
Date: Mon, 25 May 2015 18:00:47 +0800
Message-ID: <00d101d096d1$c7300a50$55901ef0$@samsung.com>
References: <1432255225-76792-1-git-send-email-jaegeuk@kernel.org>
 <1432255225-76792-2-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1432255225-76792-2-git-send-email-jaegeuk@kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Friday, May 22, 2015 8:40 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 2/3] f2fs crypto: use bounce pages from mempool first
> 
> If a lot of write streams are triggered, alloc_page and __free_page are
> costly called, resulting in high memory pressure.
> 
> In order to avoid that, let's reuse mempool pages for writeback pages.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/crypto.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/f2fs/crypto.c b/fs/f2fs/crypto.c
> index 2c7819a..2ceee68 100644
> --- a/fs/f2fs/crypto.c
> +++ b/fs/f2fs/crypto.c
> @@ -408,20 +408,12 @@ struct page *f2fs_encrypt(struct inode *inode,
>  		return (struct page *)ctx;
> 
>  	/* The encryption operation will require a bounce page. */
> -	ciphertext_page = alloc_page(GFP_NOFS);
> +	ciphertext_page = mempool_alloc(f2fs_bounce_page_pool, GFP_NOFS);
>  	if (!ciphertext_page) {
> -		/*
> -		 * This is a potential bottleneck, but at least we'll have
> -		 * forward progress.
> -		 */
> -		ciphertext_page = mempool_alloc(f2fs_bounce_page_pool,
> -							GFP_NOFS);
> -		if (WARN_ON_ONCE(!ciphertext_page))
> -			ciphertext_page = mempool_alloc(f2fs_bounce_page_pool,
> -						GFP_NOFS | __GFP_WAIT);
> -		ctx->flags &= ~F2FS_BOUNCE_PAGE_REQUIRES_FREE_ENCRYPT_FL;
> -	} else {
> +		ciphertext_page = alloc_page(GFP_NOFS);

Using alloc_page(GFP_NOFS | __GFP_WAIT) to avoid failure?

Thanks,

>  		ctx->flags |= F2FS_BOUNCE_PAGE_REQUIRES_FREE_ENCRYPT_FL;
> +	} else {
> +		ctx->flags &= ~F2FS_BOUNCE_PAGE_REQUIRES_FREE_ENCRYPT_FL;
>  	}
>  	ctx->flags |= F2FS_WRITE_PATH_FL;
>  	ctx->w.bounce_page = ciphertext_page;
> --
> 2.1.1
> 
> 
> ------------------------------------------------------------------------------
> One dashboard for servers and applications across Physical-Virtual-Cloud
> Widest out-of-the-box monitoring support with 50+ applications
> Performance metrics, stats and reports that give you Actionable Insights
> Deep dive visibility with transaction tracing using APM Insight.
> http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
