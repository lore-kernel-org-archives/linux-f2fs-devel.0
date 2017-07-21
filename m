From: Andreas Dilger <adilger@dilger.ca>
Subject: Re: [PATCH] f2fs: add ioctl to expose current features
Date: Fri, 21 Jul 2017 15:20:57 -0600
Message-ID: <4FCA5098-4C23-4D8E-92DD-2B616FB23463@dilger.ca>
References: <20170721201108.18408-1-jaegeuk@kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: multipart/signed;
 boundary="Apple-Mail=_1FAA3780-87E1-49CC-B97D-EA7EE93DA6D8";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170721201108.18408-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net


--Apple-Mail=_1FAA3780-87E1-49CC-B97D-EA7EE93DA6D8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On Jul 21, 2017, at 2:11 PM, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>=20
> This patch adds an ioctl to provide feature information to user.
> For exapmle, SQLite can use this ioctl to detect whether f2fs support =
atomic
> write or not.

Just for reference, ext4 exposes functionality that the kernel supports =
via
a file in /sys/fs/ext4/features/{feature_name} so that it is possible to
check [ -e /sys/fs/ext4/features/lazy_itable_init ] in a shell script =
also.

There are also per-filesystem tunables in /sys/fs/ext4/{device}/ and it
wouldn't be a bad idea to expose per-filesystem features something like
/sys/fs/{fstype}/{device}/features/{feature_name} so that it is easily
checked by userspace tools using [ -e $feature ] in bash or access()
in programs rather than an ioctl.

Cheers, Andreas

>=20
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
> fs/f2fs/f2fs.h |  2 ++
> fs/f2fs/file.c | 13 +++++++++++++
> 2 files changed, 15 insertions(+)
>=20
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index e06d4e4b4579..5c46a462b56e 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -112,6 +112,7 @@ struct f2fs_mount_info {
>=20
> #define F2FS_FEATURE_ENCRYPT	0x0001
> #define F2FS_FEATURE_BLKZONED	0x0002
> +#define F2FS_FEATURE_ATOMIC_WRITE 0x0004
>=20
> #define F2FS_HAS_FEATURE(sb, mask)					=
\
> 	((F2FS_SB(sb)->raw_super->feature & cpu_to_le32(mask)) !=3D 0)
> @@ -308,6 +309,7 @@ static inline bool __has_cursum_space(struct =
f2fs_journal *journal,
> 						struct =
f2fs_flush_device)
> #define F2FS_IOC_GARBAGE_COLLECT_RANGE	_IOW(F2FS_IOCTL_MAGIC, =
11,	\
> 						struct f2fs_gc_range)
> +#define	F2FS_IOC_GET_FEATURES		_IOR(F2FS_IOCTL_MAGIC, =
12, __u32)
>=20
> #define F2FS_IOC_SET_ENCRYPTION_POLICY	=
FS_IOC_SET_ENCRYPTION_POLICY
> #define F2FS_IOC_GET_ENCRYPTION_POLICY	=
FS_IOC_GET_ENCRYPTION_POLICY
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 2706130c261b..0e07b5b18cfa 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2384,6 +2384,16 @@ static int f2fs_ioc_flush_device(struct file =
*filp, unsigned long arg)
> 	return ret;
> }
>=20
> +static int f2fs_ioc_get_features(struct file *filp, unsigned long =
arg)
> +{
> +	struct inode *inode =3D file_inode(filp);
> +	u32 sb_feature =3D =
le32_to_cpu(F2FS_I_SB(inode)->raw_super->feature);
> +
> +	/* Must validate to set it with SQLite behavior in Android. */
> +	sb_feature |=3D F2FS_FEATURE_ATOMIC_WRITE;
> +
> +	return put_user(sb_feature, (u32 __user *)arg);
> +}
>=20
> long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long =
arg)
> {
> @@ -2426,6 +2436,8 @@ long f2fs_ioctl(struct file *filp, unsigned int =
cmd, unsigned long arg)
> 		return f2fs_ioc_move_range(filp, arg);
> 	case F2FS_IOC_FLUSH_DEVICE:
> 		return f2fs_ioc_flush_device(filp, arg);
> +	case F2FS_IOC_GET_FEATURES:
> +		return f2fs_ioc_get_features(filp, arg);
> 	default:
> 		return -ENOTTY;
> 	}
> @@ -2491,6 +2503,7 @@ long f2fs_compat_ioctl(struct file *file, =
unsigned int cmd, unsigned long arg)
> 	case F2FS_IOC_DEFRAGMENT:
> 	case F2FS_IOC_MOVE_RANGE:
> 	case F2FS_IOC_FLUSH_DEVICE:
> +	case F2FS_IOC_GET_FEATURES:
> 		break;
> 	default:
> 		return -ENOIOCTLCMD;
> --
> 2.13.0.rc1.294.g07d810a77f-goog
>=20


Cheers, Andreas






--Apple-Mail=_1FAA3780-87E1-49CC-B97D-EA7EE93DA6D8
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iD8DBQFZcnA7pIg59Q01vtYRAgPkAKDCEGMEuxpYWsYkmXDI98Rt/PiDugCaAxL4
OC1Ds5rOShpn8VpuU2LN80Q=
=HpUu
-----END PGP SIGNATURE-----

--Apple-Mail=_1FAA3780-87E1-49CC-B97D-EA7EE93DA6D8--
