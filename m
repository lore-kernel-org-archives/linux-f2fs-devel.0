From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: video archive on a microSD card
Date: Tue, 23 Aug 2016 14:27:27 -0700
Message-ID: <20160823212727.GE73835@jaegeuk>
References: <146631471002747@web20h.yandex.ru>
	<281281471258049@web6h.yandex.ru>
	<eac97eb4-6b4a-a987-48e9-72680238e50a@huawei.com>
	<7021471263772@web16m.yandex.ru> <158901471427237@web4g.yandex.ru>
	<bd0fc9a6-03d3-e32c-f6c7-f64d4ba8506e@kernel.org>
	<1184081471518295@web5m.yandex.ru> <20160819024105.GA64207@jaegeuk>
	<39941471627359@web1m.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bcJEU-0001eI-20
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 23 Aug 2016 21:27:42 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bcJER-0002Jc-Cy
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 23 Aug 2016 21:27:41 +0000
Content-Disposition: inline
In-Reply-To: <39941471627359@web1m.yandex.ru>
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

Hi,

This is caused by no free segment to write data or node blocks.
In both of cases, have you tried file defragmentation?
I'd like to know whether this bug happens in normal cases as well.

Can you provide fsck.f2fs messages?

Thanks,

On Fri, Aug 19, 2016 at 08:22:39PM +0300, Alexander Gordeev wrote:
> Hi,
> =

> I'd also like to report two bugs. I used f2fs-stable branch linux-3.10.y.
> I'm using some proprietary modules also, but in my understanding they sho=
uldn't affect the fs.
> =

> 1. I have a Sandisk 16GB microSDHC card, that is quite old and may be at =
its end of life.
> The bug is produced every time I try to delete any file on it.
> =

> [   28.805413] ------------[ cut here ]------------
> [   28.810327] WARNING: at /home/alex/work/s2l/amb_S2l_SDK_2.5/SDK2.5/s2l=
_linux_sdk/ambarella/kernel/linux-3.10/fs/f2fs/segment.c:1103 new_curseg+0x=
330/0x40c [f2fs]()
> [   28.824971] Modules linked in:
> [   28.828128]  ov4689_mipi(PO) crc32 f2fs xt_tcpudp nf_conntrack_ipv4 nf=
_defrag_ipv4 xt_conntrack nf_conntrack iptable_filter ip_tables x_tables sd=
_mod usb_storage scsi_mod mmc_block evdev bcmdhd(O) amb
> arella_crypto gpio_keys pwm_ambarella snd_soc_wm8974_amb spi_slave_ambare=
lla snd_soc_ambarella_i2s snd_soc_ambarella ambarella_eth spi_ambarella of_=
mdio ambarella_sd cfg80211 rfkill mmc_core ohci_hcd ehc
> i_hcd usbcore ambarella_udc ambarella_input_ir ambarella_input_adc ambdbu=
s(PO) ambtve(PO) ambad(PO) dsplog(PO) iav(PO) snd_soc_amba_board snd_soc_am=
bdummy snd_soc_core snd_compress regmap_i2c snd_pcm snd
> _page_alloc snd_timer snd soundcore regmap_spi imgproc(PO) hw_timer(PO) v=
out(PO) dsp(PO) ksz80x1r libphy spidev i2c_dev
> [   28.891640] CPU: 0 PID: 489 Comm: videoserverd Tainted: P           O =
3.10.93 #1
> [   28.899128] [<8001338c>] (unwind_backtrace+0x0/0x12c) from [<80011a0c>=
] (show_stack+0x10/0x14)
> [   28.907795] [<80011a0c>] (show_stack+0x10/0x14) from [<8001effc>] (war=
n_slowpath_common+0x54/0x68)
> [   28.916777] [<8001effc>] (warn_slowpath_common+0x54/0x68) from [<8001f=
0ac>] (warn_slowpath_null+0x1c/0x24)
> [   28.926531] [<8001f0ac>] (warn_slowpath_null+0x1c/0x24) from [<7f51c22=
0>] (new_curseg+0x330/0x40c [f2fs])
> [   28.936364] [<7f51c220>] (new_curseg+0x330/0x40c [f2fs]) from [<7f51c6=
f0>] (allocate_segment_by_default+0x230/0x2b4 [f2fs])
> [   28.947594] [<7f51c6f0>] (allocate_segment_by_default+0x230/0x2b4 [f2f=
s]) from [<7f51ccc8>] (allocate_data_block+0x2d8/0x3d8 [f2fs])
> [   28.959624] [<7f51ccc8>] (allocate_data_block+0x2d8/0x3d8 [f2fs]) from=
 [<7f51cf84>] (do_write_page+0x1bc/0x2c8 [f2fs])
> [   28.970374] [<7f51cf84>] (do_write_page+0x1bc/0x2c8 [f2fs]) from [<7f5=
1d128>] (write_node_page+0x3c/0x44 [f2fs])
> [   28.980595] [<7f51d128>] (write_node_page+0x3c/0x44 [f2fs]) from [<7f5=
15560>] (f2fs_write_node_page+0xec/0x294 [f2fs])
> [   28.991328] [<7f515560>] (f2fs_write_node_page+0xec/0x294 [f2fs]) from=
 [<7f516af0>] (move_node_page+0xcc/0xf8 [f2fs])
