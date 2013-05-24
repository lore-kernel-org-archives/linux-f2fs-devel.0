From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [f2fs-dev] [patch] f2fs: dereferencing an ERR_PTR
Date: Fri, 24 May 2013 12:46:08 +0900
Message-ID: <1369367168.10521.13.camel@kjgkr>
References: <20130523100213.GA19107@elgon.mountain>
	<20130523101240.GG30128@mwanda>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2200657037624004708=="
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1UfiyX-0006zV-5M
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 24 May 2013 03:47:29 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UfiyU-0001Ku-Qm for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 24 May 2013 03:47:29 +0000
Received: from epcpsbgr1.samsung.com
	(u141.gpu120.samsung.co.kr [203.254.230.141])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MNA00GWDAIW2SH0@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 24 May 2013 12:47:20 +0900 (KST)
In-reply-to: <20130523101240.GG30128@mwanda>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: kernel-janitors@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net


--===============2200657037624004708==
Content-type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="=-6lnAKshgeF/PjQ0nKFTU"


--=-6lnAKshgeF/PjQ0nKFTU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2013-05-23 (=EB=AA=A9), 13:12 +0300, Dan Carpenter:
> Btw, Linus's new Sparse changes don't like the f2fs's NEW_ADDR
> macro.
>=20
> #define NEW_ADDR                -1U
>=20
> We use it like this:
>=20
> 	block_t src, dest;
>=20
> 	if (src !=3D dest && dest !=3D NEW_ADDR && dest !=3D NULL_ADDR) {
>=20
> block_t is 64 bits so probably the macro should probably be:
>=20
> #define NEW_ADDR               ((block_t)-1)

Hi,
Agreed that it needs to synchronize on-disk and in-memory block address
types, __le32 and u64.
How about the below patch?

>=20
> I'm not able to test this so there may be some reason why changing
> this breaks something.  In that case we could do:
>=20
> #define NEW_ADDR               ((u32)(block_t)-1) /* explanation */
>=20
> regards,
> dan carpenter
>=20

=46rom ded3c78fcb6dd8c39a8664471544942e51ff9faf Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Date: Fri, 24 May 2013 12:41:04 +0900
Subject: [PATCH] f2fs: align data types between on-disk and in-memory
block
 addresses
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
linux-f2fs-devel@lists.sourceforge.net

The on-disk block address is defined as __le32, but in-memory block
address,
block_t, does as u64.

Let's synchronize them to 32 bits.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/f2fs.h          | 5 ++++-
 include/linux/f2fs_fs.h | 4 ++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 7b05029..92fd4e9 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -37,7 +37,10 @@
 		typecheck(unsigned long long, b) &&			\
 		((long long)((a) - (b)) > 0))
=20
-typedef u64 block_t;
+typedef u32 block_t;	/*
+			 * should not change u32, since it is the on-disk block
+			 * address format, __le32.
+			 */
 typedef u32 nid_t;
=20
 struct f2fs_mount_info {
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index df6fab8..383d5e3 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -20,8 +20,8 @@
 #define F2FS_BLKSIZE			4096	/* support only 4KB block */
 #define F2FS_MAX_EXTENSION		64	/* # of extension entries */
=20
-#define NULL_ADDR		0x0U
-#define NEW_ADDR		-1U
+#define NULL_ADDR		((block_t)0)	/* used as block_t addresses */
+#define NEW_ADDR		((block_t)-1)	/* used as block_t addresses */
=20
 #define F2FS_ROOT_INO(sbi)	(sbi->root_ino_num)
 #define F2FS_NODE_INO(sbi)	(sbi->node_ino_num)
--=20
1.8.1.3.566.gaa39828



--=20
Jaegeuk Kim
Samsung

--=-6lnAKshgeF/PjQ0nKFTU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJRnuKAAAoJEEAUqH6CSFDSK18P/3W9BAtug5ULoWfQlzbvENsG
y6QXSJqR5DR8LOlh3l5++qTWokGEPbwMrsX1eSFubDyFrjVGLwl315IJX6L8Lt6t
tUD4H+cH1v8g6YHoiPLbCSqiYg+aPb1ExaLNXOc2beaIXZzd8nm+SrUseLy0vMxE
zoAZTn3le6LBPhejArwfp3FKJfihyV4f/jAZV8tEL2T9nTgWvioEVPaWOqpcRy4o
0+wOix9Aul2Z0rgiMgm5s4pS2CB417py5iTbJJri5vjHR9fcaGYDn6j0WZ5/hlV3
PXKLg8SedoA+Ytp8YrogBt2fwQOYGPpblX9Z54TfezMglUgc9QCdvlkBCvGC53xJ
jAIqxL5/jQAyHDO/dOnjPlfn6s1JJ5dbJDtuLg492YLoCjHsv927fRfqXzEhGSGV
HMs3QwsATPLk8kwCMpUj+sTXWnSgliBDx6NuqaUYJhaXoKLb4EN5KzShavChTW56
U4O8NmCZehwCihU0ASK9HCrDZn1GlhdZHQVypGSbxzpiGWeZqsbVgu4T31ggpNEo
mJJOtPOTxC5fk0mcu29ViOjuX2UhBnEp6LcIdceQDuWXAICRa+FzAIihFmerj12H
IcaBHxq5qhwdhwY+L7t/k+t0/WjCbgGpkyOCI4nIBiXmg7zdMyJdFYJQVJ2JPyZV
diZrsRDNtu3/D4ND1rZ0
=/yD1
-----END PGP SIGNATURE-----

--=-6lnAKshgeF/PjQ0nKFTU--



--===============2200657037624004708==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
--===============2200657037624004708==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

--===============2200657037624004708==--
