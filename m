From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: video archive on a microSD card
Date: Fri, 2 Sep 2016 11:50:15 -0700
Message-ID: <20160902185015.GB917@jaegeuk>
References: <39941471627359@web1m.yandex.ru> <35301472489424@web15m.yandex.ru>
	<20160829180020.GF94184@jaegeuk> <592891472633520@web8m.yandex.ru>
	<20160831234633.GA17031@jaegeuk> <118511472751607@web30h.yandex.ru>
	<20160901182509.GA20281@jaegeuk> <116081472758656@web21j.yandex.ru>
	<20160901201555.GC20281@jaegeuk> <225181472817910@web16m.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bftXl-0004Bz-7m
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 02 Sep 2016 18:50:25 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bftXj-0002tN-Ui
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 02 Sep 2016 18:50:25 +0000
Content-Disposition: inline
In-Reply-To: <225181472817910@web16m.yandex.ru>
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

On Fri, Sep 02, 2016 at 03:05:10PM +0300, Alexander Gordeev wrote:
> Hi Jaegeuk,
> =

> 01.09.2016, 23:16, "Jaegeuk Kim" <jaegeuk@kernel.org>:
> > On Thu, Sep 01, 2016 at 10:37:36PM +0300, Alexander Gordeev wrote:
> >> =A0Hi ,
> >>
> >> =A001.09.2016, 21:25, "Jaegeuk Kim" <jaegeuk@kernel.org>:
> >> =A0> Hello,
> >> =A0>
> >> =A0> On Thu, Sep 01, 2016 at 08:40:07PM +0300, Alexander Gordeev wrote:
> >> =A0> ...
> >> =A0>> =A0>> =A0[ 49.274678] ------------[ cut here ]------------
> >> =A0>> =A0>> =A0[ 49.280216] WARNING: at /home/alex/work/s2l/amb_S2l_SD=
K_2.5/SDK2.5/s2l_linux_sdk/ambarella/kernel/linux-3.10/fs/f2fs/segment.c:11=
05 new_curseg+0x268/0x394 [f2fs]()
> >> =A0>> =A0>
> >> =A0>> =A0> This means there is no free segment.
> >> =A0>> =A0> Could you print out the below information before this f2fs_=
bug_on?
> >> =A0>> =A0> - prefree_segments(sbi)
> >> =A0>> =A0> - free_segments(sbi)
> >> =A0>> =A0>
> >> =A0>> =A0>> =A0...
> >> =A0>> =A0>> =A0[ 49.518054] ---[ end trace 49dca462b4f988ff ]---
> >> =A0>> =A0>> =A0[ 49.522689] ------------[ cut here ]------------
> >> =A0>> =A0>> =A0[ 49.527375] WARNING: at /home/alex/work/s2l/amb_S2l_SD=
K_2.5/SDK2.5/s2l_linux_sdk/ambarella/kernel/linux-3.10/fs/f2fs/segment.c:11=
44 new_curseg+0x2f0/0x394 [f2fs]()
> >> =A0>> =A0>
> >> =A0>> =A0> This is caused by the above segno which was -1.
> >> =A0>> =A0>
> >> =A0>> =A0>> =A0...
> >> =A0>> =A0>> =A0[ 49.764853] ---[ end trace 49dca462b4f98900 ]---
> >> =A0>> =A0>> =A0[ 49.857344] ------ segno =3D 7540, next_blkoff =3D 0, =
next_segno =3D 4294967295 --------
> >> =A0>> =A0>> =A0[ 49.913664] ------ blkaddr =3D 3889152 --------
> >> =A0>> =A0>> =A0[ 49.918173] Unable to handle kernel NULL pointer deref=
erence at virtual address 00000000
> >> =A0>> =A0>
> >> =A0>> =A0> Also, we can see next_segno was -1, which incur no se entry=
 for this segment.
> >> =A0>> =A0> At this moment, I'd really like to see its /sys/kernel/debu=
g/f2fs/status whether
> >> =A0>> =A0> there is really not enough free segments.
> >> =A0>>
> >> =A0>> =A0I collected both /sys/kernel/debug/f2fs/status and numbers of=
 blocks.
> >> =A0>> =A0The oops happens only when I try to delete anything. Also it =
can be caused
> >> =A0>> =A0by GC, but I turned background GC off. So I mounted the fs, d=
umped the status
> >> =A0>> =A0and then tried to remove a file. Here is what I got:
> >> =A0>>
> >> =A0>> =A0=3D=3D=3D=3D=3D[ partition info(sda). #0, RW]=3D=3D=3D=3D=3D
> >> =A0>> =A0[SB: 1] [CP: 2] [SIT: 2] [NAT: 34] [SSA: 16] [MAIN: 7540(Over=
Prov:424 Resv:50)]
> >> =A0>
> >> =A0> Could you check your mkfs.f2fs version?
> >> =A0> I want to check ovp and resv numbers.
> >>
> >> =A0I currently used mkfs.f2fs from my board's SDK. It prints this:
> >> =A0F2FS-tools: mkfs.f2fs Ver: 1.4.1 (2015-03-04)
> >>
> >> =A0Should I upgrade it?
> >> =A0I think the problem will go away if I recreate the FS. At the moment
> >> =A0it reproduces every time. I wonder if we need it again.
> >
> > Yes, please upgrade to the latest version to make sure.
> > And, it needs to format it again.
> > Seems there is no further information that we can use from the old part=
ition.
> =

> Ok, thanks! I upgraded f2fs-tools and recreated the FS. Works fine so far!
> Still IMHO this might be a problem, if someone with a specially crafted F=
S on a USB
> stick can cause a kernel oops on any modern Linux system. Isn't it?

Yes, it is a problem. :)
But for now, we rely on any reported case that we can get.
If we can confirm this is a root-cause, hopufully I need to consider someth=
ing
in kernel-- online fixing or messages whatever.

Thanks,

> =

> --=A0
>  Alexander

---------------------------------------------------------------------------=
---
