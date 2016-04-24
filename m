From: Chao Yu <chao@kernel.org>
Subject: Re: Kernel OOPS in f2fs-stable on ARM
Date: Sun, 24 Apr 2016 21:51:12 +0800
Message-ID: <571CCF50.2070603@kernel.org>
References: <d47e3dc22666855cd3941a9a6808a450@mail.tophosting.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1auKRf-0008Ap-83
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 24 Apr 2016 13:51:31 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1auKRc-0004UY-RI
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 24 Apr 2016 13:51:31 +0000
In-Reply-To: <d47e3dc22666855cd3941a9a6808a450@mail.tophosting.at>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Georg Veichtlbauer <georg@veichtlbauer.net>, linux-f2fs-devel@lists.sourceforge.net

Hi Georg,

On 2016/4/22 14:58, Georg Veichtlbauer wrote:
> Hi,
> 
> I am experiencing seemingly random (i.e. the device is in standby mode) 
> reboots after updating to the latest f2fs-stable. It is a ARMv7 device - 
> the source repo is at 
> http://www.github.com/CyanogenMod/android_kernel_sony_apq8064. The 
> problem appeared after 
> https://github.com/CyanogenMod/android_kernel_sony_apq8064/commit/8abb552f64b1e6f7499fac286939fc000fde53ea
> 
> This happens on multiple devices. Please let me know if I can provide 
> any additional info.

I can't reproduce this issue in my virtual machine till now, but I inspired in
the reply of Yunlong Song's patch, the commit 91b0abe36a7b ("mm + fs: store
shadow entries in page cache") in mainline is not in your repo, I doubt that it
can cause this issue, could you backport it into your repo, and test it?

Thanks,

