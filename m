From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [RFC 0/5] Enable f2fs support inline data
Date: Tue, 04 Jun 2013 11:19:26 +0900
Message-ID: <1370312366.3600.3.camel@kjgkr>
References: <1370253854-15084-1-git-send-email-huajun.li@intel.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="=-F7OcqDIY/fbWd3Kl2Njm"
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <1370253854-15084-1-git-send-email-huajun.li@intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Huajun Li <huajun.li@intel.com>
Cc: linux-fsdevel@vger.kernel.org, huajun.li.lee@gmail.com, namjae.jeon@samsung.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net


--=-F7OcqDIY/fbWd3Kl2Njm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

This feature is one of my todo items. ;)
Thank you for the contribution.

Before reviewing the below code intensively, we need to check the
following issues.

- deadlock conditions
- FS consistency
- recovery routine

Could you check one more time?
Thanks again,

2013-06-03 (=EC=9B=94), 18:04 +0800, Huajun Li:
> f2fs inode is so large, small files can be stored directly in the inode,
> rather than just storing a single block address and storing the data else=
where.
>=20
> This RFC patch set is just to enable f2fs support inline data: files less=
 than
> about 3.6K can be stored directly in inode block.
>=20
> TODO: make small dirs inline too.
>=20
>=20
> Haicheng Li (3):
>   f2fs: Add helper functions and flag to support inline data
>   f2fs: Add interface for inline data support
>   f2fs: add tracepoints to debug inline data operations
>=20
> Huajun Li (2):
>   f2fs: Handle inline data read and write
>   f2fs: Key functions to handle inline data
>=20
>  fs/f2fs/Kconfig             |   10 +++
>  fs/f2fs/Makefile            |    1 +
>  fs/f2fs/data.c              |   78 +++++++++++++++++++++-
>  fs/f2fs/f2fs.h              |   70 +++++++++++++++++++
>  fs/f2fs/file.c              |    9 ++-
>  fs/f2fs/inline.c            |  156 +++++++++++++++++++++++++++++++++++++=
++++++
>  fs/f2fs/inode.c             |    8 +++
>  include/linux/f2fs_fs.h     |    5 ++
>  include/trace/events/f2fs.h |   69 +++++++++++++++++++
>  9 files changed, 402 insertions(+), 4 deletions(-)
>  create mode 100644 fs/f2fs/inline.c
>=20

--=20
Jaegeuk Kim
Samsung

--=-F7OcqDIY/fbWd3Kl2Njm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJRrU6uAAoJEEAUqH6CSFDSvb4P/09GfAlbc6B2213fGi41IBa5
fqUVwdQPkYGnG/zoqHda4a3QLdA89L5l+dvlT5qb/L179p7NxCQJgF/0cEYsSvA+
wxC+QwQDQT29vKYYirdpigfPMw0Gsg6esy8y0Kc61DZHSlczpYDdWXqnTbqzI/ZX
vTc7gNzRB+Gqkpgup2EAAIb/uNkKA58v9V8Ak9Qc6ZA4GF0RS4bY9WlO1m8s7CP8
SsGf3b8ZqRKEAVJjqm5mr0ttH9cj+bTvTXpM07TRWfh/qcnEEdV0ra6GoFzgzYPU
a5qCYI4aetIRQIvAzacw6JVlA/YaM3ope1OEDREJ3uO9wpShRR8X4FIZT3hq5uSc
E65G/B8XrXJLnSp9G3W9oit0ucTJjuALQk2nTgPOrEVBkuX0JXIEfWU+0tkaaA7j
VCC2yojzDC0Gem1Xd2zK30YIGhX/qnN9zBMDf5FtzPuJguVpDULytTMQZVHGWu03
zsQ2QEhsG01yAmNr6qarmD4mlAXNvpCZzAWM5+5qY8hSsrWrXnj8mNJ+KQXemYna
lcHybLWZtQN4lbfczkp1TfcgFSHkxPbl0uZhEOecIS1G3tbXxazTLvh5fbh/q1jP
8IPohoMla365uekuugDlPCHruQ6mjtiU7AslNl1Sdsp3di2G4thjlnFKCHi/kYXx
yF9XvUTN3wAxxlyCe8BM
=r6y1
-----END PGP SIGNATURE-----

--=-F7OcqDIY/fbWd3Kl2Njm--

