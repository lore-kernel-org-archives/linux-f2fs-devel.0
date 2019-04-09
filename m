From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 203231] New: kernel BUG at fs/f2fs/segment.c:2079!
 and hangs on sync
Date: Tue, 09 Apr 2019 23:00:24 +0000
Message-ID: <bug-203231-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1hDzjS-0006Gy-4d
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Apr 2019 23:00:46 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hDzjD-00Cg0J-La
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Apr 2019 23:00:46 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 2D9032890E
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  9 Apr 2019 23:00:25 +0000 (UTC)
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

https://bugzilla.kernel.org/show_bug.cgi?id=203231

            Bug ID: 203231
           Summary: kernel BUG at fs/f2fs/segment.c:2079! and hangs on
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

Created attachment 282233
  --> https://bugzilla.kernel.org/attachment.cgi?id=282233&action=edit
The (compressed) crafted image which causes crash

- Overview
When mounting the attached crafted image and running program, following errors
are reported.
Additionally, it hangs on sync after running program.

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
cc poc_12.c
mkdir test
mount -t f2fs tmp.img test
cp a.out test
cd test
sudo ./a.out
sync

- Kernel message
[   35.866815] kernel BUG at fs/f2fs/segment.c:2079!
[   35.867465] invalid opcode: 0000 [#1] SMP PTI
[   35.868046] CPU: 0 PID: 1912 Comm: a.out Tainted: G        W         5.0.0
#5
[   35.869001] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   35.870241] RIP: 0010:update_sit_entry+0x344/0x410
[   35.870874] Code: c7 85 c1 40 88 3e 0f 85 63 fe ff ff 41 0f b7 4d 02 8d 71
01 66 81 e1 00 fc 66 81 e6 ff 03 09 f1 66 41 89 4d 02 e9 45 fe ff ff <0f> 0b 48
8b 43 10 8b 48 48 e9 0c fd ff ff 48 8b 43 10 8b 40 48 e9
[   35.873329] RSP: 0000:ffffa89f80e23d08 EFLAGS: 00010286
[   35.874026] RAX: 0000000000000200 RBX: ffff95e7eb936800 RCX:
ffffffffffffffff
[   35.874960] RDX: ffffffffffffffff RSI: 00000000ffffffff RDI:
ffff95e7eeccc780
[   35.875912] RBP: 0000000000002e2e R08: ffff95e7eeccc780 R09:
0000000000000001
[   35.876850] R10: ffffa89f80d73e18 R11: 0000000000000e60 R12:
00000000ffffffff
[   35.877803] R13: ffff95e7eb935ad0 R14: 000000000000000f R15:
000000000000002e
[   35.878763] FS:  00007f01c5c78700(0000) GS:ffff95e7f7a00000(0000)
knlGS:0000000000000000
[   35.879822] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   35.880603] CR2: 00007f4cdf7c7000 CR3: 000000022bc42003 CR4:
00000000001606f0
[   35.881537] Call Trace:
[   35.881871]  f2fs_invalidate_blocks+0x64/0xf0
[   35.882460]  f2fs_truncate_data_blocks_range+0xd2/0x350
[   35.883154]  f2fs_truncate_blocks+0x36d/0x3c0
[   35.883734]  f2fs_truncate+0x88/0x110
[   35.884229]  f2fs_evict_inode+0x2e4/0x3a0
[   35.884766]  evict+0xba/0x180
[   35.885169]  d_delete+0x9d/0xa0
[   35.885614]  vfs_rmdir+0xf6/0x120
[   35.886060]  do_rmdir+0x184/0x1c0
[   35.886527]  do_syscall_64+0x43/0xf0
[   35.887008]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   35.887677] RIP: 0033:0x7f01c57934d9
[   35.888160] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d 8f 29 2c 00 f7 d8 64 89 01 48
[   35.890610] RSP: 002b:00007ffd6381fb28 EFLAGS: 00000286 ORIG_RAX:
0000000000000054
[   35.891607] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f01c57934d9
[   35.892550] RDX: ffffffffffffff98 RSI: 00000000000006b0 RDI:
00007ffd6381fb70
[   35.893504] RBP: 00007ffd63823ca0 R08: 00007ffd63823d88 R09:
00007ffd63823d88
[   35.894445] R10: 00007ffd63823d88 R11: 0000000000000286 R12:
00000000004004e0
[   35.895386] R13: 00007ffd63823d80 R14: 0000000000000000 R15:
0000000000000000
[   35.896329] Modules linked in:
[   35.896772] ---[ end trace 852b270706f28c44 ]---
[   35.897390] RIP: 0010:update_sit_entry+0x344/0x410
[   35.898029] Code: c7 85 c1 40 88 3e 0f 85 63 fe ff ff 41 0f b7 4d 02 8d 71
01 66 81 e1 00 fc 66 81 e6 ff 03 09 f1 66 41 89 4d 02 e9 45 fe ff ff <0f> 0b 48
8b 43 10 8b 48 48 e9 0c fd ff ff 48 8b 43 10 8b 40 48 e9
[   35.900482] RSP: 0000:ffffa89f80e23d08 EFLAGS: 00010286
[   35.901178] RAX: 0000000000000200 RBX: ffff95e7eb936800 RCX:
ffffffffffffffff
[   35.902139] RDX: ffffffffffffffff RSI: 00000000ffffffff RDI:
ffff95e7eeccc780
[   35.903075] RBP: 0000000000002e2e R08: ffff95e7eeccc780 R09:
0000000000000001
[   35.904026] R10: ffffa89f80d73e18 R11: 0000000000000e60 R12:
00000000ffffffff
[   35.904979] R13: ffff95e7eb935ad0 R14: 000000000000000f R15:
000000000000002e
[   35.905925] FS:  00007f01c5c78700(0000) GS:ffff95e7f7a00000(0000)
knlGS:0000000000000000
[   35.906995] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   35.907764] CR2: 00007f4cdf7c7000 CR3: 000000022bc42003 CR4:
00000000001606f0

- Error location
2062 static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr,
int del)
2063 {
2064     struct seg_entry *se;
2065     unsigned int segno, offset;
2066     long int new_vblocks;
2067     bool exist;
2068 #ifdef CONFIG_F2FS_CHECK_FS
2069     bool mir_exist;
2070 #endif
2071 
2072     segno = GET_SEGNO(sbi, blkaddr);
2073 
2074     se = get_seg_entry(sbi, segno);
2075     new_vblocks = se->valid_blocks + del;
2076     offset = GET_BLKOFF_FROM_SEG0(sbi, blkaddr);
2077 
2078     f2fs_bug_on(sbi, (new_vblocks >> (sizeof(unsigned short) << 3) ||
*2079                 (new_vblocks > sbi->blocks_per_seg)));
2080

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
