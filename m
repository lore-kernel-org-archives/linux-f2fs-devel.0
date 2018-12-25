From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: fix use-after-free issue with sbi->stat_info
Date: Tue, 25 Dec 2018 11:06:45 +0800
Message-ID: <0938f41e-53ed-6290-9b79-d221b1e64db6@huawei.com>
References: <1545656812-14695-1-git-send-email-stummala@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1545656812-14695-1-git-send-email-stummala@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sahitya Tummala <stummala@codeaurora.org>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/12/24 21:06, Sahitya Tummala wrote:
> iput() on sbi->node_inode can update sbi->stat_info
> in the below context, if the f2fs_write_checkpoint()
> has failed with error.
> 
> f2fs_balance_fs_bg+0x1ac/0x1ec
> f2fs_write_node_pages+0x4c/0x260
> do_writepages+0x80/0xbc
> __writeback_single_inode+0xdc/0x4ac
> writeback_single_inode+0x9c/0x144
> write_inode_now+0xc4/0xec
> iput+0x194/0x22c
> f2fs_put_super+0x11c/0x1e8
> generic_shutdown_super+0x70/0xf4
> kill_block_super+0x2c/0x5c
> kill_f2fs_super+0x44/0x50
> deactivate_locked_super+0x60/0x8c
> deactivate_super+0x68/0x74
> cleanup_mnt+0x40/0x78
> 
> Fix this by moving f2fs_destroy_stats() further below iput().
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> ---
>  fs/f2fs/super.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index e184ad4e..df41a3a 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1058,9 +1058,6 @@ static void f2fs_put_super(struct super_block *sb)
>  		f2fs_write_checkpoint(sbi, &cpc);
>  	}
>  
> -	/* f2fs_write_checkpoint can update stat informaion */
> -	f2fs_destroy_stats(sbi);

The code order in error path of fill_super is almost the same as the one of
put_super, could you please check that as well?

Thanks,

> -
>  	/*
>  	 * normally superblock is clean, so we need to release this.
>  	 * In addition, EIO will skip do checkpoint, we need this as well.
> @@ -1080,6 +1077,12 @@ static void f2fs_put_super(struct super_block *sb)
>  	iput(sbi->node_inode);
>  	iput(sbi->meta_inode);
>  
> +	/*
> +	 * iput() can update stat information, if f2fs_write_checkpoint()
> +	 * above failed with error.
> +	 */
> +	f2fs_destroy_stats(sbi);
> +
>  	/* destroy f2fs internal modules */
>  	f2fs_destroy_node_manager(sbi);
>  	f2fs_destroy_segment_manager(sbi);
> 