> [   29.002072] [<7f516af0>] (move_node_page+0xcc/0xf8 [f2fs]) from [<7f50=
e33c>] (do_garbage_collect+0xa24/0xcdc [f2fs])
> [   29.012652] [<7f50e33c>] (do_garbage_collect+0xa24/0xcdc [f2fs]) from =
[<7f50e7ec>] (f2fs_gc+0xc8/0x618 [f2fs])
> [   29.022684] [<7f50e7ec>] (f2fs_gc+0xc8/0x618 [f2fs]) from [<7f503e70>]=
 (f2fs_unlink+0x40/0xe8 [f2fs])
> [   29.032013] [<7f503e70>] (f2fs_unlink+0x40/0xe8 [f2fs]) from [<800ae7f=
8>] (vfs_unlink+0x78/0x114)
> [   29.040940] [<800ae7f8>] (vfs_unlink+0x78/0x114) from [<800ae9b0>] (do=
_unlinkat+0x11c/0x1a8)
> [   29.049402] [<800ae9b0>] (do_unlinkat+0x11c/0x1a8) from [<8000ecc0>] (=
ret_fast_syscall+0x0/0x38)
> [   29.058186] ---[ end trace d249769884543c44 ]---
> [   29.062825] ------------[ cut here ]------------
> [   29.067523] WARNING: at /home/alex/work/s2l/amb_S2l_SDK_2.5/SDK2.5/s2l=
_linux_sdk/ambarella/kernel/linux-3.10/fs/f2fs/segment.c:1142 new_curseg+0x=
3e4/0x40c [f2fs]()
> [   29.082113] Modules linked in: ov4689_mipi(PO) crc32 f2fs xt_tcpudp nf=
_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack iptable_filter ip_=
tables x_tables sd_mod usb_storage scsi_mod mmc_block e
> vdev bcmdhd(O) ambarella_crypto gpio_keys pwm_ambarella snd_soc_wm8974_am=
b spi_slave_ambarella snd_soc_ambarella_i2s snd_soc_ambarella ambarella_eth=
 spi_ambarella of_mdio ambarella_sd cfg80211 rfkill mmc
> _core ohci_hcd ehci_hcd usbcore ambarella_udc ambarella_input_ir ambarell=
a_input_adc ambdbus(PO) ambtve(PO) ambad(PO) dsplog(PO) iav(PO) snd_soc_amb=
a_board snd_soc_ambdummy snd_soc_core snd_compress regm
> ap_i2c snd_pcm snd_page_alloc snd_timer snd soundcore regmap_spi imgproc(=
PO) hw_timer(PO) vout(PO) dsp(PO) ksz80x1r libphy spidev i2c_dev
> [   29.147142] CPU: 0 PID: 489 Comm: videoserverd Tainted: P        W  O =
3.10.93 #1
> [   29.154564] [<8001338c>] (unwind_backtrace+0x0/0x12c) from [<80011a0c>=
] (show_stack+0x10/0x14)
> [   29.163211] [<80011a0c>] (show_stack+0x10/0x14) from [<8001effc>] (war=
n_slowpath_common+0x54/0x68)
> [   29.172184] [<8001effc>] (warn_slowpath_common+0x54/0x68) from [<8001f=
0ac>] (warn_slowpath_null+0x1c/0x24)
> [   29.181887] [<8001f0ac>] (warn_slowpath_null+0x1c/0x24) from [<7f51c2d=
4>] (new_curseg+0x3e4/0x40c [f2fs])
> [   29.191508] [<7f51c2d4>] (new_curseg+0x3e4/0x40c [f2fs]) from [<7f51c6=
f0>] (allocate_segment_by_default+0x230/0x2b4 [f2fs])
> [   29.202785] [<7f51c6f0>] (allocate_segment_by_default+0x230/0x2b4 [f2f=
s]) from [<7f51ccc8>] (allocate_data_block+0x2d8/0x3d8 [f2fs])
> [   29.214742] [<7f51ccc8>] (allocate_data_block+0x2d8/0x3d8 [f2fs]) from=
 [<7f51cf84>] (do_write_page+0x1bc/0x2c8 [f2fs])
> [   29.225477] [<7f51cf84>] (do_write_page+0x1bc/0x2c8 [f2fs]) from [<7f5=
1d128>] (write_node_page+0x3c/0x44 [f2fs])
> [   29.235822] [<7f51d128>] (write_node_page+0x3c/0x44 [f2fs]) from [<7f5=
15560>] (f2fs_write_node_page+0xec/0x294 [f2fs])
> [   29.246575] [<7f515560>] (f2fs_write_node_page+0xec/0x294 [f2fs]) from=
 [<7f516af0>] (move_node_page+0xcc/0xf8 [f2fs])
> [   29.257220] [<7f516af0>] (move_node_page+0xcc/0xf8 [f2fs]) from [<7f50=
e33c>] (do_garbage_collect+0xa24/0xcdc [f2fs])
> [   29.267850] [<7f50e33c>] (do_garbage_collect+0xa24/0xcdc [f2fs]) from =
[<7f50e7ec>] (f2fs_gc+0xc8/0x618 [f2fs])
> [   29.277887] [<7f50e7ec>] (f2fs_gc+0xc8/0x618 [f2fs]) from [<7f503e70>]=
 (f2fs_unlink+0x40/0xe8 [f2fs])
