From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH v5] f2fs: add reserved blocks for root user
Date: Wed, 3 Jan 2018 22:02:24 -0800
Message-ID: <20180104060224.GA51247@jaegeuk-macbookpro.roam.corp.google.com>
References: <20171228021919.29397-1-jaegeuk@kernel.org>
 <20180101012953.GA81647@jaegeuk-macbookpro.roam.corp.google.com>
 <20180102192738.GB474@jaegeuk-macbookpro.roam.corp.google.com>
 <20180103022106.GB3995@jaegeuk-macbookpro.roam.corp.google.com>
 <a5e3b0f0-e6dc-66ab-1d89-ea6b371698c6@huawei.com>
 <20180103190624.GB30014@jaegeuk-macbookpro.roam.corp.google.com>
 <4955d0f7-5127-7e88-26d6-e9325c6a2cfe@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4955d0f7-5127-7e88-26d6-e9325c6a2cfe@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 01/04, Chao Yu wrote:
> On 2018/1/4 3:06, Jaegeuk Kim wrote:
> > On 01/03, Chao Yu wrote:
> >> On 2018/1/3 10:21, Jaegeuk Kim wrote:
> >>> This patch allows root to reserve some blocks via mount option.
> >>>
> >>> "-o reserve_root=N" means N x 4KB-sized blocks for root only.
> >>>
> >>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> >>> ---
> >>>
> >>> Change log from v4:
> >>>  - fix f_bfree in statfs
> >>
> >> Could you fix f_bfree calculation issue in another patch prior to this
> >> patch? That will be better for history tracking of patches or git bisect
> >> when backtracking issues.
> > 
> > I've sent out a new series for this.
> > 
> >>
> >> One more thing, should we move reserve_root_limit check to parse_option?
> > 
> > No, since we don't have sbi yet.
> > 
> >> now, it looks that during remount we can set root_reserved_blocks exceeding
> >> our defined limitation.
> > 
> > Oh, I missed the changelog that it won't be changed once getting the flag set.
> 
> If the flag is not set previously, and then we remount with that flag being
> set?

Right. Will fix.

