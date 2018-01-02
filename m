From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v3] f2fs: add reserved blocks for root user
Date: Tue, 2 Jan 2018 14:25:55 +0800
Message-ID: <3956a904-914e-6233-ab2c-c92db587537e@huawei.com>
References: <20171228021919.29397-1-jaegeuk@kernel.org>
 <20180101012953.GA81647@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eWG1X-0007EM-6k
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 02 Jan 2018 06:26:07 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eWG1V-0000a5-2V
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 02 Jan 2018 06:26:07 +0000
In-Reply-To: <20180101012953.GA81647@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2018/1/1 9:29, Jaegeuk Kim wrote:
> This patch allows root to reserve some blocks via mount option.
> 
> "-o reserve_root=N" means N x 4KB-sized blocks for root only.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
> 
> Change log from v2:
>  - wrong submission. :P
> 
>  fs/f2fs/f2fs.h  | 26 ++++++++++++++++++++++----
>  fs/f2fs/super.c | 26 +++++++++++++++++++++++---
>  fs/f2fs/sysfs.c |  3 ++-
>  3 files changed, 47 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 5f7f42267221..123d875f7293 100644
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
> @@ -1110,6 +1111,7 @@ struct f2fs_sb_info {
>  	block_t last_valid_block_count;		/* for recovery */
>  	block_t reserved_blocks;		/* configurable reserved blocks */
>  	block_t current_reserved_blocks;	/* current reserved blocks */
> +	block_t root_reserved_blocks;		/* root reserved blocks */
>  
>  	unsigned int nquota_files;		/* # of quota sysfile */
>  
> @@ -1562,6 +1564,12 @@ static inline bool f2fs_has_xattr_block(unsigned int ofs)
>  	return ofs == XATTR_NODE_OFFSET;
>  }
>  
> +static inline block_t reserve_root_limit(struct f2fs_sb_info *sbi)
> +{
> +	/* limit is 0.2% */

Should be 2% according to below calculation?

> +	return (sbi->user_block_count << 1) / 100;
> +}
> +
>  static inline void f2fs_i_blocks_write(struct inode *, block_t, bool, bool);
>  static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
>  				 struct inode *inode, blkcnt_t *count)
> @@ -1591,11 +1599,17 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
>  	sbi->total_valid_block_count += (block_t)(*count);
>  	avail_user_block_count = sbi->user_block_count -
>  					sbi->current_reserved_blocks;
> +
> +	if (!(test_opt(sbi, RESERVE_ROOT) && capable(CAP_SYS_RESOURCE)))

How about adding uid & gid verification also like ext4?

As this is a mount option, in ->remount_fs, we should consider to recover
original reserved block number if we encounter some error during remount.

Thanks,

> +		avail_user_block_count -= sbi->root_reserved_blocks;
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
> @@ -1784,9 +1798,13 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
>  
>  	spin_lock(&sbi->stat_lock);
>  
> -	valid_block_count = sbi->total_valid_block_count + 1;
> -	if (unlikely(valid_block_count + sbi->current_reserved_blocks >
> -						sbi->user_block_count)) {
> +	valid_block_count = sbi->total_valid_block_count +
> +					sbi->current_reserved_blocks + 1;
> +
> +	if (!(test_opt(sbi, RESERVE_ROOT) && capable(CAP_SYS_RESOURCE)))
> +		valid_block_count += sbi->root_reserved_blocks;
> +
> +	if (unlikely(valid_block_count > sbi->user_block_count)) {
>  		spin_unlock(&sbi->stat_lock);
>  		goto enospc;
>  	}
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index cb876d905ca5..9221b013db98 100644
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
> @@ -488,6 +490,12 @@ static int parse_options(struct super_block *sb, char *options)
>  		case Opt_data_flush:
>  			set_opt(sbi, DATA_FLUSH);
>  			break;
> +		case Opt_reserve_root:
> +			if (args->from && match_int(args, &arg))
> +				return -EINVAL;
> +			sbi->root_reserved_blocks = arg;
> +			set_opt(sbi, RESERVE_ROOT);
> +			break;
>  		case Opt_mode:
>  			name = match_strdup(&args[0]);
>  
> @@ -1005,10 +1013,12 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
>  	buf->f_bsize = sbi->blocksize;
>  
>  	buf->f_blocks = total_count - start_count;
> -	buf->f_bfree = user_block_count - valid_user_blocks(sbi) + ovp_count;
> +	buf->f_bfree = user_block_count - valid_user_blocks(sbi) -
> +						sbi->current_reserved_blocks +
> +						sbi->root_reserved_blocks;
>  	buf->f_bavail = user_block_count - valid_user_blocks(sbi) -
> -						sbi->current_reserved_blocks;
> -
> +						sbi->current_reserved_blocks -
> +						sbi->root_reserved_blocks;
>  	avail_node_count = sbi->total_node_count - sbi->nquota_files -
>  						F2FS_RESERVED_NODE_NUM;
>  
> @@ -1136,6 +1146,9 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>  	else if (test_opt(sbi, LFS))
>  		seq_puts(seq, "lfs");
>  	seq_printf(seq, ",active_logs=%u", sbi->active_logs);
> +	if (test_opt(sbi, RESERVE_ROOT))
> +		seq_printf(seq, ",reserve_root=%u",
> +				sbi->root_reserved_blocks);
>  	if (F2FS_IO_SIZE_BITS(sbi))
>  		seq_printf(seq, ",io_size=%uKB", F2FS_IO_SIZE_KB(sbi));
>  #ifdef CONFIG_F2FS_FAULT_INJECTION
> @@ -2571,6 +2584,13 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  	sbi->reserved_blocks = 0;
>  	sbi->current_reserved_blocks = 0;
>  
> +	if (test_opt(sbi, RESERVE_ROOT) &&
> +		sbi->root_reserved_blocks > reserve_root_limit(sbi)) {
> +		sbi->root_reserved_blocks = reserve_root_limit(sbi);
> +		f2fs_msg(sb, KERN_INFO,
> +			"Reduce reserved blocks for root = %u\n",
> +				sbi->root_reserved_blocks);
> +	}
>  	for (i = 0; i < NR_INODE_TYPE; i++) {
>  		INIT_LIST_HEAD(&sbi->inode_list[i]);
>  		spin_lock_init(&sbi->inode_lock[i]);
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 7e15cbc5b8e1..41887e6ec1b3 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -162,7 +162,8 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
>  #endif
>  	if (a->struct_type == RESERVED_BLOCKS) {
>  		spin_lock(&sbi->stat_lock);
> -		if (t > (unsigned long)sbi->user_block_count) {
> +		if (t > (unsigned long)(sbi->user_block_count -
> +					sbi->root_reserved_blocks)) {
>  			spin_unlock(&sbi->stat_lock);
>  			return -EINVAL;
>  		}
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
