From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2 1/4] f2fs: support F2FS_IOC_PRECACHE_EXTENTS
Date: Wed, 10 Jan 2018 21:16:15 -0800
Message-ID: <20180111051615.GC18352@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180110062441.16329-1-yuchao0@huawei.com>
 <20180110192449.GB18352@jaegeuk-macbookpro.roam.corp.google.com>
 <93a3d76b-9e17-0303-b191-023ac09e4ced@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <93a3d76b-9e17-0303-b191-023ac09e4ced@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 01/11, Chao Yu wrote:
> On 2018/1/11 3:24, Jaegeuk Kim wrote:
> > On 01/10, Chao Yu wrote:
> >> This patch introduces a new ioctl F2FS_IOC_PRECACHE_EXTENTS to precache
> >> extent info like ext4, in order to gain better performance during
> >> triggering AIO by eliminating synchronous waiting of mapping info.
> >>
> >> Referred commit: 7869a4a6c5ca ("ext4: add support for extent pre-caching")
> >>
> >> In addition, with newly added extent precache abilitiy, this patch add
> >> to support FIEMAP_FLAG_CACHE in ->fiemap.
> >>
> >> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >> ---
> >> v2:
> >> - integrate extent precache related patches into this one.
> >>  fs/f2fs/data.c | 33 +++++++++++++++++++++++++++++++++
> >>  fs/f2fs/f2fs.h |  3 +++
> >>  fs/f2fs/file.c | 39 +++++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 75 insertions(+)
> >>
> >> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> >> index 8c05e9a74427..d7d3b2b49907 100644
> >> --- a/fs/f2fs/data.c
> >> +++ b/fs/f2fs/data.c
> >> @@ -927,6 +927,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
> >>  	blkcnt_t prealloc;
> >>  	struct extent_info ei = {0,0,0};
> >>  	block_t blkaddr;
> >> +	unsigned int start_pgofs;
> >>  
> >>  	if (!maxblocks)
> >>  		return 0;
> >> @@ -942,6 +943,8 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
> >>  		map->m_pblk = ei.blk + pgofs - ei.fofs;
> >>  		map->m_len = min((pgoff_t)maxblocks, ei.fofs + ei.len - pgofs);
> >>  		map->m_flags = F2FS_MAP_MAPPED;
> >> +		if (map->m_next_pgofs)
> >> +			*map->m_next_pgofs = pgofs + map->m_len;
> >>  		goto out;
> >>  	}
> >>  
> >> @@ -964,6 +967,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
> >>  		goto unlock_out;
> >>  	}
> >>  
> >> +	start_pgofs = pgofs;
> >>  	prealloc = 0;
> >>  	last_ofs_in_node = ofs_in_node = dn.ofs_in_node;
> >>  	end_offset = ADDRS_PER_PAGE(dn.node_page, inode);
> >> @@ -997,6 +1001,8 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
> >>  				map->m_pblk = 0;
> >>  				goto sync_out;
> >>  			}
> >> +			if (flag == F2FS_GET_BLOCK_PRECACHE)
> >> +				goto sync_out;
> >>  			if (flag == F2FS_GET_BLOCK_FIEMAP &&
> >>  						blkaddr == NULL_ADDR) {
> >>  				if (map->m_next_pgofs)
> >> @@ -1055,6 +1061,16 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
> >>  	else if (dn.ofs_in_node < end_offset)
> >>  		goto next_block;
> >>  
> >> +	if (flag == F2FS_GET_BLOCK_PRECACHE) {
> >> +		if (map->m_flags & F2FS_MAP_MAPPED) {
> >> +			unsigned int ofs = start_pgofs - map->m_lblk;
> >> +
> >> +			f2fs_update_extent_cache_range(&dn,
> >> +				start_pgofs, map->m_pblk + ofs,
> >> +				map->m_len - ofs);
> >> +		}
> >> +	}
> >> +
> >>  	f2fs_put_dnode(&dn);
> >>  
> >>  	if (create) {
> >> @@ -1064,6 +1080,17 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
> >>  	goto next_dnode;
> >>  
> >>  sync_out:
> >> +	if (flag == F2FS_GET_BLOCK_PRECACHE) {
> >> +		if (map->m_flags & F2FS_MAP_MAPPED) {
> >> +			unsigned int ofs = start_pgofs - map->m_lblk;
> >> +
> >> +			f2fs_update_extent_cache_range(&dn,
> >> +				start_pgofs, map->m_pblk + ofs,
> >> +				map->m_len - ofs);
> >> +		}
> >> +		if (map->m_next_pgofs)
> >> +			*map->m_next_pgofs = pgofs + 1;
> >> +	}
> >>  	f2fs_put_dnode(&dn);
> >>  unlock_out:
> >>  	if (create) {
> >> @@ -1210,6 +1237,12 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> >>  
> >>  	inode_lock(inode);
> >>  
> >> +	if (fieinfo->fi_flags & FIEMAP_FLAG_CACHE) {
> >> +		ret = f2fs_precache_extents(inode);
> > 
> > We need to do inode_lock() in f2fs_precache_extents() after uncovering here?
> 
> > Uh? We don't need to cover fiemap_check_flags() by inode_lock().
> 
> Hmm, how about just following generic_block_fiemap using inode lock to
> cover whole block_fiemap including fiemap_check_flags, that can avoid
> leaving a hole in f2fs_fiemap after we add f2fs_precache_extents before
> fiemap_check_flags.

Do we really need inode_lock() for f2fs_precache_extents()? What about ioctl()
then? I think we can precache extents like a salt to speed up actual fiemap, so
we don't need inode_lock for that tho.

> 
> Thanks,
> 
> > 
> >> +		if (ret)
> >> +			goto out;
> >> +	}
> >> +
> >>  	ret = fiemap_check_flags(fieinfo, FIEMAP_FLAG_SYNC | FIEMAP_FLAG_XATTR);
> >>  	if (ret)
> >>  		goto out;
> >> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >> index 3b3ddcdc98e9..73a751cdbac1 100644
> >> --- a/fs/f2fs/f2fs.h
> >> +++ b/fs/f2fs/f2fs.h
> >> @@ -359,6 +359,7 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
> >>  						struct f2fs_gc_range)
> >>  #define F2FS_IOC_GET_FEATURES		_IOR(F2FS_IOCTL_MAGIC, 12, __u32)
> >>  #define F2FS_IOC_SET_PIN_FILE		_IOW(F2FS_IOCTL_MAGIC, 13, __u32)
> >> +#define F2FS_IOC_PRECACHE_EXTENTS	_IO(F2FS_IOCTL_MAGIC, 14)
> >>  
> >>  #define F2FS_IOC_SET_ENCRYPTION_POLICY	FS_IOC_SET_ENCRYPTION_POLICY
> >>  #define F2FS_IOC_GET_ENCRYPTION_POLICY	FS_IOC_GET_ENCRYPTION_POLICY
> >> @@ -564,6 +565,7 @@ enum {
> >>  	F2FS_GET_BLOCK_BMAP,
> >>  	F2FS_GET_BLOCK_PRE_DIO,
> >>  	F2FS_GET_BLOCK_PRE_AIO,
> >> +	F2FS_GET_BLOCK_PRECACHE,
> >>  };
> >>  
> >>  /*
> >> @@ -2567,6 +2569,7 @@ int f2fs_getattr(const struct path *path, struct kstat *stat,
> >>  int f2fs_setattr(struct dentry *dentry, struct iattr *attr);
> >>  int truncate_hole(struct inode *inode, pgoff_t pg_start, pgoff_t pg_end);
> >>  void truncate_data_blocks_range(struct dnode_of_data *dn, int count);
> >> +int f2fs_precache_extents(struct inode *inode);
> >>  long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
> >>  long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
> >>  int f2fs_pin_file_control(struct inode *inode, bool inc);
> >> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> >> index e4078b32856c..6e30016f26ad 100644
> >> --- a/fs/f2fs/file.c
> >> +++ b/fs/f2fs/file.c
> >> @@ -2734,6 +2734,42 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
> >>  	return ret;
> >>  }
> >>  
> >> +int f2fs_precache_extents(struct inode *inode)
> >> +{
> >> +	struct f2fs_inode_info *fi = F2FS_I(inode);
> >> +	struct f2fs_map_blocks map;
> >> +	pgoff_t next_pgofs;
> >> +	loff_t end;
> >> +	int err;
> >> +
> >> +	if (is_inode_flag_set(inode, FI_NO_EXTENT))
> >> +		return -EOPNOTSUPP;
> >> +
> >> +	map.m_lblk = 0;
> >> +	map.m_next_pgofs = &next_pgofs;
> >> +	map.m_seg_type = NO_CHECK_TYPE;
> >> +	end = F2FS_I_SB(inode)->max_file_blocks;
> >> +
> >> +	while (map.m_lblk < end) {
> >> +		map.m_len = end - map.m_lblk;
> >> +
> >> +		down_write(&fi->dio_rwsem[WRITE]);
> >> +		err = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_PRECACHE);
> >> +		up_write(&fi->dio_rwsem[WRITE]);
> >> +		if (err)
> >> +			return err;
> >> +
> >> +		map.m_lblk = next_pgofs;
> >> +	}
> >> +
> >> +	return err;
> >> +}
> >> +
> >> +static int f2fs_ioc_precache_extents(struct file *filp, unsigned long arg)
> >> +{
> >> +	return f2fs_precache_extents(file_inode(filp));
> >> +}
> >> +
> >>  long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> >>  {
> >>  	if (unlikely(f2fs_cp_error(F2FS_I_SB(file_inode(filp)))))
> >> @@ -2786,6 +2822,8 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> >>  		return f2fs_ioc_fssetxattr(filp, arg);
> >>  	case F2FS_IOC_SET_PIN_FILE:
> >>  		return f2fs_ioc_set_pin_file(filp, arg);
> >> +	case F2FS_IOC_PRECACHE_EXTENTS:
> >> +		return f2fs_ioc_precache_extents(filp, arg);
> >>  	default:
> >>  		return -ENOTTY;
> >>  	}
> >> @@ -2862,6 +2900,7 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> >>  	case F2FS_IOC_FSGETXATTR:
> >>  	case F2FS_IOC_FSSETXATTR:
> >>  	case F2FS_IOC_SET_PIN_FILE:
> >> +	case F2FS_IOC_PRECACHE_EXTENTS:
> >>  		break;
> >>  	default:
> >>  		return -ENOIOCTLCMD;
> >> -- 
> >> 2.15.0.55.gc2ece9dc4de6
> > 
> > .
> > 
