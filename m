From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: expose some sectors to user in inline data or
 dentry case
Date: Mon, 16 Oct 2017 11:11:28 +0800
Message-ID: <6ecc1778-bcf8-c07d-037a-dd733e247fa9@huawei.com>
References: <20171013173145.36510-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20171013173145.36510-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/10/14 1:31, Jaegeuk Kim wrote:
> If there's some data written through inline data or dentry, we need to shouw
> st_blocks. This fixes reporting zero blocks even though there is small written
> data.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fs/f2fs/file.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 2eb3efe92018..f7be6c394fa8 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -698,6 +698,11 @@ int f2fs_getattr(const struct path *path, struct kstat *stat,
>  				  STATX_ATTR_NODUMP);
>  
>  	generic_fillattr(inode, stat);
> +
> +	/* we need to show initial sectors used for inline_data/dentries */
> +	if (f2fs_has_inline_data(inode) || f2fs_has_inline_dentry(inode))
> +		stat->blocks += (stat->size + 511) >> 9;
> +
>  	return 0;
>  }
>  
> 
