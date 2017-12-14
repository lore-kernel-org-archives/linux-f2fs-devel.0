From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add an ioctl to disable GC for
 specific file
Date: Thu, 14 Dec 2017 11:50:27 -0800
Message-ID: <20171214195027.GC35234@jaegeuk-macbookpro.roam.corp.google.com>
References: <20171208051555.76998-1-jaegeuk@kernel.org>
 <20171208193723.GA87676@jaegeuk-macbookpro.roam.corp.google.com>
 <ae9a4c6b-f277-b03c-f3cf-ef45a49de22f@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ae9a4c6b-f277-b03c-f3cf-ef45a49de22f@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 12/12, Chao Yu wrote:
> Hi Jaegeuk,
> 
> On 2017/12/9 3:37, Jaegeuk Kim wrote:
> > Change log from v1:
> >  - fix bug in error handling of ioctl 
> > 
> >>From b905e03d8aad7d25ecaf9bde05411a68d3d2460e Mon Sep 17 00:00:00 2001
> > From: Jaegeuk Kim <jaegeuk@kernel.org>
> > Date: Thu, 7 Dec 2017 16:25:39 -0800
> > Subject: [PATCH] f2fs: add an ioctl to disable GC for specific file
> > 
> > This patch gives a flag to disable GC on given file, which would be useful, when
> > user wants to keep its block map.
> 
> Could you add some description about in which scenario userspace application
> can use this ioctl, otherwise than android, other developers can get hint about
> the usage of this interface, maybe later it can be used more wildly. ;)

The usecase would be somewhat hacky tho, it looks like 1) building a block map
through fibmap, 2) storing the map in another partition, 3) using the map to
overwrite data contents directly by low-level tools. In that case, we have to
keep its block locations.

Thanks,

