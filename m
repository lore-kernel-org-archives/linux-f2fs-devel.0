From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: video archive on a microSD card
Date: Thu, 1 Sep 2016 11:25:09 -0700
Message-ID: <20160901182509.GA20281@jaegeuk>
References: <158901471427237@web4g.yandex.ru>
	<bd0fc9a6-03d3-e32c-f6c7-f64d4ba8506e@kernel.org>
	<1184081471518295@web5m.yandex.ru> <20160819024105.GA64207@jaegeuk>
	<39941471627359@web1m.yandex.ru> <35301472489424@web15m.yandex.ru>
	<20160829180020.GF94184@jaegeuk> <592891472633520@web8m.yandex.ru>
	<20160831234633.GA17031@jaegeuk> <118511472751607@web30h.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bfWfv-0005Us-PN
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 01 Sep 2016 18:25:19 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bfWft-0008GP-W6
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 01 Sep 2016 18:25:19 +0000
Content-Disposition: inline
In-Reply-To: <118511472751607@web30h.yandex.ru>
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

On Thu, Sep 01, 2016 at 08:40:07PM +0300, Alexander Gordeev wrote:
...
> >> =A0[ 49.274678] ------------[ cut here ]------------
> >> =A0[ 49.280216] WARNING: at /home/alex/work/s2l/amb_S2l_SDK_2.5/SDK2.5=
/s2l_linux_sdk/ambarella/kernel/linux-3.10/fs/f2fs/segment.c:1105 new_curse=
g+0x268/0x394 [f2fs]()
> >
> > This means there is no free segment.
> > Could you print out the below information before this f2fs_bug_on?
> > - prefree_segments(sbi)
> > - free_segments(sbi)
> >
> >> =A0...
> >> =A0[ 49.518054] ---[ end trace 49dca462b4f988ff ]---
> >> =A0[ 49.522689] ------------[ cut here ]------------
> >> =A0[ 49.527375] WARNING: at /home/alex/work/s2l/amb_S2l_SDK_2.5/SDK2.5=
/s2l_linux_sdk/ambarella/kernel/linux-3.10/fs/f2fs/segment.c:1144 new_curse=
g+0x2f0/0x394 [f2fs]()
> >
> > This is caused by the above segno which was -1.
> >
> >> =A0...
> >> =A0[ 49.764853] ---[ end trace 49dca462b4f98900 ]---
> >> =A0[ 49.857344] ------ segno =3D 7540, next_blkoff =3D 0, next_segno =
=3D 4294967295 --------
> >> =A0[ 49.913664] ------ blkaddr =3D 3889152 --------
> >> =A0[ 49.918173] Unable to handle kernel NULL pointer dereference at vi=
rtual address 00000000
> >
> > Also, we can see next_segno was -1, which incur no se entry for this se=
gment.
> > At this moment, I'd really like to see its /sys/kernel/debug/f2fs/statu=
s whether
> > there is really not enough free segments.
> =

> I collected both /sys/kernel/debug/f2fs/status and numbers of blocks.
> The oops happens only when I try to delete anything. Also it can be caused
> by GC, but I turned background GC off. So I mounted the fs, dumped the st=
atus
> and then tried to remove a file. Here is what I got:
> =

