From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: merge read IOs at ra_nat_pages()
Date: Sun, 24 Nov 2013 11:46:57 +0900
Message-ID: <1385261217.26319.84.camel@kjgkr>
References: <1385026550-21055-1-git-send-email-jaegeuk.kim@samsung.com>
 <1385091679.16054.5.camel@lcm>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <1385091679.16054.5.camel@lcm>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Changman Lee <cm224.lee@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

2013-11-22 (=EA=B8=88), 12:41 +0900, Changman Lee:
> How about doing mark_page_accessed(page) in ra_nat_pages like
> ra_sit_pages to prevent readahead pages are reclaimed by VM?

Agreed.
I'll modify and merge this.
Thanks,

>=20
> On =EB=AA=A9, 2013-11-21 at 18:35 +0900, Jaegeuk Kim wrote:
> > This patch changes the policy of submitting read bios at ra_nat_pag=
es.
> >=20
> > Previously, f2fs submits small read bios with block plugging.
> > But, with this patch, f2fs itself merges read bios first and then s=
ubmits a
> > large bio, which can reduce the bio handling overheads.
> >=20
> > Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
> > ---
> >  fs/f2fs/node.c | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> > index b843a5b..c06871f 100644
> > --- a/fs/f2fs/node.c
> > +++ b/fs/f2fs/node.c
> > @@ -89,13 +89,10 @@ static void ra_nat_pages(struct f2fs_sb_info *s=
bi, int nid)
> >  {
> >  	struct address_space *mapping =3D sbi->meta_inode->i_mapping;
> >  	struct f2fs_nm_info *nm_i =3D NM_I(sbi);
> > -	struct blk_plug plug;
> >  	struct page *page;
> >  	pgoff_t index;
> >  	int i;
> > =20
> > -	blk_start_plug(&plug);
> > -
> >  	for (i =3D 0; i < FREE_NID_PAGES; i++, nid +=3D NAT_ENTRY_PER_BLO=
CK) {
> >  		if (nid >=3D nm_i->max_nid)
> >  			nid =3D 0;
> > @@ -108,12 +105,11 @@ static void ra_nat_pages(struct f2fs_sb_info =
*sbi, int nid)
>=20
> mark_page_accessed(page);
>=20
> >  			f2fs_put_page(page, 1);
> >  			continue;
> >  		}
> > -		if (f2fs_readpage(sbi, page, index, READ))
> > -			continue;
> > +		submit_read_page(sbi, page, index, READ_SYNC);
> > =20
>=20
> mark_page_accessed(page);
>=20
> >  		f2fs_put_page(page, 0);
> >  	}
> > -	blk_finish_plug(&plug);
> > +	f2fs_submit_read_bio(sbi, READ_SYNC);
> >  }
> > =20
> >  static struct nat_entry *__lookup_nat_cache(struct f2fs_nm_info *n=
m_i, nid_t n)
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fsdev=
el" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Jaegeuk Kim
Samsung

--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
