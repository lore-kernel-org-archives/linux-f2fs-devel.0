From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: video archive on a microSD card
Date: Thu, 1 Sep 2016 13:07:18 -0700
Message-ID: <20160901200718.GB20281@jaegeuk>
References: <1184081471518295@web5m.yandex.ru> <20160819024105.GA64207@jaegeuk>
	<1258721471607772@web12h.yandex.ru>
	<324581471899132@web4j.yandex.ru> <20160823211222.GD73835@jaegeuk>
	<139021472156043@web27j.yandex.ru> <20160827012032.GG88444@jaegeuk>
	<549571472473386@web20g.yandex.ru> <20160829182359.GG94184@jaegeuk>
	<9581472749471@web24h.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bfYGm-0002Gw-Tb
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 01 Sep 2016 20:07:28 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bfYGl-0002rD-HY
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 01 Sep 2016 20:07:28 +0000
Content-Disposition: inline
In-Reply-To: <9581472749471@web24h.yandex.ru>
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

On Thu, Sep 01, 2016 at 08:04:31PM +0300, Alexander Gordeev wrote:
> Hi Jaegeuk,
> =

> 29.08.2016, 21:24, "Jaegeuk Kim" <jaegeuk@kernel.org>:
> > On Mon, Aug 29, 2016 at 03:23:06PM +0300, Alexander Gordeev wrote:
> >> =A0Hi Jaegeuk,
> >>
> >> =A027.08.2016, 04:20, "Jaegeuk Kim" <jaegeuk@kernel.org>:
> >> =A0> On Thu, Aug 25, 2016 at 11:14:03PM +0300, Alexander Gordeev wrote:
> >> =A0>> =A0Hi Jaegeuk,
> >> =A0>>
> >> =A0>> =A0Thanks for all the help!
> >> =A0>>...
> >> =A0>> =A0> This is the number of dirty segments, so it needs to consid=
er section and
> >> =A0>> =A0> segment at the same time; a dirty section can consist of va=
lid and free
> >> =A0>> =A0> segments.
> >> =A0>> =A0> How abouting testing 2MB-sized section which is the default=
 option?
> >> =A0>>
> >> =A0>> =A0I tried what you said. Still the majority of segments are dir=
ty for some reason:
> >> =A0>>
> >> =A0>> =A0=3D=3D=3D=3D=3D[ partition info(sda). #0, RW]=3D=3D=3D=3D=3D
> >> =A0>> =A0[SB: 1] [CP: 2] [SIT: 6] [NAT: 114] [SSA: 116] [MAIN: 59149(O=
verProv:3003 Resv:48)]
> >> =A0>>
> >> =A0>> =A0Utilization: 10% (3013093 valid blocks)
> >> =A0>> =A0=A0=A0- Node: 3528 (Inode: 548, Other: 2980)
> >> =A0>> =A0=A0=A0- Data: 3009565
> >> =A0>> =A0=A0=A0- Inline_xattr Inode: 0
> >> =A0>> =A0=A0=A0- Inline_data Inode: 0
> >> =A0>> =A0=A0=A0- Inline_dentry Inode: 0
> >> =A0>> =A0=A0=A0- Orphan Inode: 0
> >> =A0>>
> >> =A0>> =A0Main area: 59149 segs, 59149 secs 59149 zones
> >> =A0>> =A0=A0=A0- COLD data: 7183, 7183, 7183
> >> =A0>> =A0=A0=A0- WARM data: 6654, 6654, 6654
> >> =A0>> =A0=A0=A0- HOT data: 59134, 59134, 59134
> >> =A0>> =A0=A0=A0- Dir dnode: 59127, 59127, 59127
> >> =A0>> =A0=A0=A0- File dnode: 59125, 59125, 59125
> >> =A0>> =A0=A0=A0- Indir nodes: 59129, 59129, 59129
> >> =A0>>
> >> =A0>> =A0=A0=A0- Valid: 300
> >> =A0>> =A0=A0=A0- Dirty: 6438
> >> =A0>> =A0=A0=A0- Prefree: 0
> >> =A0>> =A0=A0=A0- Free: 52411 (52411)
> >> =A0>>
> >> =A0>> =A0CP calls: 1023 (BG: 473)
> >> =A0>> =A0GC calls: 470 (BG: 470)
> >> =A0>> =A0=A0=A0- data segments : 466 (466)
> >> =A0>> =A0=A0=A0- node segments : 4 (4)
> >> =A0>> =A0Try to move 152221 blocks (BG: 152221)
> >> =A0>> =A0=A0=A0- data blocks : 151417 (151417)
> >> =A0>> =A0=A0=A0- node blocks : 804 (804)
> >> =A0>>
> >> =A0>> =A0Extent Cache:
> >> =A0>> =A0=A0=A0- Hit Count: L1-1:6262 L1-2:0 L2:0
> >> =A0>> =A0=A0=A0- Hit Ratio: 2% (6262 / 273606)
> >> =A0>> =A0=A0=A0- Inner Struct Count: tree: 292(0), node: 8
> >> =A0>>
> >> =A0>> =A0Balancing F2FS Async:
> >> =A0>> =A0=A0=A0- inmem: 0, wb_bios: 0
> >> =A0>> =A0=A0=A0- nodes: 0 in 0
> >> =A0>> =A0=A0=A0- dents: 0 in dirs: 0 ( 0)
> >> =A0>> =A0=A0=A0- datas: 0 in files: 0
> >> =A0>> =A0=A0=A0- meta: 0 in 0
> >> =A0>> =A0=A0=A0- NATs: 0/ 43
> >> =A0>> =A0=A0=A0- SITs: 0/ 59149
> >> =A0>> =A0=A0=A0- free_nids: 3414
> >> =A0>>
> >> =A0>> =A0Distribution of User Blocks: [ valid | invalid | free ]
> >> =A0>> =A0=A0=A0[-----|--|-------------------------------------------]
> >> =A0>>
> >> =A0>> =A0IPU: 0 blocks
> >> =A0>> =A0SSR: 0 blocks in 0 segments
> >> =A0>> =A0LFS: 3691542 blocks in 7208 segments
> >> =A0>>
> >> =A0>> =A0BDF: 95, avg. vblocks: 444
> >> =A0>>
> >> =A0>> =A0Memory: 12662 KB
> >> =A0>> =A0=A0=A0- static: 12597 KB
> >> =A0>> =A0=A0=A0- cached: 64 KB
> >> =A0>> =A0=A0=A0- paged : 0 KB
> >> =A0>>
> >> =A0>> =A0But the archive is working perfectly as before.
> >> =A0>
> >> =A0> Okay, so we need to gather more information about IO traces. :)
> >> =A0>
> >> =A0> Could you get them by:
> >> =A0>
> >> =A0> echo 1 > /sys/kernel/debug/tracing/events/f2fs/f2fs_submit_write_=
bio/enable
> >> =A0> echo 1 > /sys/kernel/debug/tracing/events/f2fs/f2fs_submit_page_m=
bio/enable
> >> =A0> echo 1 > /sys/kernel/debug/tracing/tracing_on
> >> =A0> cat /sys/kernel/debug/tracing/trace_pipe
> >> =A0>
> >> =A0> You can get a script in f2fs-tools.git/scripts/tracepoint.sh
> >>
> >> =A0I collected the trace. It is attached. Thanks!
> >
> > Thanks.
> >
> > What I've found from your trace are:
> > - there are two files (ino=3D17690, ino=3D17691) which shared the data =
log.
> > - ino=3D17690 writes data sequentiallly, and ino=3D17691 writes small d=
ata randomly.
> > - ino=3D17690 writes misaligned 4KB blocks at every around 296KB which =
produces
> > =A0dirty segments.
> >
> > Could you check all the writes and truncation in your app are aligned t=
o 4KB?
> > And, if ino=3D17691 is sqlite, it needs to check whether it is reaaly u=
sing other
> > data log.
> =

