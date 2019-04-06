From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 203169] New: at fs/f2fs/checkpoint.c:160
 f2fs_is_valid_blkaddr
Date: Sat, 06 Apr 2019 01:30:37 +0000
Message-ID: <bug-203169-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1hCaAQ-0002DC-To
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 06 Apr 2019 01:30:46 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hCaAP-001536-8O
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 06 Apr 2019 01:30:46 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id CA7E828B2C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat,  6 Apr 2019 01:30:38 +0000 (UTC)
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

https://bugzilla.kernel.org/show_bug.cgi?id=203169

            Bug ID: 203169
           Summary: at fs/f2fs/checkpoint.c:160 f2fs_is_valid_blkaddr
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

- Messages
[   35.253775] F2FS-fs (sdb): Invalid segment count (555819297)
[   35.253777] F2FS-fs (sdb): Can't find valid F2FS filesystem in 2th
superblock
[   35.264738] F2FS-fs (sdb): Try to recover 2th superblock, ret: 0
[   35.264740] F2FS-fs (sdb): Mounted with checkpoint version = 7548c2d7
[   44.217043] F2FS-fs (sdb): Corrupted max_depth of 3: 65533
[   44.217508] F2FS-fs (sdb): access invalid blkaddr:56
[   44.217529] WARNING: CPU: 0 PID: 1036 at fs/f2fs/checkpoint.c:160
f2fs_is_valid_blkaddr+0x121/0x170
[   44.217530] Modules linked in:
[   44.217532] CPU: 0 PID: 1036 Comm: touch Not tainted 5.0.0 #3
[   44.217533] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   44.217546] RIP: 0010:f2fs_is_valid_blkaddr+0x121/0x170
[   44.217547] Code: 31 c0 83 fa 06 75 a8 55 89 f1 48 c7 c2 e4 d4 77 ba 48 c7
c6 73 5b 71 ba 48 89 e5 48 83 ec 08 48 8b 3f 88 45 ff e8 ef 7e ff ff <0f> 0b 0f
b6 45 ff c9 e9 79 ff ff ff 4c 8b 47 10 8b 8f d0 03 00 00
[   44.217548] RSP: 0018:ffffb6d0810d7a48 EFLAGS: 00010286
[   44.217549] RAX: 0000000000000000 RBX: fffffffffffffff2 RCX:
0000000000000006
[   44.217550] RDX: 0000000000000000 RSI: 0000000000000092 RDI:
ffff9949f7a163a0
[   44.217551] RBP: ffffb6d0810d7a50 R08: 0000000000000001 R09:
ffffffffbaf9f0c4
[   44.217551] R10: 0000000000000000 R11: 00000000000001f8 R12:
0000000000000001
[   44.217552] R13: ffff9949f53d9000 R14: 0000000000000038 R15:
ffff9949f49feb70
[   44.217553] FS:  00007f4a868de700(0000) GS:ffff9949f7a00000(0000)
knlGS:0000000000000000
[   44.217554] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   44.217555] CR2: 0000000001565008 CR3: 00000002301ce005 CR4:
00000000001606f0
[   44.217558] Call Trace:
[   44.217562]  f2fs_grab_read_bio+0x41/0x100
[   44.217564]  f2fs_submit_page_read+0x2a/0x2a0
[   44.217566]  f2fs_get_read_data_page+0xb3/0x3b0
[   44.217568]  f2fs_find_data_page+0x68/0x190
[   44.217572]  __f2fs_find_entry+0x196/0x3e0
[   44.217574]  f2fs_find_entry+0x51/0x80
[   44.217576]  f2fs_lookup+0x10d/0x370
[   44.217580]  path_openat+0x113c/0x1540
[   44.217582]  do_filp_open+0x99/0x110
[   44.217587]  ? __check_object_size+0x17c/0x1b0
[   44.217590]  ? strncpy_from_user+0x50/0x1b0
[   44.217593]  ? __alloc_fd+0x46/0x170
[   44.217595]  do_sys_open+0x128/0x220
[   44.217596]  ? do_sys_open+0x128/0x220
[   44.217597]  __x64_sys_open+0x21/0x30
[   44.217612]  do_syscall_64+0x5a/0x110
[   44.217617]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   44.217619] RIP: 0033:0x7f4a863ef040
[   44.217620] Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00
00 00 0f 1f 44 00 00 83 3d 09 27 2d 00 00 75 10 b8 02 00 00 00 0f 05 <48> 3d 01
f0 ff ff 73 31 c3 48 83 ec 08 e8 7e e0 01 00 48 89 04 24
[   44.217620] RSP: 002b:00007ffe9e459d08 EFLAGS: 00000246 ORIG_RAX:
0000000000000002
[   44.217621] RAX: ffffffffffffffda RBX: 00007ffe9e459f38 RCX:
00007f4a863ef040
[   44.217622] RDX: 00000000000001b6 RSI: 0000000000000941 RDI:
00007ffe9e45bec4
[   44.217623] RBP: 0000000000000000 R08: 0000000000000000 R09:
0000000000000000
[   44.217623] R10: 000000000000069d R11: 0000000000000246 R12:
0000000000000000
[   44.217624] R13: 00007ffe9e45bec4 R14: 0000000000000000 R15:
0000000000000000
[   44.217625] ---[ end trace 581ce323820140e1 ]---
[   44.217636] F2FS-fs (sdb): access invalid blkaddr:56
[   44.217658] WARNING: CPU: 0 PID: 1036 at fs/f2fs/checkpoint.c:160
f2fs_is_valid_blkaddr+0x121/0x170
[   44.217658] Modules linked in:
[   44.217660] CPU: 0 PID: 1036 Comm: touch Tainted: G        W         5.0.0
#3
[   44.217660] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   44.217662] RIP: 0010:f2fs_is_valid_blkaddr+0x121/0x170
[   44.217663] Code: 31 c0 83 fa 06 75 a8 55 89 f1 48 c7 c2 e4 d4 77 ba 48 c7
c6 73 5b 71 ba 48 89 e5 48 83 ec 08 48 8b 3f 88 45 ff e8 ef 7e ff ff <0f> 0b 0f
b6 45 ff c9 e9 79 ff ff ff 4c 8b 47 10 8b 8f d0 03 00 00
[   44.217664] RSP: 0018:ffffb6d0810d7958 EFLAGS: 00010282
[   44.217665] RAX: 0000000000000000 RBX: fffffffffffffff2 RCX:
0000000000000006
[   44.217665] RDX: 0000000000000000 RSI: 0000000000000092 RDI:
ffff9949f7a163a0
[   44.217666] RBP: ffffb6d0810d7960 R08: 0000000000000001 R09:
ffffffffbaf9f0c4
[   44.217667] R10: 0000000074657374 R11: 0000000000000223 R12:
0000000000000001
[   44.217667] R13: ffff9949f53d9000 R14: 0000000000000038 R15:
ffff9949f49feb70
[   44.217668] FS:  00007f4a868de700(0000) GS:ffff9949f7a00000(0000)
knlGS:0000000000000000
[   44.217669] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   44.217670] CR2: 0000000001565008 CR3: 00000002301ce005 CR4:
00000000001606f0
[   44.217672] Call Trace:
[   44.217674]  f2fs_grab_read_bio+0x41/0x100
[   44.217676]  f2fs_submit_page_read+0x2a/0x2a0
[   44.217678]  f2fs_get_read_data_page+0xb3/0x3b0
[   44.217680]  f2fs_find_data_page+0x68/0x190
[   44.217681]  __f2fs_find_entry+0x196/0x3e0
[   44.217683]  f2fs_find_entry+0x51/0x80
[   44.217685]  f2fs_lookup+0x10d/0x370
[   44.217687]  __lookup_slow+0x9b/0x150
[   44.217689]  lookup_slow+0x3a/0x60
[   44.217691]  walk_component+0x1c5/0x360
[   44.217693]  ? mntput+0x24/0x40
[   44.217694]  path_lookupat+0x67/0x200
[   44.217696]  filename_lookup+0xb8/0x1a0
[   44.217699]  ? __check_object_size+0x17c/0x1b0
[   44.217700]  ? strncpy_from_user+0x50/0x1b0
[   44.217702]  user_path_at_empty+0x36/0x40
[   44.217704]  ? user_path_at_empty+0x36/0x40
[   44.217706]  do_utimes+0x115/0x160
[   44.217708]  __x64_sys_utimensat+0x88/0xd0
[   44.217710]  ? exit_to_usermode_loop+0xd7/0x120
[   44.217712]  do_syscall_64+0x5a/0x110
[   44.217713]  ? do_syscall_64+0x5a/0x110
[   44.217715]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   44.217716] RIP: 0033:0x7f4a863f3ad2
[   44.217717] Code: 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00
00 00 00 66 90 48 85 f6 74 2d 4c 63 d1 48 63 ff b8 18 01 00 00 0f 05 <48> 3d 00
f0 ff ff 77 06 f3 c3 0f 1f 40 00 48 8b 15 91 83 2c 00 f7
[   44.217718] RSP: 002b:00007ffe9e459c18 EFLAGS: 00000202 ORIG_RAX:
0000000000000118
[   44.217719] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f4a863f3ad2
[   44.217719] RDX: 0000000000000000 RSI: 00007ffe9e45bec4 RDI:
ffffffffffffff9c
[   44.217720] RBP: 00007ffe9e45bec4 R08: 0000000000000000 R09:
0000000000000000
[   44.217721] R10: 0000000000000000 R11: 0000000000000202 R12:
0000000000000000
[   44.217721] R13: 00000000ffffff9c R14: 00007ffe9e45bec4 R15:
000000000000000e
[   44.217723] ---[ end trace 581ce323820140e2 ]---

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
