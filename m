From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: Out of memory mounting 8 TB volume with 3.5 GiB of
 memory
Date: Mon, 25 Jul 2016 11:01:40 -0700
Message-ID: <20160725180140.GA56718@jaegeuk>
References: <20160724194630.GF4159@vip.cybercity.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bRkCQ-0007eW-If
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 25 Jul 2016 18:01:54 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bRkCP-0001ni-5t
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 25 Jul 2016 18:01:54 +0000
Content-Disposition: inline
In-Reply-To: <20160724194630.GF4159@vip.cybercity.dk>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Rask Ingemann Lambertsen <ccc94453@mail.jubii.dk>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi,

On Sun, Jul 24, 2016 at 09:46:32PM +0200, Rask Ingemann Lambertsen wrote:
> Hello,
> 
>    I have one of those 8 TB shingled magnetic recording hard disk drives and
> thought F2FS would be a good choice of file system because of the need to
> write sequentially to the HDD.  I passed -s 128 to mkfs.f2fs to hopefully
> match the F2FS section size to the zone size of the HDD. When trying to mount
> the volume on a system with 3.5 GiB of memory, the system runs out of memory
> with a stream of oom-killer messages like the one below. Is it expected
> behaviour of F2FS to require this much memory?

Yes, I've double-checked that f2fs needs about 100 MB/TB to manage some data
structures for space management in main memory. I just found out there is
30MB/TB which is unnecessary memory consumption for SMR device tho.
Let me think how to mitigate this further.

Thanks,

