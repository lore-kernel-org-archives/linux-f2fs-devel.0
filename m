From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: use inode mutex to keep atomicity of
 f2fs_falloc
Date: Tue, 28 Jan 2014 15:00:11 +0900
Message-ID: <1390888811.25542.54.camel@kjgkr>
References: <000101cf1bd0$d1f6be70$75e43b50$@samsung.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <000101cf1bd0$d1f6be70$75e43b50$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

2014-01-28 (=ED=99=94), 10:29 +0800, Chao Yu:
> Previously without protection of inode mutex, f2fs_falloc and other d=
ata
> correlated operations will interfere with each other.

Could you explain a little bit more what kind of scenarios wrt this?


> So let's use inode mutex to keep atomicity of f2fs_falloc.
>=20
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  fs/f2fs/file.c |    5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 85e91ca..ece380f 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -559,6 +559,8 @@ static long f2fs_fallocate(struct file *file, int=
 mode,
>  	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
>  		return -EOPNOTSUPP;
> =20
> +	mutex_lock(&inode->i_mutex);
> +
>  	if (mode & FALLOC_FL_PUNCH_HOLE)
>  		ret =3D punch_hole(inode, offset, len);
>  	else
> @@ -568,6 +570,9 @@ static long f2fs_fallocate(struct file *file, int=
 mode,
>  		inode->i_mtime =3D inode->i_ctime =3D CURRENT_TIME;
>  		mark_inode_dirty(inode);
>  	}
> +
> +	mutex_unlock(&inode->i_mutex);
> +
>  	trace_f2fs_fallocate(inode, mode, offset, len, ret);
>  	return ret;
>  }

--=20
Jaegeuk Kim
Samsung
