From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [oops, 4.4-rc8] warn + oops during generic/204
Date: Fri, 22 Jan 2016 09:42:14 +0800
Message-ID: <20160122014214.GA53329@jaegeuk>
References: <20160120213102.GF20456@dastard>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aMQkM-0000Eh-5f
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 22 Jan 2016 01:42:42 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aMQkK-0006cF-Cj for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 22 Jan 2016 01:42:41 +0000
Content-Disposition: inline
In-Reply-To: <20160120213102.GF20456@dastard>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Dave Chinner <david@fromorbit.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Dave,

Thank you for pointing this out.
Actually I turned off 204 in my test cases, so I couldn't get this before.

I think mkfs.f2fs calculates the number of blocks for users incorrectly.
Let us investigate and resolve this issue.

Thanks,

On Thu, Jan 21, 2016 at 08:31:02AM +1100, Dave Chinner wrote:
> Hi f2fs folks,
> 
> I just ran xfstests on f2fs using defaults and a pair of 4GB ram
> disks for the test and scratch devices, and it hard locked the
> machine with this failure in generic/204:
> 
> [  125.141471] run fstests generic/204 at 2016-01-21 08:24:22
> [  127.582183] ------------[ cut here ]------------
> [  127.583225] WARNING: CPU: 10 PID: 1224 at fs/f2fs/segment.c:916 new_curseg+0x296/0x380()
> [  127.584904] Modules linked in:
> [  127.585558] CPU: 10 PID: 1224 Comm: kworker/u32:3 Not tainted 4.4.0-rc8-dgc+ #631
> [  127.587057] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Debian-1.8.2-1 04/01/2014
> [  127.589329] Workqueue: writeback wb_workfn (flush-1:1)
> [  127.590966]  ffffffff82251760 ffff88042a163888 ffffffff817a25b9 0000000000000000
> [  127.593762]  ffff88042a1638c0 ffffffff810aa006 0000000000000002 0000000000000001
> [  127.596839]  ffff8804260e1800 000000000000002d ffff880429e4a800 ffff88042a1638d0
> [  127.599825] Call Trace:
> [  127.600832]  [<ffffffff817a25b9>] dump_stack+0x4b/0x72
> [  127.602821]  [<ffffffff810aa006>] warn_slowpath_common+0x86/0xc0
> [  127.605184]  [<ffffffff810aa0fa>] warn_slowpath_null+0x1a/0x20
> [  127.607337]  [<ffffffff816ee4b6>] new_curseg+0x296/0x380
> [  127.608980]  [<ffffffff816ee91d>] allocate_segment_by_default+0x1dd/0x1e0
> [  127.611439]  [<ffffffff816eec6d>] allocate_data_block+0x15d/0x2e0
> [  127.613590]  [<ffffffff816eefad>] do_write_page+0x1bd/0x280
> [  127.615503]  [<ffffffff816ef0f3>] write_node_page+0x23/0x30
> [  127.617443]  [<ffffffff816e7ce5>] f2fs_write_node_page+0x125/0x240
> [  127.619483]  [<ffffffff816e9b31>] sync_node_pages+0x401/0x600
> [  127.621388]  [<ffffffff816e9e38>] f2fs_write_node_pages+0x108/0x130
> [  127.623451]  [<ffffffff811941c1>] do_writepages+0x21/0x30
> [  127.625205]  [<ffffffff811feb25>] __writeback_single_inode+0x45/0x330
> [  127.627304]  [<ffffffff811ff2bb>] writeback_sb_inodes+0x25b/0x4d0
> [  127.629214]  [<ffffffff811ff788>] wb_writeback+0xf8/0x2d0
> [  127.630862]  [<ffffffff8120251e>] wb_workfn+0xfe/0x3b0
> [  127.632464]  [<ffffffff81dcba7e>] ? _raw_spin_unlock_irq+0xe/0x30
> [  127.634289]  [<ffffffff810cedfb>] ? finish_task_switch+0x8b/0x220
> [  127.636069]  [<ffffffff810c17ce>] process_one_work+0x14e/0x410
> [  127.637877]  [<ffffffff810c1dde>] worker_thread+0x4e/0x460
> [  127.639569]  [<ffffffff810c1d90>] ? rescuer_thread+0x300/0x300
> [  127.641284]  [<ffffffff810c1d90>] ? rescuer_thread+0x300/0x300
> [  127.642925]  [<ffffffff810c7176>] kthread+0xe6/0x100
> [  127.644325]  [<ffffffff810c7090>] ? kthread_create_on_node+0x190/0x190
> [  127.646032]  [<ffffffff81dcc30f>] ret_from_fork+0x3f/0x70
> [  127.647504]  [<ffffffff810c7090>] ? kthread_create_on_node+0x190/0x190
> [  127.649285] ---[ end trace 2107b831b703fa3a ]---
> [  127.650532] ------------[ cut here ]------------
> [  127.651780] WARNING: CPU: 10 PID: 1224 at fs/f2fs/segment.c:955 new_curseg+0x358/0x380()
> [  127.653918] Modules linked in:
> [  127.654752] CPU: 10 PID: 1224 Comm: kworker/u32:3 Tainted: G        W       4.4.0-rc8-dgc+ #631
> [  127.657046] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Debian-1.8.2-1 04/01/2014
> [  127.659372] Workqueue: writeback wb_workfn (flush-1:1)
> [  127.660791]  ffffffff82251760 ffff88042a163888 ffffffff817a25b9 0000000000000000
> [  127.662825]  ffff88042a1638c0 ffffffff810aa006 000000000000002d 0000000000000001
> [  127.664791]  ffff8804260e1800 ffff880429e4a800 ffff8804260e1800 ffff88042a1638d0
> [  127.666679] Call Trace:
> [  127.667287]  [<ffffffff817a25b9>] dump_stack+0x4b/0x72
> [  127.668562]  [<ffffffff810aa006>] warn_slowpath_common+0x86/0xc0
> [  127.670025]  [<ffffffff810aa0fa>] warn_slowpath_null+0x1a/0x20
> [  127.671455]  [<ffffffff816ee578>] new_curseg+0x358/0x380
> [  127.672761]  [<ffffffff816ee91d>] allocate_segment_by_default+0x1dd/0x1e0
> [  127.674397]  [<ffffffff816eec6d>] allocate_data_block+0x15d/0x2e0
> [  127.675918]  [<ffffffff816eefad>] do_write_page+0x1bd/0x280
> [  127.677254]  [<ffffffff816ef0f3>] write_node_page+0x23/0x30
> [  127.678510]  [<ffffffff816e7ce5>] f2fs_write_node_page+0x125/0x240
> [  127.679930]  [<ffffffff816e9b31>] sync_node_pages+0x401/0x600
> [  127.681264]  [<ffffffff816e9e38>] f2fs_write_node_pages+0x108/0x130
> [  127.682729]  [<ffffffff811941c1>] do_writepages+0x21/0x30
> [  127.684009]  [<ffffffff811feb25>] __writeback_single_inode+0x45/0x330
> [  127.685532]  [<ffffffff811ff2bb>] writeback_sb_inodes+0x25b/0x4d0
> [  127.686913]  [<ffffffff811ff788>] wb_writeback+0xf8/0x2d0
> [  127.688223]  [<ffffffff8120251e>] wb_workfn+0xfe/0x3b0
> [  127.689370]  [<ffffffff81dcba7e>] ? _raw_spin_unlock_irq+0xe/0x30
> [  127.690696]  [<ffffffff810cedfb>] ? finish_task_switch+0x8b/0x220
> [  127.692054]  [<ffffffff810c17ce>] process_one_work+0x14e/0x410
> [  127.693361]  [<ffffffff810c1dde>] worker_thread+0x4e/0x460
> [  127.694569]  [<ffffffff810c1d90>] ? rescuer_thread+0x300/0x300
> [  127.695905]  [<ffffffff810c1d90>] ? rescuer_thread+0x300/0x300
> [  127.697110]  [<ffffffff810c7176>] kthread+0xe6/0x100
> [  127.698083]  [<ffffffff810c7090>] ? kthread_create_on_node+0x190/0x190
> [  127.699388]  [<ffffffff81dcc30f>] ret_from_fork+0x3f/0x70
> [  127.700484]  [<ffffffff810c7090>] ? kthread_create_on_node+0x190/0x190
> [  127.701743] ---[ end trace 2107b831b703fa3b ]---
> [  127.702644] BUG: unable to handle kernel NULL pointer dereference at           (null)
> [  127.704234] IP: [<ffffffff816ec3d8>] update_sit_entry+0xe8/0x270
> [  127.705434] PGD 0 
> [  127.705859] Oops: 0000 [#1] PREEMPT SMP 
> [  127.706687] Modules linked in:
> [  127.707323] CPU: 10 PID: 1224 Comm: kworker/u32:3 Tainted: G        W       4.4.0-rc8-dgc+ #631
> [  127.709037] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Debian-1.8.2-1 04/01/2014
> [  127.710743] Workqueue: writeback wb_workfn (flush-1:1)
> [  127.711798] task: ffff88042a144580 ti: ffff88042a160000 task.ti: ffff88042a160000
> [  127.713260] RIP: 0010:[<ffffffff816ec3d8>]  [<ffffffff816ec3d8>] update_sit_entry+0xe8/0x270
> [  127.714921] RSP: 0018:ffff88042a163908  EFLAGS: 00010202
> [  127.715952] RAX: 0000000000000000 RBX: ffff8804260e1800 RCX: 0000000000000007
> [  127.717389] RDX: ffff8800ba868540 RSI: 0000000000000000 RDI: 0000000000000001
> [  127.718768] RBP: ffff88042a163948 R08: ffff88042a163a19 R09: ffff880429e4a800
> [  127.720157] R10: 0000000000000000 R11: ffff8800ba8680c0 R12: ffff8800bb1849d8
> [  127.721530] R13: 0000000000000080 R14: 0000000000000001 R15: 000000000000002d
> [  127.722902] FS:  0000000000000000(0000) GS:ffff88043fd40000(0000) knlGS:0000000000000000
> [  127.724469] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> [  127.725579] CR2: 0000000000000000 CR3: 0000000002371000 CR4: 00000000000006e0
> [  127.726961] Stack:
> [  127.727376]  0000002dbb00f980 ffff8800ba868540 0000000000000000 ffff8804260e1800
> [  127.728892]  0000000000006a00 0000000000003e40 ffff8800bb00f980 0000000000000004
> [  127.730411]  ffff88042a163970 ffffffff816edd94 0000000000000180 ffff8804260e1800
> [  127.731918] Call Trace:
> [  127.732403]  [<ffffffff816edd94>] refresh_sit_entry+0x24/0xc0
> [  127.733539]  [<ffffffff816eec7e>] allocate_data_block+0x16e/0x2e0
> [  127.734724]  [<ffffffff816eefad>] do_write_page+0x1bd/0x280
> [  127.735810]  [<ffffffff816ef0f3>] write_node_page+0x23/0x30
> [  127.736898]  [<ffffffff816e7ce5>] f2fs_write_node_page+0x125/0x240
> [  127.738103]  [<ffffffff816e9b31>] sync_node_pages+0x401/0x600
> [  127.739241]  [<ffffffff816e9e38>] f2fs_write_node_pages+0x108/0x130
> [  127.740462]  [<ffffffff811941c1>] do_writepages+0x21/0x30
> [  127.741520]  [<ffffffff811feb25>] __writeback_single_inode+0x45/0x330
> [  127.742787]  [<ffffffff811ff2bb>] writeback_sb_inodes+0x25b/0x4d0
> [  127.743977]  [<ffffffff811ff788>] wb_writeback+0xf8/0x2d0
> [  127.745063]  [<ffffffff8120251e>] wb_workfn+0xfe/0x3b0
> [  127.746070]  [<ffffffff81dcba7e>] ? _raw_spin_unlock_irq+0xe/0x30
> [  127.747245]  [<ffffffff810cedfb>] ? finish_task_switch+0x8b/0x220
> [  127.748469]  [<ffffffff810c17ce>] process_one_work+0x14e/0x410
> [  127.749472]  [<ffffffff810c1dde>] worker_thread+0x4e/0x460
> [  127.750419]  [<ffffffff810c1d90>] ? rescuer_thread+0x300/0x300
> [  127.751429]  [<ffffffff810c1d90>] ? rescuer_thread+0x300/0x300
> [  127.752464]  [<ffffffff810c7176>] kthread+0xe6/0x100
> [  127.753324]  [<ffffffff810c7090>] ? kthread_create_on_node+0x190/0x190
> [  127.754449]  [<ffffffff81dcc30f>] ret_from_fork+0x3f/0x70
> [  127.755384]  [<ffffffff810c7090>] ? kthread_create_on_node+0x190/0x190
> [  127.756513] Code: 44 24 30 48 8b 53 38 48 8b 12 48 89 82 a8 00 00 00 44 89 e8 41 bd 01 00 00 00 c1 e8 03 41 d3 e5 48 89 c6 49 03 74 24 08 45 85 f6 <0f> be 16 0f 8e  
> [  127.760859] RIP  [<ffffffff816ec3d8>] update_sit_entry+0xe8/0x270
> [  127.761929]  RSP <ffff88042a163908>
> [  127.762537] CR2: 0000000000000000
> [  127.763118] ---[ end trace 2107b831b703fa3c ]---
> 
> It's completely repeatable.
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 
> ------------------------------------------------------------------------------
> Site24x7 APM Insight: Get Deep Visibility into Application Performance
> APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
> Monitor end-to-end web transactions and take corrective actions now
> Troubleshoot faster and improve end-user experience. Signup Now!
> http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
