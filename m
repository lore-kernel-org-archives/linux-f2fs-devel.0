From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 203167] New: Kernel page fault with
 update_sit_entry+0x113/0x420
Date: Sat, 06 Apr 2019 00:50:51 +0000
Message-ID: <bug-203167-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1hCZXv-0003zs-NV
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 06 Apr 2019 00:50:59 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hCZXt-00111y-Ua
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 06 Apr 2019 00:50:59 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 4BA1728821
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat,  6 Apr 2019 00:50:52 +0000 (UTC)
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

https://bugzilla.kernel.org/show_bug.cgi?id=203167

            Bug ID: 203167
           Summary: Kernel page fault with update_sit_entry+0x113/0x420
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

Created attachment 282153
  --> https://bugzilla.kernel.org/attachment.cgi?id=282153&action=edit
The (compressed) crafted image which causes crash

- Overview
When mounting attached crafted image , I got this kernel read fault.

- Produces
mkdir test
mount -t f2fs tmp.img test

- Messages
[ 58.971048] F2FS-fs (sdb): Can't find valid F2FS filesystem in 2th superblock
[ 58.988893] F2FS-fs (sdb): invalid blkaddr: 657665, type: 6, run fsck to fix.
[ 58.990137] F2FS-fs (sdb): invalid blkaddr: 657665, type: 6, run fsck to fix.
[ 58.994104] BUG: unable to handle kernel paging request at 000000003d9b84b4
[ 58.995147] #PF error: [normal kernel read fault]
[ 58.995850] PGD 800000022e5ea067 P4D 800000022e5ea067 PUD 22e515067 PMD 0 
[ 58.996868] Oops: 0000 [#1] SMP PTI
[ 58.997399] CPU: 0 PID: 1041 Comm: mount Tainted: G W 5.0.0 #3
[ 58.998454] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[ 58.999845] RIP: 0010:update_sit_entry+0x113/0x420
[ 59.000559] Code: c7 43 20 00 00 00 00 45 89 e8 44 89 e9 b8 01 00 00 00 41 c1
e8 03 f7 d1 4c 89 c6 48 03 73 08 83 e1 07 d3 e0 45 85 ff 41 89 c5 <0f> be 16 0f
8e 6a 01 00 00 89 d1 09 c1 85 c2 88 0e 0f 85 4f 02 00
[ 59.003302] RSP: 0018:ffffabe94110b9c8 EFLAGS: 00010286
[ 59.004078] RAX: 0000000000000040 RBX: ffff9b1274e00360 RCX: 0000000000000006
[ 59.005129] RDX: ffff9b127282d600 RSI: 000000003d9b84b4 RDI: ffffffffffffffff
[ 59.006184] RBP: ffffabe94110ba00 R08: 0000000000000020 R09: 00000000000a0901
[ 59.007235] R10: ffff9b126fd0ec40 R11: ffffabe94110b7bd R12: ffff9b126e530000
[ 59.008287] R13: 0000000000000040 R14: 00000000000004fc R15: 00000000ffffffff
[ 59.009341] FS: 00007fce82c9c840(0000) GS:ffff9b1277a00000(0000)
knlGS:0000000000000000
[ 59.010534] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 59.011389] CR2: 00007efe47968950 CR3: 00000002333da005 CR4: 00000000001606f0
[ 59.012447] Call Trace:
[ 59.012825] f2fs_do_replace_block+0x1c1/0x510
[ 59.013496] f2fs_replace_block+0x4b/0x80
[ 59.014097] recover_data+0xac9/0x1c90
[ 59.014661] f2fs_recover_fsync_data+0x68f/0x800
[ 59.015351] ? proc_create_single_data+0x41/0x50
[ 59.016040] f2fs_fill_super+0x1bdd/0x1d50
[ 59.016653] ? snprintf+0x45/0x70
[ 59.017153] mount_bdev+0x17b/0x1b0
[ 59.017685] ? f2fs_commit_super+0x190/0x190
[ 59.018327] ? mount_bdev+0x17b/0x1b0
[ 59.018879] ? f2fs_commit_super+0x190/0x190
[ 59.019519] f2fs_mount+0x15/0x20
[ 59.020019] mount_fs+0x51/0x170
[ 59.020509] vfs_kern_mount+0x67/0x120
[ 59.021071] do_mount+0x208/0xd20
[ 59.021579] ? __check_object_size+0x151/0x1b0
[ 59.022245] ? memdup_user+0x4f/0x70
[ 59.022784] ksys_mount+0x83/0xd0
[ 59.023290] __x64_sys_mount+0x25/0x30
[ 59.023855] do_syscall_64+0x5a/0x110
[ 59.024404] entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 59.025156] RIP: 0033:0x7fce8257bb9a
[ 59.025720] Code: 48 8b 0d 01 c3 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f
1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0
ff ff 73 01 c3 48 8b 0d ce c2 2b 00 f7 d8 64 89 01 48
[ 59.028481] RSP: 002b:00007ffe1b5d8e98 EFLAGS: 00000202 ORIG_RAX:
00000000000000a5
[ 59.029603] RAX: ffffffffffffffda RBX: 0000000000bfd030 RCX: 00007fce8257bb9a
[ 59.030655] RDX: 0000000000bfd210 RSI: 0000000000bfff40 RDI: 0000000000bfd230
[ 59.031707] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000013
[ 59.032760] R10: 00000000c0ed0000 R11: 0000000000000202 R12: 0000000000bfd230
[ 59.033817] R13: 0000000000bfd210 R14: 0000000000000000 R15: 0000000000000003
[ 59.034874] Modules linked in:
[ 59.035340] CR2: 000000003d9b84b4
[ 59.035855] ---[ end trace 7ed20adebf31865a ]---
[ 59.036552] RIP: 0010:update_sit_entry+0x113/0x420
[ 59.037267] Code: c7 43 20 00 00 00 00 45 89 e8 44 89 e9 b8 01 00 00 00 41 c1
e8 03 f7 d1 4c 89 c6 48 03 73 08 83 e1 07 d3 e0 45 85 ff 41 89 c5 <0f> be 16 0f
8e 6a 01 00 00 89 d1 09 c1 85 c2 88 0e 0f 85 4f 02 00
[ 59.040045] RSP: 0018:ffffabe94110b9c8 EFLAGS: 00010286
[ 59.040826] RAX: 0000000000000040 RBX: ffff9b1274e00360 RCX: 0000000000000006
[ 59.041906] RDX: ffff9b127282d600 RSI: 000000003d9b84b4 RDI: ffffffffffffffff
[ 59.042961] RBP: ffffabe94110ba00 R08: 0000000000000020 R09: 00000000000a0901
[ 59.044016] R10: ffff9b126fd0ec40 R11: ffffabe94110b7bd R12: ffff9b126e530000
[ 59.045067] R13: 0000000000000040 R14: 00000000000004fc R15: 00000000ffffffff
[ 59.046135] FS: 00007fce82c9c840(0000) GS:ffff9b1277a00000(0000)
knlGS:0000000000000000
[ 59.047324] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 59.048173] CR2: 00007efe47968950 CR3: 00000002333da005 CR4: 00000000001606f0

