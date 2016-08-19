From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: video archive on a microSD card
Date: Fri, 19 Aug 2016 11:41:05 +0900
Message-ID: <20160819024105.GA64207@jaegeuk>
References: <146631471002747@web20h.yandex.ru>
	<281281471258049@web6h.yandex.ru>
	<eac97eb4-6b4a-a987-48e9-72680238e50a@huawei.com>
	<7021471263772@web16m.yandex.ru> <158901471427237@web4g.yandex.ru>
	<bd0fc9a6-03d3-e32c-f6c7-f64d4ba8506e@kernel.org>
	<1184081471518295@web5m.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1baZkF-0002Mi-NT
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 19 Aug 2016 02:41:19 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1baZkD-0001xO-OJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 19 Aug 2016 02:41:19 +0000
Content-Disposition: inline
In-Reply-To: <1184081471518295@web5m.yandex.ru>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Alexander Gordeev <alex@gordick.net>
Cc: Chao Yu <chao@kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

Hello,

On Thu, Aug 18, 2016 at 02:04:55PM +0300, Alexander Gordeev wrote:

...

> >>>>>>> =A0=A0Here is also /sys/kernel/debug/f2fs/status for reference:
> >>>>>>> =A0=A0=3D=3D=3D=3D=3D[ partition info(sda). #0 ]=3D=3D=3D=3D=3D
> >>>>>>> =A0=A0[SB: 1] [CP: 2] [SIT: 4] [NAT: 118] [SSA: 60] [MAIN: 29646(=
OverProv:1529
> >>>>>>> =A0Resv:50)]
> >>>>>>>
> >>>>>>> =A0=A0Utilization: 94% (13597314 valid blocks)
> >>>>>>> =A0=A0=A0=A0- Node: 16395 (Inode: 2913, Other: 13482)
> >>>>>>> =A0=A0=A0=A0- Data: 13580919
> >>>>>>>
> >>>>>>> =A0=A0Main area: 29646 segs, 14823 secs 14823 zones
> >>>>>>> =A0=A0=A0=A0- COLD data: 3468, 1734, 1734
> >>>>>>> =A0=A0=A0=A0- WARM data: 12954, 6477, 6477
> >>>>>>> =A0=A0=A0=A0- HOT data: 28105, 14052, 14052
> >>>>>>> =A0=A0=A0=A0- Dir dnode: 29204, 14602, 14602
> >>>>>>> =A0=A0=A0=A0- File dnode: 19960, 9980, 9980
> >>>>>>> =A0=A0=A0=A0- Indir nodes: 29623, 14811, 14811
> >>>>>>>
> >>>>>>> =A0=A0=A0=A0- Valid: 13615
> >>>>>>> =A0=A0=A0=A0- Dirty: 13309
> >>>>>>> =A0=A0=A0=A0- Prefree: 0
> >>>>>>> =A0=A0=A0=A0- Free: 2722 (763)
> >>>>>>>
> >>>>>>> =A0=A0GC calls: 8622 (BG: 4311)
> >>>>>>> =A0=A0=A0=A0- data segments : 8560
> >>>>>>> =A0=A0=A0=A0- node segments : 62
> >>>>>>> =A0=A0Try to move 3552161 blocks
> >>>>>>> =A0=A0=A0=A0- data blocks : 3540278
> >>>>>>> =A0=A0=A0=A0- node blocks : 11883
> >>>>>>>
> >>>>>>> =A0=A0Extent Hit Ratio: 49 / 4171
> >>>>>>>
> >>>>>>> =A0=A0Balancing F2FS Async:
> >>>>>>> =A0=A0=A0=A0- nodes 6 in 141
> >>>>>>> =A0=A0=A0=A0- dents 0 in dirs: 0
> >>>>>>> =A0=A0=A0=A0- meta 13 in 346
> >>>>>>> =A0=A0=A0=A0- NATs 16983 > 29120
> >>>>>>> =A0=A0=A0=A0- SITs: 17
> >>>>>>> =A0=A0=A0=A0- free_nids: 1861
> >>>>>>>
> >>>>>>> =A0=A0Distribution of User Blocks: [ valid | invalid | free ]
> >>>>>>> =A0=A0=A0=A0[-----------------------------------------------|-|--]
> >>>>>>>
> >>>>>>> =A0=A0SSR: 1230719 blocks in 14834 segments
> >>>>>>> =A0=A0LFS: 15150190 blocks in 29589 segments
> >>>>>>>
> >>>>>>> =A0=A0BDF: 89, avg. vblocks: 949
> >>>>>>>
> >>>>>>> =A0=A0Memory: 6754 KB =3D static: 4763 + cached: 1990

...

> >> =A0Per my understanding of f2fs internals, it should write these "cold=
" files and
> >> =A0usual "hot" files to different sections (that should map internally=
 to
> >> =A0different allocation units). So the sections used by "cold" data sh=
ould almost
> >> =A0never get "dirty" because most of the time all their blocks become =
free at
> >> =A0the same time. Of course, the files are not exactly 4MB in size so =
the last
> >> =A0section of the deleted file will become dirty. If it is moved by ga=
rbage
> >> =A0collector and becomes mixed with fresh "cold" data, then indeed it =
might cause
> >> =A0some problems, I think. What is your opinion?
> >
> > If your fs is not fragmented, it may be as what you said, otherwise, SS=
R will
> > still try to reuse invalid block of other temperture segments, then you=
r cold
> > data will be fixed with warm data too.
> >
> > I guess, what you are facing is the latter one:
> > SSR: 1230719 blocks in 14834 segments
> =

> I guess, I need to somehow disable any cleaning or SSR for my archive and=
 index
> files. But keep the cleaning for other data and nodes.

Could you test a mount option, "mode=3Dlfs", to disable SSR?
(I guess sqlite may suffer from logner latency due to GC though.)

Seems like it's caused by SSR starting to make worse before 95% as you desc=
ribed
below.

Thanks,

> I think the FS can get fragmented quite easily otherwise. The status abov=
e is
> captured when the FS already has problems. I think it can become fragment=
ed
> this way:
> 1. The archive is written until the utilization is 95%. It is written sep=
arately from other
> data and nodes thanks to the "cold" data feature.
> 2. After hitting 95% the archive my program starts to rotate the archive.=
 The rotation
> routine checks the free space, reported by statfs(), once a minute. If it=
 is below 5%
> of total, then it deletes several oldest records in the archive.
> 3. The last deleted record leaves a dirty section. This section holds sev=
eral blocks
> from a record, which now becomes the oldest one.
> 4. This section is merged with fresh "cold" or even warmer data by either=
 GC, or
> SSR in one or more newly used sections.
> 5. Then very soon the new oldest record is again deleted. And now we have=
 one
> or even several dirty sections filled with blocks from a not so old recor=
d. Which are
> again merged with other records.
> 6. All the records get fragmented after one full rotation. The fragmentat=
ion gets
> worse and worse.
> =

> So I think the best thing to do is to have sections with "cold" data be c=
ompletely
> out of all the cleaning schemes. It will clean itself by rotating.
> Still other data and nodes might need to use some cleaning schemes.
> Please correct me if I don't get it right.
> =

> > Maybe we can try to alter updating policy from OPU to IPU for your case=
 to avoid
> > performance regression of SSR and more frequently FG-GC:
> >
> > echo 1 > /sys/fs/f2fs/"yourdevicename"/ipu_policy
> =

> Thanks, I'll try it!
> =

> --=A0
>  Alexander
> =

> -------------------------------------------------------------------------=
-----
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

---------------------------------------------------------------------------=
---
