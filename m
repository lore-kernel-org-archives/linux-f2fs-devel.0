From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: video archive on a microSD card
Date: Fri, 26 Aug 2016 18:15:33 -0700
Message-ID: <20160827011533.GF88444@jaegeuk>
References: <281281471258049@web6h.yandex.ru>
	<eac97eb4-6b4a-a987-48e9-72680238e50a@huawei.com>
	<7021471263772@web16m.yandex.ru> <158901471427237@web4g.yandex.ru>
	<bd0fc9a6-03d3-e32c-f6c7-f64d4ba8506e@kernel.org>
	<1184081471518295@web5m.yandex.ru> <20160819024105.GA64207@jaegeuk>
	<39941471627359@web1m.yandex.ru> <20160823212727.GE73835@jaegeuk>
	<86031472227468@web20h.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bdSDn-00077h-UC
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 27 Aug 2016 01:15:43 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bdSDm-00037T-93
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 27 Aug 2016 01:15:43 +0000
Content-Disposition: inline
In-Reply-To: <86031472227468@web20h.yandex.ru>
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

Hi Alexander,

On Fri, Aug 26, 2016 at 07:04:28PM +0300, Alexander Gordeev wrote:
> Hi Jaegeuk,
> =

> 24.08.2016, 00:27, "Jaegeuk Kim" <jaegeuk@kernel.org>:
> > Hi,
> >
> > This is caused by no free segment to write data or node blocks.
> > In both of cases, have you tried file defragmentation?
> > I'd like to know whether this bug happens in normal cases as well.
> =

> Just got this after my main process, that writes the video archive, was
> killed by OOM killer, and the system restarted thanks to
> vm.panic_on_oom + kernel.panic. Then right after the restart I got this:
> =

> [   26.845556] ------------[ cut here ]------------
> [   26.861986] WARNING: at /home/alex/work/s2l/amb_S2l_SDK_2.5/SDK2.5/s2l=
_linux_sdk/ambarella/kernel/linux-3.10/fs/f2fs/segment.c:876 update_sit_ent=
ry+0x118/0x218 [f2fs]()
> [   26.881959] Modules linked in: ov4689_mipi(PO) crc32 f2fs xt_tcpudp nf=
_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack iptable_filter ip_=
tables x_tables sd_mod mmc_block usb_storage evdev bcmdv
> [   26.971301] CPU: 0 PID: 525 Comm: videoserverd Tainted: P           O =
3.10.93 #1
> [   26.996438] [<80012444>] (unwind_backtrace+0x0/0x118) from [<80010cdc>=
] (show_stack+0x10/0x14)
> [   27.021738] [<80010cdc>] (show_stack+0x10/0x14) from [<8001d3c8>] (war=
n_slowpath_common+0x4c/0x68)
> [   27.041226] [<8001d3c8>] (warn_slowpath_common+0x4c/0x68) from [<8001d=
474>] (warn_slowpath_null+0x18/0x20)
> [   27.066835] [<8001d474>] (warn_slowpath_null+0x18/0x20) from [<7f4b647=
c>] (update_sit_entry+0x118/0x218 [f2fs])
> [   27.133465] [<7f4b647c>] (update_sit_entry+0x118/0x218 [f2fs]) from [<=
7f4b800c>] (refresh_sit_entry+0x1c/0xb8 [f2fs])
> [   27.188132] [<7f4b800c>] (refresh_sit_entry+0x1c/0xb8 [f2fs]) from [<7=
f4b903c>] (allocate_data_block+0x238/0x318 [f2fs])
> [   27.209063] [<7f4b903c>] (allocate_data_block+0x238/0x318 [f2fs]) from=
 [<7f4b9340>] (do_write_page+0x224/0x270 [f2fs])
> [   27.242807] [<7f4b9340>] (do_write_page+0x224/0x270 [f2fs]) from [<7f4=
b94b8>] (write_data_page+0x8c/0xa4 [f2fs])
> [   27.260651] [<7f4b94b8>] (write_data_page+0x8c/0xa4 [f2fs]) from [<7f4=
afff4>] (do_write_data_page+0x10c/0x430 [f2fs])
> [   27.281858] [<7f4afff4>] (do_write_data_page+0x10c/0x430 [f2fs]) from =
[<7f4b060c>] (f2fs_write_data_page+0x2f4/0x4d4 [f2fs])
> [   27.302545] [<7f4b060c>] (f2fs_write_data_page+0x2f4/0x4d4 [f2fs]) fro=
m [<7f4ad24c>] (f2fs_write_data_pages+0x2d8/0x3dc [f2fs])
> [   27.315031] [<7f4ad24c>] (f2fs_write_data_pages+0x2d8/0x3dc [f2fs]) fr=
om [<800665f4>] (__filemap_fdatawrite_range+0x60/0x68)
> [   27.333922] [<800665f4>] (__filemap_fdatawrite_range+0x60/0x68) from [=
<800666f4>] (filemap_write_and_wait_range+0x34/0x78)
> [   27.369185] [<800666f4>] (filemap_write_and_wait_range+0x34/0x78) from=
 [<7f49bbc8>] (f2fs_do_sync_file+0xc8/0x56c [f2fs])
