From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove unneeded write checkpoint in
 recover_fsync_data
Date: Mon, 23 Sep 2013 09:53:49 +0800
Message-ID: <523F9F2D.1080501@cn.fujitsu.com>
References: <000101ceb768$a8b43ff0$fa1cbfd0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <000101ceb768$a8b43ff0$fa1cbfd0$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: Kim Jaegeuk <jaegeuk.kim@gmail.com>, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, =?GB2312?B?zLfmrQ==?= <shu.tan@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 09/22/2013 03:51 PM, Chao Yu wrote:

> Previously, recover_fsync_data still to write checkpoint when there is
> nothing to recover with normal umount image.
> It may reduce mount performance and flash memory lifetime, so let's remove
> it.
> 
> Signed-off-by: Tan Shu <shu.tan@samsung.com>
> Signed-off-by: Yu Chao <chao2.yu@samsung.com>
> ---
>  fs/f2fs/recovery.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> index 51ef5ee..6988e1b 100644
> --- a/fs/f2fs/recovery.c
> +++ b/fs/f2fs/recovery.c
> @@ -419,6 +419,7 @@ int recover_fsync_data(struct f2fs_sb_info *sbi)
>  {
>  	struct list_head inode_list;
>  	int err;
> +	int is_writecp = 0;

"need_writecp" may be more suitable.

Thanks,
Gu 

>  
>  	fsync_entry_slab = f2fs_kmem_cache_create("f2fs_fsync_inode_entry",
>  			sizeof(struct fsync_inode_entry), NULL);
> @@ -436,6 +437,8 @@ int recover_fsync_data(struct f2fs_sb_info *sbi)
>  	if (list_empty(&inode_list))
>  		goto out;
>  
> +	is_writecp = 1;
> +
>  	/* step #2: recover data */
>  	err = recover_data(sbi, &inode_list, CURSEG_WARM_NODE);
>  	BUG_ON(!list_empty(&inode_list));
> @@ -443,7 +446,7 @@ out:
>  	destroy_fsync_dnodes(&inode_list);
>  	kmem_cache_destroy(fsync_entry_slab);
>  	sbi->por_doing = 0;
> -	if (!err)
> +	if (!err && is_writecp)
>  		write_checkpoint(sbi, false);
>  	return err;
>  }
> ---
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
