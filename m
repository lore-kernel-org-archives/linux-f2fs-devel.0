From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: video archive on a microSD card
Date: Wed, 31 Aug 2016 16:46:33 -0700
Message-ID: <20160831234633.GA17031@jaegeuk>
References: <eac97eb4-6b4a-a987-48e9-72680238e50a@huawei.com>
	<7021471263772@web16m.yandex.ru> <158901471427237@web4g.yandex.ru>
	<bd0fc9a6-03d3-e32c-f6c7-f64d4ba8506e@kernel.org>
	<1184081471518295@web5m.yandex.ru> <20160819024105.GA64207@jaegeuk>
	<39941471627359@web1m.yandex.ru> <35301472489424@web15m.yandex.ru>
	<20160829180020.GF94184@jaegeuk> <592891472633520@web8m.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bfFDP-0001xB-1Q
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 31 Aug 2016 23:46:43 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bfFDN-0001Ai-SF
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 31 Aug 2016 23:46:43 +0000
Content-Disposition: inline
In-Reply-To: <592891472633520@web8m.yandex.ru>
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

On Wed, Aug 31, 2016 at 11:52:00AM +0300, Alexander Gordeev wrote:
> Hi Jaegeuk,
> =

> 29.08.2016, 21:00, "Jaegeuk Kim" <jaegeuk@kernel.org>:
> > On Mon, Aug 29, 2016 at 07:50:24PM +0300, Alexander Gordeev wrote:
> >> =A0Hi,
> >>
> >> =A0I have an update about the first of the bugs, that I reported.
> >>
> >> =A019.08.2016, 20:23, "Alexander Gordeev" <alex@gordick.net>:
> >> =A0> Hi,
> >> =A0>
> >> =A0> I'd also like to report two bugs. I used f2fs-stable branch linux=
-3.10.y.
> >> =A0> I'm using some proprietary modules also, but in my understanding =
they shouldn't affect the fs.
> >> =A0>
> >> =A0> 1. I have a Sandisk 16GB microSDHC card, that is quite old and ma=
y be at its end of life.
> >> =A0> The bug is produced every time I try to delete any file on it.
> >> =A0>
> >
> > ...
> >
> >> =A0As you can see, after to warnings goes an oops. I think it was over=
looked.
> >> =A0But it makes the most trouble to me.
> >>
> >> =A0I tried to understand what's going on.
> >> =A0It turns out that se->cur_valid_map is NULL in update_sit_entry().
> >> =A0Probably, this is not expected.
> >
> > Thank you for the analysis. :)
> > It seems the blkaddr is out-of-range.
> > Can you print out its blkaddr?
> >
> > If possible, could you print out:
> > =A0=A0curseg->segno, curseg->next_blkoff,a curseg->next_segno
> > =A0=A0at the end of allocate_segment_by_default()?
> =

> Thank you for the help!
> Here are the new traces:

Thank you.

> =

> [   49.274678] ------------[ cut here ]------------
> [   49.280216] WARNING: at /home/alex/work/s2l/amb_S2l_SDK_2.5/SDK2.5/s2l=
_linux_sdk/ambarella/kernel/linux-3.10/fs/f2fs/segment.c:1105 new_curseg+0x=
268/0x394 [f2fs]()

This means there is no free segment.
Could you print out the below information before this f2fs_bug_on?
- prefree_segments(sbi)
- free_segments(sbi)

> ...
> [   49.518054] ---[ end trace 49dca462b4f988ff ]---
> [   49.522689] ------------[ cut here ]------------
> [   49.527375] WARNING: at /home/alex/work/s2l/amb_S2l_SDK_2.5/SDK2.5/s2l=
_linux_sdk/ambarella/kernel/linux-3.10/fs/f2fs/segment.c:1144 new_curseg+0x=
2f0/0x394 [f2fs]()

This is caused by the above segno which was -1.

> ...
> [   49.764853] ---[ end trace 49dca462b4f98900 ]---
> [   49.857344] ------ segno =3D 7540, next_blkoff =3D 0, next_segno =3D 4=
294967295 --------
> [   49.913664] ------ blkaddr =3D 3889152 --------
> [   49.918173] Unable to handle kernel NULL pointer dereference at virtua=
l address 00000000

Also, we can see next_segno was -1, which incur no se entry for this segmen=
t.
At this moment, I'd really like to see its /sys/kernel/debug/f2fs/status wh=
ether
there is really not enough free segments.

Thanks,

> ...
> =

> --=A0
>  Alexander

---------------------------------------------------------------------------=
---