> [   27.384766] [<7f49bbc8>] (f2fs_do_sync_file+0xc8/0x56c [f2fs]) from [<=
7f49c090>] (f2fs_sync_file+0x24/0x2c [f2fs])
> [   27.396348] [<7f49c090>] (f2fs_sync_file+0x24/0x2c [f2fs]) from [<800b=
5fdc>] (vfs_fsync+0x20/0x28)
> [   27.406225] [<800b5fdc>] (vfs_fsync+0x20/0x28) from [<800b6140>] (do_f=
sync+0x28/0x48)
> [   27.414893] [<800b6140>] (do_fsync+0x28/0x48) from [<8000e1c0>] (ret_f=
ast_syscall+0x0/0x38)
> [   27.428760] ---[ end trace d9a54d63707dc19e ]---
> [   34.177477] ------------[ cut here ]------------
> [   34.204559] WARNING: at /home/alex/work/s2l/amb_S2l_SDK_2.5/SDK2.5/s2l=
_linux_sdk/ambarella/kernel/linux-3.10/fs/f2fs/segment.c:881 update_sit_ent=
ry+0x16c/0x218 [f2fs]()
> [   34.314185] Modules linked in: ov4689_mipi(PO) crc32 f2fs xt_tcpudp nf=
_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack iptable_filter ip_=
tables x_tables sd_mod mmc_block usb_storage evdev bcmdv
> [   34.409462] CPU: 0 PID: 613 Comm: videoserverd Tainted: P        W  O =
3.10.93 #1
> [   34.472011] [<80012444>] (unwind_backtrace+0x0/0x118) from [<80010cdc>=
] (show_stack+0x10/0x14)
> [   34.509232] [<80010cdc>] (show_stack+0x10/0x14) from [<8001d3c8>] (war=
n_slowpath_common+0x4c/0x68)
> [   34.541215] [<8001d3c8>] (warn_slowpath_common+0x4c/0x68) from [<8001d=
474>] (warn_slowpath_null+0x18/0x20)
> [   34.621879] [<8001d474>] (warn_slowpath_null+0x18/0x20) from [<7f4b64d=
0>] (update_sit_entry+0x16c/0x218 [f2fs])
> [   34.662256] [<7f4b64d0>] (update_sit_entry+0x16c/0x218 [f2fs]) from [<=
7f4b8050>] (refresh_sit_entry+0x60/0xb8 [f2fs])
> [   34.702123] [<7f4b8050>] (refresh_sit_entry+0x60/0xb8 [f2fs]) from [<7=
f4b903c>] (allocate_data_block+0x238/0x318 [f2fs])
> [   34.741857] [<7f4b903c>] (allocate_data_block+0x238/0x318 [f2fs]) from=
 [<7f4b9340>] (do_write_page+0x224/0x270 [f2fs])
> [   34.805079] [<7f4b9340>] (do_write_page+0x224/0x270 [f2fs]) from [<7f4=
b94b8>] (write_data_page+0x8c/0xa4 [f2fs])
> [   34.841321] [<7f4b94b8>] (write_data_page+0x8c/0xa4 [f2fs]) from [<7f4=
afff4>] (do_write_data_page+0x10c/0x430 [f2fs])
> [   34.906465] [<7f4afff4>] (do_write_data_page+0x10c/0x430 [f2fs]) from =
[<7f4b060c>] (f2fs_write_data_page+0x2f4/0x4d4 [f2fs])
> [   34.979779] [<7f4b060c>] (f2fs_write_data_page+0x2f4/0x4d4 [f2fs]) fro=
m [<7f4ad24c>] (f2fs_write_data_pages+0x2d8/0x3dc [f2fs])
> [   35.009256] [<7f4ad24c>] (f2fs_write_data_pages+0x2d8/0x3dc [f2fs]) fr=
om [<800665f4>] (__filemap_fdatawrite_range+0x60/0x68)
> [   35.069102] [<800665f4>] (__filemap_fdatawrite_range+0x60/0x68) from [=
<800666f4>] (filemap_write_and_wait_range+0x34/0x78)
> [   35.096669] [<800666f4>] (filemap_write_and_wait_range+0x34/0x78) from=
 [<7f49bbc8>] (f2fs_do_sync_file+0xc8/0x56c [f2fs])
> [   35.119298] [<7f49bbc8>] (f2fs_do_sync_file+0xc8/0x56c [f2fs]) from [<=
7f49c090>] (f2fs_sync_file+0x24/0x2c [f2fs])
> [   35.142967] [<7f49c090>] (f2fs_sync_file+0x24/0x2c [f2fs]) from [<800b=
5fdc>] (vfs_fsync+0x20/0x28)
> [   35.194647] [<800b5fdc>] (vfs_fsync+0x20/0x28) from [<800b6140>] (do_f=
sync+0x28/0x48)
> [   35.213048] [<800b6140>] (do_fsync+0x28/0x48) from [<8000e1c0>] (ret_f=
ast_syscall+0x0/0x38)
> [   35.239412] ---[ end trace d9a54d63707dc19f ]---
> =

