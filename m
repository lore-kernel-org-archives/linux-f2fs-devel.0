From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/4] f2fs: support F2FS_IOC_PRECACHE_EXTENTS
Date: Wed, 10 Jan 2018 14:22:32 +0800
Message-ID: <bdc4975a-50e5-bf9a-44eb-6250a7313822@huawei.com>
References: <20180108104834.108983-1-yuchao0@huawei.com>
 <20180109190728.GB86686@jaegeuk-macbookpro.roam.corp.google.com>
 <20180109204350.GA92235@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eZ9mp-0006Aw-QS
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 10 Jan 2018 06:22:55 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eZ9mo-0006mQ-CJ
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 10 Jan 2018 06:22:55 +0000
In-Reply-To: <20180109204350.GA92235@jaegeuk-macbookpro.roam.corp.google.com>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2018/1/10 4:43, Jaegeuk Kim wrote:
> On 01/09, Jaegeuk Kim wrote:
>> On 01/08, Chao Yu wrote:
>>> This patch introduces a new ioctl F2FS_IOC_PRECACHE_EXTENTS to precache
>>> extent info, in order to gain better performance during data/meta
>>> accessing.
>>>
>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>> ---
>>>  fs/f2fs/data.c | 27 +++++++++++++++++++++++++++
>>>  fs/f2fs/f2fs.h |  2 ++
>>>  fs/f2fs/file.c | 35 +++++++++++++++++++++++++++++++++++
>>>  3 files changed, 64 insertions(+)
>>>
>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>> index 429764118604..f38e660bc889 100644
>>> --- a/fs/f2fs/data.c
>>> +++ b/fs/f2fs/data.c
>>> @@ -920,6 +920,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>>>  	blkcnt_t prealloc;
>>>  	struct extent_info ei = {0,0,0};
>>>  	block_t blkaddr;
>>> +	unsigned int start_pgofs;
>>>  
>>>  	if (!maxblocks)
>>>  		return 0;
>>> @@ -935,6 +936,8 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>>>  		map->m_pblk = ei.blk + pgofs - ei.fofs;
>>>  		map->m_len = min((pgoff_t)maxblocks, ei.fofs + ei.len - pgofs);
>>>  		map->m_flags = F2FS_MAP_MAPPED;
>>> +		if (map->m_next_pgofs)
>>> +			*map->m_next_pgofs = pgofs + map->m_len;
>>>  		goto out;
>>>  	}
>>>  
>>> @@ -957,6 +960,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>>>  		goto unlock_out;
>>>  	}
>>>  
>>> +	start_pgofs = pgofs;
>>>  	prealloc = 0;
>>>  	last_ofs_in_node = ofs_in_node = dn.ofs_in_node;
>>>  	end_offset = ADDRS_PER_PAGE(dn.node_page, inode);
>>> @@ -990,6 +994,8 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>>>  				map->m_pblk = 0;
>>>  				goto sync_out;
>>>  			}
>>> +			if (flag == F2FS_GET_BLOCK_PRECACHE)
>>> +				goto sync_out;
>>>  			if (flag == F2FS_GET_BLOCK_FIEMAP &&
>>>  						blkaddr == NULL_ADDR) {
>>>  				if (map->m_next_pgofs)
>>> @@ -1048,6 +1054,16 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>>>  	else if (dn.ofs_in_node < end_offset)
>>>  		goto next_block;
>>>  
>>> +	if (flag == F2FS_GET_BLOCK_PRECACHE) {
>>> +		if (map->m_flags & F2FS_MAP_MAPPED) {
>>> +			unsigned int ofs = start_pgofs - map->m_lblk;
>>> +
>>> +			f2fs_update_extent_cache_range(&dn,
>>> +				start_pgofs, map->m_pblk + ofs,
>>> +				map->m_len - ofs);
>>> +		}
>>> +	}
>>> +
>>>  	f2fs_put_dnode(&dn);
>>>  
>>>  	if (create) {
>>> @@ -1057,6 +1073,17 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>>>  	goto next_dnode;
>>>  
>>>  sync_out:
>>> +	if (flag == F2FS_GET_BLOCK_PRECACHE) {
>>> +		if (map->m_flags & F2FS_MAP_MAPPED) {
>>> +			unsigned int ofs = start_pgofs - map->m_lblk;
>>> +
>>> +			f2fs_update_extent_cache_range(&dn,
>>> +				start_pgofs, map->m_pblk + ofs,
>>> +				map->m_len - ofs);
>>> +		}
>>> +		if (map->m_next_pgofs)
>>> +			*map->m_next_pgofs = pgofs + 1;
>>> +	}
>>>  	f2fs_put_dnode(&dn);
>>>  unlock_out:
>>>  	if (create) {
>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>> index 2f097139b8f7..14177cebc3e7 100644
>>> --- a/fs/f2fs/f2fs.h
>>> +++ b/fs/f2fs/f2fs.h
>>> @@ -353,6 +353,7 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
>>>  						struct f2fs_gc_range)
>>>  #define F2FS_IOC_GET_FEATURES		_IOR(F2FS_IOCTL_MAGIC, 12, __u32)
>>>  #define F2FS_IOC_SET_PIN_FILE		_IOW(F2FS_IOCTL_MAGIC, 13, __u32)
>>> +#define F2FS_IOC_PRECACHE_EXTENTS	_IO(F2FS_IOCTL_MAGIC, 14)
>>>  
>>>  #define F2FS_IOC_SET_ENCRYPTION_POLICY	FS_IOC_SET_ENCRYPTION_POLICY
>>>  #define F2FS_IOC_GET_ENCRYPTION_POLICY	FS_IOC_GET_ENCRYPTION_POLICY
>>> @@ -558,6 +559,7 @@ enum {
>>>  	F2FS_GET_BLOCK_BMAP,
>>>  	F2FS_GET_BLOCK_PRE_DIO,
>>>  	F2FS_GET_BLOCK_PRE_AIO,
>>> +	F2FS_GET_BLOCK_PRECACHE,
>>>  };
>>>  
>>>  /*
>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>> index e4078b32856c..14e75871acf3 100644
>>> --- a/fs/f2fs/file.c
>>> +++ b/fs/f2fs/file.c
>>> @@ -2734,6 +2734,38 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
>>>  	return ret;
>>>  }
>>>  
>>> +static int f2fs_ioc_precache_extents(struct file *filp, unsigned long arg)
>>> +{
>>> +	struct inode *inode = file_inode(filp);
>>> +	struct f2fs_inode_info *fi = F2FS_I(inode);
>>> +	struct f2fs_map_blocks map;
>>> +	pgoff_t next_pgofs;
>>> +	loff_t end;
>>> +	int err;
>>> +
>>> +	if (is_inode_flag_set(inode, FI_NO_EXTENT))
>>> +		return -EOPNOTSUPP;
>>> +
>>> +	map.m_lblk = 0;
>>> +	map.m_next_pgofs = &next_pgofs;
>>> +	map.m_seg_type = NO_CHECK_TYPE;
>>> +	end = F2FS_I_SB(inode)->max_file_blocks;
>>> +
>>> +	while (map.m_lblk < end) {
>>> +		map.m_len = end - map.m_lblk;
>>> +
>>> +		down_write(&fi->dio_rwsem[WRITE]);
>>> +		err = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_PRECACHE);
>>> +		up_write(&fi->dio_rwsem[WRITE]);
>>> +		if (err)
>>> +			return err;
>>> +
>>> +		map.m_lblk = next_pgofs;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>  long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>>>  {
>>>  	if (unlikely(f2fs_cp_error(F2FS_I_SB(file_inode(filp)))))
>>> @@ -2786,6 +2818,8 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>>>  		return f2fs_ioc_fssetxattr(filp, arg);
>>>  	case F2FS_IOC_SET_PIN_FILE:
>>>  		return f2fs_ioc_set_pin_file(filp, arg);
>>> +	case F2FS_IOC_PRECACHE_EXTENTS:
>>
>> It looks like F2FS_IOC_CACHE_EXTENTS, and would be better to have an offset
>> range to look up. BTW, if this is to prepare coming data reads, how about doing
>> this through fadvise(POSIX_FADV_WILLNEED) instead of additional ioctl?
>> It seems we can cache extents if the page is marked as PageReadahead().
> 
> Oh, I just got noticed that this just follows ext4 implementation. Please
> write an integrated patch which introduces this with fiemap and adds description
> regarding to ext4.

Done, please help to check it. ;)

Thanks,

> 
> Thanks,
> 
>>
>> Thanks,
>>
>>> +		return f2fs_ioc_precache_extents(filp, arg);
>>>  	default:
>>>  		return -ENOTTY;
>>>  	}
>>> @@ -2862,6 +2896,7 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>>>  	case F2FS_IOC_FSGETXATTR:
>>>  	case F2FS_IOC_FSSETXATTR:
>>>  	case F2FS_IOC_SET_PIN_FILE:
>>> +	case F2FS_IOC_PRECACHE_EXTENTS:
>>>  		break;
>>>  	default:
>>>  		return -ENOIOCTLCMD;
>>> -- 
>>> 2.15.0.55.gc2ece9dc4de6
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
