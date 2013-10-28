From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [f2fs-dev 4/5] f2fs: Key functions to handle inline data
Date: Mon, 28 Oct 2013 21:43:18 +0900
Message-ID: <1382964198.992.121.camel@kjgkr>
References: <1382716919-23345-1-git-send-email-huajun.li.lee@gmail.com>
 <1382716919-23345-5-git-send-email-huajun.li.lee@gmail.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1382716919-23345-5-git-send-email-huajun.li.lee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Huajun Li <huajun.li.lee@gmail.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Huajun Li <huajun.li@intel.com>, Haicheng Li <haicheng.li@linux.intel.com>, Weihong Xu <weihong.xu@intel.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

2013-10-26 (=ED=86=A0), 00:01 +0800, Huajun Li:
> From: Huajun Li <huajun.li@intel.com>
>=20
> Functions to implement inline data read/write, and move inline data t=
o
> normal data block when file size exceeds inline data limitation.
>=20
> Signed-off-by: Huajun Li <huajun.li@intel.com>
> Signed-off-by: Haicheng Li <haicheng.li@linux.intel.com>
> Signed-off-by: Weihong Xu <weihong.xu@intel.com>
> ---
>  fs/f2fs/Makefile |    2 +-
>  fs/f2fs/f2fs.h   |    7 +++
>  fs/f2fs/inline.c |  144 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++++
>  3 files changed, 152 insertions(+), 1 deletion(-)
>  create mode 100644 fs/f2fs/inline.c
>=20

[snip]

> +static int __f2fs_convert_inline_data(struct inode *inode, struct pa=
ge *page)
> +{
> +	int err;
> +	struct page *ipage;
> +	struct dnode_of_data dn;
> +	void *src_addr, *dst_addr;
> +	struct f2fs_sb_info *sbi =3D F2FS_SB(inode->i_sb);
> +

Here..	f2fs_lock_op(sbi);

> +	ipage =3D get_node_page(sbi, inode->i_ino);
> +	if (IS_ERR(ipage))
> +		return PTR_ERR(ipage);
> +

Need to move f2fs_lock_op prior to get_node_page.

> +	/* i_addr[0] is not used for inline data,

Coding style.
         /*
          * ...
          */

> +	 * so reserving new block will not destroy inline data */
> +	err =3D f2fs_reserve_block(inode, &dn, 0);
> +	if (err) {
> +		f2fs_put_page(ipage, 1);
> +		f2fs_unlock_op(sbi);
> +		return err;
> +	}

Need to move this too.

> +
> +	src_addr =3D inline_data_addr(ipage);
> +	dst_addr =3D page_address(page);
> +	zero_user_segment(page, 0, PAGE_CACHE_SIZE);

+ space for readability.

> +	/* Copy the whole inline data block */
> +	memcpy(dst_addr, src_addr, MAX_INLINE_DATA);
> +	zero_user_segment(ipage, INLINE_DATA_OFFSET,
> +				 INLINE_DATA_OFFSET + MAX_INLINE_DATA);
> +	clear_inode_flag(F2FS_I(inode), FI_INLINE_DATA);
> +	set_raw_inline(F2FS_I(inode),
> +			(struct f2fs_inode *)page_address(ipage));

   --> sync_inode_page()?

> +
> +	set_page_dirty(ipage);
> +	f2fs_put_page(ipage, 1);
> +	set_page_dirty(page);

Here...	f2fs_unlock_op(sbi);

Here, we need to consider data consistency.
Let's think about the below scenario.
1. inline_data was written.
2. sync_fs is done.
3. additional data were written.
  : this triggers f2fs_convert_inline_data(), produces a page, and then
unsets the inline flag.
4. checkpoint was done with updated inode page. Note that, checkpoint
doesn't guarantee any user data.
5. sudden power-off is occurred.
  -> Once power-off-recovery is done, we loose the inline_data which wa=
s
written successfully at step #2.

So, I think we need to do f2fs_sync_file() procedure at this moment.
Any idea?

> +
> +	return 0;
> +}
> +
> +int f2fs_convert_inline_data(struct inode *inode,
> +			     struct page *p, unsigned flags)
> +{
> +	int err;
> +	struct page *page;
> +
> +	if (p && !p->index) {
> +		page =3D p;
> +	} else {
> +		page =3D grab_cache_page_write_begin(inode->i_mapping, 0, flags);
> +		if (IS_ERR(page))
> +			return PTR_ERR(page);
> +	}
> +
> +	err =3D __f2fs_convert_inline_data(inode, page);
> +
> +	if (p && !p->index)
> +		f2fs_put_page(page, 1);
> +
> +	return err;
> +}
> +
> +int f2fs_write_inline_data(struct inode *inode,
> +			   struct page *page, unsigned size)
> +{
> +	void *src_addr, *dst_addr;
> +	struct page *ipage;
> +	struct dnode_of_data dn;
> +	int err;
> +
> +	set_new_dnode(&dn, inode, NULL, NULL, 0);
> +	err =3D get_dnode_of_data(&dn, 0, LOOKUP_NODE);
> +	if (err)
> +		return err;
> +	ipage =3D dn.inode_page;
> +
> +	src_addr =3D page_address(page);
> +	dst_addr =3D inline_data_addr(ipage);
> +
> +	zero_user_segment(ipage, INLINE_DATA_OFFSET,
> +				 INLINE_DATA_OFFSET + MAX_INLINE_DATA);
> +	memcpy(dst_addr, src_addr, size);
> +	if (!f2fs_has_inline_data(inode))
> +		set_inode_flag(F2FS_I(inode), FI_INLINE_DATA);
> +	set_raw_inline(F2FS_I(inode),
> +			(struct f2fs_inode *)page_address(ipage));
> +	set_page_dirty(ipage);
> +
> +	if ((F2FS_I(inode)->i_xattr_nid && inode->i_blocks =3D=3D 2) ||
> +		(!F2FS_I(inode)->i_xattr_nid && inode->i_blocks =3D=3D 1)) {
> +		f2fs_put_dnode(&dn);
> +		return 0;
> +	}
> +
> +	/* Release the first data block if it is allocated */
> +	truncate_data_blocks_range(&dn, 1);
> +	f2fs_put_dnode(&dn);
> +
> +	return 0;
> +}

--=20
Jaegeuk Kim
Samsung
