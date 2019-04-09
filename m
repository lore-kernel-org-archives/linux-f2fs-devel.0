From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 203239] New: kernel BUG at fs/f2fs/segment.c:3162!
 and hangs on sync
Date: Tue, 09 Apr 2019 23:45:02 +0000
Message-ID: <bug-203239-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1hE0QQ-0002mq-37
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Apr 2019 23:45:10 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hE0QO-00AYuK-H1
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Apr 2019 23:45:09 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id E12DD201BD
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  9 Apr 2019 23:45:02 +0000 (UTC)
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

https://bugzilla.kernel.org/show_bug.cgi?id=203239

            Bug ID: 203239
           Summary: kernel BUG at fs/f2fs/segment.c:3162! and hangs on
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

Created attachment 282245
  --> https://bugzilla.kernel.org/attachment.cgi?id=282245&action=edit
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
cc poc_15.c
./run.sh f2fs
sync

- Kernel messages
[   30.905142] F2FS-fs (sdb): Mounted with checkpoint version = 7548c2d6
[   30.930564] ------------[ cut here ]------------
[   30.930566] kernel BUG at fs/f2fs/segment.c:3162!
[   30.931418] invalid opcode: 0000 [#1] SMP PTI
[   30.932183] CPU: 0 PID: 1897 Comm: a.out Not tainted 5.0.0 #5
[   30.933246] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   30.934817] RIP: 0010:f2fs_inplace_write_data+0x12d/0x160
[   30.935719] Code: 95 f8 05 00 00 c6 85 ec 05 00 00 00 48 83 c4 08 5b 5d 41
5c c3 48 89 df 89 44 24 04 e8 9c 9f ff ff 8b 44 24 04 e9 3c ff ff ff <0f> 0b 48
8b 4d 10 8b 49 48 e9 71 ff ff ff 48 8b 7d 00 41 b8 06 00
[   30.938891] RSP: 0018:ffffa9b040d1faf0 EFLAGS: 00010206
[   30.939804] RAX: 0000000000000005 RBX: ffffa9b040d1fbc8 RCX:
ffff9febb6557600
[   30.941077] RDX: ffff9febb2d4b800 RSI: 0000000000001404 RDI:
ffff9febb2d49000
[   30.942282] RBP: ffff9febb2d49000 R08: ffff9febab4e6780 R09:
0000000000024e00
[   30.943480] R10: 0000000000000002 R11: ffff9febbfffa000 R12:
0000000000001404
[   30.944686] R13: ffff9febaebcd980 R14: 0000000000000001 R15:
ffff9febb2d49000
[   30.945861] FS:  00007f429d414700(0000) GS:ffff9febb7a00000(0000)
knlGS:0000000000000000
[   30.947227] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   30.948189] CR2: 00007f429cf2f4c0 CR3: 00000002308ba006 CR4:
00000000001606f0
[   30.949380] Call Trace:
[   30.949878]  f2fs_do_write_data_page+0x3c1/0x820
[   30.950678]  __write_data_page+0x156/0x720
[   30.951393]  f2fs_write_cache_pages+0x20d/0x460
[   30.952201]  ? current_time+0x42/0x80
[   30.952856]  ? f2fs_inode_dirtied+0xc0/0xc0
[   30.953584]  ? __mark_inode_dirty+0x153/0x380
[   30.954349]  ? generic_update_time+0xaf/0xc0
[   30.955099]  ? touch_atime+0xc1/0xd0
[   30.955739]  f2fs_write_data_pages+0x1b4/0x300
[   30.956547]  ? do_writepages+0x15/0x60
[   30.957218]  do_writepages+0x15/0x60
[   30.957875]  __filemap_fdatawrite_range+0x7c/0xb0
[   30.958706]  file_write_and_wait_range+0x2c/0x80
[   30.959535]  f2fs_do_sync_file+0x102/0x810
[   30.960341]  do_fsync+0x33/0x60
[   30.960886]  __x64_sys_fsync+0xb/0x10
[   30.961502]  do_syscall_64+0x43/0xf0
[   30.962134]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   30.962989] RIP: 0033:0x7f429cf2f4d9
[   30.963605] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d 8f 29 2c 00 f7 d8 64 89 01 48
[   30.966857] RSP: 002b:00007ffda32ae858 EFLAGS: 00000203 ORIG_RAX:
000000000000004a
[   30.968148] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f429cf2f4d9
[   30.969449] RDX: 00007f429cf2f4d9 RSI: 0000000000001864 RDI:
0000000000000003
[   30.970635] RBP: 00007ffda32b29d0 R08: 00007ffda32b2ab8 R09:
00007ffda32b2ab8
[   30.971837] R10: 00007ffda32b2ab8 R11: 0000000000000203 R12:
00000000004004e0
[   30.973087] R13: 00007ffda32b2ab0 R14: 0000000000000000 R15:
0000000000000000
[   30.974322] Modules linked in:
[   30.974862] ---[ end trace 0feb3d7e0f77ccd7 ]---
[   30.975691] RIP: 0010:f2fs_inplace_write_data+0x12d/0x160
[   30.976645] Code: 95 f8 05 00 00 c6 85 ec 05 00 00 00 48 83 c4 08 5b 5d 41
5c c3 48 89 df 89 44 24 04 e8 9c 9f ff ff 8b 44 24 04 e9 3c ff ff ff <0f> 0b 48
8b 4d 10 8b 49 48 e9 71 ff ff ff 48 8b 7d 00 41 b8 06 00
[   30.979837] RSP: 0018:ffffa9b040d1faf0 EFLAGS: 00010206
[   30.980770] RAX: 0000000000000005 RBX: ffffa9b040d1fbc8 RCX:
ffff9febb6557600
[   30.981971] RDX: ffff9febb2d4b800 RSI: 0000000000001404 RDI:
ffff9febb2d49000
[   30.983226] RBP: ffff9febb2d49000 R08: ffff9febab4e6780 R09:
0000000000024e00
[   30.984466] R10: 0000000000000002 R11: ffff9febbfffa000 R12:
0000000000001404
[   30.985681] R13: ffff9febaebcd980 R14: 0000000000000001 R15:
ffff9febb2d49000
[   30.986937] FS:  00007f429d414700(0000) GS:ffff9febb7a00000(0000)
knlGS:0000000000000000
[   30.988412] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   30.989373] CR2: 00007f429cf2f4c0 CR3: 00000002308ba006 CR4:
00000000001606f0

- Error location
3152 int f2fs_inplace_write_data(struct f2fs_io_info *fio)
3153 {
3154     int err;
3155     struct f2fs_sb_info *sbi = fio->sbi;
3156 
3157     fio->new_blkaddr = fio->old_blkaddr;
3158     /* i/o temperature is needed for passing down write hints */
3159     __get_segment_type(fio);
3160 
3161     f2fs_bug_on(sbi, !IS_DATASEG(get_seg_entry(sbi,
*3162             GET_SEGNO(sbi, fio->new_blkaddr))->type));
3163 
3164     stat_inc_inplace_blocks(fio->sbi);
3165 
3166     err = f2fs_submit_page_bio(fio);
3167     if (!err)
3168         update_device_state(fio);
3169 
3170     f2fs_update_iostat(fio->sbi, fio->io_type, F2FS_BLKSIZE);
3171 
3172     return err;
3173 }

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
