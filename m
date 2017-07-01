From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/2] f2fs: reuse original mount option in ->remount_fs
Date: Sat, 1 Jul 2017 00:48:04 -0700
Message-ID: <20170701074804.GB85052@jaegeuk-macbookpro.roam.corp.google.com>
References: <20170629152046.2610-1-chao@kernel.org>
 <20170629152046.2610-2-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170629152046.2610-2-chao@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 06/29, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> Don't clear old mount option before parse new option during ->remount_fs
> like other generic filesystems.

So, what happened on your original patch?

commit 26666c8a4366debae30ae37d0688b2bec92d196a
    f2fs: fix to clean previous mount option when remount_fs

I think we need to rever the original patch tho.

Thanks,

> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/super.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index f27c141cd8aa..af472f7968d0 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -846,7 +846,6 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>  			clear_sbi_flag(sbi, SBI_NEED_SB_WRITE);
>  	}
>  
> -	sbi->mount_opt.opt = 0;
>  	default_options(sbi);
>  
>  	/* parse mount options */
> -- 
> 2.13.0.90.g1eb437020
