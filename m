From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 203241] New: kernel BUG at fs/f2fs/segment.c:3222!
 and hangs on sync
Date: Tue, 09 Apr 2019 23:52:15 +0000
Message-ID: <bug-203241-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1hE0XQ-00034j-3x
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Apr 2019 23:52:24 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hE0XO-00ClEx-Gm
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Apr 2019 23:52:23 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id D5EBD289B4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  9 Apr 2019 23:52:16 +0000 (UTC)
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

https://bugzilla.kernel.org/show_bug.cgi?id=203241

            Bug ID: 203241
           Summary: kernel BUG at fs/f2fs/segment.c:3222! and hangs on
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

Created attachment 282251
  --> https://bugzilla.kernel.org/attachment.cgi?id=282251&action=edit
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

- Kernel Messages
[   35.663703] F2FS-fs (sdb): Can't find valid F2FS filesystem in 2th
superblock
[   35.675530] kernel BUG at fs/f2fs/segment.c:3222!
[   35.676360] invalid opcode: 0000 [#1] SMP PTI
[   35.676946] CPU: 0 PID: 1905 Comm: mount Not tainted 5.0.0 #5
[   35.677703] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   35.678962] RIP: 0010:f2fs_do_replace_block+0x432/0x4e0
[   35.679652] Code: ba 01 00 00 00 44 89 e6 4c 89 f7 e8 a8 c5 ff ff e9 10 fd
ff ff 49 8b 46 10 8b 40 48 e9 76 fe ff ff 49 8b 46 10 e9 c1 fc ff ff <0f> 0b 49
8b 56 10 8b 52 48 e9 9b fd ff ff 49 8b 46 10 8b 40 48 e9
[   35.682147] RSP: 0018:ffffa8de80cfba88 EFLAGS: 00010202
[   35.682836] RAX: ffff9c11abeaa880 RBX: 0000000000000003 RCX:
0000000000000009
[   35.683780] RDX: 0000000000000000 RSI: 0000000000001000 RDI:
ffff9c11abb58c20
[   35.684717] RBP: ffff9c11b3012800 R08: ffff9c11abb58c00 R09:
0000000000000000
[   35.685659] R10: 0000000000000009 R11: fffffa1340000000 R12:
0000000000001000
[   35.686590] R13: 0000000000000000 R14: ffff9c11b3010000 R15:
ffff9c11abb583c0
[   35.687530] FS:  00007fd333db1840(0000) GS:ffff9c11b7a00000(0000)
knlGS:0000000000000000
[   35.688625] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   35.689424] CR2: 00007ffffc4fbf38 CR3: 000000022bb1c006 CR4:
00000000001606f0
[   35.690365] Call Trace:
[   35.690694]  f2fs_replace_block+0x45/0x70
[   35.691224]  recover_data+0xaf3/0x1780
[   35.691725]  f2fs_recover_fsync_data+0x613/0x710
[   35.692354]  ? proc_create_single_data+0x37/0x50
[   35.692974]  f2fs_fill_super+0x1043/0x1aa0
[   35.693525]  ? f2fs_commit_super+0x180/0x180
[   35.694094]  mount_bdev+0x16d/0x1a0
[   35.694564]  mount_fs+0x4a/0x170
[   35.695002]  vfs_kern_mount+0x5d/0x100
[   35.695522]  do_mount+0x200/0xcf0
[   35.695972]  ? memdup_user+0x39/0x60
[   35.696459]  ksys_mount+0x79/0xc0
[   35.696921]  __x64_sys_mount+0x1c/0x20
[   35.697448]  do_syscall_64+0x43/0xf0
[   35.697927]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   35.698592] RIP: 0033:0x7fd333690b9a
[   35.699087] Code: 48 8b 0d 01 c3 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e
0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d ce c2 2b 00 f7 d8 64 89 01 48
[   35.701525] RSP: 002b:00007ffffc4fd838 EFLAGS: 00000202 ORIG_RAX:
00000000000000a5
[   35.702524] RAX: ffffffffffffffda RBX: 0000000001144050 RCX:
00007fd333690b9a
[   35.703483] RDX: 0000000001144230 RSI: 0000000001144f20 RDI:
0000000001144250
[   35.704477] RBP: 0000000000000000 R08: 0000000000000000 R09:
0000000000000013
[   35.705410] R10: 00000000c0ed0000 R11: 0000000000000202 R12:
0000000001144250
[   35.706362] R13: 0000000001144230 R14: 0000000000000000 R15:
0000000000000003
[   35.707307] Modules linked in:
[   35.707728] ---[ end trace 4f87466a0fe9a69b ]---
[   35.708357] RIP: 0010:f2fs_do_replace_block+0x432/0x4e0
[   35.709048] Code: ba 01 00 00 00 44 89 e6 4c 89 f7 e8 a8 c5 ff ff e9 10 fd
ff ff 49 8b 46 10 8b 40 48 e9 76 fe ff ff 49 8b 46 10 e9 c1 fc ff ff <0f> 0b 49
8b 56 10 8b 52 48 e9 9b fd ff ff 49 8b 46 10 8b 40 48 e9
[   35.711516] RSP: 0018:ffffa8de80cfba88 EFLAGS: 00010202
[   35.712224] RAX: ffff9c11abeaa880 RBX: 0000000000000003 RCX:
0000000000000009
[   35.713210] RDX: 0000000000000000 RSI: 0000000000001000 RDI:
ffff9c11abb58c20
[   35.714148] RBP: ffff9c11b3012800 R08: ffff9c11abb58c00 R09:
0000000000000000
[   35.715082] R10: 0000000000000009 R11: fffffa1340000000 R12:
0000000000001000
[   35.716029] R13: 0000000000000000 R14: ffff9c11b3010000 R15:
ffff9c11abb583c0
[   35.716969] FS:  00007fd333db1840(0000) GS:ffff9c11b7a00000(0000)
knlGS:0000000000000000
[   35.718028] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   35.718808] CR2: 00007ffffc4fbf38 CR3: 000000022bb1c006 CR4:
00000000001606f0
[   35.720470] mount (1905) used greatest stack depth: 13176 bytes left

