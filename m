From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: fix to keep backward compatibility of flexible
 inline xattr feature
Date: Thu, 26 Oct 2017 10:42:43 +0200
Message-ID: <20171026084243.GA54331@jaegeuk-macbookpro.roam.corp.google.com>
References: <20171025103124.63162-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171025103124.63162-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

It seems this is a critical problem, so let me integrate this patch with your
initial patch "f2fs: support flexible inline xattr size".
Let me know, if you have any other concern.

Thanks,

On 10/25, Chao Yu wrote:
> Previously, in inode layout, we will always reserve 200 bytes for inline
> xattr space no matter the inode enables inline xattr feature or not, due
> to this reason, max inline size of inode is fixed, but now, if inline
> xattr is not enabled, max inline size of inode will be enlarged by 200
> bytes, for regular and symlink inode, it will be safe to reuse resevered
> space as they are all zero, but for directory, we need to keep the
> reservation for stablizing directory structure.
> 
> Reported-by: Sheng Yong <shengyong1@huawei.com>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/f2fs.h  |  5 +----
>  fs/f2fs/inode.c | 15 ++++++++++++---
>  fs/f2fs/namei.c |  2 ++
>  3 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 2af1d31ae74b..7ddd0d085e3b 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2393,10 +2393,7 @@ static inline int get_extra_isize(struct inode *inode)
>  static inline int f2fs_sb_has_flexible_inline_xattr(struct super_block *sb);
>  static inline int get_inline_xattr_addrs(struct inode *inode)
>  {
> -	if (!f2fs_has_inline_xattr(inode))
> -		return 0;
> -	if (!f2fs_sb_has_flexible_inline_xattr(F2FS_I_SB(inode)->sb))
> -		return DEFAULT_INLINE_XATTR_ADDRS;
> +
>  	return F2FS_I(inode)->i_inline_xattr_size;
>  }
>  
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index bb876737e653..7f31b22c9efa 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -232,10 +232,19 @@ static int do_read_inode(struct inode *inode)
>  	fi->i_extra_isize = f2fs_has_extra_attr(inode) ?
>  					le16_to_cpu(ri->i_extra_isize) : 0;
>  
> -	if (!f2fs_has_inline_xattr(inode))
> -		fi->i_inline_xattr_size = 0;
> -	else if (f2fs_sb_has_flexible_inline_xattr(sbi->sb))
> +	/*
> +	 * Previously, we will always reserve DEFAULT_INLINE_XATTR_ADDRS size
> +	 * space for inline xattr datas, if inline xattr is not enabled, we
> +	 * can expect all zero in reserved area, so for regular or symlink,
> +	 * it will be safe to reuse reserved area, but for directory, we
> +	 * should keep the reservation for stablizing directory structure.
> +	 */
> +	if (f2fs_has_extra_attr(inode) &&
> +		f2fs_sb_has_flexible_inline_xattr(sbi->sb))
>  		fi->i_inline_xattr_size = le16_to_cpu(ri->i_inline_xattr_size);
> +	else if (!f2fs_has_inline_xattr(inode) &&
> +		(S_ISREG(inode->i_mode) || S_ISLNK(inode->i_mode)))
> +		fi->i_inline_xattr_size = 0;
>  	else
>  		fi->i_inline_xattr_size = DEFAULT_INLINE_XATTR_ADDRS;
>  
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index e6f86d5d97b9..a1c56a14c191 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -91,6 +91,8 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
>  		f2fs_sb_has_flexible_inline_xattr(sbi->sb) &&
>  		f2fs_has_inline_xattr(inode))
>  		F2FS_I(inode)->i_inline_xattr_size = sbi->inline_xattr_size;
> +	else
> +		F2FS_I(inode)->i_inline_xattr_size = 0;
>  
>  	if (test_opt(sbi, INLINE_DATA) && f2fs_may_inline_data(inode))
>  		set_inode_flag(inode, FI_INLINE_DATA);
> -- 
> 2.13.1.388.g69e6b9b4f4a9
