From: NeilBrown <neilb@suse.com>
Subject: [PATCH 09/11] f2fs: Remove __GFP_NOFAIL flag from call to mempool_alloc()
Date: Mon, 10 Apr 2017 12:17:37 +1000
Message-ID: <8737dhxaym.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Passing __GFP_NOFAIL to mempool_alloc() is strange
because it bypasses the pool functionality provided
by the mempool.  mempool_alloc() will not fail
even without the NOFAIL flag.

So remove the flag and allow the pool to be used properly.

Signed-off-by: NeilBrown <neilb@suse.com>
=2D--
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 1602b4bccae6..7e31751ec708 100644
=2D-- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -204,7 +204,7 @@ static inline void __submit_bio(struct f2fs_sb_info *sb=
i,
 		for (; start < F2FS_IO_SIZE(sbi); start++) {
 			struct page *page =3D
 				mempool_alloc(sbi->write_io_dummy,
=2D					GFP_NOIO | __GFP_ZERO | __GFP_NOFAIL);
+					GFP_NOIO | __GFP_ZERO);
 			f2fs_bug_on(sbi, !page);
=20
 			SetPagePrivate(page);
=2D-=20
2.12.2


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAljq60IACgkQOeye3VZi
gbnixxAAnSleGfxNiq6+bbxB/ZoT85tUy2xUHh79TfkmTiZS/dFqvpTe5EUfbYfH
iMInAa/SSXc51YXmtX9Nx+VvuYlglytXiGM7MPUYDgjbXcIX/9l04/6YTOqD6u5E
WoiBRg6/x5/x7bAXGzR0pcVZQGG0vEGZKpCCt97W2AbpCDD3i5x5Xs2Hnyq8zCv3
NtqhnLxSAu9+3h0COt24Ae3pX6E5XNLNDW6J/Cjb8ULptGk66xTZ6pwaHfdc0/3K
4nhbxdhe3fxNz4E2TbTZOzLQl1oZqprH2WcyNmJop4pmRDHHDkILFc9H592gqGG5
j50uswyTUc3uUbrNKF4Ahvk3Q4YStApxQCsS2uR8bm95sTjMAY82XIMngSpmqP7x
OqpKCCPEGI197Xe5mxyUie6ZPbret8GKh6ezBcdfB3dpZ2iF9+mQtJJiTp9UtyUI
3hQKLU8pL8hQE3CqUxK7juAQiU+WFG5T5BEDIeXKyKpZHKIMSTtjnrrZ3mnCQxdY
jUVp5RhD7r7HHmvRugcpIxWEAYkwU7bToqjQHu64arV6Y0YAOzXvPYMrP9zB8W3E
TS1mINg2fj9tP92vOgPdvUraefbXQMfUss9ZYyNX3uhb7udOsbaD+U2bb6PGoDcK
kv/KNyxCm/6Rpi6S0NvkusQV93fLVTsPOdEPBC9KN7WIQBLHMrU=
=dBdY
-----END PGP SIGNATURE-----
--=-=-=--
