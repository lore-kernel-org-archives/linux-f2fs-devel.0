From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 203345] New: page fault and hang on mounting
 crafted image and running program
Date: Wed, 17 Apr 2019 00:58:04 +0000
Message-ID: <bug-203345-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1hGYu0-00022t-6K
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Apr 2019 00:58:16 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hGYty-00BQBS-Mv
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Apr 2019 00:58:16 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 05FE628A19
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 17 Apr 2019 00:58:09 +0000 (UTC)
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

https://bugzilla.kernel.org/show_bug.cgi?id=203345

            Bug ID: 203345
           Summary: page fault and hang on mounting crafted image and
                    running program
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

Created attachment 282367
  --> https://bugzilla.kernel.org/attachment.cgi?id=282367&action=edit
image and program

- Overview
When mounting the attached crafted image and running program, I got this error.
The image is intentionally fuzzed from a normal f2fs image for testing.
Additionally, it hangs after this running program.

- Produces
cc poc_14.c
./run.sh f2fs

- Kernel Messages
[   80.377610] F2FS-fs (sdb): Can't find valid F2FS filesystem in 2th
superblock
[   80.494744] BUG: unable to handle kernel NULL pointer dereference at
0000000000000009
[   80.496367] #PF error: [WRITE]
[   80.497004] PGD 0 P4D 0 
[   80.497550] Oops: 0002 [#1] SMP PTI
[   80.498259] CPU: 0 PID: 1068 Comm: a.out Not tainted 5.0.0 #3
[   80.499376] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   80.501210] RIP: 0010:down_write+0x1f/0x40
[   80.502019] Code: 90 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 48 89
e5 53 48 89 fb e8 2e d8 ff ff 48 ba 01 00 00 00 ff ff ff ff 48 89 d8 <3e> 48 0f
c1 10 85 d2 74 05 e8 93 15 ff ff 65 48 8b 04 25 00 5c 01
[   80.505606] RSP: 0018:ffffac144109fd20 EFLAGS: 00010246
[   80.506627] RAX: 0000000000000009 RBX: 0000000000000009 RCX:
0000000000603000
[   80.508005] RDX: ffffffff00000001 RSI: ffff8fa5ab38bbe0 RDI:
0000000000000009
[   80.509392] RBP: ffffac144109fd28 R08: 0000000000602000 R09:
ffff8fa5aa8f3320
[   80.510657] R10: ffffac144109fca8 R11: 0000000000000000 R12:
0000000000000001
[   80.511869] R13: ffff8fa5ab38bbd0 R14: ffff8fa5aa8f3848 R15:
ffff8fa5ab38bfe0
[   80.513085] FS:  0000000000000000(0000) GS:ffff8fa5b7a00000(0000)
knlGS:0000000000000000
[   80.514452] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   80.515428] CR2: 0000000000000009 CR3: 000000013260e005 CR4:
00000000001606f0
[   80.516640] Call Trace:
[   80.517074]  unlink_anon_vmas+0xad/0x1b0
[   80.517756]  free_pgtables+0xa1/0x120
[   80.518393]  exit_mmap+0xdc/0x1c0
[   80.518971]  mmput+0x57/0x140
[   80.519486]  do_exit+0x284/0xba0
[   80.520045]  ? __do_page_fault+0x2d2/0x4c0
[   80.520746]  do_group_exit+0x43/0xb0
[   80.521364]  __x64_sys_exit_group+0x18/0x20
[   80.522097]  do_syscall_64+0x5a/0x110
[   80.522730]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   80.523592] RIP: 0033:0x7f5d080b0748
[   80.524217] Code: Bad RIP value.
[   80.524778] RSP: 002b:00007ffd8a9f7428 EFLAGS: 00000246 ORIG_RAX:
00000000000000e7
[   80.526070] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f5d080b0748
[   80.527278] RDX: 0000000000000000 RSI: 000000000000003c RDI:
0000000000000000
[   80.528483] RBP: 00007f5d083a48e0 R08: 00000000000000e7 R09:
ffffffffffffff98
[   80.529700] R10: 00007ffd8a9f7378 R11: 0000000000000246 R12:
00007f5d083a48e0
[   80.530917] R13: 00007f5d083a9c40 R14: 0000000000000000 R15:
0000000000000000
[   80.532124] Modules linked in:
[   80.532656] CR2: 0000000000000009
[   80.533229] ---[ end trace 53d0a41cadff5099 ]---
[   80.534026] RIP: 0010:down_write+0x1f/0x40
[   80.534729] Code: 90 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 48 89
e5 53 48 89 fb e8 2e d8 ff ff 48 ba 01 00 00 00 ff ff ff ff 48 89 d8 <3e> 48 0f
c1 10 85 d2 74 05 e8 93 15 ff ff 65 48 8b 04 25 00 5c 01
[   80.537888] RSP: 0018:ffffac144109fd20 EFLAGS: 00010246
[   80.538781] RAX: 0000000000000009 RBX: 0000000000000009 RCX:
0000000000603000
[   80.539995] RDX: ffffffff00000001 RSI: ffff8fa5ab38bbe0 RDI:
0000000000000009
[   80.541204] RBP: ffffac144109fd28 R08: 0000000000602000 R09:
ffff8fa5aa8f3320
[   80.542419] R10: ffffac144109fca8 R11: 0000000000000000 R12:
0000000000000001
[   80.543629] R13: ffff8fa5ab38bbd0 R14: ffff8fa5aa8f3848 R15:
ffff8fa5ab38bfe0
[   80.544841] FS:  0000000000000000(0000) GS:ffff8fa5b7a00000(0000)
knlGS:0000000000000000
[   80.546222] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   80.547206] CR2: 00007f5d080b071e CR3: 000000013260e005 CR4:
00000000001606f0
[   80.548417] Fixing recursive fault but reboot is needed!

