From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 08/13] f2fs: do checkpoint at f2fs_put_super
Date: Thu, 14 Aug 2014 10:57:10 +0800
Message-ID: <000401cfb76b$a3957b20$eac07160$@samsung.com>
References: <1407872967-26423-1-git-send-email-jaegeuk@kernel.org>
 <1407872967-26423-8-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1407872967-26423-8-git-send-email-jaegeuk@kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Wednesday, August 13, 2014 3:49 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 08/13] f2fs: do checkpoint at f2fs_put_super
> 
> The generic_shutdown_super calls sync_filesystem, evict_inode, and then
> f2fs_put_super. In f2fs_evict_inode, we remain some dirty inode information
> so we should release them at f2fs_put_super.
> 
> But normally, it's more reasonable to set its superblock as dirty when
> evict_inode is called.

After applying this patch, when we mount and then umount f2fs image without
modification, we will write checkpoint in f2fs_put_super even though we have
no more dirty data to sync, it's not needed.

"some dirty inode information" you mentioned is inode information in ->ino_root of
sbi, right?

Regards,
Yu

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/inode.c | 1 +
>  fs/f2fs/super.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index 2c39999..eeaf5aa 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -303,6 +303,7 @@ no_delete:
>  		add_dirty_inode(sbi, inode->i_ino, APPEND_INO);
>  	if (is_inode_flag_set(F2FS_I(inode), FI_UPDATE_WRITE))
>  		add_dirty_inode(sbi, inode->i_ino, UPDATE_INO);
> +	F2FS_SET_SB_DIRT(sbi);
>  out_clear:
>  	clear_inode(inode);
>  }
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 633315a..60e3554 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -432,7 +432,7 @@ static void f2fs_put_super(struct super_block *sb)
>  	stop_gc_thread(sbi);
> 
>  	/* We don't need to do checkpoint when it's clean */
> -	if (sbi->s_dirty && get_pages(sbi, F2FS_DIRTY_NODES))
> +	if (sbi->s_dirty)
>  		write_checkpoint(sbi, true);
> 
>  	iput(sbi->node_inode);
> --
> 1.8.5.2 (Apple Git-48)
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
