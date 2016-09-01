From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: video archive on a microSD card
Date: Thu, 1 Sep 2016 13:15:55 -0700
Message-ID: <20160901201555.GC20281@jaegeuk>
References: <1184081471518295@web5m.yandex.ru> <20160819024105.GA64207@jaegeuk>
	<39941471627359@web1m.yandex.ru> <35301472489424@web15m.yandex.ru>
	<20160829180020.GF94184@jaegeuk> <592891472633520@web8m.yandex.ru>
	<20160831234633.GA17031@jaegeuk> <118511472751607@web30h.yandex.ru>
	<20160901182509.GA20281@jaegeuk> <116081472758656@web21j.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bfYPD-0002Uy-Dm
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 01 Sep 2016 20:16:11 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bfYPC-0005Et-3p
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 01 Sep 2016 20:16:11 +0000
Content-Disposition: inline
In-Reply-To: <116081472758656@web21j.yandex.ru>
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

On Thu, Sep 01, 2016 at 10:37:36PM +0300, Alexander Gordeev wrote:
> Hi ,
> =

> 01.09.2016, 21:25, "Jaegeuk Kim" <jaegeuk@kernel.org>:
> > Hello,
> >
> > On Thu, Sep 01, 2016 at 08:40:07PM +0300, Alexander Gordeev wrote:
> > ...
> >> =A0>> =A0[ 49.274678] ------------[ cut here ]------------
> >> =A0>> =A0[ 49.280216] WARNING: at /home/alex/work/s2l/amb_S2l_SDK_2.5/=
SDK2.5/s2l_linux_sdk/ambarella/kernel/linux-3.10/fs/f2fs/segment.c:1105 new=
_curseg+0x268/0x394 [f2fs]()
> >> =A0>
> >> =A0> This means there is no free segment.
> >> =A0> Could you print out the below information before this f2fs_bug_on?
> >> =A0> - prefree_segments(sbi)
> >> =A0> - free_segments(sbi)
> >> =A0>
> >> =A0>> =A0...
> >> =A0>> =A0[ 49.518054] ---[ end trace 49dca462b4f988ff ]---
> >> =A0>> =A0[ 49.522689] ------------[ cut here ]------------
> >> =A0>> =A0[ 49.527375] WARNING: at /home/alex/work/s2l/amb_S2l_SDK_2.5/=
SDK2.5/s2l_linux_sdk/ambarella/kernel/linux-3.10/fs/f2fs/segment.c:1144 new=
_curseg+0x2f0/0x394 [f2fs]()
> >> =A0>
> >> =A0> This is caused by the above segno which was -1.
> >> =A0>
> >> =A0>> =A0...
> >> =A0>> =A0[ 49.764853] ---[ end trace 49dca462b4f98900 ]---
> >> =A0>> =A0[ 49.857344] ------ segno =3D 7540, next_blkoff =3D 0, next_s=
egno =3D 4294967295 --------
> >> =A0>> =A0[ 49.913664] ------ blkaddr =3D 3889152 --------
> >> =A0>> =A0[ 49.918173] Unable to handle kernel NULL pointer dereference=
 at virtual address 00000000
> >> =A0>
> >> =A0> Also, we can see next_segno was -1, which incur no se entry for t=
his segment.
> >> =A0> At this moment, I'd really like to see its /sys/kernel/debug/f2fs=
/status whether
> >> =A0> there is really not enough free segments.
> >>
> >> =A0I collected both /sys/kernel/debug/f2fs/status and numbers of block=
s.
> >> =A0The oops happens only when I try to delete anything. Also it can be=
 caused
