From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 3/4] f2fs: avoid f2fs_lock_op in f2fs_write_begin
Date: Thu, 24 Dec 2015 13:50:32 +0800
Message-ID: <015501d13e0f$1b755180$525ff480$@samsung.com>
References: <1450923320-41113-1-git-send-email-jaegeuk@kernel.org>
 <1450923320-41113-3-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1450923320-41113-3-git-send-email-jaegeuk@kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Thursday, December 24, 2015 10:15 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 3/4] f2fs: avoid f2fs_lock_op in f2fs_write_begin
> 
> If f2fs_write_begin is to update data, we can bypass calling f2fs_lock_op() in
> order to avoid the checkpoint latency in the write syscall.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/data.c | 43 ++++++++++++++++++++++++++++++++++---------
>  1 file changed, 34 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 49092da..d53cf4f 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1418,10 +1418,16 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
>  	pgoff_t index = page->index;
>  	struct dnode_of_data dn;
>  	struct page *ipage;
> +	bool locked = false;
> +	struct extent_info ei;
>  	int err = 0;
> 
> -	f2fs_lock_op(sbi);
> -
> +	if (f2fs_has_inline_data(inode) ||
> +			(pos & PAGE_CACHE_MASK) >= i_size_read(inode)) {
> +		f2fs_lock_op(sbi);
> +		locked = true;
> +	}
> +restart:
>  	/* check inline_data */
>  	ipage = get_node_page(sbi, inode->i_ino);
>  	if (IS_ERR(ipage)) {
> @@ -1436,22 +1442,41 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
>  			read_inline_data(page, ipage);
>  			set_inode_flag(F2FS_I(inode), FI_DATA_EXIST);
>  			sync_inode_page(&dn);
> -			goto done;
>  		} else {
>  			err = f2fs_convert_inline_page(&dn, page);
>  			if (err)
> -				goto err_out;
> +				goto out;
> +			err = f2fs_get_block(&dn, index);

Seems after f2fs_convert_inline_page, data_blkaddr and node_changed should
have been set, so f2fs_get_block could be removed here.

> +		}
> +	} else if (locked) {
> +		err = f2fs_get_block(&dn, index);
> +	} else {
> +		if (f2fs_lookup_extent_cache(inode, index, &ei)) {
> +			dn.data_blkaddr = ei.blk + index - ei.fofs;
> +		} else {
> +			bool restart = false;
> +
> +			/* hole case */
> +			err = get_dnode_of_data(&dn, index, LOOKUP_NODE);

Better to handle error case like -ENOMEM or -EIO.

Thanks,

> +			if (err || (!err && dn.data_blkaddr == NULL_ADDR))
> +				restart = true;
> +			if (restart) {
> +				f2fs_put_dnode(&dn);
> +				f2fs_lock_op(sbi);
> +				locked = true;
> +				goto restart;
> +			}
>  		}
>  	}
> -	err = f2fs_get_block(&dn, index);
> -done:
> +
>  	/* convert_inline_page can make node_changed */
>  	*blk_addr = dn.data_blkaddr;
>  	*node_changed = dn.node_changed;
> -err_out:
> +out:
>  	f2fs_put_dnode(&dn);
>  unlock_out:
> -	f2fs_unlock_op(sbi);
> +	if (locked)
> +		f2fs_unlock_op(sbi);
>  	return err;
>  }
> 
> @@ -1488,7 +1513,7 @@ repeat:
> 
>  	*pagep = page;
> 
> -	err = prepare_write_begin(sbi, page, pos + len,
> +	err = prepare_write_begin(sbi, page, pos,  len,
>  					&blkaddr, &need_balance);
>  	if (err)
>  		goto fail;
> --
> 2.5.4 (Apple Git-61)
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
