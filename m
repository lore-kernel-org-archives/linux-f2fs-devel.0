From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: add reserved blocks for root user
Date: Fri, 29 Dec 2017 15:55:44 +0800
Message-ID: <1d6b66be-121e-8654-15a6-0cae3d4a7ba9@huawei.com>
References: <20171228021919.29397-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171228021919.29397-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/12/28 10:19, Jaegeuk Kim wrote:
> This patch allows root to reserve some blocks via mount option.
> 
> "-o reserve_root=N" means N x 4KB-sized blocks for root only.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/f2fs.h  | 25 ++++++++++++++++++++-----
>  fs/f2fs/super.c | 24 ++++++++++++++++++++++--
>  fs/f2fs/sysfs.c |  5 ++++-
>  3 files changed, 46 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 5bcd530dbae0..e2d859672147 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -95,6 +95,7 @@ extern char *fault_name[FAULT_MAX];
>  #define F2FS_MOUNT_PRJQUOTA		0x00200000
>  #define F2FS_MOUNT_QUOTA		0x00400000
>  #define F2FS_MOUNT_INLINE_XATTR_SIZE	0x00800000
> +#define F2FS_MOUNT_RESERVE_ROOT		0x01000000
>  
>  #define clear_opt(sbi, option)	((sbi)->mount_opt.opt &= ~F2FS_MOUNT_##option)
>  #define set_opt(sbi, option)	((sbi)->mount_opt.opt |= F2FS_MOUNT_##option)
> @@ -1557,6 +1558,12 @@ static inline bool f2fs_has_xattr_block(unsigned int ofs)
>  	return ofs == XATTR_NODE_OFFSET;
>  }
>  
> +static inline block_t reserve_root_limit(struct f2fs_sb_info *sbi)
> +{
> +	/* limit is 0.2% */
> +	return (sbi->user_block_count << 1) / 100;
> +}
> +
>  static inline void f2fs_i_blocks_write(struct inode *, block_t, bool, bool);
>  static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
>  				 struct inode *inode, blkcnt_t *count)
> @@ -1584,13 +1591,18 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
>  
>  	spin_lock(&sbi->stat_lock);
>  	sbi->total_valid_block_count += (block_t)(*count);
> -	avail_user_block_count = sbi->user_block_count -
> -					sbi->current_reserved_blocks;
> +	avail_user_block_count = sbi->user_block_count;
> +
> +	if (!(test_opt(sbi, RESERVE_ROOT) && capable(CAP_SYS_RESOURCE)))

How about adding uid & gid verification also like ext4?

