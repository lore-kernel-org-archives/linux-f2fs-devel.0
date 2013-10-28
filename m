From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs:fix truncate_partial_nodes bug
Date: Mon, 28 Oct 2013 19:21:44 +0900
Message-ID: <1382955704.992.91.camel@kjgkr>
References: <27929860.72301382948116848.JavaMail.weblogic@epml07>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <27929860.72301382948116848.JavaMail.weblogic@epml07>
Sender: linux-kernel-owner@vger.kernel.org
To: shifei10.ge@samsung.com
Cc: ?? <shu.tan@samsung.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

2013-10-28 (=EC=9B=94), 08:15 +0000, Shifei Ge:
> truncate_partial_nodes puts pages incorrectly in two cases.note that =
the value for argc 'depth' can only be 2 or 3(see truncate_inode_blocks=
 --->truncate_partial_nodes ).
> first case:err happened in the first 'for' loop
> 	assume depth is 2,when err happened,pages[0] is invalid,so this page=
 don't need to be put when func return,there is no problem.
> 	but when depth is 3 ,pages isn't put correctly when pages[0] is vali=
d and pages[1] is invalid.in this case,depth is set to 2(ref to statemn=
t depth =3D i + 1) ,and then 'goto fail'.
> 	in label 'fail', for (i =3D depth - 3; i >=3D 0; i--) cann't meet th=
e condition because i=3D-1,so pages[0] cann't be put when func return.
> second case:err happened in the second 'for' loop
> 	now,we've got pages[0] with argc 'depth' is 2 ,or we've got pages[0]=
 and pages[1] with depth is 3.when err happend,we need 'goto fail' to p=
ut pages we've got.
> 	when depth is 2,in label 'fail',for (i =3D depth - 3; i >=3D 0; i--)=
 cann't meet the condition because i=3D-1,so pages[0] cann't be put.
> 	when depth is 3,in label 'fail',for (i =3D depth - 3; i >=3D 0; i--)=
 can only put pages[0],pages[1] also cann't be put.
> notes 'depth' has been changed before first 'goto fail'(ref to statem=
nt depth =3D i + 1),so pass this modified 'depth' to trace_f2fs_truncat=
e_partial_nodes is also incorrectly.

Please write a description not to exceed 80 columns.
It's very hard to understand.

>=20
> From 9de8efa31759ce86a032f5ad092d337b686ede06 Mon Sep 17 00:00:00 200=
1
> Signed-off-by: Shifei Ge <shifei10.ge@samsung.com>
> ---
>  fs/f2fs/node.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 304d5ce..9986930 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -625,6 +625,7 @@ static int truncate_partial_nodes(struct dnode_of=
_data *dn,
>  	int err =3D 0;
>  	int i;
>  	int idx =3D depth - 2;
> +	int dep =3D depth;

I think we need to avoid using a local variable only for the use of
tracepoints below.
How about this?

---
 fs/f2fs/node.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 304d5ce..8578719 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -631,11 +631,10 @@ static int truncate_partial_nodes(struct
dnode_of_data *dn,
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
 			goto fail;
 		}
@@ -643,7 +642,7 @@ static int truncate_partial_nodes(struct
dnode_of_data *dn,
 	}
=20
 	/* free direct nodes linked to a partial indirect node */
-	for (i =3D offset[depth - 1]; i < NIDS_PER_BLOCK; i++) {
+	for (i =3D offset[idx + 1]; i < NIDS_PER_BLOCK; i++) {
 		child_nid =3D get_nid(pages[idx], i, false);
 		if (!child_nid)
 			continue;
@@ -654,7 +653,7 @@ static int truncate_partial_nodes(struct
dnode_of_data *dn,
 		set_nid(pages[idx], i, 0, false);
 	}
=20
-	if (offset[depth - 1] =3D=3D 0) {
+	if (offset[idx + 1] =3D=3D 0) {
 		dn->node_page =3D pages[idx];
 		dn->nid =3D nid[idx];
 		truncate_node(dn);
@@ -662,9 +661,10 @@ static int truncate_partial_nodes(struct
dnode_of_data *dn,
 		f2fs_put_page(pages[idx], 1);
 	}
 	offset[idx]++;
-	offset[depth - 1] =3D 0;
+	offset[idx + 1] =3D 0;
+	idx--;
 fail:
-	for (i =3D depth - 3; i >=3D 0; i--)
+	for (i =3D idx; i >=3D 0; i--)
 		f2fs_put_page(pages[i], 1);
=20
 	trace_f2fs_truncate_partial_nodes(dn->inode, nid, depth, err);
--=20
1.8.4.474.g128a96c




--=20
Jaegeuk Kim
Samsung