> 
> Thanks,
> 
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/f2fs.h          | 17 ++++++++++++++++
> >  fs/f2fs/file.c          | 54 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  fs/f2fs/gc.c            | 11 ++++++++++
> >  fs/f2fs/gc.h            |  2 ++
> >  fs/f2fs/sysfs.c         |  2 ++
> >  include/linux/f2fs_fs.h |  1 +
> >  6 files changed, 87 insertions(+)
> > 
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 82f1dc345505..dd76cbf02791 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -375,6 +375,8 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
> >  #define F2FS_IOC_FSGETXATTR		FS_IOC_FSGETXATTR
> >  #define F2FS_IOC_FSSETXATTR		FS_IOC_FSSETXATTR
> >  
> > +#define F2FS_IOC_SET_DONTMOVE		_IO(F2FS_IOCTL_MAGIC, 13)
> > +
> >  struct f2fs_gc_range {
> >  	u32 sync;
> >  	u64 start;
> > @@ -1129,6 +1131,9 @@ struct f2fs_sb_info {
> >  	/* threshold for converting bg victims for fg */
> >  	u64 fggc_threshold;
> >  
> > +	/* threshold for dontmove gc trials */
> > +	u64 gc_dontmove;
> > +
> >  	/* maximum # of trials to find a victim segment for SSR and GC */
> >  	unsigned int max_victim_search;
> >  
> > @@ -2104,6 +2109,7 @@ enum {
> >  	FI_HOT_DATA,		/* indicate file is hot */
> >  	FI_EXTRA_ATTR,		/* indicate file has extra attribute */
> >  	FI_PROJ_INHERIT,	/* indicate file inherits projectid */
> > +	FI_DONTMOVE,		/* indicate file should not be gced */
> >  };
> >  
> >  static inline void __mark_inode_dirty_flag(struct inode *inode,
> > @@ -2117,6 +2123,7 @@ static inline void __mark_inode_dirty_flag(struct inode *inode,
> >  			return;
> >  	case FI_DATA_EXIST:
> >  	case FI_INLINE_DOTS:
> > +	case FI_DONTMOVE:
> >  		f2fs_mark_inode_dirty_sync(inode, true);
> >  	}
> >  }
> > @@ -2225,6 +2232,8 @@ static inline void get_inline_info(struct inode *inode, struct f2fs_inode *ri)
> >  		set_bit(FI_INLINE_DOTS, &fi->flags);
> >  	if (ri->i_inline & F2FS_EXTRA_ATTR)
> >  		set_bit(FI_EXTRA_ATTR, &fi->flags);
> > +	if (ri->i_inline & F2FS_DONTMOVE)
> > +		set_bit(FI_DONTMOVE, &fi->flags);
> >  }
> >  
> >  static inline void set_raw_inline(struct inode *inode, struct f2fs_inode *ri)
> > @@ -2243,6 +2252,8 @@ static inline void set_raw_inline(struct inode *inode, struct f2fs_inode *ri)
> >  		ri->i_inline |= F2FS_INLINE_DOTS;
> >  	if (is_inode_flag_set(inode, FI_EXTRA_ATTR))
> >  		ri->i_inline |= F2FS_EXTRA_ATTR;
> > +	if (is_inode_flag_set(inode, FI_DONTMOVE))
> > +		ri->i_inline |= F2FS_DONTMOVE;
> >  }
> >  
> >  static inline int f2fs_has_extra_attr(struct inode *inode)
> > @@ -2288,6 +2299,11 @@ static inline int f2fs_has_inline_dots(struct inode *inode)
> >  	return is_inode_flag_set(inode, FI_INLINE_DOTS);
> >  }
> >  
> > +static inline bool f2fs_is_dontmove_file(struct inode *inode)
> > +{
> > +	return is_inode_flag_set(inode, FI_DONTMOVE);
> > +}
> > +
> >  static inline bool f2fs_is_atomic_file(struct inode *inode)
> >  {
> >  	return is_inode_flag_set(inode, FI_ATOMIC_FILE);
> > @@ -2503,6 +2519,7 @@ int truncate_hole(struct inode *inode, pgoff_t pg_start, pgoff_t pg_end);
> >  void truncate_data_blocks_range(struct dnode_of_data *dn, int count);
> >  long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
> >  long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
> > +int f2fs_dontmove_control(struct inode *inode, bool inc);
> >  
> >  /*
> >   * inode.c
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 1db68f1bcd77..e232f8d91f6f 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -2666,6 +2666,57 @@ static int f2fs_ioc_fssetxattr(struct file *filp, unsigned long arg)
> >  	return 0;
> >  }
> >  
> > +int f2fs_dontmove_control(struct inode *inode, bool inc)
> > +{
> > +	struct f2fs_inode_info *fi = F2FS_I(inode);
> > +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> > +
> > +	/* Use i_current_depth for normal file as a risk signal. */
> > +	if (inc)
> > +		f2fs_i_depth_write(inode, fi->i_current_depth + 1);
> > +
> > +	if (fi->i_current_depth > sbi->gc_dontmove) {
> > +		f2fs_msg(sbi->sb, KERN_WARNING,
> > +			"%s: Enable GC = ino %lx after %x GC trials\n",
> > +			__func__, inode->i_ino, fi->i_current_depth);
> > +		return -EAGAIN;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static int f2fs_ioc_set_dontmove(struct file *filp)
> > +{
> > +	struct inode *inode = file_inode(filp);
> > +	int ret;
> > +
> > +	if (!inode_owner_or_capable(inode))
> > +		return -EACCES;
> > +
> > +	if (!S_ISREG(inode->i_mode))
> > +		return -EINVAL;
> > +
> > +	if (f2fs_readonly(F2FS_I_SB(inode)->sb))
> > +		return -EROFS;
> > +
> > +	inode_lock(inode);
> > +
> > +	if (f2fs_dontmove_control(inode, false)) {
> > +		ret = -EAGAIN;
> > +		goto out;
> > +	}
> > +
> > +	ret = f2fs_convert_inline_inode(inode);
> > +	if (ret)
> > +		goto out;
> > +
> > +	set_inode_flag(inode, FI_DONTMOVE);
> > +	ret = F2FS_I(inode)->i_current_depth;
> > +	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
> > +out:
> > +	inode_unlock(inode);
> > +	return ret;
> > +}
> > +
> >  long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> >  {
> >  	if (unlikely(f2fs_cp_error(F2FS_I_SB(file_inode(filp)))))
> > @@ -2716,6 +2767,8 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> >  		return f2fs_ioc_fsgetxattr(filp, arg);
> >  	case F2FS_IOC_FSSETXATTR:
> >  		return f2fs_ioc_fssetxattr(filp, arg);
> > +	case F2FS_IOC_SET_DONTMOVE:
> > +		return f2fs_ioc_set_dontmove(filp);
> >  	default:
> >  		return -ENOTTY;
> >  	}
> > @@ -2791,6 +2844,7 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> >  	case F2FS_IOC_GET_FEATURES:
> >  	case F2FS_IOC_FSGETXATTR:
> >  	case F2FS_IOC_FSSETXATTR:
> > +	case F2FS_IOC_SET_DONTMOVE:
> >  		break;
> >  	default:
> >  		return -ENOIOCTLCMD;
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index 5d5bba462f26..263cb0b71ec8 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -624,6 +624,11 @@ static void move_data_block(struct inode *inode, block_t bidx,
> >  	if (f2fs_is_atomic_file(inode))
> >  		goto out;
> >  
> > +	if (f2fs_is_dontmove_file(inode)) {
> > +		f2fs_dontmove_control(inode, false);
> > +		goto out;
> > +	}
> > +
> >  	set_new_dnode(&dn, inode, NULL, NULL, 0);
> >  	err = get_dnode_of_data(&dn, bidx, LOOKUP_NODE);
> >  	if (err)
> > @@ -720,6 +725,11 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
> >  
> >  	if (f2fs_is_atomic_file(inode))
> >  		goto out;
> > +	if (f2fs_is_dontmove_file(inode)) {
> > +		if (gc_type == FG_GC)
> > +			f2fs_dontmove_control(inode, false);
> > +		goto out;
> > +	}
> >  
> >  	if (gc_type == BG_GC) {
> >  		if (PageWriteback(page))
> > @@ -1091,6 +1101,7 @@ void build_gc_manager(struct f2fs_sb_info *sbi)
> >  
> >  	sbi->fggc_threshold = div64_u64((main_count - ovp_count) *
> >  				BLKS_PER_SEC(sbi), (main_count - resv_count));
> > +	sbi->gc_dontmove = DEF_GC_FAILED_DONTMOVE;
> >  
> >  	/* give warm/cold data area from slower device */
> >  	if (sbi->s_ndevs && sbi->segs_per_sec == 1)
> > diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
> > index 9325191fab2d..3fbb74253e52 100644
> > --- a/fs/f2fs/gc.h
> > +++ b/fs/f2fs/gc.h
> > @@ -20,6 +20,8 @@
> >  #define LIMIT_INVALID_BLOCK	40 /* percentage over total user space */
> >  #define LIMIT_FREE_BLOCK	40 /* percentage over invalid + free space */
> >  
> > +#define DEF_GC_FAILED_DONTMOVE		1024
> > +
> >  /* Search max. number of dirty segments to select a victim segment */
> >  #define DEF_MAX_VICTIM_SEARCH 4096 /* covers 8GB */
> >  
> > diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> > index 93c3364250dd..57dd6660936a 100644
> > --- a/fs/f2fs/sysfs.c
> > +++ b/fs/f2fs/sysfs.c
> > @@ -300,6 +300,7 @@ F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, cp_interval, interval_time[CP_TIME]);
> >  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, idle_interval, interval_time[REQ_TIME]);
> >  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, iostat_enable, iostat_enable);
> >  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, readdir_ra, readdir_ra);
> > +F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_dontmove, gc_dontmove);
> >  #ifdef CONFIG_F2FS_FAULT_INJECTION
> >  F2FS_RW_ATTR(FAULT_INFO_RATE, f2fs_fault_info, inject_rate, inject_rate);
> >  F2FS_RW_ATTR(FAULT_INFO_TYPE, f2fs_fault_info, inject_type, inject_type);
> > @@ -348,6 +349,7 @@ static struct attribute *f2fs_attrs[] = {
> >  	ATTR_LIST(idle_interval),
> >  	ATTR_LIST(iostat_enable),
> >  	ATTR_LIST(readdir_ra),
> > +	ATTR_LIST(gc_dontmove),
> >  #ifdef CONFIG_F2FS_FAULT_INJECTION
> >  	ATTR_LIST(inject_rate),
> >  	ATTR_LIST(inject_type),
> > diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> > index 43e98d30d2df..fedb2698a8f7 100644
> > --- a/include/linux/f2fs_fs.h
> > +++ b/include/linux/f2fs_fs.h
> > @@ -212,6 +212,7 @@ struct f2fs_extent {
> >  #define F2FS_DATA_EXIST		0x08	/* file inline data exist flag */
> >  #define F2FS_INLINE_DOTS	0x10	/* file having implicit dot dentries */
> >  #define F2FS_EXTRA_ATTR		0x20	/* file having extra attribute */
> > +#define F2FS_DONTMOVE		0x40	/* file should not be move */
> >  
> >  struct f2fs_inode {
> >  	__le16 i_mode;			/* file mode */
> > 