> [   29.287127] [<7f503e70>] (f2fs_unlink+0x40/0xe8 [f2fs]) from [<800ae7f=
8>] (vfs_unlink+0x78/0x114)
> [   29.296045] [<800ae7f8>] (vfs_unlink+0x78/0x114) from [<800ae9b0>] (do=
_unlinkat+0x11c/0x1a8)
> [   29.304504] [<800ae9b0>] (do_unlinkat+0x11c/0x1a8) from [<8000ecc0>] (=
ret_fast_syscall+0x0/0x38)
> [   29.313271] ---[ end trace d249769884543c45 ]---
> [   29.371882] Unable to handle kernel NULL pointer dereference at virtua=
l address 00000000
> [   29.396142] pgd =3D 85644000
> [   29.399051] [00000000] *pgd=3D0357b831, *pte=3D00000000, *ppte=3D00000=
000
> [   29.407041] Internal error: Oops: 17 [#1] PREEMPT ARM
> [   29.412085] Modules linked in: ov4689_mipi(PO) crc32 f2fs xt_tcpudp nf=
_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack iptable_filter ip_=
tables x_tables sd_mod usb_storage scsi_mod mmc_block e
> vdev bcmdhd(O) ambarella_crypto gpio_keys pwm_ambarella snd_soc_wm8974_am=
b spi_slave_ambarella snd_soc_ambarella_i2s snd_soc_ambarella ambarella_eth=
 spi_ambarella of_mdio ambarella_sd cfg80211 rfkill mmc
> _core ohci_hcd ehci_hcd usbcore ambarella_udc ambarella_input_ir ambarell=
a_input_adc ambdbus(PO) ambtve(PO) ambad(PO) dsplog(PO) iav(PO) snd_soc_amb=
a_board snd_soc_ambdummy snd_soc_core snd_compress regm
> ap_i2c snd_pcm snd_page_alloc snd_timer snd soundcore regmap_spi imgproc(=
PO) hw_timer(PO) vout(PO) dsp(PO) ksz80x1r libphy spidev i2c_dev
> [   29.476936] CPU: 0 PID: 489 Comm: videoserverd Tainted: P        W  O =
3.10.93 #1
> [   29.484309] task: 869fdc80 ti: 83350000 task.ti: 83350000
> [   29.489728] PC is at update_sit_entry+0xc4/0x250 [f2fs]
> [   29.494949] LR is at update_sit_entry+0x78/0x250 [f2fs]
> [   29.500154] pc : [<7f51a74c>]    lr : [<7f51a700>]    psr: 20060013
> sp : 83351c48  ip : 00000000  fp : 84a0f740
> [   29.511600] r10: 00000000  r9 : 00001d74  r8 : 00000001
> [   29.516800] r7 : 00000000  r6 : 00000080  r5 : 859ac2e0  r4 : 857e6800
> [   29.523301] r3 : 00000007  r2 : 00153fae  r1 : 00000000  r0 : 00153fae
> [   29.529805] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segme=
nt user
> [   29.536914] Control: 10c53c7d  Table: 05844059  DAC: 00000015
> [   29.542639] Process videoserverd (pid: 489, stack limit =3D 0x83350238)
> [   29.549054] Stack: (0x83351c48 to 0x83352000)
> [   29.553394] 1c40:                   00000001 857e6800 003b5800 0034c07=
5 00000004 00000001
> [   29.561547] 1c60: 00000000 83351d38 80550080 7f51baf0 857e6800 86974cd=
0 86974cd0 7f51ccd8
> [   29.569701] 1c80: 83351d2c 84a0f740 00000000 84a0f768 0034c075 83351d0=
1 00000000 800d0d94
> [   29.577853] 1ca0: 00000000 000000f0 60060013 7f5103cc 86455e00 83351d2=
c 00000004 80550080
> [   29.586005] 1cc0: 0000010c 83351d01 857e6938 000006b0 857e6800 7f51cf8=
4 83351d01 00000004
> [   29.594156] 1ce0: 857e6800 00000000 83351d70 80550080 804ce684 000006b=
0 857e6800 7f51d128
> [   29.602309] 1d00: 0006b080 00000000 857e6938 7f515560 00000064 8006ddd=
8 8054b8f4 000006b0
> [   29.610461] 1d20: 000006b0 0034c075 86390d08 857e6800 00000001 0000041=
1 003b5800 0034c075
> [   29.618612] 1d40: 80550080 00000000 80550080 857e6800 00000200 857e6a8=
0 861c2333 00000075
> [   29.626765] 1d60: 857e6800 7f516af0 000006b0 00000001 00000001 0000000=
0 00000000 00000000
> [   29.634916] 1d80: 00000000 00000000 00000001 00000000 861c2333 8055008=
0 00000000 7f50e33c
> [   29.643069] 1da0: 00000001 83351e00 83351eb0 00001a28 000006b0 85795a5=
0 83350000 00000000
> [   29.651220] 1dc0: 000273c0 00000000 00001a2a 805a0840 00000001 861c200=
0 00000001 83351e8c
> [   29.659372] 1de0: 0034c000 857e6804 00001a28 83350000 83351e08 000273c=
0 000003fc 83351e88
> [   29.667525] 1e00: 84a0f6c0 84a0f7c0 91827364 83351e0c 83351e0c 83351e1=
4 83351e14 000006b0
> [   29.675676] 1e20: 000006b0 0034c075 00000008 00000400 00000000 857e680=
0 83351e8c 00000000
> [   29.683828] 1e40: 00000000 00000000 857e6a80 00000400 00000000 857e680=
0 83351e8c 7f50e7ec
> [   29.691979] 1e60: 00000000 ffffffea 00000000 83351ef4 00000000 0000000=
0 00000000 00000000
> [   29.700131] 1e80: 857e6a50 857e6a60 00001a28 83351e8c 83351e8c 0000000=
0 00000050 00000000
> [   29.708282] 1ea0: 00000002 84d43950 000000d6 863d83d8 863d83ec 0000000=
4 00000000 00000000
> [   29.716434] 1ec0: 00000000 00000000 00000000 857e6800 86390568 0000000=
0 857e692c 84d43034
> [   29.724586] 1ee0: 863dc720 863dc720 01da6a24 7f503e70 863d83c0 8057786=
0 00000000 86390568
> [   29.732738] 1f00: 863d83c0 00000000 01da9a34 ffffff9c 863d83c0 800ae7f=
8 01da6a24 000bda58
> [   29.740890] 1f20: 00000000 00000000 8699e000 800ae9b0 85795a50 863acaa=
8 6fe7deef 00000004
> [   29.749042] 1f40: 8699e027 ffffff9c 00000000 86214d50 86390568 0000000=
0 00000002 00000000
> [   29.757194] 1f60: 00000000 00000000 00000000 00000000 00000000 0000000=
0 57b1c919 3ace5a0f
> [   29.765346] 1f80: 57b1c919 3ace5a0f 01da9a34 00418a80 7eee3978 0000000=
a 8000ee44 83350000
> [   29.773498] 1fa0: 00000000 8000ecc0 01da9a34 00418a80 01da9a34 7eee383=
8 81b40000 000081b4
> [   29.781650] 1fc0: 01da9a34 00418a80 7eee3978 0000000a 01da6ef0 01dac12=
0 7eee3978 01da6a24
> [   29.789802] 1fe0: 76c49a71 7eee382c 76c49a79 76ca6926 800d0030 01da9a3=
4 00000000 00000000
> [   29.798018] [<7f51a74c>] (update_sit_entry+0xc4/0x250 [f2fs]) from [<7=
f51baf0>] (refresh_sit_entry+0x1c/0xb8 [f2fs])
> [   29.808554] [<7f51baf0>] (refresh_sit_entry+0x1c/0xb8 [f2fs]) from [<7=
f51ccd8>] (allocate_data_block+0x2e8/0x3d8 [f2fs])
> [   29.819429] [<7f51ccd8>] (allocate_data_block+0x2e8/0x3d8 [f2fs]) from=
 [<7f51cf84>] (do_write_page+0x1bc/0x2c8 [f2fs])
> [   29.830129] [<7f51cf84>] (do_write_page+0x1bc/0x2c8 [f2fs]) from [<7f5=
1d128>] (write_node_page+0x3c/0x44 [f2fs])
> [   29.840312] [<7f51d128>] (write_node_page+0x3c/0x44 [f2fs]) from [<7f5=
15560>] (f2fs_write_node_page+0xec/0x294 [f2fs])
> [   29.851017] [<7f515560>] (f2fs_write_node_page+0xec/0x294 [f2fs]) from=
 [<7f516af0>] (move_node_page+0xcc/0xf8 [f2fs])
> [   29.861630] [<7f516af0>] (move_node_page+0xcc/0xf8 [f2fs]) from [<7f50=
e33c>] (do_garbage_collect+0xa24/0xcdc [f2fs])
> [   29.872157] [<7f50e33c>] (do_garbage_collect+0xa24/0xcdc [f2fs]) from =
[<7f50e7ec>] (f2fs_gc+0xc8/0x618 [f2fs])
> [   29.882157] [<7f50e7ec>] (f2fs_gc+0xc8/0x618 [f2fs]) from [<7f503e70>]=
 (f2fs_unlink+0x40/0xe8 [f2fs])
> [   29.891373] [<7f503e70>] (f2fs_unlink+0x40/0xe8 [f2fs]) from [<800ae7f=
8>] (vfs_unlink+0x78/0x114)
> [   29.900231] [<800ae7f8>] (vfs_unlink+0x78/0x114) from [<800ae9b0>] (do=
_unlinkat+0x11c/0x1a8)
> [   29.908672] [<800ae9b0>] (do_unlinkat+0x11c/0x1a8) from [<8000ecc0>] (=
ret_fast_syscall+0x0/0x38)
> [   29.917434] Code: e2063007 e3a06001 e1a06316 e1a071aa (e7d121aa) =

> [   29.974780] ---[ end trace d249769884543c46 ]---
> =

> =

> 2. I tried to run manual defragmentation of all the files on an almost new
> Transcend 128GB microSDXC card to fix the archive. Unfortunately this bug
> appeared after successful defragmentation of several files:
> =

> [ 5819.169892] ------------[ cut here ]------------
> [ 5819.174668] WARNING: at /home/alex/work/s2l/amb_S2l_SDK_2.5/SDK2.5/s2l=
_linux_sdk/ambarella/kernel/linux-3.10/fs/f2fs/segment.c:1087 new_curseg+0x=
150/0x3b0 [f2fs]()
> [ 5819.189524] Modules linked in: ov4689_mipi(PO) crc32 f2fs xt_tcpudp nf=
_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack iptable_filter ip_=
tables x_tables sd_mod mmc_block usb_storage gpio_keys v
> [ 5819.251573] CPU: 0 PID: 1363 Comm: f2fstool Tainted: P           O 3.1=
0.93 #1
> [ 5819.258793] [<80012444>] (unwind_backtrace+0x0/0x118) from [<80010cdc>=
] (show_stack+0x10/0x14)
> [ 5819.267471] [<80010cdc>] (show_stack+0x10/0x14) from [<8001d3c8>] (war=
n_slowpath_common+0x4c/0x68)
> [ 5819.276445] [<8001d3c8>] (warn_slowpath_common+0x4c/0x68) from [<8001d=
474>] (warn_slowpath_null+0x18/0x20)
> [ 5819.286294] [<8001d474>] (warn_slowpath_null+0x18/0x20) from [<7f47f53=
0>] (new_curseg+0x150/0x3b0 [f2fs])
> [ 5819.296041] [<7f47f530>] (new_curseg+0x150/0x3b0 [f2fs]) from [<7f47f9=
dc>] (allocate_segment_by_default+0xa4/0x270 [f2fs])
> [ 5819.307317] [<7f47f9dc>] (allocate_segment_by_default+0xa4/0x270 [f2fs=
]) from [<7f480114>] (allocate_data_block+0x310/0x318 [f2fs])
> [ 5819.319257] [<7f480114>] (allocate_data_block+0x310/0x318 [f2fs]) from=
 [<7f480340>] (do_write_page+0x224/0x270 [f2fs])
> [ 5819.330071] [<7f480340>] (do_write_page+0x224/0x270 [f2fs]) from [<7f4=
804b8>] (write_data_page+0x8c/0xa4 [f2fs])
> [ 5819.340372] [<7f4804b8>] (write_data_page+0x8c/0xa4 [f2fs]) from [<7f4=
76ff4>] (do_write_data_page+0x10c/0x430 [f2fs])
> [ 5819.351070] [<7f476ff4>] (do_write_data_page+0x10c/0x430 [f2fs]) from =
[<7f472bdc>] (do_garbage_collect+0xad8/0xbcc [f2fs])
> [ 5819.362209] [<7f472bdc>] (do_garbage_collect+0xad8/0xbcc [f2fs]) from =
[<7f472fd4>] (f2fs_gc+0x304/0x4e8 [f2fs])
> [ 5819.372382] [<7f472fd4>] (f2fs_gc+0x304/0x4e8 [f2fs]) from [<7f47779c>=
] (f2fs_write_data_page+0x484/0x4d4 [f2fs])
> [ 5819.382756] [<7f47779c>] (f2fs_write_data_page+0x484/0x4d4 [f2fs]) fro=
m [<7f47424c>] (f2fs_write_data_pages+0x2d8/0x3dc [f2fs])
> [ 5819.394361] [<7f47424c>] (f2fs_write_data_pages+0x2d8/0x3dc [f2fs]) fr=
om [<800665f4>] (__filemap_fdatawrite_range+0x60/0x68)
> [ 5819.405599] [<800665f4>] (__filemap_fdatawrite_range+0x60/0x68) from [=
<80066620>] (filemap_fdatawrite+0x24/0x2c)
> [ 5819.415810] [<80066620>] (filemap_fdatawrite+0x24/0x2c) from [<7f4639f=
c>] (f2fs_defragment_range+0x664/0x6b4 [f2fs])
> [ 5819.426445] [<7f4639fc>] (f2fs_defragment_range+0x664/0x6b4 [f2fs]) fr=
om [<7f4668f4>] (f2fs_ioctl+0xae0/0x117c [f2fs])
> [ 5819.437202] [<7f4668f4>] (f2fs_ioctl+0xae0/0x117c [f2fs]) from [<8009f=
b64>] (vfs_ioctl+0x28/0x3c)
> [ 5819.446105] [<8009fb64>] (vfs_ioctl+0x28/0x3c) from [<800a058c>] (do_v=
fs_ioctl+0x484/0x56c)
> [ 5819.454463] [<800a058c>] (do_vfs_ioctl+0x484/0x56c) from [<800a06ac>] =
(SyS_ioctl+0x38/0x58)
> [ 5819.462882] [<800a06ac>] (SyS_ioctl+0x38/0x58) from [<8000e1c0>] (ret_=
fast_syscall+0x0/0x38)
> [ 5819.471311] ---[ end trace 7e587b920f507a04 ]---
> [ 5819.475939] ------------[ cut here ]------------
> [ 5819.480611] WARNING: at /home/alex/work/s2l/amb_S2l_SDK_2.5/SDK2.5/s2l=
_linux_sdk/ambarella/kernel/linux-3.10/fs/f2fs/segment.c:1142 new_curseg+0x=
300/0x3b0 [f2fs]()
> [ 5819.495227] Modules linked in: ov4689_mipi(PO) crc32 f2fs xt_tcpudp nf=
_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack iptable_filter ip_=
tables x_tables sd_mod mmc_block usb_storage gpio_keys v
> [ 5819.557163] CPU: 0 PID: 1363 Comm: f2fstool Tainted: P        W  O 3.1=
0.93 #1
> [ 5819.564332] [<80012444>] (unwind_backtrace+0x0/0x118) from [<80010cdc>=
] (show_stack+0x10/0x14)
> [ 5819.572959] [<80010cdc>] (show_stack+0x10/0x14) from [<8001d3c8>] (war=
n_slowpath_common+0x4c/0x68)
> [ 5819.581946] [<8001d3c8>] (warn_slowpath_common+0x4c/0x68) from [<8001d=
474>] (warn_slowpath_null+0x18/0x20)
> [ 5819.591707] [<8001d474>] (warn_slowpath_null+0x18/0x20) from [<7f47f6e=
0>] (new_curseg+0x300/0x3b0 [f2fs])
> [ 5819.601375] [<7f47f6e0>] (new_curseg+0x300/0x3b0 [f2fs]) from [<7f47f9=
dc>] (allocate_segment_by_default+0xa4/0x270 [f2fs])
> [ 5819.612548] [<7f47f9dc>] (allocate_segment_by_default+0xa4/0x270 [f2fs=
]) from [<7f480114>] (allocate_data_block+0x310/0x318 [f2fs])
> [ 5819.624523] [<7f480114>] (allocate_data_block+0x310/0x318 [f2fs]) from=
 [<7f480340>] (do_write_page+0x224/0x270 [f2fs])
> [ 5819.635354] [<7f480340>] (do_write_page+0x224/0x270 [f2fs]) from [<7f4=
804b8>] (write_data_page+0x8c/0xa4 [f2fs])
> [ 5819.645642] [<7f4804b8>] (write_data_page+0x8c/0xa4 [f2fs]) from [<7f4=
76ff4>] (do_write_data_page+0x10c/0x430 [f2fs])
> [ 5819.656337] [<7f476ff4>] (do_write_data_page+0x10c/0x430 [f2fs]) from =
[<7f472bdc>] (do_garbage_collect+0xad8/0xbcc [f2fs])
> [ 5819.667505] [<7f472bdc>] (do_garbage_collect+0xad8/0xbcc [f2fs]) from =
[<7f472fd4>] (f2fs_gc+0x304/0x4e8 [f2fs])
> [ 5819.677682] [<7f472fd4>] (f2fs_gc+0x304/0x4e8 [f2fs]) from [<7f47779c>=
] (f2fs_write_data_page+0x484/0x4d4 [f2fs])
> [ 5819.688086] [<7f47779c>] (f2fs_write_data_page+0x484/0x4d4 [f2fs]) fro=
m [<7f47424c>] (f2fs_write_data_pages+0x2d8/0x3dc [f2fs])
> [ 5819.699547] irq_sync_frame_count(388): Add missing 2 frames to the fra=
me queue! DSP(H264: 247189; MJEPG: 0), IAV(Total: 247187)!
> [ 5819.711303] [<7f47424c>] (f2fs_write_data_pages+0x2d8/0x3dc [f2fs]) fr=
om [<800665f4>] (__filemap_fdatawrite_range+0x60/0x68)
> [ 5819.722548] [<800665f4>] (__filemap_fdatawrite_range+0x60/0x68) from [=
<80066620>] (filemap_fdatawrite+0x24/0x2c)
> [ 5819.732771] [<80066620>] (filemap_fdatawrite+0x24/0x2c) from [<7f4639f=
c>] (f2fs_defragment_range+0x664/0x6b4 [f2fs])
> [ 5819.743389] [<7f4639fc>] (f2fs_defragment_range+0x664/0x6b4 [f2fs]) fr=
om [<7f4668f4>] (f2fs_ioctl+0xae0/0x117c [f2fs])
> [ 5819.754139] [<7f4668f4>] (f2fs_ioctl+0xae0/0x117c [f2fs]) from [<8009f=
b64>] (vfs_ioctl+0x28/0x3c)
> [ 5819.763037] [<8009fb64>] (vfs_ioctl+0x28/0x3c) from [<800a058c>] (do_v=
fs_ioctl+0x484/0x56c)
> [ 5819.771374] [<800a058c>] (do_vfs_ioctl+0x484/0x56c) from [<800a06ac>] =
(SyS_ioctl+0x38/0x58)
> [ 5819.779759] [<800a06ac>] (SyS_ioctl+0x38/0x58) from [<8000e1c0>] (ret_=
fast_syscall+0x0/0x38)
> [ 5819.788228] ---[ end trace 7e587b920f507a05 ]---
> [ 5819.816478] Unable to handle kernel NULL pointer dereference at virtua=
l address 00000000
> [ 5819.839179] pgd =3D 82960000
> [ 5819.842605] [00000000] *pgd=3D0084f831, *pte=3D00000000, *ppte=3D00000=
000
> [ 5819.849403] Internal error: Oops: 17 [#1] PREEMPT ARM
> [ 5819.854439] Modules linked in: ov4689_mipi(PO) crc32 f2fs xt_tcpudp nf=
_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack iptable_filter ip_=
tables x_tables sd_mod mmc_block usb_storage gpio_keys v
> [ 5819.916258] CPU: 0 PID: 1363 Comm: f2fstool Tainted: P        W  O 3.1=
0.93 #1
> [ 5819.923373] task: 81d6f800 ti: 83350000 task.ti: 83350000
> [ 5819.928824] PC is at update_sit_entry+0xf0/0x218 [f2fs]
> [ 5819.934088] LR is at update_sit_entry+0xac/0x218 [f2fs]
> [ 5819.939295] pc : [<7f47d454>]    lr : [<7f47d410>]    psr: 200f0013
> [ 5819.939295] sp : 83351a20  ip : 00000001  fp : 8515a8c0
> [ 5819.950741] r10: 00000001  r9 : ffffffff  r8 : a86023f8
> [ 5819.955944] r7 : 0000e708  r6 : 00000080  r5 : 00000000  r4 : 8587cc00
> [ 5819.962446] r3 : 00000001  r2 : 00000000  r1 : 00000000  r0 : 00174241
> [ 5819.968951] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segme=
nt user
> [ 5819.976062] Control: 10c53c7d  Table: 02b60059  DAC: 00000015
> [ 5819.981785] Process f2fstool (pid: 1363, stack limit =3D 0x83350238)
> [ 5819.987941] Stack: (0x83351a20 to 0x83352000)
> [ 5819.992285] 1a20: 83351bd0 8587cc00 0040b455 01cff800 00000000 83351bc=
4 869ec468 8052e420
> [ 5820.000443] 1a40: 861d36a8 7f47f00c 8587cc00 869ec468 00000002 7f48003=
c 8046a4a0 83351b14
> [ 5820.008598] 1a60: 861d3680 83351bd0 0040b455 83351ac1 833936b4 000024c=
7 83351ac8 00000002
> [ 5820.016752] 1a80: 83351bc4 83351ac1 00000000 83351bc4 00000001 0000000=
1 00000000 7f480340
> [ 5820.024907] 1aa0: 83351ac1 00000002 00000001 83351b14 83351bc4 8587cc0=
0 8052e420 7f4804b8
> [ 5820.033062] 1ac0: 0024c790 01520100 000024c7 0000249a 019c12dd 8052e40=
1 8587cc00 8052e420
> [ 5820.041216] 1ae0: 86540528 7f476ff4 8019cf50 680d0013 86540528 0000000=
0 00000000 000024c7
> [ 5820.049371] 1b00: 00000152 00000000 0040b455 8587cc00 8052e420 8654052=
8 804a6380 8049ae20
> [ 5820.057525] 1b20: 000024c7 00000152 00000000 0040b455 8285f253 8587cc0=
0 8052e420 86540528
> [ 5820.065679] 1b40: 8285f253 83350000 00000001 00000001 00000000 7f472bd=
c 00000001 00000210
> [ 5820.073834] 1b60: 00001f66 00001f64 00000003 83351b80 804a9be0 0000000=
0 0002f160 00000055
> [ 5820.081989] 1b80: 8285f000 00001f68 8587cc04 00000000 0002f190 83351c2=
4 85e71c00 0040b400
> [ 5820.090144] 1ba0: 000024c7 0000249a 019c12dd 8272c001 91827364 83351bb=
4 83351bb4 83351bbc
> [ 5820.098298] 1bc0: 83351bbc 8587cc00 00000000 00000411 01cff800 0040b45=
5 8052e420 00000000
> [ 5820.106451] 1be0: 00000004 8587cc00 0000001b 00000001 00000000 0000000=
2 0000001b 00000000
> [ 5820.114605] 1c00: 00000004 7f472fd4 00000001 00000000 00000000 0000000=
0 0000001a 00000009
> [ 5820.122759] 1c20: 00001f64 8658d260 8658d1f0 00000003 00000050 864395f=
1 00000002 00000001
> [ 5820.130913] 1c40: 00001c2b 00000000 804c2d80 804c47c0 00001a94 0000020=
6 00000000 003a3fff
> [ 5820.139067] 1c60: 60060013 8587cc00 8052dd60 864536e0 00000001 83351da=
0 00000000 02572000
> [ 5820.147221] 1c80: 00000000 7f47779c 0000000e 00000102 83351d20 8335000=
8 8587cd2c 00000000
> [ 5820.155376] 1ca0: 864c75b4 80066130 00000002 8587cc00 00000000 0000041=
1 003a3fff 01324440
> [ 5820.163530] 1cc0: 8052dd60 00000000 00002570 8645379c ffffffff 864536e=
0 00002570 00000001
> [ 5820.171684] 1ce0: 8587cc00 8052dd60 83351da0 7f47424c 0000000e 0000000=
2 81c5c000 ffffffff
> [ 5820.179837] 1d00: 00000005 00000000 00002571 0000000e 83351d54 0000000=
0 00000001 00000002
> [ 5820.187992] 1d20: 0000257a 91827364 83351d28 83351d28 83351d30 83351d3=
0 0000000e 00000000
> [ 5820.196148] 1d40: 804e4840 8049eca0 804d7e80 8046db00 80463d80 8052dd6=
0 8048b480 804ff940
> [ 5820.204302] 1d60: 804e2ea0 804d8840 80471960 804777c0 805111a0 80475fc=
0 00000000 8645379c
> [ 5820.212456] 1d80: 864536e0 00000000 00000000 00002600 00000200 0000240=
0 00000000 800665f4
> [ 5820.220609] 1da0: 7ffffe8e 00000000 00000000 00000000 ffffffff 7ffffff=
f 00000001 00000000
> [ 5820.228766] 1dc0: 8047b6e0 00002b0a 00000200 80066620 ffffffff 7ffffff=
f 00000001 00021000
> [ 5820.236921] 1de0: 8047b6e0 7f4639fc 02b09fff 00000000 83351ec0 0000020=
0 00000800 00000000
> [ 5820.245075] 1e00: 86453744 8006bd7c 00000006 000000a8 00000000 8008a21=
8 00000012 80013f04
> [ 5820.253229] 1e20: 804edd20 0132442e 00002600 000001e4 00000020 0000000=
0 82748c00 864536e0
> [ 5820.261383] 1e40: 82748c00 7e8a6a90 8587cc00 00000fff 00000000 8335000=
0 00000000 7f4668f4
> [ 5820.269537] 1e60: 76e94000 000000a8 82961db8 81d2e4d8 83350018 8007ee7=
4 000000a2 000000a8
> [ 5820.277692] 1e80: 00000000 600d0093 80450720 76f36000 000003b7 81dc8d8=
0 8585f580 000000a8
> [ 5820.285846] 1ea0: 82961db8 82960000 83350018 8007f054 82961db8 000000a=
8 83351fb0 000000a8
> [ 5820.294000] 1ec0: 00000000 00000000 02b0a000 00000000 000000a8 800138e=
4 00000800 00000000
> [ 5820.302154] 1ee0: 00000200 00001a88 000081b4 6eadc2c5 80403434 7e8a6a9=
0 864536e0 82748c00
> [ 5820.310308] 1f00: 0000f508 7e8a6a90 83350000 00000000 00000000 8009fb6=
4 4030582a 800a058c
> [ 5820.318464] 1f20: 57a7001f 3982fe52 57a7014a 1eb08998 57a7014a 1eb0899=
8 00001a88 00000000
> [ 5820.326618] 1f40: 7e8a6a18 7e8a6a18 00000000 80095854 00001a88 0000000=
0 00800000 000081b4
> [ 5820.334771] 1f60: 00000001 00000003 82748c00 00000000 0000f508 7e8a6a9=
0 83350000 00000000
> [ 5820.342924] 1f80: 00000000 800a06ac 00000003 00000000 00000000 0000000=
0 00000000 00000036
> [ 5820.351078] 1fa0: 8000e344 8000e1c0 00000000 00000000 00000003 0000f50=
8 7e8a6a90 7e8a6a90
> [ 5820.359231] 1fc0: 00000000 00000000 00000000 00000036 00000000 0000000=
0 76fba000 00000000
> [ 5820.367385] 1fe0: 76f37d91 7e8a6a84 000086f1 76f37d96 800d0030 0000000=
3 5bb15ad7 ae252a72
> [ 5820.375663] [<7f47d454>] (update_sit_entry+0xf0/0x218 [f2fs]) from [<7=
f47f00c>] (refresh_sit_entry+0x1c/0xb8 [f2fs])
> [ 5820.386266] [<7f47f00c>] (refresh_sit_entry+0x1c/0xb8 [f2fs]) from [<7=
f48003c>] (allocate_data_block+0x238/0x318 [f2fs])
> [ 5820.397214] [<7f48003c>] (allocate_data_block+0x238/0x318 [f2fs]) from=
 [<7f480340>] (do_write_page+0x224/0x270 [f2fs])
> [ 5820.407981] [<7f480340>] (do_write_page+0x224/0x270 [f2fs]) from [<7f4=
804b8>] (write_data_page+0x8c/0xa4 [f2fs])
> [ 5820.418219] [<7f4804b8>] (write_data_page+0x8c/0xa4 [f2fs]) from [<7f4=
76ff4>] (do_write_data_page+0x10c/0x430 [f2fs])
> [ 5820.428885] [<7f476ff4>] (do_write_data_page+0x10c/0x430 [f2fs]) from =
[<7f472bdc>] (do_garbage_collect+0xad8/0xbcc [f2fs])
> [ 5820.439983] [<7f472bdc>] (do_garbage_collect+0xad8/0xbcc [f2fs]) from =
[<7f472fd4>] (f2fs_gc+0x304/0x4e8 [f2fs])
> [ 5820.450124] [<7f472fd4>] (f2fs_gc+0x304/0x4e8 [f2fs]) from [<7f47779c>=
] (f2fs_write_data_page+0x484/0x4d4 [f2fs])
> [ 5820.460443] [<7f47779c>] (f2fs_write_data_page+0x484/0x4d4 [f2fs]) fro=
m [<7f47424c>] (f2fs_write_data_pages+0x2d8/0x3dc [f2fs])
> [ 5820.471952] [<7f47424c>] (f2fs_write_data_pages+0x2d8/0x3dc [f2fs]) fr=
om [<800665f4>] (__filemap_fdatawrite_range+0x60/0x68)
> [ 5820.483156] [<800665f4>] (__filemap_fdatawrite_range+0x60/0x68) from [=
<80066620>] (filemap_fdatawrite+0x24/0x2c)
> [ 5820.493342] [<80066620>] (filemap_fdatawrite+0x24/0x2c) from [<7f4639f=
c>] (f2fs_defragment_range+0x664/0x6b4 [f2fs])
> [ 5820.503901] [<7f4639fc>] (f2fs_defragment_range+0x664/0x6b4 [f2fs]) fr=
om [<7f4668f4>] (f2fs_ioctl+0xae0/0x117c [f2fs])
> [ 5820.514626] [<7f4668f4>] (f2fs_ioctl+0xae0/0x117c [f2fs]) from [<8009f=
b64>] (vfs_ioctl+0x28/0x3c)
> [ 5820.523485] [<8009fb64>] (vfs_ioctl+0x28/0x3c) from [<800a058c>] (do_v=
fs_ioctl+0x484/0x56c)
> [ 5820.531820] [<800a058c>] (do_vfs_ioctl+0x484/0x56c) from [<800a06ac>] =
(SyS_ioctl+0x38/0x58)
> [ 5820.540161] [<800a06ac>] (SyS_ioctl+0x38/0x58) from [<8000e1c0>] (ret_=
fast_syscall+0x0/0x38)
> [ 5820.548585] Code: e1c305f8 e3a03001 e59b2004 e1a06613 (e7d231a5) =

> [ 5820.674046] ---[ end trace 7e587b920f507a06 ]---
> =

> =

> I'll be happy to provide any additional information.
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
