From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 203343] New: page fault and hang on umounting
Date: Wed, 17 Apr 2019 00:43:44 +0000
Message-ID: <bug-203343-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1hGYg4-0002h5-BZ
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Apr 2019 00:43:52 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hGYg2-00Arv4-Te
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Apr 2019 00:43:52 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 56797286FB
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 17 Apr 2019 00:43:45 +0000 (UTC)
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

https://bugzilla.kernel.org/show_bug.cgi?id=203343

            Bug ID: 203343
           Summary: page fault and hang on umounting
           Product: File System
           Version: 2.5
    Kernel Version: 5.0
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

Created attachment 282365
  --> https://bugzilla.kernel.org/attachment.cgi?id=282365&action=edit
image and program

- Overview
When mounting the attached crafted image and running program, I got this error.
The image is intentionally fuzzed from a normal f2fs image for testing.
Additionally, it hangs after un-mount the test directory.

- Produces
cc poc_15.c
./run.sh f2fs
sudo umount test

- Kernel Messages
[   43.639591] F2FS-fs (sdb): Bitmap was wrongly cleared, blk:7424
[   43.640885] F2FS-fs (sdb): Bitmap was wrongly cleared, blk:7680
[   43.644975] BUG: unable to handle kernel paging request at 00000c9800000f08
[   43.646215] #PF error: [WRITE]
[   43.646762] PGD 0 P4D 0 
[   43.647219] Oops: 0002 [#1] SMP PTI
[   43.647857] CPU: 0 PID: 1054 Comm: a.out Tainted: G        W         5.0.0
#3
[   43.649090] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   43.650857] RIP: 0010:__remove_dirty_segment+0x61/0xd0
[   43.651850] Code: 48 8b 97 88 00 00 00 4c 8d 0c 80 49 c1 e1 03 48 8b 12 48
8b 52 68 42 0f b6 14 0a 83 e2 3f 49 89 d0 41 83 e0 3f 4e 8b 44 c1 08 <3e> 49 0f
b3 00 72 42 44 8b 87 d8 03 00 00 48 8b 87 88 00 00 00 41
[   43.655422] RSP: 0018:ffffbb6d01153c70 EFLAGS: 00010202
[   43.656452] RAX: 0000000000000007 RBX: 0000000000000007 RCX:
ffff950ceb2b0300
[   43.657860] RDX: 0000000000000019 RSI: 0000000000000007 RDI:
ffff950cf13d0000
[   43.659277] RBP: ffffbb6d01153c70 R08: 00000c9800000f08 R09:
0000000000000118
[   43.660538] R10: ffffbb6d00ca3c90 R11: 000000000000a4f6 R12:
ffff950cf13d0000
[   43.661869] R13: ffff950ceb2b0348 R14: ffff950ceb2b0d00 R15:
ffffbb6d01153d38
[   43.663276] FS:  00007f7dd8377700(0000) GS:ffff950cf7a00000(0000)
knlGS:0000000000000000
[   43.664702] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   43.665841] CR2: 00000c9800000f08 CR3: 0000000235260002 CR4:
00000000001606f0
[   43.667255] Call Trace:
[   43.667754]  locate_dirty_segment+0x116/0x120
[   43.668626]  f2fs_invalidate_blocks+0x76/0x120
[   43.669525]  f2fs_truncate_data_blocks_range+0xd9/0x360
[   43.670578]  f2fs_truncate_blocks+0x43b/0x530
[   43.671446]  f2fs_truncate+0x8d/0x110
[   43.672192]  f2fs_setattr+0x3e6/0x460
[   43.672924]  notify_change+0x2e1/0x410
[   43.673676]  do_truncate+0x75/0xc0
[   43.674364]  do_sys_ftruncate+0x125/0x1c0
[   43.675177]  __x64_sys_ftruncate+0x1b/0x20
[   43.676011]  do_syscall_64+0x5a/0x110
[   43.676639]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   43.677646] RIP: 0033:0x7f7dd7e924d9
[   43.678368] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d 8f 29 2c 00 f7 d8 64 89 01 48
[   43.682035] RSP: 002b:00007ffebc3caa48 EFLAGS: 00000286 ORIG_RAX:
000000000000004d
[   43.683468] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f7dd7e924d9
[   43.684884] RDX: ffffffffffffff98 RSI: 0000000000000deb RDI:
0000000000000003
[   43.686294] RBP: 00007ffebc3ceed0 R08: 00007ffebc3cefb8 R09:
00007ffebc3cefb8
[   43.687668] R10: 0000000000000001 R11: 0000000000000286 R12:
00000000004004e0
[   43.689062] R13: 00007ffebc3cefb0 R14: 0000000000000000 R15:
0000000000000000
[   43.690467] Modules linked in:
[   43.691084] CR2: 00000c9800000f08
[   43.691774] ---[ end trace aeb1be51e7dc75ed ]---
[   43.692706] RIP: 0010:__remove_dirty_segment+0x61/0xd0
[   43.693739] Code: 48 8b 97 88 00 00 00 4c 8d 0c 80 49 c1 e1 03 48 8b 12 48
8b 52 68 42 0f b6 14 0a 83 e2 3f 49 89 d0 41 83 e0 3f 4e 8b 44 c1 08 <3e> 49 0f
b3 00 72 42 44 8b 87 d8 03 00 00 48 8b 87 88 00 00 00 41
[   43.697460] RSP: 0018:ffffbb6d01153c70 EFLAGS: 00010202
[   43.698502] RAX: 0000000000000007 RBX: 0000000000000007 RCX:
ffff950ceb2b0300
[   43.699885] RDX: 0000000000000019 RSI: 0000000000000007 RDI:
ffff950cf13d0000
[   43.701317] RBP: ffffbb6d01153c70 R08: 00000c9800000f08 R09:
0000000000000118
[   43.702735] R10: ffffbb6d00ca3c90 R11: 000000000000a4f6 R12:
ffff950cf13d0000
[   43.704151] R13: ffff950ceb2b0348 R14: ffff950ceb2b0d00 R15:
ffffbb6d01153d38
[   43.705478] FS:  00007f7dd8377700(0000) GS:ffff950cf7a00000(0000)
knlGS:0000000000000000
[   43.707102] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   43.708259] CR2: 00000c9800000f08 CR3: 0000000235260002 CR4:
00000000001606f0
./run.sh: line 10:  1053 Killed                  sudo ./a.out

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