> 
> [50885.725754] mount invoked oom-killer: gfp_mask=0x26000c0(GFP_KERNEL|__GFP_NOTRACK), order=0, oom_score_adj=0
> [50885.735755] CPU: 0 PID: 8301 Comm: mount Not tainted 4.7.0-rc5-01511-g19f4af3-dirty #24
> [50885.743837] Hardware name: Allwinner sun9i Family
> [50885.748635] [<c011089c>] (unwind_backtrace) from [<c010c7e0>] (show_stack+0x20/0x24)
> [50885.756474] [<c010c7e0>] (show_stack) from [<c042bef8>] (dump_stack+0x94/0xa8)
> [50885.763790] [<c042bef8>] (dump_stack) from [<c0230b7c>] (dump_header+0x60/0x180)
> [50885.771280] [<c0230b7c>] (dump_header) from [<c01e62dc>] (oom_kill_process+0x37c/0x4f4)
> [50885.779379] [<c01e62dc>] (oom_kill_process) from [<c01e66b4>] (out_of_memory+0x1e8/0x334)
> [50885.787654] [<c01e66b4>] (out_of_memory) from [<c01eb12c>] (__alloc_pages_nodemask+0xcb8/0xcf4)
> [50885.796453] [<c01eb12c>] (__alloc_pages_nodemask) from [<c022a9c0>] (new_slab+0x334/0x378)
> [50885.804815] [<c022a9c0>] (new_slab) from [<c022c184>] (___slab_alloc.constprop.9+0x24c/0x2e0)
> [50885.813440] [<c022c184>] (___slab_alloc.constprop.9) from [<c022c708>] (kmem_cache_alloc_trace+0x194/0x1cc)
> [50885.823292] [<c022c708>] (kmem_cache_alloc_trace) from [<c03cd2c4>] (build_sit_info+0x134/0x324)
> [50885.832182] [<c03cd2c4>] (build_sit_info) from [<c03d1c44>] (build_segment_manager+0x108/0xcac)
> [50885.840988] [<c03d1c44>] (build_segment_manager) from [<c03b7330>] (f2fs_fill_super+0x710/0xf94)
> [50885.849877] [<c03b7330>] (f2fs_fill_super) from [<c0237238>] (mount_bdev+0x174/0x19c)
> [50885.857803] [<c0237238>] (mount_bdev) from [<c03b5850>] (f2fs_mount+0x28/0x30)
> [50885.865114] [<c03b5850>] (f2fs_mount) from [<c0238040>] (mount_fs+0x24/0xb4)
> [50885.872250] [<c0238040>] (mount_fs) from [<c025496c>] (vfs_kern_mount+0x58/0x110)
> [50885.879826] [<c025496c>] (vfs_kern_mount) from [<c0257ae4>] (do_mount+0x1b8/0xcb4)
> [50885.887489] [<c0257ae4>] (do_mount) from [<c02589a4>] (SyS_mount+0xa4/0xcc)
> [50885.894541] [<c02589a4>] (SyS_mount) from [<c0107fc0>] (ret_fast_syscall+0x0/0x3c)
> [50885.902261] Mem-Info:
> [50885.904598] active_anon:15340 inactive_anon:24606 isolated_anon:0
>                 active_file:4533 inactive_file:4907 isolated_file:0
>                 unevictable:0 dirty:512 writeback:0 unstable:0
>                 slab_reclaimable:2157 slab_unreclaimable:152930
>                 mapped:5677 shmem:37585 pagetables:126 bounce:0
>                 free:678464 free_pcp:294 free_cma:0
> [50885.938521] Normal free:3328kB min:3448kB low:4308kB high:5168kB active_anon:9424kB inactive_anon:13976kB active_file:844kB inactive_file:2016kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:786432kB managed:745120kB mlocked:0kB dirty:2040kB writeback:0kB mapped:1072kB shmem:22752kB slab_reclaimable:8628kB slab_unreclaimable:611720kB kernel_stack:1120kB pagetables:52kB unstable:0kB bounce:0kB free_pcp:504kB local_pcp:504kB free_cma:0kB writeback_tmp:0kB pages_scanned:19160 all_unreclaimable? yes
> [50885.984181] lowmem_reserve[]: 0 22527 22527
> [50885.988563] HighMem free:2710528kB min:512kB low:3852kB high:7192kB active_anon:51936kB inactive_anon:84448kB active_file:17288kB inactive_file:17612kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:2883580kB managed:2883580kB mlocked:0kB dirty:8kB writeback:0kB mapped:21636kB shmem:127588kB slab_reclaimable:0kB slab_unreclaimable:0kB kernel_stack:0kB pagetables:452kB unstable:0kB bounce:0kB free_pcp:672kB local_pcp:672kB free_cma:0kB writeback_tmp:0kB pages_scanned:0 all_unreclaimable? no
> [50886.033619] lowmem_reserve[]: 0 0 0
> [50886.037251] Normal: 104*4kB (ME) 62*8kB (ME) 71*16kB (ME) 20*32kB (UME) 6*64kB (UME) 2*128kB (UE) 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 3328kB
> [50886.051120] HighMem: 316*4kB (UM) 1330*8kB (UM) 2174*16kB (UM) 1057*32kB (UM) 846*64kB (UM) 336*128kB (UM) 148*256kB (UM) 43*512kB (M) 11*1024kB (M) 4*2048kB (M) 599*4096kB (UM) = 2710528kB
> [50886.068617] 47030 total pagecache pages
> [50886.072498] 0 pages in swap cache
> [50886.075890] Swap cache stats: add 0, delete 0, find 0/0
> [50886.081170] Free swap  = 0kB
> [50886.084084] Total swap = 0kB
> [50886.087035] 917503 pages RAM
> [50886.089950] 720895 pages HighMem/MovableOnly
> [50886.094264] 10328 pages reserved
> [50886.097564] [ pid ]   uid  tgid total_vm      rss nr_ptes nr_pmds swapents oom_score_adj name
> [50886.097618] [  162]   101   162     1311      713       7       0        0          -900 dbus-daemon
> [50886.097646] [  169]     0   169     2073      997       7       0        0         -1000 sshd
> [50886.097673] [  209]     0   209      502      315       4       0        0             0 agetty
> [50886.097702] [ 3473]     0  3473     2665      574       6       0        0         -1000 systemd-udevd
> [50886.097734] [ 8177]     0  8177     3432     1435       9       0        0             0 systemd-journal
> [50886.097761] [ 8180]     0  8180     1430      808       5       0        0             0 systemd-logind
> [50886.097789] [ 8182]     0  8182     1058      309       5       0        0             0 cgmanager
> [50886.097815] [ 8183]     0  8183     1249      584       6       0        0             0 login
> [50886.097842] [ 8197]     0  8197     1397      653       5       0        0             0 rpcbind
> [50886.097869] [ 8204]     0  8204    19011     3076      18       0        0             0 NetworkManager
> [50886.097896] [ 8205]     0  8205      646       47       4       0        0             0 rpc.idmapd
> [50886.097922] [ 8208]     0  8208     1069      181       5       0        0             0 rpc.mountd
> [50886.097952] [ 8239]     0  8239     8485     1105      10       0        0             0 polkitd
> [50886.097978] [ 8282]     0  8282     1820     1000       8       0        0             0 systemd
> [50886.098004] [ 8286]     0  8286     6605      361       9       0        0             0 (sd-pam)
> [50886.098030] [ 8292]     0  8292      740      570       4       0        0             0 bash
> [50886.098057] [ 8301]     0  8301      700      411       5       0        0             0 mount
> [50886.098078] Out of memory: Kill process 8204 (NetworkManager) score 3 or sacrifice child
> [50886.106341] Killed process 8204 (NetworkManager) total-vm:76044kB, anon-rss:1760kB, file-rss:10544kB, shmem-rss:0kB
> 
> [...]
> 
> [50898.530822] SLUB: Unable to allocate memory on node -1, gfp=0x24080c0(GFP_KERNEL|__GFP_ZERO)
> [50898.539344]   cache: kmalloc-64, object size: 64, buffer size: 64, default order: 0, min order: 0
> [50898.548302]   node 0: slabs: 152849, objs: 9782336, free: 0
> [50898.553969] F2FS-fs (sdb2): Failed to initialize F2FS segment manager
> 
> -- 
> Rask Ingemann Lambertsen
> 
> ------------------------------------------------------------------------------
> What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
> patterns at an interface-level. Reveals which users, apps, and protocols are 
> consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
> J-Flow, sFlow and other flows. Make informed decisions using capacity planning
> reports.http://sdm.link/zohodev2dev
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity planning
reports.http://sdm.link/zohodev2dev
