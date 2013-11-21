From: Haicheng Li <haicheng.li@linux.intel.com>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: disable the extent cache ops on
 high fragmented files
Date: Thu, 21 Nov 2013 13:34:03 +0800
Message-ID: <20131121053402.GA9143@hli22-desktop>
References: <1384845037-7872-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1384845037-7872-1-git-send-email-jaegeuk.kim@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

> Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>

Function looks good to me. But some nitpicking below for code cleanup..

> @@ -71,6 +71,9 @@ static int check_extent_cache(struct inode *inode, pgoff_t pgofs,
return value could be boolean?
>  	pgoff_t start_fofs, end_fofs;
>  	block_t start_blkaddr;
>  
> +	if (is_inode_flag_set(fi, FI_NO_EXTENT))
> +		return 0;
> +
>  	read_lock(&fi->ext.ext_lock);
>  	if (fi->ext.len == 0) {
>  		read_unlock(&fi->ext.ext_lock);
> @@ -109,6 +112,7 @@ void update_extent_cache(block_t blk_addr, struct dnode_of_data *dn)
>  	struct f2fs_inode_info *fi = F2FS_I(dn->inode);
>  	pgoff_t fofs, start_fofs, end_fofs;
>  	block_t start_blkaddr, end_blkaddr;
> +	int need_update = true;
bool?
