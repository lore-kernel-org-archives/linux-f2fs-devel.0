From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 1/2] f2fs: clean up the do_submit_bio flow
Date: Tue, 19 Nov 2013 15:33:14 +0900
Message-ID: <1384842794.26319.32.camel@kjgkr>
References: <1384765922-24028-1-git-send-email-jaegeuk.kim@samsung.com>
 <001401cee4e8$09cf01b0$1d6d0510$@samsung.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <001401cee4e8$09cf01b0$1d6d0510$@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

2013-11-19 (=ED=99=94), 13:25 +0800, Chao Yu:
> Hi
>=20
> > -----Original Message-----
> > From: Jaegeuk Kim [mailto:jaegeuk.kim@samsung.com]
> > Sent: Monday, November 18, 2013 5:12 PM
> > Cc: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org; li=
nux-f2fs-devel@lists.sourceforge.net
> > Subject: [f2fs-dev] [PATCH 1/2] f2fs: clean up the do_submit_bio fl=
ow
> >=20
> > This patch introduces PAGE_TYPE_OF_BIO() and cleans up do_submit_bi=
o() with it.
> >=20
> > Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
> > ---
> >  fs/f2fs/f2fs.h    |  1 +
> >  fs/f2fs/segment.c | 39 +++++++++++++++++++++------------------
> >  2 files changed, 22 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index fe5c2fc..1c783fd 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -351,6 +351,7 @@ enum count_type {
> >   *			with waiting the bio's completion
> >   * ...			Only can be used with META.
> >   */
> > +#define PAGE_TYPE_OF_BIO(type)	(type) > META ? META : (type)


I'll add parenthesis as you suggested. Thanks.

> >  enum page_type {
> >  	DATA,
> >  	NODE,
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index 1f83999..dad5f1a 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -837,32 +837,35 @@ static void do_submit_bio(struct f2fs_sb_info=
 *sbi,
> >  				enum page_type type, bool sync)
> >  {
> >  	int rw =3D sync ? WRITE_SYNC : WRITE;
> > -	enum page_type btype =3D type > META ? META : type;
> > +	enum page_type btype =3D PAGE_TYPE_OF_BIO(type);
>=20
> ->f2fs_submit_bio()
> 	: enum page_type btype =3D PAGE_TYPE_OF_BIO(type);
> 	->do_submit_bio()
> 		: enum page_type btype =3D PAGE_TYPE_OF_BIO(type);
>=20
> Could we remove PAGE_TYPE_OF_BIO or use f2fs_bug_on to instead
> in do_submit_bio()? because it looks redundant , and also=20
> submit_write_page() will not pass the type which is larger than META.

The f2fs_submit_bio(type) calls do_submit_bio(type) in which the type i=
s
able to be META_FLUSH from sync_meta_pages().
So, we need to do this. :)

--=20
Jaegeuk Kim
Samsung

--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
