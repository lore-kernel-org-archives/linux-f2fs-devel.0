From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 2/6] f2fs: convert inline_data for punch_hole
Date: Tue, 31 Dec 2013 14:08:24 +0800
Message-ID: <000001cf05ee$d8bd8c90$8a38a5b0$@samsung.com>
References: <1388116820-15038-1-git-send-email-jaegeuk.kim@samsung.com>
 <1388116820-15038-2-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <1388116820-15038-2-git-send-email-jaegeuk.kim@samsung.com>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

One comment as following.

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk.kim@samsung.com]
> Sent: Friday, December 27, 2013 12:00 PM
> Cc: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Subject: [f2fs-dev] [PATCH 2/6] f2fs: convert inline_data for punch_hole
> 
> In the punch_hole(), let's convert inline_data all the time for simplicity and
> to avoid potential deadlock conditions.
> It is pretty much not a big deal to do this.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>

> ---
>  fs/f2fs/file.c | 22 +++-------------------
>  1 file changed, 3 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 7ef2d6a..f64a1c8 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -462,25 +462,9 @@ static int punch_hole(struct inode *inode, loff_t offset, loff_t len)
>  	loff_t off_start, off_end;
>  	int ret = 0;
> 
> -	if (f2fs_has_inline_data(inode)) {
> -		struct page *page;
> -		unsigned flags = AOP_FLAG_NOFS;
> -		page = grab_cache_page_write_begin(inode->i_mapping, 0, flags);
> -		if (IS_ERR(page))
> -			return PTR_ERR(page);

We use following code because grab_cache_page_write_begin only use
NULL value as its error number.

	if (!page)
		return -ENOMEM;

> -		if (offset + len > MAX_INLINE_DATA) {
> -			ret = f2fs_convert_inline_data(inode, page, flags);
> -			f2fs_put_page(page, 1);
> -			if (ret)
> -				return ret;
> -		} else {
> -			zero_user_segment(page, offset, offset + len);
> -			SetPageUptodate(page);
> -			set_page_dirty(page);
> -			f2fs_put_page(page, 1);
> -			return ret;
> -		}
> -	}
> +	ret = f2fs_convert_inline_data(inode, NULL, AOP_FLAG_NOFS);
> +	if (ret)
> +		return ret;
> 
>  	pg_start = ((unsigned long long) offset) >> PAGE_CACHE_SHIFT;
>  	pg_end = ((unsigned long long) offset + len) >> PAGE_CACHE_SHIFT;
> --
> 1.8.4.474.g128a96c
> 
> 
> ------------------------------------------------------------------------------
> Rapidly troubleshoot problems before they affect your business. Most IT
> organizations don't have a clear picture of how application performance
> affects their revenue. With AppDynamics, you get 100% visibility into your
> Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
> http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

