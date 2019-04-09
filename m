From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 203227] New: kernel BUG at fs/f2fs/recovery.c:549!
 and hangs on sync
Date: Tue, 09 Apr 2019 22:45:25 +0000
Message-ID: <bug-203227-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1hDzUj-0004WT-AL
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Apr 2019 22:45:33 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hDzUh-00ASlc-Ly
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Apr 2019 22:45:33 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 0EC122896A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  9 Apr 2019 22:45:26 +0000 (UTC)
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

https://bugzilla.kernel.org/show_bug.cgi?id=203227

            Bug ID: 203227
           Summary: kernel BUG at fs/f2fs/recovery.c:549! and hangs on
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

Created attachment 282229
  --> https://bugzilla.kernel.org/attachment.cgi?id=282229&action=edit
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

- Messages
[   38.315948] F2FS-fs (sdb): Can't find valid F2FS filesystem in 2th
superblock
[   38.320145] kernel BUG at fs/f2fs/recovery.c:549!
[   38.320971] invalid opcode: 0000 [#1] SMP PTI
[   38.321556] CPU: 0 PID: 1878 Comm: mount Not tainted 5.0.0 #5
[   38.322349] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   38.323594] RIP: 0010:recover_data+0x167a/0x1780
[   38.324211] Code: 00 00 83 e0 f8 89 8a e8 0f 00 00 89 c1 8b 82 f0 0f 00 00
83 e0 07 09 c8 89 82 f0 0f 00 00 e8 6d ca e1 ff e9 71 fd ff ff 0f 0b <0f> 0b f6
40 03 20 0f 84 d8 fc ff ff 0f b7 88 68 01 00 00 66 c1 e9
[   38.326697] RSP: 0018:ffffbd3fc0cfbb18 EFLAGS: 00010287
[   38.327386] RAX: ffffa211f13f6000 RBX: 00000000129fa2df RCX:
000000001ffca000
[   38.328332] RDX: ffffa211ec3dc000 RSI: ffffa20fc0000000 RDI:
000000000004b01e
[   38.329258] RBP: ffffa211eebe8cc0 R08: ffffa211eebf3298 R09:
0000000000000009
[   38.330220] R10: ffffe6fa88b0f700 R11: ffffe6fa80000000 R12:
00000000000003fa
[   38.331176] R13: ffffa211eea9f0a0 R14: 0000000000000000 R15:
ffffe6fa88c4fd80
[   38.332104] FS:  00007f4acee4e840(0000) GS:ffffa211f7a00000(0000)
knlGS:0000000000000000
[   38.333180] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   38.333996] CR2: 00007ffed1517d3c CR3: 000000022c480004 CR4:
00000000001606f0
[   38.334940] Call Trace:
[   38.335291]  ? mark_page_accessed+0x9c/0x110
[   38.335862]  ? pagecache_get_page+0x177/0x210
[   38.336456]  f2fs_recover_fsync_data+0x613/0x710
[   38.337065]  ? proc_create_single_data+0x37/0x50
[   38.337719]  f2fs_fill_super+0x1043/0x1aa0
[   38.338297]  ? f2fs_commit_super+0x180/0x180
[   38.338862]  mount_bdev+0x16d/0x1a0
[   38.339326]  mount_fs+0x4a/0x170
[   38.339759]  vfs_kern_mount+0x5d/0x100
[   38.340259]  do_mount+0x200/0xcf0
[   38.340711]  ? memdup_user+0x39/0x60
[   38.341208]  ksys_mount+0x79/0xc0
[   38.341670]  __x64_sys_mount+0x1c/0x20
[   38.342184]  do_syscall_64+0x43/0xf0
[   38.342662]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   38.343346] RIP: 0033:0x7f4ace72db9a
[   38.343822] Code: 48 8b 0d 01 c3 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e
0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d ce c2 2b 00 f7 d8 64 89 01 48
[   38.346264] RSP: 002b:00007ffed1519568 EFLAGS: 00000202 ORIG_RAX:
00000000000000a5
[   38.347260] RAX: ffffffffffffffda RBX: 0000000001535050 RCX:
00007f4ace72db9a
[   38.348191] RDX: 0000000001535230 RSI: 0000000001535f20 RDI:
0000000001535250
[   38.349120] RBP: 0000000000000000 R08: 0000000000000000 R09:
0000000000000013
[   38.350066] R10: 00000000c0ed0000 R11: 0000000000000202 R12:
0000000001535250
[   38.350990] R13: 0000000001535230 R14: 0000000000000000 R15:
0000000000000003
[   38.351938] Modules linked in:
[   38.352374] ---[ end trace 763c06721205a251 ]---
[   38.352989] RIP: 0010:recover_data+0x167a/0x1780
[   38.353615] Code: 00 00 83 e0 f8 89 8a e8 0f 00 00 89 c1 8b 82 f0 0f 00 00
83 e0 07 09 c8 89 82 f0 0f 00 00 e8 6d ca e1 ff e9 71 fd ff ff 0f 0b <0f> 0b f6
40 03 20 0f 84 d8 fc ff ff 0f b7 88 68 01 00 00 66 c1 e9
[   38.356070] RSP: 0018:ffffbd3fc0cfbb18 EFLAGS: 00010287
[   38.356763] RAX: ffffa211f13f6000 RBX: 00000000129fa2df RCX:
000000001ffca000
[   38.357746] RDX: ffffa211ec3dc000 RSI: ffffa20fc0000000 RDI:
000000000004b01e
[   38.358706] RBP: ffffa211eebe8cc0 R08: ffffa211eebf3298 R09:
0000000000000009
[   38.359641] R10: ffffe6fa88b0f700 R11: ffffe6fa80000000 R12:
00000000000003fa
[   38.360594] R13: ffffa211eea9f0a0 R14: 0000000000000000 R15:
ffffe6fa88c4fd80
[   38.361570] FS:  00007f4acee4e840(0000) GS:ffffa211f7a00000(0000)
knlGS:0000000000000000
[   38.362633] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   38.363393] CR2: 00007ffed1517d3c CR3: 000000022c480004 CR4:
00000000001606f0
[   38.365045] mount (1878) used greatest stack depth: 13320 bytes left

