From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 203165] New: Kernel panic - not syncing: corrupted
 stack end detected inside scheduler
Date: Fri, 05 Apr 2019 23:08:41 +0000
Message-ID: <bug-203165-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1hCXx9-0002pV-C8
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 05 Apr 2019 23:08:55 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hCXx5-000ptN-6l
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 05 Apr 2019 23:08:55 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 88CEA1FE8A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  5 Apr 2019 23:08:45 +0000 (UTC)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

https://bugzilla.kernel.org/show_bug.cgi?id=203165

            Bug ID: 203165
           Summary: Kernel panic - not syncing: corrupted stack end
                    detected inside scheduler
           Product: File System
           Version: 2.5
    Kernel Version: 5.0.0
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: f2fs
          Assignee: filesystem_f2fs@kernel-bugs.kernel.org
          Reporter: jungyeon@gatech.edu
        Regression: No

- Overview
After mounting crafted image and running the attached program, I got this
errors while running attached program.
It seems that errors above that panic keep changing.

- Produces
mkdir test
mount -t f2fs tmp.img test 
gcc poc_02.c
cp a.out test
cd test
./a.out

- Messages
[   42.863932] general protection fault: 0000 [#1] SMP PTI
[   42.864763] CPU: 0 PID: 1111 Comm: a.out Not tainted 5.0.0 #3
[   42.865619] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   42.866974] RIP: 0010:kmem_cache_alloc+0x88/0x1d0
[   42.867646] Code: 65 49 8b 50 08 65 4c 03 05 8d e6 99 7b 4d 8b 28 4d 85 ed
0f 84 10 01 00 00 41 8b 5f 20 48 8d 4a 01 49 8b 3f 4c 89 e8 4c 01 eb <48> 33 1b
49 33 9f 38 01 00 00 65 48 0f c7 0f 0f 94 c0 84 c0 74 bd
[   42.870271] RSP: 0018:ffffb668010ef758 EFLAGS: 00010286
[   42.871029] RAX: fc71e573939ee6a6 RBX: fc71e573939ee6a6 RCX:
0000000000002dec
[   42.872012] RDX: 0000000000002deb RSI: 0000000000411200 RDI:
0000000000027660
[   42.873065] RBP: ffffb668010ef788 R08: ffff9c2277a27660 R09:
0000000000000001
[   42.874099] R10: 00000000fffffffb R11: 0000000000000000 R12:
0000000000411200
[   42.875095] R13: fc71e573939ee6a6 R14: ffff9c2277413480 R15:
ffff9c2277413480
[   42.876079] FS:  00007efdbbe20700(0000) GS:ffff9c2277a00000(0000)
knlGS:0000000000000000
[   42.877261] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   42.878056] CR2: 00007efdbb93b4c0 CR3: 0000000234fd0003 CR4:
00000000001606f0
[   42.879040] Call Trace:
[   42.879394]  ? mempool_alloc_slab+0x15/0x20
[   42.879980]  mempool_alloc_slab+0x15/0x20
[   42.880542]  mempool_alloc+0x73/0x180
[   42.881114]  bio_alloc_bioset+0x1ac/0x210
[   42.881702]  ? update_sit_entry+0xc0/0x420
[   42.882296]  __bio_alloc+0x3c/0xe0
[   42.882794]  f2fs_submit_page_write+0x1aa/0x5c0
[   42.883451]  do_write_page+0x9c/0x170
[   42.883985]  f2fs_do_write_node_page+0x3a/0xb0
[   42.884629]  __write_node_page+0x289/0x530
[   42.885275]  f2fs_sync_node_pages+0x6b6/0x750
[   42.885907]  ? vfs_getxattr_alloc+0xc6/0x120
[   42.886560]  ? iput+0x76/0x210
[   42.887010]  ? f2fs_sync_inode_meta+0x3f/0x100
[   42.887654]  block_operations+0x1fc/0x2f0
[   42.888238]  f2fs_write_checkpoint+0xf2/0x11f0
[   42.888910]  ? f2fs_write_checkpoint+0xf2/0x11f0
[   42.889600]  ? f2fs_mark_inode_dirty_sync.part.28+0x16/0x30
[   42.890401]  ? f2fs_mark_inode_dirty_sync+0x1e/0x20
[   42.891104]  ? f2fs_delete_entry+0x171/0x2f0
[   42.891722]  ? f2fs_rename2+0xbbd/0x1110
[   42.892291]  f2fs_sync_fs+0xb4/0x140
[   42.892813]  f2fs_do_sync_file+0x1bd/0x8e0
[   42.893457]  f2fs_sync_file+0x31/0x40
[   42.894007]  vfs_fsync_range+0x48/0x80
[   42.894553]  do_fsync+0x3d/0x70
[   42.895014]  __x64_sys_fsync+0x14/0x20
[   42.895561]  do_syscall_64+0x5a/0x110
[   42.896096]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   42.896823] RIP: 0033:0x7efdbb93b4d9
[   42.897404] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d 8f 29 2c 00 f7 d8 64 89 01 48
[   42.900056] RSP: 002b:00007ffef37f5378 EFLAGS: 00000217 ORIG_RAX:
000000000000004a
[   42.901188] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007efdbb93b4d9
[   42.902207] RDX: 00007efdbb93b4d9 RSI: 00007efdbb93b4d9 RDI:
0000000000000003
[   42.903226] RBP: 00007ffef37f9510 R08: 00007ffef37f95f8 R09:
00007ffef37f95f8
[   42.904243] R10: 00007ffef37f95f8 R11: 0000000000000217 R12:
00000000004004e0
[   42.905279] R13: 00007ffef37f95f0 R14: 0000000000000000 R15:
0000000000000000
[   42.906297] Modules linked in:
[   42.906759] ---[ end trace 0f31ea6120b7b9e9 ]---
[   42.907454] RIP: 0010:kmem_cache_alloc+0x88/0x1d0
[   42.908137] Code: 65 49 8b 50 08 65 4c 03 05 8d e6 99 7b 4d 8b 28 4d 85 ed
0f 84 10 01 00 00 41 8b 5f 20 48 8d 4a 01 49 8b 3f 4c 89 e8 4c 01 eb <48> 33 1b
49 33 9f 38 01 00 00 65 48 0f c7 0f 0f 94 c0 84 c0 74 bd
[   42.910853] RSP: 0018:ffffb668010ef758 EFLAGS: 00010286
[   42.911609] RAX: fc71e573939ee6a6 RBX: fc71e573939ee6a6 RCX:
0000000000002dec
[   42.912632] RDX: 0000000000002deb RSI: 0000000000411200 RDI:
0000000000027660
[   42.913674] RBP: ffffb668010ef788 R08: ffff9c2277a27660 R09:
0000000000000001
[   42.914701] R10: 00000000fffffffb R11: 0000000000000000 R12:
0000000000411200
[   42.915725] R13: fc71e573939ee6a6 R14: ffff9c2277413480 R15:
ffff9c2277413480
[   42.916748] FS:  00007efdbbe20700(0000) GS:ffff9c2277a00000(0000)
knlGS:0000000000000000
[   42.917948] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   42.918776] CR2: 00007efdbb93b4c0 CR3: 0000000234fd0003 CR4:
00000000001606f0
[   42.919808] WARNING: CPU: 0 PID: 1111 at kernel/exit.c:781
do_exit+0x51/0xba0
[   42.920863] Modules linked in:
[   42.921362] CPU: 0 PID: 1111 Comm: a.out Tainted: G      D           5.0.0
#3
[   42.922385] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   42.923733] RIP: 0010:do_exit+0x51/0xba0
[   42.924303] Code: 8b 04 25 28 00 00 00 48 89 45 d0 31 c0 e8 f7 f9 07 00 48
8b 83 70 0b 00 00 48 85 c0 74 0e 48 8b 10 48 39 d0 0f 84 37 07 00 00 <0f> 0b 65
8b 05 16 3d b8 7b 25 00 ff 1f 00 89 45 a8 0f 85 ce 07 00
[   42.926976] RSP: 0018:ffffb668010efee8 EFLAGS: 00010216
[   42.927727] RAX: ffffb668010efb90 RBX: ffff9c22725a5c00 RCX:
00000000ffffffff
[   42.928746] RDX: ffff9c226b498048 RSI: 0000000000000000 RDI:
ffffffff85ab63c0
[   42.929814] RBP: ffffb668010eff48 R08: 0000000000000000 R09:
0000000000000005
[   42.930832] R10: 0000000000000000 R11: ffffb668010ef41d R12:
000000000000000b
[   42.931851] R13: ffffb668010ef6a8 R14: 0000000000000000 R15:
0000000000000000
[   42.932880] FS:  00007efdbbe20700(0000) GS:ffff9c2277a00000(0000)
knlGS:0000000000000000
[   42.934039] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   42.934863] CR2: 00007efdbb93b4c0 CR3: 0000000234fd0003 CR4:
00000000001606f0
[   42.935883] Call Trace:
[   42.936250]  ? do_fsync+0x3d/0x70
[   42.936737]  rewind_stack_do_exit+0x17/0x20
[   42.937393] RIP: 0033:0x7efdbb93b4d9
[   42.937935] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d 8f 29 2c 00 f7 d8 64 89 01 48
[   42.940692] RSP: 002b:00007ffef37f5378 EFLAGS: 00000217 ORIG_RAX:
000000000000004a
[   42.941833] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007efdbb93b4d9
[   42.942892] RDX: 00007efdbb93b4d9 RSI: 00007efdbb93b4d9 RDI:
0000000000000003
[   42.943950] RBP: 00007ffef37f9510 R08: 00007ffef37f95f8 R09:
00007ffef37f95f8
[   42.945040] R10: 00007ffef37f95f8 R11: 0000000000000217 R12:
00000000004004e0
[   42.946100] R13: 00007ffef37f95f0 R14: 0000000000000000 R15:
0000000000000000
[   42.947161] ---[ end trace 0f31ea6120b7b9ea ]---
[   42.948710] BUG: Bad rss-counter state mm:000000007b6b0bb3 idx:0 val:1
[   42.949731] BUG: Bad rss-counter state mm:000000007b6b0bb3 idx:1 val:2
[   42.950705] BUG: non-zero pgtables_bytes on freeing mm: 12288
[   42.951707] general protection fault: 0000 [#2] SMP PTI
[   42.952507] CPU: 0 PID: 607 Comm: in:imuxsock Tainted: G      D W        
5.0.0 #3
[   42.953665] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   42.955068] RIP: 0010:exit_creds+0x40/0x60
[   42.955684] Code: 83 40 0a 00 00 00 00 00 00 48 85 ff 74 05 3e ff 0f 74 27
48 8b bb 48 0a 00 00 48 c7 83 48 0a 00 00 00 00 00 00 48 85 ff 74 05 <3e> ff 0f
74 03 5b 5d c3 e8 53 f8 ff ff 5b 5d c3 e8 4b f8 ff ff eb
[   42.958457] RSP: 0018:ffffb668014f7d58 EFLAGS: 00010206
[   42.959235] RAX: ffffffff84a07610 RBX: ffff9c226b345c00 RCX:
0000000000000040
[   42.960290] RDX: ffffffff85b6f3e0 RSI: ffff9c226b345c00 RDI:
206e69616d3a7372
[   42.961370] RBP: ffffb668014f7d60 R08: 0000000000000001 R09:
0000000000000001
[   42.962427] R10: 0000000000000000 R11: 0000000002541c88 R12:
0000000000000001
[   42.963484] R13: ffff9c226b345c00 R14: ffffb66800cd6770 R15:
ffffb66800cd6788
[   42.964540] FS:  00007faa7b01e700(0000) GS:ffff9c2277a00000(0000)
knlGS:0000000000000000
[   42.965757] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   42.966612] CR2: 000055f1f6a23000 CR3: 000000022f56a006 CR4:
00000000001606f0
[   42.967666] Call Trace:
[   42.968044]  __put_task_struct+0x5a/0x160
[   42.968647]  wake_up_q+0x5a/0x70
[   42.969162]  do_futex+0x7e7/0xb50
[   42.969666]  __x64_sys_futex+0x8a/0x180
[   42.970245]  do_syscall_64+0x5a/0x110
[   42.970799]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   42.971553] RIP: 0033:0x7faa7cc69a26
[   42.972093] Code: 00 00 00 74 17 49 8b 48 20 44 8b 59 10 41 83 e3 30 41 83
fb 20 74 1e be 85 00 00 00 41 ba 01 00 00 00 41 b9 01 00 00 04 0f 05 <48> 3d 01
f0 ff ff 73 1f 31 c0 c3 be 8c 00 00 00 49 89 c8 4d 31 d2
[   42.974827] RSP: 002b:00007faa7b01a628 EFLAGS: 00000283 ORIG_RAX:
00000000000000ca
[   42.975907] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007faa7cc69a26
[   42.976973] RDX: 0000000000000001 RSI: 0000000000000085 RDI:
0000000002541c8c
[   42.978029] RBP: 0000000000000001 R08: 0000000002541c88 R09:
0000000004000001
[   42.979084] R10: 0000000000000001 R11: 0000000000000283 R12:
0000000000000000
[   42.980139] R13: 0000000000000001 R14: 00000000025480c0 R15:
0000000002548320
[   42.981216] Modules linked in:
[   42.981694] ---[ end trace 0f31ea6120b7b9eb ]---
[   42.982395] RIP: 0010:kmem_cache_alloc+0x88/0x1d0
[   42.983102] Code: 65 49 8b 50 08 65 4c 03 05 8d e6 99 7b 4d 8b 28 4d 85 ed
0f 84 10 01 00 00 41 8b 5f 20 48 8d 4a 01 49 8b 3f 4c 89 e8 4c 01 eb <48> 33 1b
49 33 9f 38 01 00 00 65 48 0f c7 0f 0f 94 c0 84 c0 74 bd
[   42.985884] RSP: 0018:ffffb668010ef758 EFLAGS: 00010286
[   42.986668] RAX: fc71e573939ee6a6 RBX: fc71e573939ee6a6 RCX:
0000000000002dec
[   42.987727] RDX: 0000000000002deb RSI: 0000000000411200 RDI:
0000000000027660
[   42.988787] RBP: ffffb668010ef788 R08: ffff9c2277a27660 R09:
0000000000000001
[   42.989876] R10: 00000000fffffffb R11: 0000000000000000 R12:
0000000000411200
[   42.990939] R13: fc71e573939ee6a6 R14: ffff9c2277413480 R15:
ffff9c2277413480
[   42.991999] FS:  00007faa7b01e700(0000) GS:ffff9c2277a00000(0000)
knlGS:0000000000000000
[   42.993229] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   42.994093] CR2: 000055f1f6a23000 CR3: 000000022f56a006 CR4:
00000000001606f0
[   42.995358] general protection fault: 0000 [#3] SMP PTI
[   42.996184] CPU: 0 PID: 1112 Comm: kworker/u2:3 Tainted: G      D W        
5.0.0 #3
[   42.997404] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   42.998816] RIP: 0010:kmem_cache_alloc+0x88/0x1d0
[   42.999524] Code: 65 49 8b 50 08 65 4c 03 05 8d e6 99 7b 4d 8b 28 4d 85 ed
0f 84 10 01 00 00 41 8b 5f 20 48 8d 4a 01 49 8b 3f 4c 89 e8 4c 01 eb <48> 33 1b
49 33 9f 38 01 00 00 65 48 0f c7 0f 0f 94 c0 84 c0 74 bd
[   43.002311] RSP: 0018:ffffb668010ef860 EFLAGS: 00010286
[   43.003097] RAX: fc71e573939ee6a6 RBX: fc71e573939ee6a6 RCX:
0000000000002dec
[   43.004162] RDX: 0000000000002deb RSI: 0000000000411280 RDI:
0000000000027660
[   43.005248] RBP: ffffb668010ef890 R08: ffff9c2277a27660 R09:
0000000000000001
[   43.006310] R10: ffffd84648bd5940 R11: 0000000000000020 R12:
0000000000411280
[   43.007371] R13: fc71e573939ee6a6 R14: ffff9c2277413480 R15:
ffff9c2277413480
[   43.008433] FS:  0000000000000000(0000) GS:ffff9c2277a00000(0000)
knlGS:0000000000000000
[   43.009656] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   43.010514] CR2: 00007efecaff24e0 CR3: 0000000234e46005 CR4:
00000000001606f0
[   43.011577] Call Trace:
[   43.011956]  ? mempool_alloc_slab+0x15/0x20
[   43.012589]  mempool_alloc_slab+0x15/0x20
[   43.013217]  mempool_alloc+0x73/0x180
[   43.013775]  ? __check_block_validity.constprop.80+0x2d/0x70
[   43.014649]  bio_alloc_bioset+0x1ac/0x210
[   43.015260]  ext4_mpage_readpages+0x55e/0x9b0
[   43.015943]  ext4_readpages+0x3c/0x40
[   43.016505]  read_pages+0x71/0x1a0
[   43.017027]  __do_page_cache_readahead+0x196/0x1b0
[   43.017721]  ? __do_page_cache_readahead+0x196/0x1b0
[   43.018475]  ondemand_readahead+0x178/0x2f0
[   43.019086]  page_cache_sync_readahead+0x7d/0xc0
[   43.019758]  generic_file_read_iter+0x871/0xc70
[   43.020449]  ? profile_transition+0x2b1/0x960
[   43.021130]  ext4_file_read_iter+0x56/0xf0
[   43.021750]  __vfs_read+0x11f/0x1a0
[   43.022280]  vfs_read+0x95/0x140
[   43.022772]  kernel_read+0x31/0x50
[   43.023291]  prepare_binprm+0xef/0x1d0
[   43.023859]  __do_execve_file.isra.38+0x595/0x930
[   43.024567]  do_execve+0x25/0x30
[   43.025082]  call_usermodehelper_exec_async+0x188/0x1a0
[   43.025864]  ? umh_complete+0x40/0x40
[   43.026419]  ret_from_fork+0x35/0x40
[   43.026960] Modules linked in:
[   43.027438] ---[ end trace 0f31ea6120b7b9ec ]---
[   43.028140] RIP: 0010:kmem_cache_alloc+0x88/0x1d0
[   43.028850] Code: 65 49 8b 50 08 65 4c 03 05 8d e6 99 7b 4d 8b 28 4d 85 ed
0f 84 10 01 00 00 41 8b 5f 20 48 8d 4a 01 49 8b 3f 4c 89 e8 4c 01 eb <48> 33 1b
49 33 9f 38 01 00 00 65 48 0f c7 0f 0f 94 c0 84 c0 74 bd
[   43.031642] RSP: 0018:ffffb668010ef758 EFLAGS: 00010286
[   43.032429] RAX: fc71e573939ee6a6 RBX: fc71e573939ee6a6 RCX:
0000000000002dec
[   43.033516] RDX: 0000000000002deb RSI: 0000000000411200 RDI:
0000000000027660
[   43.034584] RBP: ffffb668010ef788 R08: ffff9c2277a27660 R09:
0000000000000001
[   43.035651] R10: 00000000fffffffb R11: 0000000000000000 R12:
0000000000411200
[   43.036716] R13: fc71e573939ee6a6 R14: ffff9c2277413480 R15:
ffff9c2277413480
[   43.037808] FS:  0000000000000000(0000) GS:ffff9c2277a00000(0000)
knlGS:0000000000000000
[   43.039019] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   43.039883] CR2: 00007efecaff24e0 CR3: 0000000234e46005 CR4:
00000000001606f0
[   44.229781] general protection fault: 0000 [#4] SMP PTI
[   44.230619] CPU: 0 PID: 325 Comm: jbd2/sda1-8 Tainted: G      D W        
5.0.0 #3
[   44.231748] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   44.233206] RIP: 0010:kmem_cache_alloc+0x88/0x1d0
[   44.233916] Code: 65 49 8b 50 08 65 4c 03 05 8d e6 99 7b 4d 8b 28 4d 85 ed
0f 84 10 01 00 00 41 8b 5f 20 48 8d 4a 01 49 8b 3f 4c 89 e8 4c 01 eb <48> 33 1b
49 33 9f 38 01 00 00 65 48 0f c7 0f 0f 94 c0 84 c0 74 bd
[   44.236672] RSP: 0018:ffffb6680113bb78 EFLAGS: 00010286
[   44.237470] RAX: fc71e573939ee6a6 RBX: fc71e573939ee6a6 RCX:
0000000000002dec
[   44.238528] RDX: 0000000000002deb RSI: 0000000000411200 RDI:
0000000000027660
[   44.239587] RBP: ffffb6680113bba8 R08: ffff9c2277a27660 R09:
0000000000000000
[   44.240645] R10: 0000000000000078 R11: 0000000000088078 R12:
0000000000411200
[   44.241715] R13: fc71e573939ee6a6 R14: ffff9c2277413480 R15:
ffff9c2277413480
[   44.242775] FS:  0000000000000000(0000) GS:ffff9c2277a00000(0000)
knlGS:0000000000000000
[   44.243974] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   44.244830] CR2: 00007ff3f7e7c000 CR3: 0000000234f50002 CR4:
00000000001606f0
[   44.245904] Call Trace:
[   44.246283]  ? mempool_alloc_slab+0x15/0x20
[   44.246915]  mempool_alloc_slab+0x15/0x20
[   44.247519]  mempool_alloc+0x73/0x180
[   44.248076]  ? generic_block_bmap+0x4f/0x70
[   44.248707]  ? _cond_resched+0x1a/0x50
[   44.249294]  bio_alloc_bioset+0x1ac/0x210
[   44.249898]  ? jbd2_journal_write_metadata_buffer+0x29f/0x3a0
[   44.250753]  submit_bh_wbc+0x87/0x1b0
[   44.251306]  submit_bh+0x13/0x20
[   44.251800]  jbd2_journal_commit_transaction+0x62c/0x17c0
[   44.252604]  ? __switch_to_asm+0x34/0x70
[   44.253207]  ? __switch_to_asm+0x40/0x70
[   44.253798]  ? __switch_to_asm+0x40/0x70
[   44.254389]  kjournald2+0xc8/0x250
[   44.254905]  ? kjournald2+0xc8/0x250
[   44.255449]  ? wait_woken+0x80/0x80
[   44.255977]  kthread+0x105/0x140
[   44.256468]  ? commit_timeout+0x20/0x20
[   44.257059]  ? kthread_destroy_worker+0x50/0x50
[   44.257740]  ret_from_fork+0x35/0x40
[   44.258280] Modules linked in:
[   44.258756] ---[ end trace 0f31ea6120b7b9ed ]---
[   44.259455] RIP: 0010:kmem_cache_alloc+0x88/0x1d0
[   44.260164] Code: 65 49 8b 50 08 65 4c 03 05 8d e6 99 7b 4d 8b 28 4d 85 ed
0f 84 10 01 00 00 41 8b 5f 20 48 8d 4a 01 49 8b 3f 4c 89 e8 4c 01 eb <48> 33 1b
49 33 9f 38 01 00 00 65 48 0f c7 0f 0f 94 c0 84 c0 74 bd
[   44.262954] RSP: 0018:ffffb668010ef758 EFLAGS: 00010286
[   44.263738] RAX: fc71e573939ee6a6 RBX: fc71e573939ee6a6 RCX:
0000000000002dec
[   44.264800] RDX: 0000000000002deb RSI: 0000000000411200 RDI:
0000000000027660
[   44.265884] RBP: ffffb668010ef788 R08: ffff9c2277a27660 R09:
0000000000000001
[   44.266949] R10: 00000000fffffffb R11: 0000000000000000 R12:
0000000000411200
[   44.268011] R13: fc71e573939ee6a6 R14: ffff9c2277413480 R15:
ffff9c2277413480
[   44.269094] FS:  0000000000000000(0000) GS:ffff9c2277a00000(0000)
knlGS:0000000000000000
[   44.270301] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   44.271162] CR2: 00007ff3f7e7c000 CR3: 0000000234f50002 CR4:
00000000001606f0
[   44.741774] general protection fault: 0000 [#5] SMP PTI
[   44.742598] CPU: 0 PID: 140 Comm: kworker/u2:3 Tainted: G      D W        
5.0.0 #3
[   44.743738] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   44.745159] Workqueue: writeback wb_workfn (flush-8:0)
[   44.745933] RIP: 0010:kmem_cache_alloc+0x88/0x1d0
[   44.746636] Code: 65 49 8b 50 08 65 4c 03 05 8d e6 99 7b 4d 8b 28 4d 85 ed
0f 84 10 01 00 00 41 8b 5f 20 48 8d 4a 01 49 8b 3f 4c 89 e8 4c 01 eb <48> 33 1b
49 33 9f 38 01 00 00 65 48 0f c7 0f 0f 94 c0 84 c0 74 bd
[   44.749424] RSP: 0018:ffffb66800fcf7a8 EFLAGS: 00010286
[   44.750203] RAX: fc71e573939ee6a6 RBX: fc71e573939ee6a6 RCX:
0000000000002dec
[   44.751261] RDX: 0000000000002deb RSI: 0000000000411200 RDI:
0000000000027660
[   44.752319] RBP: ffffb66800fcf7d8 R08: ffff9c2277a27660 R09:
0000000000000002
[   44.753393] R10: 0000000000000000 R11: 0000000000000000 R12:
0000000000411200
[   44.754449] R13: fc71e573939ee6a6 R14: ffff9c2277413480 R15:
ffff9c2277413480
[   44.755505] FS:  0000000000000000(0000) GS:ffff9c2277a00000(0000)
knlGS:0000000000000000
[   44.756703] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   44.757570] CR2: 00007ff3f7e80000 CR3: 0000000234f50002 CR4:
00000000001606f0
[   44.758631] Call Trace:
[   44.759011]  ? mempool_alloc_slab+0x15/0x20
[   44.759642]  mempool_alloc_slab+0x15/0x20
[   44.760247]  mempool_alloc+0x73/0x180
[   44.760802]  ? sb_mark_inode_writeback+0x61/0xf0
[   44.761519]  bio_alloc_bioset+0x1ac/0x210
[   44.762123]  ext4_bio_write_page+0x3d6/0x540
[   44.762765]  mpage_submit_page+0x58/0x70
[   44.763356]  mpage_process_page_bufs+0x10f/0x120
[   44.764049]  mpage_prepare_extent_to_map+0x219/0x2f0
[   44.764797]  ? ata_sff_qc_issue+0xbf/0x1a0
[   44.765429]  ? _cond_resched+0x1a/0x50
[   44.765996]  ? kmem_cache_alloc+0x164/0x1d0
[   44.766626]  ? ext4_init_io_end+0x1f/0x40
[   44.767231]  ext4_writepages+0x3ba/0xe00
[   44.767824]  ? __switch_to_asm+0x34/0x70
[   44.768416]  ? __switch_to_asm+0x34/0x70
[   44.769021]  ? __switch_to_asm+0x34/0x70
[   44.769613]  ? __switch_to_asm+0x40/0x70
[   44.770205]  ? __switch_to_asm+0x34/0x70
[   44.770800]  ? __switch_to+0x9b/0x470
[   44.771353]  ? __switch_to_asm+0x40/0x70
[   44.771946]  do_writepages+0x1f/0x70
[   44.772489]  ? do_writepages+0x1f/0x70
[   44.773068]  __writeback_single_inode+0x40/0x340
[   44.773760]  writeback_sb_inodes+0x26a/0x570
[   44.774403]  __writeback_inodes_wb+0x92/0xc0
[   44.775046]  wb_writeback+0x265/0x320
[   44.775599]  wb_workfn+0x369/0x460
[   44.776115]  ? wb_workfn+0x369/0x460
[   44.776656]  process_one_work+0x167/0x410
[   44.777282]  worker_thread+0x4d/0x460
[   44.777846]  kthread+0x105/0x140
[   44.778341]  ? rescuer_thread+0x360/0x360
[   44.778923]  ? kthread_destroy_worker+0x50/0x50
[   44.779581]  ret_from_fork+0x35/0x40
[   44.780106] Modules linked in:
[   44.780567] ---[ end trace 0f31ea6120b7b9ee ]---
[   44.781290] RIP: 0010:kmem_cache_alloc+0x88/0x1d0
[   44.781981] Code: 65 49 8b 50 08 65 4c 03 05 8d e6 99 7b 4d 8b 28 4d 85 ed
0f 84 10 01 00 00 41 8b 5f 20 48 8d 4a 01 49 8b 3f 4c 89 e8 4c 01 eb <48> 33 1b
49 33 9f 38 01 00 00 65 48 0f c7 0f 0f 94 c0 84 c0 74 bd
[   44.784704] RSP: 0018:ffffb668010ef758 EFLAGS: 00010286
[   44.785533] RAX: fc71e573939ee6a6 RBX: fc71e573939ee6a6 RCX:
0000000000002dec
[   44.786603] RDX: 0000000000002deb RSI: 0000000000411200 RDI:
0000000000027660
[   44.787667] RBP: ffffb668010ef788 R08: ffff9c2277a27660 R09:
0000000000000001
[   44.788721] R10: 00000000fffffffb R11: 0000000000000000 R12:
0000000000411200
[   44.789818] R13: fc71e573939ee6a6 R14: ffff9c2277413480 R15:
ffff9c2277413480
[   44.790846] FS:  0000000000000000(0000) GS:ffff9c2277a00000(0000)
knlGS:0000000000000000
[   44.792041] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   44.792940] CR2: 00007ff3f7e80000 CR3: 0000000234f50002 CR4:
00000000001606f0


