From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [PATCH 2/2] f2fs: fix the location of tracepoint
Date: Wed, 11 Dec 2013 16:07:58 +0900
Message-ID: <1386745678.2101.152.camel@kjgkr>
References: <1386741927-6007-1-git-send-email-jaegeuk.kim@samsung.com>
 <1386741927-6007-2-git-send-email-jaegeuk.kim@samsung.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <1386741927-6007-2-git-send-email-jaegeuk.kim@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Oops,
Please ignore the second patch.
Sorry for the noise.

2013-12-11 (=EC=88=98), 15:05 +0900, Jaegeuk Kim:
> We need to get a trace before submit_bio, since its bi_sector is rema=
pped during
> the submit_bio.
>=20
> Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
> ---
>  fs/f2fs/data.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index ebc9177..969df55 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -103,9 +103,10 @@ static void __submit_merged_bio(struct f2fs_bio_=
info *io)
> =20
>  	rw =3D fio->rw | fio->rw_flag;
> =20
> +	trace_f2fs_submit_write_bio(io->sbi->sb, rw, fio->type, io->bio);
> +
>  	if (is_read_io(rw)) {
>  		submit_bio(rw, io->bio);
> -		trace_f2fs_submit_read_bio(io->sbi->sb, rw, fio->type, io->bio);
>  		io->bio =3D NULL;
>  		return;
>  	}
> @@ -122,7 +123,6 @@ static void __submit_merged_bio(struct f2fs_bio_i=
nfo *io)
>  	} else {
>  		submit_bio(rw, io->bio);
>  	}
> -	trace_f2fs_submit_write_bio(io->sbi->sb, rw, fio->type, io->bio);
>  	io->bio =3D NULL;
>  }
> =20

--=20
Jaegeuk Kim
Samsung

--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
