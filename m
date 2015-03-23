From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [PATCH v2 1/2] f2fs: enable inline data by default
Date: Mon, 23 Mar 2015 15:25:45 +0800
Message-ID: <000c01d0653a$b6becad0$243c6070$@samsung.com>
References: <1427067840-20610-1-git-send-email-wanpeng.li@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <1427067840-20610-1-git-send-email-wanpeng.li@linux.intel.com>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: 'Wanpeng Li' <wanpeng.li@linux.intel.com>, 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: 'Changman Lee' <cm224.lee@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Wanpeng,

> -----Original Message-----
> From: Wanpeng Li [mailto:wanpeng.li@linux.intel.com]
> Sent: Monday, March 23, 2015 7:44 AM
> To: Jaegeuk Kim
> Cc: Changman Lee; Chao Yu; linux-f2fs-devel@lists.sourceforge.net;
> linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org; Wanpeng Li
> Subject: [PATCH v2 1/2] f2fs: enable inline data by default
> 
> Enable inline_data feature by default since it brings us better
> performance and space utilization and now has already stable.
> Add another option noinline_data to disable it during mount.
> 
> Suggested-by: Jaegeuk Kim <jaegeuk@kernel.org>
> Suggested-by: Chao Yu <chao2.yu@samsung.com>
> Signed-off-by: Wanpeng Li <wanpeng.li@linux.intel.com>
> ---
> v1 -> v2:
>  * retain inline_data option and enable it by default
>  * add another noinline_data option
> 
>  Documentation/filesystems/f2fs.txt | 2 ++
>  fs/f2fs/f2fs.h                     | 1 +
>  fs/f2fs/inline.c                   | 2 +-
>  fs/f2fs/super.c                    | 8 ++++++++
>  4 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
> index 48e2123..e9e750e 100644
> --- a/Documentation/filesystems/f2fs.txt
> +++ b/Documentation/filesystems/f2fs.txt
> @@ -144,6 +144,8 @@ extent_cache           Enable an extent cache based on rb-tree, it can cache
>                         as many as extent which map between contiguous logical
>                         address and physical address per inode, resulting in
>                         increasing the cache hit ratio.
> +noinline_data          Disable the inline data feature, inline data feature is
> +                       enabled by default.
> 
>  ================================================================================
>  DEBUGFS ENTRIES
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index f2909c6..6d4ceb3 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -51,6 +51,7 @@
>  #define F2FS_MOUNT_NOBARRIER		0x00000800
>  #define F2FS_MOUNT_FASTBOOT		0x00001000
>  #define F2FS_MOUNT_EXTENT_CACHE		0x00002000
> +#define F2FS_MOUNT_NOINLINE_DATA	0x00004000

May be we could reuse F2FS_MOUNT_INLINE_DATA for saving inline/noinline status
like F2FS_MOUNT_BG_GC.

e.g.
parse_options:
	case Opt_noinline_data:
		clear_opt(sbi, INLINE_DATA);
		break;

f2fs_show_options:
	if (test_opt(sbi, INLINE_DATA))
		seq_puts(seq, ",inline_data");
	else
		seq_puts(seq, ",noinline_data");

So we can avoid to show both options "inline_data,noinline_data" in ->show_options
if we mount with noinline_data, since this will make our user confused.

How do you think?

Thanks,

> 
>  #define clear_opt(sbi, option)	(sbi->mount_opt.opt &= ~F2FS_MOUNT_##option)
>  #define set_opt(sbi, option)	(sbi->mount_opt.opt |= F2FS_MOUNT_##option)
> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> index d3e0599..0363b57 100644
> --- a/fs/f2fs/inline.c
> +++ b/fs/f2fs/inline.c
> @@ -15,7 +15,7 @@
> 
>  bool f2fs_may_inline(struct inode *inode)
>  {
> -	if (!test_opt(F2FS_I_SB(inode), INLINE_DATA))
> +	if (!test_opt(F2FS_I_SB(inode), NOINLINE_DATA))
>  		return false;
> 
>  	if (f2fs_is_atomic_file(inode))
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index fc6857f..7b17795 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -58,6 +58,7 @@ enum {
>  	Opt_nobarrier,
>  	Opt_fastboot,
>  	Opt_extent_cache,
> +	Opt_noinline_data,
>  	Opt_err,
>  };
> 
> @@ -80,6 +81,7 @@ static match_table_t f2fs_tokens = {
>  	{Opt_nobarrier, "nobarrier"},
>  	{Opt_fastboot, "fastboot"},
>  	{Opt_extent_cache, "extent_cache"},
> +	{Opt_noinline_data, "noinline_data"},
>  	{Opt_err, NULL},
>  };
> 
> @@ -372,6 +374,9 @@ static int parse_options(struct super_block *sb, char *options)
>  		case Opt_extent_cache:
>  			set_opt(sbi, EXTENT_CACHE);
>  			break;
> +		case Opt_noinline_data:
> +			set_opt(sbi, NOINLINE_DATA);
> +			break;
>  		default:
>  			f2fs_msg(sb, KERN_ERR,
>  				"Unrecognized mount option \"%s\" or missing value",
> @@ -606,6 +611,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>  		seq_puts(seq, ",fastboot");
>  	if (test_opt(sbi, EXTENT_CACHE))
>  		seq_puts(seq, ",extent_cache");
> +	if (test_opt(sbi, NOINLINE_DATA))
> +		seq_puts(seq, ",noinline_data");
>  	seq_printf(seq, ",active_logs=%u", sbi->active_logs);
> 
>  	return 0;
> @@ -991,6 +998,7 @@ try_onemore:
>  	sbi->active_logs = NR_CURSEG_TYPE;
> 
>  	set_opt(sbi, BG_GC);
> +	set_opt(sbi, INLINE_DATA);
> 
>  #ifdef CONFIG_F2FS_FS_XATTR
>  	set_opt(sbi, XATTR_USER);
> --
> 1.9.1

