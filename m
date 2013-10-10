From: Jan Altenberg <jan@linutronix.de>
Subject: BUG_ON in recovery.c after powercut
Date: Thu, 10 Oct 2013 16:23:28 +0200
Message-ID: <1381415008.3138.32.camel@moestavern>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jan@linutronix.de>) id 1VUHQ6-0003jY-Ix
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 10 Oct 2013 14:40:54 +0000
Received: from www.linutronix.de ([62.245.132.108] helo=Galois.linutronix.de)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps
	(TLSv1:AES256-SHA:256) (Exim 4.76) id 1VUHQ4-0006mg-DA
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 10 Oct 2013 14:40:54 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi all,

I've just triggered a BUG_ON, which looks similar to:
http://www.mail-archive.com/linux-f2fs-devel@lists.sourceforge.net/msg00336.html

I'm running 3.11.4 on a BeagleBone Black. Unfortunately, I need a couple
of patches on top of 3.11.4, because I need MMC support:
https://github.com/beagleboard/kernel/tree/3.11

If I put a 2012.12 Angstrom image for the beagle on the eMMC and use it
as a rootfilesystem, I'm triggering the following issue, when doing a
powercut:

[...]
[    4.228477] F2FS-fs (mmcblk0p2): recover_inode and its dentry: ino = ca3d, name = system.journal, dir = ca24, err = 0
[    4.242586] F2FS-fs (mmcblk0p2): recover_inode and its dentry: ino = ca3d, name = system.journal, dir = ca24, err = 0
[    4.260272] F2FS-fs (mmcblk0p2): recover_inode and its dentry: ino = ca44, name = settings.UXHEXP, dir = a9df, err = 0
[    4.276471] F2FS-fs (mmcblk0p2): recover_inode and its dentry: ino = ca5e, name = settings.8VMWXP, dir = a9e1, err = 0
[    4.298343] F2FS-fs (mmcblk0p2): recover_data: ino = ca3d, recovered_data = 1 blocks, err = 0
[    4.332907] ------------[ cut here ]------------
[    4.337797] kernel BUG at /home/jan/work/beagle/linux-3.11/fs/f2fs/recovery.c:306!
[    4.345775] Internal error: Oops - BUG: 0 [#1] SMP ARM
[    4.351193] Modules linked in:
[    4.354435] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.11.4 #10
[    4.360768] task: de05b440 ti: de05c000 task.ti: de05c000
[    4.366483] PC is at recover_fsync_data+0xc0c/0xc48
[    4.371629] LR is at recover_fsync_data+0x8fc/0xc48
[    4.376773] pc : [<c028e6a8>]    lr : [<c028e398>]    psr: 80000113
[    4.376773] sp : de05dcf0  ip : 00000000  fp : 0008101d
[    4.388867] r10: 2007fffb  r9 : de2ba000  r8 : 200803f5
[    4.394373] r7 : 00000000  r6 : c134c4a0  r5 : de05dd6c  r4 : dd9d3438
[    4.401252] r3 : fffffffb  r2 : c0f84000  r1 : 00000470  r0 : de425000
[    4.408132] Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[    4.415834] Control: 10c5387d  Table: 80004019  DAC: 00000015
[    4.421889] Process swapper/0 (pid: 1, stack limit = 0xde05c240)
[    4.428220] Stack: (0xde05dcf0 to 0xde05e000)
[    4.432817] dce0:                                     00000001 00000000 00000000 c0092f34
[    4.441440] dd00: 00000001 00000000 0005d9bd c134c4c0 0000005e 00000000 dd9c6508 00100100
[    4.450063] dd20: 00200200 0000ca3d 00000000 dd9c6508 c134c4c0 c134c660 0000ca3a 000000d8
[    4.458685] dd40: 00000000 00000000 de05c000 0000000f de42505c dd9aac98 00000002 0000ca3a
[    4.467308] dd60: 0000ca3d ffffffff 00000000 dd9d3438 dd9d3418 00ca3dc8 00000000 00000000
[    4.475930] dd80: dd9c6770 de2ba000 de2ba800 00000000 00000000 6e6790fc 00000000 00000000
[    4.484553] dda0: de05c000 c0281ab0 00000000 00000000 c0d81400 dd9c44c8 00001000 dd803340
[    4.493176] ddc0: 00000081 dd8033e4 00008001 de2ba800 00008001 c0115da0 dd803340 de05de08
[    4.501798] dde0: 62636d6d 70306b6c 00000032 00000008 00000004 c010e398 000079ec c051532c
[    4.510420] de00: 00000000 00008001 00000000 de2bbcc0 c07ef0ac 00000000 00000000 c027f188
[    4.519042] de20: c0281530 c07973d8 00008001 c0116a9c de05c000 c012dfd4 de01b200 c07ef0ac
[    4.527665] de40: de2bbcc0 00008001 00000000 00008001 c07dce38 c012e464 c07ef0ac 00000000
[    4.536286] de60: de2bbcc0 de2bbd00 00000060 c01303b4 00000000 c0650a50 de2bbcc0 00008001
[    4.544909] de80: de01bb10 dd9ad270 0000000a 00000000 0000000a c00f02e0 0000000a de059000
[    4.553531] dea0: c0650a50 00000000 00008001 c0650a50 c134bd00 000000a5 00000000 c0130ad0
[    4.562153] dec0: 00000000 00006180 00000000 de2bbd00 de2bbcc0 00000000 000000b3 de3e8000
[    4.570776] dee0: 00008001 de3e8000 c0775f48 c0733f38 00000000 c0650a50 0b300002 ffffff9c
[    4.579398] df00: 00000000 c0066a80 dd9c19a8 c0121244 de01bb10 dd9aec48 c0775f48 000000b3
[    4.588020] df20: 000000b3 c0775f59 c0775f20 c081ae40 c07334d0 c07887b4 000000a5 c0734240
[    4.596643] df40: 00000000 de05df24 de05b440 c0775f48 c081ae60 c0775f59 c0775f20 c07343c0
[    4.605264] df60: c081ae40 c07334d0 c07887b4 c0775f40 00000007 c0733c54 00000007 00000007
[    4.613886] df80: c07334d0 c1394fc0 00000000 c0500770 00000000 00000000 00000000 00000000
[    4.622507] dfa0: 00000000 c0500778 00000000 c0013788 00000000 00000000 00000000 00000000
[    4.631128] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    4.639748] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000 ffdf67fc f77ffdd4
[    4.648384] [<c028e6a8>] (recover_fsync_data+0xc0c/0xc48) from [<c0281ab0>] (f2fs_fill_super+0x580/0x670)
[    4.658487] [<c0281ab0>] (f2fs_fill_super+0x580/0x670) from [<c0115da0>] (mount_bdev+0x168/0x19c)
[    4.667848] [<c0115da0>] (mount_bdev+0x168/0x19c) from [<c027f188>] (f2fs_mount+0x18/0x20)
[    4.676565] [<c027f188>] (f2fs_mount+0x18/0x20) from [<c0116a9c>] (mount_fs+0x44/0x178)
[    4.685009] [<c0116a9c>] (mount_fs+0x44/0x178) from [<c012e464>] (vfs_kern_mount+0x4c/0xc0)
[    4.693819] [<c012e464>] (vfs_kern_mount+0x4c/0xc0) from [<c01303b4>] (do_mount+0x1c8/0x860)
[    4.702718] [<c01303b4>] (do_mount+0x1c8/0x860) from [<c0130ad0>] (SyS_mount+0x84/0xb8)
[    4.711168] [<c0130ad0>] (SyS_mount+0x84/0xb8) from [<c0733f38>] (mount_block_root+0x100/0x234)
[    4.720343] [<c0733f38>] (mount_block_root+0x100/0x234) from [<c0734240>] (mount_root+0xe8/0x108)
[    4.729700] [<c0734240>] (mount_root+0xe8/0x108) from [<c07343c0>] (prepare_namespace+0x160/0x1c4)
[    4.739149] [<c07343c0>] (prepare_namespace+0x160/0x1c4) from [<c0733c54>] (kernel_init_freeable+0x1d0/0x21c)
[    4.749616] [<c0733c54>] (kernel_init_freeable+0x1d0/0x21c) from [<c0500778>] (kernel_init+0x8/0xe4)
[    4.759263] [<c0500778>] (kernel_init+0x8/0xe4) from [<c0013788>] (ret_from_fork+0x14/0x2c)
[    4.768068] Code: e584c004 ebf9fb3e eafffed4 e7f001f2 (e7f001f2) 
[    4.774505] ---[ end trace 6a3aa57fb472d1aa ]---
[    4.779939] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[...]

