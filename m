From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [PATCH 02/15] f2fs: remove unnecessary flag set
Date: Mon, 20 May 2013 16:31:30 +0900
Message-ID: <1369035090.10521.4.camel@kjgkr>
References: <1369020743-18520-1-git-send-email-jaegeuk.kim@samsung.com>
 <1369020743-18520-2-git-send-email-jaegeuk.kim@samsung.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="=-ywCZPx3KQ2M8Axv1uoiw"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1369020743-18520-2-git-send-email-jaegeuk.kim@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net


--=-ywCZPx3KQ2M8Axv1uoiw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for the noise.
This patch should be ignored.
Thanks,

2013-05-20 (=EC=9B=94), 12:32 +0900, Jaegeuk Kim:
> If an inode is recovered with its dentry, it will not invoke __f2fs_add_l=
ink,
> since the recovery routine checks its dentry before calling __f2fs_add_li=
nk.
>=20
> Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
> ---
>  fs/f2fs/recovery.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>=20
> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> index 2941987..993b601 100644
> --- a/fs/f2fs/recovery.c
> +++ b/fs/f2fs/recovery.c
> @@ -125,11 +125,7 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sb=
i, struct list_head *head)
>  			goto next;
> =20
>  		entry =3D get_fsync_inode(head, ino_of_node(page));
> -		if (entry) {
> -			if (IS_INODE(page) && is_dent_dnode(page))
> -				set_inode_flag(F2FS_I(entry->inode),
> -							FI_INC_LINK);
> -		} else {
> +		if (!entry) {
>  			if (IS_INODE(page) && is_dent_dnode(page)) {
>  				err =3D recover_inode_page(sbi, page);
>  				if (err)

--=20
Jaegeuk Kim
Samsung

--=-ywCZPx3KQ2M8Axv1uoiw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJRmdFSAAoJEEAUqH6CSFDSxRIP/iS9C/E3mYCc6XpAVd0zVrip
vmFKj1NDD8MSzygRZhjYyZpcwjHAQAUX0u4d/Sp4LKmkHNw3WSSvzrkgMHOExy9C
7fJD+6sa1mbC8ZFox/JbVIcD729TLuK5Jgtx5hSM/WozRNe5S7PIO7TyBwIp7V0T
D60BXSgs1RdQis9HZVOG+oacsfIyWh/NUr2+F362MFfTX+4GelVPBGvohPz9NS9f
RKhoPTcauiRZRg2G7KVifAL54z+uPU2vWf1FFmhY/yljPgvC4wVO5czbWeetYzi7
EasJz1Yc+GfqkRNkok6uPb6GybixODEnSKM+hiuLkx/92x8zyaKFAq4bqUo+qE00
AXJro9mhGiTI/7E7fwQBi0ttUmWcUHw0sRjBPKTMRMBUP3TWYA3toAK4Mjknb26z
RacSxczYJ+zpQn2M364fG1XXEtOAe48d3G0vYZw/N36/KSCkD/TnR5r+tQ+5W3/r
HHQr5s3N+9y0lhWPgFjiK/h2TZ9hJmdj/8bIDlbiEFhILCOWT2CH5GxtViNC7d0k
Q5smBFf99MBq6Bp0AKNnuke5sdJHkFnLbpPCU2LSZj0h6IoY34r7ZSaa9zN1INtS
fOx6ow/jJuXnXEvz877MSYJ3GBiQ5NG0uWR3+N19e7V/S43E31FMwshaC1J5uAC5
/O4rYb/Kdt3DXIM86cQX
=gfTi
-----END PGP SIGNATURE-----

--=-ywCZPx3KQ2M8Axv1uoiw--
