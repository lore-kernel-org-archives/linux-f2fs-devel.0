From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [f2fs-dev][PATCH V2 4/6] f2fs: Key functions to handle inline data
Date: Fri, 15 Nov 2013 16:49:09 +0900
Message-ID: <1384501749.14041.107.camel@kjgkr>
References: <1384096401-25169-1-git-send-email-huajun.li.lee@gmail.com>
 <1384096401-25169-5-git-send-email-huajun.li.lee@gmail.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <1384096401-25169-5-git-send-email-huajun.li.lee@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Huajun Li <huajun.li.lee@gmail.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Huajun Li <huajun.li@intel.com>, Haicheng Li <haicheng.li@linux.intel.com>, Weihong Xu <weihong.xu@intel.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Huajun,

[snip]

> +static int __f2fs_convert_inline_data(struct inode *inode, struct page *page)
> +{
> +	int err;
> +	struct page *ipage;
> +	struct dnode_of_data dn;
> +	void *src_addr, *dst_addr;
> +	block_t old_blk_addr, new_blk_addr;
> +	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
> +
> +	f2fs_lock_op(sbi);
> +	ipage = get_node_page(sbi, inode->i_ino);
> +	if (IS_ERR(ipage))
> +		return PTR_ERR(ipage);
> +
> +	/*
> +	 * i_addr[0] is not used for inline data,
> +	 * so reserving new block will not destroy inline data
> +	 */
> +	set_new_dnode(&dn, inode, ipage, ipage, 0);
> +	err = f2fs_reserve_block(&dn, 0);
> +	if (err) {
> +		f2fs_put_page(ipage, 1);
> +		f2fs_unlock_op(sbi);
> +		return err;
> +	}
> +
> +	src_addr = inline_data_addr(ipage);
> +	dst_addr = page_address(page);
> +	zero_user_segment(page, 0, PAGE_CACHE_SIZE);
> +
> +	/* Copy the whole inline data block */
> +	memcpy(dst_addr, src_addr, MAX_INLINE_DATA);
> +
> +	/* write data page to try to make data consistent */
> +	old_blk_addr = dn.data_blkaddr;
> +	set_page_writeback(page);
> +	write_data_page(inode, page, &dn,
> +			old_blk_addr, &new_blk_addr);
> +	update_extent_cache(new_blk_addr, &dn);
> +	f2fs_wait_on_page_writeback(page, DATA, true);
> +
> +	/* clear inline data and flag after data writeback */
> +	zero_user_segment(ipage, INLINE_DATA_OFFSET,
> +				 INLINE_DATA_OFFSET + MAX_INLINE_DATA);
> +	clear_inode_flag(F2FS_I(inode), FI_INLINE_DATA);
> +
> +	sync_inode_page(&dn);
> +	f2fs_put_page(ipage, 1);

Again, it seems that you missed what I mentioned.
If we write the inlined data block only, we cannot recover the data
block after SPO.
In order to avoid that, we should write its dnode block too by
triggering sync_node_pages(ino) at this point as similar as fsync
routine.

Thanks,

-- 
Jaegeuk Kim
Samsung

