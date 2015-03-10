From: Changman Lee <cm224.lee@samsung.com>
Subject: Re: [PATCH] f2fs: fix reference leaks in f2fs_acl_create
Date: Tue, 10 Mar 2015 10:15:10 +0900
Message-ID: <20150310011510.GC4450@lcm-devel.org>
References: <000901d05a52$77f298b0$67d7ca10$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-disposition: inline
In-reply-to: <000901d05a52$77f298b0$67d7ca10$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Reviewed-by: Changman Lee <cm224.lee@ssamsung.com>

On Mon, Mar 09, 2015 at 06:18:19PM +0800, Chao Yu wrote:
> Our f2fs_acl_create is copied and modified from posix_acl_create to avoid
> deadlock bug when inline_dentry feature is enabled.
> 
> Now, we got reference leaks in posix_acl_create, and this has been fixed in
> commit fed0b588be2f ("posix_acl: fix reference leaks in posix_acl_create")
> by Omar Sandoval.
> https://lkml.org/lkml/2015/2/9/5
> 
> Let's fix this issue in f2fs_acl_create too.
> 
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  fs/f2fs/acl.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
> index 7422027..4320ffa 100644
> --- a/fs/f2fs/acl.c
> +++ b/fs/f2fs/acl.c
> @@ -351,13 +351,11 @@ static int f2fs_acl_create(struct inode *dir, umode_t *mode,
>  
>  	*acl = f2fs_acl_clone(p, GFP_NOFS);
>  	if (!*acl)
> -		return -ENOMEM;
> +		goto no_mem;
>  
>  	ret = f2fs_acl_create_masq(*acl, mode);
> -	if (ret < 0) {
> -		posix_acl_release(*acl);
> -		return -ENOMEM;
> -	}
> +	if (ret < 0)
> +		goto no_mem_clone;
>  
>  	if (ret == 0) {
>  		posix_acl_release(*acl);
> @@ -378,6 +376,12 @@ no_acl:
>  	*default_acl = NULL;
>  	*acl = NULL;
>  	return 0;
> +
> +no_mem_clone:
> +	posix_acl_release(*acl);
> +no_mem:
> +	posix_acl_release(p);
> +	return -ENOMEM;
>  }
>  
>  int f2fs_init_acl(struct inode *inode, struct inode *dir, struct page *ipage,
> -- 
> 2.3.0
> 
