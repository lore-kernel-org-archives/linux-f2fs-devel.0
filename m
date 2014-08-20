From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 2/2] f2fs: trigger release_dirty_inode in
	f2fs_put_super
Date: Wed, 20 Aug 2014 17:33:58 +0800
Message-ID: <007a01cfbc5a$035849f0$0a08ddd0$@samsung.com>
References: <1408467177-69746-1-git-send-email-jaegeuk@kernel.org>
 <1408467177-69746-2-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <1408467177-69746-2-git-send-email-jaegeuk@kernel.org>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Wednesday, August 20, 2014 12:53 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 2/2] f2fs: trigger release_dirty_inode in f2fs_put_super
> 
> The generic_shutdown_super calls sync_filesystem, evict_inode, and then
> f2fs_put_super. In f2fs_evict_inode, we remain some dirty inode information
> so we should release them at f2fs_put_super.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Looks good to me now, add this please:

Reviewed-by: Chao Yu <chao2.yu@samsung.com>

> ---
>  fs/f2fs/checkpoint.c | 2 +-
>  fs/f2fs/super.c      | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 7e1c13b..f14af91 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -348,7 +348,7 @@ bool exist_written_data(struct f2fs_sb_info *sbi, nid_t ino, int mode)
>  	return e ? true : false;
>  }
> 
> -static void release_dirty_inode(struct f2fs_sb_info *sbi)
> +void release_dirty_inode(struct f2fs_sb_info *sbi)
>  {
>  	struct ino_entry *e, *tmp;
>  	int i;
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 60e3554..7a54779 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -435,6 +435,9 @@ static void f2fs_put_super(struct super_block *sb)
>  	if (sbi->s_dirty)
>  		write_checkpoint(sbi, true);
> 
> +	/* normally superblock is clean, so we need to release this */
> +	release_dirty_inode(sbi);
> +
>  	iput(sbi->node_inode);
>  	iput(sbi->meta_inode);
> 
> --
> 1.8.5.2 (Apple Git-48)
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

