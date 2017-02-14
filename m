From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/2] f2fs: enable inline_xattr by default
Date: Mon, 13 Feb 2017 16:35:02 -0800
Message-ID: <20170214003502.GB14533@jaegeuk.local>
References: <20170208093945.24681-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170208093945.24681-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

On 02/08, Chao Yu wrote:
> In android, since SElinux is enable, security policy will be appliedd for
> each file, it stores in inode as an xattr entry, so it will take one 4k
> size node block additionally for each file.
> 
> Let's enable inline_xattr by default in order to save storage space.

Then, we need to add "noinline_xattr".

Thanks,

> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/super.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 68a555b014cf..e2f919d3096a 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1026,6 +1026,7 @@ static void default_options(struct f2fs_sb_info *sbi)
>  	sbi->active_logs = NR_CURSEG_TYPE;
>  
>  	set_opt(sbi, BG_GC);
> +	set_opt(sbi, INLINE_XATTR);
>  	set_opt(sbi, INLINE_DATA);
>  	set_opt(sbi, INLINE_DENTRY);
>  	set_opt(sbi, EXTENT_CACHE);
> -- 
> 2.8.2.295.g3f1c1d0
