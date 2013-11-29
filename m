From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [f2fs-dev] [PATCH 2/5] f2fs: add unlikely macro for compiler
 optimization
Date: Fri, 29 Nov 2013 19:14:17 +0900
Message-ID: <1385720057.2417.46.camel@kjgkr>
References: <003301ceec0d$77ddaef0$67990cd0$@samsung.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <003301ceec0d$77ddaef0$67990cd0$@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, =?UTF-8?Q?=E8=B0=AD=E5=A7=9D?= <shu.tan@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

Could you make a patch to add *unlikely* as many as possible across the
whole source files at once?
It is wasteful to add it with a bunch of patches at multiple times.

And please write descriptions for all the patches even if nothing is
special.
In this case, why should we set *unlikely* for checking this condition?

Thanks,

2013-11-28 (=EB=AA=A9), 15:42 +0800, Chao Yu:
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  fs/f2fs/node.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 0fe9a97..954155b 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1160,7 +1160,7 @@ int wait_on_node_pages_writeback(struct f2fs_sb=
_info *sbi, nid_t ino)
>  			struct page *page =3D pvec.pages[i];
> =20
>  			/* until radix tree lookup accepts end_index */
> -			if (page->index > end)
> +			if (unlikely(page->index > end))
>  				continue;
> =20
>  			if (ino && ino_of_node(page) =3D=3D ino) {

--=20
Jaegeuk Kim
Samsung

--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
