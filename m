From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [patch] f2fs: checking for IS_ERR() instead of NULL
Date: Thu, 09 Jan 2014 18:56:27 +0900
Message-ID: <1389261387.3035.7.camel@kjgkr>
References: <20140109052825.GB1265@elgon.mountain>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-reply-to: <20140109052825.GB1265@elgon.mountain>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, kernel-janitors@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Thank you for the patch.
This was already fixed in the original patch with an issue trigger by
Chao Yu before.
I rebased it before, so that it seems you need to pull the f2fs again.
Thanks,

2014-01-09 (=EB=AA=A9), 08:28 +0300, Dan Carpenter:
> grab_cache_page_write_begin() returns NULL on error, it doesn't retur=
n
> error pointers.
>=20
> Fixes: e18c65b2ac91 ('f2fs: key functions to handle inline data')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20
> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> index 69a923e38f0c..e0d800a1d79f 100644
> --- a/fs/f2fs/inline.c
> +++ b/fs/f2fs/inline.c
> @@ -131,8 +131,8 @@ int f2fs_convert_inline_data(struct inode *inode,=
 pgoff_t to_size)
>  		return 0;
> =20
>  	page =3D grab_cache_page_write_begin(inode->i_mapping, 0, AOP_FLAG_=
NOFS);
> -	if (IS_ERR(page))
> -		return PTR_ERR(page);
> +	if (!page)
> +		return -ENOMEM;
> =20
>  	err =3D __f2fs_convert_inline_data(inode, page);
>  	f2fs_put_page(page, 1);

--=20
Jaegeuk Kim
Samsung

--
To unsubscribe from this list: send the line "unsubscribe kernel-janito=
rs" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