> =

> I consider this to be a normal situation. The filesystem was created
> several days ago with the default section size and mounted with these
> options: nodev,noexec,nosuid,noatime,nodiratime,nouser_xattr,noacl,mode=
=3Dlfs
> =

> Here is also the status right after the warnings:
> =

> =3D=3D=3D=3D=3D[ partition info(sda). #0, RW]=3D=3D=3D=3D=3D
> [SB: 1] [CP: 2] [SIT: 6] [NAT: 114] [SSA: 116] [MAIN: 59149(OverProv:3003=
 Resv:48)]
> =

> Utilization: 18% (5357903 valid blocks)
>   - Node: 6279 (Inode: 976, Other: 5303)
>   - Data: 5351624
>   - Inline_xattr Inode: 0
>   - Inline_data Inode: 0
>   - Inline_dentry Inode: 0
>   - Orphan Inode: 0
> =

> Main area: 59149 segs, 59149 secs 59149 zones
>   - COLD  data: 12160, 12160, 12160
>   - WARM  data: 11878, 11878, 11878
>   - HOT   data: 59117, 59117, 59117
>   - Dir   dnode: 59118, 59118, 59118
>   - File   dnode: 59115, 59115, 59115
>   - Indir nodes: 59129, 59129, 59129
> =

>   - Valid: 380
>   - Dirty: 11221
>   - Prefree: 0
>   - Free: 47548 (47548)
> =

> CP calls: 4 (BG: 0)
> GC calls: 0 (BG: 0)
>   - data segments : 0 (0)
>   - node segments : 0 (0)
> Try to move 0 blocks (BG: 0)
>   - data blocks : 0 (0)
>   - node blocks : 0 (0)
> =

> Extent Cache:
>   - Hit Count: L1-1:26 L1-2:2 L2:1
>   - Hit Ratio: 5% (29 / 574)
>   - Inner Struct Count: tree: 973(0), node: 0
> =

> Balancing F2FS Async:
>   - inmem:    0, wb_bios:    0
>   - nodes:    4 in    9
>   - dents:    2 in dirs:   2 (   0)
>   - datas:    0 in files:   0
>   - meta:    0 in   23
>   - NATs:         3/      167
>   - SITs:         3/    59149
>   - free_nids:      3587
> =

> Distribution of User Blocks: [ valid | invalid | free ]
>   [---------|--|---------------------------------------]
> =

> IPU: 0 blocks
> SSR: 0 blocks in 0 segments
> LFS: 3394 blocks in 7 segments
> =

> BDF: 93, avg. vblocks: 460
> =

> Memory: 12820 KB
>   - static: 12597 KB
>   - cached: 94 KB
>   - paged : 128 KB
> =

> =

> > Can you provide fsck.f2fs messages?
> =

> Sure:
> =

> Info: sector size =3D 512
> Info: total sectors =3D 243253248 (in 512 bytes)
> Info: MKFS version
>   "Linux version 3.10.93 (alex@deb-i386) (gcc version 4.9.1 20140625 (pre=
release) (crosstool-NG - Ambarella Linaro Multilib GCC [CortexA9 & ARMv6k] =
2014.06) ) #1 PREEMPT Mon Aug 22 12:09:13 MSK 2016"
> Info: FSCK version
>   from "Linux version 3.10.93 (alex@deb-i386) (gcc version 4.9.1 20140625=
 (prerelease) (crosstool-NG - Ambarella Linaro Multilib GCC [CortexA9 & ARM=
v6k] 2014.06) ) #1 PREEMPT Mon Aug 22 12:09:13 MSK 2016"
>     to "Linux version 3.10.93 (alex@deb-i386) (gcc version 4.9.1 20140625=
 (prerelease) (crosstool-NG - Ambarella Linaro Multilib GCC [CortexA9 & ARM=
v6k] 2014.06) ) #1 PREEMPT Mon Aug 22 12:09:13 MSK 2016"
> =

> [FSCK] Unreachable nat entries                        [Ok..] [0x0]
> [FSCK] SIT valid block bitmap checking                [Ok..]
> [FSCK] Hard link checking for regular file            [Ok..] [0x0]
> [FSCK] valid_block_count matching with CP             [Ok..] [0x51c14f]
> [FSCK] valid_node_count matcing with CP (de lookup)   [Ok..] [0x1887]
> [FSCK] valid_node_count matcing with CP (nat lookup)  [Ok..] [0x1887]
> [FSCK] valid_inode_count matched with CP              [Ok..] [0x3d0]
> [FSCK] free segment_count matched with CP             [Ok..] [0xb9bc]
> [FSCK] next block offset is free                      [Ok..]
> [FSCK] fixing SIT types
> [FSCK] other corrupted bugs                           [Ok..]
> =

> Done.

This means there is no inconsistency in the image.
Does WARN_ON occur all the time after mouting this device?

Thanks,

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
