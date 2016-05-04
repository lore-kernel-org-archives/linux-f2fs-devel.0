From: Stephen Bates <stephen.bates@microsemi.com>
Subject: Kernel panic in F2FS mount on NVMe SSD.
Date: Wed, 4 May 2016 22:47:10 +0000
Message-ID: <D87A37E7A4AA544D853031D9A919C70B168FC5E3@avsrvexchmbx2.microsemi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stephen.bates@microsemi.com>) id 1ay5pE-0003vk-84
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 04 May 2016 23:03:24 +0000
Received: from mail-by2on0096.outbound.protection.outlook.com ([207.46.100.96]
	helo=na01-by2-obe.outbound.protection.outlook.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ay5pC-0005nA-8x
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 04 May 2016 23:03:24 +0000
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

Hi

I have been experimenting with putting F2FS onto a NVMe block device. I have been hitting a kernel panic on mount and was wondering if anyone on the list had any ideas what might be causing this. I formatted the NVMe block device using the f2fs-tools version 1.2.0 with default format settings.  This is Ubuntu 14.04 running v2.6-rc6 (though I see a similar problem on older kernels).

The NVMe device is about 4TB big and is formatted for 4KB sectors. I have done some long term stability testing on the same drive using ext4 so the issue does seem to be F2FS related. 

[  328.464442]
[  328.464449] **********************************************************
[  328.464451] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
[  328.464453] **                                                      **
[  328.464455] ** trace_printk() being used. Allocating extra memory.  **
[  328.464456] **                                                      **
[  328.464458] ** This means that this is a DEBUG kernel and it is     **
[  328.464460] ** unsafe for production use.                           **
[  328.464461] **                                                      **
[  328.464463] ** If you see this message and you are not debugging    **
[  328.464465] ** the kernel, report this immediately to your vendor!  **
[  328.464466] **                                                      **
[  328.464468] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
[  328.464470] **********************************************************
[  330.031867] ------------[ cut here ]------------
[  330.031962] kernel BUG at fs/f2fs/segment.h:608!
[  330.032004] invalid opcode: 0000 [#1] SMP
[  330.032004] Modules linked in: crc32_generic(E) f2fs(E) xt_tcpudp(E) ip6table_filter(E) ip6_tables(E) iptable_filter(E) ip_tables(E) x_tables(E) des_generic(E) md4(E) rfcomm(E) bnep(E) bluetooth(E) nls_utf8(E) cifs(E) fscache(E) amdkfd(E) amd_iommu_v2(E) radeon(E) i2c_algo_bit(E) drm_kms_helper(E) syscopyarea(E) sysfillrect(E) joydev(E) sysimgblt(E) fb_sys_fops(E) ttm(E) drm(E) nvme(E) gpio_ich(E) nvme_core(E) serio_raw(E) coretemp(E) i5000_edac(E) 8250_fintek(E) edac_core(E) lpc_ich(E) shpchp(E) mac_hid(E) i5k_amb(E) parport_pc(E) ppdev(E) lp(E) parport(E) hid_generic(E) usbhid(E) hid(E) pata_acpi(E) e1000e(E) ptp(E) pps_core(E) floppy(E)
[  330.032004] CPU: 1 PID: 2913 Comm: mount Tainted: G            E   4.6.0-rc6+nevado-v4.6-rc6 #2
[  330.032004] Hardware name: Supermicro X7DB8/X7DB8, BIOS 2.1 06/23/2008
[  330.032004] task: ffff8800cabe3400 ti: ffff88009f448000 task.ti: ffff88009f448000
[  330.032004] RIP: 0010:[<ffffffffc0509e1f>]  [<ffffffffc0509e1f>] build_segment_manager+0x191f/0x1980 [f2fs]
[  330.032004] RSP: 0018:ffff88009f44bc40  EFLAGS: 00010297
[  330.032004] RAX: 0000000000000000 RBX: 00000000001a30a1 RCX: 00000000000001fe
[  330.032004] RDX: 0000000000000000 RSI: 0000000000000200 RDI: ffff88009f44bc80
[  330.032004] RBP: ffff88009f44bcf8 R08: 3ffffffffe9da846 R09: ffffffffffffffff
[  330.032004] R10: ffff88010ceeecb8 R11: ffff88009f44bb60 R12: ffffc90008177338
[  330.032004] R13: 0000000000000072 R14: 0000000000000200 R15: ffff8800c15b1800
[  330.032004] FS:  00007f3728b35880(0000) GS:ffff88012fc80000(0000) knlGS:0000000000000000
[  330.032004] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  330.032004] CR2: 00007f9530eecf70 CR3: 00000000a2e23000 CR4: 00000000000006e0
[  330.032004] Stack:
[  330.032004]  0000000000008137 00007c0000000400 ffff8800001aa400 ffff8801292b0f00
[  330.032004]  ffff8800001a30a1 ffff8800cabb0120 ffff8800b98dd400 8000000000000000
[  330.032004]  4000000000f7874d 3000000000432464 d000000002c71521 9000000000550b07
[  330.032004] Call Trace:
[  330.032004]  [<ffffffffc04f2bbd>] f2fs_fill_super+0x62d/0xfe0 [f2fs]
[  330.032004]  [<ffffffff81209217>] mount_bdev+0x187/0x1c0
[  330.032004]  [<ffffffffc04f2590>] ? f2fs_commit_super+0xc0/0xc0 [f2fs]
[  330.032004]  [<ffffffffc04ecbe5>] f2fs_mount+0x15/0x20 [f2fs]
[  330.032004]  [<ffffffff81209af9>] mount_fs+0x39/0x160
[  330.032004]  [<ffffffff811a6145>] ? __alloc_percpu+0x15/0x20
[  330.032004]  [<ffffffff81224c47>] vfs_kern_mount+0x67/0x110
[  330.032004]  [<ffffffff812271f5>] do_mount+0x225/0xdb0
[  330.032004]  [<ffffffff811e542f>] ? __kmalloc_track_caller+0x1af/0x250
[  330.032004]  [<ffffffff811a0a31>] ? strndup_user+0x41/0x80
[  330.032004]  [<ffffffff811a0952>] ? memdup_user+0x42/0x70
[  330.032004]  [<ffffffff81228063>] SyS_mount+0x83/0xd0
[  330.032004]  [<ffffffff817aecf6>] entry_SYSCALL_64_fastpath+0x1e/0xa8
[  330.032004] Code: 0e 48 83 c7 04 48 83 c6 04 83 ea 04 89 4f fc e9 8d ed ff ff 48 83 ea 01 e9 7a ef ff ff 48 8d 7a ff e9 d6 ee ff ff e8 3d 61 00 00 <0f> 0b 4c 8d 68 ff e9 af f7 ff ff 48 83 e8 01 e9 87 f7 ff ff e8
[  330.032004] RIP  [<ffffffffc0509e1f>] build_segment_manager+0x191f/0x1980 [f2fs]
[  330.032004]  RSP <ffff88009f44bc40>
[  330.071560] ---[ end trace 22b76b4a512d7db2 ]---

Cheers

Stephen


------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
