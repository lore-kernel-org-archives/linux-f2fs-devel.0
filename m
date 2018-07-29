From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 3/4] f2fs: fix avoid race between truncate
 and background GC
Date: Sat, 28 Jul 2018 18:58:06 -0700
Message-ID: <20180729015806.GF83620@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180727101516.41403-1-yuchao0@huawei.com>
 <20180727101516.41403-3-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1fjayM-0005wv-Ic
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 29 Jul 2018 01:58:14 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fjayL-001Puk-4H
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 29 Jul 2018 01:58:14 +0000
Content-Disposition: inline
In-Reply-To: <20180727101516.41403-3-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 07/27, Chao Yu wrote:
> Thread A				Background GC
> - f2fs_setattr isize to 0
>  - truncate_setsize
> 					- gc_data_segment
> 					 - f2fs_get_read_data_page page #0
> 					  - set_page_dirty
> 					  - set_cold_data
>  - f2fs_truncate
> 
> - f2fs_setattr isize to 4k
> - read 4k <--- hit data in cached page #0
> 
> Above race condition can cause read out invalid data in a truncated
> page, fix it by i_gc_rwsem[WRITE] lock.

We can truncate pages again after f2fs_truncate()?

> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/data.c |  4 ++++
>  fs/f2fs/file.c | 33 +++++++++++++++++++--------------
>  2 files changed, 23 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 071224ded5f4..a29f3162b887 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2214,10 +2214,14 @@ static void f2fs_write_failed(struct address_space *mapping, loff_t to)
>  	loff_t i_size = i_size_read(inode);
>  
>  	if (to > i_size) {
> +		down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>  		down_write(&F2FS_I(inode)->i_mmap_sem);
> +
>  		truncate_pagecache(inode, i_size);
>  		f2fs_truncate_blocks(inode, i_size, true);
> +
>  		up_write(&F2FS_I(inode)->i_mmap_sem);
> +		up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>  	}
>  }
>  
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 7bd2412a8c37..ed5c9b0e0d0c 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -796,22 +796,25 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
>  	}
>  
>  	if (attr->ia_valid & ATTR_SIZE) {
> -		if (attr->ia_size <= i_size_read(inode)) {
> -			down_write(&F2FS_I(inode)->i_mmap_sem);
> -			truncate_setsize(inode, attr->ia_size);
> +		bool to_smaller = (attr->ia_size <= i_size_read(inode));
> +
> +		down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> +		down_write(&F2FS_I(inode)->i_mmap_sem);
> +
> +		truncate_setsize(inode, attr->ia_size);
> +
> +		if (to_smaller)
>  			err = f2fs_truncate(inode);
> -			up_write(&F2FS_I(inode)->i_mmap_sem);
> -			if (err)
> -				return err;
> -		} else {
> -			/*
> -			 * do not trim all blocks after i_size if target size is
> -			 * larger than i_size.
> -			 */
> -			down_write(&F2FS_I(inode)->i_mmap_sem);
> -			truncate_setsize(inode, attr->ia_size);
> -			up_write(&F2FS_I(inode)->i_mmap_sem);
> +		/*
> +		 * do not trim all blocks after i_size if target size is
> +		 * larger than i_size.
> +		 */
> +		up_write(&F2FS_I(inode)->i_mmap_sem);
> +		up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> +		if (err)
> +			return err;
>  
> +		if (!to_smaller) {
>  			/* should convert inline inode here */
>  			if (!f2fs_may_inline_data(inode)) {
>  				err = f2fs_convert_inline_inode(inode);
> @@ -958,6 +961,7 @@ static int punch_hole(struct inode *inode, loff_t offset, loff_t len)
>  
>  			blk_start = (loff_t)pg_start << PAGE_SHIFT;
>  			blk_end = (loff_t)pg_end << PAGE_SHIFT;
> +			down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>  			down_write(&F2FS_I(inode)->i_mmap_sem);
>  			truncate_inode_pages_range(mapping, blk_start,
>  					blk_end - 1);
> @@ -966,6 +970,7 @@ static int punch_hole(struct inode *inode, loff_t offset, loff_t len)
>  			ret = f2fs_truncate_hole(inode, pg_start, pg_end);
>  			f2fs_unlock_op(sbi);
>  			up_write(&F2FS_I(inode)->i_mmap_sem);
> +			up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>  		}
>  	}
>  
> -- 
> 2.18.0.rc1

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
