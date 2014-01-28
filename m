From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH] f2fs: use inode mutex to keep atomicity of
 f2fs_falloc
Date: Tue, 28 Jan 2014 16:51:13 +0800
Message-ID: <000001cf1c06$3ac9a9f0$b05cfdd0$@samsung.com>
References: <000101cf1bd0$d1f6be70$75e43b50$@samsung.com>
 <1390888811.25542.54.camel@kjgkr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1390888811.25542.54.camel@kjgkr>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk.kim@samsung.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk.kim@samsung.com]
> Sent: Tuesday, January 28, 2014 2:00 PM
> To: Chao Yu
> Cc: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH] f2fs: use inode mutex to keep atomici=
ty of f2fs_falloc
>=20
> Hi,
>=20
> 2014-01-28 (=ED=99=94), 10:29 +0800, Chao Yu:
> > Previously without protection of inode mutex, f2fs_falloc and other=
 data
> > correlated operations will interfere with each other.
>=20
> Could you explain a little bit more what kind of scenarios wrt this?

1. Without protection of i_mutex, status(e.g. i_size) of inode could be=
 changed
by other operation(e.g. vfs_write()/vfs_truncate()) when we fallocate a=
 file, it
may cause us walk into wrong branch code after we check these status of=
 inode,
and vice versa.
2. i_size_write()/inode_newsize_ok() is called in f2fs_fallocate(), usu=
ally we
use i_mutex to protect these functions.

>=20
>=20
> > So let's use inode mutex to keep atomicity of f2fs_falloc.
> >
> > Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> > ---
> >  fs/f2fs/file.c |    5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 85e91ca..ece380f 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -559,6 +559,8 @@ static long f2fs_fallocate(struct file *file, i=
nt mode,
> >  	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
> >  		return -EOPNOTSUPP;
> >
> > +	mutex_lock(&inode->i_mutex);
> > +
> >  	if (mode & FALLOC_FL_PUNCH_HOLE)
> >  		ret =3D punch_hole(inode, offset, len);
> >  	else
> > @@ -568,6 +570,9 @@ static long f2fs_fallocate(struct file *file, i=
nt mode,
> >  		inode->i_mtime =3D inode->i_ctime =3D CURRENT_TIME;
> >  		mark_inode_dirty(inode);
> >  	}
> > +
> > +	mutex_unlock(&inode->i_mutex);
> > +
> >  	trace_f2fs_fallocate(inode, mode, offset, len, ret);
> >  	return ret;
> >  }
>=20
> --
> Jaegeuk Kim
> Samsung