> 
> Cheers,
> Georg
> 
> 
> 
> [11011.154479] ------------[ cut here ]------------
> [11011.158111] kernel BUG at 
> ../../../../../../kernel/sony/apq8064/fs/f2fs/inode.c:335!
> [11011.165893] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
> [11011.171661] Modules linked in: wlan(C) [last unloaded: wlan]
> [11011.177306] CPU: 3    Tainted: G        WC    
> (3.4.0-cm-ge347aa9-00623-g72f4111 #1)
> [11011.184936] PC is at f2fs_evict_inode+0xe8/0x35c
> [11011.189605] LR is at find_get_pages+0x130/0x160
> [11011.194060] pc : [<c0342200>]    lr : [<c0208004>]    psr: 20000013
> [11011.194060] sp : ec131f08  ip : 00000000  fp : 12c02510
> [11011.205505] r10: 00000000  r9 : ec130000  r8 : c0106044
> [11011.210784] r7 : 00000000  r6 : c0fba758  r5 : edfa0c00  r4 : 
> ec976dc0
> [11011.217223] r3 : 00000001  r2 : 00000002  r1 : ec131e3c  r0 : 
> 00000000
> [11011.223785] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  
> Segment user
> [11011.230895] Control: 10c5787d  Table: 8c9f006a  DAC: 00000015
> [11011.236571]
> [11011.236602] PC: 0xc0342180:
> [11011.240844] 2180  e5163008 e1a01004 e5160004 e12fff33 e4963008 
> e3530000 1afffff8 e3c8303f
> [11011.248992] 21a0  e5932004 e2422001 e5832004 e1a0100d e3c13d7f 
> e3c3303f e5933000 e3130002
> [11011.257140] 21c0  0a000000 eb16dd86 e3a02000 e3a03000 e28400d0 
> ebfb3efc e5943028 e5952248
> [11011.265319] 21e0  e1530002 0a00009c e595224c e1530002 0a000099 
> e5943178 e3530000 0a000000
> [11011.273467] 2200  e7f001f2 e1a00004 eb003298 e1a00004 eb007a02 
> e594302c e3530000 0a000001
> [11011.281646] 2220  e3a06000 ea00002f e1a00004 ebfc500c e3500000 
> 1afffff9 e5943164 e3130020
> [11011.289794] 2240  1a000002 e3a00005 e2841f59 eb01c6df e5943068 
> e2833001 e5843068 f57ff05f
> [11011.297942] 2260  e3a02000 e3a03000 e1c426f0 f57ff05f e5943068 
> e2833001 e5843068 e5943184
> [11011.306121]
> [11011.306121] LR: 0xc0207f84:
> [11011.310424] 7f84  0a000022 e1a0300c eafffff0 e7890105 e2855001 
> e1550006 0a000017 e59d3008
> [11011.318542] 7fa4  e2842004 e59d1004 e2433001 e0613003 e3530000 
> 0a000009 e59d1004 e1a04002
> [11011.326690] 7fc4  e2433001 e2822004 e2811001 e58d1004 e5941000 
> e3510000 1affffca eafffff3
> [11011.334838] 7fe4  e1a04003 e1a02004 e1a0000a e28d1004 eb06c56f 
> e2504000 1affffc4 ebff6a9e
> [11011.343017] 8004  e1a00005 ea000006 e1a00006 ea000004 e5943000 
> e1500003 0affffdb eb002387
> [11011.351165] 8024  eaffffba e28dd014 e8bd8ff0 c0c47ccf e92d4070 
> e1a04002 e1a05003 eb00e075
> [11011.359344] 8044  e2506000 0a00001f e5963024 e3130001 03e04008 
> 0a000018 e59d3010 e1a02624
> [11011.367492] 8064  e5960090 e1822a05 e0944003 e2621001 e2a55000 
> e2544001 e1a03624 e2c55000
> [11011.375640]
> [11011.375640] SP: 0xec131e88:
> [11011.379912] 1e88  00000002 00000001 ec976dc0 edfa0c00 c0fba758 
> 00000000 c0106044 ec130000
> [11011.388061] 1ea8  00000000 12c02510 00000000 ec131f08 c0208004 
> c0342200 20000013 ffffffff
> [11011.396209] 1ec8  00000000 ffffffff ffffffff c0fba758 00000000 
> c0106044 ec130000 00000000
> [11011.404388] 1ee8  12c02510 c0211de0 ffffffff ffffffff 00000000 
> ec976dc0 edfa0c00 c03421d8
> [11011.412536] 1f08  ec976dc0 ec976e60 c0fba758 00000148 c0106044 
> c0254a88 00000000 ec976dc0
> [11011.420714] 1f28  edc0a500 c024bc8c 5719c47e d5c6f000 ed39ff10 
> ec96be00 d5f7a518 00000012
> [11011.428863] 1f48  d5c6f02e 00000000 ee202080 ec9a54a0 00000000 
> 00000002 00000000 00000000
> [11011.437011] 1f68  00002728 bfe01000 000012f4 00000000 5719c47e 
> 30ead7d6 5719c47e 30ead7d6
> [11011.445190]
> [11011.445190] R1: 0xec131dbc:
> [11011.449432] 1dbc  c0342200 ec131e80 e7f001f2 00000000 e7100000 
> c08fb0a8 00000000 12c02510
> [11011.457610] 1ddc  c01001e8 00000006 c020d47c 00000004 00000000 
> 00030001 c0342200 ec131e40
> [11011.465758] 1dfc  00000000 c101dae0 c020db38 ec976e94 ec131e3c 
> 00000000 00000000 00000000
> [11011.473907] 1e1c  0000000e ec976e90 00000000 ec131e90 ec976e94 
> 00000000 c0208004 00000002
> [11011.482085] 1e3c  00000000 00000000 c2d27cf4 ffffffff ec131e88 
> ffffffff ec976e90 00000002
> [11011.490234] 1e5c  00000000 ffffffff 00000002 c0f4a9e4 c0342204 
> 20000013 c08fb314 00000000
> [11011.498382] 1e7c  c08fb0a8 00000000 ec131e3c 00000002 00000001 
> ec976dc0 edfa0c00 c0fba758
> [11011.506560] 1e9c  00000000 c0106044 ec130000 00000000 12c02510 
> 00000000 ec131f08 c0208004
> [11011.514709]
> [11011.514709] R4: 0xec976d40:
> [11011.518981] 6d40  00000000 6f441ecd 00000000 00000000 00000000 
> 00000000 00000000 00000000
> [11011.527129] 6d60  00000001 00000411 00000000 00902c00 00000000 
> 00000000 ec976d78 ec976d78
> [11011.535277] 6d80  00000000 00000000 00000000 00000000 00000000 
> 00000000 c6b02be0 edfa0dec
> [11011.543456] 6da0  ec976da0 ec976da0 00000001 00000000 ec976db0 
> ec976db0 00000000 ec6338c0
> [11011.551604] 6dc0  00058180 00002728 00002728 00001000 ffffffff 
> ffffffff c0a2d400 edfa0800
> [11011.559753] 6de0  ec976e90 ed599570 00006add 00000000 00000000 
> 5719c47e 30ead7d6 5719c47e
> [11011.567931] 6e00  30ead7d6 5719c47f 0e5f0101 000b000b 00000000 
> 00000000 00000003 00000000
> [11011.576079] 6e20  000012f4 00000000 00000006 00000027 00000001 
> 00000000 ec976e38 ec976e38
> [11011.584258]
> [11011.584258] R5: 0xedfa0b80:
> [11011.588500] 0b80  00000000 00000000 00000000 00000000 00000000 
> 00000000 00000000 00000000
> [11011.596648] 0ba0  00000000 00000000 00000000 00000000 00000000 
> 00000000 00000000 00000000
> [11011.604827] 0bc0  00000000 00000000 00000000 00000000 00000000 
> 00000000 00000000 00000000
> [11011.612975] 0be0  00000000 00000000 00000000 00000000 00000000 
> 00000000 00000000 00000000
> [11011.621154] 0c00  edfa0800 ed801f80 cf5c7000 00000000 00000001 
> ee1226c0 edbe21b8 ed6a5600
> [11011.629302] 0c20  edfa0c00 00000000 002e4191 00000000 edfa0c00 
> 00000002 00000050 002e4191
> [11011.637450] 0c40  002e4191 c2a0a900 00000000 00000000 01020102 
> edfa0c54 edfa0c54 00000000
> [11011.645629] 0c60  edfa0c00 00000000 00176546 00000000 edfa0c00 
> 00000000 00000211 00176544
> [11011.653777]
> [11011.653777] R6: 0xc0fba6d8:
> [11011.658019] a6d8  00000006 c0c516a2 00000007 c0c5a20c 00000008 
> c0c655c3 00000009 c0c65657
> [11011.666198] a6f8  0000000a c0c655ca 0000000b c0c655b5 0000000c 
> c0c655e0 0000000d c0c655fc
> [11011.674346] a718  0000000e c0c651e6 0000000f c0c65618 00000010 
> c0c65623 00000011 c0c6562d
> [11011.682525] a738  00000012 c0c6563b 00000013 c0c655ed 00000014 
> c0c6564b 00000015 00000000
> [11011.690673] a758  c0348cb4 c0348c90 c03486bc c03420c4 c034af58 
> c0342118 c0348b68 00000000
> [11011.698821] a778  c03485b8 c034af3c c0343a10 c0343a18 c034b440 
> 00000000 c034883c 00000000
> [11011.707000] a798  00000000 00000000 00000000 00000000 00000000 
> c034881c c0a2d9a0 c0fba7c0
> [11011.715148] a7b8  00000000 00000000 c0fba9a4 c0fba98c c0fba974 
> c0fba95c c0fba944 c0fba92c
> [11011.723327]
> [11011.723327] R8: 0xc0105fc4:
> [11011.727630] 5fc4  e31a0602 1a00000a e31a0c07 1a000008 e3570d06 
> e24fee12 3798f107 e28d1008
> [11011.735717] 5fe4  e3a08000 e357080f e2270000 2a000fd2 ea025605 
> e1a02007 e28d1008 e3a00000
> [11011.743896] 6004  eb000889 e28fe014 e1a07000 e28d1008 e3570d06 
> 3891000f 3798f107 eaffffef
> [11011.752044] 6024  e5ad0008 e1a02007 e1a0100d e3a00001 eb00087d 
> eaffffb8 e320f000 c0f52d6c
> [11011.760192] 6044  c018e950 c0181aec c010666c c023f688 c023f6f0 
> c023e8f8 c023d998 c019b810
> [11011.768371] 6064  c023e920 c024c888 c024c6c4 c010667c c023e328 
> c019b810 c024c5c0 c023e530
> [11011.776519] 6084  c01c5234 c019b810 c019b810 c023ef44 c018b0e8 
> c02599dc c019b810 c01c52a4
> [11011.784698] 60a4  c01c5664 c019b810 c0187a00 c019b810 c019b810 
> c018fa20 c019b810 c019b810
> [11011.792846]
> [11011.792846] R9: 0xec12ff80:
> [11011.797088] ff80  00000001 00000000 ec12f480 c0d1e635 ec12f6d1 
> ec12f750 ec12ff10 00000000
> [11011.805266] ffa0  00000000 5dd9f7e8 c100dc08 00000000 00000000 
> 81a40002 00004e1b 00000000
> [11011.813415] ffc0  ec12f8c0 00000180 00000000 00000000 00000000 
> 00000000 00000000 00000000
> [11011.821593] ffe0  00000000 00000000 00000000 00000000 00000000 
> 00000000 00000000 00000000
> [11011.829742] 0000  00000002 00000002 00000000 c7902680 c0fac580 
> 00000003 00000015 c7902680
> [11011.837890] 0020  c4edaa80 ec130030 edf8d340 edfa9880 ebf57380 
> ec006000 ec131d0c ec131c70
> [11011.846068] 0040  c08f92ac 00000000 00000000 00000000 00000000 
> 00000000 01010000 00000000
> [11011.854217] 0060  ab7b3978 00000000 00000000 00000000 00000000 
> 00000000 00000000 00000000
> [11011.862395] Process pool-2-thread-1 (pid: 28613, stack limit = 
> 0xec1302f0)
> [11011.869231] Stack: (0xec131f08 to 0xec132000)
> [11011.873626] 1f00:                   ec976dc0 ec976e60 c0fba758 
> 00000148 c0106044 c0254a88
> [11011.881744] 1f20: 00000000 ec976dc0 edc0a500 c024bc8c 5719c47e 
> d5c6f000 ed39ff10 ec96be00
> [11011.889953] 1f40: d5f7a518 00000012 d5c6f02e 00000000 ee202080 
> ec9a54a0 00000000 00000002
> [11011.898101] 1f60: 00000000 00000000 00002728 bfe01000 000012f4 
> 00000000 5719c47e 30ead7d6
> [11011.906280] 1f80: 5719c47e 30ead7d6 5719c47e 30ead7d6 00001000 
> ffffffff b7e155d0 6f9172b0
> [11011.914367] 1fa0: b7c582c8 c0105ec0 b7e155d0 6f9172b0 ffffff9c 
> b7e155d0 00000000 00008180
> [11011.922607] 1fc0: b7e155d0 6f9172b0 b7c582c8 00000148 13109980 
> b7da8db8 00000000 12c02510
> [11011.930755] 1fe0: 13103cd0 ab7b2df0 b6d3a44d b6d430ac 60070010 
> ffffff9c 20202020 20202020
> [11011.938872] [<c0342200>] (f2fs_evict_inode+0xe8/0x35c) from 
> [<c0254a88>] (evict+0x94/0x158)
> [11011.947265] [<c0254a88>] (evict+0x94/0x158) from [<c024bc8c>] 
> (do_unlinkat+0xe8/0x128)
> [11011.955169] [<c024bc8c>] (do_unlinkat+0xe8/0x128) from [<c0105ec0>] 
> (ret_fast_syscall+0x0/0x30)
> [11011.963836] Code: 0a000099 e5943178 e3530000 0a000000 (e7f001f2)
> [11011.969848] ---[ end trace eeef49fbf1e7474d ]---
> [11011.974517] Kernel panic - not syncing: Fatal exception
> [11011.979674] CPU0: stopping
> [11011.982360] [<c010c1a4>] (unwind_backtrace+0x0/0x11c) from 
> [<c010b284>] (handle_IPI+0x108/0x1f0)
> [11011.991180] [<c010b284>] (handle_IPI+0x108/0x1f0) from [<c010054c>] 
> (gic_handle_irq+0x104/0x110)
> [11011.999938] [<c010054c>] (gic_handle_irq+0x104/0x110) from 
> [<c08fb000>] (__irq_svc+0x40/0x70)
> [11012.008453] Exception stack(0xc219fe28 to 0xc219fe70)
> [11012.013427] fe20:                   00000001 c011639c fa002f00 
> 00000001 c4ebd000 c0f1e1c0
> [11012.021636] fe40: 00000003 c0f1b000 00000000 00000001 c0a09724 
> 03fa2000 f1c1f380 c219fe70
> [11012.029815] fe60: c0177a40 c01c4b3c 20000013 ffffffff
> [11012.034789] [<c08fb000>] (__irq_svc+0x40/0x70) from [<c01c4b3c>] 
> (smp_call_function_many+0x220/0x250)
> [11012.044036] [<c01c4b3c>] (smp_call_function_many+0x220/0x250) from 
> [<c01c4bb0>] (smp_call_function+0x44/0x84)
> [11012.053954] [<c01c4bb0>] (smp_call_function+0x44/0x84) from 
> [<c067c660>] (cpuidle_latency_notify+0x14/0x20)
> [11012.063659] [<c067c660>] (cpuidle_latency_notify+0x14/0x20) from 
> [<c08fc96c>] (notifier_call_chain+0x40/0x68)
> [11012.073516] [<c08fc96c>] (notifier_call_chain+0x40/0x68) from 
> [<c019f8c8>] (__blocking_notifier_call_chain+0x40/0x58)
> [11012.084136] [<c019f8c8>] (__blocking_notifier_call_chain+0x40/0x58) 
> from [<c019f8f4>] (blocking_notifier_call_chain+0x14/0x1c)
> [11012.095519] [<c019f8f4>] (blocking_notifier_call_chain+0x14/0x1c) 
> from [<c01b58b4>] (pm_qos_update_target+0x110/0x124)
> [11012.106200] [<c01b58b4>] (pm_qos_update_target+0x110/0x124) from 
> [<c0694ef0>] (msmsdcc_disable+0x24/0x11c)
> [11012.115844] [<c0694ef0>] (msmsdcc_disable+0x24/0x11c) from 
> [<c067e81c>] (mmc_release_host+0x44/0xa8)
> [11012.124938] [<c067e81c>] (mmc_release_host+0x44/0xa8) from 
> [<c068f5a4>] (mmc_blk_issue_rq+0x57c/0x608)
> [11012.134246] [<c068f5a4>] (mmc_blk_issue_rq+0x57c/0x608) from 
> [<c068f6d8>] (mmc_queue_thread+0xa8/0x124)
> [11012.143615] [<c068f6d8>] (mmc_queue_thread+0xa8/0x124) from 
> [<c019a038>] (kthread+0xa0/0xac)
> [11012.151977] [<c019a038>] (kthread+0xa0/0xac) from [<c01069d0>] 
> (kernel_thread_exit+0x0/0x8)
> [11012.160369] CPU1: stopping
> [11012.160369] &@running_process@cpu0:*mmcqd/0*
> [11012.167327] [<c010c1a4>] (unwind_backtrace+0x0/0x11c) from 
> [<c010b284>] (handle_IPI+0x108/0x1f0)
> [11012.176086] [<c010b284>] (handle_IPI+0x108/0x1f0) from [<c010054c>] 
> (gic_handle_irq+0x104/0x110)
> [11012.184783] [<c010054c>] (gic_handle_irq+0x104/0x110) from 
> [<c08fb000>] (__irq_svc+0x40/0x70)
> [11012.193359] Exception stack(0xc008bf58 to 0xc008bfa0)
> [11012.198394] bf40:                                                     
>    00000000 00000003
> [11012.206481] bf60: c4ec6918 00000000 c4ec6900 00000000 00000001 
> c11b95dc c008a030 c101d838
> [11012.214690] bf80: 00000003 c0f61c40 00000000 c008bfa0 c01508c4 
> c0157170 68000013 ffffffff
> [11012.222869] [<c08fb000>] (__irq_svc+0x40/0x70) from [<c0157170>] 
> (msm_cpuidle_enter+0x40/0x48)
> [11012.231475] [<c0157170>] (msm_cpuidle_enter+0x40/0x48) from 
> [<c067c438>] (cpuidle_enter+0x14/0x18)
> [11012.240356] [<c067c438>] (cpuidle_enter+0x14/0x18) from [<c067c958>] 
> (cpuidle_idle_call+0x1c0/0x364)
> [11012.249511] [<c067c958>] (cpuidle_idle_call+0x1c0/0x364) from 
> [<c0106d9c>] (cpu_idle+0x60/0xec)
> [11012.258208] [<c0106d9c>] (cpu_idle+0x60/0xec) from [<80ae6b34>] 
> (0x80ae6b34)
> [11012.265227] CPU2: stopping
> [11012.265227] &@running_process@cpu1:*swapper/1*
> [11012.272308] [<c010c1a4>] (unwind_backtrace+0x0/0x11c) from 
> [<c010b284>] (handle_IPI+0x108/0x1f0)
> [11012.281127] [<c010b284>] (handle_IPI+0x108/0x1f0) from [<c010054c>] 
> (gic_handle_irq+0x104/0x110)
> [11012.289886] [<c010054c>] (gic_handle_irq+0x104/0x110) from 
> [<c08fb000>] (__irq_svc+0x40/0x70)
> [11012.298339] Exception stack(0xc0095f58 to 0xc0095fa0)
> [11012.303405] 5f40:                                                     
>    00000000 00000003
> [11012.311584] 5f60: c4ed0918 00000000 c4ed0900 00000000 00000002 
> c11b95dc c0094030 c101d838
> [11012.319671] 5f80: 00000003 c0f61c40 00000000 c0095fa0 c01508c4 
> c0157170 60000013 ffffffff
> [11012.327911] [<c08fb000>] (__irq_svc+0x40/0x70) from [<c0157170>] 
> (msm_cpuidle_enter+0x40/0x48)
> [11012.336516] [<c0157170>] (msm_cpuidle_enter+0x40/0x48) from 
> [<c067c438>] (cpuidle_enter+0x14/0x18)
> [11012.345458] [<c067c438>] (cpuidle_enter+0x14/0x18) from [<c067c958>] 
> (cpuidle_idle_call+0x1c0/0x364)
> [11012.354491] [<c067c958>] (cpuidle_idle_call+0x1c0/0x364) from 
> [<c0106d9c>] (cpu_idle+0x60/0xec)
> [11012.363250] [<c0106d9c>] (cpu_idle+0x60/0xec) from [<80ae6b34>] 
> (0x80ae6b34)
> [11012.370269] &@running_process@cpu2:*swapper/2*
> [11012.370269] wcnss_8960: crash shutdown : 0
> [11012.470550] &@panic_name@:*pool-2-thread-1*
> [11012.473968] Rebooting in 5 seconds..
> [11017.478759] Restarting Linux version 3.4.0-cm-ge347aa9-00623-g72f4111 
> (admin@buildbot) (gcc version 4.8 (GCC) ) #1 SMP PREEMPT Thu Apr 21 
> 11:46:28 CEST 2016
> [11017.478759]
> [11017.493316]
> [11017.494811] Restarting Linux version 3.4.0-cm-ge347aa9-00623-g72f4111 
> (admin@buildbot) (gcc version 4.8 (GCC) ) #1 SMP PREEMPT Thu Apr 21 
> 11:46:28 CEST 2016
> [11017.494811]
> [11017.510680] Going down for restart now
> 
> ------------------------------------------------------------------------------
> Find and fix application performance issues faster with Applications Manager
> Applications Manager provides deep performance insights into multiple tiers of
> your business applications. It resolves application problems quickly and
> reduces your MTTR. Get your free trial!
> https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 

------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