[ 63.582542] F2FS-fs (sdb): Can't find valid F2FS filesystem in 2th superblock
[ 63.611664] F2FS-fs (sdb): invalid blkaddr: 657665, type: 6, run fsck to fix.
[ 63.612831] F2FS-fs (sdb): invalid blkaddr: 657665, type: 6, run fsck to fix.
[ 63.613931] BUG: unable to handle kernel paging request at ffffffff98c4c800
[ 63.614876] #PF error: [PROT] [WRITE]
[ 63.615381] PGD 1de012067 P4D 1de012067 PUD 1de013063 PMD 80000001dda000e1 
[ 63.616361] Oops: 0003 [#1] SMP PTI
[ 63.616847] CPU: 0 PID: 1057 Comm: mount Tainted: G W 5.0.0 #3
[ 63.617811] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[ 63.619085] RIP: 0010:update_sit_entry+0x293/0x420
[ 63.619738] Code: 00 00 0f 83 7f fe ff ff 48 89 82 90 00 00 00 e9 73 fe ff ff
48 29 d0 48 03 46 78 eb cf 41 89 c2 89 d1 41 f7 d2 44 21 d1 85 c2 <88> 0e 0f 84
17 01 00 00 49 8b 54 24 48 80 e6 01 0f 85 4b 01 00 00
[ 63.622308] RSP: 0000:ffffafe8810cf9c8 EFLAGS: 00010246
[ 63.623017] RAX: 0000000000000040 RBX: ffff937c318bfb60 RCX: 0000000000000000
[ 63.623997] RDX: 0000000000000000 RSI: ffffffff98c4c800 RDI: 0000000000000000
[ 63.624975] RBP: ffffafe8810cfa00 R08: 0000000000000020 R09: 00000000000a0901
[ 63.625935] R10: 00000000ffffffbf R11: ffffafe8810cf7bd R12: ffff937c2b122800
[ 63.626896] R13: 0000000000000040 R14: 00000000000004fc R15: 00000000ffffffff
[ 63.627862] FS: 00007faf64c2b840(0000) GS:ffff937c37a00000(0000)
knlGS:0000000000000000
[ 63.628984] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 63.629762] CR2: ffffffff98c4c800 CR3: 00000002353f4004 CR4: 00000000001606f0
[ 63.630726] Call Trace:
[ 63.631071] f2fs_do_replace_block+0x1c1/0x510
[ 63.631680] f2fs_replace_block+0x4b/0x80
[ 63.632269] recover_data+0xac9/0x1c90
[ 63.632787] f2fs_recover_fsync_data+0x68f/0x800
[ 63.633419] ? proc_create_single_data+0x41/0x50
[ 63.634050] f2fs_fill_super+0x1bdd/0x1d50
[ 63.634612] ? snprintf+0x45/0x70
[ 63.635071] mount_bdev+0x17b/0x1b0
[ 63.635553] ? f2fs_commit_super+0x190/0x190
[ 63.636161] ? mount_bdev+0x17b/0x1b0
[ 63.636676] ? f2fs_commit_super+0x190/0x190
[ 63.637259] f2fs_mount+0x15/0x20
[ 63.637716] mount_fs+0x51/0x170
[ 63.638163] vfs_kern_mount+0x67/0x120
[ 63.638679] do_mount+0x208/0xd20
[ 63.639137] ? __check_object_size+0x151/0x1b0
[ 63.639745] ? memdup_user+0x4f/0x70
[ 63.640275] ksys_mount+0x83/0xd0
[ 63.640734] __x64_sys_mount+0x25/0x30
[ 63.641249] do_syscall_64+0x5a/0x110
[ 63.641753] entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 63.642439] RIP: 0033:0x7faf6450ab9a
[ 63.642932] Code: 48 8b 0d 01 c3 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f
1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0
ff ff 73 01 c3 48 8b 0d ce c2 2b 00 f7 d8 64 89 01 48
[ 63.645485] RSP: 002b:00007ffda90ea048 EFLAGS: 00000206 ORIG_RAX:
00000000000000a5
[ 63.646504] RAX: ffffffffffffffda RBX: 0000000002240030 RCX: 00007faf6450ab9a
[ 63.647467] RDX: 0000000002240210 RSI: 0000000002242f40 RDI: 0000000002240230
[ 63.648465] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000013
[ 63.649435] R10: 00000000c0ed0000 R11: 0000000000000206 R12: 0000000002240230
[ 63.650406] R13: 0000000002240210 R14: 0000000000000000 R15: 0000000000000003
[ 63.651378] Modules linked in:
[ 63.651805] CR2: ffffffff98c4c800
[ 63.652298] ---[ end trace 880c173854b1dcb0 ]---
[ 63.652938] RIP: 0010:update_sit_entry+0x293/0x420
[ 63.653592] Code: 00 00 0f 83 7f fe ff ff 48 89 82 90 00 00 00 e9 73 fe ff ff
48 29 d0 48 03 46 78 eb cf 41 89 c2 89 d1 41 f7 d2 44 21 d1 85 c2 <88> 0e 0f 84
17 01 00 00 49 8b 54 24 48 80 e6 01 0f 85 4b 01 00 00
[ 63.656101] RSP: 0000:ffffafe8810cf9c8 EFLAGS: 00010246
[ 63.656812] RAX: 0000000000000040 RBX: ffff937c318bfb60 RCX: 0000000000000000
[ 63.657773] RDX: 0000000000000000 RSI: ffffffff98c4c800 RDI: 0000000000000000
[ 63.658737] RBP: ffffafe8810cfa00 R08: 0000000000000020 R09: 00000000000a0901
[ 63.659699] R10: 00000000ffffffbf R11: ffffafe8810cf7bd R12: ffff937c2b122800
[ 63.660696] R13: 0000000000000040 R14: 00000000000004fc R15: 00000000ffffffff
[ 63.661658] FS: 00007faf64c2b840(0000) GS:ffff937c37a00000(0000)
knlGS:0000000000000000
[ 63.662748] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 63.663526] CR2: ffffffff98c4c800 CR3: 00000002353f4004 CR4: 00000000001606f0

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
