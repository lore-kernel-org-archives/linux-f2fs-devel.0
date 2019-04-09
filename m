From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 203233] New: kernel BUG at fs/f2fs/segment.c:2102!
Date: Tue, 09 Apr 2019 23:07:58 +0000
Message-ID: <bug-203233-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1hDzqZ-00079g-RC
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Apr 2019 23:08:07 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hDzqX-00CBcE-T1
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Apr 2019 23:08:07 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 0B47024B44
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  9 Apr 2019 23:08:00 +0000 (UTC)
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

https://bugzilla.kernel.org/show_bug.cgi?id=203233

            Bug ID: 203233
           Summary: kernel BUG at fs/f2fs/segment.c:2102!
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

Created attachment 282237
  --> https://bugzilla.kernel.org/attachment.cgi?id=282237&action=edit
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
cc poc_13.c
mkdir test
mount -t f2fs tmp.img test
cp a.out test
cd test
sudo ./a.out
sync

- Kernel messages
[   35.628135] F2FS-fs (sdb): Mounted with checkpoint version = 7548c2d6
[   35.643236] F2FS-fs (sdb): Bitmap was wrongly set, blk:4608
[   35.644093] ------------[ cut here ]------------
[   35.644095] kernel BUG at fs/f2fs/segment.c:2102!
[   35.644737] invalid opcode: 0000 [#1] SMP PTI
[   35.645342] CPU: 0 PID: 1952 Comm: a.out Not tainted 5.0.0 #5
[   35.646128] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   35.647438] RIP: 0010:update_sit_entry+0x394/0x410
[   35.648101] Code: 10 81 c1 93 48 c7 c6 7b 8a be 93 e8 16 01 fe ff 0f 0b 48
8b 3b 89 e9 48 c7 c2 50 81 c1 93 48 c7 c6 7b 8a be 93 e8 fc 00 fe ff <0f> 0b 48
8b 3b 41 83 e0 01 89 e9 48 c7 c2 70 81 c1 93 48 c7 c6 7b
[   35.650553] RSP: 0018:ffffb18e00d339d8 EFLAGS: 00010286
[   35.651241] RAX: 0000000000000000 RBX: ffff9202765e8800 RCX:
0000000000000000
[   35.652213] RDX: 0000000000000000 RSI: ffff920277a15418 RDI:
ffff920277a15418
[   35.653152] RBP: 0000000000001200 R08: 000000000009d0a4 R09:
0000000000000005
[   35.654094] R10: 0000000000000002 R11: ffffb18e00d3381d R12:
0000000000000001
[   35.655028] R13: ffff9202765e9830 R14: 0000000000000001 R15:
0000000000000000
[   35.655967] FS:  00007f65e82f2700(0000) GS:ffff920277a00000(0000)
knlGS:0000000000000000
[   35.657039] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   35.657837] CR2: 00007f65e7e0d4c0 CR3: 0000000235150005 CR4:
00000000001606f0
[   35.658794] Call Trace:
[   35.659136]  f2fs_allocate_data_block+0x16f/0x660
[   35.659759]  do_write_page+0x62/0x170
[   35.660269]  f2fs_do_write_node_page+0x33/0xa0
[   35.660864]  __write_node_page+0x270/0x4e0
[   35.661417]  f2fs_sync_node_pages+0x5df/0x670
[   35.661998]  ? writeback_single_inode+0xd1/0x100
[   35.662613]  ? iput+0x66/0x1e0
[   35.663024]  f2fs_write_checkpoint+0x372/0x1400
[   35.663626]  ? xa_load+0x54/0xa0
[   35.664076]  ? blk_finish_plug+0x22/0x30
[   35.664601]  ? f2fs_fill_dentries+0x19d/0x1d0
[   35.665182]  ? f2fs_sync_fs+0xa3/0x130
[   35.665693]  f2fs_sync_fs+0xa3/0x130
[   35.666178]  ? touch_atime+0xc1/0xd0
[   35.666655]  f2fs_do_sync_file+0x1a6/0x810
[   35.667200]  do_fsync+0x33/0x60
[   35.667636]  __x64_sys_fsync+0xb/0x10
[   35.668143]  do_syscall_64+0x43/0xf0
[   35.668624]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   35.669294] RIP: 0033:0x7f65e7e0d4d9
[   35.669783] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d 8f 29 2c 00 f7 d8 64 89 01 48
[   35.672241] RSP: 002b:00007fffed3c90b8 EFLAGS: 00000203 ORIG_RAX:
000000000000004a
[   35.673243] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f65e7e0d4d9
[   35.674205] RDX: 00007f65e7e0d4d9 RSI: 0000000000000928 RDI:
0000000000000003
[   35.675142] RBP: 00007fffed3cd200 R08: 00007fffed3cd2e8 R09:
00007fffed3cd2e8
[   35.676080] R10: 00007fffed3cd2e8 R11: 0000000000000203 R12:
00000000004004e0
[   35.677064] R13: 00007fffed3cd2e0 R14: 0000000000000000 R15:
0000000000000000
[   35.678018] Modules linked in:
[   35.678439] ---[ end trace ea48b3729c06467c ]---
[   35.679060] RIP: 0010:update_sit_entry+0x394/0x410
[   35.679693] Code: 10 81 c1 93 48 c7 c6 7b 8a be 93 e8 16 01 fe ff 0f 0b 48
8b 3b 89 e9 48 c7 c2 50 81 c1 93 48 c7 c6 7b 8a be 93 e8 fc 00 fe ff <0f> 0b 48
8b 3b 41 83 e0 01 89 e9 48 c7 c2 70 81 c1 93 48 c7 c6 7b
[   35.682210] RSP: 0018:ffffb18e00d339d8 EFLAGS: 00010286
[   35.682930] RAX: 0000000000000000 RBX: ffff9202765e8800 RCX:
0000000000000000
[   35.683873] RDX: 0000000000000000 RSI: ffff920277a15418 RDI:
ffff920277a15418
[   35.684838] RBP: 0000000000001200 R08: 000000000009d0a4 R09:
0000000000000005
[   35.685794] R10: 0000000000000002 R11: ffffb18e00d3381d R12:
0000000000000001
[   35.686751] R13: ffff9202765e9830 R14: 0000000000000001 R15:
0000000000000000
[   35.687688] FS:  00007f65e82f2700(0000) GS:ffff920277a00000(0000)
knlGS:0000000000000000
[   35.688751] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   35.689550] CR2: 00007f65e7e0d4c0 CR3: 0000000235150005 CR4:
00000000001606f0
[   35.690539] WARNING: CPU: 0 PID: 1952 at kernel/exit.c:781
do_exit+0x4a/0xbf0
[   35.691504] Modules linked in:
[   35.691916] CPU: 0 PID: 1952 Comm: a.out Tainted: G      D           5.0.0
#5
[   35.692855] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   35.694124] RIP: 0010:do_exit+0x4a/0xbf0
[   35.694647] Code: 04 25 28 00 00 00 48 89 44 24 30 31 c0 e8 7e 6c 06 00 48
8b 83 40 07 00 00 48 85 c0 74 0e 48 8b 10 48 39 d0 0f 84 6b 07 00 00 <0f> 0b 65
44 8b 25 ec 21 5b 6d 41 81 e4 00 ff 1f 00 44 89 64 24 0c
[   35.697087] RSP: 0018:ffffb18e00d33ee8 EFLAGS: 00010216
[   35.697788] RAX: ffffb18e00d33d70 RBX: ffff92026bbca880 RCX:
00000000ffffffff
[   35.698723] RDX: ffff920275fcc048 RSI: 0000000000000000 RDI:
ffffffff93e4e6c0
[   35.699670] RBP: 000000000000000b R08: 0000000000000000 R09:
0000000000000005
[   35.700616] R10: 000000000000002b R11: ffffb18e00d33705 R12:
0000000000000246
[   35.701574] R13: 0000000000000004 R14: 0000000000000002 R15:
ffffffff92d37994
[   35.702511] FS:  00007f65e82f2700(0000) GS:ffff920277a00000(0000)
knlGS:0000000000000000
[   35.703591] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   35.704352] CR2: 00007f65e7e0d4c0 CR3: 0000000235150005 CR4:
00000000001606f0
[   35.705364] Call Trace:
[   35.705728]  ? do_fsync+0x33/0x60
[   35.706170]  ? update_sit_entry+0x394/0x410
[   35.706724]  rewind_stack_do_exit+0x17/0x20
[   35.707278] ---[ end trace ea48b3729c06467d ]---

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
...
2086     /* Update valid block bitmap */
2087     if (del > 0) {
2088         exist = f2fs_test_and_set_bit(offset, se->cur_valid_map);
2089 #ifdef CONFIG_F2FS_CHECK_FS
2090         mir_exist = f2fs_test_and_set_bit(offset,
2091                         se->cur_valid_map_mir);
2092         if (unlikely(exist != mir_exist)) {
2093             f2fs_msg(sbi->sb, KERN_ERR, "Inconsistent error "
2094                 "when setting bitmap, blk:%u, old bit:%d",
2095                 blkaddr, exist);
2096             f2fs_bug_on(sbi, 1);
2097         }
2098 #endif
2099         if (unlikely(exist)) {
2100             f2fs_msg(sbi->sb, KERN_ERR,
2101                 "Bitmap was wrongly set, blk:%u", blkaddr);
*2102             f2fs_bug_on(sbi, 1);
2103             se->valid_blocks--;
2104             del = 0;
2105         }
2106

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