> 
> Like:
> 
> mount -t f2fs /dev/xxx /mnt/
> mount -t f2fs -o remount,reserve_root=xxx /dev/xxx /mnt/
> 
> Thanks,
> 
> > 
> > Thanks,
> > 
> >>
> >> Thanks,
> >>
> >>>
> >>>  fs/f2fs/f2fs.h  | 26 ++++++++++++++++++++++----
> >>>  fs/f2fs/super.c | 34 +++++++++++++++++++++++++++++-----
> >>>  fs/f2fs/sysfs.c |  3 ++-
> >>>  3 files changed, 53 insertions(+), 10 deletions(-)
> >>>
> >>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >>> index 07e03990420b..a0e8eec23125 100644
> >>> --- a/fs/f2fs/f2fs.h
> >>> +++ b/fs/f2fs/f2fs.h
> >>> @@ -95,6 +95,7 @@ extern char *fault_name[FAULT_MAX];
> >>>  #define F2FS_MOUNT_PRJQUOTA		0x00200000
> >>>  #define F2FS_MOUNT_QUOTA		0x00400000
> >>>  #define F2FS_MOUNT_INLINE_XATTR_SIZE	0x00800000
> >>> +#define F2FS_MOUNT_RESERVE_ROOT		0x01000000
> >>>  
> >>>  #define clear_opt(sbi, option)	((sbi)->mount_opt.opt &= ~F2FS_MOUNT_##option)
> >>>  #define set_opt(sbi, option)	((sbi)->mount_opt.opt |= F2FS_MOUNT_##option)
> >>> @@ -1105,6 +1106,7 @@ struct f2fs_sb_info {
> >>>  	block_t last_valid_block_count;		/* for recovery */
> >>>  	block_t reserved_blocks;		/* configurable reserved blocks */
> >>>  	block_t current_reserved_blocks;	/* current reserved blocks */
> >>> +	block_t root_reserved_blocks;		/* root reserved blocks */
> >>>  
> >>>  	unsigned int nquota_files;		/* # of quota sysfile */
> >>>  
> >>> @@ -1554,6 +1556,12 @@ static inline bool f2fs_has_xattr_block(unsigned int ofs)
> >>>  	return ofs == XATTR_NODE_OFFSET;
> >>>  }
> >>>  
> >>> +static inline block_t reserve_root_limit(struct f2fs_sb_info *sbi)
> >>> +{
> >>> +	/* limit is 0.2% */
> >>> +	return (sbi->user_block_count << 1) / 1000;
> >>> +}
> >>> +
> >>>  static inline void f2fs_i_blocks_write(struct inode *, block_t, bool, bool);
> >>>  static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
> >>>  				 struct inode *inode, blkcnt_t *count)
> >>> @@ -1583,11 +1591,17 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
> >>>  	sbi->total_valid_block_count += (block_t)(*count);
> >>>  	avail_user_block_count = sbi->user_block_count -
> >>>  					sbi->current_reserved_blocks;
> >>> +
> >>> +	if (!(test_opt(sbi, RESERVE_ROOT) && capable(CAP_SYS_RESOURCE)))
> >>> +		avail_user_block_count -= sbi->root_reserved_blocks;
> >>> +
> >>>  	if (unlikely(sbi->total_valid_block_count > avail_user_block_count)) {
> >>>  		diff = sbi->total_valid_block_count - avail_user_block_count;
> >>> +		if (diff > *count)
> >>> +			diff = *count;
> >>>  		*count -= diff;
> >>>  		release = diff;
> >>> -		sbi->total_valid_block_count = avail_user_block_count;
> >>> +		sbi->total_valid_block_count -= diff;
> >>>  		if (!*count) {
> >>>  			spin_unlock(&sbi->stat_lock);
> >>>  			percpu_counter_sub(&sbi->alloc_valid_block_count, diff);
> >>> @@ -1776,9 +1790,13 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
> >>>  
> >>>  	spin_lock(&sbi->stat_lock);
> >>>  
> >>> -	valid_block_count = sbi->total_valid_block_count + 1;
> >>> -	if (unlikely(valid_block_count + sbi->current_reserved_blocks >
> >>> -						sbi->user_block_count)) {
> >>> +	valid_block_count = sbi->total_valid_block_count +
> >>> +					sbi->current_reserved_blocks + 1;
> >>> +
> >>> +	if (!(test_opt(sbi, RESERVE_ROOT) && capable(CAP_SYS_RESOURCE)))
> >>> +		valid_block_count += sbi->root_reserved_blocks;
> >>> +
> >>> +	if (unlikely(valid_block_count > sbi->user_block_count)) {
> >>>  		spin_unlock(&sbi->stat_lock);
> >>>  		goto enospc;
> >>>  	}
> >>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> >>> index 5c6a02b558f0..e814340bc2f0 100644
> >>> --- a/fs/f2fs/super.c
> >>> +++ b/fs/f2fs/super.c
> >>> @@ -107,6 +107,7 @@ enum {
> >>>  	Opt_noextent_cache,
> >>>  	Opt_noinline_data,
> >>>  	Opt_data_flush,
> >>> +	Opt_reserve_root,
> >>>  	Opt_mode,
> >>>  	Opt_io_size_bits,
> >>>  	Opt_fault_injection,
> >>> @@ -157,6 +158,7 @@ static match_table_t f2fs_tokens = {
> >>>  	{Opt_noextent_cache, "noextent_cache"},
> >>>  	{Opt_noinline_data, "noinline_data"},
> >>>  	{Opt_data_flush, "data_flush"},
> >>> +	{Opt_reserve_root, "reserve_root=%u"},
> >>>  	{Opt_mode, "mode=%s"},
> >>>  	{Opt_io_size_bits, "io_bits=%u"},
> >>>  	{Opt_fault_injection, "fault_injection=%u"},
> >>> @@ -488,6 +490,18 @@ static int parse_options(struct super_block *sb, char *options)
> >>>  		case Opt_data_flush:
> >>>  			set_opt(sbi, DATA_FLUSH);
> >>>  			break;
> >>> +		case Opt_reserve_root:
> >>> +			if (args->from && match_int(args, &arg))
> >>> +				return -EINVAL;
> >>> +			if (test_opt(sbi, RESERVE_ROOT)) {
> >>> +				f2fs_msg(sb, KERN_INFO,
> >>> +					"Preserve previous reserve_root=%u",
> >>> +					sbi->root_reserved_blocks);
> >>> +			} else {
> >>> +				sbi->root_reserved_blocks = arg;
> >>> +				set_opt(sbi, RESERVE_ROOT);
> >>> +			}
> >>> +			break;
> >>>  		case Opt_mode:
> >>>  			name = match_strdup(&args[0]);
> >>>  
> >>> @@ -994,21 +1008,21 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
> >>>  	struct super_block *sb = dentry->d_sb;
> >>>  	struct f2fs_sb_info *sbi = F2FS_SB(sb);
> >>>  	u64 id = huge_encode_dev(sb->s_bdev->bd_dev);
> >>> -	block_t total_count, user_block_count, start_count, ovp_count;
> >>> +	block_t total_count, user_block_count, start_count;
> >>>  	u64 avail_node_count;
> >>>  
> >>>  	total_count = le64_to_cpu(sbi->raw_super->block_count);
> >>>  	user_block_count = sbi->user_block_count;
> >>>  	start_count = le32_to_cpu(sbi->raw_super->segment0_blkaddr);
> >>> -	ovp_count = SM_I(sbi)->ovp_segments << sbi->log_blocks_per_seg;
> >>>  	buf->f_type = F2FS_SUPER_MAGIC;
> >>>  	buf->f_bsize = sbi->blocksize;
> >>>  
> >>>  	buf->f_blocks = total_count - start_count;
> >>> -	buf->f_bfree = user_block_count - valid_user_blocks(sbi) + ovp_count;
> >>> -	buf->f_bavail = user_block_count - valid_user_blocks(sbi) -
> >>> +	buf->f_bfree = user_block_count - valid_user_blocks(sbi) -
> >>>  						sbi->current_reserved_blocks;
> >>> -
> >>> +	buf->f_bavail = user_block_count - valid_user_blocks(sbi) -
> >>> +						sbi->current_reserved_blocks -
> >>> +						sbi->root_reserved_blocks;
> >>>  	avail_node_count = sbi->total_node_count - sbi->nquota_files -
> >>>  						F2FS_RESERVED_NODE_NUM;
> >>>  
> >>> @@ -1136,6 +1150,9 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
> >>>  	else if (test_opt(sbi, LFS))
> >>>  		seq_puts(seq, "lfs");
> >>>  	seq_printf(seq, ",active_logs=%u", sbi->active_logs);
> >>> +	if (test_opt(sbi, RESERVE_ROOT))
> >>> +		seq_printf(seq, ",reserve_root=%u",
> >>> +				sbi->root_reserved_blocks);
> >>>  	if (F2FS_IO_SIZE_BITS(sbi))
> >>>  		seq_printf(seq, ",io_size=%uKB", F2FS_IO_SIZE_KB(sbi));
> >>>  #ifdef CONFIG_F2FS_FAULT_INJECTION
> >>> @@ -2571,6 +2588,13 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
> >>>  	sbi->reserved_blocks = 0;
> >>>  	sbi->current_reserved_blocks = 0;
> >>>  
> >>> +	if (test_opt(sbi, RESERVE_ROOT) &&
> >>> +		sbi->root_reserved_blocks > reserve_root_limit(sbi)) {
> >>> +		sbi->root_reserved_blocks = reserve_root_limit(sbi);
> >>> +		f2fs_msg(sb, KERN_INFO,
> >>> +			"Reduce reserved blocks for root = %u\n",
> >>> +				sbi->root_reserved_blocks);
> >>> +	}
> >>>  	for (i = 0; i < NR_INODE_TYPE; i++) {
> >>>  		INIT_LIST_HEAD(&sbi->inode_list[i]);
> >>>  		spin_lock_init(&sbi->inode_lock[i]);
> >>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> >>> index 93c3364250dd..ab6028c332aa 100644
> >>> --- a/fs/f2fs/sysfs.c
> >>> +++ b/fs/f2fs/sysfs.c
> >>> @@ -162,7 +162,8 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
> >>>  #endif
> >>>  	if (a->struct_type == RESERVED_BLOCKS) {
> >>>  		spin_lock(&sbi->stat_lock);
> >>> -		if (t > (unsigned long)sbi->user_block_count) {
> >>> +		if (t > (unsigned long)(sbi->user_block_count -
> >>> +					sbi->root_reserved_blocks)) {
> >>>  			spin_unlock(&sbi->stat_lock);
> >>>  			return -EINVAL;
> >>>  		}
> >>>
> > 
> > .
> > 
