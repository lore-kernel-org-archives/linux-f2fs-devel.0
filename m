From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 203171] New: PF error: at
 __remove_dirty_segment+0x61/0xd0
Date: Sat, 06 Apr 2019 01:46:33 +0000
Message-ID: <bug-203171-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1hCaPp-0002GZ-Vd
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 06 Apr 2019 01:46:41 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hCaPo-003md1-Kf
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 06 Apr 2019 01:46:41 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id B28A228B2C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat,  6 Apr 2019 01:46:34 +0000 (UTC)
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

https://bugzilla.kernel.org/show_bug.cgi?id=203171

            Bug ID: 203171
           Summary: PF error: at __remove_dirty_segment+0x61/0xd0
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

Created attachment 282157
  --> https://bugzilla.kernel.org/attachment.cgi?id=282157&action=edit
The (compressed) crafted image which causes crash

- Overview
When mounting the attached crafted image, I got this error.

- Produces
mkdir test
mount -t f2fs tmp.img test

- Messages
[ 107.646001] F2FS-fs (sdb): Can't find valid F2FS filesystem in 2th superblock
[ 107.654882] BUG: unable to handle kernel paging request at 000006e800000f08
[ 107.655922] #PF error: [WRITE]
[ 107.656383] PGD 0 P4D 0 
[ 107.656768] Oops: 0002 [#1] SMP PTI
[ 107.657289] CPU: 0 PID: 1038 Comm: mount Not tainted 5.0.0 #3
[ 107.658127] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[ 107.659500] RIP: 0010:__remove_dirty_segment+0x61/0xd0
[ 107.660255] Code: 48 8b 97 88 00 00 00 4c 8d 0c 80 49 c1 e1 03 48 8b 12 48 8b
52 68 42 0f b6 14 0a 83 e2 3f 49 89 d0 41 83 e0 3f 4e 8b 44 c1 08 <3e> 49 0f b3
00 72 42 44 8b 87 d8 03 00 00 48 8b 87 88 00 00 00 41
[ 107.662940] RSP: 0018:ffffb834c11179b0 EFLAGS: 00010202
[ 107.663705] RAX: 0000000000000008 RBX: ffff9478ef52d000 RCX: ffff9478e8d6d9c0
[ 107.664741] RDX: 000000000000001c RSI: 0000000000000008 RDI: ffff9478ef52d000
[ 107.665775] RBP: ffffb834c11179b0 R08: 000006e800000f08 R09: 0000000000000140
[ 107.666809] R10: 0000000000000000 R11: 0000000000000007 R12: 0000000000000008
[ 107.667843] R13: ffff9478e8d6da08 R14: 0000000000000002 R15: ffff9478f014d4e0
[ 107.668878] FS: 00007fe3e3e75840(0000) GS:ffff9478f7a00000(0000)
knlGS:0000000000000000
[ 107.670049] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 107.670886] CR2: 000006e800000f08 CR3: 000000022e59c004 CR4: 00000000001606f0
[ 107.671924] Call Trace:
[ 107.672302] change_curseg+0xe7/0x250
[ 107.672872] f2fs_do_replace_block+0xf8/0x510
[ 107.673511] f2fs_replace_block+0x4b/0x80
[ 107.674098] recover_data+0xac9/0x1c90
[ 107.674647] f2fs_recover_fsync_data+0x68f/0x800
[ 107.675325] ? proc_create_single_data+0x41/0x50
[ 107.676002] f2fs_fill_super+0x1bdd/0x1d50
[ 107.676608] ? snprintf+0x45/0x70
[ 107.677100] mount_bdev+0x17b/0x1b0
[ 107.677612] ? f2fs_commit_super+0x190/0x190
[ 107.678232] ? mount_bdev+0x17b/0x1b0
[ 107.678767] ? f2fs_commit_super+0x190/0x190
[ 107.679387] f2fs_mount+0x15/0x20
[ 107.679877] mount_fs+0x51/0x170
[ 107.680360] vfs_kern_mount+0x67/0x120
[ 107.680909] do_mount+0x208/0xd20
[ 107.681398] ? __check_object_size+0x151/0x1b0
[ 107.682048] ? memdup_user+0x4f/0x70
[ 107.682570] ksys_mount+0x83/0xd0
[ 107.683055] __x64_sys_mount+0x25/0x30
[ 107.683606] do_syscall_64+0x5a/0x110
[ 107.684148] entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 107.684884] RIP: 0033:0x7fe3e3754b9a
[ 107.685406] Code: 48 8b 0d 01 c3 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f
1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0
ff ff 73 01 c3 48 8b 0d ce c2 2b 00 f7 d8 64 89 01 48
[ 107.688056] RSP: 002b:00007ffef116fae8 EFLAGS: 00000206 ORIG_RAX:
00000000000000a5
[ 107.689143] RAX: ffffffffffffffda RBX: 0000000002342030 RCX: 00007fe3e3754b9a
[ 107.690165] RDX: 0000000002342210 RSI: 0000000002344f40 RDI: 0000000002342230
[ 107.691186] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000013
[ 107.692213] R10: 00000000c0ed0000 R11: 0000000000000206 R12: 0000000002342230
[ 107.693236] R13: 0000000002342210 R14: 0000000000000000 R15: 0000000000000003
[ 107.694260] Modules linked in:
[ 107.694715] CR2: 000006e800000f08
[ 107.695220] ---[ end trace 206927c7f0048e33 ]---
[ 107.695909] RIP: 0010:__remove_dirty_segment+0x61/0xd0
[ 107.696661] Code: 48 8b 97 88 00 00 00 4c 8d 0c 80 49 c1 e1 03 48 8b 12 48 8b
52 68 42 0f b6 14 0a 83 e2 3f 49 89 d0 41 83 e0 3f 4e 8b 44 c1 08 <3e> 49 0f b3
00 72 42 44 8b 87 d8 03 00 00 48 8b 87 88 00 00 00 41
[ 107.699327] RSP: 0018:ffffb834c11179b0 EFLAGS: 00010202
[ 107.700093] RAX: 0000000000000008 RBX: ffff9478ef52d000 RCX: ffff9478e8d6d9c0
[ 107.701125] RDX: 000000000000001c RSI: 0000000000000008 RDI: ffff9478ef52d000
[ 107.702171] RBP: ffffb834c11179b0 R08: 000006e800000f08 R09: 0000000000000140
[ 107.703201] R10: 0000000000000000 R11: 0000000000000007 R12: 0000000000000008
[ 107.704243] R13: ffff9478e8d6da08 R14: 0000000000000002 R15: ffff9478f014d4e0
[ 107.705280] FS: 00007fe3e3e75840(0000) GS:ffff9478f7a00000(0000)
knlGS:0000000000000000
[ 107.706452] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 107.707325] CR2: 000006e800000f08 CR3: 000000022e59c004 CR4: 00000000001606f0

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
