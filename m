From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 203209] New: crash at f2fs_is_valid_blkaddr
Date: Tue, 09 Apr 2019 19:56:57 +0000
Message-ID: <bug-203209-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1hDwrl-0002RN-HU
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Apr 2019 19:57:09 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hDwri-00ACeH-1G
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Apr 2019 19:57:09 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 5F1A5288F8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  9 Apr 2019 19:57:00 +0000 (UTC)
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

https://bugzilla.kernel.org/show_bug.cgi?id=203209

            Bug ID: 203209
           Summary: crash at f2fs_is_valid_blkaddr
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

Created attachment 282197
  --> https://bugzilla.kernel.org/attachment.cgi?id=282197&action=edit
The (compressed) crafted image which causes crash

- Overview
When mounting the attached crafted image and running program, I got this error.
Additionally, it hangs on sync after the this script.

The image is intentionally fuzzed from a normal f2fs image for testing and I
enabled option CONFIG_F2FS_CHECK_FS on.

- Reproduces
cc poc_01.c
./run.sh f2fs
sync

- Messages
[   37.059784] F2FS-fs (sdb): Mounted with checkpoint version = 7548c2d6
[   37.083706] F2FS-fs (sdb): sanity_check_inode: corrupted inode footer
i_ino=8, ino,nid: [1048584, 8] run fsck to fix.
[   37.089282] F2FS-fs (sdb): sanity_check_inode: corrupted inode footer
i_ino=8, ino,nid: [1048584, 8] run fsck to fix.
[   37.089313] F2FS-fs (sdb): access invalid blkaddr:3101294592
[   37.089332] WARNING: CPU: 0 PID: 1898 at fs/f2fs/checkpoint.c:160
f2fs_is_valid_blkaddr+0x119/0x170
[   37.089333] Modules linked in:
[   37.089335] CPU: 0 PID: 1898 Comm: a.out Not tainted 5.0.0 #4
[   37.089336] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   37.089338] RIP: 0010:f2fs_is_valid_blkaddr+0x119/0x170
[   37.089339] Code: 00 eb ed 31 c0 83 fa 06 75 a8 48 83 ec 08 48 8b 3f 89 f1
48 c7 c2 74 5e 81 be 48 c7 c6 9f bc 7d be 88 44 24 07 e8 c7 90 ff ff <0f> 0b 0f
b6 44 24 07 48 83 c4 08 e9 78 ff ff ff 4c 8b 47 10 8b 8f
[   37.089340] RSP: 0018:ffff939f00d3bd08 EFLAGS: 00010286
[   37.089341] RAX: 0000000000000000 RBX: 0000000000000002 RCX:
0000000000000006
[   37.089342] RDX: 0000000000000000 RSI: 0000000000000096 RDI:
ffff922977a15410
[   37.089343] RBP: ffff92296bbcbf0c R08: 0000000000007da8 R09:
ffffffffbf0ca614
[   37.089343] R10: 000000000000001c R11: 00000000000001b4 R12:
ffff92296ed5a800
[   37.089344] R13: ffff939f00d3bd60 R14: 00000000b8da0000 R15:
ffff92296bbcb214
[   37.089346] FS:  00007f18eb285700(0000) GS:ffff922977a00000(0000)
knlGS:0000000000000000
[   37.089349] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.089349] CR2: 00007fff363e2ff8 CR3: 000000023454a002 CR4:
00000000001606f0
[   37.089350] Call Trace:
[   37.089366]  f2fs_truncate_data_blocks_range+0xc3/0x350
[   37.089368]  f2fs_truncate_blocks+0x36d/0x3c0
[   37.089370]  f2fs_truncate+0x88/0x110
[   37.089371]  f2fs_setattr+0x3e1/0x460
[   37.089375]  notify_change+0x2da/0x400
[   37.089380]  do_truncate+0x6d/0xb0
[   37.089382]  do_sys_ftruncate+0xf1/0x160
[   37.089385]  do_syscall_64+0x43/0xf0
[   37.089389]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   37.089391] RIP: 0033:0x7f18eada04d9
[   37.089392] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d 8f 29 2c 00 f7 d8 64 89 01 48
[   37.089393] RSP: 002b:00007fff363e2ff8 EFLAGS: 00000217 ORIG_RAX:
000000000000004d
[   37.089394] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f18eada04d9
[   37.089394] RDX: 00007f18eada04d9 RSI: 0000000000001816 RDI:
0000000000000004
[   37.089395] RBP: 00007fff363e7210 R08: 00007fff363e72f8 R09:
00007fff363e72f8
[   37.089396] R10: 00007fff363e72f8 R11: 0000000000000217 R12:
00000000004004e0
[   37.089397] R13: 00007fff363e72f0 R14: 0000000000000000 R15:
0000000000000000
[   37.089398] ---[ end trace 5e252472d7d424fe ]---
[   37.089399] F2FS-fs (sdb): access invalid blkaddr:3268846199
[   37.089407] WARNING: CPU: 0 PID: 1898 at fs/f2fs/checkpoint.c:160
f2fs_is_valid_blkaddr+0x119/0x170
[   37.089407] Modules linked in:
[   37.089408] CPU: 0 PID: 1898 Comm: a.out Tainted: G        W         5.0.0
#4
[   37.089409] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   37.089410] RIP: 0010:f2fs_is_valid_blkaddr+0x119/0x170
[   37.089411] Code: 00 eb ed 31 c0 83 fa 06 75 a8 48 83 ec 08 48 8b 3f 89 f1
48 c7 c2 74 5e 81 be 48 c7 c6 9f bc 7d be 88 44 24 07 e8 c7 90 ff ff <0f> 0b 0f
b6 44 24 07 48 83 c4 08 e9 78 ff ff ff 4c 8b 47 10 8b 8f
[   37.089412] RSP: 0018:ffff939f00d3bd08 EFLAGS: 00010286
[   37.089413] RAX: 0000000000000000 RBX: 0000000000000002 RCX:
0000000000000006
[   37.089413] RDX: 0000000000000000 RSI: 0000000000000096 RDI:
ffff922977a15410
[   37.089414] RBP: ffff92296bbcbf0c R08: 0000000000008804 R09:
ffffffffbf0ca614
[   37.089427] R10: 000000000000001c R11: 00000000000001d7 R12:
ffff92296ed5a800
[   37.089427] R13: ffff939f00d3bd60 R14: 00000000c2d6a277 R15:
ffff92296bbcb218
[   37.089428] FS:  00007f18eb285700(0000) GS:ffff922977a00000(0000)
knlGS:0000000000000000
[   37.089431] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.089431] CR2: 00007fff363e2ff8 CR3: 000000023454a002 CR4:
00000000001606f0
[   37.089432] Call Trace:
[   37.089433]  f2fs_truncate_data_blocks_range+0xc3/0x350
[   37.089435]  f2fs_truncate_blocks+0x36d/0x3c0
[   37.089436]  f2fs_truncate+0x88/0x110
[   37.089438]  f2fs_setattr+0x3e1/0x460
[   37.089440]  notify_change+0x2da/0x400
[   37.089442]  do_truncate+0x6d/0xb0
[   37.089444]  do_sys_ftruncate+0xf1/0x160
[   37.089445]  do_syscall_64+0x43/0xf0
[   37.089447]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   37.089448] RIP: 0033:0x7f18eada04d9
[   37.089449] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d 8f 29 2c 00 f7 d8 64 89 01 48
[   37.089449] RSP: 002b:00007fff363e2ff8 EFLAGS: 00000217 ORIG_RAX:
000000000000004d
[   37.089450] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f18eada04d9
[   37.089451] RDX: 00007f18eada04d9 RSI: 0000000000001816 RDI:
0000000000000004
[   37.089452] RBP: 00007fff363e7210 R08: 00007fff363e72f8 R09:
00007fff363e72f8
[   37.089452] R10: 00007fff363e72f8 R11: 0000000000000217 R12:
00000000004004e0
[   37.089453] R13: 00007fff363e72f0 R14: 0000000000000000 R15:
0000000000000000
[   37.089454] ---[ end trace 5e252472d7d424ff ]---
[   37.089455] F2FS-fs (sdb): access invalid blkaddr:30024
[   37.089462] WARNING: CPU: 0 PID: 1898 at fs/f2fs/checkpoint.c:160
f2fs_is_valid_blkaddr+0x119/0x170
[   37.089462] Modules linked in:
[   37.089475] CPU: 0 PID: 1898 Comm: a.out Tainted: G        W         5.0.0
#4
[   37.089475] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   37.089477] RIP: 0010:f2fs_is_valid_blkaddr+0x119/0x170
[   37.089477] Code: 00 eb ed 31 c0 83 fa 06 75 a8 48 83 ec 08 48 8b 3f 89 f1
48 c7 c2 74 5e 81 be 48 c7 c6 9f bc 7d be 88 44 24 07 e8 c7 90 ff ff <0f> 0b 0f
b6 44 24 07 48 83 c4 08 e9 78 ff ff ff 4c 8b 47 10 8b 8f
[   37.089478] RSP: 0018:ffff939f00d3bd08 EFLAGS: 00010286
[   37.089479] RAX: 0000000000000000 RBX: 0000000000000002 RCX:
0000000000000006
[   37.089479] RDX: 0000000000000000 RSI: 0000000000000096 RDI:
ffff922977a15410
[   37.089480] RBP: ffff92296bbcbf0c R08: 000000000000926c R09:
ffffffffbf0ca614
[   37.089481] R10: 000000000000001c R11: 00000000000001fa R12:
ffff92296ed5a800
[   37.089481] R13: ffff939f00d3bd60 R14: 0000000000007548 R15:
ffff92296bbcb21c
[   37.089482] FS:  00007f18eb285700(0000) GS:ffff922977a00000(0000)
knlGS:0000000000000000
[   37.089484] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.089485] CR2: 00007fff363e2ff8 CR3: 000000023454a002 CR4:
00000000001606f0
[   37.089485] Call Trace:
[   37.089487]  f2fs_truncate_data_blocks_range+0xc3/0x350
[   37.089488]  f2fs_truncate_blocks+0x36d/0x3c0
[   37.089490]  f2fs_truncate+0x88/0x110
[   37.089491]  f2fs_setattr+0x3e1/0x460
[   37.089493]  notify_change+0x2da/0x400
[   37.089495]  do_truncate+0x6d/0xb0
[   37.089497]  do_sys_ftruncate+0xf1/0x160
[   37.089498]  do_syscall_64+0x43/0xf0
[   37.089500]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   37.089500] RIP: 0033:0x7f18eada04d9
[   37.089501] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d 8f 29 2c 00 f7 d8 64 89 01 48
[   37.089502] RSP: 002b:00007fff363e2ff8 EFLAGS: 00000217 ORIG_RAX:
000000000000004d
[   37.089503] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f18eada04d9
[   37.089503] RDX: 00007f18eada04d9 RSI: 0000000000001816 RDI:
0000000000000004
[   37.089504] RBP: 00007fff363e7210 R08: 00007fff363e72f8 R09:
00007fff363e72f8
[   37.089505] R10: 00007fff363e72f8 R11: 0000000000000217 R12:
00000000004004e0
[   37.089505] R13: 00007fff363e72f0 R14: 0000000000000000 R15:
0000000000000000
[   37.089506] ---[ end trace 5e252472d7d42500 ]---
[   37.089507] F2FS-fs (sdb): access invalid blkaddr:268435456
[   37.089513] WARNING: CPU: 0 PID: 1898 at fs/f2fs/checkpoint.c:160
f2fs_is_valid_blkaddr+0x119/0x170
[   37.089514] Modules linked in:
[   37.089515] CPU: 0 PID: 1898 Comm: a.out Tainted: G        W         5.0.0
#4
[   37.089515] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   37.089516] RIP: 0010:f2fs_is_valid_blkaddr+0x119/0x170
[   37.089517] Code: 00 eb ed 31 c0 83 fa 06 75 a8 48 83 ec 08 48 8b 3f 89 f1
48 c7 c2 74 5e 81 be 48 c7 c6 9f bc 7d be 88 44 24 07 e8 c7 90 ff ff <0f> 0b 0f
b6 44 24 07 48 83 c4 08 e9 78 ff ff ff 4c 8b 47 10 8b 8f
[   37.089518] RSP: 0018:ffff939f00d3bd08 EFLAGS: 00010286
[   37.089518] RAX: 0000000000000000 RBX: 0000000000000002 RCX:
0000000000000006
[   37.089519] RDX: 0000000000000000 RSI: 0000000000000096 RDI:
ffff922977a15410
[   37.089520] RBP: ffff92296bbcbf0c R08: 0000000000009cd8 R09:
ffffffffbf0ca614
[   37.089520] R10: 000000000000001c R11: 000000000000021d R12:
ffff92296ed5a800
[   37.089521] R13: ffff939f00d3bd60 R14: 0000000010000000 R15:
ffff92296bbcb220
[   37.089522] FS:  00007f18eb285700(0000) GS:ffff922977a00000(0000)
knlGS:0000000000000000
[   37.089524] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.089525] CR2: 00007fff363e2ff8 CR3: 000000023454a002 CR4:
00000000001606f0
[   37.089525] Call Trace:
[   37.089526]  f2fs_truncate_data_blocks_range+0xc3/0x350
[   37.089528]  f2fs_truncate_blocks+0x36d/0x3c0
[   37.089529]  f2fs_truncate+0x88/0x110
[   37.089531]  f2fs_setattr+0x3e1/0x460
[   37.089532]  notify_change+0x2da/0x400
[   37.089534]  do_truncate+0x6d/0xb0
[   37.089536]  do_sys_ftruncate+0xf1/0x160
[   37.089537]  do_syscall_64+0x43/0xf0
[   37.089539]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   37.089540] RIP: 0033:0x7f18eada04d9
[   37.089541] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d 8f 29 2c 00 f7 d8 64 89 01 48
[   37.089541] RSP: 002b:00007fff363e2ff8 EFLAGS: 00000217 ORIG_RAX:
000000000000004d
[   37.089542] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f18eada04d9
[   37.089543] RDX: 00007f18eada04d9 RSI: 0000000000001816 RDI:
0000000000000004
[   37.089543] RBP: 00007fff363e7210 R08: 00007fff363e72f8 R09:
00007fff363e72f8
[   37.089544] R10: 00007fff363e72f8 R11: 0000000000000217 R12:
00000000004004e0
[   37.089545] R13: 00007fff363e72f0 R14: 0000000000000000 R15:
0000000000000000
[   37.089545] ---[ end trace 5e252472d7d42501 ]---
[   37.089546] F2FS-fs (sdb): access invalid blkaddr:655360
[   37.089553] WARNING: CPU: 0 PID: 1898 at fs/f2fs/checkpoint.c:160
f2fs_is_valid_blkaddr+0x119/0x170
[   37.089553] Modules linked in:
[   37.089554] CPU: 0 PID: 1898 Comm: a.out Tainted: G        W         5.0.0
#4
[   37.089555] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   37.089556] RIP: 0010:f2fs_is_valid_blkaddr+0x119/0x170
[   37.089557] Code: 00 eb ed 31 c0 83 fa 06 75 a8 48 83 ec 08 48 8b 3f 89 f1
48 c7 c2 74 5e 81 be 48 c7 c6 9f bc 7d be 88 44 24 07 e8 c7 90 ff ff <0f> 0b 0f
b6 44 24 07 48 83 c4 08 e9 78 ff ff ff 4c 8b 47 10 8b 8f
[   37.089557] RSP: 0018:ffff939f00d3bd08 EFLAGS: 00010286
[   37.089558] RAX: 0000000000000000 RBX: 0000000000000002 RCX:
0000000000000006
[   37.089559] RDX: 0000000000000000 RSI: 0000000000000096 RDI:
ffff922977a15410
[   37.089559] RBP: ffff92296bbcbf0c R08: 000000000000a740 R09:
ffffffffbf0ca614
[   37.089560] R10: 000000000000001c R11: 0000000000000240 R12:
ffff92296ed5a800
[   37.089560] R13: ffff939f00d3bd60 R14: 00000000000a0000 R15:
ffff92296bbcb228
[   37.089561] FS:  00007f18eb285700(0000) GS:ffff922977a00000(0000)
knlGS:0000000000000000
[   37.089563] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.089564] CR2: 00007fff363e2ff8 CR3: 000000023454a002 CR4:
00000000001606f0
[   37.089564] Call Trace:
[   37.089566]  f2fs_truncate_data_blocks_range+0xc3/0x350
[   37.089567]  f2fs_truncate_blocks+0x36d/0x3c0
[   37.089569]  f2fs_truncate+0x88/0x110
[   37.089570]  f2fs_setattr+0x3e1/0x460
[   37.089572]  notify_change+0x2da/0x400
[   37.089574]  do_truncate+0x6d/0xb0
[   37.089576]  do_sys_ftruncate+0xf1/0x160
[   37.089577]  do_syscall_64+0x43/0xf0
[   37.089579]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   37.089579] RIP: 0033:0x7f18eada04d9
[   37.089580] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d 8f 29 2c 00 f7 d8 64 89 01 48
[   37.089581] RSP: 002b:00007fff363e2ff8 EFLAGS: 00000217 ORIG_RAX:
000000000000004d
[   37.089581] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f18eada04d9
[   37.089582] RDX: 00007f18eada04d9 RSI: 0000000000001816 RDI:
0000000000000004
[   37.089583] RBP: 00007fff363e7210 R08: 00007fff363e72f8 R09:
00007fff363e72f8
[   37.089583] R10: 00007fff363e72f8 R11: 0000000000000217 R12:
00000000004004e0
[   37.089584] R13: 00007fff363e72f0 R14: 0000000000000000 R15:
0000000000000000
[   37.089585] ---[ end trace 5e252472d7d42502 ]---
[   37.089586] F2FS-fs (sdb): access invalid blkaddr:851968
[   37.089592] WARNING: CPU: 0 PID: 1898 at fs/f2fs/checkpoint.c:160
f2fs_is_valid_blkaddr+0x119/0x170
[   37.089592] Modules linked in:
[   37.089593] CPU: 0 PID: 1898 Comm: a.out Tainted: G        W         5.0.0
#4
[   37.089594] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   37.089595] RIP: 0010:f2fs_is_valid_blkaddr+0x119/0x170
[   37.089596] Code: 00 eb ed 31 c0 83 fa 06 75 a8 48 83 ec 08 48 8b 3f 89 f1
48 c7 c2 74 5e 81 be 48 c7 c6 9f bc 7d be 88 44 24 07 e8 c7 90 ff ff <0f> 0b 0f
b6 44 24 07 48 83 c4 08 e9 78 ff ff ff 4c 8b 47 10 8b 8f
[   37.089596] RSP: 0018:ffff939f00d3bd08 EFLAGS: 00010286
[   37.089597] RAX: 0000000000000000 RBX: 0000000000000002 RCX:
0000000000000006
[   37.089598] RDX: 0000000000000000 RSI: 0000000000000096 RDI:
ffff922977a15410
[   37.089598] RBP: ffff92296bbcbf0c R08: 000000000000b1a8 R09:
ffffffffbf0ca614
[   37.089599] R10: 000000000000001c R11: 0000000000000263 R12:
ffff92296ed5a800
[   37.089600] R13: ffff939f00d3bd60 R14: 00000000000d0000 R15:
ffff92296bbcb230
[   37.089601] FS:  00007f18eb285700(0000) GS:ffff922977a00000(0000)
knlGS:0000000000000000
[   37.089603] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.089603] CR2: 00007fff363e2ff8 CR3: 000000023454a002 CR4:
00000000001606f0
[   37.089604] Call Trace:
[   37.089605]  f2fs_truncate_data_blocks_range+0xc3/0x350
[   37.089606]  f2fs_truncate_blocks+0x36d/0x3c0
[   37.089608]  f2fs_truncate+0x88/0x110
[   37.089609]  f2fs_setattr+0x3e1/0x460
[   37.089611]  notify_change+0x2da/0x400
[   37.089613]  do_truncate+0x6d/0xb0
[   37.089615]  do_sys_ftruncate+0xf1/0x160
[   37.089616]  do_syscall_64+0x43/0xf0
[   37.089618]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   37.089618] RIP: 0033:0x7f18eada04d9
[   37.089619] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d 8f 29 2c 00 f7 d8 64 89 01 48
[   37.089620] RSP: 002b:00007fff363e2ff8 EFLAGS: 00000217 ORIG_RAX:
000000000000004d
[   37.089621] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f18eada04d9
[   37.089621] RDX: 00007f18eada04d9 RSI: 0000000000001816 RDI:
0000000000000004
[   37.089622] RBP: 00007fff363e7210 R08: 00007fff363e72f8 R09:
00007fff363e72f8
[   37.089623] R10: 00007fff363e72f8 R11: 0000000000000217 R12:
00000000004004e0
[   37.089623] R13: 00007fff363e72f0 R14: 0000000000000000 R15:
0000000000000000
[   37.089624] ---[ end trace 5e252472d7d42503 ]---
[   37.089625] F2FS-fs (sdb): access invalid blkaddr:1048576
[   37.089631] WARNING: CPU: 0 PID: 1898 at fs/f2fs/checkpoint.c:160
f2fs_is_valid_blkaddr+0x119/0x170
[   37.089632] Modules linked in:
[   37.089633] CPU: 0 PID: 1898 Comm: a.out Tainted: G        W         5.0.0
#4
[   37.089633] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   37.089634] RIP: 0010:f2fs_is_valid_blkaddr+0x119/0x170
[   37.089635] Code: 00 eb ed 31 c0 83 fa 06 75 a8 48 83 ec 08 48 8b 3f 89 f1
48 c7 c2 74 5e 81 be 48 c7 c6 9f bc 7d be 88 44 24 07 e8 c7 90 ff ff <0f> 0b 0f
b6 44 24 07 48 83 c4 08 e9 78 ff ff ff 4c 8b 47 10 8b 8f
[   37.089636] RSP: 0018:ffff939f00d3bd08 EFLAGS: 00010286
[   37.089636] RAX: 0000000000000000 RBX: 0000000000000002 RCX:
0000000000000006
[   37.089637] RDX: 0000000000000000 RSI: 0000000000000096 RDI:
ffff922977a15410
[   37.089638] RBP: ffff92296bbcbf0c R08: 000000000000bc14 R09:
ffffffffbf0ca614
[   37.089638] R10: 000000000000001c R11: 0000000000000286 R12:
ffff92296ed5a800
[   37.089639] R13: ffff939f00d3bd60 R14: 0000000000100000 R15:
ffff92296bbcb234
[   37.089640] FS:  00007f18eb285700(0000) GS:ffff922977a00000(0000)
knlGS:0000000000000000
[   37.089642] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.089643] CR2: 00007fff363e2ff8 CR3: 000000023454a002 CR4:
00000000001606f0
[   37.089643] Call Trace:
[   37.089644]  f2fs_truncate_data_blocks_range+0xc3/0x350
[   37.089646]  f2fs_truncate_blocks+0x36d/0x3c0
[   37.089647]  f2fs_truncate+0x88/0x110
[   37.089648]  f2fs_setattr+0x3e1/0x460
[   37.089650]  notify_change+0x2da/0x400
[   37.089652]  do_truncate+0x6d/0xb0
[   37.089654]  do_sys_ftruncate+0xf1/0x160
[   37.089655]  do_syscall_64+0x43/0xf0
[   37.089657]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   37.089658] RIP: 0033:0x7f18eada04d9
[   37.089658] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d 8f 29 2c 00 f7 d8 64 89 01 48
[   37.089659] RSP: 002b:00007fff363e2ff8 EFLAGS: 00000217 ORIG_RAX:
000000000000004d
[   37.089660] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f18eada04d9
[   37.089660] RDX: 00007f18eada04d9 RSI: 0000000000001816 RDI:
0000000000000004
[   37.089661] RBP: 00007fff363e7210 R08: 00007fff363e72f8 R09:
00007fff363e72f8
[   37.089662] R10: 00007fff363e72f8 R11: 0000000000000217 R12:
00000000004004e0
[   37.089662] R13: 00007fff363e72f0 R14: 0000000000000000 R15:
0000000000000000
[   37.089663] ---[ end trace 5e252472d7d42504 ]---
[   37.089664] F2FS-fs (sdb): access invalid blkaddr:1179648
[   37.089670] WARNING: CPU: 0 PID: 1898 at fs/f2fs/checkpoint.c:160
f2fs_is_valid_blkaddr+0x119/0x170
[   37.089671] Modules linked in:
[   37.089672] CPU: 0 PID: 1898 Comm: a.out Tainted: G        W         5.0.0
#4
[   37.089672] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   37.089673] RIP: 0010:f2fs_is_valid_blkaddr+0x119/0x170
[   37.089674] Code: 00 eb ed 31 c0 83 fa 06 75 a8 48 83 ec 08 48 8b 3f 89 f1
48 c7 c2 74 5e 81 be 48 c7 c6 9f bc 7d be 88 44 24 07 e8 c7 90 ff ff <0f> 0b 0f
b6 44 24 07 48 83 c4 08 e9 78 ff ff ff 4c 8b 47 10 8b 8f
[   37.089675] RSP: 0018:ffff939f00d3bd08 EFLAGS: 00010286
[   37.089675] RAX: 0000000000000000 RBX: 0000000000000002 RCX:
0000000000000006
[   37.089676] RDX: 0000000000000000 RSI: 0000000000000096 RDI:
ffff922977a15410
[   37.089677] RBP: ffff92296bbcbf0c R08: 000000000000c680 R09:
ffffffffbf0ca614
[   37.089677] R10: 000000000000001c R11: 00000000000002a9 R12:
ffff92296ed5a800
[   37.089678] R13: ffff939f00d3bd60 R14: 0000000000120000 R15:
ffff92296bbcb238
[   37.089679] FS:  00007f18eb285700(0000) GS:ffff922977a00000(0000)
knlGS:0000000000000000
[   37.089681] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.089682] CR2: 00007fff363e2ff8 CR3: 000000023454a002 CR4:
00000000001606f0
[   37.089682] Call Trace:
[   37.089683]  f2fs_truncate_data_blocks_range+0xc3/0x350
[   37.089685]  f2fs_truncate_blocks+0x36d/0x3c0
[   37.089686]  f2fs_truncate+0x88/0x110
[   37.089687]  f2fs_setattr+0x3e1/0x460
[   37.089689]  notify_change+0x2da/0x400
[   37.089691]  do_truncate+0x6d/0xb0
[   37.089693]  do_sys_ftruncate+0xf1/0x160
[   37.089694]  do_syscall_64+0x43/0xf0
[   37.089696]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   37.089697] RIP: 0033:0x7f18eada04d9
[   37.089697] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d 8f 29 2c 00 f7 d8 64 89 01 48
[   37.089698] RSP: 002b:00007fff363e2ff8 EFLAGS: 00000217 ORIG_RAX:
000000000000004d
[   37.089699] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f18eada04d9
[   37.089699] RDX: 00007f18eada04d9 RSI: 0000000000001816 RDI:
0000000000000004
[   37.089700] RBP: 00007fff363e7210 R08: 00007fff363e72f8 R09:
00007fff363e72f8
[   37.089701] R10: 00007fff363e72f8 R11: 0000000000000217 R12:
00000000004004e0
[   37.089701] R13: 00007fff363e72f0 R14: 0000000000000000 R15:
0000000000000000
[   37.089702] ---[ end trace 5e252472d7d42505 ]---
[   37.089703] F2FS-fs (sdb): access invalid blkaddr:65536
[   37.089709] WARNING: CPU: 0 PID: 1898 at fs/f2fs/checkpoint.c:160
f2fs_is_valid_blkaddr+0x119/0x170
[   37.089710] Modules linked in:
[   37.089711] CPU: 0 PID: 1898 Comm: a.out Tainted: G        W         5.0.0
#4
[   37.089711] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   37.089712] RIP: 0010:f2fs_is_valid_blkaddr+0x119/0x170
[   37.089713] Code: 00 eb ed 31 c0 83 fa 06 75 a8 48 83 ec 08 48 8b 3f 89 f1
48 c7 c2 74 5e 81 be 48 c7 c6 9f bc 7d be 88 44 24 07 e8 c7 90 ff ff <0f> 0b 0f
b6 44 24 07 48 83 c4 08 e9 78 ff ff ff 4c 8b 47 10 8b 8f
[   37.089714] RSP: 0018:ffff939f00d3bd08 EFLAGS: 00010286
[   37.089714] RAX: 0000000000000000 RBX: 0000000000000002 RCX:
0000000000000006
[   37.089715] RDX: 0000000000000000 RSI: 0000000000000096 RDI:
ffff922977a15410
[   37.089716] RBP: ffff92296bbcbf0c R08: 000000000000d0e8 R09:
ffffffffbf0ca614
[   37.089716] R10: 000000000000001c R11: 00000000000002cc R12:
ffff92296ed5a800
[   37.089717] R13: ffff939f00d3bd60 R14: 0000000000010000 R15:
ffff92296bbcb240
[   37.089718] FS:  00007f18eb285700(0000) GS:ffff922977a00000(0000)
knlGS:0000000000000000
[   37.089720] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.089720] CR2: 00007fff363e2ff8 CR3: 000000023454a002 CR4:
00000000001606f0
[   37.089721] Call Trace:
[   37.089722]  f2fs_truncate_data_blocks_range+0xc3/0x350
[   37.089724]  f2fs_truncate_blocks+0x36d/0x3c0
[   37.089725]  f2fs_truncate+0x88/0x110
[   37.089726]  f2fs_setattr+0x3e1/0x460
[   37.089728]  notify_change+0x2da/0x400
[   37.089730]  do_truncate+0x6d/0xb0
[   37.089732]  do_sys_ftruncate+0xf1/0x160
[   37.089733]  do_syscall_64+0x43/0xf0
[   37.089735]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   37.089736] RIP: 0033:0x7f18eada04d9
[   37.089736] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d 8f 29 2c 00 f7 d8 64 89 01 48
[   37.089737] RSP: 002b:00007fff363e2ff8 EFLAGS: 00000217 ORIG_RAX:
000000000000004d
[   37.089738] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f18eada04d9
[   37.089738] RDX: 00007f18eada04d9 RSI: 0000000000001816 RDI:
0000000000000004
[   37.089739] RBP: 00007fff363e7210 R08: 00007fff363e72f8 R09:
00007fff363e72f8
[   37.089740] R10: 00007fff363e72f8 R11: 0000000000000217 R12:
00000000004004e0
[   37.089740] R13: 00007fff363e72f0 R14: 0000000000000000 R15:
0000000000000000
[   37.089741] ---[ end trace 5e252472d7d42506 ]---
[   37.089742] F2FS-fs (sdb): access invalid blkaddr:131072
[   37.089748] WARNING: CPU: 0 PID: 1898 at fs/f2fs/checkpoint.c:160
f2fs_is_valid_blkaddr+0x119/0x170
[   37.089748] Modules linked in:
[   37.089750] CPU: 0 PID: 1898 Comm: a.out Tainted: G        W         5.0.0
#4
[   37.089750] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   37.089751] RIP: 0010:f2fs_is_valid_blkaddr+0x119/0x170
[   37.089754] Code: 00 eb ed 31 c0 83 fa 06 75 a8 48 83 ec 08 48 8b 3f 89 f1
48 c7 c2 74 5e 81 be 48 c7 c6 9f bc 7d be 88 44 24 07 e8 c7 90 ff ff <0f> 0b 0f
b6 44 24 07 48 83 c4 08 e9 78 ff ff ff 4c 8b 47 10 8b 8f
[   37.089754] RSP: 0018:ffff939f00d3bd08 EFLAGS: 00010286
[   37.089755] RAX: 0000000000000000 RBX: 0000000000000002 RCX:
0000000000000006
[   37.089756] RDX: 0000000000000000 RSI: 0000000000000096 RDI:
ffff922977a15410
[   37.089756] RBP: ffff92296bbcbf0c R08: 000000000000db50 R09:
ffffffffbf0ca614
[   37.089757] R10: 000000000000001c R11: 00000000000002ef R12:
ffff92296ed5a800
[   37.089757] R13: ffff939f00d3bd60 R14: 0000000000020000 R15:
ffff92296bbcb244
[   37.089758] FS:  00007f18eb285700(0000) GS:ffff922977a00000(0000)
knlGS:0000000000000000
[   37.089760] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.089761] CR2: 00007fff363e2ff8 CR3: 000000023454a002 CR4:
00000000001606f0
[   37.089761] Call Trace:
[   37.089763]  f2fs_truncate_data_blocks_range+0xc3/0x350
[   37.089764]  f2fs_truncate_blocks+0x36d/0x3c0
[   37.089766]  f2fs_truncate+0x88/0x110
[   37.089767]  f2fs_setattr+0x3e1/0x460
[   37.089769]  notify_change+0x2da/0x400
[   37.089771]  do_truncate+0x6d/0xb0
[   37.089772]  do_sys_ftruncate+0xf1/0x160
[   37.089774]  do_syscall_64+0x43/0xf0
[   37.089775]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   37.089776] RIP: 0033:0x7f18eada04d9
[   37.089777] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d 8f 29 2c 00 f7 d8 64 89 01 48
[   37.089777] RSP: 002b:00007fff363e2ff8 EFLAGS: 00000217 ORIG_RAX:
000000000000004d
[   37.089778] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f18eada04d9
[   37.089779] RDX: 00007f18eada04d9 RSI: 0000000000001816 RDI:
0000000000000004
[   37.089780] RBP: 00007fff363e7210 R08: 00007fff363e72f8 R09:
00007fff363e72f8
[   37.089780] R10: 00007fff363e72f8 R11: 0000000000000217 R12:
00000000004004e0
[   37.089781] R13: 00007fff363e72f0 R14: 0000000000000000 R15:
0000000000000000
[   37.089782] ---[ end trace 5e252472d7d42507 ]---
[   37.089794] F2FS-fs (sdb): access invalid blkaddr:4294901760
[   37.089801] WARNING: CPU: 0 PID: 1898 at fs/f2fs/checkpoint.c:160
f2fs_is_valid_blkaddr+0x119/0x170
[   37.089801] Modules linked in:
[   37.089802] CPU: 0 PID: 1898 Comm: a.out Tainted: G        W         5.0.0
#4
[   37.089802] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   37.089804] RIP: 0010:f2fs_is_valid_blkaddr+0x119/0x170
[   37.089804] Code: 00 eb ed 31 c0 83 fa 06 75 a8 48 83 ec 08 48 8b 3f 89 f1
48 c7 c2 74 5e 81 be 48 c7 c6 9f bc 7d be 88 44 24 07 e8 c7 90 ff ff <0f> 0b 0f
b6 44 24 07 48 83 c4 08 e9 78 ff ff ff 4c 8b 47 10 8b 8f
[   37.089805] RSP: 0018:ffff939f00d3bd08 EFLAGS: 00010286
[   37.089806] RAX: 0000000000000000 RBX: 0000000000000002 RCX:
0000000000000000
[   37.089806] RDX: 0000000000000000 RSI: ffff922977a15418 RDI:
ffff922977a15418
[   37.089807] RBP: ffff92296bbcbf0c R08: 000000000000e5bc R09:
ffffffffbf0ca614
[   37.089807] R10: 000000000000001c R11: 0000000000000312 R12:
ffff92296ed5a800
[   37.089808] R13: ffff939f00d3bd60 R14: 00000000ffff0000 R15:
ffff92296bbcb248
[   37.089809] FS:  00007f18eb285700(0000) GS:ffff922977a00000(0000)
knlGS:0000000000000000
[   37.089811] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.089812] CR2: 00007fff363e2ff8 CR3: 000000023454a002 CR4:
00000000001606f0
[   37.089812] Call Trace:
[   37.089814]  f2fs_truncate_data_blocks_range+0xc3/0x350
[   37.089815]  f2fs_truncate_blocks+0x36d/0x3c0
[   37.089817]  f2fs_truncate+0x88/0x110
[   37.089818]  f2fs_setattr+0x3e1/0x460
[   37.089820]  notify_change+0x2da/0x400
[   37.089822]  do_truncate+0x6d/0xb0
[   37.089824]  do_sys_ftruncate+0xf1/0x160
[   37.089825]  do_syscall_64+0x43/0xf0
[   37.089827]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   37.089828] RIP: 0033:0x7f18eada04d9
[   37.089828] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d 8f 29 2c 00 f7 d8 64 89 01 48
[   37.089829] RSP: 002b:00007fff363e2ff8 EFLAGS: 00000217 ORIG_RAX:
000000000000004d
[   37.089830] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f18eada04d9
[   37.089831] RDX: 00007f18eada04d9 RSI: 0000000000001816 RDI:
0000000000000004
[   37.089831] RBP: 00007fff363e7210 R08: 00007fff363e72f8 R09:
00007fff363e72f8
[   37.089832] R10: 00007fff363e72f8 R11: 0000000000000217 R12:
00000000004004e0
[   37.089832] R13: 00007fff363e72f0 R14: 0000000000000000 R15:
0000000000000000
[   37.089833] ---[ end trace 5e252472d7d42508 ]---
[   37.089834] F2FS-fs (sdb): access invalid blkaddr:327679
[   37.089841] WARNING: CPU: 0 PID: 1898 at fs/f2fs/checkpoint.c:160
f2fs_is_valid_blkaddr+0x119/0x170
[   37.089841] Modules linked in:
[   37.089842] CPU: 0 PID: 1898 Comm: a.out Tainted: G        W         5.0.0
#4
[   37.089843] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   37.089844] RIP: 0010:f2fs_is_valid_blkaddr+0x119/0x170
[   37.089844] Code: 00 eb ed 31 c0 83 fa 06 75 a8 48 83 ec 08 48 8b 3f 89 f1
48 c7 c2 74 5e 81 be 48 c7 c6 9f bc 7d be 88 44 24 07 e8 c7 90 ff ff <0f> 0b 0f
b6 44 24 07 48 83 c4 08 e9 78 ff ff ff 4c 8b 47 10 8b 8f
[   37.089845] RSP: 0018:ffff939f00d3bd08 EFLAGS: 00010286
[   37.089846] RAX: 0000000000000000 RBX: 0000000000000006 RCX:
0000000000000006
[   37.089846] RDX: 0000000000000000 RSI: 0000000000000096 RDI:
ffff922977a15410
[   37.089847] RBP: ffff92296bbcbf0c R08: 000000000000f024 R09:
ffffffffbf0ca614
[   37.089848] R10: 000000000000001c R11: 0000000000000335 R12:
ffff92296ed5a800
[   37.089848] R13: ffff939f00d3bd60 R14: 000000000004ffff R15:
ffff92296bbcb25c
[   37.089849] FS:  00007f18eb285700(0000) GS:ffff922977a00000(0000)
knlGS:0000000000000000
[   37.089851] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.089852] CR2: 00007fff363e2ff8 CR3: 000000023454a002 CR4:
00000000001606f0
[   37.089852] Call Trace:
[   37.089854]  f2fs_truncate_data_blocks_range+0xc3/0x350
[   37.089855]  f2fs_truncate_blocks+0x36d/0x3c0
[   37.089856]  f2fs_truncate+0x88/0x110
[   37.089858]  f2fs_setattr+0x3e1/0x460
[   37.089860]  notify_change+0x2da/0x400
[   37.089861]  do_truncate+0x6d/0xb0
[   37.089863]  do_sys_ftruncate+0xf1/0x160
[   37.089865]  do_syscall_64+0x43/0xf0
[   37.089866]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   37.089867] RIP: 0033:0x7f18eada04d9
[   37.089868] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d 8f 29 2c 00 f7 d8 64 89 01 48
[   37.089868] RSP: 002b:00007fff363e2ff8 EFLAGS: 00000217 ORIG_RAX:
000000000000004d
[   37.089869] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f18eada04d9
[   37.089870] RDX: 00007f18eada04d9 RSI: 0000000000001816 RDI:
0000000000000004
[   37.089871] RBP: 00007fff363e7210 R08: 00007fff363e72f8 R09:
00007fff363e72f8
[   37.089871] R10: 00007fff363e72f8 R11: 0000000000000217 R12:
00000000004004e0
[   37.089872] R13: 00007fff363e72f0 R14: 0000000000000000 R15:
0000000000000000
[   37.089873] ---[ end trace 5e252472d7d42509 ]---
[   37.089874] F2FS-fs (sdb): access invalid blkaddr:6
[   37.089880] WARNING: CPU: 0 PID: 1898 at fs/f2fs/checkpoint.c:160
f2fs_is_valid_blkaddr+0x119/0x170
[   37.089880] Modules linked in:
[   37.089881] CPU: 0 PID: 1898 Comm: a.out Tainted: G        W         5.0.0
#4
[   37.089882] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   37.089883] RIP: 0010:f2fs_is_valid_blkaddr+0x119/0x170
[   37.089884] Code: 00 eb ed 31 c0 83 fa 06 75 a8 48 83 ec 08 48 8b 3f 89 f1
48 c7 c2 74 5e 81 be 48 c7 c6 9f bc 7d be 88 44 24 07 e8 c7 90 ff ff <0f> 0b 0f
b6 44 24 07 48 83 c4 08 e9 78 ff ff ff 4c 8b 47 10 8b 8f
[   37.089884] RSP: 0018:ffff939f00d3bd08 EFLAGS: 00010286
[   37.089885] RAX: 0000000000000000 RBX: 0000000000000006 RCX:
0000000000000006
[   37.089886] RDX: 0000000000000000 RSI: 0000000000000096 RDI:
ffff922977a15410
[   37.089886] RBP: ffff92296bbcbf0c R08: 000000000000fa88 R09:
ffffffffbf0ca614
[   37.089887] R10: 000000000000001c R11: 0000000000000358 R12:
ffff92296ed5a800
[   37.089888] R13: ffff939f00d3bd60 R14: 0000000000000006 R15:
ffff92296bbcb260
[   37.089889] FS:  00007f18eb285700(0000) GS:ffff922977a00000(0000)
knlGS:0000000000000000
[   37.089891] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.089891] CR2: 00007fff363e2ff8 CR3: 000000023454a002 CR4:
00000000001606f0
[   37.089892] Call Trace:
[   37.089893]  f2fs_truncate_data_blocks_range+0xc3/0x350
[   37.089894]  f2fs_truncate_blocks+0x36d/0x3c0
[   37.089896]  f2fs_truncate+0x88/0x110
[   37.089897]  f2fs_setattr+0x3e1/0x460
[   37.089899]  notify_change+0x2da/0x400
[   37.089901]  do_truncate+0x6d/0xb0
[   37.089903]  do_sys_ftruncate+0xf1/0x160
[   37.089904]  do_syscall_64+0x43/0xf0
[   37.089906]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   37.089906] RIP: 0033:0x7f18eada04d9
[   37.089907] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d 8f 29 2c 00 f7 d8 64 89 01 48
[   37.089908] RSP: 002b:00007fff363e2ff8 EFLAGS: 00000217 ORIG_RAX:
000000000000004d
[   37.089908] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f18eada04d9
[   37.089909] RDX: 00007f18eada04d9 RSI: 0000000000001816 RDI:
0000000000000004
[   37.089910] RBP: 00007fff363e7210 R08: 00007fff363e72f8 R09:
00007fff363e72f8
[   37.089910] R10: 00007fff363e72f8 R11: 0000000000000217 R12:
00000000004004e0
[   37.089911] R13: 00007fff363e72f0 R14: 0000000000000000 R15:
0000000000000000
[   37.089912] ---[ end trace 5e252472d7d4250a ]---
[   37.089913] F2FS-fs (sdb): access invalid blkaddr:196608
[   37.089919] WARNING: CPU: 0 PID: 1898 at fs/f2fs/checkpoint.c:160
f2fs_is_valid_blkaddr+0x119/0x170
[   37.089919] Modules linked in:
[   37.089920] CPU: 0 PID: 1898 Comm: a.out Tainted: G        W         5.0.0
#4
[   37.089921] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   37.089922] RIP: 0010:f2fs_is_valid_blkaddr+0x119/0x170
[   37.089923] Code: 00 eb ed 31 c0 83 fa 06 75 a8 48 83 ec 08 48 8b 3f 89 f1
48 c7 c2 74 5e 81 be 48 c7 c6 9f bc 7d be 88 44 24 07 e8 c7 90 ff ff <0f> 0b 0f
b6 44 24 07 48 83 c4 08 e9 78 ff ff ff 4c 8b 47 10 8b 8f
[   37.089923] RSP: 0018:ffff939f00d3bd08 EFLAGS: 00010286
[   37.089924] RAX: 0000000000000000 RBX: 0000000000000006 RCX:
0000000000000006
[   37.089925] RDX: 0000000000000000 RSI: 0000000000000096 RDI:
ffff922977a15410
[   37.089925] RBP: ffff92296bbcbf0c R08: 00000000000104f0 R09:
ffffffffbf0ca614
[   37.089926] R10: 000000000000001c R11: 000000000000037b R12:
ffff92296ed5a800
[   37.089926] R13: ffff939f00d3bd60 R14: 0000000000030000 R15:
ffff92296bbcb26c
[   37.089927] FS:  00007f18eb285700(0000) GS:ffff922977a00000(0000)
knlGS:0000000000000000
[   37.089929] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.089930] CR2: 00007fff363e2ff8 CR3: 000000023454a002 CR4:
00000000001606f0
[   37.089931] Call Trace:
[   37.089932]  f2fs_truncate_data_blocks_range+0xc3/0x350
[   37.089933]  f2fs_truncate_blocks+0x36d/0x3c0
[   37.089935]  f2fs_truncate+0x88/0x110
[   37.089936]  f2fs_setattr+0x3e1/0x460
[   37.089938]  notify_change+0x2da/0x400
[   37.089940]  do_truncate+0x6d/0xb0
[   37.089942]  do_sys_ftruncate+0xf1/0x160
[   37.089943]  do_syscall_64+0x43/0xf0
[   37.089945]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   37.089945] RIP: 0033:0x7f18eada04d9
[   37.089946] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d 8f 29 2c 00 f7 d8 64 89 01 48
[   37.089947] RSP: 002b:00007fff363e2ff8 EFLAGS: 00000217 ORIG_RAX:
000000000000004d
[   37.089948] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f18eada04d9
[   37.089948] RDX: 00007f18eada04d9 RSI: 0000000000001816 RDI:
0000000000000004
[   37.089949] RBP: 00007fff363e7210 R08: 00007fff363e72f8 R09:
00007fff363e72f8
[   37.089950] R10: 00007fff363e72f8 R11: 0000000000000217 R12:
00000000004004e0
[   37.089950] R13: 00007fff363e72f0 R14: 0000000000000000 R15:
0000000000000000
[   37.089951] ---[ end trace 5e252472d7d4250b ]---
[   37.089952] F2FS-fs (sdb): access invalid blkaddr:720896
[   37.089958] WARNING: CPU: 0 PID: 1898 at fs/f2fs/checkpoint.c:160
f2fs_is_valid_blkaddr+0x119/0x170
[   37.089959] Modules linked in:
[   37.089960] CPU: 0 PID: 1898 Comm: a.out Tainted: G        W         5.0.0
#4
[   37.089960] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   37.089961] RIP: 0010:f2fs_is_valid_blkaddr+0x119/0x170
[   37.089962] Code: 00 eb ed 31 c0 83 fa 06 75 a8 48 83 ec 08 48 8b 3f 89 f1
48 c7 c2 74 5e 81 be 48 c7 c6 9f bc 7d be 88 44 24 07 e8 c7 90 ff ff <0f> 0b 0f
b6 44 24 07 48 83 c4 08 e9 78 ff ff ff 4c 8b 47 10 8b 8f
[   37.089962] RSP: 0018:ffff939f00d3bd08 EFLAGS: 00010286
[   37.089963] RAX: 0000000000000000 RBX: 0000000000000006 RCX:
0000000000000006
[   37.089964] RDX: 0000000000000000 RSI: 0000000000000096 RDI:
ffff922977a15410
[   37.089964] RBP: ffff92296bbcbf0c R08: 0000000000010f58 R09:
ffffffffbf0ca614
[   37.089965] R10: 000000000000001c R11: 000000000000039e R12:
ffff92296ed5a800
[   37.089966] R13: ffff939f00d3bd60 R14: 00000000000b0000 R15:
ffff92296bbcb270
[   37.089967] FS:  00007f18eb285700(0000) GS:ffff922977a00000(0000)
knlGS:0000000000000000
[   37.089969] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.089969] CR2: 00007fff363e2ff8 CR3: 000000023454a002 CR4:
00000000001606f0
[   37.089970] Call Trace:
[   37.089971]  f2fs_truncate_data_blocks_range+0xc3/0x350
[   37.089972]  f2fs_truncate_blocks+0x36d/0x3c0
[   37.089974]  f2fs_truncate+0x88/0x110
[   37.089975]  f2fs_setattr+0x3e1/0x460
[   37.089977]  notify_change+0x2da/0x400
[   37.089979]  do_truncate+0x6d/0xb0
[   37.089981]  do_sys_ftruncate+0xf1/0x160
[   37.089982]  do_syscall_64+0x43/0xf0
[   37.089984]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   37.089984] RIP: 0033:0x7f18eada04d9
[   37.089985] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d 8f 29 2c 00 f7 d8 64 89 01 48
[   37.089986] RSP: 002b:00007fff363e2ff8 EFLAGS: 00000217 ORIG_RAX:
000000000000004d
[   37.089987] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f18eada04d9
[   37.089987] RDX: 00007f18eada04d9 RSI: 0000000000001816 RDI:
0000000000000004
[   37.089988] RBP: 00007fff363e7210 R08: 00007fff363e72f8 R09:
00007fff363e72f8
[   37.089988] R10: 00007fff363e72f8 R11: 0000000000000217 R12:
00000000004004e0
[   37.089989] R13: 00007fff363e72f0 R14: 0000000000000000 R15:
0000000000000000
[   37.089990] ---[ end trace 5e252472d7d4250c ]---
[   37.089991] F2FS-fs (sdb): access invalid blkaddr:327680
[   37.089997] WARNING: CPU: 0 PID: 1898 at fs/f2fs/checkpoint.c:160
f2fs_is_valid_blkaddr+0x119/0x170
[   37.089997] Modules linked in:
[   37.089998] CPU: 0 PID: 1898 Comm: a.out Tainted: G        W         5.0.0
#4
[   37.089999] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   37.090000] RIP: 0010:f2fs_is_valid_blkaddr+0x119/0x170
[   37.090001] Code: 00 eb ed 31 c0 83 fa 06 75 a8 48 83 ec 08 48 8b 3f 89 f1
48 c7 c2 74 5e 81 be 48 c7 c6 9f bc 7d be 88 44 24 07 e8 c7 90 ff ff <0f> 0b 0f
b6 44 24 07 48 83 c4 08 e9 78 ff ff ff 4c 8b 47 10 8b 8f
[   37.090001] RSP: 0018:ffff939f00d3bd08 EFLAGS: 00010286
[   37.090002] RAX: 0000000000000000 RBX: 0000000000000006 RCX:
0000000000000006
[   37.090003] RDX: 0000000000000000 RSI: 0000000000000096 RDI:
ffff922977a15410
[   37.090003] RBP: ffff92296bbcbf0c R08: 00000000000119c0 R09:
ffffffffbf0ca614
[   37.090004] R10: 000000000000001c R11: 00000000000003c1 R12:
ffff92296ed5a800
[   37.090005] R13: ffff939f00d3bd60 R14: 0000000000050000 R15:
ffff92296bbcb274
[   37.090006] FS:  00007f18eb285700(0000) GS:ffff922977a00000(0000)
knlGS:0000000000000000
[   37.090008] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.090008] CR2: 00007fff363e2ff8 CR3: 000000023454a002 CR4:
00000000001606f0
[   37.090009] Call Trace:
[   37.090010]  f2fs_truncate_data_blocks_range+0xc3/0x350
[   37.090011]  f2fs_truncate_blocks+0x36d/0x3c0
[   37.090013]  f2fs_truncate+0x88/0x110
[   37.090014]  f2fs_setattr+0x3e1/0x460
[   37.090016]  notify_change+0x2da/0x400
[   37.090018]  do_truncate+0x6d/0xb0
[   37.090020]  do_sys_ftruncate+0xf1/0x160
[   37.090021]  do_syscall_64+0x43/0xf0
[   37.090023]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   37.090023] RIP: 0033:0x7f18eada04d9
[   37.090024] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d 8f 29 2c 00 f7 d8 64 89 01 48
[   37.090025] RSP: 002b:00007fff363e2ff8 EFLAGS: 00000217 ORIG_RAX:
000000000000004d
[   37.090025] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f18eada04d9
[   37.090026] RDX: 00007f18eada04d9 RSI: 0000000000001816 RDI:
0000000000000004
[   37.090027] RBP: 00007fff363e7210 R08: 00007fff363e72f8 R09:
00007fff363e72f8
[   37.090027] R10: 00007fff363e72f8 R11: 0000000000000217 R12:
00000000004004e0
[   37.090028] R13: 00007fff363e72f0 R14: 0000000000000000 R15:
0000000000000000
[   37.090029] ---[ end trace 5e252472d7d4250d ]---
[   37.090030] F2FS-fs (sdb): access invalid blkaddr:524288
[   37.090036] WARNING: CPU: 0 PID: 1898 at fs/f2fs/checkpoint.c:160
f2fs_is_valid_blkaddr+0x119/0x170
[   37.090036] Modules linked in:
[   37.090037] CPU: 0 PID: 1898 Comm: a.out Tainted: G        W         5.0.0
#4
[   37.090038] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   37.090039] RIP: 0010:f2fs_is_valid_blkaddr+0x119/0x170
[   37.090040] Code: 00 eb ed 31 c0 83 fa 06 75 a8 48 83 ec 08 48 8b 3f 89 f1
48 c7 c2 74 5e 81 be 48 c7 c6 9f bc 7d be 88 44 24 07 e8 c7 90 ff ff <0f> 0b 0f
b6 44 24 07 48 83 c4 08 e9 78 ff ff ff 4c 8b 47 10 8b 8f
[   37.090040] RSP: 0018:ffff939f00d3bd08 EFLAGS: 00010286
[   37.090041] RAX: 0000000000000000 RBX: 0000000000000006 RCX:
0000000000000006
[   37.090042] RDX: 0000000000000000 RSI: 0000000000000096 RDI:
ffff922977a15410
[   37.090042] RBP: ffff92296bbcbf0c R08: 0000000000012428 R09:
ffffffffbf0ca614
[   37.090043] R10: 000000000000001c R11: 00000000000003e4 R12:
ffff92296ed5a800
[   37.090044] R13: ffff939f00d3bd60 R14: 0000000000080000 R15:
ffff92296bbcb350
[   37.090045] FS:  00007f18eb285700(0000) GS:ffff922977a00000(0000)
knlGS:0000000000000000
[   37.090047] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.090047] CR2: 00007fff363e2ff8 CR3: 000000023454a002 CR4:
00000000001606f0
[   37.090048] Call Trace:
[   37.090049]  f2fs_truncate_data_blocks_range+0xc3/0x350
[   37.090050]  f2fs_truncate_blocks+0x36d/0x3c0
[   37.090052]  f2fs_truncate+0x88/0x110
[   37.090053]  f2fs_setattr+0x3e1/0x460
[   37.090055]  notify_change+0x2da/0x400
[   37.090057]  do_truncate+0x6d/0xb0
[   37.090059]  do_sys_ftruncate+0xf1/0x160
[   37.090060]  do_syscall_64+0x43/0xf0
[   37.090062]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   37.090062] RIP: 0033:0x7f18eada04d9
[   37.090063] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d 8f 29 2c 00 f7 d8 64 89 01 48
[   37.090064] RSP: 002b:00007fff363e2ff8 EFLAGS: 00000217 ORIG_RAX:
000000000000004d
[   37.090065] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f18eada04d9
[   37.090065] RDX: 00007f18eada04d9 RSI: 0000000000001816 RDI:
0000000000000004
[   37.090066] RBP: 00007fff363e7210 R08: 00007fff363e72f8 R09:
00007fff363e72f8
[   37.090066] R10: 00007fff363e72f8 R11: 0000000000000217 R12:
00000000004004e0
[   37.090067] R13: 00007fff363e72f0 R14: 0000000000000000 R15:
0000000000000000
[   37.090068] ---[ end trace 5e252472d7d4250e ]---
[   37.090070] F2FS-fs (sdb): access invalid blkaddr:16774912
[   37.090076] WARNING: CPU: 0 PID: 1898 at fs/f2fs/checkpoint.c:160
f2fs_is_valid_blkaddr+0x119/0x170
[   37.090076] Modules linked in:
[   37.090077] CPU: 0 PID: 1898 Comm: a.out Tainted: G        W         5.0.0
#4
[   37.090078] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   37.090079] RIP: 0010:f2fs_is_valid_blkaddr+0x119/0x170
[   37.090080] Code: 00 eb ed 31 c0 83 fa 06 75 a8 48 83 ec 08 48 8b 3f 89 f1
48 c7 c2 74 5e 81 be 48 c7 c6 9f bc 7d be 88 44 24 07 e8 c7 90 ff ff <0f> 0b 0f
b6 44 24 07 48 83 c4 08 e9 78 ff ff ff 4c 8b 47 10 8b 8f
[   37.090080] RSP: 0018:ffff939f00d3bd08 EFLAGS: 00010286
[   37.090081] RAX: 0000000000000000 RBX: 0000000000000006 RCX:
0000000000000006
[   37.090082] RDX: 0000000000000000 RSI: 0000000000000096 RDI:
ffff922977a15410
[   37.090082] RBP: ffff92296bbcbf0c R08: 0000000000012e94 R09:
ffffffffbf0ca614
[   37.090083] R10: 000000000000001c R11: 0000000000000407 R12:
ffff92296ed5a800
[   37.090083] R13: ffff939f00d3bd60 R14: 0000000000fff700 R15:
ffff92296bbcb9d4
[   37.090084] FS:  00007f18eb285700(0000) GS:ffff922977a00000(0000)
knlGS:0000000000000000
[   37.090086] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.090087] CR2: 00007fff363e2ff8 CR3: 000000023454a002 CR4:
00000000001606f0
[   37.090087] Call Trace:
[   37.090089]  f2fs_truncate_data_blocks_range+0xc3/0x350
[   37.090090]  f2fs_truncate_blocks+0x36d/0x3c0
[   37.090092]  f2fs_truncate+0x88/0x110
[   37.090093]  f2fs_setattr+0x3e1/0x460
[   37.090095]  notify_change+0x2da/0x400
[   37.090097]  do_truncate+0x6d/0xb0
[   37.090098]  do_sys_ftruncate+0xf1/0x160
[   37.090100]  do_syscall_64+0x43/0xf0
[   37.090101]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   37.090102] RIP: 0033:0x7f18eada04d9
[   37.090103] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d 8f 29 2c 00 f7 d8 64 89 01 48
[   37.090103] RSP: 002b:00007fff363e2ff8 EFLAGS: 00000217 ORIG_RAX:
000000000000004d
[   37.090104] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f18eada04d9
[   37.090105] RDX: 00007f18eada04d9 RSI: 0000000000001816 RDI:
0000000000000004
[   37.090106] RBP: 00007fff363e7210 R08: 00007fff363e72f8 R09:
00007fff363e72f8
[   37.090106] R10: 00007fff363e72f8 R11: 0000000000000217 R12:
00000000004004e0
[   37.090107] R13: 00007fff363e72f0 R14: 0000000000000000 R15:
0000000000000000
[   37.090108] ---[ end trace 5e252472d7d4250f ]---
[   37.090109] F2FS-fs (sdb): access invalid blkaddr:4294934528
[   37.090115] WARNING: CPU: 0 PID: 1898 at fs/f2fs/checkpoint.c:160
f2fs_is_valid_blkaddr+0x119/0x170
[   37.090116] Modules linked in:
[   37.090117] CPU: 0 PID: 1898 Comm: a.out Tainted: G        W         5.0.0
#4
[   37.090117] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   37.090118] RIP: 0010:f2fs_is_valid_blkaddr+0x119/0x170
[   37.090119] Code: 00 eb ed 31 c0 83 fa 06 75 a8 48 83 ec 08 48 8b 3f 89 f1
48 c7 c2 74 5e 81 be 48 c7 c6 9f bc 7d be 88 44 24 07 e8 c7 90 ff ff <0f> 0b 0f
b6 44 24 07 48 83 c4 08 e9 78 ff ff ff 4c 8b 47 10 8b 8f
[   37.090120] RSP: 0018:ffff939f00d3bd08 EFLAGS: 00010286
[   37.090120] RAX: 0000000000000000 RBX: 0000000000000006 RCX:
0000000000000006
[   37.090121] RDX: 0000000000000000 RSI: 0000000000000096 RDI:
ffff922977a15410
[   37.090122] RBP: ffff92296bbcbf0c R08: 0000000000013900 R09:
ffffffffbf0ca614
[   37.090122] R10: 000000000000001c R11: 000000000000042a R12:
ffff92296ed5a800
[   37.090123] R13: ffff939f00d3bd60 R14: 00000000ffff8000 R15:
ffff92296bbcbe50
[   37.090124] FS:  00007f18eb285700(0000) GS:ffff922977a00000(0000)
knlGS:0000000000000000
[   37.090126] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.090127] CR2: 00007fff363e2ff8 CR3: 000000023454a002 CR4:
00000000001606f0
[   37.090127] Call Trace:
[   37.090128]  f2fs_truncate_data_blocks_range+0xc3/0x350
[   37.090130]  f2fs_truncate_blocks+0x36d/0x3c0
[   37.090131]  f2fs_truncate+0x88/0x110
[   37.090132]  f2fs_setattr+0x3e1/0x460
[   37.090134]  notify_change+0x2da/0x400
[   37.090136]  do_truncate+0x6d/0xb0
[   37.090138]  do_sys_ftruncate+0xf1/0x160
[   37.090139]  do_syscall_64+0x43/0xf0
[   37.090141]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   37.090142] RIP: 0033:0x7f18eada04d9
[   37.090142] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d 8f 29 2c 00 f7 d8 64 89 01 48
[   37.090143] RSP: 002b:00007fff363e2ff8 EFLAGS: 00000217 ORIG_RAX:
000000000000004d
[   37.090144] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f18eada04d9
[   37.090144] RDX: 00007f18eada04d9 RSI: 0000000000001816 RDI:
0000000000000004
[   37.090145] RBP: 00007fff363e7210 R08: 00007fff363e72f8 R09:
00007fff363e72f8
[   37.090146] R10: 00007fff363e72f8 R11: 0000000000000217 R12:
00000000004004e0
[   37.090146] R13: 00007fff363e72f0 R14: 0000000000000000 R15:
0000000000000000
[   37.090147] ---[ end trace 5e252472d7d42510 ]---
[   37.090153] ------------[ cut here ]------------
[   37.090154] kernel BUG at fs/f2fs/f2fs.h:1788!
[   37.090810] invalid opcode: 0000 [#1] SMP PTI
[   37.091419] CPU: 0 PID: 1898 Comm: a.out Tainted: G        W         5.0.0
#4
[   37.092393] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   37.093718] RIP: 0010:f2fs_truncate_data_blocks_range+0x342/0x350
[   37.094546] Code: 50 02 00 00 f7 c1 00 00 04 00 0f 84 de fd ff ff 3e 80 a2
52 02 00 00 fb 41 8b 45 1c e9 cd fd ff ff 31 db e9 e5 fd ff ff 0f 0b <0f> 0b 66
90 66 2e 0f 1f 84 00 00 00 00 00 be fa 03 00 00 e9 a6 fc
[   37.097109] RSP: 0018:ffff939f00d3bd18 EFLAGS: 00010202
[   37.097848] RAX: 0000000000000016 RBX: 0000000000000006 RCX:
0000000000000001
[   37.098822] RDX: 0000000000000001 RSI: 0000000000000000 RDI:
ffff92296ed5ade8
[   37.099790] RBP: ffff922975425980 R08: 0000000000000004 R09:
ffffffffbd94150b
[   37.100753] R10: fffff44cc8d69740 R11: 0000000000000004 R12:
ffff92296ed5a800
[   37.101748] R13: ffff939f00d3bd60 R14: 0000000000000030 R15:
ffff92296bbcbf0c
[   37.102720] FS:  00007f18eb285700(0000) GS:ffff922977a00000(0000)
knlGS:0000000000000000
[   37.103820] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.104614] CR2: 00007fff363e2ff8 CR3: 000000023454a002 CR4:
00000000001606f0
[   37.105622] Call Trace:
[   37.105967]  f2fs_truncate_blocks+0x36d/0x3c0
[   37.106566]  f2fs_truncate+0x88/0x110
[   37.107072]  f2fs_setattr+0x3e1/0x460
[   37.107578]  notify_change+0x2da/0x400
[   37.108096]  do_truncate+0x6d/0xb0
[   37.108569]  do_sys_ftruncate+0xf1/0x160
[   37.109147]  do_syscall_64+0x43/0xf0
[   37.109638]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   37.110315] RIP: 0033:0x7f18eada04d9
[   37.110831] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d 8f 29 2c 00 f7 d8 64 89 01 48
[   37.113437] RSP: 002b:00007fff363e2ff8 EFLAGS: 00000217 ORIG_RAX:
000000000000004d
[   37.114489] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f18eada04d9
[   37.115456] RDX: 00007f18eada04d9 RSI: 0000000000001816 RDI:
0000000000000004
[   37.116420] RBP: 00007fff363e7210 R08: 00007fff363e72f8 R09:
00007fff363e72f8
[   37.117425] R10: 00007fff363e72f8 R11: 0000000000000217 R12:
00000000004004e0
[   37.118406] R13: 00007fff363e72f0 R14: 0000000000000000 R15:
0000000000000000
[   37.119398] Modules linked in:
[   37.119849] ---[ end trace 5e252472d7d42511 ]---
[   37.120486] RIP: 0010:f2fs_truncate_data_blocks_range+0x342/0x350
[   37.121368] Code: 50 02 00 00 f7 c1 00 00 04 00 0f 84 de fd ff ff 3e 80 a2
52 02 00 00 fb 41 8b 45 1c e9 cd fd ff ff 31 db e9 e5 fd ff ff 0f 0b <0f> 0b 66
90 66 2e 0f 1f 84 00 00 00 00 00 be fa 03 00 00 e9 a6 fc
[   37.123911] RSP: 0018:ffff939f00d3bd18 EFLAGS: 00010202
[   37.124642] RAX: 0000000000000016 RBX: 0000000000000006 RCX:
0000000000000001
[   37.125659] RDX: 0000000000000001 RSI: 0000000000000000 RDI:
ffff92296ed5ade8
[   37.126666] RBP: ffff922975425980 R08: 0000000000000004 R09:
ffffffffbd94150b
[   37.127673] R10: fffff44cc8d69740 R11: 0000000000000004 R12:
ffff92296ed5a800
[   37.128679] R13: ffff939f00d3bd60 R14: 0000000000000030 R15:
ffff92296bbcbf0c
[   37.129713] FS:  00007f18eb285700(0000) GS:ffff922977a00000(0000)
knlGS:0000000000000000
[   37.130858] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.131662] CR2: 00007fff363e2ff8 CR3: 000000023454a002 CR4:
00000000001606f0

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