> >> =A0by GC, but I turned background GC off. So I mounted the fs, dumped =
the status
> >> =A0and then tried to remove a file. Here is what I got:
> >>
> >> =A0=3D=3D=3D=3D=3D[ partition info(sda). #0, RW]=3D=3D=3D=3D=3D
> >> =A0[SB: 1] [CP: 2] [SIT: 2] [NAT: 34] [SSA: 16] [MAIN: 7540(OverProv:4=
24 Resv:50)]
> >
> > Could you check your mkfs.f2fs version?
> > I want to check ovp and resv numbers.
> =

> I currently used mkfs.f2fs from my board's SDK. It prints this:
> F2FS-tools: mkfs.f2fs Ver: 1.4.1 (2015-03-04)
> =

> Should I upgrade it?
> I think the problem will go away if I recreate the FS. At the moment
> it reproduces every time. I wonder if we need it again.

Yes, please upgrade to the latest version to make sure.
And, it needs to format it again.
Seems there is no further information that we can use from the old partitio=
n.

Thanks,

> =

> > You can get the latest one from:
> > http://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs-tools.git
> >
> >> =A0Utilization: 94% (3443739 valid blocks)
> >> =A0=A0=A0- Node: 4458 (Inode: 1115, Other: 3343)
> >> =A0=A0=A0- Data: 3439281
> >> =A0=A0=A0- Inline_xattr Inode: 0
> >> =A0=A0=A0- Inline_data Inode: 0
> >> =A0=A0=A0- Inline_dentry Inode: 0
> >> =A0=A0=A0- Orphan Inode: 0
> >>
> >> =A0Main area: 7540 segs, 3770 secs 3770 zones
> >> =A0=A0=A0- COLD data: 6192, 3096, 3096
> >> =A0=A0=A0- WARM data: 6186, 3093, 3093
> >> =A0=A0=A0- HOT data: 6198, 3099, 3099
> >> =A0=A0=A0- Dir dnode: 4836, 2418, 2418
> >> =A0=A0=A0- File dnode: 5003, 2501, 2501
> >> =A0=A0=A0- Indir nodes: 7533, 3766, 3766
> >>
> >> =A0=A0=A0- Valid: 6728
> >> =A0=A0=A0- Dirty: 5
> >> =A0=A0=A0- Prefree: 0
> >> =A0=A0=A0- Free: 807 (0)
> >
> > Here, we have 807 free segments, but no section that we can use right n=
ow.
> =

> Ah, I see now.
> =

> >> =A0CP calls: 0 (BG: 0)
> >> =A0GC calls: 0 (BG: 0)
> >> =A0=A0=A0- data segments : 0 (0)
> >> =A0=A0=A0- node segments : 0 (0)
> >> =A0Try to move 0 blocks (BG: 0)
> >> =A0=A0=A0- data blocks : 0 (0)
> >> =A0=A0=A0- node blocks : 0 (0)
> >>
> >> =A0Extent Cache:
> >> =A0=A0=A0- Hit Count: L1-1:0 L1-2:0 L2:0
> >> =A0=A0=A0- Hit Ratio: 0% (0 / 0)
> >> =A0=A0=A0- Inner Struct Count: tree: 0(0), node: 0
> >>
> >> =A0Balancing F2FS Async:
> >> =A0=A0=A0- inmem: 0, wb_bios: 0
> >> =A0=A0=A0- nodes: 0 in 1
> >> =A0=A0=A0- dents: 0 in dirs: 0 ( 0)
> >> =A0=A0=A0- datas: 0 in files: 0
> >> =A0=A0=A0- meta: 0 in 155
> >> =A0=A0=A0- NATs: 0/ 1
> >> =A0=A0=A0- SITs: 0/ 7540
> >> =A0=A0=A0- free_nids: 3496
> >>
> >> =A0Distribution of User Blocks: [ valid | invalid | free ]
> >> =A0=A0=A0[-----------------------------------------------|-|--]
> >>
> >> =A0IPU: 0 blocks
> >> =A0SSR: 0 blocks in 0 segments
> >> =A0LFS: 0 blocks in 0 segments
> >>
> >> =A0BDF: 78, avg. vblocks: 510
> >>
> >> =A0Memory: 2325 KB
> >> =A0=A0=A0- static: 1647 KB
> >> =A0=A0=A0- cached: 54 KB
> >> =A0=A0=A0- paged : 624 KB
> >>
> >> =A0[ 107.562070] ------ blkaddr =3D 2590606, se->cur_valid_map =3D 847=
7f040 --------
> >> =A0[ 107.570415] ------ blkaddr =3D 2590607, se->cur_valid_map =3D 847=
7f040 --------
> >
> > ...
> >> =A0[ 108.334883] ------ blkaddr =3D 2590713, se->cur_valid_map =3D 847=
7f040 --------
> >> =A0[ 108.341966] ------ blkaddr =3D 2590714, se->cur_valid_map =3D 847=
7f040 --------
> >> =A0[ 108.349047] ------ blkaddr =3D 2590715, se->cur_valid_map =3D 847=
7f040 --------
> >> =A0[ 108.356004] ------ blkaddr =3D 2590716, se->cur_valid_map =3D 847=
7f040 --------
> >> =A0[ 108.363130] ------ blkaddr =3D 2590717, se->cur_valid_map =3D 847=
7f040 --------
> >> =A0[ 108.370210] ------ blkaddr =3D 2590718, se->cur_valid_map =3D 847=
7f040 --------
> >> =A0[ 108.377244] ------ prefree_segments =3D 0, free_segments =3D 807 =
------
> >> =A0[ 108.383526] ------------[ cut here ]------------
> >> =A0[ 108.388231] WARNING: at /home/alex/work/s2l/s2l_linux_sdk/ambarel=
la/kernel/linux-3.10/fs/f2fs/segment.c:1105 new_curseg+0x280/0x3b8 [f2fs]()
> >> =A0...
> >> =A0[ 108.628965] ---[ end trace c59ce5906bb6d95e ]---
> >> =A0[ 108.633563] ------------[ cut here ]------------
> >> =A0[ 108.638240] WARNING: at /home/alex/work/s2l/s2l_linux_sdk/ambarel=
la/kernel/linux-3.10/fs/f2fs/segment.c:1144 new_curseg+0x308/0x3b8 [f2fs]()
> >> =A0...
> >> =A0[ 108.878788] ---[ end trace c59ce5906bb6d95f ]---
> >> =A0[ 108.885201] ------ segno =3D 7540, next_blkoff =3D 0, next_segno =
=3D 4294967295 --------
> >
> > So, new_curseg failed to find a free section, and gave 7540 which is th=
e end
> > of main area. And then, it tried to allocate that LBA and got panic due=
 to wrong
> > bitmap position when setting its SIT bitmap.
> >
> > For now, the root cause is due to zero free section, and I'd like to ch=
eck
> > whether ovp and reserved space were correctly assigned or not.
> > Or, there was a missing flow which consumed reserved space entirely wit=
hout
> > any cleaning.
> =

> I think, this is the SD card, I tried to defragment some time ago.
> Probably I shouldn't ever do it.
> Still IMHO the code should handle even such cases. For example, someone
> can craft a FS, and it might make bad things...
> =

> --=A0
>  Alexander

---------------------------------------------------------------------------=
---
