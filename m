From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: video archive on a microSD card
Date: Tue, 23 Aug 2016 14:12:22 -0700
Message-ID: <20160823211222.GD73835@jaegeuk>
References: <146631471002747@web20h.yandex.ru>
	<281281471258049@web6h.yandex.ru>
	<eac97eb4-6b4a-a987-48e9-72680238e50a@huawei.com>
	<7021471263772@web16m.yandex.ru> <158901471427237@web4g.yandex.ru>
	<bd0fc9a6-03d3-e32c-f6c7-f64d4ba8506e@kernel.org>
	<1184081471518295@web5m.yandex.ru> <20160819024105.GA64207@jaegeuk>
	<1258721471607772@web12h.yandex.ru>
	<324581471899132@web4j.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bcIzo-0001DE-9t
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 23 Aug 2016 21:12:32 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bcIzn-00009P-3z
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 23 Aug 2016 21:12:32 +0000
Content-Disposition: inline
In-Reply-To: <324581471899132@web4j.yandex.ru>
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

On Mon, Aug 22, 2016 at 11:52:12PM +0300, Alexander Gordeev wrote:
> Hi,
> =

> I ran the test over weekend and I think I have some interesting results.
> I used 1 new SD card in one device and two fully utilized SD cards,
> that have problems with write latency, on two oter devices.
> I mounted all the cards with mode=3Dlfs. The new SD card got utilized at =
95% after some time.
> Here is the current status after the archive is rotated for some time:
> =

