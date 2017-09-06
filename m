From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 3/3] f2fs: support flexible inline xattr size
Date: Wed, 6 Sep 2017 11:45:21 +0800
Message-ID: <eed64ca4-1d6a-6898-3ff0-6a39d7665b96@huawei.com>
References: <20170904105804.8042-1-yuchao0@huawei.com>
 <20170904105804.8042-3-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1dpRHZ-0004zJ-BG
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 06 Sep 2017 03:45:41 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1dpRHW-0002De-KK
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 06 Sep 2017 03:45:41 +0000
In-Reply-To: <20170904105804.8042-3-yuchao0@huawei.com>
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
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

Do we have time to test and stabilize this new feature before merge window?

Thanks,

On 2017/9/4 18:58, Chao Yu wrote:
> Now, in product, more and more features based on file encryption were
> introduced, their demand of xattr space is increasing, however, inline
> xattr has fixed-size of 200 bytes, once inline xattr space is full, new
> increased xattr data would occupy additional xattr block which may bring
> us more space usage and performance regression during persisting.
> 
> In order to resolve above issue, it's better to expand inline xattr size
> flexibly according to user's requirement.
> 
> So this patch introduces new filesystem feature 'flexible inline xattr',
> and new mount option 'inline_xattr_size=%u', once mkfs enables the
> feature, we can use the option to make f2fs supporting flexible inline
> xattr size.
> 
> To support this feature, we add extra attribute i_inline_xattr_size in
> inode layout, indicating that how many space inline xattr borrows from
> block address mapping space in inode layout, by this, we can easily
> locate and store flexible-sized inline xattr data in inode.
> 
> Inode disk layout:
>   +----------------------+
>   | .i_mode              |
>   | ...                  |
>   | .i_ext               |
>   +----------------------+
>   | .i_extra_isize       |
>   | .i_inline_xattr_size |-----------+
>   | ...                  |           |
>   +----------------------+           |
>   | .i_addr              |           |
>   |  - block address or  |           |
>   |  - inline data       |           |
>   +----------------------+<---+      v
>   |    inline xattr      |    +---inline xattr range
>   +----------------------+<---+
>   | .i_nid               |
>   +----------------------+
>   |   node_footer        |
>   | (nid, ino, offset)   |
>   +----------------------+
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/f2fs.h          | 43 ++++++++++++++++++++++++++++++-------------
>  fs/f2fs/inode.c         | 12 ++++++++++++
>  fs/f2fs/namei.c         |  6 ++++++
>  fs/f2fs/node.c          |  4 ++--
>  fs/f2fs/super.c         | 32 +++++++++++++++++++++++++++++++-
>  fs/f2fs/sysfs.c         |  7 +++++++
>  fs/f2fs/xattr.c         | 18 +++++++++---------
>  include/linux/f2fs_fs.h |  5 +++--
>  8 files changed, 100 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 1f24ad4ca1bb..168ad51b7fb9 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -93,6 +93,7 @@ extern char *fault_name[FAULT_MAX];
>  #define F2FS_MOUNT_GRPQUOTA		0x00100000
>  #define F2FS_MOUNT_PRJQUOTA		0x00200000
>  #define F2FS_MOUNT_QUOTA		0x00400000
> +#define F2FS_MOUNT_INLINE_XATTR_SIZE	0x00800000
>  
>  #define clear_opt(sbi, option)	((sbi)->mount_opt.opt &= ~F2FS_MOUNT_##option)
>  #define set_opt(sbi, option)	((sbi)->mount_opt.opt |= F2FS_MOUNT_##option)
> @@ -118,6 +119,7 @@ struct f2fs_mount_info {
>  #define F2FS_FEATURE_EXTRA_ATTR		0x0008
>  #define F2FS_FEATURE_PRJQUOTA		0x0010
>  #define F2FS_FEATURE_INODE_CHKSUM	0x0020
> +#define F2FS_FEATURE_FLEXIBLE_INLINE_XATTR	0x0040
>  
>  #define F2FS_HAS_FEATURE(sb, mask)					\
>  	((F2FS_SB(sb)->raw_super->feature & cpu_to_le32(mask)) != 0)
> @@ -379,11 +381,14 @@ struct f2fs_flush_device {
>  
>  /* for inline stuff */
>  #define DEF_INLINE_RESERVED_SIZE	1
> +#define DEF_MIN_INLINE_SIZE		1
>  static inline int get_extra_isize(struct inode *inode);
> -#define MAX_INLINE_DATA(inode)	(sizeof(__le32) * \
> -				(CUR_ADDRS_PER_INODE(inode) - \
> -				DEF_INLINE_RESERVED_SIZE - \
> -				F2FS_INLINE_XATTR_ADDRS))
> +static inline int get_inline_xattr_addrs(struct inode *inode);
> +#define F2FS_INLINE_XATTR_ADDRS(inode)	get_inline_xattr_addrs(inode)
> +#define MAX_INLINE_DATA(inode)	(sizeof(__le32) *			\
> +				(CUR_ADDRS_PER_INODE(inode) -		\
> +				F2FS_INLINE_XATTR_ADDRS(inode) -	\
> +				DEF_INLINE_RESERVED_SIZE))
>  
>  /* for inline dir */
>  #define NR_INLINE_DENTRY(inode)	(MAX_INLINE_DATA(inode) * BITS_PER_BYTE / \
> @@ -592,6 +597,7 @@ struct f2fs_inode_info {
>  
>  	int i_extra_isize;		/* size of extra space located in i_addr */
>  	kprojid_t i_projid;		/* id for project quota */
> +	int i_inline_xattr_size;	/* inline xattr size */
>  };
>  
>  static inline void get_extent_info(struct extent_info *ext,
> @@ -1043,6 +1049,7 @@ struct f2fs_sb_info {
>  	loff_t max_file_blocks;			/* max block index of file */
>  	int active_logs;			/* # of active logs */
>  	int dir_level;				/* directory level */
> +	int inline_xattr_size;			/* inline xattr size */
>  
>  	block_t user_block_count;		/* # of user blocks */
>  	block_t total_valid_block_count;	/* # of valid blocks */
> @@ -2167,25 +2174,20 @@ static inline int f2fs_has_inline_xattr(struct inode *inode)
>  
>  static inline unsigned int addrs_per_inode(struct inode *inode)
>  {
> -	if (f2fs_has_inline_xattr(inode))
> -		return CUR_ADDRS_PER_INODE(inode) - F2FS_INLINE_XATTR_ADDRS;
> -	return CUR_ADDRS_PER_INODE(inode);
> +	return CUR_ADDRS_PER_INODE(inode) - F2FS_INLINE_XATTR_ADDRS(inode);
>  }
>  
> -static inline void *inline_xattr_addr(struct page *page)
> +static inline void *inline_xattr_addr(struct inode *inode, struct page *page)
>  {
>  	struct f2fs_inode *ri = F2FS_INODE(page);
>  
>  	return (void *)&(ri->i_addr[DEF_ADDRS_PER_INODE -
> -					F2FS_INLINE_XATTR_ADDRS]);
> +					F2FS_INLINE_XATTR_ADDRS(inode)]);
>  }
>  
>  static inline int inline_xattr_size(struct inode *inode)
>  {
> -	if (f2fs_has_inline_xattr(inode))
> -		return F2FS_INLINE_XATTR_ADDRS << 2;
> -	else
> -		return 0;
> +	return get_inline_xattr_addrs(inode) * sizeof(__le32);
>  }
>  
>  static inline int f2fs_has_inline_data(struct inode *inode)
> @@ -2329,6 +2331,16 @@ static inline int get_extra_isize(struct inode *inode)
>  	return F2FS_I(inode)->i_extra_isize / sizeof(__le32);
>  }
>  
> +static inline int f2fs_sb_has_flexible_inline_xattr(struct super_block *sb);
> +static inline int get_inline_xattr_addrs(struct inode *inode)
> +{
> +	if (!f2fs_has_inline_xattr(inode))
> +		return 0;
> +	if (!f2fs_sb_has_flexible_inline_xattr(F2FS_I_SB(inode)->sb))
> +		return DEFAULT_INLINE_XATTR_ADDRS;
> +	return F2FS_I(inode)->i_inline_xattr_size;
> +}
> +
>  #define get_inode_mode(i) \
>  	((is_inode_flag_set(i, FI_ACL_MODE)) ? \
>  	 (F2FS_I(i)->i_acl_mode) : ((i)->i_mode))
> @@ -2984,6 +2996,11 @@ static inline int f2fs_sb_has_inode_chksum(struct super_block *sb)
>  	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_INODE_CHKSUM);
>  }
>  
> +static inline int f2fs_sb_has_flexible_inline_xattr(struct super_block *sb)
> +{
> +	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_FLEXIBLE_INLINE_XATTR);
> +}
> +
>  #ifdef CONFIG_BLK_DEV_ZONED
>  static inline int get_blkz_type(struct f2fs_sb_info *sbi,
>  			struct block_device *bdev, block_t blkaddr)
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index c33b05aec1a1..c3e60fa60957 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -232,6 +232,13 @@ static int do_read_inode(struct inode *inode)
>  	fi->i_extra_isize = f2fs_has_extra_attr(inode) ?
>  					le16_to_cpu(ri->i_extra_isize) : 0;
>  
> +	if (!f2fs_has_inline_xattr(inode))
> +		fi->i_inline_xattr_size = 0;
> +	else if (f2fs_sb_has_flexible_inline_xattr(sbi->sb))
> +		fi->i_inline_xattr_size = le16_to_cpu(ri->i_inline_xattr_size);
> +	else
> +		fi->i_inline_xattr_size = DEFAULT_INLINE_XATTR_ADDRS;
> +
>  	/* check data exist */
>  	if (f2fs_has_inline_data(inode) && !f2fs_exist_data(inode))
>  		__recover_inline_status(inode, node_page);
> @@ -384,6 +391,11 @@ int update_inode(struct inode *inode, struct page *node_page)
>  	if (f2fs_has_extra_attr(inode)) {
>  		ri->i_extra_isize = cpu_to_le16(F2FS_I(inode)->i_extra_isize);
>  
> +		if (f2fs_sb_has_flexible_inline_xattr(F2FS_I_SB(inode)->sb) &&
> +			f2fs_has_inline_xattr(inode))
> +			ri->i_inline_xattr_size =
> +				cpu_to_le16(F2FS_I(inode)->i_inline_xattr_size);
> +
>  		if (f2fs_sb_has_project_quota(F2FS_I_SB(inode)->sb) &&
>  			F2FS_FITS_IN_INODE(ri, F2FS_I(inode)->i_extra_isize,
>  								i_projid)) {
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index a4dab98c4b7b..b6455b7ca00f 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -86,6 +86,12 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
>  
>  	if (test_opt(sbi, INLINE_XATTR))
>  		set_inode_flag(inode, FI_INLINE_XATTR);
> +
> +	if (f2fs_sb_has_extra_attr(sbi->sb) &&
> +		f2fs_sb_has_flexible_inline_xattr(sbi->sb) &&
> +		f2fs_has_inline_xattr(inode))
> +		F2FS_I(inode)->i_inline_xattr_size = sbi->inline_xattr_size;
> +
>  	if (test_opt(sbi, INLINE_DATA) && f2fs_may_inline_data(inode))
>  		set_inode_flag(inode, FI_INLINE_DATA);
>  	if (f2fs_may_inline_dentry(inode))
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index fca87835a1da..a19f3302c967 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -2193,8 +2193,8 @@ void recover_inline_xattr(struct inode *inode, struct page *page)
>  		goto update_inode;
>  	}
>  
> -	dst_addr = inline_xattr_addr(ipage);
> -	src_addr = inline_xattr_addr(page);
> +	dst_addr = inline_xattr_addr(inode, ipage);
> +	src_addr = inline_xattr_addr(inode, page);
>  	inline_size = inline_xattr_size(inode);
>  
>  	f2fs_wait_on_page_writeback(ipage, NODE, true);
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index a8ff16c50b4c..3298bb3bf417 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -92,6 +92,7 @@ enum {
>  	Opt_disable_ext_identify,
>  	Opt_inline_xattr,
>  	Opt_noinline_xattr,
> +	Opt_inline_xattr_size,
>  	Opt_inline_data,
>  	Opt_inline_dentry,
>  	Opt_noinline_dentry,
> @@ -141,6 +142,7 @@ static match_table_t f2fs_tokens = {
>  	{Opt_disable_ext_identify, "disable_ext_identify"},
>  	{Opt_inline_xattr, "inline_xattr"},
>  	{Opt_noinline_xattr, "noinline_xattr"},
> +	{Opt_inline_xattr_size, "inline_xattr_size=%u"},
>  	{Opt_inline_data, "inline_data"},
>  	{Opt_inline_dentry, "inline_dentry"},
>  	{Opt_noinline_dentry, "noinline_dentry"},
> @@ -383,6 +385,12 @@ static int parse_options(struct super_block *sb, char *options)
>  		case Opt_noinline_xattr:
>  			clear_opt(sbi, INLINE_XATTR);
>  			break;
> +		case Opt_inline_xattr_size:
> +			if (args->from && match_int(args, &arg))
> +				return -EINVAL;
> +			set_opt(sbi, INLINE_XATTR_SIZE);
> +			sbi->inline_xattr_size = arg;
> +			break;
>  #else
>  		case Opt_user_xattr:
>  			f2fs_msg(sb, KERN_INFO,
> @@ -604,6 +612,24 @@ static int parse_options(struct super_block *sb, char *options)
>  				F2FS_IO_SIZE_KB(sbi));
>  		return -EINVAL;
>  	}
> +
> +	if (test_opt(sbi, INLINE_XATTR_SIZE)) {
> +		if (!test_opt(sbi, INLINE_XATTR)) {
> +			f2fs_msg(sb, KERN_ERR,
> +					"inline_xattr_size option should be "
> +					"set with inline_xattr option");
> +			return -EINVAL;
> +		}
> +		if (!sbi->inline_xattr_size ||
> +			sbi->inline_xattr_size >= DEF_ADDRS_PER_INODE -
> +					F2FS_TOTAL_EXTRA_ATTR_SIZE -
> +					DEF_INLINE_RESERVED_SIZE -
> +					DEF_MIN_INLINE_SIZE) {
> +			f2fs_msg(sb, KERN_ERR,
> +					"inline xattr size is out of range");
> +			return -EINVAL;
> +		}
> +	}
>  	return 0;
>  }
>  
> @@ -1045,6 +1071,9 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>  		seq_puts(seq, ",inline_xattr");
>  	else
>  		seq_puts(seq, ",noinline_xattr");
> +	if (test_opt(sbi, INLINE_XATTR_SIZE))
> +		seq_printf(seq, ",inline_xattr_size=%u",
> +					sbi->inline_xattr_size);
>  #endif
>  #ifdef CONFIG_F2FS_FS_POSIX_ACL
>  	if (test_opt(sbi, POSIX_ACL))
> @@ -1107,6 +1136,7 @@ static void default_options(struct f2fs_sb_info *sbi)
>  {
>  	/* init some FS parameters */
>  	sbi->active_logs = NR_CURSEG_TYPE;
> +	sbi->inline_xattr_size = DEFAULT_INLINE_XATTR_ADDRS;
>  
>  	set_opt(sbi, BG_GC);
>  	set_opt(sbi, INLINE_XATTR);
> @@ -1655,7 +1685,7 @@ static loff_t max_file_blocks(void)
>  
>  	/*
>  	 * note: previously, result is equal to (DEF_ADDRS_PER_INODE -
> -	 * F2FS_INLINE_XATTR_ADDRS), but now f2fs try to reserve more
> +	 * DEFAULT_INLINE_XATTR_ADDRS), but now f2fs try to reserve more
>  	 * space in inode.i_addr, it will be more safe to reassign
>  	 * result as zero.
>  	 */
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index daa48257cc94..595b69862b0e 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -100,6 +100,9 @@ static ssize_t features_show(struct f2fs_attr *a,
>  	if (f2fs_sb_has_inode_chksum(sb))
>  		len += snprintf(buf + len, PAGE_SIZE - len, "%s%s",
>  				len ? ", " : "", "inode_checksum");
> +	if (f2fs_sb_has_flexible_inline_xattr(sb))
> +		len += snprintf(buf + len, PAGE_SIZE - len, "%s%s",
> +				len ? ", " : "", "flexible_inline_xattr");
>  	len += snprintf(buf + len, PAGE_SIZE - len, "\n");
>  	return len;
>  }
> @@ -232,6 +235,7 @@ enum feat_id {
>  	FEAT_EXTRA_ATTR,
>  	FEAT_PROJECT_QUOTA,
>  	FEAT_INODE_CHECKSUM,
> +	FEAT_FLEXIBLE_INLINE_XATTR,
>  };
>  
>  static ssize_t f2fs_feature_show(struct f2fs_attr *a,
> @@ -244,6 +248,7 @@ static ssize_t f2fs_feature_show(struct f2fs_attr *a,
>  	case FEAT_EXTRA_ATTR:
>  	case FEAT_PROJECT_QUOTA:
>  	case FEAT_INODE_CHECKSUM:
> +	case FEAT_FLEXIBLE_INLINE_XATTR:
>  		return snprintf(buf, PAGE_SIZE, "supported\n");
>  	}
>  	return 0;
> @@ -314,6 +319,7 @@ F2FS_FEATURE_RO_ATTR(atomic_write, FEAT_ATOMIC_WRITE);
>  F2FS_FEATURE_RO_ATTR(extra_attr, FEAT_EXTRA_ATTR);
>  F2FS_FEATURE_RO_ATTR(project_quota, FEAT_PROJECT_QUOTA);
>  F2FS_FEATURE_RO_ATTR(inode_checksum, FEAT_INODE_CHECKSUM);
> +F2FS_FEATURE_RO_ATTR(flexible_inline_xattr, FEAT_FLEXIBLE_INLINE_XATTR);
>  
>  #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
>  static struct attribute *f2fs_attrs[] = {
> @@ -360,6 +366,7 @@ static struct attribute *f2fs_feat_attrs[] = {
>  	ATTR_LIST(extra_attr),
>  	ATTR_LIST(project_quota),
>  	ATTR_LIST(inode_checksum),
> +	ATTR_LIST(flexible_inline_xattr),
>  	NULL,
>  };
>  
> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
> index 4829f1b38478..252adbb7126a 100644
> --- a/fs/f2fs/xattr.c
> +++ b/fs/f2fs/xattr.c
> @@ -217,12 +217,12 @@ static struct f2fs_xattr_entry *__find_xattr(void *base_addr, int index,
>  	return entry;
>  }
>  
> -static struct f2fs_xattr_entry *__find_inline_xattr(void *base_addr,
> -					void **last_addr, int index,
> -					size_t len, const char *name)
> +static struct f2fs_xattr_entry *__find_inline_xattr(struct inode *inode,
> +				void *base_addr, void **last_addr, int index,
> +				size_t len, const char *name)
>  {
>  	struct f2fs_xattr_entry *entry;
> -	unsigned int inline_size = F2FS_INLINE_XATTR_ADDRS << 2;
> +	unsigned int inline_size = inline_xattr_size(inode);
>  
>  	list_for_each_xattr(entry, base_addr) {
>  		if ((void *)entry + sizeof(__u32) > base_addr + inline_size ||
> @@ -250,13 +250,13 @@ static int read_inline_xattr(struct inode *inode, struct page *ipage,
>  	void *inline_addr;
>  
>  	if (ipage) {
> -		inline_addr = inline_xattr_addr(ipage);
> +		inline_addr = inline_xattr_addr(inode, ipage);
>  	} else {
>  		page = get_node_page(sbi, inode->i_ino);
>  		if (IS_ERR(page))
>  			return PTR_ERR(page);
>  
> -		inline_addr = inline_xattr_addr(page);
> +		inline_addr = inline_xattr_addr(inode, page);
>  	}
>  	memcpy(txattr_addr, inline_addr, inline_size);
>  	f2fs_put_page(page, 1);
> @@ -309,7 +309,7 @@ static int lookup_all_xattrs(struct inode *inode, struct page *ipage,
>  		if (err)
>  			goto out;
>  
> -		*xe = __find_inline_xattr(txattr_addr, &last_addr,
> +		*xe = __find_inline_xattr(inode, txattr_addr, &last_addr,
>  						index, len, name);
>  		if (*xe)
>  			goto check;
> @@ -404,7 +404,7 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
>  		void *inline_addr;
>  
>  		if (ipage) {
> -			inline_addr = inline_xattr_addr(ipage);
> +			inline_addr = inline_xattr_addr(inode, ipage);
>  			f2fs_wait_on_page_writeback(ipage, NODE, true);
>  			set_page_dirty(ipage);
>  		} else {
> @@ -413,7 +413,7 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
>  				alloc_nid_failed(sbi, new_nid);
>  				return PTR_ERR(page);
>  			}
> -			inline_addr = inline_xattr_addr(page);
> +			inline_addr = inline_xattr_addr(inode, page);
>  			f2fs_wait_on_page_writeback(page, NODE, true);
>  		}
>  		memcpy(inline_addr, txattr_addr, inline_size);
> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> index 2a0c453d7235..50a8ee501bf1 100644
> --- a/include/linux/f2fs_fs.h
> +++ b/include/linux/f2fs_fs.h
> @@ -184,7 +184,8 @@ struct f2fs_extent {
>  } __packed;
>  
>  #define F2FS_NAME_LEN		255
> -#define F2FS_INLINE_XATTR_ADDRS	50	/* 200 bytes for inline xattrs */
> +/* 200 bytes for inline xattrs by default */
> +#define DEFAULT_INLINE_XATTR_ADDRS	50
>  #define DEF_ADDRS_PER_INODE	923	/* Address Pointers in an Inode */
>  #define CUR_ADDRS_PER_INODE(inode)	(DEF_ADDRS_PER_INODE - \
>  					get_extra_isize(inode))
> @@ -238,7 +239,7 @@ struct f2fs_inode {
>  	union {
>  		struct {
>  			__le16 i_extra_isize;	/* extra inode attribute size */
> -			__le16 i_padding;	/* padding */
> +			__le16 i_inline_xattr_size;	/* inline xattr size, unit: 4 bytes */
>  			__le32 i_projid;	/* project id */
>  			__le32 i_inode_checksum;/* inode meta checksum */
>  			__le32 i_extra_end[0];	/* for attribute size calculation */
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
