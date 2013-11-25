From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [f2fs-dev][PATCH V2 3/6] f2fs: Add a new function:
 f2fs_reserve_block()
Date: Mon, 25 Nov 2013 20:05:06 +0900
Message-ID: <1385377506.26319.159.camel@kjgkr>
References: <1384096401-25169-1-git-send-email-huajun.li.lee@gmail.com>
 <1384096401-25169-4-git-send-email-huajun.li.lee@gmail.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <1384096401-25169-4-git-send-email-huajun.li.lee@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Huajun Li <huajun.li.lee@gmail.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Huajun Li <huajun.li@intel.com>, Haicheng Li <haicheng.li@linux.intel.com>, Weihong Xu <weihong.xu@intel.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Huajun,

I think this clean-up is not related to inline_data series, so I merged
this patch earlier.

Thanks,

2013-11-10 (=EC=9D=BC), 23:13 +0800, Huajun Li:
> From: Huajun Li <huajun.li@intel.com>
>=20
> Add the function f2fs_reserve_block() to easily reserve new blocks, a=
nd
> use it to clean up more codes.
>=20
> Signed-off-by: Huajun Li <huajun.li@intel.com>
> Signed-off-by: Haicheng Li <haicheng.li@linux.intel.com>
> Signed-off-by: Weihong Xu <weihong.xu@intel.com>
> ---
>  fs/f2fs/data.c |   50 +++++++++++++++++++++++-----------------------=
----
>  fs/f2fs/f2fs.h |    1 +
>  fs/f2fs/file.c |   38 ++++++--------------------------------
>  3 files changed, 30 insertions(+), 59 deletions(-)
>=20
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index aa3438c..92d0724 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -64,6 +64,22 @@ int reserve_new_block(struct dnode_of_data *dn)
>  	return 0;
>  }
> =20
> +int f2fs_reserve_block(struct dnode_of_data *dn, pgoff_t index)
> +{
> +	bool need_put =3D dn->inode_page ? false : true;
> +	int err;
> +
> +	err =3D get_dnode_of_data(dn, index, ALLOC_NODE);
> +	if (err)
> +		return err;
> +	if (dn->data_blkaddr =3D=3D NULL_ADDR)
> +		err =3D reserve_new_block(dn);
> +
> +	if (need_put)
> +		f2fs_put_dnode(dn);
> +	return err;
> +}
> +
>  static int check_extent_cache(struct inode *inode, pgoff_t pgofs,
>  					struct buffer_head *bh_result)
>  {
> @@ -300,19 +316,10 @@ struct page *get_new_data_page(struct inode *in=
ode,
>  	int err;
> =20
>  	set_new_dnode(&dn, inode, npage, npage, 0);
> -	err =3D get_dnode_of_data(&dn, index, ALLOC_NODE);
> +	err =3D f2fs_reserve_block(&dn, index);
>  	if (err)
>  		return ERR_PTR(err);
> =20
> -	if (dn.data_blkaddr =3D=3D NULL_ADDR) {
> -		if (reserve_new_block(&dn)) {
> -			if (!npage)
> -				f2fs_put_dnode(&dn);
> -			return ERR_PTR(-ENOSPC);
> -		}
> -	}
> -	if (!npage)
> -		f2fs_put_dnode(&dn);
>  repeat:
>  	page =3D grab_cache_page(mapping, index);
>  	if (!page)
> @@ -644,21 +651,15 @@ repeat:
>  	*pagep =3D page;
> =20
>  	f2fs_lock_op(sbi);
> -
>  	set_new_dnode(&dn, inode, NULL, NULL, 0);
> -	err =3D get_dnode_of_data(&dn, index, ALLOC_NODE);
> -	if (err)
> -		goto err;
> -
> -	if (dn.data_blkaddr =3D=3D NULL_ADDR)
> -		err =3D reserve_new_block(&dn);
> -
> -	f2fs_put_dnode(&dn);
> -	if (err)
> -		goto err;
> -
> +	err =3D f2fs_reserve_block(&dn, index);
>  	f2fs_unlock_op(sbi);
> =20
> +	if (err) {
> +		f2fs_put_page(page, 1);
> +		return err;
> +	}
> +
>  	if ((len =3D=3D PAGE_CACHE_SIZE) || PageUptodate(page))
>  		return 0;
> =20
> @@ -691,11 +692,6 @@ out:
>  	SetPageUptodate(page);
>  	clear_cold_data(page);
>  	return 0;
> -
> -err:
> -	f2fs_unlock_op(sbi);
> -	f2fs_put_page(page, 1);
> -	return err;
>  }
> =20
>  static int f2fs_write_end(struct file *file,
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index cd7d2f9..de84f52 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1119,6 +1119,7 @@ void destroy_checkpoint_caches(void);
>   * data.c
>   */
>  int reserve_new_block(struct dnode_of_data *);
> +int f2fs_reserve_block(struct dnode_of_data *, pgoff_t);
>  void update_extent_cache(block_t, struct dnode_of_data *);
>  struct page *find_data_page(struct inode *, pgoff_t, bool);
>  struct page *get_lock_data_page(struct inode *, pgoff_t);
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 7d714f4..1cd8e44 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -33,7 +33,6 @@ static int f2fs_vm_page_mkwrite(struct vm_area_stru=
ct *vma,
>  	struct page *page =3D vmf->page;
>  	struct inode *inode =3D file_inode(vma->vm_file);
>  	struct f2fs_sb_info *sbi =3D F2FS_SB(inode->i_sb);
> -	block_t old_blk_addr;
>  	struct dnode_of_data dn;
>  	int err;
> =20
> @@ -44,24 +43,10 @@ static int f2fs_vm_page_mkwrite(struct vm_area_st=
ruct *vma,
>  	/* block allocation */
>  	f2fs_lock_op(sbi);
>  	set_new_dnode(&dn, inode, NULL, NULL, 0);
> -	err =3D get_dnode_of_data(&dn, page->index, ALLOC_NODE);
> -	if (err) {
> -		f2fs_unlock_op(sbi);
> -		goto out;
> -	}
> -
> -	old_blk_addr =3D dn.data_blkaddr;
> -
> -	if (old_blk_addr =3D=3D NULL_ADDR) {
> -		err =3D reserve_new_block(&dn);
> -		if (err) {
> -			f2fs_put_dnode(&dn);
> -			f2fs_unlock_op(sbi);
> -			goto out;
> -		}
> -	}
> -	f2fs_put_dnode(&dn);
> +	err =3D f2fs_reserve_block(&dn, page->index);
>  	f2fs_unlock_op(sbi);
> +	if (err)
> +		goto out;
> =20
>  	file_update_time(vma->vm_file);
>  	lock_page(page);
> @@ -532,22 +517,11 @@ static int expand_inode_data(struct inode *inod=
e, loff_t offset,
> =20
>  		f2fs_lock_op(sbi);
>  		set_new_dnode(&dn, inode, NULL, NULL, 0);
> -		ret =3D get_dnode_of_data(&dn, index, ALLOC_NODE);
> -		if (ret) {
> -			f2fs_unlock_op(sbi);
> +		ret =3D f2fs_reserve_block(&dn, index);
> +		f2fs_unlock_op(sbi);
> +		if (ret)
>  			break;
> -		}
> =20
> -		if (dn.data_blkaddr =3D=3D NULL_ADDR) {
> -			ret =3D reserve_new_block(&dn);
> -			if (ret) {
> -				f2fs_put_dnode(&dn);
> -				f2fs_unlock_op(sbi);
> -				break;
> -			}
> -		}
> -		f2fs_put_dnode(&dn);
> -		f2fs_unlock_op(sbi);
> =20
>  		if (pg_start =3D=3D pg_end)
>  			new_size =3D offset + len;

--=20
Jaegeuk Kim
Samsung

--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
