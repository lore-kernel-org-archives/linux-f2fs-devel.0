From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix incorrect parsing with option string
Date: Tue, 18 Mar 2014 09:33:27 +0900
Message-ID: <1395102807.3870.156.camel@kjgkr>
References: <000301cf41c5$10f247b0$32d6d710$@samsung.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <000301cf41c5$10f247b0$32d6d710$@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

2014-03-17 (=EC=9B=94), 17:40 +0800, Chao Yu:
> Previously 'background_gc=3D{on***,off***}' is being parsed as correc=
t option,
> with this patch we cloud fix the trivial bug in mount process.
>=20
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  fs/f2fs/super.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 057a3ef..6597290 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -258,9 +258,9 @@ static int parse_options(struct super_block *sb, =
char *options)
> =20
>  			if (!name)
>  				return -ENOMEM;
> -			if (!strncmp(name, "on", 2))
> +			if (!strncmp(name, "on", strlen(name)))

What about 'background_gc=3Do'?
Need to check strlen(name) =3D=3D 2...
Thanks,

>  				set_opt(sbi, BG_GC);
> -			else if (!strncmp(name, "off", 3))
> +			else if (!strncmp(name, "off", strlen(name)))
>  				clear_opt(sbi, BG_GC);
>  			else {
>  				kfree(name);

--=20
Jaegeuk Kim
Samsung

--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
