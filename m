From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: fix to cover f2fs_fiemap with inode_lock
Date: Wed, 10 Jan 2018 10:41:41 -0800
Message-ID: <20180110184141.GA18352@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180110061806.15744-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180110061806.15744-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 01/10, Chao Yu wrote:
> This patch fix to cover f2fs_fiemap with inode_lock in order to make
> the whole interface avoiding race with mapping change.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/data.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index d6302051a65d..330085d3adfc 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1146,18 +1146,18 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  	u32 flags = 0;
>  	int ret = 0;
>  
> +	inode_lock(inode);
> +
>  	ret = fiemap_check_flags(fieinfo, FIEMAP_FLAG_SYNC);
>  	if (ret)
> -		return ret;
> +		goto out;

Uh? We don't need to cover fiemap_check_flags() by inode_lock().

>  
>  	if (f2fs_has_inline_data(inode)) {
>  		ret = f2fs_inline_data_fiemap(inode, fieinfo, start, len);
>  		if (ret != -EAGAIN)
> -			return ret;
> +			goto out;
>  	}
>  
> -	inode_lock(inode);
> -
>  	if (logical_to_blk(inode, len) == 0)
>  		len = blk_to_logical(inode, 1);
>  
> -- 
> 2.15.0.55.gc2ece9dc4de6
