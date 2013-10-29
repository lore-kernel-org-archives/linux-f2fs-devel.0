From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: RE: [f2fs-dev] [PATCH] f2fs:fix truncate_partial_nodes bug
Date: Tue, 29 Oct 2013 16:43:17 +0900
Message-ID: <1383032597.14041.12.camel@kjgkr>
References: <27929860.72301382948116848.JavaMail.weblogic@epml07>
 <1382955704.992.91.camel@kjgkr>
 <000101ced479$26555160$72fff420$%ge@samsung.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <000101ced479$26555160$72fff420$%ge@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "shifei10.ge" <shifei10.ge@samsung.com>
Cc: '??' <shu.tan@samsung.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

2013-10-29 (=ED=99=94), 15:32 +0800, shifei10.ge:
> Hi,I think we don't need to put the invalid page that get_node_page r=
eturned.
> So I add " idx =3D i--" based on your version.Following is the patch:=
=20
>=20
> ---
>  fs/f2fs/node.c |   13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 304d5ce..fd5f721 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -631,19 +631,19 @@ static int truncate_partial_nodes(struct dnode_=
of_data *dn,
>  		return 0;
> =20
>  	/* get indirect nodes in the path */
> -	for (i =3D 0; i < depth - 1; i++) {
> +	for (i =3D 0; i < idx + 1; i++) {
>  		/* refernece count'll be increased */
>  		pages[i] =3D get_node_page(sbi, nid[i]);
>  		if (IS_ERR(pages[i])) {
> -			depth =3D i + 1;
>  			err =3D PTR_ERR(pages[i]);
> +			idx =3D i--;

You meant (idx =3D i - 1)?
If so, idx =3D i--; is wrong.

--=20
Jaegeuk Kim
Samsung
