From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: RE: [f2fs-dev] [PATCH V3 2/2] f2fs: read contiguous sit entry pages by
 merging for mount performance
Date: Sun, 24 Nov 2013 13:05:26 +0900
Message-ID: <1385265926.26319.96.camel@kjgkr>
References: <000301cee71f$b0e54160$12afc420$@samsung.com>
 <1385111441.26319.81.camel@kjgkr> <000c01cee7f7$471c04c0$d5540e40$@samsung.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <000c01cee7f7$471c04c0$d5540e40$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, =?UTF-8?Q?=27=E8=B0=AD=E5=A7=9D=27?= <shu.tan@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

2013-11-23 (=ED=86=A0), 10:53 +0800, Chao Yu:
> Hi,
>=20
> > -----Original Message-----
> > From: Jaegeuk Kim [mailto:jaegeuk.kim@samsung.com]
> > Sent: Friday, November 22, 2013 5:11 PM
> > To: Chao Yu
> > Cc: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org; li=
nux-f2fs-devel@lists.sourceforge.net; =E8=B0=AD=E5=A7=9D
> > Subject: Re: [f2fs-dev] [PATCH V3 2/2] f2fs: read contiguous sit en=
try pages by merging for mount performance
> >=20
> > Hi,
> >=20
> > Just one niptick.
> >=20
> > 2013-11-22 (=EA=B8=88), 09:09 +0800, Chao Yu:
> > > Previously we read sit entries page one by one, this method lost =
the chance
> > > of reading contiguous page together. So we read pages as contiguo=
us as
> > > possible for better mount performance.
> > >
> > > change log:
> > >  o merge judgements/use 'Continue' or 'Break' instead of 'Goto' a=
s Gu Zheng
> > >    suggested.
> > >  o add mark_page_accessed() before release page to delay VM recla=
iming.
> > >  o remove '*order' for simplification of function as Jaegeuk Kim =
suggested.
> > >
> > > Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> > > ---
> > >  fs/f2fs/segment.c |  103 +++++++++++++++++++++++++++++++++++++++=
--------------
> > >  fs/f2fs/segment.h |    2 ++
> > >  2 files changed, 78 insertions(+), 27 deletions(-)
> > >
> > > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > > index 8149eba..998e7d3 100644
> > > --- a/fs/f2fs/segment.c
> > > +++ b/fs/f2fs/segment.c
> > > @@ -14,6 +14,7 @@
> > >  #include <linux/blkdev.h>
> > >  #include <linux/prefetch.h>
> > >  #include <linux/vmalloc.h>
> > > +#include <linux/swap.h>
> > >
> > >  #include "f2fs.h"
> > >  #include "segment.h"
> > > @@ -1488,41 +1489,89 @@ static int build_curseg(struct f2fs_sb_in=
fo *sbi)
> > >  	return restore_curseg_summaries(sbi);
> > >  }
> > >
> > > +static int ra_sit_pages(struct f2fs_sb_info *sbi, int start, int=
 nrpages)
> > > +{
> > > +	struct address_space *mapping =3D sbi->meta_inode->i_mapping;
> > > +	struct page *page;
> > > +	block_t blk_addr, prev_blk_addr =3D 0;
> > > +	int sit_blk_cnt =3D SIT_BLK_CNT(sbi);
> >=20
> > Can we remove SIT_BLK_CNT by replacing with sit_i->sit_blocks?
>=20
> Because sit_i->sit_blocks is a multiple of segment size(i.e. 512/1024=
),
> but we may use part of sit_blocks, not all of them. So it's waste to =
read=20
> all of them.
> What's your opinion?

Got it.
It's right and we can avoid that.
Thanks, :)

--=20
Jaegeuk Kim
Samsung
