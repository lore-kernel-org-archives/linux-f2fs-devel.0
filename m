From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 3/3] f2fs: introduce __f2fs_commit_super
Date: Tue, 15 Dec 2015 14:19:47 -0800
Message-ID: <20151215221947.GE66113@jaegeuk.local>
References: <010601d13719$fb952260$f2bf6720$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <010601d13719$fb952260$f2bf6720$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

On Tue, Dec 15, 2015 at 05:20:50PM +0800, Chao Yu wrote:
> Introduce __f2fs_commit_super to include duplicated codes in
> f2fs_commit_super for cleanup.
> 
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  fs/f2fs/super.c | 28 +++++++++++++---------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 2d4fed8..56a160a 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1201,14 +1201,13 @@ next:
>  	return 0;
>  }
>  
> -int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
> +int __f2fs_commit_super(struct f2fs_sb_info *sbi, int block)
>  {
>  	struct f2fs_super_block *super = F2FS_RAW_SUPER(sbi);
>  	struct buffer_head *bh;
>  	int err;
>  
> -	/* write back-up superblock first */
> -	bh = sb_getblk(sbi->sb, sbi->valid_super_block ? 0 : 1);
> +	bh = sb_getblk(sbi->sb, block);
>  	if (!bh)
>  		return -EIO;
>  
> @@ -1222,23 +1221,22 @@ int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
>  	err = __sync_dirty_buffer(bh, WRITE_FLUSH_FUA);
>  	brelse(bh);
>  
> +	return err;
> +}
> +
> +int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
> +{
> +	int err;
> +
> +	/* write back-up superblock first */
> +	err = __f2fs_commit_super(sbi, sbi->valid_super_block ? 0 : 1);
> +
>  	/* if we are in recovery path, skip writing valid superblock */
>  	if (recover || err)
>  		return err;
>  
> -	bh = sb_getblk(sbi->sb, sbi->valid_super_block);
> -	if (!bh)
> -		return -EIO;
> -
>  	/* write current valid superblock */
> -	lock_buffer(bh);
> -	memcpy(bh->b_data + F2FS_SUPER_OFFSET, super, sizeof(*super));
> -	set_buffer_uptodate(bh);
> -	set_buffer_dirty(bh);
> -	unlock_buffer(bh);
> -
> -	err = __sync_dirty_buffer(bh, WRITE_FLUSH_FUA);
> -	brelse(bh);
> +	err = __f2fs_commit_super(sbi, sbi->valid_super_block);

I just merged this patch with:

	return __f2fs_commit_super().

Thanks,

>  
>  	return err;
>  }
> -- 
> 2.6.3
> 
