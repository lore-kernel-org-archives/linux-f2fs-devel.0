From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 203235] New: kernel BUG at fs/f2fs/segment.c:2131!
 and hangs on sync
Date: Tue, 09 Apr 2019 23:32:33 +0000
Message-ID: <bug-203235-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1hE0EN-0002Gl-2R
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Apr 2019 23:32:43 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hE0EL-00CjI4-G7
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Apr 2019 23:32:42 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 2FBD3288AA
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  9 Apr 2019 23:32:34 +0000 (UTC)
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

https://bugzilla.kernel.org/show_bug.cgi?id=203235

            Bug ID: 203235
           Summary: kernel BUG at fs/f2fs/segment.c:2131! and hangs on
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

Created attachment 282241
  --> https://bugzilla.kernel.org/attachment.cgi?id=282241&action=edit
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
cc poc_14.c
mkdir test
mount -t f2fs tmp.img test
cp a.out test
cd test
sudo ./a.out
sync

- Kernel messages
[  850.579251] cc1 (1895) used greatest stack depth: 13240 bytes left
[  855.736545] F2FS-fs (sdb): Mounted with checkpoint version = 7548c2d6
[  868.482066] F2FS-fs (sdb): Bitmap was wrongly cleared, blk:5632
[  868.482913] ------------[ cut here ]------------
[  868.482914] kernel BUG at fs/f2fs/segment.c:2131!
[  868.483556] invalid opcode: 0000 [#1] SMP PTI
[  868.484138] CPU: 0 PID: 1912 Comm: a.out Not tainted 5.0.0 #5
[  868.484911] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[  868.486155] RIP: 0010:update_sit_entry+0x3ec/0x410
[  868.486788] Code: a8 57 c1 84 48 c7 c6 7b 8a be 84 e8 be 00 fe ff 0f 0b 48
8b 3b 89 e9 48 c7 c2 b0 81 c1 84 48 c7 c6 7b 8a be 84 e8 a4 00 fe ff <0f> 0b 49
8b 75 18 0f be 34 16 85 c6 0f 84 ed fe ff ff 83 83 10 04
[  868.489231] RSP: 0018:ffffbaae80cff830 EFLAGS: 00010286
[  868.489918] RAX: 0000000000000000 RBX: ffff98d875289800 RCX:
0000000000000000
[  868.490847] RDX: 0000000000000000 RSI: ffff98d877a15418 RDI:
ffff98d877a15418
[  868.491777] RBP: 0000000000001600 R08: 0000000000075b12 R09:
0000000000000005
[  868.492722] R10: 0000000000000060 R11: ffffbaae80cff675 R12:
00000000ffffffff
[  868.493657] R13: ffff98d87528a090 R14: 0000000000000003 R15:
0000000000000000
[  868.494605] FS:  00007f8c6c855700(0000) GS:ffff98d877a00000(0000)
knlGS:0000000000000000
[  868.495660] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  868.496430] CR2: 00007ffd4ce81ee0 CR3: 0000000232d44004 CR4:
00000000001606f0
[  868.497369] Call Trace:
[  868.497713]  f2fs_allocate_data_block+0x399/0x660
[  868.498333]  do_write_page+0x62/0x170
[  868.498804]  f2fs_outplace_write_data+0x4d/0xd0
[  868.499400]  f2fs_do_write_data_page+0x5a8/0x820
[  868.500011]  __write_data_page+0x63f/0x720
[  868.500559]  f2fs_write_cache_pages+0x20d/0x460
[  868.501179]  ? _cond_resched+0x11/0x40
[  868.501677]  ? unmap_page_range+0x7e0/0x890
[  868.502234]  f2fs_write_data_pages+0x1b4/0x300
[  868.502843]  ? do_writepages+0x15/0x60
[  868.503342]  do_writepages+0x15/0x60
[  868.503825]  __filemap_fdatawrite_range+0x7c/0xb0
[  868.504467]  f2fs_sync_dirty_inodes+0x6b/0x210
[  868.505063]  f2fs_write_checkpoint+0x1c1/0x1400
[  868.505675]  ? xa_load+0x54/0xa0
[  868.506107]  ? blk_finish_plug+0x22/0x30
[  868.506632]  ? f2fs_fill_dentries+0x19d/0x1d0
[  868.507226]  ? f2fs_sync_fs+0xa3/0x130
[  868.507723]  f2fs_sync_fs+0xa3/0x130
[  868.508202]  ? touch_atime+0x2f/0xd0
[  868.508710]  f2fs_do_sync_file+0x1a6/0x810
[  868.509284]  do_fsync+0x33/0x60
[  868.509725]  __x64_sys_fsync+0xb/0x10
[  868.510217]  do_syscall_64+0x43/0xf0
[  868.510705]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  868.511381] RIP: 0033:0x7f8c6c3704d9
[  868.511856] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d 8f 29 2c 00 f7 d8 64 89 01 48
[  868.514305] RSP: 002b:00007ffd4ce82088 EFLAGS: 00000213 ORIG_RAX:
000000000000004a
[  868.515289] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f8c6c3704d9
[  868.516240] RDX: 00007f8c6c3704d9 RSI: 0000000000000928 RDI:
0000000000000003
[  868.517192] RBP: 00007ffd4ce861a0 R08: 00007ffd4ce86288 R09:
00007ffd4ce86288
[  868.518121] R10: 00007ffd4ce86288 R11: 0000000000000213 R12:
00000000004004e0
[  868.519051] R13: 00007ffd4ce86280 R14: 0000000000000000 R15:
0000000000000000
[  868.520001] Modules linked in:
[  868.520419] ---[ end trace 6c7a2100f47b16d0 ]---
[  868.521027] RIP: 0010:update_sit_entry+0x3ec/0x410
[  868.521680] Code: a8 57 c1 84 48 c7 c6 7b 8a be 84 e8 be 00 fe ff 0f 0b 48
8b 3b 89 e9 48 c7 c2 b0 81 c1 84 48 c7 c6 7b 8a be 84 e8 a4 00 fe ff <0f> 0b 49
8b 75 18 0f be 34 16 85 c6 0f 84 ed fe ff ff 83 83 10 04
[  868.524130] RSP: 0018:ffffbaae80cff830 EFLAGS: 00010286
[  868.524829] RAX: 0000000000000000 RBX: ffff98d875289800 RCX:
0000000000000000
[  868.525781] RDX: 0000000000000000 RSI: ffff98d877a15418 RDI:
ffff98d877a15418
[  868.526741] RBP: 0000000000001600 R08: 0000000000075b12 R09:
0000000000000005
[  868.527686] R10: 0000000000000060 R11: ffffbaae80cff675 R12:
00000000ffffffff
[  868.528629] R13: ffff98d87528a090 R14: 0000000000000003 R15:
0000000000000000
[  868.529597] FS:  00007f8c6c855700(0000) GS:ffff98d877a00000(0000)
knlGS:0000000000000000
[  868.530660] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  868.531425] CR2: 00007ffd4ce81ee0 CR3: 0000000232d44004 CR4:
00000000001606f0
[  868.533179] a.out (1912) used greatest stack depth: 12584 bytes left

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
...
2116     } else {
2117         exist = f2fs_test_and_clear_bit(offset, se->cur_valid_map);
2118 #ifdef CONFIG_F2FS_CHECK_FS
2119         mir_exist = f2fs_test_and_clear_bit(offset,
2120                         se->cur_valid_map_mir);
2121         if (unlikely(exist != mir_exist)) {
2122             f2fs_msg(sbi->sb, KERN_ERR, "Inconsistent error "
2123                 "when clearing bitmap, blk:%u, old bit:%d",
2124                 blkaddr, exist);
2125             f2fs_bug_on(sbi, 1);
2126         }
2127 #endif
2128         if (unlikely(!exist)) {
2129             f2fs_msg(sbi->sb, KERN_ERR,
2130                 "Bitmap was wrongly cleared, blk:%u", blkaddr);
*2131             f2fs_bug_on(sbi, 1);
2132             se->valid_blocks++;
2133             del = 0;

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
