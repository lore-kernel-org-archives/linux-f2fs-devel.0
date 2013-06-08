From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [PATCH 2/2 v2] f2fs: support xattr security labels
Date: Sat, 08 Jun 2013 09:18:38 +0900
Message-ID: <1370650718.3600.50.camel@kjgkr>
References: <1370584557-20592-1-git-send-email-jaegeuk.kim@samsung.com>
 <1370584557-20592-2-git-send-email-jaegeuk.kim@samsung.com>
 <1370592580.3600.42.camel@kjgkr>
 <CAKYAXd9V39ff3b3V13nOOH2nxZAMesMe9KzwUK-ovzBVUCkhGw@mail.gmail.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="=-ucbxUC2dzttUQO1TP9Nd"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAKYAXd9V39ff3b3V13nOOH2nxZAMesMe9KzwUK-ovzBVUCkhGw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Namjae Jeon <linkinjeon@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net


--=-ucbxUC2dzttUQO1TP9Nd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2013-06-07 (=EA=B8=88), 19:50 +0900, Namjae Jeon:
> 2013/6/7, Jaegeuk Kim <jaegeuk.kim@samsung.com>:
> > Change log from v1:
> >  o fix a bug
> >
> > From 901aea226653e26aa3556edd88ca1e48fa89eb5f Mon Sep 17 00:00:00 2001
> > From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
> > Date: Mon, 3 Jun 2013 19:46:19 +0900
> > Subject: [PATCH 2/2] f2fs: support xattr security labels
> > Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
> > linux-f2fs-devel@lists.sourceforge.net
> >
> > This patch adds the support of security labels for f2fs, which will be =
used
> > by SElinux.
> >
> > Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
> > ---
> >  fs/f2fs/Kconfig |  9 +++++++++
> >  fs/f2fs/dir.c   |  5 +++++
> >  fs/f2fs/xattr.c | 60
> > +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
> >  fs/f2fs/xattr.h | 12 +++++++++++-
> >  4 files changed, 83 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/f2fs/Kconfig b/fs/f2fs/Kconfig
> > index fd27e7e..2214cc9 100644
> > --- a/fs/f2fs/Kconfig
> > +++ b/fs/f2fs/Kconfig
> > @@ -51,3 +51,12 @@ config F2FS_FS_POSIX_ACL
> >  	  Linux website <http://acl.bestbits.at/>.
> >
> >  	  If you don't know what Access Control Lists are, say N
> > +
> > +config F2FS_FS_SECURITY
> > +	bool "F2FS Security Labels"
> > +	depends on F2FS_FS_XATTR
> Hi Jaegeuk.
> Do we need to add "default y" as other xattr options ?

Hi Namjae,
Currently negative.
Most of xattr operations will be fine though, I'd like to test them more
intensively. After then, we'd better set *default y*.
Thanks, :)

>=20
> Thanks.
> > +	help
> > +	  Security labels provide acls used by the security modules
> > +	  like SELinux. This option should be used with the xattr mode.
> > +
> > +	  If you are not using a security module, say N.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Jaegeuk Kim
Samsung

--=-ucbxUC2dzttUQO1TP9Nd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJRsnhfAAoJEEAUqH6CSFDSAeEP/iyWeSv9ybSoHhCIrH02TLSr
A7eM5YO4y7ggJRQJjLGyuGUNpsdyJUFiTZ//k4HXAkrlyeoTlArtsMKadPo/2RWx
mdMUCL9WW9q0LP/RBSwIQH1U0Iix1dgvCvg8hAiOzPRC/YGp1Dp/T2k7AXsauSfm
4MfDhbnkWWUiUpWso+P2LJ4bfPKrzkQNKmd9S9hC0FoQHNmI4P9NHfGEOsy1yAdk
qkQM4OdtdXHAVITX7up8/7RiXER7gZoxmW5lCSHwtBgRImXEMuUgVloNJ6JrRBm7
UBwgLVZWxMKZ1N+SiG4N+6uV5m7iINF7hksjArLeUHa7JZln8fduAfClY5EX4SNr
esqrVifC0UziOTKSEE+hrohEh4tfVgWpHPcf/zPmMEsaX41CQpAVLKSQOCK2ErEi
SFZIsrxVf8ReRaUkncxLR/vrVOdZgZJ3U4kjiDqKrGTfzjQ86RsELaEqnV/MuLTR
1cW/sp4M4hM2SNFnfpq2eCewTZ5lygXz5JJe/plzKfRHNQCfPOEUq7oJj6lby7fw
N+bV3zbQw28eKGUTH9uvpt8SqntbfSVGxMdu5NiMGEQhR2+9tcBbZIBhifTXj24/
R3Ofk0Qg78Ct4zby7EY/s0Oig+Hsv+rJJCzkNpPBgtRzDgXPLDAR3NX+axXGrMgc
yvNOTWr0SRZlUfIs8pAG
=V82D
-----END PGP SIGNATURE-----

--=-ucbxUC2dzttUQO1TP9Nd--
