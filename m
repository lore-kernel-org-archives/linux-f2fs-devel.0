From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 203213] New: kernel BUG at fs/f2fs/f2fs.h:2012 and
 hangs
Date: Tue, 09 Apr 2019 20:27:36 +0000
Message-ID: <bug-203213-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1hDxLa-0005dS-0e
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Apr 2019 20:27:58 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hDxLL-00BxOs-7N
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Apr 2019 20:27:57 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 4597528892
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  9 Apr 2019 20:27:37 +0000 (UTC)
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

https://bugzilla.kernel.org/show_bug.cgi?id=203213

            Bug ID: 203213
           Summary: kernel BUG at fs/f2fs/f2fs.h:2012 and hangs
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

Created attachment 282205
  --> https://bugzilla.kernel.org/attachment.cgi?id=282205&action=edit
The (compressed) crafted image which causes crash

- Overview
When mounting the attached crafted image and running program, I got this error.
Additionally, it hangs on sync after running the this script.

The image is intentionally fuzzed from a normal f2fs image for testing and I
enabled option CONFIG_F2FS_CHECK_FS on.

- Reproduces
mkdir test
mount -t f2fs tmp.img test
cp a.out test
cd test
sudo ./a.out
sync

- Messages
[   69.816604] kernel BUG at fs/f2fs/f2fs.h:2012!
[   69.817282] invalid opcode: 0000 [#1] SMP PTI
[   69.817882] CPU: 0 PID: 1896 Comm: a.out Not tainted 5.0.0 #4
[   69.818633] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   69.819904] RIP: 0010:truncate_node+0x2c9/0x2e0
[   69.820503] Code: ff ff ff ff e8 68 27 0b 00 48 8b 7d 00 e8 df a3 fe ff e9
b7 fe ff ff 0f 0b 0f 0b 49 83 bc 24 90 00 00 00 00 0f 85 e1 fd ff ff <0f> 0b 0f
0b e8 fe 0c d3 ff 0f 1f 40 00 66 2e 0f 1f 84 00 00 00 00
[   69.822970] RSP: 0018:ffff90e380d4fcd0 EFLAGS: 00010246
[   69.823683] RAX: 000000000000000f RBX: ffff8bc7361c6800 RCX:
0000000000000001
[   69.824601] RDX: 000000000000000b RSI: 0000000000000000 RDI:
ffff8bc7361c6de8
[   69.825528] RBP: ffff90e380d4fd18 R08: ffff8bc7363f5a01 R09:
ffff8bc7363f5d00
[   69.826454] R10: 0000000000000018 R11: ffff8bc72bb87228 R12:
ffff8bc72ebd2200
[   69.827421] R13: 000000000000000a R14: 0000000000000004 R15:
00007ffcb720f630
[   69.828355] FS:  00007f5877c00700(0000) GS:ffff8bc737a00000(0000)
knlGS:0000000000000000
[   69.829406] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   69.830164] CR2: 00007f587771b4c0 CR3: 000000023518a002 CR4:
00000000001606f0
[   69.831137] Call Trace:
[   69.831488]  f2fs_truncate_xattr_node+0xa1/0x130
[   69.832117]  f2fs_remove_inode_page+0x82/0x2d0
[   69.832705]  f2fs_evict_inode+0x2a3/0x3a0
[   69.833241]  evict+0xba/0x180
[   69.833641]  __dentry_kill+0xbe/0x160
[   69.834126]  dentry_kill+0x46/0x180
[   69.834590]  dput+0xbb/0x100
[   69.834994]  do_renameat2+0x3c9/0x550
[   69.835504]  __x64_sys_rename+0x17/0x20
[   69.836015]  do_syscall_64+0x43/0xf0
[   69.836493]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   69.837159] RIP: 0033:0x7f587771b4d9
[   69.837632] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d 8f 29 2c 00 f7 d8 64 89 01 48
[   69.840157] RSP: 002b:00007ffcb720f578 EFLAGS: 00000217 ORIG_RAX:
0000000000000052
[   69.841140] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f587771b4d9
[   69.842068] RDX: 00007f587771b4d9 RSI: 00007ffcb720f640 RDI:
00007ffcb720f630
[   69.843029] RBP: 00007ffcb72136b0 R08: 00007ffcb7213798 R09:
00007ffcb7213798
[   69.843975] R10: 00007ffcb7213798 R11: 0000000000000217 R12:
00000000004004e0
[   69.844905] R13: 00007ffcb7213790 R14: 0000000000000000 R15:
0000000000000000
[   69.845833] Modules linked in:
[   69.846271] ---[ end trace ce77f978d191a0d8 ]---
[   69.846884] RIP: 0010:truncate_node+0x2c9/0x2e0
[   69.847496] Code: ff ff ff ff e8 68 27 0b 00 48 8b 7d 00 e8 df a3 fe ff e9
b7 fe ff ff 0f 0b 0f 0b 49 83 bc 24 90 00 00 00 00 0f 85 e1 fd ff ff <0f> 0b 0f
0b e8 fe 0c d3 ff 0f 1f 40 00 66 2e 0f 1f 84 00 00 00 00
[   69.849951] RSP: 0018:ffff90e380d4fcd0 EFLAGS: 00010246
[   69.850647] RAX: 000000000000000f RBX: ffff8bc7361c6800 RCX:
0000000000000001
[   69.851626] RDX: 000000000000000b RSI: 0000000000000000 RDI:
ffff8bc7361c6de8
[   69.852569] RBP: ffff90e380d4fd18 R08: ffff8bc7363f5a01 R09:
ffff8bc7363f5d00
[   69.853523] R10: 0000000000000018 R11: ffff8bc72bb87228 R12:
ffff8bc72ebd2200
[   69.854485] R13: 000000000000000a R14: 0000000000000004 R15:
00007ffcb720f630
[   69.855484] FS:  00007f5877c00700(0000) GS:ffff8bc737a00000(0000)
knlGS:0000000000000000
[   69.856572] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   69.857337] CR2: 00007f587771b4c0 CR3: 000000023518a002 CR4:
00000000001606f0

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
