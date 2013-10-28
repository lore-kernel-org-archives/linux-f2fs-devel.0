From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [f2fs-dev 5/5] f2fs: Handle inline data operations
Date: Mon, 28 Oct 2013 21:44:55 +0900
Message-ID: <1382964295.992.122.camel@kjgkr>
References: <1382716919-23345-1-git-send-email-huajun.li.lee@gmail.com>
 <1382716919-23345-6-git-send-email-huajun.li.lee@gmail.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1382716919-23345-6-git-send-email-huajun.li.lee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Huajun Li <huajun.li.lee@gmail.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Huajun Li <huajun.li@intel.com>, Haicheng Li <haicheng.li@linux.intel.com>, Weihong Xu <weihong.xu@intel.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

2013-10-26 (=ED=86=A0), 00:01 +0800, Huajun Li:
> From: Huajun Li <huajun.li@intel.com>
>=20

[snip]

> =20
> @@ -538,7 +553,7 @@ static int f2fs_write_data_page(struct page *page=
,
>  	loff_t i_size =3D i_size_read(inode);
>  	const pgoff_t end_index =3D ((unsigned long long) i_size)
>  							>> PAGE_CACHE_SHIFT;
> -	unsigned offset;
> +	unsigned offset =3D 0;
>  	bool need_balance_fs =3D false;
>  	int err =3D 0;
> =20
> @@ -572,7 +587,14 @@ write:
>  		err =3D do_write_data_page(page);
>  	} else {
>  		f2fs_lock_op(sbi);
> -		err =3D do_write_data_page(page);
> +		if (test_opt(sbi, INLINE_DATA) && (i_size <=3D MAX_INLINE_DATA)) {
> +			err =3D f2fs_write_inline_data(inode, page, offset);
> +			ClearPageDirty(page);

Don't need to call ClearPageDirty(page).

> +			f2fs_unlock_op(sbi);
> +			goto out;
> +		} else {
> +			err =3D do_write_data_page(page);
> +		}
>  		f2fs_unlock_op(sbi);
>  		need_balance_fs =3D true;
>  =09
--=20
Jaegeuk Kim
Samsung
