From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [f2fs-dev] [patch] f2fs: dereferencing an ERR_PTR
Date: Fri, 24 May 2013 20:32:33 +0900
Message-ID: <1369395153.10521.15.camel@kjgkr>
References: <20130523100213.GA19107@elgon.mountain>
	<20130523101240.GG30128@mwanda> <1369367168.10521.13.camel@kjgkr>
	<20130524112340.GA23932@mwanda>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3535173097162912100=="
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1UfqFs-0002Xg-2r
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 24 May 2013 11:33:52 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UfqFp-0001Zj-5n for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 24 May 2013 11:33:52 +0000
Received: from epcpsbgr1.samsung.com
	(u141.gpu120.samsung.co.kr [203.254.230.141])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MNA0000OW46IIU0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 24 May 2013 20:33:42 +0900 (KST)
In-reply-to: <20130524112340.GA23932@mwanda>
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


--===============3535173097162912100==
Content-type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="=-mfDDLZKvee5phFp8qzjy"


--=-mfDDLZKvee5phFp8qzjy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2013-05-24 (=EA=B8=88), 14:23 +0300, Dan Carpenter:
> On Fri, May 24, 2013 at 12:46:08PM +0900, Jaegeuk Kim wrote:
> > From ded3c78fcb6dd8c39a8664471544942e51ff9faf Mon Sep 17 00:00:00 2001
> > From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
> > Date: Fri, 24 May 2013 12:41:04 +0900
> > Subject: [PATCH] f2fs: align data types between on-disk and in-memory
> > block
> >  addresses
> > Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
> > linux-f2fs-devel@lists.sourceforge.net
> >=20
> > The on-disk block address is defined as __le32, but in-memory block
> > address,
> > block_t, does as u64.
> >=20
> > Let's synchronize them to 32 bits.
> >=20
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
>=20
> What you say sounds good to me.  Could you give me the reported-by
> tag instead of the Signed-off-by?  The Signed-off-by means it went
> through my hands and it's intended as sort of a legal thing like
> signing a document.

Ok, I see.
Thank you very much for the notification. :)

>=20
> regards,
> dan carpenter

--=20
Jaegeuk Kim
Samsung

--=-mfDDLZKvee5phFp8qzjy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJRn0/RAAoJEEAUqH6CSFDSm+sP/1WK++r94w+j5sFiuqszouO1
jNvAaRFJw44mbOKocK1VX9su9aLSh/Q4554JHRKFmzI+rde8zeQmJNZzzl+uEMuX
HyihNJluN/XgtHxB+/R+hy0guuzgqn6U/DuCACkWlxYznRlJIwrmeCByaSZO/XV7
EnHskefAbefVR8aCEpV2eyjLw0yUyD302jhPGjRpdvD1+bcXAf6P4ePIyQhjDLNx
N+wwSb3ccrM/sWg7k2v/2zXZSFjvS8eTTObEaETyl2g3iwsDJlNO6LwbmYOjSSTy
i0gV/5T59YgvMFIRI1ileYSkr/ODzIR9gVx2VGpNIk3wfAOBhrDyKiZ5zc+IQYuF
1MkIyxE+35p3INuMmiRaInRhBEG2TVOQ3Uje6YVN2xoHomrkVRzV1HZa3KrD2L2q
3zi7xM7Z86Ic69bxuN6z9iseyhy77ZchyJ1eP8xtwCXZD4eIWqJFLKRxJ9iIqCyp
N7IJpLzzfo/j9JtUOroo5vyx2LWGZgKpT9/2oBuStK0gaKgVeGGclKFKaklBaTxy
rRSqzEvO8NQ33zn+eP6oh1nRakCSfgpBp47tGEuDjNvbtL9TeDH3aoP6NAV7b9aR
JiMfiTigGEW17CXqgQEOTf3FqCKvTVNdD6ApyS6E49Iv/5oA4g60XtXvhy6UaZov
3CRxzPyb9vZPSiPnX8Yo
=5zkL
-----END PGP SIGNATURE-----

--=-mfDDLZKvee5phFp8qzjy--



--===============3535173097162912100==
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
--===============3535173097162912100==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

--===============3535173097162912100==--
