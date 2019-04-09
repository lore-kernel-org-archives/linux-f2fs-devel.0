From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 203215] New: failure at
 fs/f2fs/f2fs.h:2809/verify_blkaddr()!
Date: Tue, 09 Apr 2019 20:43:18 +0000
Message-ID: <bug-203215-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1hDxaY-0003gV-7D
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Apr 2019 20:43:26 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hDxaW-00Byqe-KJ
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Apr 2019 20:43:26 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id DCEA228844
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  9 Apr 2019 20:43:18 +0000 (UTC)
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

https://bugzilla.kernel.org/show_bug.cgi?id=203215

            Bug ID: 203215
           Summary: failure at fs/f2fs/f2fs.h:2809/verify_blkaddr()!
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

Created attachment 282209
  --> https://bugzilla.kernel.org/attachment.cgi?id=282209&action=edit
The (compressed) crafted image which causes crash

- Overview
When mounting the attached crafted image, this error is reported.

The image is intentionally fuzzed from a normal f2fs image for testing and I
run with option CONFIG_F2FS_CHECK_FS on.


- Reproduces
mkdir test
mount -t f2fs tmp.img test


- Messages
[  168.408970] F2FS-fs (sdb): Can't find valid F2FS filesystem in 2th
superblock
[  168.413779] F2FS-fs (sdb): invalid blkaddr: 1, type: 6, run fsck to fix.
[  168.415138] kernel BUG at fs/f2fs/f2fs.h:2809!
[  168.415858] invalid opcode: 0000 [#1] SMP PTI
[  168.416530] CPU: 0 PID: 1886 Comm: mount Tainted: G        W         5.0.0
#4
[  168.417529] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[  168.418806] RIP: 0010:f2fs_do_replace_block+0x499/0x4e0
[  168.419618] Code: 6c 7e 8a e8 d9 c9 fd ff 0f 0b 8b 4c 24 08 49 8b 3e 41 b8
06 00 00 00 48 c7 c2 b0 39 81 8a 48 c7 c6 7b 6c 7e 8a e8 b7 c9 fd ff <0f> 0b 49
8b 3e 41 b8 06 00 00 00 44 89 e1 48 c7 c2 b0 39 81 8a 48
[  168.422287] RSP: 0018:ffffacdec0cffa88 EFLAGS: 00010282
[  168.423042] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
0000000000000000
[  168.424023] RDX: 0000000000000000 RSI: ffff9ef677a15418 RDI:
ffff9ef677a15418
[  168.425092] RBP: ffff9ef6734dd000 R08: 0000000000065053 R09:
0000000000000005
[  168.426043] R10: 00000000ffffff00 R11: ffffacdec0cff8cd R12:
0000000000001700
[  168.427153] R13: 0000000000000003 R14: ffff9ef67603a800 R15:
0000000000000003
[  168.428088] FS:  00007f77a1e99840(0000) GS:ffff9ef677a00000(0000)
knlGS:0000000000000000
[  168.429121] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  168.429876] CR2: 00007ffd2b63aca8 CR3: 000000022b48c005 CR4:
00000000001606f0
[  168.430995] Call Trace:
[  168.431350]  f2fs_replace_block+0x45/0x70
[  168.431873]  recover_data+0xaf3/0x1780
[  168.432390]  f2fs_recover_fsync_data+0x613/0x710
[  168.433070]  ? proc_create_single_data+0x37/0x50
[  168.433749]  f2fs_fill_super+0x1043/0x1aa0
[  168.434353]  ? f2fs_commit_super+0x180/0x180
[  168.435022]  mount_bdev+0x16d/0x1a0
[  168.435492]  mount_fs+0x4a/0x170
[  168.435945]  vfs_kern_mount+0x5d/0x100
[  168.436499]  do_mount+0x200/0xcf0
[  168.436987]  ? memdup_user+0x39/0x60
[  168.437450]  ksys_mount+0x79/0xc0
[  168.437882]  __x64_sys_mount+0x1c/0x20
[  168.438370]  do_syscall_64+0x43/0xf0
[  168.438892]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  168.439645] RIP: 0033:0x7f77a1778b9a
[  168.440144] Code: 48 8b 0d 01 c3 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e
0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d ce c2 2b 00 f7 d8 64 89 01 48
[  168.442600] RSP: 002b:00007ffd2b63bd08 EFLAGS: 00000202 ORIG_RAX:
00000000000000a5
[  168.443765] RAX: ffffffffffffffda RBX: 0000000001481050 RCX:
00007f77a1778b9a
[  168.444774] RDX: 0000000001481230 RSI: 0000000001481f20 RDI:
0000000001481250
[  168.445799] RBP: 0000000000000000 R08: 0000000000000000 R09:
0000000000000013
[  168.446748] R10: 00000000c0ed0000 R11: 0000000000000202 R12:
0000000001481250
[  168.447811] R13: 0000000001481230 R14: 0000000000000000 R15:
0000000000000003
[  168.448805] Modules linked in:
[  168.449266] ---[ end trace 5e10f6c9bf2f50fb ]---
[  168.449908] RIP: 0010:f2fs_do_replace_block+0x499/0x4e0
[  168.450677] Code: 6c 7e 8a e8 d9 c9 fd ff 0f 0b 8b 4c 24 08 49 8b 3e 41 b8
06 00 00 00 48 c7 c2 b0 39 81 8a 48 c7 c6 7b 6c 7e 8a e8 b7 c9 fd ff <0f> 0b 49
8b 3e 41 b8 06 00 00 00 44 89 e1 48 c7 c2 b0 39 81 8a 48
[  168.453437] RSP: 0018:ffffacdec0cffa88 EFLAGS: 00010282
[  168.454123] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
0000000000000000
[  168.455169] RDX: 0000000000000000 RSI: ffff9ef677a15418 RDI:
ffff9ef677a15418
[  168.456216] RBP: ffff9ef6734dd000 R08: 0000000000065053 R09:
0000000000000005
[  168.457166] R10: 00000000ffffff00 R11: ffffacdec0cff8cd R12:
0000000000001700
[  168.458209] R13: 0000000000000003 R14: ffff9ef67603a800 R15:
0000000000000003
[  168.459189] FS:  00007f77a1e99840(0000) GS:ffff9ef677a00000(0000)
knlGS:0000000000000000
[  168.460345] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  168.461187] CR2: 00007ffd2b63aca8 CR3: 000000022b48c005 CR4:
00000000001606f0
[  168.463257] mount (1886) used greatest stack depth: 13152 bytes left

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
