From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 2/6] f2fs: convert inline_data for punch_hole
Date: Mon, 06 Jan 2014 16:41:53 +0900
Message-ID: <1388994113.2101.312.camel@kjgkr>
References: <1388116820-15038-1-git-send-email-jaegeuk.kim@samsung.com>
 <1388116820-15038-2-git-send-email-jaegeuk.kim@samsung.com>
 <000001cf05ee$d8bd8c90$8a38a5b0$@samsung.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <000001cf05ee$d8bd8c90$8a38a5b0$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

2013-12-31 (=ED=99=94), 14:08 +0800, Chao Yu:
> Hi,
>=20
> One comment as following.
>=20
> > -----Original Message-----
> > From: Jaegeuk Kim [mailto:jaegeuk.kim@samsung.com]
> > Sent: Friday, December 27, 2013 12:00 PM
> > Cc: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org; li=
nux-f2fs-devel@lists.sourceforge.net
> > Subject: [f2fs-dev] [PATCH 2/6] f2fs: convert inline_data for punch=
_hole
> >=20
> > In the punch_hole(), let's convert inline_data all the time for sim=
plicity and
> > to avoid potential deadlock conditions.
> > It is pretty much not a big deal to do this.
> >=20
> > Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
>=20
> Reviewed-by: Chao Yu <chao2.yu@samsung.com>
>=20
> > ---
> >  fs/f2fs/file.c | 22 +++-------------------
> >  1 file changed, 3 insertions(+), 19 deletions(-)
> >=20
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 7ef2d6a..f64a1c8 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -462,25 +462,9 @@ static int punch_hole(struct inode *inode, lof=
f_t offset, loff_t len)
> >  	loff_t off_start, off_end;
> >  	int ret =3D 0;
> >=20
> > -	if (f2fs_has_inline_data(inode)) {
> > -		struct page *page;
> > -		unsigned flags =3D AOP_FLAG_NOFS;
> > -		page =3D grab_cache_page_write_begin(inode->i_mapping, 0, flags)=
;
> > -		if (IS_ERR(page))
> > -			return PTR_ERR(page);
>=20
> We use following code because grab_cache_page_write_begin only use
> NULL value as its error number.

Right. :)
Applied to the following patch:
f2fs: refactor f2fs_convert_inline_data.

Thanks,

--=20
Jaegeuk Kim
Samsung
