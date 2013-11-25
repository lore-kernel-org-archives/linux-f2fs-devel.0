From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH V3 2/2] f2fs: read contiguous sit entry pages by
 merging for mount performance
Date: Mon, 25 Nov 2013 09:33:12 +0800
Message-ID: <000e01cee97e$6b83e480$428bad80$@samsung.com>
References: <000301cee71f$b0e54160$12afc420$@samsung.com>
 <1385267160.26319.98.camel@kjgkr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1385267160.26319.98.camel@kjgkr>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk.kim@samsung.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, =?utf-8?B?J+iwreWnnSc=?= <shu.tan@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk.kim@samsung.com]
> Sent: Sunday, November 24, 2013 12:26 PM
> To: Chao Yu
> Cc: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org; linu=
x-f2fs-devel@lists.sourceforge.net; =E8=B0=AD=E5=A7=9D
> Subject: Re: [f2fs-dev] [PATCH V3 2/2] f2fs: read contiguous sit entr=
y pages by merging for mount performance
>=20
> Hi,
>=20
> 2013-11-22 (=EA=B8=88), 09:09 +0800, Chao Yu:
> > Previously we read sit entries page one by one, this method lost th=
e chance
> > of reading contiguous page together. So we read pages as contiguous=
 as
> > possible for better mount performance.
> >
> > change log:
> >  o merge judgements/use 'Continue' or 'Break' instead of 'Goto' as =
Gu Zheng
> >    suggested.
> >  o add mark_page_accessed() before release page to delay VM reclaim=
ing.
> >  o remove '*order' for simplification of function as Jaegeuk Kim su=
ggested.
> >
> > Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> > ---
> >  fs/f2fs/segment.c |  103 +++++++++++++++++++++++++++++++++++++++--=
------------
> >  fs/f2fs/segment.h |    2 ++
> >  2 files changed, 78 insertions(+), 27 deletions(-)
> >
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index 8149eba..998e7d3 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/blkdev.h>
> >  #include <linux/prefetch.h>
> >  #include <linux/vmalloc.h>
> > +#include <linux/swap.h>
> >
> >  #include "f2fs.h"
> >  #include "segment.h"
> > @@ -1488,41 +1489,89 @@ static int build_curseg(struct f2fs_sb_info=
 *sbi)
> >  	return restore_curseg_summaries(sbi);
> >  }
> >
> > +static int ra_sit_pages(struct f2fs_sb_info *sbi, int start, int n=
rpages)
> > +{
> > +	struct address_space *mapping =3D sbi->meta_inode->i_mapping;
> > +	struct page *page;
> > +	block_t blk_addr, prev_blk_addr =3D 0;
> > +	int sit_blk_cnt =3D SIT_BLK_CNT(sbi);
> > +	int blkno =3D start;
> > +
> > +	for (; blkno < start + nrpages && blkno < sit_blk_cnt; blkno++) {
> > +
> > +		blk_addr =3D current_sit_addr(sbi, start * SIT_ENTRY_PER_BLOCK);
>=20
> Should be:
> 	blk_addr =3D current_sit_addr(sbi, blkno * SIT_ENTRY_PER_BLOCK);
> 	                                -------
> I'll fix this and merge the patch though.
> Thanks,

Oh, It's my mistake, sorry for that.
Thanks for your review! :)

>=20
> --
> Jaegeuk Kim
> Samsung
