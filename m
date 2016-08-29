From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: video archive on a microSD card
Date: Mon, 29 Aug 2016 11:23:59 -0700
Message-ID: <20160829182359.GG94184@jaegeuk>
References: <158901471427237@web4g.yandex.ru>
	<bd0fc9a6-03d3-e32c-f6c7-f64d4ba8506e@kernel.org>
	<1184081471518295@web5m.yandex.ru> <20160819024105.GA64207@jaegeuk>
	<1258721471607772@web12h.yandex.ru>
	<324581471899132@web4j.yandex.ru> <20160823211222.GD73835@jaegeuk>
	<139021472156043@web27j.yandex.ru> <20160827012032.GG88444@jaegeuk>
	<549571472473386@web20g.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1beRE9-0006RW-Af
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 29 Aug 2016 18:24:09 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1beRE8-000860-7U
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 29 Aug 2016 18:24:09 +0000
Content-Disposition: inline
In-Reply-To: <549571472473386@web20g.yandex.ru>
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

On Mon, Aug 29, 2016 at 03:23:06PM +0300, Alexander Gordeev wrote:
> Hi Jaegeuk,
> =

> 27.08.2016, 04:20, "Jaegeuk Kim" <jaegeuk@kernel.org>:
> > On Thu, Aug 25, 2016 at 11:14:03PM +0300, Alexander Gordeev wrote:
> >> =A0Hi Jaegeuk,
> >>
> >> =A0Thanks for all the help!
> >>...
> >> =A0> This is the number of dirty segments, so it needs to consider sec=
tion and
> >> =A0> segment at the same time; a dirty section can consist of valid an=
d free
> >> =A0> segments.
> >> =A0> How abouting testing 2MB-sized section which is the default optio=
n?
> >>
> >> =A0I tried what you said. Still the majority of segments are dirty for=
 some reason:
> >>
> >> =A0=3D=3D=3D=3D=3D[ partition info(sda). #0, RW]=3D=3D=3D=3D=3D
> >> =A0[SB: 1] [CP: 2] [SIT: 6] [NAT: 114] [SSA: 116] [MAIN: 59149(OverPro=
v:3003 Resv:48)]
> >>
> >> =A0Utilization: 10% (3013093 valid blocks)
> >> =A0=A0=A0- Node: 3528 (Inode: 548, Other: 2980)
> >> =A0=A0=A0- Data: 3009565
> >> =A0=A0=A0- Inline_xattr Inode: 0
> >> =A0=A0=A0- Inline_data Inode: 0
> >> =A0=A0=A0- Inline_dentry Inode: 0
> >> =A0=A0=A0- Orphan Inode: 0
> >>
> >> =A0Main area: 59149 segs, 59149 secs 59149 zones
> >> =A0=A0=A0- COLD data: 7183, 7183, 7183
> >> =A0=A0=A0- WARM data: 6654, 6654, 6654
> >> =A0=A0=A0- HOT data: 59134, 59134, 59134
> >> =A0=A0=A0- Dir dnode: 59127, 59127, 59127
> >> =A0=A0=A0- File dnode: 59125, 59125, 59125
> >> =A0=A0=A0- Indir nodes: 59129, 59129, 59129
> >>
> >> =A0=A0=A0- Valid: 300
> >> =A0=A0=A0- Dirty: 6438
> >> =A0=A0=A0- Prefree: 0
> >> =A0=A0=A0- Free: 52411 (52411)
> >>
> >> =A0CP calls: 1023 (BG: 473)
> >> =A0GC calls: 470 (BG: 470)
> >> =A0=A0=A0- data segments : 466 (466)
> >> =A0=A0=A0- node segments : 4 (4)
> >> =A0Try to move 152221 blocks (BG: 152221)
> >> =A0=A0=A0- data blocks : 151417 (151417)
> >> =A0=A0=A0- node blocks : 804 (804)
> >>
> >> =A0Extent Cache:
> >> =A0=A0=A0- Hit Count: L1-1:6262 L1-2:0 L2:0
> >> =A0=A0=A0- Hit Ratio: 2% (6262 / 273606)
> >> =A0=A0=A0- Inner Struct Count: tree: 292(0), node: 8
> >>
> >> =A0Balancing F2FS Async:
> >> =A0=A0=A0- inmem: 0, wb_bios: 0
> >> =A0=A0=A0- nodes: 0 in 0
> >> =A0=A0=A0- dents: 0 in dirs: 0 ( 0)
> >> =A0=A0=A0- datas: 0 in files: 0
> >> =A0=A0=A0- meta: 0 in 0
> >> =A0=A0=A0- NATs: 0/ 43
> >> =A0=A0=A0- SITs: 0/ 59149
> >> =A0=A0=A0- free_nids: 3414
> >>
> >> =A0Distribution of User Blocks: [ valid | invalid | free ]
> >> =A0=A0=A0[-----|--|-------------------------------------------]
> >>
> >> =A0IPU: 0 blocks
> >> =A0SSR: 0 blocks in 0 segments
> >> =A0LFS: 3691542 blocks in 7208 segments
> >>
> >> =A0BDF: 95, avg. vblocks: 444
> >>
> >> =A0Memory: 12662 KB
> >> =A0=A0=A0- static: 12597 KB
> >> =A0=A0=A0- cached: 64 KB
> >> =A0=A0=A0- paged : 0 KB
> >>
> >> =A0But the archive is working perfectly as before.
> >
> > Okay, so we need to gather more information about IO traces. :)
> >
> > Could you get them by:
> >
> > echo 1 > /sys/kernel/debug/tracing/events/f2fs/f2fs_submit_write_bio/en=
able
> > echo 1 > /sys/kernel/debug/tracing/events/f2fs/f2fs_submit_page_mbio/en=
able
> > echo 1 > /sys/kernel/debug/tracing/tracing_on
> > cat /sys/kernel/debug/tracing/trace_pipe
> >
> > You can get a script in f2fs-tools.git/scripts/tracepoint.sh
> =

> I collected the trace. It is attached. Thanks!

Thanks.

What I've found from your trace are:
- there are two files (ino=3D17690, ino=3D17691) which shared the data log.
- ino=3D17690 writes data sequentiallly, and ino=3D17691 writes small data =
randomly.
- ino=3D17690 writes misaligned 4KB blocks at every around 296KB which prod=
uces
 dirty segments.

Could you check all the writes and truncation in your app are aligned to 4K=
B?
And, if ino=3D17691 is sqlite, it needs to check whether it is reaaly using=
 other
data log.

Thanks,

> =

> --=A0
>  Alexander



---------------------------------------------------------------------------=
---
