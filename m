From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: add an ioctl to disable GC for specific file
Date: Fri, 29 Dec 2017 16:29:22 +0800
Message-ID: <bbb9fa01-25c6-4e38-2b8b-30955f819fce@huawei.com>
References: <20171208051555.76998-1-jaegeuk@kernel.org>
 <20171208193723.GA87676@jaegeuk-macbookpro.roam.corp.google.com>
 <20171228034020.GF13490@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171228034020.GF13490@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/12/28 11:40, Jaegeuk Kim wrote:
> This patch gives a flag to disable GC on given file, which would be useful, when
> user wants to keep its block map. It also conducts in-place-update for dontmove
> file.

One question, we may encounter out-of-space during foreground GC if there
is too many data blocks of pinned files as they are removable.

Do we need to record all segments which contain block of pinned file? and
then trigger foreground GC more early by adjust threshold in
has_not_enough_free_secs.

Thanks,

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
> 
> Change log from v2:
>  - change the naming from dontmove to pin_file
>  - do in-place-update for pinned files
>  - use union for i_current_depth with i_gc_failures
>  - pass increasing i_gc_failures
> 
>  fs/f2fs/data.c          |  2 ++
>  fs/f2fs/f2fs.h          | 29 +++++++++++++++++++++++++-
>  fs/f2fs/file.c          | 54 +++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/f2fs/gc.c            | 11 ++++++++++
>  fs/f2fs/gc.h            |  2 ++
>  fs/f2fs/sysfs.c         |  2 ++
>  include/linux/f2fs_fs.h |  9 ++++++++-
>  7 files changed, 107 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 7aca6ccd01f6..b9fab6186f28 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1394,6 +1394,8 @@ static inline bool need_inplace_update(struct f2fs_io_info *fio)
>  {
>  	struct inode *inode = fio->page->mapping->host;
>  
> +	if (f2fs_is_pinned_file(inode))
> +		return true;
>  	if (S_ISDIR(inode->i_mode) || f2fs_is_atomic_file(inode))
>  		return false;
>  	if (is_cold_data(fio->page))
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 65a51b941146..398ed95d4036 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -376,6 +376,8 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
>  #define F2FS_IOC_FSGETXATTR		FS_IOC_FSGETXATTR
>  #define F2FS_IOC_FSSETXATTR		FS_IOC_FSSETXATTR
>  
> +#define F2FS_IOC_PIN_FILE		_IO(F2FS_IOCTL_MAGIC, 13)
> +
>  struct f2fs_gc_range {
>  	u32 sync;
>  	u64 start;
> @@ -586,7 +588,10 @@ struct f2fs_inode_info {
>  	unsigned long i_flags;		/* keep an inode flags for ioctl */
>  	unsigned char i_advise;		/* use to give file attribute hints */
>  	unsigned char i_dir_level;	/* use for dentry level for large dir */
> -	unsigned int i_current_depth;	/* use only in directory structure */
> +	union {
> +		unsigned int i_current_depth;	/* only for directory depth */
> +		unsigned short i_gc_failures;	/* only for regular file */
> +	};
>  	unsigned int i_pino;		/* parent inode number */
>  	umode_t i_acl_mode;		/* keep file acl mode temporarily */
>  
> @@ -1130,6 +1135,9 @@ struct f2fs_sb_info {
>  	/* threshold for converting bg victims for fg */
>  	u64 fggc_threshold;
>  
> +	/* threshold for gc trials on pinned files */
> +	u64 gc_pin_file_threshold;
> +
>  	/* maximum # of trials to find a victim segment for SSR and GC */
>  	unsigned int max_victim_search;
>  
> @@ -2119,6 +2127,7 @@ enum {
>  	FI_HOT_DATA,		/* indicate file is hot */
>  	FI_EXTRA_ATTR,		/* indicate file has extra attribute */
>  	FI_PROJ_INHERIT,	/* indicate file inherits projectid */
> +	FI_PIN_FILE,		/* indicate file should not be gced */
>  };
>  
>  static inline void __mark_inode_dirty_flag(struct inode *inode,
> @@ -2132,6 +2141,7 @@ static inline void __mark_inode_dirty_flag(struct inode *inode,
>  			return;
>  	case FI_DATA_EXIST:
>  	case FI_INLINE_DOTS:
> +	case FI_PIN_FILE:
>  		f2fs_mark_inode_dirty_sync(inode, true);
>  	}
>  }
> @@ -2212,6 +2222,13 @@ static inline void f2fs_i_depth_write(struct inode *inode, unsigned int depth)
>  	f2fs_mark_inode_dirty_sync(inode, true);
>  }
>  
> +static inline void f2fs_i_gc_failures_write(struct inode *inode,
> +					unsigned int count)
> +{
> +	F2FS_I(inode)->i_gc_failures = count;
> +	f2fs_mark_inode_dirty_sync(inode, true);
> +}
> +
>  static inline void f2fs_i_xnid_write(struct inode *inode, nid_t xnid)
>  {
>  	F2FS_I(inode)->i_xattr_nid = xnid;
> @@ -2240,6 +2257,8 @@ static inline void get_inline_info(struct inode *inode, struct f2fs_inode *ri)
>  		set_bit(FI_INLINE_DOTS, &fi->flags);
>  	if (ri->i_inline & F2FS_EXTRA_ATTR)
>  		set_bit(FI_EXTRA_ATTR, &fi->flags);
> +	if (ri->i_inline & F2FS_PIN_FILE)
> +		set_bit(FI_PIN_FILE, &fi->flags);
>  }
>  
>  static inline void set_raw_inline(struct inode *inode, struct f2fs_inode *ri)
> @@ -2258,6 +2277,8 @@ static inline void set_raw_inline(struct inode *inode, struct f2fs_inode *ri)
>  		ri->i_inline |= F2FS_INLINE_DOTS;
>  	if (is_inode_flag_set(inode, FI_EXTRA_ATTR))
>  		ri->i_inline |= F2FS_EXTRA_ATTR;
> +	if (is_inode_flag_set(inode, FI_PIN_FILE))
> +		ri->i_inline |= F2FS_PIN_FILE;
>  }
>  
>  static inline int f2fs_has_extra_attr(struct inode *inode)
> @@ -2303,6 +2324,11 @@ static inline int f2fs_has_inline_dots(struct inode *inode)
>  	return is_inode_flag_set(inode, FI_INLINE_DOTS);
>  }
>  
> +static inline bool f2fs_is_pinned_file(struct inode *inode)
> +{
> +	return is_inode_flag_set(inode, FI_PIN_FILE);
> +}
> +
>  static inline bool f2fs_is_atomic_file(struct inode *inode)
>  {
>  	return is_inode_flag_set(inode, FI_ATOMIC_FILE);
> @@ -2518,6 +2544,7 @@ int truncate_hole(struct inode *inode, pgoff_t pg_start, pgoff_t pg_end);
>  void truncate_data_blocks_range(struct dnode_of_data *dn, int count);
>  long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
>  long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
> +int f2fs_pin_file_control(struct inode *inode, bool inc);
>  
>  /*
>   * inode.c
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 1db68f1bcd77..5a3b9a07d72d 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2666,6 +2666,57 @@ static int f2fs_ioc_fssetxattr(struct file *filp, unsigned long arg)
>  	return 0;
>  }
>  
> +int f2fs_pin_file_control(struct inode *inode, bool inc)
> +{
> +	struct f2fs_inode_info *fi = F2FS_I(inode);
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +
> +	/* Use i_gc_failures for normal file as a risk signal. */
> +	if (inc)
> +		f2fs_i_gc_failures_write(inode, fi->i_gc_failures + 1);
> +
> +	if (fi->i_gc_failures > sbi->gc_pin_file_threshold) {
> +		f2fs_msg(sbi->sb, KERN_WARNING,
> +			"%s: Enable GC = ino %lx after %x GC trials\n",
> +			__func__, inode->i_ino, fi->i_gc_failures);
> +		return -EAGAIN;
> +	}
> +	return 0;
> +}
> +
> +static int f2fs_ioc_pin_file(struct file *filp)
> +{
> +	struct inode *inode = file_inode(filp);
> +	int ret;
> +
> +	if (!inode_owner_or_capable(inode))
> +		return -EACCES;
> +
> +	if (!S_ISREG(inode->i_mode))
> +		return -EINVAL;
> +
> +	if (f2fs_readonly(F2FS_I_SB(inode)->sb))
> +		return -EROFS;
> +
> +	inode_lock(inode);
> +
> +	if (f2fs_pin_file_control(inode, false)) {
> +		ret = -EAGAIN;
> +		goto out;
> +	}
> +
> +	ret = f2fs_convert_inline_inode(inode);
> +	if (ret)
> +		goto out;
> +
> +	set_inode_flag(inode, FI_PIN_FILE);
> +	ret = F2FS_I(inode)->i_gc_failures;
> +	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
> +out:
> +	inode_unlock(inode);
> +	return ret;
> +}
> +
>  long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  {
>  	if (unlikely(f2fs_cp_error(F2FS_I_SB(file_inode(filp)))))
> @@ -2716,6 +2767,8 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  		return f2fs_ioc_fsgetxattr(filp, arg);
>  	case F2FS_IOC_FSSETXATTR:
>  		return f2fs_ioc_fssetxattr(filp, arg);
> +	case F2FS_IOC_PIN_FILE:
> +		return f2fs_ioc_pin_file(filp);
>  	default:
>  		return -ENOTTY;
>  	}
> @@ -2791,6 +2844,7 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  	case F2FS_IOC_GET_FEATURES:
>  	case F2FS_IOC_FSGETXATTR:
>  	case F2FS_IOC_FSSETXATTR:
> +	case F2FS_IOC_PIN_FILE:
>  		break;
>  	default:
>  		return -ENOIOCTLCMD;
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 5d5bba462f26..9bffef153a12 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -624,6 +624,11 @@ static void move_data_block(struct inode *inode, block_t bidx,
>  	if (f2fs_is_atomic_file(inode))
>  		goto out;
>  
> +	if (f2fs_is_pinned_file(inode)) {
> +		f2fs_pin_file_control(inode, true);
> +		goto out;
> +	}
> +
>  	set_new_dnode(&dn, inode, NULL, NULL, 0);
>  	err = get_dnode_of_data(&dn, bidx, LOOKUP_NODE);
>  	if (err)
> @@ -720,6 +725,11 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
>  
>  	if (f2fs_is_atomic_file(inode))
>  		goto out;
> +	if (f2fs_is_pinned_file(inode)) {
> +		if (gc_type == FG_GC)
> +			f2fs_pin_file_control(inode, true);
> +		goto out;
> +	}
>  
>  	if (gc_type == BG_GC) {
>  		if (PageWriteback(page))
> @@ -1091,6 +1101,7 @@ void build_gc_manager(struct f2fs_sb_info *sbi)
>  
>  	sbi->fggc_threshold = div64_u64((main_count - ovp_count) *
>  				BLKS_PER_SEC(sbi), (main_count - resv_count));
> +	sbi->gc_pin_file_threshold = DEF_GC_FAILED_PINNED_FILES;
>  
>  	/* give warm/cold data area from slower device */
>  	if (sbi->s_ndevs && sbi->segs_per_sec == 1)
> diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
> index 9325191fab2d..33310165cb78 100644
> --- a/fs/f2fs/gc.h
> +++ b/fs/f2fs/gc.h
> @@ -20,6 +20,8 @@
>  #define LIMIT_INVALID_BLOCK	40 /* percentage over total user space */
>  #define LIMIT_FREE_BLOCK	40 /* percentage over invalid + free space */
>  
> +#define DEF_GC_FAILED_PINNED_FILES	1024
> +
>  /* Search max. number of dirty segments to select a victim segment */
>  #define DEF_MAX_VICTIM_SEARCH 4096 /* covers 8GB */
>  
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 581c7ce23c22..0e3253d7cb10 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -303,6 +303,7 @@ F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, cp_interval, interval_time[CP_TIME]);
>  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, idle_interval, interval_time[REQ_TIME]);
>  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, iostat_enable, iostat_enable);
>  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, readdir_ra, readdir_ra);
> +F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_pin_file_thresh, gc_pin_file_threshold);
>  #ifdef CONFIG_F2FS_FAULT_INJECTION
>  F2FS_RW_ATTR(FAULT_INFO_RATE, f2fs_fault_info, inject_rate, inject_rate);
>  F2FS_RW_ATTR(FAULT_INFO_TYPE, f2fs_fault_info, inject_type, inject_type);
> @@ -351,6 +352,7 @@ static struct attribute *f2fs_attrs[] = {
>  	ATTR_LIST(idle_interval),
>  	ATTR_LIST(iostat_enable),
>  	ATTR_LIST(readdir_ra),
> +	ATTR_LIST(gc_pin_file_thresh),
>  #ifdef CONFIG_F2FS_FAULT_INJECTION
>  	ATTR_LIST(inject_rate),
>  	ATTR_LIST(inject_type),
> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> index 43e98d30d2df..cfb522e6affc 100644
> --- a/include/linux/f2fs_fs.h
> +++ b/include/linux/f2fs_fs.h
> @@ -212,6 +212,7 @@ struct f2fs_extent {
>  #define F2FS_DATA_EXIST		0x08	/* file inline data exist flag */
>  #define F2FS_INLINE_DOTS	0x10	/* file having implicit dot dentries */
>  #define F2FS_EXTRA_ATTR		0x20	/* file having extra attribute */
> +#define F2FS_PIN_FILE		0x40	/* file should not be gced */
>  
>  struct f2fs_inode {
>  	__le16 i_mode;			/* file mode */
> @@ -229,7 +230,13 @@ struct f2fs_inode {
>  	__le32 i_ctime_nsec;		/* change time in nano scale */
>  	__le32 i_mtime_nsec;		/* modification time in nano scale */
>  	__le32 i_generation;		/* file version (for NFS) */
> -	__le32 i_current_depth;		/* only for directory depth */
> +	union {
> +		__le32 i_current_depth;	/* only for directory depth */
> +		__le16 i_gc_failures;	/*
> +					 * # of gc failures on pinned file.
> +					 * only for regular files.
> +					 */
> +	};
>  	__le32 i_xattr_nid;		/* nid to save xattr */
>  	__le32 i_flags;			/* file attributes */
>  	__le32 i_pino;			/* parent inode number */
> 
