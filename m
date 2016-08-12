From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] In fs/f2fs/data.c, there is a typo.
Date: Fri, 12 Aug 2016 09:23:53 +0800
Message-ID: <20160812012353.GB47037@jaegeuk>
References: <1470828336-26120-1-git-send-email-i9mpossible@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1470828336-26120-1-git-send-email-i9mpossible@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonggyu <i9mpossible@gmail.com>
Cc: cm224.lee@samsung.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jonggyu,

Please take a look at how other patches look like.
(e.g., subject and your SOB)

Thanks,

On Wed, Aug 10, 2016 at 08:25:36PM +0900, Jonggyu wrote:
> I fixed write_cche_pages to write_cache_pages
> 
> Signed-off-by: Jonggyu <i9mpossible@gmail.com>
> ---
>  fs/f2fs/data.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index d64d2a5..9549ff0 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1326,7 +1326,7 @@ redirty_out:
>  }
>  
>  /*
> - * This function was copied from write_cche_pages from mm/page-writeback.c.
> + * This function was copied from write_cache_pages from mm/page-writeback.c.
>   * The major change is making write step of cold data page separately from
>   * warm/hot data page.
>   */
> -- 
> 1.9.1
