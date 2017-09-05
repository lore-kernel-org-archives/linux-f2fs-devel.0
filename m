From: Andreas Dilger <adilger@dilger.ca>
Subject: Re: [PATCH] f2fs: fix wrong bfree and bavail
Date: Tue, 5 Sep 2017 15:20:13 -0600
Message-ID: <3A56CCE1-34B3-4EBA-9871-DAF175AB89BD@dilger.ca>
References: <20170905210653.46186-1-jaegeuk@kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: multipart/signed;
 boundary="Apple-Mail=_943614EA-D99A-406F-89BC-034B5085BD5B";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20170905210653.46186-1-jaegeuk@kernel.org>
Sender: stable-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, stable@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net


--Apple-Mail=_943614EA-D99A-406F-89BC-034B5085BD5B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Sep 5, 2017, at 3:06 PM, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>=20
> This patch fixes bavail and bfree finally.
>=20
> long    f_bfree;    /* free blocks in fs */
> long    f_bavail;   /* free blocks avail to non-superuser */
>=20
> So, bfree represents all the reserved blocks, while bavail does the =
space only
> visible to normal user.
>=20
> Fix: 3e6d0b4d9c1c ("f2fs: fix incorrect f_bfree calculation in =
->statfs")
> Cc: <stable@vger.kernel.org> # 4.8+
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
> fs/f2fs/super.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 7e29db227910..17cca4cb93af 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -955,8 +955,8 @@ static int f2fs_statfs(struct dentry *dentry, =
struct kstatfs *buf)
> 	buf->f_bsize =3D sbi->blocksize;
>=20
> 	buf->f_blocks =3D total_count - start_count;
> -	buf->f_bfree =3D user_block_count - valid_user_blocks(sbi) + =
ovp_count;
> -	buf->f_bavail =3D user_block_count - valid_user_blocks(sbi) -
> +	buf->f_bfree =3D user_block_count - valid_user_blocks(sbi);
> +	buf->f_bavail =3D user_block_count - valid_user_blocks(sbi) - =
ovp_count -
> 						sbi->reserved_blocks;

To keep the statfs data more consistent, you could use:

	buf->f_bavail =3D buf->f_bfree - ovp_count - =
sbi->reserved_blocks;

That avoids the extra subtraction, and avoids (minor) issues if these =
values
change while this syscall is running.

Cheers, Andreas






--Apple-Mail=_943614EA-D99A-406F-89BC-034B5085BD5B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iD8DBQFZrxUOpIg59Q01vtYRAvEbAJ9W+UxlkoNz2YMWYfQUMrNYgAEZCwCcDgII
5rwo92MTh1gmvK8YXFQZIDI=
=dDnr
-----END PGP SIGNATURE-----

--Apple-Mail=_943614EA-D99A-406F-89BC-034B5085BD5B--
