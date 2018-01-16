From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v3 RESEND] f2fs: support F2FS_IOC_PRECACHE_EXTENTS
Date: Tue, 16 Jan 2018 15:59:08 -0800
Message-ID: <20180116235908.GA22625@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180111064230.38643-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180111064230.38643-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

On 01/11, Chao Yu wrote:
> This patch introduces a new ioctl F2FS_IOC_PRECACHE_EXTENTS to precache
> extent info like ext4, in order to gain better performance during
> triggering AIO by eliminating synchronous waiting of mapping info.
> 
> Referred commit: 7869a4a6c5ca ("ext4: add support for extent pre-caching")
> 
> In addition, with newly added extent precache abilitiy, this patch add
> to support FIEMAP_FLAG_CACHE in ->fiemap.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
> v3:
> - rebase code.
>  fs/f2fs/data.c | 39 +++++++++++++++++++++++++++++++++++++++
>  fs/f2fs/f2fs.h |  4 ++++
>  fs/f2fs/file.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 85 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 3c1a0f1a3e53..06a647a36356 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -861,6 +861,7 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
>  		map.m_len = 0;
>  
>  	map.m_next_pgofs = NULL;
> +	map.m_next_extent = NULL;
>  	map.m_seg_type = NO_CHECK_TYPE;
>  
>  	if (direct_io) {
> @@ -927,6 +928,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>  	blkcnt_t prealloc;
>  	struct extent_info ei = {0,0,0};
>  	block_t blkaddr;
> +	unsigned int start_pgofs;
>  
>  	if (!maxblocks)
>  		return 0;
> @@ -942,6 +944,8 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>  		map->m_pblk = ei.blk + pgofs - ei.fofs;
>  		map->m_len = min((pgoff_t)maxblocks, ei.fofs + ei.len - pgofs);
>  		map->m_flags = F2FS_MAP_MAPPED;
> +		if (map->m_next_extent)
> +			*map->m_next_extent = pgofs + map->m_len;
>  		goto out;
>  	}
>  
> @@ -960,10 +964,14 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>  			if (map->m_next_pgofs)
>  				*map->m_next_pgofs =
>  					get_next_page_offset(&dn, pgofs);
> +			if (map->m_next_extent)
> +				*map->m_next_extent =
> +					get_next_page_offset(&dn, pgofs);
>  		}
>  		goto unlock_out;
>  	}
>  
> +	start_pgofs = pgofs;
>  	prealloc = 0;
>  	last_ofs_in_node = ofs_in_node = dn.ofs_in_node;
>  	end_offset = ADDRS_PER_PAGE(dn.node_page, inode);
> @@ -997,6 +1005,8 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>  				map->m_pblk = 0;
>  				goto sync_out;
>  			}
> +			if (flag == F2FS_GET_BLOCK_PRECACHE)
> +				goto sync_out;
>  			if (flag == F2FS_GET_BLOCK_FIEMAP &&
>  						blkaddr == NULL_ADDR) {
>  				if (map->m_next_pgofs)
> @@ -1055,6 +1065,16 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>  	else if (dn.ofs_in_node < end_offset)
>  		goto next_block;
>  
> +	if (flag == F2FS_GET_BLOCK_PRECACHE) {
> +		if (map->m_flags & F2FS_MAP_MAPPED) {
> +			unsigned int ofs = start_pgofs - map->m_lblk;
> +
> +			f2fs_update_extent_cache_range(&dn,
> +				start_pgofs, map->m_pblk + ofs,
> +				map->m_len - ofs);
> +		}
> +	}
> +
>  	f2fs_put_dnode(&dn);
>  
>  	if (create) {
> @@ -1064,6 +1084,17 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>  	goto next_dnode;
>  
>  sync_out:
> +	if (flag == F2FS_GET_BLOCK_PRECACHE) {
> +		if (map->m_flags & F2FS_MAP_MAPPED) {
> +			unsigned int ofs = start_pgofs - map->m_lblk;
> +
> +			f2fs_update_extent_cache_range(&dn,
> +				start_pgofs, map->m_pblk + ofs,
> +				map->m_len - ofs);
> +		}
> +		if (map->m_next_extent)
> +			*map->m_next_extent = pgofs + 1;
> +	}
>  	f2fs_put_dnode(&dn);
>  unlock_out:
>  	if (create) {
> @@ -1085,6 +1116,7 @@ static int __get_data_block(struct inode *inode, sector_t iblock,
>  	map.m_lblk = iblock;
>  	map.m_len = bh->b_size >> inode->i_blkbits;
>  	map.m_next_pgofs = next_pgofs;
> +	map.m_next_extent = NULL;
>  	map.m_seg_type = seg_type;
>  
>  	err = f2fs_map_blocks(inode, &map, create, flag);
> @@ -1208,6 +1240,12 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  	u32 flags = 0;
>  	int ret = 0;
>  
> +	if (fieinfo->fi_flags & FIEMAP_FLAG_CACHE) {
> +		ret = f2fs_precache_extents(inode);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	ret = fiemap_check_flags(fieinfo, FIEMAP_FLAG_SYNC | FIEMAP_FLAG_XATTR);
>  	if (ret)
>  		return ret;
> @@ -1309,6 +1347,7 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
>  	map.m_len = 0;
>  	map.m_flags = 0;
>  	map.m_next_pgofs = NULL;
> +	map.m_next_extent = NULL;
>  	map.m_seg_type = NO_CHECK_TYPE;
>  
>  	for (; nr_pages; nr_pages--) {
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 3b3ddcdc98e9..aa3cd97c559e 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -359,6 +359,7 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
>  						struct f2fs_gc_range)
>  #define F2FS_IOC_GET_FEATURES		_IOR(F2FS_IOCTL_MAGIC, 12, __u32)
>  #define F2FS_IOC_SET_PIN_FILE		_IOW(F2FS_IOCTL_MAGIC, 13, __u32)
> +#define F2FS_IOC_PRECACHE_EXTENTS	_IO(F2FS_IOCTL_MAGIC, 14)

Since I needed to add F2FS_IOC_GET_PIN_FILE, let me modify the ioctl number to:

#define F2FS_IOC_PRECACHE_EXTENTS	_IO(F2FS_IOCTL_MAGIC, 15)

Thanks,

>  
>  #define F2FS_IOC_SET_ENCRYPTION_POLICY	FS_IOC_SET_ENCRYPTION_POLICY
>  #define F2FS_IOC_GET_ENCRYPTION_POLICY	FS_IOC_GET_ENCRYPTION_POLICY
> @@ -554,6 +555,7 @@ struct f2fs_map_blocks {
>  	unsigned int m_len;
>  	unsigned int m_flags;
>  	pgoff_t *m_next_pgofs;		/* point next possible non-hole pgofs */
> +	pgoff_t *m_next_extent;		/* point to next possible extent */
>  	int m_seg_type;
>  };
>  
> @@ -564,6 +566,7 @@ enum {
>  	F2FS_GET_BLOCK_BMAP,
>  	F2FS_GET_BLOCK_PRE_DIO,
>  	F2FS_GET_BLOCK_PRE_AIO,
> +	F2FS_GET_BLOCK_PRECACHE,
>  };
>  
>  /*
> @@ -2567,6 +2570,7 @@ int f2fs_getattr(const struct path *path, struct kstat *stat,
>  int f2fs_setattr(struct dentry *dentry, struct iattr *attr);
>  int truncate_hole(struct inode *inode, pgoff_t pg_start, pgoff_t pg_end);
>  void truncate_data_blocks_range(struct dnode_of_data *dn, int count);
> +int f2fs_precache_extents(struct inode *inode);
>  long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
>  long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
>  int f2fs_pin_file_control(struct inode *inode, bool inc);
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 82e0a5c24bd2..b44c4272bd01 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1422,7 +1422,7 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
>  {
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  	struct f2fs_map_blocks map = { .m_next_pgofs = NULL,
> -					.m_seg_type = NO_CHECK_TYPE };
> +			.m_next_extent = NULL, .m_seg_type = NO_CHECK_TYPE };
>  	pgoff_t pg_end;
>  	loff_t new_size = i_size_read(inode);
>  	loff_t off_end;
> @@ -2071,7 +2071,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
>  {
>  	struct inode *inode = file_inode(filp);
>  	struct f2fs_map_blocks map = { .m_next_pgofs = NULL,
> -					.m_seg_type = NO_CHECK_TYPE };
> +			.m_next_extent = NULL, .m_seg_type = NO_CHECK_TYPE };
>  	struct extent_info ei = {0,0,0};
>  	pgoff_t pg_start, pg_end;
>  	unsigned int blk_per_seg = sbi->blocks_per_seg;
> @@ -2737,6 +2737,43 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
>  	return ret;
>  }
>  
> +int f2fs_precache_extents(struct inode *inode)
> +{
> +	struct f2fs_inode_info *fi = F2FS_I(inode);
> +	struct f2fs_map_blocks map;
> +	pgoff_t m_next_extent;
> +	loff_t end;
> +	int err;
> +
> +	if (is_inode_flag_set(inode, FI_NO_EXTENT))
> +		return -EOPNOTSUPP;
> +
> +	map.m_lblk = 0;
> +	map.m_next_pgofs = NULL;
> +	map.m_next_extent = &m_next_extent;
> +	map.m_seg_type = NO_CHECK_TYPE;
> +	end = F2FS_I_SB(inode)->max_file_blocks;
> +
> +	while (map.m_lblk < end) {
> +		map.m_len = end - map.m_lblk;
> +
> +		down_write(&fi->dio_rwsem[WRITE]);
> +		err = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_PRECACHE);
> +		up_write(&fi->dio_rwsem[WRITE]);
> +		if (err)
> +			return err;
> +
> +		map.m_lblk = m_next_extent;
> +	}
> +
> +	return err;
> +}
> +
> +static int f2fs_ioc_precache_extents(struct file *filp, unsigned long arg)
> +{
> +	return f2fs_precache_extents(file_inode(filp));
> +}
> +
>  long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  {
>  	if (unlikely(f2fs_cp_error(F2FS_I_SB(file_inode(filp)))))
> @@ -2789,6 +2826,8 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  		return f2fs_ioc_fssetxattr(filp, arg);
>  	case F2FS_IOC_SET_PIN_FILE:
>  		return f2fs_ioc_set_pin_file(filp, arg);
> +	case F2FS_IOC_PRECACHE_EXTENTS:
> +		return f2fs_ioc_precache_extents(filp, arg);
>  	default:
>  		return -ENOTTY;
>  	}
> @@ -2865,6 +2904,7 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  	case F2FS_IOC_FSGETXATTR:
>  	case F2FS_IOC_FSSETXATTR:
>  	case F2FS_IOC_SET_PIN_FILE:
> +	case F2FS_IOC_PRECACHE_EXTENTS:
>  		break;
>  	default:
>  		return -ENOIOCTLCMD;
> -- 
> 2.15.0.55.gc2ece9dc4de6
