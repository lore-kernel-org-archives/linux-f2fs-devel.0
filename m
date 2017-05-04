From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 1/3] f2fs:dax: fix races between page faults
 and fallocate
Date: Thu, 4 May 2017 10:59:17 -0700
Message-ID: <20170504175917.GB7464@jaegeuk.local>
References: <1493857019-40586-1-git-send-email-sunqiuyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1493857019-40586-1-git-send-email-sunqiuyang@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: sunqiuyang <sunqiuyang@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, wenyuzhong1@huawei.com, wangxiaojun11@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com, guzheng1@huawei.com, yanaijie@huawei.com, zhaohongjiang@huawei.com, dingxiang@huawei.com, wangyijing@huawei.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Qiuyang,

When I checked i_mmap_sem in ext4, do we also check it in:

 f2fs_vm_page_mkwrite
 filemap_fault
 f2fs_setattr
 f2fs_add_inline_entries

It needs to think about how to reduce lock coverage below as well.

Thanks,

On 05/04, sunqiuyang wrote:
> Currently in F2FS, page faults and fallocate operations, like punch_hole 
> and collapse/insert/zero_range, are completely unsynchronized. This can 
> result in page fault faulting in a page into a range that we are changing 
> after truncating pagecache, and thus we can end up with a page mapped to 
> disk blocks that will be shortly freed. Filesystem corruption will shortly 
> follow. 
> 
> This patch fixes the problem by creating new rw semaphore i_mmap_sem in 
> f2fs_inode_info and grab it for functions removing blocks from extent tree 
> and for read over page faults. The mechanism is similar to that in ext4.
> 
> Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>
> ---
>  fs/f2fs/f2fs.h  |  1 +
>  fs/f2fs/file.c  | 30 +++++++++++++++++++++---------
>  fs/f2fs/super.c |  1 +
>  3 files changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 0a6e115..f7957ca 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -474,6 +474,7 @@ struct f2fs_inode_info {
>  	struct mutex inmem_lock;	/* lock for inmemory pages */
>  	struct extent_tree *extent_tree;	/* cached extent_tree entry */
>  	struct rw_semaphore dio_rwsem[2];/* avoid racing between dio and gc */
> +	struct rw_semaphore i_mmap_sem;
>  };
>  
>  static inline void get_extent_info(struct extent_info *ext,
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 5f73178..165acbf 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -813,22 +813,23 @@ static int punch_hole(struct inode *inode, loff_t offset, loff_t len)
>  	off_start = offset & (PAGE_SIZE - 1);
>  	off_end = (offset + len) & (PAGE_SIZE - 1);
>  
> +	down_write(&F2FS_I(inode)->i_mmap_sem);
>  	if (pg_start == pg_end) {
>  		ret = fill_zero(inode, pg_start, off_start,
>  						off_end - off_start);
>  		if (ret)
> -			return ret;
> +			goto out;
>  	} else {
>  		if (off_start) {
>  			ret = fill_zero(inode, pg_start++, off_start,
>  						PAGE_SIZE - off_start);
>  			if (ret)
> -				return ret;
> +				goto out;
>  		}
>  		if (off_end) {
>  			ret = fill_zero(inode, pg_end, 0, off_end);
>  			if (ret)
> -				return ret;
> +				goto out;
>  		}
>  
>  		if (pg_start < pg_end) {
> @@ -849,6 +850,8 @@ static int punch_hole(struct inode *inode, loff_t offset, loff_t len)
>  		}
>  	}
>  
> +out:
> +	up_write(&F2FS_I(inode)->i_mmap_sem);
>  	return ret;
>  }
>  
> @@ -1084,16 +1087,17 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
>  	pg_start = offset >> PAGE_SHIFT;
>  	pg_end = (offset + len) >> PAGE_SHIFT;
>  
> +	down_write(&F2FS_I(inode)->i_mmap_sem);
>  	/* write out all dirty pages from offset */
>  	ret = filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
>  	if (ret)
> -		return ret;
> +		goto out;
>  
>  	truncate_pagecache(inode, offset);
>  
>  	ret = f2fs_do_collapse(inode, pg_start, pg_end);
>  	if (ret)
> -		return ret;
> +		goto out;
>  
>  	/* write out all moved pages, if possible */
>  	filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
> @@ -1106,6 +1110,8 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
>  	if (!ret)
>  		f2fs_i_size_write(inode, new_size);
>  
> +out:
> +	up_write(&F2FS_I(inode)->i_mmap_sem);
>  	return ret;
>  }
>  
> @@ -1182,11 +1188,12 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
>  	off_start = offset & (PAGE_SIZE - 1);
>  	off_end = (offset + len) & (PAGE_SIZE - 1);
>  
> +	down_write(&F2FS_I(inode)->i_mmap_sem);
>  	if (pg_start == pg_end) {
>  		ret = fill_zero(inode, pg_start, off_start,
>  						off_end - off_start);
>  		if (ret)
> -			return ret;
> +			goto unlock;
>  
>  		if (offset + len > new_size)
>  			new_size = offset + len;
> @@ -1196,7 +1203,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
>  			ret = fill_zero(inode, pg_start++, off_start,
>  						PAGE_SIZE - off_start);
>  			if (ret)
> -				return ret;
> +				goto unlock;
>  
>  			new_size = max_t(loff_t, new_size,
>  					(loff_t)pg_start << PAGE_SHIFT);
> @@ -1245,6 +1252,8 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
>  out:
>  	if (!(mode & FALLOC_FL_KEEP_SIZE) && i_size_read(inode) < new_size)
>  		f2fs_i_size_write(inode, new_size);
> +unlock:
> +	up_write(&F2FS_I(inode)->i_mmap_sem);
>  
>  	return ret;
>  }
> @@ -1271,16 +1280,17 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
>  	if (ret)
>  		return ret;
>  
> +	down_write(&F2FS_I(inode)->i_mmap_sem);
>  	f2fs_balance_fs(sbi, true);
>  
>  	ret = truncate_blocks(inode, i_size_read(inode), true);
>  	if (ret)
> -		return ret;
> +		goto out;
>  
>  	/* write out all dirty pages from offset */
>  	ret = filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
>  	if (ret)
> -		return ret;
> +		goto out;
>  
>  	truncate_pagecache(inode, offset);
>  
> @@ -1309,6 +1319,8 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
>  
>  	if (!ret)
>  		f2fs_i_size_write(inode, new_size);
> +out:
> +	up_write(&F2FS_I(inode)->i_mmap_sem);
>  	return ret;
>  }
>  
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 96fe8ed..30855cf 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -616,6 +616,7 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
>  	mutex_init(&fi->inmem_lock);
>  	init_rwsem(&fi->dio_rwsem[READ]);
>  	init_rwsem(&fi->dio_rwsem[WRITE]);
> +	init_rwsem(&fi->i_mmap_sem);
>  
>  	/* Will be used by directory only */
>  	fi->i_dir_level = F2FS_SB(sb)->dir_level;
> -- 
> 1.8.3.1
> 
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