> I collected more logs from both kernel tracing and strace and tried to ge=
t more
> understanding of this. I think, I get what's wrong now.
> =

> ino=3D17690 is a video file. ino=3D17691 is not SQLite, it is an index fi=
le. It is written
> 24 bytes per frame. Here is a small piece of strace log for writing a sin=
gle frame:
> =

> write(19, "...", 4) =3D 4
> write(19, "...", 4) =3D 4
> write(19, "...", 2432) =3D 2432
> write(20, "...", 24) =3D 24
> =

> First three writes are writing to a video file (4 byte stream id, then 4 =
byte length
> and then the actual frame), then the fourth one writes to and index file.=
 Yes, I know,
> this looks ugly. :)
> All the writes are not aligned to 4096, but there are no truncations, only
> appending.
> =

> Then, I think, I see f2fs worker thread wakes up about every two seconds =
to
> write dirty pages. Unfortunately it seems to write everything collected s=
o far, even
> the most recent pages, which are not fully filled yet. I'd say that can n=
ot be
> expected, that every app will write data aligned to 4096 bytes. So this m=
eans
> more overhead and overwrites even in a more general case. Is it different=
 in
> mode=3Dadaptive?

No, the flushing time is controlled by vm, and you can tune that through pr=
oc.
And, IMO, even if those are append-only, it'd be worth to split index and m=
edia
files into different logs; it seems using the cold log for media file only =
would
be recommendable.

> The 296KB size, probably, comes from my bitrate, which is about 142KB/s, =
times
> 2 seconds. It is roughly the right size.
> My video FPS is about 30, so the size of data, written to an index, is ab=
out 1440
> in two seconds. This is why it looks like randow writes, I think.
> =

> Also I see from my new traces, that f2fs_submit_write_bio for other inodes
> are writing to completely different sectors. Looks like the "cold" data f=
eature
> is working good.
> =

> To conclude:
> 1. I think I can leave everything as is because (1) there is a small numb=
er of
> rewrites and (2) I start rotating the archive at 95% utilization so given=
 the tiny
> amount of data in index and sqlite files, this should be ok, I hope.

If both of index and media files are deleted before suffering from cleaning,
IMO, it'd be fine. You can check the cleaning information in status file.

> 2. But I'd better write both video and index files at 4096 boundary.
> 3. Or this should be fixed in f2fs. I think, there should be a configurab=
le amount
> of time to wait for dirty page to expire. It should be written only after=
 expiration.
> Unless a user calls fsync() of course. Is there such a tunable?
> =

> Does this make sense?

Yeah, I think you can tune flushing timing through proc entries.
(e.g., /proc/sys/vm/dirty_writeback_centisecs)

Thanks,

> =

> The new traces are attached for reference. They are filtered somewhat
> for easier side-by-side viewing.
> =

> Thanks!
> =

> --=A0
>  Alexander



---------------------------------------------------------------------------=
---
