From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH] f2fs: fix incorrect parsing with option string
Date: Tue, 18 Mar 2014 08:59:08 +0800
Message-ID: <000001cf4245$5f848250$1e8d86f0$@samsung.com>
References: <000301cf41c5$10f247b0$32d6d710$@samsung.com>
 <1395102807.3870.156.camel@kjgkr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1395102807.3870.156.camel@kjgkr>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk.kim@samsung.com
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk.kim@samsung.com]
> Sent: Tuesday, March 18, 2014 8:33 AM
> To: Chao Yu
> Cc: linux-f2fs-devel@lists.sourceforge.net; linux-fsdevel@vger.kernel=
=2Eorg;
> linux-kernel@vger.kernel.org
> Subject: Re: [f2fs-dev] [PATCH] f2fs: fix incorrect parsing with opti=
on string
>=20
> Hi,
>=20
> 2014-03-17 (=EC=9B=94), 17:40 +0800, Chao Yu:
> > Previously 'background_gc=3D{on***,off***}' is being parsed as corr=
ect option,
> > with this patch we cloud fix the trivial bug in mount process.
> >
> > Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> > ---
> >  fs/f2fs/super.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 057a3ef..6597290 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -258,9 +258,9 @@ static int parse_options(struct super_block *sb=
, char *options)
> >
> >  			if (!name)
> >  				return -ENOMEM;
> > -			if (!strncmp(name, "on", 2))
> > +			if (!strncmp(name, "on", strlen(name)))
>=20
> What about 'background_gc=3Do'?
> Need to check strlen(name) =3D=3D 2...

Oh, you're right. I will fix it and send v2 patch.
Thanks for your review. :)

> Thanks,
>=20
> >  				set_opt(sbi, BG_GC);
> > -			else if (!strncmp(name, "off", 3))
> > +			else if (!strncmp(name, "off", strlen(name)))
> >  				clear_opt(sbi, BG_GC);
> >  			else {
> >  				kfree(name);
>=20
> --
> Jaegeuk Kim
> Samsung
