From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: video archive on a microSD card
Date: Fri, 26 Aug 2016 18:20:32 -0700
Message-ID: <20160827012032.GG88444@jaegeuk>
References: <eac97eb4-6b4a-a987-48e9-72680238e50a@huawei.com>
	<7021471263772@web16m.yandex.ru> <158901471427237@web4g.yandex.ru>
	<bd0fc9a6-03d3-e32c-f6c7-f64d4ba8506e@kernel.org>
	<1184081471518295@web5m.yandex.ru> <20160819024105.GA64207@jaegeuk>
	<1258721471607772@web12h.yandex.ru>
	<324581471899132@web4j.yandex.ru> <20160823211222.GD73835@jaegeuk>
	<139021472156043@web27j.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bdSIc-00046M-Af
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 27 Aug 2016 01:20:42 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bdSIb-0000mw-4a
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 27 Aug 2016 01:20:42 +0000
Content-Disposition: inline
In-Reply-To: <139021472156043@web27j.yandex.ru>
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

On Thu, Aug 25, 2016 at 11:14:03PM +0300, Alexander Gordeev wrote:
> Hi Jaegeuk,
> =

> Thanks for all the help!
> =

> 24.08.2016, 00:12, "Jaegeuk Kim" <jaegeuk@kernel.org>:
> > On Mon, Aug 22, 2016 at 11:52:12PM +0300, Alexander Gordeev wrote:
> >> =A0Hi,
> >>
> >> =A0I ran the test over weekend and I think I have some interesting res=
ults.
> >> =A0I used 1 new SD card in one device and two fully utilized SD cards,
> >> =A0that have problems with write latency, on two oter devices.
> >> =A0I mounted all the cards with mode=3Dlfs. The new SD card got utiliz=
ed at 95% after some time.
> >> =A0Here is the current status after the archive is rotated for some ti=
me:
> >>
> >> =A0=3D=3D=3D=3D=3D[ partition info(sda1). #0, RW]=3D=3D=3D=3D=3D
> >> =A0[SB: 1] [CP: 2] [SIT: 2] [NAT: 68] [SSA: 30] [MAIN: 15112(OverProv:=
803 Resv:50)]
> >>
> >> =A0Utilization: 94% (6929763 valid blocks)
> >> =A0=A0=A0- Node: 8113 (Inode: 1255, Other: 6858)
> >> =A0=A0=A0- Data: 6921650
> >> =A0=A0=A0- Inline_xattr Inode: 0
> >> =A0=A0=A0- Inline_data Inode: 1
> >> =A0=A0=A0- Inline_dentry Inode: 0
> >> =A0=A0=A0- Orphan Inode: 0
> >>
> >> =A0Main area: 15112 segs, 7556 secs 7556 zones
> >> =A0=A0=A0- COLD data: 5306, 2653, 2653
> >> =A0=A0=A0- WARM data: 5233, 2616, 2616
> >> =A0=A0=A0- HOT data: 15100, 7550, 7550
> >> =A0=A0=A0- Dir dnode: 15097, 7548, 7548
> >> =A0=A0=A0- File dnode: 4701, 2350, 2350
> >> =A0=A0=A0- Indir nodes: 15105, 7552, 7552
> >>
> >> =A0=A0=A0- Valid: 97
> >> =A0=A0=A0- Dirty: 13798
> >> =A0=A0=A0- Prefree: 0
> >> =A0=A0=A0- Free: 1217 (604)
> >>
> >> =A0CP calls: 282 (BG: 0)
> >> =A0GC calls: 0 (BG: 0)
> >> =A0=A0=A0- data segments : 0 (0)
> >> =A0=A0=A0- node segments : 0 (0)
> >> =A0Try to move 0 blocks (BG: 0)
> >> =A0=A0=A0- data blocks : 0 (0)
> >> =A0=A0=A0- node blocks : 0 (0)
> >>
> >> =A0Extent Cache:
> >> =A0=A0=A0- Hit Count: L1-1:3084 L1-2:456 L2:0
> >> =A0=A0=A0- Hit Ratio: 4% (3540 / 84026)
> >> =A0=A0=A0- Inner Struct Count: tree: 1252(0), node: 0
> >>
> >> =A0Balancing F2FS Async:
> >> =A0=A0=A0- inmem: 0, wb_bios: 0
> >> =A0=A0=A0- nodes: 12 in 30
> >> =A0=A0=A0- dents: 3 in dirs: 2 ( 2)
> >> =A0=A0=A0- datas: 48 in files: 0
> >> =A0=A0=A0- meta: 9 in 34
> >> =A0=A0=A0- NATs: 10/ 249
> >> =A0=A0=A0- SITs: 13/ 15112
> >> =A0=A0=A0- free_nids: 1797
> >>
> >> =A0Distribution of User Blocks: [ valid | invalid | free ]
> >> =A0=A0=A0[-----------------------------------------------|--|-]
> >>
> >> =A0IPU: 0 blocks
> >> =A0SSR: 0 blocks in 0 segments
> >> =A0LFS: 912188 blocks in 1781 segments
> >>
> >> =A0BDF: 94, avg. vblocks: 996
> >>
> >> =A0Memory: 3604 KB
> >> =A0=A0=A0- static: 3270 KB
> >> =A0=A0=A0- cached: 78 KB
> >> =A0=A0=A0- paged : 256 KB
> >>
> >> =A0The interesting thing here is the very small number of valid and
> >> =A0a huge number of dirty sections. I don't understand this at all.
> >
> > This is the number of dirty segments, so it needs to consider section a=
nd
> > segment at the same time; a dirty section can consist of valid and free
> > segments.
> > How abouting testing 2MB-sized section which is the default option?
> =

> I tried what you said. Still the majority of segments are dirty for some =
reason:
> =

> =3D=3D=3D=3D=3D[ partition info(sda). #0, RW]=3D=3D=3D=3D=3D
> [SB: 1] [CP: 2] [SIT: 6] [NAT: 114] [SSA: 116] [MAIN: 59149(OverProv:3003=
 Resv:48)]
> =

> Utilization: 10% (3013093 valid blocks)
>   - Node: 3528 (Inode: 548, Other: 2980)
>   - Data: 3009565
>   - Inline_xattr Inode: 0
>   - Inline_data Inode: 0
>   - Inline_dentry Inode: 0
>   - Orphan Inode: 0
> =

> Main area: 59149 segs, 59149 secs 59149 zones
>   - COLD  data: 7183, 7183, 7183
>   - WARM  data: 6654, 6654, 6654
>   - HOT   data: 59134, 59134, 59134
>   - Dir   dnode: 59127, 59127, 59127
>   - File   dnode: 59125, 59125, 59125
>   - Indir nodes: 59129, 59129, 59129
> =

>   - Valid: 300
>   - Dirty: 6438
>   - Prefree: 0
>   - Free: 52411 (52411)
> =

> CP calls: 1023 (BG: 473)
> GC calls: 470 (BG: 470)
>   - data segments : 466 (466)
>   - node segments : 4 (4)
> Try to move 152221 blocks (BG: 152221)
>   - data blocks : 151417 (151417)
>   - node blocks : 804 (804)
> =

> Extent Cache:
>   - Hit Count: L1-1:6262 L1-2:0 L2:0
>   - Hit Ratio: 2% (6262 / 273606)
>   - Inner Struct Count: tree: 292(0), node: 8
> =

> Balancing F2FS Async:
>   - inmem:    0, wb_bios:    0
>   - nodes:    0 in    0
>   - dents:    0 in dirs:   0 (   0)
>   - datas:    0 in files:   0
>   - meta:    0 in    0
>   - NATs:         0/       43
>   - SITs:         0/    59149
>   - free_nids:      3414
> =

> Distribution of User Blocks: [ valid | invalid | free ]
>   [-----|--|-------------------------------------------]
> =

> IPU: 0 blocks
> SSR: 0 blocks in 0 segments
> LFS: 3691542 blocks in 7208 segments
> =

> BDF: 95, avg. vblocks: 444
> =

> Memory: 12662 KB
>   - static: 12597 KB
>   - cached: 64 KB
>   - paged : 0 KB
> =

> =

> But the archive is working perfectly as before.

Okay, so we need to gather more information about IO traces. :)

Could you get them by:

echo 1 > /sys/kernel/debug/tracing/events/f2fs/f2fs_submit_write_bio/enable
echo 1 > /sys/kernel/debug/tracing/events/f2fs/f2fs_submit_page_mbio/enable
echo 1 > /sys/kernel/debug/tracing/tracing_on
cat /sys/kernel/debug/tracing/trace_pipe

You can get a script in f2fs-tools.git/scripts/tracepoint.sh

Thanks,

> =

> >> =A0Still the archive is working perfectly. Also I see, that there GC i=
s never
> >> =A0called, which is probably an indication of FS working exactly as
> >> =A0we expected.
> >> =A0Also the small number of cold sections does not make problems.
> >> =A0So, well, it works perfect so fat. But I don't understand everythin=
g here.
> >> =A0Is this expected?
> >
> > So, I'm in doubt that dirty sections consist of entirely valid or free =
segments.
> >
> >> =A0The other two SD cards were tested differently. On one of them I ca=
lled
> >> =A0ioctl(F2FS_IOC_GARBAGE_COLLECT) for several hours. And indeed the n=
umber
> >> =A0of dirty sectoins dropped considerably. It works fine so far.
> >
> > It makes sense that valid segments in dirty sections would be migrated =
to
> > different free sections.
> >
> >> =A0On the other SD card I called ioctl(F2FS_IOC_DEFRAGMENT) for every
> >> =A0file in the archive. It works fine as well now. But the number of d=
irty sections
> >> =A0was still very high at the end of defragmentation. I don't understa=
nd this
> >> =A0as well.
> >
> > This is for defragementation to the given file, which would not move bl=
ocks in
> > order to decrease the number of dirty sections.
> > I think it's not necessary for this workload.
> =

> Yes, I'd prefer to not run manual GC or defragmentation. This was just a =
test.
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
