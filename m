From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 203229] New: kernel BUG at fs/f2fs/recovery.c:591!
 and hangs on sync
Date: Tue, 09 Apr 2019 22:51:51 +0000
Message-ID: <bug-203229-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1hDzay-0000YK-Ax
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Apr 2019 22:52:00 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hDzaw-00CABO-PB
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Apr 2019 22:52:00 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 2A3E328673
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  9 Apr 2019 22:51:52 +0000 (UTC)
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

https://bugzilla.kernel.org/show_bug.cgi?id=203229

            Bug ID: 203229
           Summary: kernel BUG at fs/f2fs/recovery.c:591! and hangs on
                    sync
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

Created attachment 282231
  --> https://bugzilla.kernel.org/attachment.cgi?id=282231&action=edit
The (compressed) crafted image which causes crash

- Overview
When mounting the attached crafted image, following errors are reported.
Additionally, it hangs on sync after trying to mount it.

The image is intentionally fuzzed from a normal f2fs image for testing.
Compile options for F2FS are as follows.
CONFIG_F2FS_FS=y
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
CONFIG_F2FS_CHECK_FS=y
# CONFIG_F2FS_FS_ENCRYPTION is not set
# CONFIG_F2FS_FAULT_INJECTION is not set

- Reproduces
mkdir test
mount -t f2fs tmp.img test
sync

