From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 203219] New: kernel BUG at fs/f2fs/node.c:1183! and
 hangs on sync
Date: Tue, 09 Apr 2019 21:10:41 +0000
Message-ID: <bug-203219-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1hDy13-0007Kp-Oj
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Apr 2019 21:10:49 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hDy12-00CW6f-5I
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Apr 2019 21:10:49 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 8610028950
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  9 Apr 2019 21:10:42 +0000 (UTC)
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

https://bugzilla.kernel.org/show_bug.cgi?id=203219

            Bug ID: 203219
           Summary: kernel BUG at fs/f2fs/node.c:1183! and hangs on sync
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

Created attachment 282215
  --> https://bugzilla.kernel.org/attachment.cgi?id=282215&action=edit
The (compressed) crafted image which causes crash

- Overview
When mounting the attached crafted image and running program, I got this error.
Additionally, it hangs on sync after running the program.

The image is intentionally fuzzed from a normal f2fs image for testing and I
enabled option CONFIG_F2FS_CHECK_FS on.

- Reproduces
cc poc_06.c
mkdir test
mount -t f2fs tmp.img test
cp a.out test
cd test
sudo ./a.out
sync

- Messages
[   54.959546] kernel BUG at fs/f2fs/node.c:1183!
[   54.960445] invalid opcode: 0000 [#1] SMP PTI
[   54.961320] CPU: 0 PID: 1905 Comm: a.out Not tainted 5.0.0 #4
[   54.962460] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   54.964292] RIP: 0010:f2fs_remove_inode_page+0x294/0x2d0
[   54.965300] Code: 48 85 ff 74 1b 48 3b 7c 24 18 74 14 48 8b 47 08 48 8d 50
ff a8 01 48 0f 45 fa 3e ff 4f 34 74 21 b8 fb ff ff ff e9 cb fd ff ff <0f> 0b 48
89 df 89 44 24 04 e8 3e f3 e2 ff 8b 44 24 04 e9 1e ff ff
[   54.968963] RSP: 0018:ffff9aa700d0bd70 EFLAGS: 00010202
[   54.969971] RAX: ffff8b3c7f891000 RBX: ffff8b3c6cfdd980 RCX:
ffff8b3c6cfdd980
[   54.971366] RDX: 0000000000000000 RSI: ffff8b3c7e1f4168 RDI:
ffff9aa700d0bd78
[   54.972799] RBP: 0000000000000000 R08: 0000000000000006 R09:
ffff8b3c7e1f416c
[   54.974201] R10: 0000000000000000 R11: ffff8b3c7e9c2ab0 R12:
ffff8b3c7e9c2800
[   54.975630] R13: 0000000000000000 R14: ffff8b3c7e9c2908 R15:
00007ffe06227910
[   54.977004] FS:  00007f71f6034700(0000) GS:ffff8b3c7fc00000(0000)
knlGS:0000000000000000
[   54.978570] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   54.979711] CR2: 00007f71f5b4f4c0 CR3: 0000000231524006 CR4:
00000000001606f0
[   54.981085] Call Trace:
[   54.981582]  f2fs_evict_inode+0x2a3/0x3a0
[   54.982443]  evict+0xba/0x180
[   54.983075]  __dentry_kill+0xbe/0x160
[   54.983792]  dentry_kill+0x46/0x180
[   54.984477]  dput+0xbb/0x100
[   54.985050]  do_renameat2+0x3c9/0x550
[   54.985765]  __x64_sys_rename+0x17/0x20
[   54.986535]  do_syscall_64+0x43/0xf0
[   54.987250]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   54.988230] RIP: 0033:0x7f71f5b4f4d9
[   54.988927] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d 8f 29 2c 00 f7 d8 64 89 01 48
[   54.992536] RSP: 002b:00007ffe06227868 EFLAGS: 00000217 ORIG_RAX:
0000000000000052
[   54.994008] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f71f5b4f4d9
[   54.995460] RDX: 00007f71f5b4f4d9 RSI: 00007ffe062278d0 RDI:
00007ffe06227910
[   54.996846] RBP: 00007ffe0622b950 R08: 00007ffe0622ba38 R09:
00007ffe0622ba38
[   54.998198] R10: 00007ffe0622ba38 R11: 0000000000000217 R12:
00000000004004e0
[   54.999652] R13: 00007ffe0622ba30 R14: 0000000000000000 R15:
0000000000000000
[   55.001040] Modules linked in:
[   55.001667] ---[ end trace 179922f700648628 ]---
[   55.002616] RIP: 0010:f2fs_remove_inode_page+0x294/0x2d0
[   55.003667] Code: 48 85 ff 74 1b 48 3b 7c 24 18 74 14 48 8b 47 08 48 8d 50
ff a8 01 48 0f 45 fa 3e ff 4f 34 74 21 b8 fb ff ff ff e9 cb fd ff ff <0f> 0b 48
89 df 89 44 24 04 e8 3e f3 e2 ff 8b 44 24 04 e9 1e ff ff
[   55.007226] RSP: 0018:ffff9aa700d0bd70 EFLAGS: 00010202
[   55.008243] RAX: ffff8b3c7f891000 RBX: ffff8b3c6cfdd980 RCX:
ffff8b3c6cfdd980
[   55.009633] RDX: 0000000000000000 RSI: ffff8b3c7e1f4168 RDI:
ffff9aa700d0bd78
[   55.011027] RBP: 0000000000000000 R08: 0000000000000006 R09:
ffff8b3c7e1f416c
[   55.012403] R10: 0000000000000000 R11: ffff8b3c7e9c2ab0 R12:
ffff8b3c7e9c2800
[   55.013803] R13: 0000000000000000 R14: ffff8b3c7e9c2908 R15:
00007ffe06227910
[   55.015249] FS:  00007f71f6034700(0000) GS:ffff8b3c7fc00000(0000)
knlGS:0000000000000000
[   55.016790] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   55.017892] CR2: 00007f71f5b4f4c0 CR3: 0000000231524006 CR4:
00000000001606f0

- Error location
1156 int f2fs_remove_inode_page(struct inode *inode)
1157 {
1158     struct dnode_of_data dn;
1159     int err;
1160 
1161     set_new_dnode(&dn, inode, NULL, NULL, inode->i_ino);
1162     err = f2fs_get_dnode_of_data(&dn, 0, LOOKUP_NODE);
1163     if (err)
1164         return err;
1165 
1166     err = f2fs_truncate_xattr_node(inode);
1167     if (err) {
1168         f2fs_put_dnode(&dn);
1169         return err;
1170     }
1171 
1172     /* remove potential inline_data blocks */
1173     if (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
1174                 S_ISLNK(inode->i_mode))
1175         f2fs_truncate_data_blocks_range(&dn, 1);
1176 
1177     /* 0 is possible, after f2fs_new_inode() has failed */
1178     if (unlikely(f2fs_cp_error(F2FS_I_SB(inode)))) {
1179         f2fs_put_dnode(&dn);
1180         return -EIO;
1181     }
1182     f2fs_bug_on(F2FS_I_SB(inode),
*1183             inode->i_blocks != 0 && inode->i_blocks != 8);
1184 
1185     /* will put inode & node pages */
1186     err = truncate_node(&dn);
1187     if (err) {
1188         f2fs_put_dnode(&dn);
1189         return err;
1190     }
1191     return 0;
1192 }

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