> =3D=3D=3D=3D=3D[ partition info(sda1). #0, RW]=3D=3D=3D=3D=3D
> [SB: 1] [CP: 2] [SIT: 2] [NAT: 68] [SSA: 30] [MAIN: 15112(OverProv:803 Re=
sv:50)]
> =

> Utilization: 94% (6929763 valid blocks)
>   - Node: 8113 (Inode: 1255, Other: 6858)
>   - Data: 6921650
>   - Inline_xattr Inode: 0
>   - Inline_data Inode: 1
>   - Inline_dentry Inode: 0
>   - Orphan Inode: 0
> =

> Main area: 15112 segs, 7556 secs 7556 zones
>   - COLD  data: 5306, 2653, 2653
>   - WARM  data: 5233, 2616, 2616
>   - HOT   data: 15100, 7550, 7550
>   - Dir   dnode: 15097, 7548, 7548
>   - File   dnode: 4701, 2350, 2350
>   - Indir nodes: 15105, 7552, 7552
> =

>   - Valid: 97
>   - Dirty: 13798
>   - Prefree: 0
>   - Free: 1217 (604)
> =

> CP calls: 282 (BG: 0)
> GC calls: 0 (BG: 0)
>   - data segments : 0 (0)
>   - node segments : 0 (0)
> Try to move 0 blocks (BG: 0)
>   - data blocks : 0 (0)
>   - node blocks : 0 (0)
> =

> Extent Cache:
>   - Hit Count: L1-1:3084 L1-2:456 L2:0
>   - Hit Ratio: 4% (3540 / 84026)
>   - Inner Struct Count: tree: 1252(0), node: 0
> =

> Balancing F2FS Async:
>   - inmem:    0, wb_bios:    0
>   - nodes:   12 in   30
>   - dents:    3 in dirs:   2 (   2)
>   - datas:   48 in files:   0
>   - meta:    9 in   34
>   - NATs:        10/      249
>   - SITs:        13/    15112
>   - free_nids:      1797
> =

> Distribution of User Blocks: [ valid | invalid | free ]
>   [-----------------------------------------------|--|-]
> =

> IPU: 0 blocks
> SSR: 0 blocks in 0 segments
> LFS: 912188 blocks in 1781 segments
> =

> BDF: 94, avg. vblocks: 996
> =

> Memory: 3604 KB
>   - static: 3270 KB
>   - cached: 78 KB
>   - paged : 256 KB
> =

> =

> The interesting thing here is the very small number of valid and
> a huge number of dirty sections. I don't understand this at all.

This is the number of dirty segments, so it needs to consider section and
segment at the same time; a dirty section can consist of valid and free
segments.
How abouting testing 2MB-sized section which is the default option?

> Still the archive is working perfectly. Also I see, that there GC is never
> called, which is probably an indication of FS working exactly as
> we expected.
> Also the small number of cold sections does not make problems.
> So, well, it works perfect so fat. But I don't understand everything here.
> Is this expected?

So, I'm in doubt that dirty sections consist of entirely valid or free segm=
ents.

> =

> The other two SD cards were tested differently. On one of them I called
> ioctl(F2FS_IOC_GARBAGE_COLLECT) for several hours. And indeed the number
> of dirty sectoins dropped considerably. It works fine so far.

It makes sense that valid segments in dirty sections would be migrated to
different free sections.

> On the other SD card I called ioctl(F2FS_IOC_DEFRAGMENT) for every
> file in the archive. It works fine as well now. But the number of dirty s=
ections
> was still very high at the end of defragmentation. I don't understand this
> as well.

This is for defragementation to the given file, which would not move blocks=
 in
order to decrease the number of dirty sections.
I think it's not necessary for this workload.

Thanks,

> =

> Thanks!
> =

> 19.08.2016, 14:56, "Alexander Gordeev" <alex@gordick.net>:
> > =A0Hi Jaegeuk,
> >
> > =A019.08.2016, 05:41, "Jaegeuk Kim" <jaegeuk@kernel.org>:
> >> =A0=A0=A0Hello,
> >>
> >> =A0=A0=A0On Thu, Aug 18, 2016 at 02:04:55PM +0300, Alexander Gordeev w=
rote:
> >>
> >> =A0=A0=A0...
> >>
> >>> =A0=A0=A0=A0>>>>>>> =A0=A0Here is also /sys/kernel/debug/f2fs/status =
for reference:
> >>> =A0=A0=A0=A0>>>>>>> =A0=A0=3D=3D=3D=3D=3D[ partition info(sda). #0 ]=
=3D=3D=3D=3D=3D
> >>> =A0=A0=A0=A0>>>>>>> =A0=A0[SB: 1] [CP: 2] [SIT: 4] [NAT: 118] [SSA: 6=
0] [MAIN: 29646(OverProv:1529
> >>> =A0=A0=A0=A0>>>>>>> =A0Resv:50)]
> >>> =A0=A0=A0=A0>>>>>>>
> >>> =A0=A0=A0=A0>>>>>>> =A0=A0Utilization: 94% (13597314 valid blocks)
> >>> =A0=A0=A0=A0>>>>>>> =A0=A0=A0=A0- Node: 16395 (Inode: 2913, Other: 13=
482)
> >>> =A0=A0=A0=A0>>>>>>> =A0=A0=A0=A0- Data: 13580919
> >>> =A0=A0=A0=A0>>>>>>>
> >>> =A0=A0=A0=A0>>>>>>> =A0=A0Main area: 29646 segs, 14823 secs 14823 zon=
es
> >>> =A0=A0=A0=A0>>>>>>> =A0=A0=A0=A0- COLD data: 3468, 1734, 1734
> >>> =A0=A0=A0=A0>>>>>>> =A0=A0=A0=A0- WARM data: 12954, 6477, 6477
> >>> =A0=A0=A0=A0>>>>>>> =A0=A0=A0=A0- HOT data: 28105, 14052, 14052
> >>> =A0=A0=A0=A0>>>>>>> =A0=A0=A0=A0- Dir dnode: 29204, 14602, 14602
> >>> =A0=A0=A0=A0>>>>>>> =A0=A0=A0=A0- File dnode: 19960, 9980, 9980
> >>> =A0=A0=A0=A0>>>>>>> =A0=A0=A0=A0- Indir nodes: 29623, 14811, 14811
> >>> =A0=A0=A0=A0>>>>>>>
> >>> =A0=A0=A0=A0>>>>>>> =A0=A0=A0=A0- Valid: 13615
> >>> =A0=A0=A0=A0>>>>>>> =A0=A0=A0=A0- Dirty: 13309
> >>> =A0=A0=A0=A0>>>>>>> =A0=A0=A0=A0- Prefree: 0
> >>> =A0=A0=A0=A0>>>>>>> =A0=A0=A0=A0- Free: 2722 (763)
> >>> =A0=A0=A0=A0>>>>>>>
> >>> =A0=A0=A0=A0>>>>>>> =A0=A0GC calls: 8622 (BG: 4311)
> >>> =A0=A0=A0=A0>>>>>>> =A0=A0=A0=A0- data segments : 8560
> >>> =A0=A0=A0=A0>>>>>>> =A0=A0=A0=A0- node segments : 62
> >>> =A0=A0=A0=A0>>>>>>> =A0=A0Try to move 3552161 blocks
> >>> =A0=A0=A0=A0>>>>>>> =A0=A0=A0=A0- data blocks : 3540278
> >>> =A0=A0=A0=A0>>>>>>> =A0=A0=A0=A0- node blocks : 11883
> >>> =A0=A0=A0=A0>>>>>>>
> >>> =A0=A0=A0=A0>>>>>>> =A0=A0Extent Hit Ratio: 49 / 4171
> >>> =A0=A0=A0=A0>>>>>>>
> >>> =A0=A0=A0=A0>>>>>>> =A0=A0Balancing F2FS Async:
> >>> =A0=A0=A0=A0>>>>>>> =A0=A0=A0=A0- nodes 6 in 141
> >>> =A0=A0=A0=A0>>>>>>> =A0=A0=A0=A0- dents 0 in dirs: 0
> >>> =A0=A0=A0=A0>>>>>>> =A0=A0=A0=A0- meta 13 in 346
> >>> =A0=A0=A0=A0>>>>>>> =A0=A0=A0=A0- NATs 16983 > 29120
> >>> =A0=A0=A0=A0>>>>>>> =A0=A0=A0=A0- SITs: 17
> >>> =A0=A0=A0=A0>>>>>>> =A0=A0=A0=A0- free_nids: 1861
> >>> =A0=A0=A0=A0>>>>>>>
> >>> =A0=A0=A0=A0>>>>>>> =A0=A0Distribution of User Blocks: [ valid | inva=
lid | free ]
> >>> =A0=A0=A0=A0>>>>>>> =A0=A0=A0=A0[------------------------------------=
-----------|-|--]
> >>> =A0=A0=A0=A0>>>>>>>
> >>> =A0=A0=A0=A0>>>>>>> =A0=A0SSR: 1230719 blocks in 14834 segments
> >>> =A0=A0=A0=A0>>>>>>> =A0=A0LFS: 15150190 blocks in 29589 segments
> >>> =A0=A0=A0=A0>>>>>>>
> >>> =A0=A0=A0=A0>>>>>>> =A0=A0BDF: 89, avg. vblocks: 949
> >>> =A0=A0=A0=A0>>>>>>>
> >>> =A0=A0=A0=A0>>>>>>> =A0=A0Memory: 6754 KB =3D static: 4763 + cached: =
1990
> >>
> >> =A0=A0=A0...
> >>
> >>> =A0=A0=A0=A0>> =A0Per my understanding of f2fs internals, it should w=
rite these "cold" files and
> >>> =A0=A0=A0=A0>> =A0usual "hot" files to different sections (that shoul=
d map internally to
> >>> =A0=A0=A0=A0>> =A0different allocation units). So the sections used b=
y "cold" data should almost
> >>> =A0=A0=A0=A0>> =A0never get "dirty" because most of the time all thei=
r blocks become free at
> >>> =A0=A0=A0=A0>> =A0the same time. Of course, the files are not exactly=
 4MB in size so the last
> >>> =A0=A0=A0=A0>> =A0section of the deleted file will become dirty. If i=
t is moved by garbage
> >>> =A0=A0=A0=A0>> =A0collector and becomes mixed with fresh "cold" data,=
 then indeed it might cause
> >>> =A0=A0=A0=A0>> =A0some problems, I think. What is your opinion?
> >>> =A0=A0=A0=A0>
> >>> =A0=A0=A0=A0> If your fs is not fragmented, it may be as what you sai=
d, otherwise, SSR will
> >>> =A0=A0=A0=A0> still try to reuse invalid block of other temperture se=
gments, then your cold
> >>> =A0=A0=A0=A0> data will be fixed with warm data too.
> >>> =A0=A0=A0=A0>
> >>> =A0=A0=A0=A0> I guess, what you are facing is the latter one:
> >>> =A0=A0=A0=A0> SSR: 1230719 blocks in 14834 segments
> >>>
> >>> =A0=A0=A0=A0I guess, I need to somehow disable any cleaning or SSR fo=
r my archive and index
> >>> =A0=A0=A0=A0files. But keep the cleaning for other data and nodes.
> >>
> >> =A0=A0=A0Could you test a mount option, "mode=3Dlfs", to disable SSR?
> >> =A0=A0=A0(I guess sqlite may suffer from logner latency due to GC thou=
gh.)
> >>
> >> =A0=A0=A0Seems like it's caused by SSR starting to make worse before 9=
5% as you described
> >> =A0=A0=A0below.
> >
> > =A0Thanks, I'll run a test with a couple of SD cards over weekend.
> > =A0So if I understand it correctly, GC will not cause the problems desc=
ribed below, right?
> > =A0I.e. it will not mix the new data with old data from dirty sections?
> > =A0Longer SQLite latencies should not be a problem because the database=
 is written not
> > =A0frequently and also it is about 200-250KB in size usually. Maybe for=
cing IPU as
> > =A0suggested by Chao would help sqlite, no?
> > =A0However looks like setting ipu_policy to 1 has no effect when mode=
=3Dlfs.
> > =A0The IPU counter is still zero on my test system.
> > ...
> --=A0
> =A0Alexander

---------------------------------------------------------------------------=
---
