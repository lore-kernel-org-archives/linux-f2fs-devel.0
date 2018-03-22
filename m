From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: no need to initialize zero value for GFP_F2FS_ZERO
Date: Thu, 22 Mar 2018 09:11:04 +0800
Message-ID: <2bd0b193-c2de-503e-0379-cf4abe645bd9@huawei.com>
References: <1521635131-137071-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521635131-137071-1-git-send-email-yunlong.song@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/3/21 20:25, Yunlong Song wrote:
> Since f2fs_inode_info is allocated with flag GFP_F2FS_ZERO, so we do not
> need to initialize zero value for its member any more.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  fs/f2fs/super.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 0c1fe9b..3a7fa03 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -825,9 +825,7 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
>  	init_once((void *) fi);
>  
>  	/* Initialize f2fs-specific inode info */
> -	atomic_set(&fi->dirty_pages, 0);

We'd better to keep atomic_set function as it is since how it initialize
.dirty_pages field is completely depend on locking sub module itself.

Thanks,

>  	fi->i_current_depth = 1;
> -	fi->i_advise = 0;
>  	init_rwsem(&fi->i_sem);
>  	INIT_LIST_HEAD(&fi->dirty_list);
>  	INIT_LIST_HEAD(&fi->gdirty_list);
> @@ -839,10 +837,6 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
>  	init_rwsem(&fi->i_mmap_sem);
>  	init_rwsem(&fi->i_xattr_sem);
>  
> -#ifdef CONFIG_QUOTA
> -	memset(&fi->i_dquot, 0, sizeof(fi->i_dquot));
> -	fi->i_reserved_quota = 0;
> -#endif
>  	/* Will be used by directory only */
>  	fi->i_dir_level = F2FS_SB(sb)->dir_level;
>  
> 
