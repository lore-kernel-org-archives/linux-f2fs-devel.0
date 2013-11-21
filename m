From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH V2 2/2 RESEND] f2fs: read contiguous sit entry
 pages by merging for mount performance
Date: Thu, 21 Nov 2013 14:37:57 +0800
Message-ID: <000201cee684$550e11a0$ff2a34e0$@samsung.com>
References: <001d01cee5bc$779c2fe0$66d48fa0$@samsung.com>
 <1384997517.26319.60.camel@kjgkr>
 <000001cee668$872ec6a0$958c53e0$@samsung.com> <1385009132.26319.71.camel@kjgkr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <1385009132.26319.71.camel@kjgkr>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: jaegeuk.kim@samsung.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, =?UTF-8?B?J+iwreWnnSc=?= <shu.tan@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk.kim@samsung.com]
> Sent: Thursday, November 21, 2013 12:46 PM
> To: Chao Yu
> Cc: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org; linu=
x-f2fs-devel@lists.sourceforge.net; '=E8=B0=AD=E5=A7=9D'
> Subject: RE: [f2fs-dev] [PATCH V2 2/2 RESEND] f2fs: read contiguous s=
it entry pages by merging for mount performance
>=20
> Hi,
>=20
> 2013-11-21 (=EB=AA=A9), 11:18 +0800, Chao Yu:
> > Hi,
> >
> > > -----Original Message-----
> > > From: Jaegeuk Kim [mailto:jaegeuk.kim@samsung.com]
> > > Sent: Thursday, November 21, 2013 9:32 AM
> > > To: Chao Yu
> > > Cc: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org; =
linux-f2fs-devel@lists.sourceforge.net; =E8=B0=AD=E5=A7=9D
> > > Subject: Re: [f2fs-dev] [PATCH V2 2/2 RESEND] f2fs: read contiguo=
us sit entry pages by merging for mount performance
> > >
> > > Hi,
> > >
> > > It seems that ra_sit_pages() is too tightly coupled with
> > > build_sit_entries().
> >
> > This code could be improved.
> >
> > > Is there another way not to use *is_order?
> >
> > Previously the code is like this:
> >  -build_sit_entries()
> >  next_setp:
> > 	for(start =3D 0; start < TOTAL_SEGS(sbi); start++)
> > 		/*step#1 readahead all sit entries blocks*/
> > 			if(start % SIT_ENTRY_PER_BLOCK =3D=3D 0) {
> > 				blk_addr =3D current_sit_addr(sbi, start);
> > 				/* grab and submit_read_page */
> > 			}
> > 			if(start =3D=3D TOTAL_SEGS(sbi) - 1)
> > 				f2fs_submit_read_bio();
> > 			continue;
> > 		/*step#2 fill sit entries info*/
> > 		/*step#3 cover sit entries with journal*/
> >
> > But I think its weakness is that it will cost lots of memory to rea=
d
> > ahead all sit entry pages when f2fs mount, and also it's serious wa=
ste
> > that we read them again after these pages are released by VM when
> > out of memory.
> >
> > >
> > > The ra_sit_pages() tries to read consecutive sit pages as many as
> > > possible.
> > > So then, what about just checking whether its block address is
> > > contiguous or not?
> > >
> > > Something like this:
> > >  -ra_sit_pages()
> > > 	blkno =3D start;
> > > 	while (blkno < sit_i->sit_blocks) {
> > > 		blk_addr =3D current_sit_addr(sbi, blkno);
> > > 		if (blkno !=3D start && prev_blk_addr + 1 !=3D blk_addr)
> > > 			break;
> > >
> > > 		/* grab and submit_read_page */
> > >
> > > 		prev_blk_addr =3D blk_addr;
> > > 		blkno++;
> > > 	}
> >
> > Agreed, this method could remove *order.
> > Shouldn't we add nrpages for readahead policy as VM?
>=20
> Aha, agreed.
> We need nrpages to avoid too many reads on sit blocks.
>=20
> But, still it needs to change the nrpages in its caller.
> In your patch, it was sit_i->sit_blocks that is total # of sit blocks=
=2E
> I think 128 or 256 is quite reasonable number.

Hmm, Originally in [PATCH V1] it was be set to=20
MAX_BIO_BLOCKS(max_hw_blocks(sbi)).

So it could be "#define SIT_ENTRIES_RA_NUM	128"?
BTW, maybe we should send dynamical nrpages which depend on=20
memory state of system as I mention in previous thread.
How do you think?

>=20
> Anyway, how about implementing ra_sit_pages() with a blk_plug likewis=
e
> ra_node_pages()?

So we use this structure to plug multi bios submitting in ra_sit_pages(=
), right?
-build_sit_entries()
	blk_start_plug(&plug);
	ra_sit_pages();
	blk_finish_plug(&plug);

>=20
> --
> Jaegeuk Kim
> Samsung

--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