[   95.810728] general protection fault: 0000 [#2] SMP PTI
[   95.812471] CPU: 0 PID: 506 Comm: sd-resolve Tainted: G      D          
5.0.0 #3
[   95.814857] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   95.817855] RIP: 0010:kmem_cache_alloc+0x88/0x1d0
[   95.819353] Code: 65 49 8b 50 08 65 4c 03 05 8d e6 59 5f 4d 8b 28 4d 85 ed
0f 84 10 01 00 00 41 8b 5f 20 48 8d 4a 01 49 8b 3f 4c 89 e8 4c 01 eb <48> 33 1b
49 33 9f 38 01 00 00 65 48 0f c7 0f 0f 94 c0 84 c0 74 bd
[   95.825237] RSP: 0018:ffffac14412bfd78 EFLAGS: 00010282
[   95.826754] RAX: c42e2bea4bc34edc RBX: c42e2bea4bc34edc RCX:
00000000000001a2
[   95.827993] RDX: 00000000000001a1 RSI: 00000000006080c0 RDI:
00003c6e882167d0
[   95.829212] RBP: ffffac14412bfda8 R08: ffffcc143fc167d0 R09:
ffffffffffffe000
[   95.830432] R10: ffffac14412bfec8 R11: 0000000000000000 R12:
00000000006080c0
[   95.831646] R13: c42e2bea4bc34edc R14: ffff8fa5b756d780 R15:
ffff8fa5b1f75900
[   95.832860] FS:  00007fea472b3700(0000) GS:ffff8fa5b7a00000(0000)
knlGS:0000000000000000
[   95.834238] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   95.835218] CR2: 00007feb0a58d000 CR3: 0000000234d82001 CR4:
00000000001606f0
[   95.836444] Call Trace:
[   95.836881]  ? __alloc_file+0x29/0x100
[   95.837539]  __alloc_file+0x29/0x100
[   95.838160]  ? kmem_cache_alloc+0x164/0x1d0
[   95.838883]  alloc_empty_file+0x4a/0xf0
[   95.839544]  alloc_file+0x2d/0xf0
[   95.840120]  alloc_file_pseudo+0xb7/0x120
[   95.840812]  sock_alloc_file+0x38/0x90
[   95.841466]  ? sock_alloc_file+0x38/0x90
[   95.842144]  __sys_socket+0x88/0xe0
[   95.842748]  __x64_sys_socket+0x1a/0x20
[   95.843413]  do_syscall_64+0x5a/0x110
[   95.844047]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   95.844911] RIP: 0033:0x7fea47bfc5a7
[   95.845538] Code: 73 01 c3 48 8b 0d f1 b8 2b 00 f7 d8 64 89 01 48 83 c8 ff
c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 29 00 00 00 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d c1 b8 2b 00 f7 d8 64 89 01 48
[   95.848689] RSP: 002b:00007fea472abd38 EFLAGS: 00000246 ORIG_RAX:
0000000000000029
[   95.849979] RAX: ffffffffffffffda RBX: 00000000ffffffff RCX:
00007fea47bfc5a7
[   95.851188] RDX: 0000000000000000 RSI: 0000000000000802 RDI:
0000000000000002
[   95.852398] RBP: 00007fea472b3db8 R08: 0000000000000000 R09:
00007fea472acbe0
[   95.853613] R10: 0000000000000800 R11: 0000000000000246 R12:
00007fea472b3db8
[   95.854820] R13: 00007fea472abe68 R14: 00007fea472b3dcc R15:
00007fea472b3db8
[   95.856032] Modules linked in:
[   95.856585] ---[ end trace 53d0a41cadff509a ]---
[   95.857387] RIP: 0010:down_write+0x1f/0x40
[   95.858100] Code: 90 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 48 89
e5 53 48 89 fb e8 2e d8 ff ff 48 ba 01 00 00 00 ff ff ff ff 48 89 d8 <3e> 48 0f
c1 10 85 d2 74 05 e8 93 15 ff ff 65 48 8b 04 25 00 5c 01
[   95.861253] RSP: 0018:ffffac144109fd20 EFLAGS: 00010246
[   95.862146] RAX: 0000000000000009 RBX: 0000000000000009 RCX:
0000000000603000
[   95.863358] RDX: ffffffff00000001 RSI: ffff8fa5ab38bbe0 RDI:
0000000000000009
[   95.864574] RBP: ffffac144109fd28 R08: 0000000000602000 R09:
ffff8fa5aa8f3320
[   95.865790] R10: ffffac144109fca8 R11: 0000000000000000 R12:
0000000000000001
[   95.866998] R13: ffff8fa5ab38bbd0 R14: ffff8fa5aa8f3848 R15:
ffff8fa5ab38bfe0
[   95.868217] FS:  00007fea472b3700(0000) GS:ffff8fa5b7a00000(0000)
knlGS:0000000000000000
[   95.869588] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   95.870574] CR2: 00007feb0a58d000 CR3: 0000000234d82001 CR4:
00000000001606f0
[  111.051136] F2FS-fs (sdb): inconsistent node block, nid:12,
node_footer[nid:0,ino:0,ofs:0,cpver:4294967297,blkaddr:0]

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