[   65.148699] sysfs: cannot create duplicate filename
'/kernel/slab/dentry/cgroup/dentry(503:systemd-timesyncd.service)'
[   65.150363] CPU: 0 PID: 12 Comm: kworker/0:1 Tainted: G      D W        
5.0.0 #3
[   65.151479] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   65.152912] Workqueue: memcg_kmem_cache memcg_kmem_cache_create_func
[   65.153862] Call Trace:
[   65.154242]  dump_stack+0x63/0x85
[   65.154748]  sysfs_warn_dup+0x5b/0x70
[   65.155302]  sysfs_create_dir_ns+0xbe/0xd0
[   65.155919]  kobject_add_internal+0xaa/0x2c0
[   65.156561]  kobject_init_and_add+0x6f/0xb0
[   65.157212]  sysfs_slab_add+0x1bd/0x280
[   65.157792]  __kmem_cache_create+0x4f0/0x580
[   65.158435]  ? kvasprintf+0x7d/0xd0
[   65.158965]  ? _cond_resched+0x1a/0x50
[   65.159532]  ? kmem_cache_alloc+0x164/0x1d0
[   65.160163]  create_cache+0xde/0x1e0
[   65.160727]  memcg_create_kmem_cache+0x109/0x130
[   65.161421]  memcg_kmem_cache_create_func+0x20/0x70
[   65.162155]  process_one_work+0x167/0x410
[   65.162761]  worker_thread+0x4d/0x460
[   65.163315]  kthread+0x105/0x140
[   65.163807]  ? rescuer_thread+0x360/0x360
[   65.164413]  ? kthread_destroy_worker+0x50/0x50
[   65.165115]  ret_from_fork+0x35/0x40
[   65.165668] kobject_add_internal failed for
dentry(503:systemd-timesyncd.service) with -EEXIST, don't try to register
things with the same name in the same directory.
[   65.168153] sysfs: cannot create duplicate filename
'/kernel/slab/:A-0000256/cgroup/filp(503:systemd-timesyncd.service)'
[   65.169813] CPU: 0 PID: 12 Comm: kworker/0:1 Tainted: G      D W        
5.0.0 #3
[   65.170929] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   65.172337] Workqueue: memcg_kmem_cache memcg_kmem_cache_create_func
[   65.173303] Call Trace:
[   65.173682]  dump_stack+0x63/0x85
[   65.174187]  sysfs_warn_dup+0x5b/0x70
[   65.174741]  sysfs_create_dir_ns+0xbe/0xd0
[   65.175358]  kobject_add_internal+0xaa/0x2c0
[   65.175999]  kobject_init_and_add+0x6f/0xb0
[   65.176667]  sysfs_slab_add+0x1bd/0x280
[   65.177254]  __kmem_cache_create+0x4f0/0x580
[   65.177897]  ? kvasprintf+0x7d/0xd0
[   65.178426]  ? _cond_resched+0x1a/0x50
[   65.178992]  ? kmem_cache_alloc+0x164/0x1d0
[   65.179623]  create_cache+0xde/0x1e0
[   65.180165]  memcg_create_kmem_cache+0x109/0x130
[   65.180879]  memcg_kmem_cache_create_func+0x20/0x70
[   65.181611]  process_one_work+0x167/0x410
[   65.182215]  worker_thread+0x4d/0x460
[   65.182769]  kthread+0x105/0x140
[   65.183260]  ? rescuer_thread+0x360/0x360
[   65.183863]  ? kthread_destroy_worker+0x50/0x50
[   65.184543]  ret_from_fork+0x35/0x40
[   65.185111] kobject_add_internal failed for
filp(503:systemd-timesyncd.service) with -EEXIST, don't try to register things
with the same name in the same directory.
[   65.187530] sysfs: cannot create duplicate filename
'/kernel/slab/dentry/cgroup/dentry(503:systemd-timesyncd.service)'
[   65.189145] CPU: 0 PID: 12 Comm: kworker/0:1 Tainted: G      D W        
5.0.0 #3
[   65.190259] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   65.191658] Workqueue: memcg_kmem_cache memcg_kmem_cache_create_func
[   65.192602] Call Trace:
[   65.193000]  dump_stack+0x63/0x85
[   65.193503]  sysfs_warn_dup+0x5b/0x70
[   65.194056]  sysfs_create_dir_ns+0xbe/0xd0
[   65.194672]  kobject_add_internal+0xaa/0x2c0
[   65.195311]  kobject_init_and_add+0x6f/0xb0
[   65.195941]  sysfs_slab_add+0x1bd/0x280
[   65.196519]  __kmem_cache_create+0x4f0/0x580
[   65.197194]  ? kvasprintf+0x7d/0xd0
[   65.197721]  ? _cond_resched+0x1a/0x50
[   65.198288]  ? kmem_cache_alloc+0x164/0x1d0
[   65.198917]  create_cache+0xde/0x1e0
[   65.199459]  memcg_create_kmem_cache+0x109/0x130
[   65.200152]  memcg_kmem_cache_create_func+0x20/0x70
[   65.200901]  process_one_work+0x167/0x410
[   65.201505]  worker_thread+0x4d/0x460
[   65.202058]  kthread+0x105/0x140
[   65.202547]  ? rescuer_thread+0x360/0x360
[   65.203150]  ? kthread_destroy_worker+0x50/0x50
[   65.203829]  ret_from_fork+0x35/0x40
[   65.204382] kobject_add_internal failed for
dentry(503:systemd-timesyncd.service) with -EEXIST, don't try to register
things with the same name in the same directory.
[   65.206858] sysfs: cannot create duplicate filename
'/kernel/slab/:A-0000256/cgroup/filp(503:systemd-timesyncd.service)'
[   65.208475] CPU: 0 PID: 12 Comm: kworker/0:1 Tainted: G      D W        
5.0.0 #3
[   65.209593] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   65.210942] Workqueue: memcg_kmem_cache memcg_kmem_cache_create_func
[   65.211851] Call Trace:
[   65.212215]  dump_stack+0x63/0x85
[   65.212719]  sysfs_warn_dup+0x5b/0x70
[   65.213253]  sysfs_create_dir_ns+0xbe/0xd0
[   65.213849]  kobject_add_internal+0xaa/0x2c0
[   65.214467]  kobject_init_and_add+0x6f/0xb0
[   65.215075]  sysfs_slab_add+0x1bd/0x280
[   65.215633]  __kmem_cache_create+0x4f0/0x580
[   65.216252]  ? kvasprintf+0x7d/0xd0
[   65.216798]  ? _cond_resched+0x1a/0x50
[   65.217360]  ? kmem_cache_alloc+0x164/0x1d0
[   65.217969]  create_cache+0xde/0x1e0
[   65.218491]  memcg_create_kmem_cache+0x109/0x130
[   65.219159]  memcg_kmem_cache_create_func+0x20/0x70
[   65.219864]  process_one_work+0x167/0x410
[   65.220447]  worker_thread+0x4d/0x460
[   65.221032]  kthread+0x105/0x140
[   65.221504]  ? rescuer_thread+0x360/0x360
[   65.222085]  ? kthread_destroy_worker+0x50/0x50
[   65.222739]  ret_from_fork+0x35/0x40
[   65.223268] kobject_add_internal failed for
filp(503:systemd-timesyncd.service) with -EEXIST, don't try to register things
with the same name in the same directory.
[   65.225605] sysfs: cannot create duplicate filename
'/kernel/slab/:A-0000256/cgroup/filp(503:systemd-timesyncd.service)'
[   65.227168] CPU: 0 PID: 12 Comm: kworker/0:1 Tainted: G      D W        
5.0.0 #3
[   65.228244] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   65.229655] Workqueue: memcg_kmem_cache memcg_kmem_cache_create_func
[   65.230567] Call Trace:
[   65.230931]  dump_stack+0x63/0x85
[   65.231416]  sysfs_warn_dup+0x5b/0x70
[   65.231949]  sysfs_create_dir_ns+0xbe/0xd0
[   65.232543]  kobject_add_internal+0xaa/0x2c0
[   65.233181]  kobject_init_and_add+0x6f/0xb0
[   65.233804]  sysfs_slab_add+0x1bd/0x280
[   65.234382]  __kmem_cache_create+0x4f0/0x580
[   65.235025]  ? kvasprintf+0x7d/0xd0
[   65.235535]  ? _cond_resched+0x1a/0x50
[   65.236081]  ? kmem_cache_alloc+0x164/0x1d0
[   65.236720]  create_cache+0xde/0x1e0
[   65.237260]  memcg_create_kmem_cache+0x109/0x130
[   65.237927]  memcg_kmem_cache_create_func+0x20/0x70
[   65.238630]  process_one_work+0x167/0x410
[   65.239212]  worker_thread+0x4d/0x460
[   65.239747]  kthread+0x105/0x140
[   65.240220]  ? rescuer_thread+0x360/0x360
[   65.240838]  ? kthread_destroy_worker+0x50/0x50
[   65.241507]  ret_from_fork+0x35/0x40
[   65.242034] kobject_add_internal failed for
filp(503:systemd-timesyncd.service) with -EEXIST, don't try to register things
with the same name in the same directory.
[   65.244437] sysfs: cannot create duplicate filename
'/kernel/slab/dentry/cgroup/dentry(503:systemd-timesyncd.service)'
[   65.246013] CPU: 0 PID: 12 Comm: kworker/0:1 Tainted: G      D W        
5.0.0 #3
[   65.247086] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   65.248439] Workqueue: memcg_kmem_cache memcg_kmem_cache_create_func
[   65.249404] Call Trace:
[   65.249771]  dump_stack+0x63/0x85
[   65.250256]  sysfs_warn_dup+0x5b/0x70
[   65.250789]  sysfs_create_dir_ns+0xbe/0xd0
[   65.251406]  kobject_add_internal+0xaa/0x2c0
[   65.252047]  kobject_init_and_add+0x6f/0xb0
[   65.252697]  sysfs_slab_add+0x1bd/0x280
[   65.253276]  __kmem_cache_create+0x4f0/0x580
[   65.253917]  ? kvasprintf+0x7d/0xd0
[   65.254444]  ? _cond_resched+0x1a/0x50
[   65.255022]  ? kmem_cache_alloc+0x164/0x1d0
[   65.255629]  create_cache+0xde/0x1e0
[   65.256151]  memcg_create_kmem_cache+0x109/0x130
[   65.256858]  memcg_kmem_cache_create_func+0x20/0x70
[   65.257578]  process_one_work+0x167/0x410
[   65.258160]  worker_thread+0x4d/0x460
[   65.258693]  kthread+0x105/0x140
[   65.259165]  ? rescuer_thread+0x360/0x360
[   65.259747]  ? kthread_destroy_worker+0x50/0x50
[   65.260403]  ret_from_fork+0x35/0x40
[   65.260982] kobject_add_internal failed for
dentry(503:systemd-timesyncd.service) with -EEXIST, don't try to register
things with the same name in the same directory.
[   65.263372] sysfs: cannot create duplicate filename
'/kernel/slab/:A-0000256/cgroup/filp(503:systemd-timesyncd.service)'
[   65.265010] CPU: 0 PID: 12 Comm: kworker/0:1 Tainted: G      D W        
5.0.0 #3
[   65.266114] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   65.267502] Workqueue: memcg_kmem_cache memcg_kmem_cache_create_func
[   65.268444] Call Trace:
[   65.268840]  dump_stack+0x63/0x85
[   65.269344]  sysfs_warn_dup+0x5b/0x70
[   65.269897]  sysfs_create_dir_ns+0xbe/0xd0
[   65.270513]  kobject_add_internal+0xaa/0x2c0
[   65.271154]  kobject_init_and_add+0x6f/0xb0
[   65.271782]  sysfs_slab_add+0x1bd/0x280
[   65.272360]  __kmem_cache_create+0x4f0/0x580
[   65.273025]  ? kvasprintf+0x7d/0xd0
[   65.273552]  ? _cond_resched+0x1a/0x50
[   65.274115]  ? kmem_cache_alloc+0x164/0x1d0
[   65.274744]  create_cache+0xde/0x1e0
[   65.275284]  memcg_create_kmem_cache+0x109/0x130
[   65.275975]  memcg_kmem_cache_create_func+0x20/0x70
[   65.276723]  process_one_work+0x167/0x410
[   65.277327]  worker_thread+0x4d/0x460
[   65.277879]  kthread+0x105/0x140
[   65.278368]  ? rescuer_thread+0x360/0x360
[   65.278970]  ? kthread_destroy_worker+0x50/0x50
[   65.279651]  ret_from_fork+0x35/0x40
[   65.280201] kobject_add_internal failed for
filp(503:systemd-timesyncd.service) with -EEXIST, don't try to register things
with the same name in the same directory.
[   65.282617] sysfs: cannot create duplicate filename
'/kernel/slab/:A-0000256/cgroup/filp(503:systemd-timesyncd.service)'
[   65.284236] CPU: 0 PID: 12 Comm: kworker/0:1 Tainted: G      D W        
5.0.0 #3
[   65.285369] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   65.286769] Workqueue: memcg_kmem_cache memcg_kmem_cache_create_func
[   65.287713] Call Trace:
[   65.288090]  dump_stack+0x63/0x85
[   65.288593]  sysfs_warn_dup+0x5b/0x70
[   65.289167]  sysfs_create_dir_ns+0xbe/0xd0
[   65.289783]  kobject_add_internal+0xaa/0x2c0
[   65.290425]  kobject_init_and_add+0x6f/0xb0
[   65.291054]  sysfs_slab_add+0x1bd/0x280
[   65.291632]  __kmem_cache_create+0x4f0/0x580
[   65.292274]  ? kvasprintf+0x7d/0xd0
[   65.292835]  ? _cond_resched+0x1a/0x50
[   65.293401]  ? kmem_cache_alloc+0x164/0x1d0
[   65.294028]  create_cache+0xde/0x1e0
[   65.294570]  memcg_create_kmem_cache+0x109/0x130
[   65.295268]  memcg_kmem_cache_create_func+0x20/0x70
[   65.296006]  process_one_work+0x167/0x410
[   65.296588]  worker_thread+0x4d/0x460
[   65.297193]  kthread+0x105/0x140
[   65.297690]  ? rescuer_thread+0x360/0x360
[   65.298306]  ? kthread_destroy_worker+0x50/0x50
[   65.298961]  ret_from_fork+0x35/0x40
[   65.299491] kobject_add_internal failed for
filp(503:systemd-timesyncd.service) with -EEXIST, don't try to register things
with the same name in the same directory.
[   65.301905] sysfs: cannot create duplicate filename
'/kernel/slab/:A-0000256/cgroup/filp(503:systemd-timesyncd.service)'
[   65.303535] CPU: 0 PID: 12 Comm: kworker/0:1 Tainted: G      D W        
5.0.0 #3
[   65.304657] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   65.306071] Workqueue: memcg_kmem_cache memcg_kmem_cache_create_func
[   65.307016] Call Trace:
[   65.307393]  dump_stack+0x63/0x85
[   65.307896]  sysfs_warn_dup+0x5b/0x70
[   65.308449]  sysfs_create_dir_ns+0xbe/0xd0
[   65.309086]  kobject_add_internal+0xaa/0x2c0
[   65.309727]  kobject_init_and_add+0x6f/0xb0
[   65.310357]  sysfs_slab_add+0x1bd/0x280
[   65.310938]  __kmem_cache_create+0x4f0/0x580
[   65.311579]  ? kvasprintf+0x7d/0xd0
[   65.312109]  ? _cond_resched+0x1a/0x50
[   65.312696]  ? kmem_cache_alloc+0x164/0x1d0
[   65.313325]  create_cache+0xde/0x1e0
[   65.313865]  memcg_create_kmem_cache+0x109/0x130
[   65.314556]  memcg_kmem_cache_create_func+0x20/0x70
[   65.315285]  process_one_work+0x167/0x410
[   65.315888]  worker_thread+0x4d/0x460
[   65.316440]  kthread+0x105/0x140
[   65.316950]  ? rescuer_thread+0x360/0x360
[   65.317554]  ? kthread_destroy_worker+0x50/0x50
[   65.318233]  ret_from_fork+0x35/0x40
[   65.318781] kobject_add_internal failed for
filp(503:systemd-timesyncd.service) with -EEXIST, don't try to register things
with the same name in the same directory.
[   65.321203] sysfs: cannot create duplicate filename
'/kernel/slab/dentry/cgroup/dentry(503:systemd-timesyncd.service)'
[   65.322802] CPU: 0 PID: 12 Comm: kworker/0:1 Tainted: G      D W        
5.0.0 #3
[   65.323916] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   65.325341] Workqueue: memcg_kmem_cache memcg_kmem_cache_create_func
[   65.326287] Call Trace:
[   65.326665]  dump_stack+0x63/0x85
[   65.327168]  sysfs_warn_dup+0x5b/0x70
[   65.327722]  sysfs_create_dir_ns+0xbe/0xd0
[   65.328339]  kobject_add_internal+0xaa/0x2c0
[   65.329000]  kobject_init_and_add+0x6f/0xb0
[   65.329630]  sysfs_slab_add+0x1bd/0x280
[   65.330209]  __kmem_cache_create+0x4f0/0x580
[   65.330851]  ? kvasprintf+0x7d/0xd0
[   65.331379]  ? _cond_resched+0x1a/0x50
[   65.331945]  ? kmem_cache_alloc+0x164/0x1d0
[   65.332574]  create_cache+0xde/0x1e0
[   65.333134]  memcg_create_kmem_cache+0x109/0x130
[   65.333852]  memcg_kmem_cache_create_func+0x20/0x70
[   65.334583]  process_one_work+0x167/0x410
[   65.335188]  worker_thread+0x4d/0x460
[   65.335743]  kthread+0x105/0x140
[   65.336233]  ? rescuer_thread+0x360/0x360
[   65.336855]  ? kthread_destroy_worker+0x50/0x50
[   65.337536]  ret_from_fork+0x35/0x40
[   65.338083] kobject_add_internal failed for
dentry(503:systemd-timesyncd.service) with -EEXIST, don't try to register
things with the same name in the same directory.
[   65.340507] sysfs: cannot create duplicate filename
'/kernel/slab/:A-0000256/cgroup/filp(503:systemd-timesyncd.service)'
[   65.342167] CPU: 0 PID: 12 Comm: kworker/0:1 Tainted: G      D W        
5.0.0 #3
[   65.343281] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   65.344709] Workqueue: memcg_kmem_cache memcg_kmem_cache_create_func
[   65.345659] Call Trace:
[   65.346039]  dump_stack+0x63/0x85
[   65.346542]  sysfs_warn_dup+0x5b/0x70
[   65.347096]  sysfs_create_dir_ns+0xbe/0xd0
[   65.347713]  kobject_add_internal+0xaa/0x2c0
[   65.348356]  kobject_init_and_add+0x6f/0xb0
[   65.349005]  sysfs_slab_add+0x1bd/0x280
[   65.349585]  __kmem_cache_create+0x4f0/0x580
[   65.350227]  ? kvasprintf+0x7d/0xd0
[   65.350755]  ? _cond_resched+0x1a/0x50
[   65.351326]  ? kmem_cache_alloc+0x164/0x1d0
[   65.351934]  create_cache+0xde/0x1e0
[   65.352473]  memcg_create_kmem_cache+0x109/0x130
[   65.353185]  memcg_kmem_cache_create_func+0x20/0x70
[   65.353915]  process_one_work+0x167/0x410
[   65.354519]  worker_thread+0x4d/0x460
[   65.355072]  kthread+0x105/0x140
[   65.355562]  ? rescuer_thread+0x360/0x360
[   65.356166]  ? kthread_destroy_worker+0x50/0x50
[   65.356864]  ret_from_fork+0x35/0x40
[   65.357411] kobject_add_internal failed for
filp(503:systemd-timesyncd.service) with -EEXIST, don't try to register things
with the same name in the same directory.
[   65.360209] sysfs: cannot create duplicate filename
'/kernel/slab/dentry/cgroup/dentry(503:systemd-timesyncd.service)'
[   65.361837] CPU: 0 PID: 12 Comm: kworker/0:1 Tainted: G      D W        
5.0.0 #3
[   65.362957] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   65.364369] Workqueue: memcg_kmem_cache memcg_kmem_cache_create_func
[   65.365326] Call Trace:
[   65.365708]  dump_stack+0x63/0x85
[   65.366214]  sysfs_warn_dup+0x5b/0x70
[   65.366770]  sysfs_create_dir_ns+0xbe/0xd0
[   65.367390]  kobject_add_internal+0xaa/0x2c0
[   65.368057]  kobject_init_and_add+0x6f/0xb0
[   65.368731]  sysfs_slab_add+0x1bd/0x280
[   65.369310]  __kmem_cache_create+0x4f0/0x580
[   65.369951]  ? kvasprintf+0x7d/0xd0
[   65.370478]  ? _cond_resched+0x1a/0x50
[   65.371045]  ? kmem_cache_alloc+0x164/0x1d0
[   65.371674]  create_cache+0xde/0x1e0
[   65.372216]  memcg_create_kmem_cache+0x109/0x130
[   65.372928]  memcg_kmem_cache_create_func+0x20/0x70
[   65.373660]  process_one_work+0x167/0x410
[   65.374265]  worker_thread+0x4d/0x460
[   65.374823]  kthread+0x105/0x140
[   65.375297]  ? rescuer_thread+0x360/0x360
[   65.375880]  ? kthread_destroy_worker+0x50/0x50
[   65.376537]  ret_from_fork+0x35/0x40
[   65.377115] kobject_add_internal failed for
dentry(503:systemd-timesyncd.service) with -EEXIST, don't try to register
things with the same name in the same directory.
[   65.379561] sysfs: cannot create duplicate filename
'/kernel/slab/:A-0000256/cgroup/filp(503:systemd-timesyncd.service)'
[   65.381199] CPU: 0 PID: 12 Comm: kworker/0:1 Tainted: G      D W        
5.0.0 #3
[   65.382311] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   65.383709] Workqueue: memcg_kmem_cache memcg_kmem_cache_create_func
[   65.384665] Call Trace:
[   65.385048]  dump_stack+0x63/0x85
[   65.385552]  sysfs_warn_dup+0x5b/0x70
[   65.386105]  sysfs_create_dir_ns+0xbe/0xd0
[   65.386722]  kobject_add_internal+0xaa/0x2c0
[   65.387362]  kobject_init_and_add+0x6f/0xb0
[   65.387991]  sysfs_slab_add+0x1bd/0x280
[   65.388570]  __kmem_cache_create+0x4f0/0x580
[   65.389243]  ? kvasprintf+0x7d/0xd0
[   65.389771]  ? _cond_resched+0x1a/0x50
[   65.390336]  ? kmem_cache_alloc+0x164/0x1d0
[   65.390967]  create_cache+0xde/0x1e0
[   65.391508]  memcg_create_kmem_cache+0x109/0x130
[   65.392200]  memcg_kmem_cache_create_func+0x20/0x70
[   65.392949]  process_one_work+0x167/0x410
[   65.393553]  worker_thread+0x4d/0x460
[   65.394106]  kthread+0x105/0x140
[   65.394596]  ? rescuer_thread+0x360/0x360
[   65.395199]  ? kthread_destroy_worker+0x50/0x50
[   65.395879]  ret_from_fork+0x35/0x40
[   65.396430] kobject_add_internal failed for
filp(503:systemd-timesyncd.service) with -EEXIST, don't try to register things
with the same name in the same directory.
[   65.398859] sysfs: cannot create duplicate filename
'/kernel/slab/dentry/cgroup/dentry(503:systemd-timesyncd.service)'
[   65.400451] CPU: 0 PID: 12 Comm: kworker/0:1 Tainted: G      D W        
5.0.0 #3
[   65.401569] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   65.402974] Workqueue: memcg_kmem_cache memcg_kmem_cache_create_func
[   65.403919] Call Trace:
[   65.404298]  dump_stack+0x63/0x85
[   65.404823]  sysfs_warn_dup+0x5b/0x70
[   65.405376]  sysfs_create_dir_ns+0xbe/0xd0
[   65.405991]  kobject_add_internal+0xaa/0x2c0
[   65.406632]  kobject_init_and_add+0x6f/0xb0
[   65.407260]  sysfs_slab_add+0x1bd/0x280
[   65.407838]  __kmem_cache_create+0x4f0/0x580
[   65.408478]  ? kvasprintf+0x7d/0xd0
[   65.409024]  ? _cond_resched+0x1a/0x50
[   65.409590]  ? kmem_cache_alloc+0x164/0x1d0
[   65.410219]  create_cache+0xde/0x1e0
[   65.410761]  memcg_create_kmem_cache+0x109/0x130
[   65.411454]  memcg_kmem_cache_create_func+0x20/0x70
[   65.412184]  process_one_work+0x167/0x410
[   65.412806]  worker_thread+0x4d/0x460
[   65.413360]  kthread+0x105/0x140
[   65.413850]  ? rescuer_thread+0x360/0x360
[   65.414454]  ? kthread_destroy_worker+0x50/0x50
[   65.415134]  ret_from_fork+0x35/0x40
[   65.415684] kobject_add_internal failed for
dentry(503:systemd-timesyncd.service) with -EEXIST, don't try to register
things with the same name in the same directory.
[   65.418153] sysfs: cannot create duplicate filename
'/kernel/slab/:A-0000256/cgroup/filp(503:systemd-timesyncd.service)'
[   65.419771] CPU: 0 PID: 12 Comm: kworker/0:1 Tainted: G      D W        
5.0.0 #3
[   65.420903] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   65.422308] Workqueue: memcg_kmem_cache memcg_kmem_cache_create_func
[   65.423250] Call Trace:
[   65.423627]  dump_stack+0x63/0x85
[   65.424130]  sysfs_warn_dup+0x5b/0x70
[   65.424700]  sysfs_create_dir_ns+0xbe/0xd0
[   65.425316]  kobject_add_internal+0xaa/0x2c0
[   65.425956]  kobject_init_and_add+0x6f/0xb0
[   65.426584]  sysfs_slab_add+0x1bd/0x280
[   65.427163]  __kmem_cache_create+0x4f0/0x580
[   65.427804]  ? kvasprintf+0x7d/0xd0
[   65.428331]  ? _cond_resched+0x1a/0x50
[   65.428912]  ? kmem_cache_alloc+0x164/0x1d0
[   65.429540]  create_cache+0xde/0x1e0
[   65.430080]  memcg_create_kmem_cache+0x109/0x130
[   65.430771]  memcg_kmem_cache_create_func+0x20/0x70
[   65.431501]  process_one_work+0x167/0x410
[   65.432104]  worker_thread+0x4d/0x460
[   65.432671]  kthread+0x105/0x140
[   65.433163]  ? rescuer_thread+0x360/0x360
[   65.433766]  ? kthread_destroy_worker+0x50/0x50
[   65.434445]  ret_from_fork+0x35/0x40
[   65.434995] kobject_add_internal failed for
filp(503:systemd-timesyncd.service) with -EEXIST, don't try to register things
with the same name in the same directory.
[   65.437439] sysfs: cannot create duplicate filename
'/kernel/slab/dentry/cgroup/dentry(503:systemd-timesyncd.service)'
[   65.439058] CPU: 0 PID: 12 Comm: kworker/0:1 Tainted: G      D W        
5.0.0 #3
[   65.440171] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   65.441595] Workqueue: memcg_kmem_cache memcg_kmem_cache_create_func
[   65.442539] Call Trace:
[   65.442916]  dump_stack+0x63/0x85
[   65.443419]  sysfs_warn_dup+0x5b/0x70
[   65.443973]  sysfs_create_dir_ns+0xbe/0xd0
[   65.444588]  kobject_add_internal+0xaa/0x2c0
[   65.445247]  kobject_init_and_add+0x6f/0xb0
[   65.445875]  sysfs_slab_add+0x1bd/0x280
[   65.446454]  __kmem_cache_create+0x4f0/0x580
[   65.447096]  ? kvasprintf+0x7d/0xd0
[   65.447623]  ? _cond_resched+0x1a/0x50
[   65.448189]  ? kmem_cache_alloc+0x164/0x1d0
[   65.448823]  create_cache+0xde/0x1e0
[   65.449365]  memcg_create_kmem_cache+0x109/0x130
[   65.450057]  memcg_kmem_cache_create_func+0x20/0x70
[   65.450785]  process_one_work+0x167/0x410
[   65.451389]  worker_thread+0x4d/0x460
[   65.451942]  kthread+0x105/0x140
[   65.452432]  ? rescuer_thread+0x360/0x360
[   65.453055]  ? kthread_destroy_worker+0x50/0x50
[   65.453736]  ret_from_fork+0x35/0x40
[   65.454281] kobject_add_internal failed for
dentry(503:systemd-timesyncd.service) with -EEXIST, don't try to register
things with the same name in the same directory.
[   65.456720] sysfs: cannot create duplicate filename
'/kernel/slab/:A-0000256/cgroup/filp(503:systemd-timesyncd.service)'
[   65.458345] CPU: 0 PID: 12 Comm: kworker/0:1 Tainted: G      D W        
5.0.0 #3
[   65.459460] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   65.460887] Workqueue: memcg_kmem_cache memcg_kmem_cache_create_func
[   65.461836] Call Trace:
[   65.462213]  dump_stack+0x63/0x85
[   65.462716]  sysfs_warn_dup+0x5b/0x70
[   65.463269]  sysfs_create_dir_ns+0xbe/0xd0
[   65.463884]  kobject_add_internal+0xaa/0x2c0
[   65.464525]  kobject_init_and_add+0x6f/0xb0
[   65.465173]  sysfs_slab_add+0x1bd/0x280
[   65.465752]  __kmem_cache_create+0x4f0/0x580
[   65.466393]  ? kvasprintf+0x7d/0xd0
[   65.466920]  ? _cond_resched+0x1a/0x50
[   65.467486]  ? kmem_cache_alloc+0x164/0x1d0
[   65.468115]  create_cache+0xde/0x1e0
[   65.468658]  memcg_create_kmem_cache+0x109/0x130
[   65.469351]  memcg_kmem_cache_create_func+0x20/0x70
[   65.470080]  process_one_work+0x167/0x410
[   65.470683]  worker_thread+0x4d/0x460
[   65.471234]  kthread+0x105/0x140
[   65.471725]  ? rescuer_thread+0x360/0x360
[   65.472327]  ? kthread_destroy_worker+0x50/0x50
[   65.473022]  ret_from_fork+0x35/0x40
[   65.473568] kobject_add_internal failed for
filp(503:systemd-timesyncd.service) with -EEXIST, don't try to register things
with the same name in the same directory.
[   65.475968] sysfs: cannot create duplicate filename
'/kernel/slab/dentry/cgroup/dentry(503:systemd-timesyncd.service)'
[   65.477578] CPU: 0 PID: 12 Comm: kworker/0:1 Tainted: G      D W        
5.0.0 #3
[   65.478688] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   65.480089] Workqueue: memcg_kmem_cache memcg_kmem_cache_create_func
[   65.481058] Call Trace:
[   65.481436]  dump_stack+0x63/0x85
[   65.481939]  sysfs_warn_dup+0x5b/0x70
[   65.482493]  sysfs_create_dir_ns+0xbe/0xd0
[   65.483109]  kobject_add_internal+0xaa/0x2c0
[   65.483750]  kobject_init_and_add+0x6f/0xb0
[   65.484379]  sysfs_slab_add+0x1bd/0x280
[   65.484991]  __kmem_cache_create+0x4f0/0x580
[   65.485632]  ? kvasprintf+0x7d/0xd0
[   65.486159]  ? _cond_resched+0x1a/0x50
[   65.486725]  ? kmem_cache_alloc+0x164/0x1d0
[   65.487354]  create_cache+0xde/0x1e0
[   65.487895]  memcg_create_kmem_cache+0x109/0x130
[   65.488586]  memcg_kmem_cache_create_func+0x20/0x70
[   65.489338]  process_one_work+0x167/0x410
[   65.489941]  worker_thread+0x4d/0x460
[   65.490493]  kthread+0x105/0x140
[   65.490983]  ? rescuer_thread+0x360/0x360
[   65.491586]  ? kthread_destroy_worker+0x50/0x50
[   65.492265]  ret_from_fork+0x35/0x40
[   65.492834] kobject_add_internal failed for
dentry(503:systemd-timesyncd.service) with -EEXIST, don't try to register
things with the same name in the same directory.
[   65.495272] sysfs: cannot create duplicate filename
'/kernel/slab/:A-0000256/cgroup/filp(503:systemd-timesyncd.service)'
[   65.496912] CPU: 0 PID: 12 Comm: kworker/0:1 Tainted: G      D W        
5.0.0 #3
[   65.498025] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   65.499423] Workqueue: memcg_kmem_cache memcg_kmem_cache_create_func
[   65.500366] Call Trace:
[   65.500765]  dump_stack+0x63/0x85
[   65.501269]  sysfs_warn_dup+0x5b/0x70
[   65.501823]  sysfs_create_dir_ns+0xbe/0xd0
[   65.502440]  kobject_add_internal+0xaa/0x2c0
[   65.503082]  kobject_init_and_add+0x6f/0xb0
[   65.503712]  sysfs_slab_add+0x1bd/0x280
[   65.504291]  __kmem_cache_create+0x4f0/0x580
[   65.504954]  ? kvasprintf+0x7d/0xd0
[   65.505483]  ? _cond_resched+0x1a/0x50
[   65.506050]  ? kmem_cache_alloc+0x164/0x1d0
[   65.506681]  create_cache+0xde/0x1e0
[   65.507223]  memcg_create_kmem_cache+0x109/0x130
[   65.507917]  memcg_kmem_cache_create_func+0x20/0x70
[   65.508660]  process_one_work+0x167/0x410
[   65.509272]  worker_thread+0x4d/0x460
[   65.509826]  kthread+0x105/0x140
[   65.510316]  ? rescuer_thread+0x360/0x360
[   65.510919]  ? kthread_destroy_worker+0x50/0x50
[   65.511599]  ret_from_fork+0x35/0x40
[   65.512149] kobject_add_internal failed for
filp(503:systemd-timesyncd.service) with -EEXIST, don't try to register things
with the same name in the same directory.
[   65.514575] sysfs: cannot create duplicate filename
'/kernel/slab/:A-0000256/cgroup/filp(503:systemd-timesyncd.service)'
[   65.516194] CPU: 0 PID: 12 Comm: kworker/0:1 Tainted: G      D W        
5.0.0 #3
[   65.517328] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   65.518732] Workqueue: memcg_kmem_cache memcg_kmem_cache_create_func
[   65.519675] Call Trace:
[   65.520052]  dump_stack+0x63/0x85
[   65.520557]  sysfs_warn_dup+0x5b/0x70
[   65.521131]  sysfs_create_dir_ns+0xbe/0xd0
[   65.521748]  kobject_add_internal+0xaa/0x2c0
[   65.522389]  kobject_init_and_add+0x6f/0xb0
[   65.523017]  sysfs_slab_add+0x1bd/0x280
[   65.523595]  __kmem_cache_create+0x4f0/0x580
[   65.524235]  ? kvasprintf+0x7d/0xd0
[   65.524784]  ? _cond_resched+0x1a/0x50
[   65.525350]  ? kmem_cache_alloc+0x164/0x1d0
[   65.525979]  create_cache+0xde/0x1e0
[   65.526519]  memcg_create_kmem_cache+0x109/0x130
[   65.527211]  memcg_kmem_cache_create_func+0x20/0x70
[   65.527940]  process_one_work+0x167/0x410
[   65.528543]  worker_thread+0x4d/0x460
[   65.529117]  kthread+0x105/0x140
[   65.529607]  ? rescuer_thread+0x360/0x360
[   65.530211]  ? kthread_destroy_worker+0x50/0x50
[   65.530889]  ret_from_fork+0x35/0x40
[   65.531437] kobject_add_internal failed for
filp(503:systemd-timesyncd.service) with -EEXIST, don't try to register things
with the same name in the same directory.
[   65.533884] sysfs: cannot create duplicate filename
'/kernel/slab/dentry/cgroup/dentry(503:systemd-timesyncd.service)'
[   65.535497] CPU: 0 PID: 12 Comm: kworker/0:1 Tainted: G      D W        
5.0.0 #3
[   65.536609] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   65.538022] Workqueue: memcg_kmem_cache memcg_kmem_cache_create_func
[   65.538966] Call Trace:
[   65.539343]  dump_stack+0x63/0x85
[   65.539847]  sysfs_warn_dup+0x5b/0x70
[   65.540401]  sysfs_create_dir_ns+0xbe/0xd0
[   65.541045]  kobject_add_internal+0xaa/0x2c0
[   65.541686]  kobject_init_and_add+0x6f/0xb0
[   65.542317]  sysfs_slab_add+0x1bd/0x280
[   65.542896]  __kmem_cache_create+0x4f0/0x580
[   65.543539]  ? kvasprintf+0x7d/0xd0
[   65.544067]  ? _cond_resched+0x1a/0x50
[   65.544640]  ? kmem_cache_alloc+0x164/0x1d0
[   65.545285]  create_cache+0xde/0x1e0
[   65.545827]  memcg_create_kmem_cache+0x109/0x130
[   65.546520]  memcg_kmem_cache_create_func+0x20/0x70
[   65.547268]  process_one_work+0x167/0x410
[   65.547872]  worker_thread+0x4d/0x460
[   65.548426]  kthread+0x105/0x140
[   65.548939]  ? rescuer_thread+0x360/0x360
[   65.549543]  ? kthread_destroy_worker+0x50/0x50
[   65.550224]  ret_from_fork+0x35/0x40
[   65.550773] kobject_add_internal failed for
dentry(503:systemd-timesyncd.service) with -EEXIST, don't try to register
things with the same name in the same directory.
[   65.553224] sysfs: cannot create duplicate filename
'/kernel/slab/:A-0000256/cgroup/filp(503:systemd-timesyncd.service)'
[   65.554887] CPU: 0 PID: 12 Comm: kworker/0:1 Tainted: G      D W        
5.0.0 #3
[   65.556000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   65.557450] Workqueue: memcg_kmem_cache memcg_kmem_cache_create_func
[   65.558395] Call Trace:
[   65.558772]  dump_stack+0x63/0x85
[   65.559277]  sysfs_warn_dup+0x5b/0x70
[   65.559829]  sysfs_create_dir_ns+0xbe/0xd0
[   65.560445]  kobject_add_internal+0xaa/0x2c0
[   65.561130]  kobject_init_and_add+0x6f/0xb0
[   65.561779]  sysfs_slab_add+0x1bd/0x280
[   65.562379]  __kmem_cache_create+0x4f0/0x580
[   65.563020]  ? kvasprintf+0x7d/0xd0
[   65.563546]  ? _cond_resched+0x1a/0x50
[   65.564112]  ? kmem_cache_alloc+0x164/0x1d0
[   65.564762]  create_cache+0xde/0x1e0
[   65.565303]  memcg_create_kmem_cache+0x109/0x130
[   65.565996]  memcg_kmem_cache_create_func+0x20/0x70
[   65.566726]  process_one_work+0x167/0x410
[   65.567331]  worker_thread+0x4d/0x460
[   65.567883]  kthread+0x105/0x140
[   65.568373]  ? rescuer_thread+0x360/0x360
[   65.568997]  ? kthread_destroy_worker+0x50/0x50
[   65.569677]  ret_from_fork+0x35/0x40
[   65.570224] kobject_add_internal failed for
filp(503:systemd-timesyncd.service) with -EEXIST, don't try to register things
with the same name in the same directory.
[   65.572625] sysfs: cannot create duplicate filename
'/kernel/slab/:A-0000256/cgroup/filp(503:systemd-timesyncd.service)'
[   65.574265] CPU: 0 PID: 12 Comm: kworker/0:1 Tainted: G      D W        
5.0.0 #3
[   65.575402] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   65.576855] Workqueue: memcg_kmem_cache memcg_kmem_cache_create_func
[   65.577804] Call Trace:
[   65.578181]  dump_stack+0x63/0x85
[   65.578684]  sysfs_warn_dup+0x5b/0x70
[   65.579237]  sysfs_create_dir_ns+0xbe/0xd0
[   65.579852]  kobject_add_internal+0xaa/0x2c0
[   65.580493]  kobject_init_and_add+0x6f/0xb0
[   65.581154]  sysfs_slab_add+0x1bd/0x280
[   65.581731]  __kmem_cache_create+0x4f0/0x580
[   65.582372]  ? kvasprintf+0x7d/0xd0
[   65.582899]  ? _cond_resched+0x1a/0x50
[   65.583464]  ? kmem_cache_alloc+0x164/0x1d0
[   65.584092]  create_cache+0xde/0x1e0
[   65.584639]  memcg_create_kmem_cache+0x109/0x130
[   65.585346]  memcg_kmem_cache_create_func+0x20/0x70
[   65.586077]  process_one_work+0x167/0x410
[   65.586681]  worker_thread+0x4d/0x460
[   65.587234]  kthread+0x105/0x140
[   65.587724]  ? rescuer_thread+0x360/0x360
[   65.588327]  ? kthread_destroy_worker+0x50/0x50
[   65.589025]  ret_from_fork+0x35/0x40
[   65.589572] kobject_add_internal failed for
filp(503:systemd-timesyncd.service) with -EEXIST, don't try to register things
with the same name in the same directory.
[   65.591973] sysfs: cannot create duplicate filename
'/kernel/slab/:A-0000256/cgroup/filp(503:systemd-timesyncd.service)'
[   65.593632] CPU: 0 PID: 12 Comm: kworker/0:1 Tainted: G      D W        
5.0.0 #3
[   65.594739] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   65.596137] Workqueue: memcg_kmem_cache memcg_kmem_cache_create_func
[   65.597100] Call Trace:
[   65.597477]  dump_stack+0x63/0x85
[   65.597980]  sysfs_warn_dup+0x5b/0x70
[   65.598532]  sysfs_create_dir_ns+0xbe/0xd0
[   65.599149]  kobject_add_internal+0xaa/0x2c0
[   65.599789]  kobject_init_and_add+0x6f/0xb0
[   65.600418]  sysfs_slab_add+0x1bd/0x280
[   65.601017]  __kmem_cache_create+0x4f0/0x580
[   65.601657]  ? kvasprintf+0x7d/0xd0
[   65.602183]  ? _cond_resched+0x1a/0x50
[   65.602749]  ? kmem_cache_alloc+0x164/0x1d0
[   65.603376]  create_cache+0xde/0x1e0
[   65.603916]  memcg_create_kmem_cache+0x109/0x130
[   65.604606]  memcg_kmem_cache_create_func+0x20/0x70
[   65.605356]  process_one_work+0x167/0x410
[   65.605958]  worker_thread+0x4d/0x460
[   65.606509]  kthread+0x105/0x140
[   65.606998]  ? rescuer_thread+0x360/0x360
[   65.607600]  ? kthread_destroy_worker+0x50/0x50
[   65.608276]  ret_from_fork+0x35/0x40
[   65.608845] kobject_add_internal failed for
filp(503:systemd-timesyncd.service) with -EEXIST, don't try to register things
with the same name in the same directory.
[   65.611244] sysfs: cannot create duplicate filename
'/kernel/slab/dentry/cgroup/dentry(503:systemd-timesyncd.service)'
[   65.612859] CPU: 0 PID: 12 Comm: kworker/0:1 Tainted: G      D W        
5.0.0 #3
[   65.613972] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   65.615372] Workqueue: memcg_kmem_cache memcg_kmem_cache_create_func
[   65.616318] Call Trace:
[   65.616716]  dump_stack+0x63/0x85
[   65.617220]  sysfs_warn_dup+0x5b/0x70
[   65.617774]  sysfs_create_dir_ns+0xbe/0xd0
[   65.618392]  kobject_add_internal+0xaa/0x2c0
[   65.619034]  kobject_init_and_add+0x6f/0xb0
[   65.619666]  sysfs_slab_add+0x1bd/0x280
[   65.620246]  __kmem_cache_create+0x4f0/0x580
[   65.620892]  ? kvasprintf+0x7d/0xd0
[   65.621420]  ? _cond_resched+0x1a/0x50
[   65.621987]  ? kmem_cache_alloc+0x164/0x1d0
[   65.622618]  create_cache+0xde/0x1e0
[   65.623159]  memcg_create_kmem_cache+0x109/0x130
[   65.623852]  memcg_kmem_cache_create_func+0x20/0x70
[   65.624583]  process_one_work+0x167/0x410
[   65.625214]  worker_thread+0x4d/0x460
[   65.625768]  kthread+0x105/0x140
[   65.626259]  ? rescuer_thread+0x360/0x360
[   65.626863]  ? kthread_destroy_worker+0x50/0x50
[   65.627543]  ret_from_fork+0x35/0x40
[   65.628093] kobject_add_internal failed for
dentry(503:systemd-timesyncd.service) with -EEXIST, don't try to register
things with the same name in the same directory.
[   65.630557] sysfs: cannot create duplicate filename
'/kernel/slab/:A-0000256/cgroup/filp(503:systemd-timesyncd.service)'
[   65.632173] CPU: 0 PID: 12 Comm: kworker/0:1 Tainted: G      D W        
5.0.0 #3
[   65.633307] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   65.634708] Workqueue: memcg_kmem_cache memcg_kmem_cache_create_func
[   65.635649] Call Trace:
[   65.636026]  dump_stack+0x63/0x85
[   65.636529]  sysfs_warn_dup+0x5b/0x70
[   65.637106]  sysfs_create_dir_ns+0xbe/0xd0
[   65.637723]  kobject_add_internal+0xaa/0x2c0
[   65.638364]  kobject_init_and_add+0x6f/0xb0
[   65.638994]  sysfs_slab_add+0x1bd/0x280
[   65.639574]  __kmem_cache_create+0x4f0/0x580
[   65.640214]  ? kvasprintf+0x7d/0xd0
[   65.640762]  ? _cond_resched+0x1a/0x50
[   65.641328]  ? kmem_cache_alloc+0x164/0x1d0
[   65.641958]  create_cache+0xde/0x1e0
[   65.642499]  memcg_create_kmem_cache+0x109/0x130
[   65.643193]  memcg_kmem_cache_create_func+0x20/0x70
[   65.643925]  process_one_work+0x167/0x410
[   65.644530]  worker_thread+0x4d/0x460
[   65.645107]  kthread+0x105/0x140
[   65.645599]  ? rescuer_thread+0x360/0x360
[   65.646202]  ? kthread_destroy_worker+0x50/0x50
[   65.646881]  ret_from_fork+0x35/0x40
[   65.647430] kobject_add_internal failed for
filp(503:systemd-timesyncd.service) with -EEXIST, don't try to register things
with the same name in the same directory.
[   65.649863] sysfs: cannot create duplicate filename
'/kernel/slab/dentry/cgroup/dentry(503:systemd-timesyncd.service)'
[   65.651452] CPU: 0 PID: 12 Comm: kworker/0:1 Tainted: G      D W        
5.0.0 #3
[   65.652564] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   65.654012] Workqueue: memcg_kmem_cache memcg_kmem_cache_create_func
[   65.654958] Call Trace:
[   65.655336]  dump_stack+0x63/0x85
[   65.655840]  sysfs_warn_dup+0x5b/0x70
[   65.656394]  sysfs_create_dir_ns+0xbe/0xd0
[   65.657032]  kobject_add_internal+0xaa/0x2c0
[   65.657675]  kobject_init_and_add+0x6f/0xb0
[   65.658305]  sysfs_slab_add+0x1bd/0x280
[   65.658885]  __kmem_cache_create+0x4f0/0x580
[   65.659528]  ? kvasprintf+0x7d/0xd0
[   65.660057]  ? _cond_resched+0x1a/0x50
[   65.660623]  ? kmem_cache_alloc+0x164/0x1d0
[   65.661275]  create_cache+0xde/0x1e0
[   65.661816]  memcg_create_kmem_cache+0x109/0x130
[   65.662509]  memcg_kmem_cache_create_func+0x20/0x70
[   65.663260]  process_one_work+0x167/0x410
[   65.663865]  worker_thread+0x4d/0x460
[   65.664418]  kthread+0x105/0x140
[   65.664929]  ? rescuer_thread+0x360/0x360
[   65.665534]  ? kthread_destroy_worker+0x50/0x50
[   65.666215]  ret_from_fork+0x35/0x40
[   65.666766] kobject_add_internal failed for
dentry(503:systemd-timesyncd.service) with -EEXIST, don't try to register
things with the same name in the same directory.
[   65.668996] Kernel panic - not syncing: corrupted stack end detected inside
scheduler
[   65.670558] Kernel Offset: 0x3400000 from 0xffffffff81000000 (relocation
range: 0xffffffff80000000-0xffffffffbfffffff)
[   65.672141] ---[ end Kernel panic - not syncing: corrupted stack end
detected inside scheduler ]---

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