> +		avail_user_block_count -= sbi->current_reserved_blocks;
> +
>  	if (unlikely(sbi->total_valid_block_count > avail_user_block_count)) {
>  		diff = sbi->total_valid_block_count - avail_user_block_count;
> +		if (diff > *count)
> +			diff = *count;
>  		*count -= diff;
>  		release = diff;
> -		sbi->total_valid_block_count = avail_user_block_count;
> +		sbi->total_valid_block_count -= diff;
>  		if (!*count) {
>  			spin_unlock(&sbi->stat_lock);
>  			percpu_counter_sub(&sbi->alloc_valid_block_count, diff);
> @@ -1780,8 +1792,11 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
>  	spin_lock(&sbi->stat_lock);
>  
>  	valid_block_count = sbi->total_valid_block_count + 1;
> -	if (unlikely(valid_block_count + sbi->current_reserved_blocks >
> -						sbi->user_block_count)) {
> +
> +	if (!(test_opt(sbi, RESERVE_ROOT) && capable(CAP_SYS_RESOURCE)))
> +		valid_block_count += sbi->current_reserved_blocks;
> +
> +	if (unlikely(valid_block_count > sbi->user_block_count)) {
>  		spin_unlock(&sbi->stat_lock);
>  		goto enospc;
>  	}
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index cb876d905ca5..a19e9f7bd908 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -107,6 +107,7 @@ enum {
>  	Opt_noextent_cache,
>  	Opt_noinline_data,
>  	Opt_data_flush,
> +	Opt_reserve_root,
>  	Opt_mode,
>  	Opt_io_size_bits,
>  	Opt_fault_injection,
> @@ -157,6 +158,7 @@ static match_table_t f2fs_tokens = {
>  	{Opt_noextent_cache, "noextent_cache"},
>  	{Opt_noinline_data, "noinline_data"},
>  	{Opt_data_flush, "data_flush"},
> +	{Opt_reserve_root, "reserve_root=%u"},
>  	{Opt_mode, "mode=%s"},
>  	{Opt_io_size_bits, "io_bits=%u"},
>  	{Opt_fault_injection, "fault_injection=%u"},
> @@ -488,6 +490,14 @@ static int parse_options(struct super_block *sb, char *options)
>  		case Opt_data_flush:
>  			set_opt(sbi, DATA_FLUSH);
>  			break;
> +		case Opt_reserve_root:
> +			if (args->from && match_int(args, &arg))
> +				return -EINVAL;
> +			if (sbi->current_reserved_blocks > arg)
> +				return -EINVAL;
> +			sbi->current_reserved_blocks = arg;

Previously, we have supported to reserve blocks in fs layer to adjust
over-provision ratio dynamically by configuring sysfs interface, which can
be used for reserving space of low level storage device for performance or
flash lifetime.

I think reserve blocks for root user is another requirement which is
different from above one, so I hope we can keep both of these two features
available and usable, in order to keep previous one's backward
compatibility and also try to support more various features in f2fs.

Thanks,

> +			set_opt(sbi, RESERVE_ROOT);
> +			break;
>  		case Opt_mode:
>  			name = match_strdup(&args[0]);
>  
> @@ -1006,6 +1016,8 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
>  
>  	buf->f_blocks = total_count - start_count;
>  	buf->f_bfree = user_block_count - valid_user_blocks(sbi) + ovp_count;
> +	if (test_opt(sbi, RESERVE_ROOT))
> +		buf->f_bfree += sbi->current_reserved_blocks;
>  	buf->f_bavail = user_block_count - valid_user_blocks(sbi) -
>  						sbi->current_reserved_blocks;
>  
> @@ -1136,6 +1148,9 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>  	else if (test_opt(sbi, LFS))
>  		seq_puts(seq, "lfs");
>  	seq_printf(seq, ",active_logs=%u", sbi->active_logs);
> +	if (test_opt(sbi, RESERVE_ROOT))
> +		seq_printf(seq, ",reserve_root=%u",
> +				sbi->current_reserved_blocks);
>  	if (F2FS_IO_SIZE_BITS(sbi))
>  		seq_printf(seq, ",io_size=%uKB", F2FS_IO_SIZE_KB(sbi));
>  #ifdef CONFIG_F2FS_FAULT_INJECTION
> @@ -2569,8 +2584,13 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  				le64_to_cpu(sbi->ckpt->valid_block_count);
>  	sbi->last_valid_block_count = sbi->total_valid_block_count;
>  	sbi->reserved_blocks = 0;
> -	sbi->current_reserved_blocks = 0;
> -
> +	if (test_opt(sbi, RESERVE_ROOT) &&
> +		sbi->current_reserved_blocks > reserve_root_limit(sbi)) {
> +		sbi->current_reserved_blocks = reserve_root_limit(sbi);
> +		f2fs_msg(sb, KERN_INFO,
> +			"Reduce reserved blocks for root = %u\n",
> +				sbi->current_reserved_blocks);
> +	}
>  	for (i = 0; i < NR_INODE_TYPE; i++) {
>  		INIT_LIST_HEAD(&sbi->inode_list[i]);
>  		spin_lock_init(&sbi->inode_lock[i]);
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 987b2736348c..33e159491b48 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -162,7 +162,10 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
>  #endif
>  	if (a->struct_type == RESERVED_BLOCKS) {
>  		spin_lock(&sbi->stat_lock);
> -		if (t > (unsigned long)sbi->user_block_count) {
> +		if (t > (unsigned long)sbi->user_block_count ||
> +			(test_opt(sbi, RESERVE_ROOT) &&
> +				(t < sbi->current_reserved_blocks ||
> +				t > reserve_root_limit(sbi)))) {
>  			spin_unlock(&sbi->stat_lock);
>  			return -EINVAL;
>  		}
> 