> =3D=3D=3D=3D=3D[ partition info(sda). #0, RW]=3D=3D=3D=3D=3D
> [SB: 1] [CP: 2] [SIT: 2] [NAT: 34] [SSA: 16] [MAIN: 7540(OverProv:424 Res=
v:50)]

Could you check your mkfs.f2fs version?
I want to check ovp and resv numbers.

You can get the latest one from:
http://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs-tools.git

> Utilization: 94% (3443739 valid blocks)
>   - Node: 4458 (Inode: 1115, Other: 3343)
>   - Data: 3439281
>   - Inline_xattr Inode: 0
>   - Inline_data Inode: 0
>   - Inline_dentry Inode: 0
>   - Orphan Inode: 0
> =

> Main area: 7540 segs, 3770 secs 3770 zones
>   - COLD  data: 6192, 3096, 3096
>   - WARM  data: 6186, 3093, 3093
>   - HOT   data: 6198, 3099, 3099
>   - Dir   dnode: 4836, 2418, 2418
>   - File   dnode: 5003, 2501, 2501
>   - Indir nodes: 7533, 3766, 3766
> =

>   - Valid: 6728
>   - Dirty: 5
>   - Prefree: 0
>   - Free: 807 (0)

Here, we have 807 free segments, but no section that we can use right now.

> CP calls: 0 (BG: 0)
> GC calls: 0 (BG: 0)
>   - data segments : 0 (0)
>   - node segments : 0 (0)
> Try to move 0 blocks (BG: 0)
>   - data blocks : 0 (0)
>   - node blocks : 0 (0)
> =

> Extent Cache:
>   - Hit Count: L1-1:0 L1-2:0 L2:0
>   - Hit Ratio: 0% (0 / 0)
>   - Inner Struct Count: tree: 0(0), node: 0
> =

> Balancing F2FS Async:
>   - inmem:    0, wb_bios:    0
>   - nodes:    0 in    1
>   - dents:    0 in dirs:   0 (   0)
>   - datas:    0 in files:   0
>   - meta:    0 in  155
>   - NATs:         0/        1
>   - SITs:         0/     7540
>   - free_nids:      3496
> =

> Distribution of User Blocks: [ valid | invalid | free ]
>   [-----------------------------------------------|-|--]
> =

> IPU: 0 blocks
> SSR: 0 blocks in 0 segments
> LFS: 0 blocks in 0 segments
> =

> BDF: 78, avg. vblocks: 510
> =

> Memory: 2325 KB
>   - static: 1647 KB
>   - cached: 54 KB
>   - paged : 624 KB
> =

> [  107.562070] ------ blkaddr =3D 2590606, se->cur_valid_map =3D 8477f040=
 --------
> [  107.570415] ------ blkaddr =3D 2590607, se->cur_valid_map =3D 8477f040=
 --------
...
> [  108.334883] ------ blkaddr =3D 2590713, se->cur_valid_map =3D 8477f040=
 --------
> [  108.341966] ------ blkaddr =3D 2590714, se->cur_valid_map =3D 8477f040=
 --------
> [  108.349047] ------ blkaddr =3D 2590715, se->cur_valid_map =3D 8477f040=
 --------
> [  108.356004] ------ blkaddr =3D 2590716, se->cur_valid_map =3D 8477f040=
 --------
> [  108.363130] ------ blkaddr =3D 2590717, se->cur_valid_map =3D 8477f040=
 --------
> [  108.370210] ------ blkaddr =3D 2590718, se->cur_valid_map =3D 8477f040=
 --------
> [  108.377244] ------ prefree_segments =3D 0, free_segments =3D 807 ------
> [  108.383526] ------------[ cut here ]------------
> [  108.388231] WARNING: at /home/alex/work/s2l/s2l_linux_sdk/ambarella/ke=
rnel/linux-3.10/fs/f2fs/segment.c:1105 new_curseg+0x280/0x3b8 [f2fs]()
> ...
> [  108.628965] ---[ end trace c59ce5906bb6d95e ]---
> [  108.633563] ------------[ cut here ]------------
> [  108.638240] WARNING: at /home/alex/work/s2l/s2l_linux_sdk/ambarella/ke=
rnel/linux-3.10/fs/f2fs/segment.c:1144 new_curseg+0x308/0x3b8 [f2fs]()
> ...
> [  108.878788] ---[ end trace c59ce5906bb6d95f ]---
> [  108.885201] ------ segno =3D 7540, next_blkoff =3D 0, next_segno =3D 4=
294967295 --------

So, new_curseg failed to find a free section, and gave 7540 which is the end
of main area. And then, it tried to allocate that LBA and got panic due to =
wrong
bitmap position when setting its SIT bitmap.

For now, the root cause is due to zero free section, and I'd like to check
whether ovp and reserved space were correctly assigned or not.
Or, there was a missing flow which consumed reserved space entirely without
any cleaning.

Thanks,

> [  108.892808] ------ blkaddr =3D 2590719, se->cur_valid_map =3D 8477f040=
 --------
> [  108.899825] ------ blkaddr =3D 3889152, se->cur_valid_map =3D   (null)=
 --------
> [  108.906800] Unable to handle kernel NULL pointer dereference at virtua=
l address 00000000
> ...
> [  109.429454] ---[ end trace c59ce5906bb6d960 ]---
> =

> =

> Thanks!
> =

> --=A0
>  Alexander

---------------------------------------------------------------------------=
---
