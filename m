From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: fix to restrict mount condition when without
 CONFIG_QUOTA
Date: Fri, 27 Jul 2018 19:08:55 +0900
Message-ID: <20180727100855.GF16155@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180724165546.12924-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180724165546.12924-1-chao@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 07/25, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> Like quota_ino feature, we need to reject mounting RDWR with image
> which enables project_quota feature when there is no CONFIG_QUOTA
> be set in kernel.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/super.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index dbc1cb53581f..bb40f08d2861 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -775,6 +775,12 @@ static int parse_options(struct super_block *sb, char *options)
>  			 "without CONFIG_QUOTA");
>  		return -EINVAL;
>  	}
> +	if (f2fs_sb_has_project_quota(sbi->sb) && !f2fs_readonly(sbi->sb)) {
> +		ext4_msg(sb, KERN_ERR,

What is this?

> +			"Filesystem with project quota feature cannot be "
> +			"mounted RDWR without CONFIG_QUOTA");
> +		return -EINVAL;
> +	}
>  #endif
>  
>  	if (F2FS_IO_SIZE_BITS(sbi) && !test_opt(sbi, LFS)) {
> -- 
> 2.16.2.17.g38e79b1fd
