From: Chris Ruehl <chris.ruehl@gtsys.com.hk>
Subject: f2fs: OOPS: kernel BUG at fs/f2fs/segment.h:620!
Date: Fri, 23 Jun 2017 09:12:32 +0800
Message-ID: <24265dcf-ba9d-be31-f0b2-66d67120510e@gtsys.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chris.ruehl@gtsys.com.hk>) id 1dODY7-0003r9-BL
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 23 Jun 2017 01:38:15 +0000
Received: from sh1.xit.com.hk ([111.91.236.50])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dODY2-0005V1-WC
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 23 Jun 2017 01:38:15 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net

Hi,

running kernel 4.9.29 and hit the BUG on the f2fs running on 4Gbyte eMMC on
mx6dl integrated board and hits the system at bootup.

Please find the Kernel dump below.
If you need further informations feel free to contact me.

Thanks
Chris

[    2.531133] ------------[ cut here ]------------
[    2.535777] kernel BUG at fs/f2fs/segment.h:620!
[    2.540401] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
[    2.546246] Modules linked in:
[    2.549331] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.9.29 #30
[    2.555344] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[    2.561879] task: ee070000 task.stack: ee056000
[    2.566430] PC is at build_segment_manager+0x788/0xe6c
[    2.571581] LR is at build_segment_manager+0x4ac/0xe6c
[    2.576728] pc : [<c033d6b4>]    lr : [<c033d3d8>]    psr: 20000113
[    2.576728] sp : ee057cd8  ip : 00000000  fp : ed039540
[    2.588213] r10: 00000000  r9 : 00000200  r8 : ed0da878
[    2.593445] r7 : 00000705  r6 : 000001f8  r5 : ed09b000  r4 : ee057d18
[    2.599978] r3 : 00000200  r2 : 00000200  r1 : 00000200  r0 : 00001200
[    2.606513] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[    2.613654] Control: 10c5387d  Table: 1000404a  DAC: 00000051
[    2.619406] Process swapper/0 (pid: 1, stack limit = 0xee056210)
[    2.625419] Stack: (0xee057cd8 to 0xee058000)
[    2.629785] 7cc0: 
00000001 ed09b000
[    2.637975] 7ce0: 0000a890 00000022 0000074e 00000400 00000022 ed08a800 
ed039540 ed0a4400
[    2.646162] 7d00: 00000000 c152dcdc ed09a800 c016e2a4 c0172f24 12000000 
ffffffff ffffffff
[    2.654349] 7d20: ffff00ff ffffffff ffffffff ffffffff ffffffff ffffffff 
ffffffff ffffffff
[    2.662537] 7d40: ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff 
0000310e 00000000
[    2.670724] 7d60: ed09b448 ed09b608 00000000 ed09b470 ed09b5d0 ed09b4d0 
ed09b000 ed09a800
[    2.678913] 7d80: ed09b470 c0324020 024000c0 c1538098 ed09ac58 c0a14ad4 
ee057e10 00000000
[    2.687101] 7da0: ee733000 00000001 f2f52010 ed09b010 c152dcdc ed09b774 
c1538004 00000000
[    2.695289] 7dc0: 3f015acd 00000000 00000200 00002600 000e3000 000e5600 
00000002 0000000a
[    2.703476] 7de0: 00000004 00000718 00000000 ed88c398 ed09a800 ed88c300 
00000083 00008000
[    2.711664] 7e00: 00000000 00008000 00000001 c02217c4 ed88c300 c0d5e7c0 
c0a0809c ee718900
[    2.719851] 7e20: ed036480 c0d19404 c0244384 00000000 c0d19404 c0322048 
c0323738 00000000
[    2.728038] 7e40: 00000000 c0222498 c0d19404 ed036480 ee718900 ed036480 
00008000 00000000
[    2.736226] 7e60: c0d19404 c02409b0 00000001 c0797ea0 c0d19404 c02400ec 
ed036404 c0d19404
[    2.744412] 7e80: 00000000 c02451f0 ed036480 ed036400 00000020 c0244384 
00000000 ed036480
[    2.752599] 7ea0: c09ff2a0 00000051 ee038010 ed807a10 0000000a 00000000 
0000000a c01ef964
[    2.760787] 7ec0: 00007fff ed036400 ed036480 00000000 00008000 c09ff2a4 
c09ff2a0 ffffffea
[    2.768974] 7ee0: 00008878 c02451f0 00000000 c0c1482c 00008000 ee7da01c 
ee7da000 ef5c7b40
[    2.777161] 7f00: c0c38878 c0c0117c 00000000 00006000 00006180 00000000 
ffffff9c c09ff2a0
[    2.785348] 7f20: 0b300002 c022e968 ee038010 ed807730 00000000 0b300002 
c0c38878 c0d5c024
[    2.793536] 7f40: c0c38878 c0c3888d c0d5c000 c0d5c000 000000c6 c0c38858 
00000000 c0c0163c
[    2.801723] 7f60: c0d5c000 c0d5c000 c0c46b8c 00000008 c0c38854 c0c00f54 
00000007 00000007
[    2.809910] 7f80: 00000000 c0c005a4 00000000 c0790860 00000000 00000000 
00000000 00000000
[    2.818096] 7fa0: 00000000 c0790868 00000000 c0107a10 00000000 00000000 
00000000 00000000
[    2.826282] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 
00000000 00000000
[    2.834469] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000 
21d24060 e020dd25
[    2.842668] [<c033d6b4>] (build_segment_manager) from [<c0324020>] 
(f2fs_fill_super+0x8e8/0x10e4)
[    2.851554] [<c0324020>] (f2fs_fill_super) from [<c02217c4>] 
(mount_bdev+0x16c/0x194)
[    2.859403] [<c02217c4>] (mount_bdev) from [<c0322048>] (f2fs_mount+0x18/0x20)
[    2.866641] [<c0322048>] (f2fs_mount) from [<c0222498>] (mount_fs+0x14/0xa4)
[    2.873705] [<c0222498>] (mount_fs) from [<c02409b0>] (vfs_kern_mount+0x54/0x134)
[    2.881201] [<c02409b0>] (vfs_kern_mount) from [<c0244384>] 
(do_mount+0x158/0xc5c)
[    2.888784] [<c0244384>] (do_mount) from [<c02451f0>] (SyS_mount+0x74/0x9c)
[    2.895765] [<c02451f0>] (SyS_mount) from [<c0c0117c>] 
(mount_block_root+0x10c/0x2d4)
[    2.903609] [<c0c0117c>] (mount_block_root) from [<c0c0163c>] 
(prepare_namespace+0x190/0x1d8)
[    2.912146] [<c0c0163c>] (prepare_namespace) from [<c0c00f54>] 
(kernel_init_freeable+0x2d8/0x2e8)
[    2.921036] [<c0c00f54>] (kernel_init_freeable) from [<c0790868>] 
(kernel_init+0x8/0x114)
[    2.929231] [<c0790868>] (kernel_init) from [<c0107a10>] 
(ret_from_fork+0x14/0x24)
[    2.936814] Code: e0433321 e58535a8 eaffff98 e7f001f2 (e7f001f2)
[    2.942919] ---[ end trace c9675cb653b1fa01 ]---
[    2.947948] Kernel panic - not syncing: Attempted to kill init! 
exitcode=0x0000000b
[    2.947948]
[    2.957136] CPU0: stopping
[    2.959879] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D         4.9.29 #30
[    2.967120] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[    2.973708] [<c010fbfc>] (unwind_backtrace) from [<c010bc60>] 
(show_stack+0x10/0x14)
[    2.981500] [<c010bc60>] (show_stack) from [<c0397cc0>] (dump_stack+0xac/0xd8)
[    2.988759] [<c0397cc0>] (dump_stack) from [<c010ec60>] (handle_IPI+0x1a0/0x1b4)
[    2.996188] [<c010ec60>] (handle_IPI) from [<c01014fc>] 
(gic_handle_irq+0x88/0x8c)
[    3.003789] [<c01014fc>] (gic_handle_irq) from [<c010c7b0>] (__irq_svc+0x70/0xb0)
[    3.011293] Exception stack(0xc0d01f60 to 0xc0d01fa8)
[    3.016376] 1f60: c0108490 00000000 c0d08080 00000000 c0d00000 c0d04cec 
c0d04d54 00000001
[    3.024583] 1f80: c0d14686 c0d14686 efffca80 00000000 00000001 c0d01fb0 
c0108490 c0108494
[    3.032779] 1fa0: 60000013 ffffffff
[    3.036303] [<c010c7b0>] (__irq_svc) from [<c0108494>] (arch_cpu_idle+0x24/0x3c)
[    3.043737] [<c0108494>] (arch_cpu_idle) from [<c016522c>] 
(cpu_startup_entry+0xd4/0x154)
[    3.051950] [<c016522c>] (cpu_startup_entry) from [<c0c00c70>] 
(start_kernel+0x394/0x3a0)
[    3.060159] [<c0c00c70>] (start_kernel) from [<10008078>] (0x10008078)
[    3.066733] ---[ end Kernel panic - not syncing: Attempted to kill init! 
exitcode=0x0000000b


-- 
GTSYS Limited RFID Technology
9/F, Unit E, R07, Kwai Shing Industrial Building Phase 2,
42-46 Tai Lin Pai Road, Kwai Chung, N.T., Hong Kong
Tel (852) 9079 9521

Disclaimer: https://www.gtsys.com.hk/email/classified.html

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