- Error location
3187 void f2fs_do_replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary
*sum,
3188                 block_t old_blkaddr, block_t new_blkaddr,
3189                 bool recover_curseg, bool recover_newaddr)
3190 {
3191     struct sit_info *sit_i = SIT_I(sbi);
3192     struct curseg_info *curseg;
3193     unsigned int segno, old_cursegno;
3194     struct seg_entry *se;
3195     int type;
3196     unsigned short old_blkoff;
3197 
3198     segno = GET_SEGNO(sbi, new_blkaddr);
3199     se = get_seg_entry(sbi, segno);
3200     type = se->type;
3201 
3202     down_write(&SM_I(sbi)->curseg_lock);
3203 
3204     if (!recover_curseg) {
3205         /* for recovery flow */
3206         if (se->valid_blocks == 0 && !IS_CURSEG(sbi, segno)) {
3207             if (old_blkaddr == NULL_ADDR)
3208                 type = CURSEG_COLD_DATA;
3209             else
3210                 type = CURSEG_WARM_DATA;
3211         }
3212     } else {
3213         if (IS_CURSEG(sbi, segno)) {
3214             /* se->type is volatile as SSR allocation */
3215             type = __f2fs_get_curseg(sbi, segno);
3216             f2fs_bug_on(sbi, type == NO_CHECK_TYPE);
3217         } else {
3218             type = CURSEG_WARM_DATA;
3219         }
3220     }
3221 
*3222     f2fs_bug_on(sbi, !IS_DATASEG(type));
3223     curseg = CURSEG_I(sbi, type);

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
