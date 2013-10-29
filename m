From: "shifei10.ge" <shifei10.ge@samsung.com>
Subject: RE: [f2fs-dev] [PATCH] f2fs:fix truncate_partial_nodes bug
Date: Tue, 29 Oct 2013 15:32:34 +0800
Message-ID: <000101ced479$26555160$72fff420$%ge@samsung.com>
References: <27929860.72301382948116848.JavaMail.weblogic@epml07>
 <1382955704.992.91.camel@kjgkr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1382955704.992.91.camel@kjgkr>
Content-language: en-us
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk.kim@samsung.com
Cc: '??' <shu.tan@samsung.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,I think we don't need to put the invalid page that get_node_page ret=
urned.
So I add " idx =3D i--" based on your version.Following is the patch:=20

---
 fs/f2fs/node.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 304d5ce..fd5f721 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -631,19 +631,19 @@ static int truncate_partial_nodes(struct dnode_of=
_data *dn,
 		return 0;
=20
 	/* get indirect nodes in the path */
-	for (i =3D 0; i < depth - 1; i++) {
+	for (i =3D 0; i < idx + 1; i++) {
 		/* refernece count'll be increased */
 		pages[i] =3D get_node_page(sbi, nid[i]);
 		if (IS_ERR(pages[i])) {
-			depth =3D i + 1;
 			err =3D PTR_ERR(pages[i]);
+			idx =3D i--;
 			goto fail;
 		}
 		nid[i + 1] =3D get_nid(pages[i], offset[i + 1], false);
 	}
=20
 	/* free direct nodes linked to a partial indirect node */
-	for (i =3D offset[depth - 1]; i < NIDS_PER_BLOCK; i++) {
+	for (i =3D offset[idx + 1]; i < NIDS_PER_BLOCK; i++) {
 		child_nid =3D get_nid(pages[idx], i, false);
 		if (!child_nid)
 			continue;
@@ -654,7 +654,7 @@ static int truncate_partial_nodes(struct dnode_of_d=
ata *dn,
 		set_nid(pages[idx], i, 0, false);
 	}
=20
-	if (offset[depth - 1] =3D=3D 0) {
+	if (offset[idx + 1] =3D=3D 0) {
 		dn->node_page =3D pages[idx];
 		dn->nid =3D nid[idx];
 		truncate_node(dn);
@@ -662,9 +662,10 @@ static int truncate_partial_nodes(struct dnode_of_=
data *dn,
 		f2fs_put_page(pages[idx], 1);
 	}
 	offset[idx]++;
-	offset[depth - 1] =3D 0;
+	offset[idx + 1] =3D 0;
+	idx--;
 fail:
-	for (i =3D depth - 3; i >=3D 0; i--)
+	for (i =3D idx; i >=3D 0; i--)=09
 		f2fs_put_page(pages[i], 1);
=20
 	trace_f2fs_truncate_partial_nodes(dn->inode, nid, depth, err);
--=20
1.7.9.5


> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk.kim@samsung.com]
> Sent: Monday, October 28, 2013 6:22 PM
> To: shifei10.ge@samsung.com
> Cc: ??; linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org; =
linux-
> f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH] f2fs:fix truncate_partial_nodes bug
>=20
> Hi,
>=20
> 2013-10-28 (=EC=9B=94), 08:15 +0000, Shifei Ge:
> > truncate_partial_nodes puts pages incorrectly in two cases.note tha=
t the
> value for argc 'depth' can only be 2 or 3(see truncate_inode_blocks -=
--
> >truncate_partial_nodes ).
> > first case:err happened in the first 'for' loop
> > 	assume depth is 2,when err happened,pages[0] is invalid,so this pa=
ge
> don't need to be put when func return,there is no problem.
> > 	but when depth is 3 ,pages isn't put correctly when pages[0] is va=
lid
> and pages[1] is invalid.in this case,depth is set to 2(ref to statemn=
t depth =3D
> i + 1) ,and then 'goto fail'.
> > 	in label 'fail', for (i =3D depth - 3; i >=3D 0; i--) cann't meet =
the
> condition because i=3D-1,so pages[0] cann't be put when func return.
> > second case:err happened in the second 'for' loop
> > 	now,we've got pages[0] with argc 'depth' is 2 ,or we've got pages[=
0]
> and pages[1] with depth is 3.when err happend,we need 'goto fail' to =
put pages
> we've got.
> > 	when depth is 2,in label 'fail',for (i =3D depth - 3; i >=3D 0; i-=
-) cann't
> meet the condition because i=3D-1,so pages[0] cann't be put.
> > 	when depth is 3,in label 'fail',for (i =3D depth - 3; i >=3D 0; i-=
-) can
> only put pages[0],pages[1] also cann't be put.
> > notes 'depth' has been changed before first 'goto fail'(ref to stat=
emnt
> depth =3D i + 1),so pass this modified 'depth' to
> trace_f2fs_truncate_partial_nodes is also incorrectly.
>=20
> Please write a description not to exceed 80 columns.
> It's very hard to understand.
>=20
> >
> > From 9de8efa31759ce86a032f5ad092d337b686ede06 Mon Sep 17 00:00:00 2=
001
> > Signed-off-by: Shifei Ge <shifei10.ge@samsung.com>
> > ---
> >  fs/f2fs/node.c |    6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c index 304d5ce..9986930
> > 100644
> > --- a/fs/f2fs/node.c
> > +++ b/fs/f2fs/node.c
> > @@ -625,6 +625,7 @@ static int truncate_partial_nodes(struct dnode_=
of_data
> *dn,
> >  	int err =3D 0;
> >  	int i;
> >  	int idx =3D depth - 2;
> > +	int dep =3D depth;
>=20
> I think we need to avoid using a local variable only for the use of
> tracepoints below.
> How about this?
>=20
> ---
>  fs/f2fs/node.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c index 304d5ce..8578719 1=
00644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -631,11 +631,10 @@ static int truncate_partial_nodes(struct dnode_=
of_data
> *dn,
>  		return 0;
>=20
>  	/* get indirect nodes in the path */
> -	for (i =3D 0; i < depth - 1; i++) {
> +	for (i =3D 0; i < idx + 1; i++) {
>  		/* refernece count'll be increased */
>  		pages[i] =3D get_node_page(sbi, nid[i]);
>  		if (IS_ERR(pages[i])) {
> -			depth =3D i + 1;
>  			err =3D PTR_ERR(pages[i]);
>  			goto fail;
>  		}
> @@ -643,7 +642,7 @@ static int truncate_partial_nodes(struct dnode_of=
_data *dn,
>  	}
>=20
>  	/* free direct nodes linked to a partial indirect node */
> -	for (i =3D offset[depth - 1]; i < NIDS_PER_BLOCK; i++) {
> +	for (i =3D offset[idx + 1]; i < NIDS_PER_BLOCK; i++) {
>  		child_nid =3D get_nid(pages[idx], i, false);
>  		if (!child_nid)
>  			continue;
> @@ -654,7 +653,7 @@ static int truncate_partial_nodes(struct dnode_of=
_data *dn,
>  		set_nid(pages[idx], i, 0, false);
>  	}
>=20
> -	if (offset[depth - 1] =3D=3D 0) {
> +	if (offset[idx + 1] =3D=3D 0) {
>  		dn->node_page =3D pages[idx];
>  		dn->nid =3D nid[idx];
>  		truncate_node(dn);
> @@ -662,9 +661,10 @@ static int truncate_partial_nodes(struct dnode_o=
f_data
> *dn,
>  		f2fs_put_page(pages[idx], 1);
>  	}
>  	offset[idx]++;
> -	offset[depth - 1] =3D 0;
> +	offset[idx + 1] =3D 0;
> +	idx--;
>  fail:
> -	for (i =3D depth - 3; i >=3D 0; i--)
> +	for (i =3D idx; i >=3D 0; i--)
>  		f2fs_put_page(pages[i], 1);
>=20
>  	trace_f2fs_truncate_partial_nodes(dn->inode, nid, depth, err);
> --
> 1.8.4.474.g128a96c
>=20
>=20
>=20
>=20
> --
> Jaegeuk Kim
> Samsung
