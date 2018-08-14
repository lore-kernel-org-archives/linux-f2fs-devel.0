From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] Revert "f2fs: use printk_ratelimited for f2fs_msg"
Date: Tue, 14 Aug 2018 10:09:56 -0700
Message-ID: <20180814170956.GA56510@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180813062845.25394-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180813062845.25394-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 08/13, Chao Yu wrote:
> Don't limit printing log, so that we will not miss any key messages.

For example, this can avoid lots of messages during roll-forward recovery.

> 
> This reverts commit a36c106dffb616250117efb1cab271c19a8f94ff.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index bf4c919fe418..3d89d94191e7 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -209,7 +209,7 @@ void f2fs_msg(struct super_block *sb, const char *level, const char *fmt, ...)
>  	va_start(args, fmt);
>  	vaf.fmt = fmt;
>  	vaf.va = &args;
> -	printk_ratelimited("%sF2FS-fs (%s): %pV\n", level, sb->s_id, &vaf);
> +	printk("%sF2FS-fs (%s): %pV\n", level, sb->s_id, &vaf);
>  	va_end(args);
>  }
>  
> -- 
> 2.18.0.rc1
