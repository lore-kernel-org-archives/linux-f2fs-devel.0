From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 203217] New: kernel BUG at fs/f2fs/inode.c:707! and
 hangs
Date: Tue, 09 Apr 2019 21:02:38 +0000
Message-ID: <bug-203217-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1hDxtG-0001FC-2K
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Apr 2019 21:02:46 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hDxtE-00AIy3-Go
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Apr 2019 21:02:45 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id E3D62289D2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  9 Apr 2019 21:02:38 +0000 (UTC)
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

https://bugzilla.kernel.org/show_bug.cgi?id=203217

            Bug ID: 203217
           Summary: kernel BUG at fs/f2fs/inode.c:707! and hangs
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

Created attachment 282211
  --> https://bugzilla.kernel.org/attachment.cgi?id=282211&action=edit
The (compressed) crafted image which causes crash

- Overview
When mounting the attached crafted image and running program, I got this error.
Additionally, it hangs on sync after running the program.

The image is intentionally fuzzed from a normal f2fs image for testing and I
enabled option CONFIG_F2FS_CHECK_FS on.

- Reproduces
cc poc_test_05.c
mkdir test
mount -t f2fs tmp.img test
sudo ./a.out
sync

- Messages
[  202.860834] kernel BUG at fs/f2fs/inode.c:707!
[  202.861484] invalid opcode: 0000 [#1] SMP PTI
[  202.862065] CPU: 0 PID: 1932 Comm: a.out Tainted: G        W         5.0.0
#4
[  202.863079] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[  202.864419] RIP: 0010:f2fs_evict_inode+0x33f/0x3a0
[  202.865097] Code: e8 d6 67 e5 ff 8b 43 48 85 c0 0f 84 2b fe ff ff e9 06 fe
ff ff 8b 73 40 ba 02 00 00 00 4c 89 e7 e8 f6 21 01 00 e9 11 fe ff ff <0f> 0b 48
89 df e8 c7 bc 00 00 48 8b 73 40 48 85 f6 0f 84 ca fd ff
[  202.867703] RSP: 0018:ffffb109c0da7b60 EFLAGS: 00010202
[  202.868445] RAX: 0000000000100602 RBX: ffff94a3aebbe640 RCX:
0000000000000000
[  202.869451] RDX: ffff94a3abdbb600 RSI: 0000000000000001 RDI:
ffff94a3aebbe640
[  202.870456] RBP: ffff94a3aebbe748 R08: ffff94a3b4c5d400 R09:
ffffffffb6741f99
[  202.871476] R10: ffffd6d908baf140 R11: ffff94a3abe6a500 R12:
ffff94a3b6325800
[  202.872480] R13: 0000000000000000 R14: 00000000fffffff2 R15:
ffffd6d908d8c1c0
[  202.873482] FS:  00007fe5ac087700(0000) GS:ffff94a3b7a00000(0000)
knlGS:0000000000000000
[  202.874628] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  202.875440] CR2: 00007ffff0c6e000 CR3: 0000000235e56004 CR4:
00000000001606f0
[  202.876453] Call Trace:
[  202.876817]  evict+0xba/0x180
[  202.877257]  f2fs_iget+0x598/0xdf0
[  202.877746]  f2fs_lookup+0x136/0x320
[  202.878260]  __lookup_slow+0x92/0x140
[  202.878803]  lookup_slow+0x30/0x50
[  202.879303]  walk_component+0x1c1/0x350
[  202.879853]  ? f2fs_get_dnode_of_data+0x4f8/0x600
[  202.880509]  ? f2fs_get_node_info+0x17b/0x2e0
[  202.881134]  path_lookupat+0x62/0x200
[  202.881657]  filename_lookup+0xb3/0x1a0
[  202.882205]  ? f2fs_alloc_nid_failed+0x72/0xc0
[  202.882845]  ? _cond_resched+0x11/0x40
[  202.883382]  ? kmem_cache_alloc+0x33/0x160
[  202.883964]  ? getname_flags+0x6a/0x1d0
[  202.884512]  ? do_readlinkat+0x56/0x110
[  202.885057]  do_readlinkat+0x56/0x110
[  202.885581]  ? do_mkdirat+0x80/0xe0
[  202.886081]  __x64_sys_readlink+0x16/0x20
[  202.886671]  do_syscall_64+0x43/0xf0
[  202.887183]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  202.887920] RIP: 0033:0x7fe5abba24d9
[  202.888431] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d 8f 29 2c 00 f7 d8 64 89 01 48
[  202.891059] RSP: 002b:00007ffff0c6bc78 EFLAGS: 00000286 ORIG_RAX:
0000000000000059
[  202.892132] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007fe5abba24d9
[  202.893135] RDX: 0000000000002000 RSI: 00007ffff0c6de20 RDI:
00007ffff0c6bd20
[  202.894132] RBP: 00007ffff0c6fe30 R08: 00007ffff0c6ff18 R09:
00007ffff0c6ff18
[  202.895167] R10: 00007ffff0c6ff18 R11: 0000000000000286 R12:
00000000004004e0
[  202.896181] R13: 00007ffff0c6ff10 R14: 0000000000000000 R15:
0000000000000000
[  202.897204] Modules linked in:
[  202.897682] ---[ end trace 637c750cd5ef0048 ]---
[  202.898354] RIP: 0010:f2fs_evict_inode+0x33f/0x3a0
[  202.899055] Code: e8 d6 67 e5 ff 8b 43 48 85 c0 0f 84 2b fe ff ff e9 06 fe
ff ff 8b 73 40 ba 02 00 00 00 4c 89 e7 e8 f6 21 01 00 e9 11 fe ff ff <0f> 0b 48
89 df e8 c7 bc 00 00 48 8b 73 40 48 85 f6 0f 84 ca fd ff
[  202.901691] RSP: 0018:ffffb109c0da7b60 EFLAGS: 00010202
[  202.902464] RAX: 0000000000100602 RBX: ffff94a3aebbe640 RCX:
0000000000000000
[  202.903480] RDX: ffff94a3abdbb600 RSI: 0000000000000001 RDI:
ffff94a3aebbe640
[  202.904494] RBP: ffff94a3aebbe748 R08: ffff94a3b4c5d400 R09:
ffffffffb6741f99
[  202.905505] R10: ffffd6d908baf140 R11: ffff94a3abe6a500 R12:
ffff94a3b6325800
[  202.906545] R13: 0000000000000000 R14: 00000000fffffff2 R15:
ffffd6d908d8c1c0
[  202.907553] FS:  00007fe5ac087700(0000) GS:ffff94a3b7a00000(0000)
knlGS:0000000000000000
[  202.908709] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  202.909530] CR2: 00007ffff0c6e000 CR3: 0000000235e56004 CR4:
00000000001606f0

-- error location

632 void f2fs_evict_inode(struct inode *inode)
633 {
...
700 
701     stat_dec_inline_xattr(inode);
702     stat_dec_inline_dir(inode);
703     stat_dec_inline_inode(inode);
704 
705     if (likely(!is_set_ckpt_flags(sbi, CP_ERROR_FLAG) &&
706                 !is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
*707         f2fs_bug_on(sbi, is_inode_flag_set(inode, FI_DIRTY_INODE));
708     else
709         f2fs_inode_synced(inode);
710 
711     /* ino == 0, if f2fs_new_inode() was failed t*/
712     if (inode->i_ino)
713         invalidate_mapping_pages(NODE_MAPPING(sbi), inode->i_ino,
714                             inode->i_ino);

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