fsck.f2fs gives the following output on that partition:
root@beaglebone:~# fsck.f2fs /dev/mmcblk1p2
Info: sector size = 512
Info: total sectors = 3598560 (in 512bytes)
[is_valid_ssa_data_blk: 137] summary_entry.nid         [0x24]
[is_valid_ssa_data_blk: 138] summary_entry.version     [0x0]
[is_valid_ssa_data_blk: 139] summary_entry.ofs_in_node [0xce]
[is_valid_ssa_data_blk: 141] parent nid                [0x268]
[is_valid_ssa_data_blk: 142] version from nat          [0x0]
[is_valid_ssa_data_blk: 143] idx in parent node        [0x0]
[is_valid_ssa_data_blk: 145] Target data block addr    [0x5a04]

Assertion failed!
[is_valid_ssa_data_blk: 146] 0
 --> Invalid data seg summary

After a reboot, the system comes up, the filesystem is mounted and I
just see: 
[    4.221523] F2FS-fs (mmcblk0p2): Cannot recover all fsync data errno=-2

The filesystem seems consistent and it works if I do a clean reboot. If
I do a powercut again, it runs again into that BUG_ON.

It's quite easy to reproduce on that system.
     1. mkfs.f2fs on the eMMC partition
     2. copy the Angstrom RFS to that partition
     3. reboot and use that partition as a rootfilesystem
     4. wait until the RFS is mounted and the system is up
     5. -> POWERCUT

Using that procedure it's 100% reproducable. Up to now, I wasn't able to
isolate, what's really necessary to run into that problem. In my case,
it just triggers with the Angstrom image, but I don't know why.
I did a lot of stress testing from within an RFS on the SD-Card and the
F2FS partition was just mounted to /mnt. I also did lots of testing with
a very simple (busybox based) RFS. All of those tests were fine.

Just let me know if you need more information, or if I should do some
more testing.

Cheers,
	Jan


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134071&iu=/4140/ostg.clktrk