- Kernel message
[   22.820057] F2FS-fs (sdb): invalid crc value
[   22.823032] WARNING: CPU: 0 PID: 1879 at fs/f2fs/node.c:2586
f2fs_recover_inode_page+0x3ca/0x3f0
[   22.823034] Modules linked in:
[   22.823037] CPU: 0 PID: 1879 Comm: mount Not tainted 5.0.0 #5
[   22.823037] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   22.823039] RIP: 0010:f2fs_recover_inode_page+0x3ca/0x3f0
[   22.823041] Code: ff ff 48 8b 8a 74 01 00 00 48 89 88 74 01 00 00 8b 92 7c
01 00 00 89 90 7c 01 00 00 e9 87 fe ff ff 41 c6 84 24 e8 05 00 00 00 <0f> 0b e9
16 ff ff ff b8 ea ff ff ff e9 77 ff ff ff 41 03 94 24 10
[   22.823042] RSP: 0018:ffffae6380cf3bd8 EFLAGS: 00010297
[   22.823043] RAX: 0000000000007f00 RBX: fffff90a48d85740 RCX:
0000000000000008
[   22.823044] RDX: 0000000000007f01 RSI: 0000000000000020 RDI:
ffffa3c5f6109de8
[   22.823044] RBP: ffffae6380cf3c30 R08: 0000000000000000 R09:
ffffffff93332f01
[   22.823045] R10: ffffa3c5eeb4b078 R11: 0000000000000001 R12:
ffffa3c5f6109800
[   22.823046] R13: 0000000000000009 R14: 0000000231b8d000 R15:
0000000000000009
[   22.823048] FS:  00007f8c9c06b840(0000) GS:ffffa3c5f7a00000(0000)
knlGS:0000000000000000
[   22.823050] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   22.823051] CR2: 00007ffc7f26dfcc CR3: 0000000235d64001 CR4:
00000000001606f0
[   22.823052] Call Trace:
[   22.823070]  f2fs_recover_fsync_data+0x6cf/0x710
[   22.823076]  ? proc_create_single_data+0x37/0x50
[   22.823078]  f2fs_fill_super+0x1043/0x1aa0
[   22.823080]  ? f2fs_commit_super+0x180/0x180
[   22.823086]  mount_bdev+0x16d/0x1a0
[   22.823088]  mount_fs+0x4a/0x170
[   22.823092]  vfs_kern_mount+0x5d/0x100
[   22.823095]  do_mount+0x200/0xcf0
[   22.823100]  ? memdup_user+0x39/0x60
[   22.823101]  ksys_mount+0x79/0xc0
[   22.823103]  __x64_sys_mount+0x1c/0x20
[   22.823106]  do_syscall_64+0x43/0xf0
[   22.823112]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   22.823114] RIP: 0033:0x7f8c9b94ab9a
[   22.823115] Code: 48 8b 0d 01 c3 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e
0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d ce c2 2b 00 f7 d8 64 89 01 48
[   22.823116] RSP: 002b:00007ffc7f26f7f8 EFLAGS: 00000202 ORIG_RAX:
00000000000000a5
[   22.823117] RAX: ffffffffffffffda RBX: 0000000000dc2050 RCX:
00007f8c9b94ab9a
[   22.823118] RDX: 0000000000dc2230 RSI: 0000000000dc2f20 RDI:
0000000000dc2250
[   22.823119] RBP: 0000000000000000 R08: 0000000000000000 R09:
0000000000000013
[   22.823119] R10: 00000000c0ed0000 R11: 0000000000000202 R12:
0000000000dc2250
[   22.823120] R13: 0000000000dc2230 R14: 0000000000000000 R15:
0000000000000003
[   22.823122] ---[ end trace f9a70503bb3dfdc3 ]---
[   22.823142] ------------[ cut here ]------------
[   22.823143] kernel BUG at fs/f2fs/recovery.c:591!
[   22.824026] invalid opcode: 0000 [#1] SMP PTI
[   22.824618] CPU: 0 PID: 1879 Comm: mount Tainted: G        W         5.0.0
#5
[   22.825553] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   22.826799] RIP: 0010:recover_data+0x12d8/0x1780
[   22.827411] Code: 00 3e 80 48 49 08 e9 17 fc ff ff 4c 89 f7 e8 2f 56 e9 ff
e9 0f f8 ff ff 48 8d 7c 24 70 e8 b0 80 fe ff 85 c0 0f 84 ee f5 ff ff <0f> 0b 48
8b 7c 24 78 48 89 7c 24 38 e8 57 e3 71 00 48 8b 7c 24 38
[   22.829889] RSP: 0018:ffffae6380cf3b18 EFLAGS: 00010286
[   22.830576] RAX: 00000000ffffffe4 RBX: ffffa3c5f6109800 RCX:
ffffa3c5f2978000
[   22.831529] RDX: 0000000000000001 RSI: 0000000000001000 RDI:
ffffa3c5eebc0cc0
[   22.832488] RBP: 0000000000000230 R08: 0000000000000001 R09:
0000000000000009
[   22.833430] R10: fffff90a48d85740 R11: fffff90a40000000 R12:
0000000000001000
[   22.834365] R13: 0000000000000000 R14: 0000000000000000 R15:
0000000001000041
[   22.835320] FS:  00007f8c9c06b840(0000) GS:ffffa3c5f7a00000(0000)
knlGS:0000000000000000
[   22.836374] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   22.837159] CR2: 00007ffc7f26dfcc CR3: 0000000235d64001 CR4:
00000000001606f0
[   22.838093] Call Trace:
[   22.838428]  ? mark_page_accessed+0x9c/0x110
[   22.839024]  ? pagecache_get_page+0x177/0x210
[   22.839610]  f2fs_recover_fsync_data+0x613/0x710
[   22.840223]  ? proc_create_single_data+0x37/0x50
[   22.840858]  f2fs_fill_super+0x1043/0x1aa0
[   22.841402]  ? f2fs_commit_super+0x180/0x180
[   22.841966]  mount_bdev+0x16d/0x1a0
[   22.842455]  mount_fs+0x4a/0x170
[   22.842887]  vfs_kern_mount+0x5d/0x100
[   22.843386]  do_mount+0x200/0xcf0
[   22.843828]  ? memdup_user+0x39/0x60
[   22.844302]  ksys_mount+0x79/0xc0
[   22.844771]  __x64_sys_mount+0x1c/0x20
[   22.845268]  do_syscall_64+0x43/0xf0
[   22.845746]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   22.846412] RIP: 0033:0x7f8c9b94ab9a
[   22.846888] Code: 48 8b 0d 01 c3 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e
0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d ce c2 2b 00 f7 d8 64 89 01 48
[   22.849339] RSP: 002b:00007ffc7f26f7f8 EFLAGS: 00000202 ORIG_RAX:
00000000000000a5
[   22.850330] RAX: ffffffffffffffda RBX: 0000000000dc2050 RCX:
00007f8c9b94ab9a
[   22.851285] RDX: 0000000000dc2230 RSI: 0000000000dc2f20 RDI:
0000000000dc2250
[   22.852218] RBP: 0000000000000000 R08: 0000000000000000 R09:
0000000000000013
[   22.853154] R10: 00000000c0ed0000 R11: 0000000000000202 R12:
0000000000dc2250
[   22.854108] R13: 0000000000dc2230 R14: 0000000000000000 R15:
0000000000000003
[   22.855058] Modules linked in:
[   22.855476] ---[ end trace f9a70503bb3dfdc4 ]---
[   22.856095] RIP: 0010:recover_data+0x12d8/0x1780
[   22.856715] Code: 00 3e 80 48 49 08 e9 17 fc ff ff 4c 89 f7 e8 2f 56 e9 ff
e9 0f f8 ff ff 48 8d 7c 24 70 e8 b0 80 fe ff 85 c0 0f 84 ee f5 ff ff <0f> 0b 48
8b 7c 24 78 48 89 7c 24 38 e8 57 e3 71 00 48 8b 7c 24 38
[   22.859167] RSP: 0018:ffffae6380cf3b18 EFLAGS: 00010286
[   22.859873] RAX: 00000000ffffffe4 RBX: ffffa3c5f6109800 RCX:
ffffa3c5f2978000
[   22.860818] RDX: 0000000000000001 RSI: 0000000000001000 RDI:
ffffa3c5eebc0cc0
[   22.861781] RBP: 0000000000000230 R08: 0000000000000001 R09:
0000000000000009
[   22.862717] R10: fffff90a48d85740 R11: fffff90a40000000 R12:
0000000000001000
[   22.863655] R13: 0000000000000000 R14: 0000000000000000 R15:
0000000001000041
[   22.864592] FS:  00007f8c9c06b840(0000) GS:ffffa3c5f7a00000(0000)
knlGS:0000000000000000
[   22.865657] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   22.866418] CR2: 00007ffc7f26dfcc CR3: 0000000235d64001 CR4:
00000000001606f0
[   22.868476] mount (1879) used greatest stack depth: 13320 bytes left

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
