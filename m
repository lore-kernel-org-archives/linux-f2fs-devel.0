From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 7/8] f2fs: introduce new option for controlling
 data flush
Date: Wed, 16 Dec 2015 00:07:04 +0800
Message-ID: <56703AA8.3000607@kernel.org>
References: <00fa01d136fa$7c028980$74079c80$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <00fa01d136fa$7c028980$74079c80$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

The 7, 8 patches could not be merged on current dev-test branch due to I
generate them on incorrect base line. I will rebase and resent them tomorrow,
sorry for the noisy.

Thanks,

On 12/15/15 1:35 PM, Chao Yu wrote:
> Add a new option 'data_flush' to enable/disable data flush functionality
> in checkpoint.
> 
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  Documentation/filesystems/f2fs.txt | 2 ++
>  fs/f2fs/checkpoint.c               | 2 +-
>  fs/f2fs/f2fs.h                     | 1 +
>  fs/f2fs/super.c                    | 7 +++++++
>  4 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
> index 8088bd9..727373e 100644
> --- a/Documentation/filesystems/f2fs.txt
> +++ b/Documentation/filesystems/f2fs.txt
> @@ -151,6 +151,8 @@ noextent_cache         Disable an extent cache based on rb-tree explicitly, see
>                         the above extent_cache mount option.
>  noinline_data          Disable the inline data feature, inline data feature is
>                         enabled by default.
> +data_flush             Enable data flushing during checkpoint in order to
> +                       persist data of regular and symlink.
>  
>  ================================================================================
>  DEBUGFS ENTRIES
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index a73909c..2fdf271 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -855,7 +855,7 @@ static int block_operations(struct f2fs_sb_info *sbi)
>  
>  retry_flush_datas:
>  	/* write all the dirty data pages */
> -	if (get_pages(sbi, F2FS_DIRTY_DATAS)) {
> +	if (test_opt(sbi, DATA_FLUSH) && get_pages(sbi, F2FS_DIRTY_DATAS)) {
>  		sync_dirty_inodes(sbi, FILE_INODE);
>  		if (unlikely(f2fs_cp_error(sbi))) {
>  			err = -EIO;
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 4d44732..ee1f0a8 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -54,6 +54,7 @@
>  #define F2FS_MOUNT_FASTBOOT		0x00001000
>  #define F2FS_MOUNT_EXTENT_CACHE		0x00002000
>  #define F2FS_MOUNT_FORCE_FG_GC		0x00004000
> +#define F2FS_MOUNT_DATA_FLUSH		0x00008000
>  
>  #define clear_opt(sbi, option)	(sbi->mount_opt.opt &= ~F2FS_MOUNT_##option)
>  #define set_opt(sbi, option)	(sbi->mount_opt.opt |= F2FS_MOUNT_##option)
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 051bce6..694e092 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -67,6 +67,7 @@ enum {
>  	Opt_extent_cache,
>  	Opt_noextent_cache,
>  	Opt_noinline_data,
> +	Opt_data_flush,
>  	Opt_nodiscard,
>  	Opt_err,
>  };
> @@ -92,6 +93,7 @@ static match_table_t f2fs_tokens = {
>  	{Opt_extent_cache, "extent_cache"},
>  	{Opt_noextent_cache, "noextent_cache"},
>  	{Opt_noinline_data, "noinline_data"},
> +	{Opt_data_flush, "data_flush"},
>  	{Opt_nodiscard, "nodiscard"},
>  	{Opt_err, NULL},
>  };
> @@ -411,6 +413,9 @@ static int parse_options(struct super_block *sb, char *options)
>  		case Opt_noinline_data:
>  			clear_opt(sbi, INLINE_DATA);
>  			break;
> +		case Opt_data_flush:
> +			clear_opt(sbi, DATA_FLUSH);
> +			break;
>  		default:
>  			f2fs_msg(sb, KERN_ERR,
>  				"Unrecognized mount option \"%s\" or missing value",
> @@ -694,6 +699,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>  		seq_puts(seq, ",extent_cache");
>  	else
>  		seq_puts(seq, ",noextent_cache");
> +	if (test_opt(sbi, DATA_FLUSH))
> +		seq_puts(seq, ",data_flush");
>  	seq_printf(seq, ",active_logs=%u", sbi->active_logs);
>  
>  	return 0;
> 
