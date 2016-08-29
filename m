From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: video archive on a microSD card
Date: Mon, 29 Aug 2016 11:00:20 -0700
Message-ID: <20160829180020.GF94184@jaegeuk>
References: <146631471002747@web20h.yandex.ru>
	<281281471258049@web6h.yandex.ru>
	<eac97eb4-6b4a-a987-48e9-72680238e50a@huawei.com>
	<7021471263772@web16m.yandex.ru> <158901471427237@web4g.yandex.ru>
	<bd0fc9a6-03d3-e32c-f6c7-f64d4ba8506e@kernel.org>
	<1184081471518295@web5m.yandex.ru> <20160819024105.GA64207@jaegeuk>
	<39941471627359@web1m.yandex.ru> <35301472489424@web15m.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1beQrG-0007ZA-Ax
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 29 Aug 2016 18:00:30 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1beQrF-0003Qx-Dm
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 29 Aug 2016 18:00:30 +0000
Content-Disposition: inline
In-Reply-To: <35301472489424@web15m.yandex.ru>
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

On Mon, Aug 29, 2016 at 07:50:24PM +0300, Alexander Gordeev wrote:
> Hi,
> =

> I have an update about the first of the bugs, that I reported.
> =

> 19.08.2016, 20:23, "Alexander Gordeev" <alex@gordick.net>:
> > Hi,
> >
> > I'd also like to report two bugs. I used f2fs-stable branch linux-3.10.=
y.
> > I'm using some proprietary modules also, but in my understanding they s=
houldn't affect the fs.
> >
> > 1. I have a Sandisk 16GB microSDHC card, that is quite old and may be a=
t its end of life.
> > The bug is produced every time I try to delete any file on it.
> >

...

> As you can see, after to warnings goes an oops. I think it was overlooked.
> But it makes the most trouble to me. =

> =

> I tried to understand what's going on.
> It turns out that se->cur_valid_map is NULL in update_sit_entry().
> Probably, this is not expected.

Thank you for the analysis. :)
It seems the blkaddr is out-of-range.
Can you print out its blkaddr?

If possible,  could you print out:
  curseg->segno, curseg->next_blkoff,a curseg->next_segno
  at the end of allocate_segment_by_default()?

Thanks,

> =

> I made this patch:
> =

> diff --git a/ambarella/kernel/linux-3.10/fs/f2fs/segment.c b/ambarella/ke=
rnel/linux-3.10/fs/f2fs/segment.c
> index 20eb067..767394e 100644
> --- a/ambarella/kernel/linux-3.10/fs/f2fs/segment.c
> +++ b/ambarella/kernel/linux-3.10/fs/f2fs/segment.c
> @@ -872,6 +872,7 @@ static void update_sit_entry(struct f2fs_sb_info *sbi=
, block_t blkaddr, int del)
>  =

>         /* Update valid block bitmap */
>         if (del > 0) {
> +               f2fs_bug_on(sbi, !se->cur_valid_map);
>                 if (f2fs_test_and_set_bit(offset, se->cur_valid_map))
>                         f2fs_bug_on(sbi, 1);
>                 if (!f2fs_test_and_set_bit(offset, se->discard_map))
> =

> And got this new warning:
> =

> [   49.878738] ------------[ cut here ]------------
> [   49.913650] WARNING: at /home/alex/work/s2l/amb_S2l_SDK_2.5/SDK2.5/s2l=
_linux_sdk/ambarella/kernel/linux-3.10/fs/f2fs/segment.c:875 update_sit_ent=
ry+0xfc/0x274 [f2fs]()
> [   49.956951] Modules linked in: crc32 f2fs ov4689_mipi(PO) xt_tcpudp nf=
_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack iptable_filter ip_=
tables x_tables sd_mod bcmdhd(O) cfg80v
> [   50.047314] CPU: 0 PID: 421 Comm: f2fs_gc-8:0 Tainted: P        W  O 3=
.10.93 #1
> [   50.066051] [<800128d0>] (unwind_backtrace+0x0/0x118) from [<80011180>=
] (show_stack+0x10/0x14)
> [   50.097576] [<80011180>] (show_stack+0x10/0x14) from [<80020200>] (war=
n_slowpath_common+0x4c/0x68)
> [   50.117019] [<80020200>] (warn_slowpath_common+0x4c/0x68) from [<80020=
2ac>] (warn_slowpath_null+0x18/0x20)
> [   50.127578] [<800202ac>] (warn_slowpath_null+0x18/0x20) from [<7f536b0=
8>] (update_sit_entry+0xfc/0x274 [f2fs])
> [   50.145997] [<7f536b08>] (update_sit_entry+0xfc/0x274 [f2fs]) from [<7=
f538838>] (refresh_sit_entry+0x1c/0xb8 [f2fs])
> [   50.157110] [<7f538838>] (refresh_sit_entry+0x1c/0xb8 [f2fs]) from [<7=
f539840>] (allocate_data_block+0x238/0x318 [f2fs])
> [   50.170414] [<7f539840>] (allocate_data_block+0x238/0x318 [f2fs]) from=
 [<7f539b44>] (do_write_page+0x224/0x270 [f2fs])
> [   50.211114] [<7f539b44>] (do_write_page+0x224/0x270 [f2fs]) from [<7f5=
39c28>] (write_node_page+0x38/0x40 [f2fs])
> [   50.235535] [<7f539c28>] (write_node_page+0x38/0x40 [f2fs]) from [<7f5=
322fc>] (f2fs_write_node_page+0x1f8/0x2e4 [f2fs])
> [   50.262378] [<7f5322fc>] (f2fs_write_node_page+0x1f8/0x2e4 [f2fs]) fro=
m [<7f533a48>] (move_node_page+0xa8/0xe8 [f2fs])
> [   50.303626] [<7f533a48>] (move_node_page+0xa8/0xe8 [f2fs]) from [<7f52=
ac60>] (do_garbage_collect+0x3b8/0xbbc [f2fs])
> [   50.316456] [<7f52ac60>] (do_garbage_collect+0x3b8/0xbbc [f2fs]) from =
[<7f52b768>] (f2fs_gc+0x304/0x4e8 [f2fs])
> [   50.327530] [<7f52b768>] (f2fs_gc+0x304/0x4e8 [f2fs]) from [<7f52bbc0>=
] (gc_thread_func+0x274/0x368 [f2fs])
> [   50.340949] [<7f52bbc0>] (gc_thread_func+0x274/0x368 [f2fs]) from [<80=
03eb28>] (kthread+0xa0/0xac)
> [   50.350623] [<8003eb28>] (kthread+0xa0/0xac) from [<8000dd60>] (ret_fr=
om_fork+0x14/0x34)
> [   50.359590] ---[ end trace 2e2fd9e8fd78501a ]---
> =

> --=A0
>  Alexander

---------------------------------------------------------------------------=
---