- Error location
505 static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
506                     struct page *page)
507 {
508     struct dnode_of_data dn;
509     struct node_info ni;
510     unsigned int start, end;
511     int err = 0, recovered = 0;
512 
513     /* step 1: recover xattr */
514     if (IS_INODE(page)) {
515         f2fs_recover_inline_xattr(inode, page);
516     } else if (f2fs_has_xattr_block(ofs_of_node(page))) {
517         err = f2fs_recover_xattr_data(inode, page);
518         if (!err)
519             recovered++;
520         goto out;
521     }
522 
523     /* step 2: recover inline data */
524     if (f2fs_recover_inline_data(inode, page))
525         goto out;
526 
527     /* step 3: recover data indices */
528     start = f2fs_start_bidx_of_node(ofs_of_node(page), inode);
529     end = start + ADDRS_PER_PAGE(page, inode);
530 
531     set_new_dnode(&dn, inode, NULL, NULL, 0);
532 retry_dn:
533     err = f2fs_get_dnode_of_data(&dn, start, ALLOC_NODE);
534     if (err) {
535         if (err == -ENOMEM) {
536             congestion_wait(BLK_RW_ASYNC, HZ/50);
537             goto retry_dn;
538         }
539         goto out;
540     }
541 
542     f2fs_wait_on_page_writeback(dn.node_page, NODE, true, true);
543 
544     err = f2fs_get_node_info(sbi, dn.nid, &ni);
545     if (err)
546         goto err;
547 
548     f2fs_bug_on(sbi, ni.ino != ino_of_node(page));
*549     f2fs_bug_on(sbi, ofs_of_node(dn.node_page) != ofs_of_node(page));
550

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
