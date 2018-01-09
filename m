From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2] f2fs: support FIEMAP_FLAG_XATTR
Date: Tue, 9 Jan 2018 10:11:00 -0800
Message-ID: <20180109181100.GA86686@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180108104809.108904-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180108104809.108904-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 01/08, Chao Yu wrote:
> This patch enables ->fiemap to handle FIEMAP_FLAG_XATTR flag for xattr
> mapping info lookup purpose.
> 
> It makes f2fs passing generic/425 test in fstest.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
> v2: adjust f2fs_xattr_fiemap flow to handle the case that inline xattr and
> xattr node both exist.
>  fs/f2fs/data.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 71 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index cd988bc1922b..429764118604 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1129,6 +1129,68 @@ static inline loff_t blk_to_logical(struct inode *inode, sector_t blk)
>  	return (blk << inode->i_blkbits);
>  }
>  
> +static int f2fs_xattr_fiemap(struct inode *inode,
> +				struct fiemap_extent_info *fieinfo)
> +{
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +	struct page *page;
> +	struct node_info ni;
> +	__u64 phys = 0, len;
> +	__u32 flags;
> +	nid_t xnid = F2FS_I(inode)->i_xattr_nid;
> +	int err = 0;
> +
> +	if (f2fs_has_inline_xattr(inode)) {
> +		int offset;
> +
> +		page = f2fs_grab_cache_page(NODE_MAPPING(sbi),
> +						inode->i_ino, false);
> +		if (!page)
> +			return -ENOMEM;
> +
> +		get_node_info(sbi, inode->i_ino, &ni);
> +
> +		phys = (__u64)blk_to_logical(inode, ni.blk_addr);
> +		offset = offsetof(struct f2fs_inode, i_addr) +
> +					sizeof(__le32) * (DEF_ADDRS_PER_INODE -
> +					F2FS_INLINE_XATTR_ADDRS(inode));
> +
> +		phys += offset;
> +		len = inline_xattr_size(inode);
> +
> +		f2fs_put_page(page, 1);
> +
> +		flags = FIEMAP_EXTENT_DATA_INLINE;
> +
> +		if (!xnid)
> +			flags |= FIEMAP_EXTENT_LAST;
> +
> +		err = fiemap_fill_next_extent(fieinfo, 0, phys, len, flags);
> +		if (err || err == 1)
> +			return err;
> +	}
> +
> +	if (xnid) {
> +		page = f2fs_grab_cache_page(NODE_MAPPING(sbi), xnid, false);
> +		if (!page)
> +			return -ENOMEM;
> +
> +		get_node_info(sbi, xnid, &ni);
> +
> +		phys = (__u64)blk_to_logical(inode, ni.blk_addr);
> +		len = inode->i_sb->s_blocksize;
> +
> +		f2fs_put_page(page, 1);
> +
> +		flags = FIEMAP_EXTENT_LAST;
> +	}
> +
> +	if (phys)
> +		err = fiemap_fill_next_extent(fieinfo, 0, phys, len, flags);
> +
> +	return (err < 0 ? err : 0);
> +}
> +
>  int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  		u64 start, u64 len)
>  {
> @@ -1139,18 +1201,23 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  	u32 flags = 0;
>  	int ret = 0;
>  
> -	ret = fiemap_check_flags(fieinfo, FIEMAP_FLAG_SYNC);
> +	ret = fiemap_check_flags(fieinfo, FIEMAP_FLAG_SYNC | FIEMAP_FLAG_XATTR);
>  	if (ret)
>  		return ret;
>  
> +	inode_lock(inode);
> +
> +	if (fieinfo->fi_flags & FIEMAP_FLAG_XATTR) {
> +		ret = f2fs_xattr_fiemap(inode, fieinfo);
> +		goto out;
> +	}
> +

We need to fix calling inode_lock() for the below block first?

>  	if (f2fs_has_inline_data(inode)) {
>  		ret = f2fs_inline_data_fiemap(inode, fieinfo, start, len);
>  		if (ret != -EAGAIN)
> -			return ret;
> +			goto out;
>  	}
>  
> -	inode_lock(inode);
> -
>  	if (logical_to_blk(inode, len) == 0)
>  		len = blk_to_logical(inode, 1);
>  
> -- 
> 2.15.0.55.gc2ece9dc4de6
