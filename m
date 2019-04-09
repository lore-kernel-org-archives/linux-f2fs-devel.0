From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 203225] New: kernel BUG at fs/f2fs/node.c:3073! and
 hangs on sync
Date: Tue, 09 Apr 2019 22:16:09 +0000
Message-ID: <bug-203225-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1hDz2P-0001d1-Bk
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Apr 2019 22:16:17 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hDz2N-00APrU-OQ
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Apr 2019 22:16:17 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 16F622894E
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  9 Apr 2019 22:16:10 +0000 (UTC)
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

https://bugzilla.kernel.org/show_bug.cgi?id=203225

            Bug ID: 203225
           Summary: kernel BUG at fs/f2fs/node.c:3073! and hangs on sync
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

Created attachment 282227
  --> https://bugzilla.kernel.org/attachment.cgi?id=282227&action=edit
The (compressed) crafted image which causes crash

- Overview
When mounting the attached crafted image and unmounting it, following errors
are reported.
Additionally, it hangs on sync after unmounting.

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
touch test/t
umount test
sync

- Messages
[   53.602713] kernel BUG at fs/f2fs/node.c:3073!
[   53.603349] invalid opcode: 0000 [#1] SMP PTI
[   53.603958] CPU: 0 PID: 1892 Comm: umount Not tainted 5.0.0 #5
[   53.604746] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   53.606021] RIP: 0010:f2fs_destroy_node_manager+0x2f0/0x300
[   53.606749] Code: 3d 65 d9 7e 01 e8 10 a0 e7 ff 4d 39 f4 74 98 49 8b 46 08
49 83 c6 08 48 8b 50 10 48 8d 48 10 48 39 d1 74 cc 0f 0b 0f 0b 0f 0b <0f> 0b 0f
0b e8 17 b0 d2 ff 0f 1f 80 00 00 00 00 48 8b 3d 21 d9 7e
[   53.609203] RSP: 0018:ffffa31ac0d13aa8 EFLAGS: 00010202
[   53.609920] RAX: ffff8e682bccd898 RBX: ffff8e682bccd800 RCX:
0000000000000001
[   53.610858] RDX: 0000000000000001 RSI: 0000000000000000 RDI:
ffff8e682bccd8b0
[   53.611807] RBP: ffff8e682bccd898 R08: ffff8e682ebb4f00 R09:
ffffffffb5b34384
[   53.612762] R10: ffffd85948bacac0 R11: ffff8e6836298200 R12:
ffff8e682bccd898
[   53.613696] R13: ffff8e682bccd898 R14: ffff8e682bccd8b0 R15:
0000000000000000
[   53.614625] FS:  00007f85aae88840(0000) GS:ffff8e6837a00000(0000)
knlGS:0000000000000000
[   53.615754] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   53.616574] CR2: 00000000025da108 CR3: 00000002361b8004 CR4:
00000000001606f0
[   53.617522] Call Trace:
[   53.617867]  ? __switch_to_asm+0x40/0x70
[   53.618386]  ? xas_store+0x33b/0x530
[   53.618868]  ? xas_load+0x9/0x50
[   53.619297]  ? xas_find+0x14d/0x190
[   53.619781]  ? find_get_entries+0x92/0x250
[   53.620350]  ? pagevec_lookup_entries+0x15/0x20
[   53.620943]  ? truncate_inode_pages_range+0x323/0x7b0
[   53.621612]  ? fsnotify_grab_connector+0x37/0x60
[   53.622223]  f2fs_put_super+0xf4/0x270
[   53.622719]  generic_shutdown_super+0x62/0x110
[   53.623302]  kill_block_super+0x1c/0x50
[   53.623834]  kill_f2fs_super+0xad/0xd0
[   53.624354]  ? _cond_resched+0x11/0x40
[   53.624861]  deactivate_locked_super+0x35/0x60
[   53.625496]  cleanup_mnt+0x36/0x70
[   53.625957]  task_work_run+0x75/0x90
[   53.626416]  exit_to_usermode_loop+0x93/0xa0
[   53.626958]  do_syscall_64+0xba/0xf0
[   53.627439]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   53.628151] RIP: 0033:0x7f85aa767487
[   53.628706] Code: 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d e1 c9 2b 00 f7 d8 64 89 01 48
[   53.631278] RSP: 002b:00007ffc9d6b00b8 EFLAGS: 00000246 ORIG_RAX:
00000000000000a6
[   53.632339] RAX: 0000000000000000 RBX: 00000000025d3050 RCX:
00007f85aa767487
[   53.633300] RDX: 0000000000000001 RSI: 0000000000000000 RDI:
00000000025d7d70
[   53.634260] RBP: 00000000025d7d70 R08: 0000000000000000 R09:
0000000000000014
[   53.635222] R10: 00000000000006b2 R11: 0000000000000246 R12:
00007f85aac7083c
[   53.636213] R13: 0000000000000000 R14: 00000000025d3230 R15:
00007ffc9d6b0340
[   53.637155] Modules linked in:
[   53.637570] ---[ end trace 970faca020014925 ]---
[   53.638184] RIP: 0010:f2fs_destroy_node_manager+0x2f0/0x300
[   53.638939] Code: 3d 65 d9 7e 01 e8 10 a0 e7 ff 4d 39 f4 74 98 49 8b 46 08
49 83 c6 08 48 8b 50 10 48 8d 48 10 48 39 d1 74 cc 0f 0b 0f 0b 0f 0b <0f> 0b 0f
0b e8 17 b0 d2 ff 0f 1f 80 00 00 00 00 48 8b 3d 21 d9 7e
[   53.641422] RSP: 0018:ffffa31ac0d13aa8 EFLAGS: 00010202
[   53.642110] RAX: ffff8e682bccd898 RBX: ffff8e682bccd800 RCX:
0000000000000001
[   53.643064] RDX: 0000000000000001 RSI: 0000000000000000 RDI:
ffff8e682bccd8b0
[   53.644065] RBP: ffff8e682bccd898 R08: ffff8e682ebb4f00 R09:
ffffffffb5b34384
[   53.645013] R10: ffffd85948bacac0 R11: ffff8e6836298200 R12:
ffff8e682bccd898
[   53.645984] R13: ffff8e682bccd898 R14: ffff8e682bccd8b0 R15:
0000000000000000
[   53.646920] FS:  00007f85aae88840(0000) GS:ffff8e6837a00000(0000)
knlGS:0000000000000000
[   53.648013] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   53.648808] CR2: 00000000025da108 CR3: 00000002361b8004 CR4:
00000000001606f0
[   53.650487] umount (1892) used greatest stack depth: 13208 bytes left

- Error location
3052 void f2fs_destroy_node_manager(struct f2fs_sb_info *sbi)
3053 {
3054     struct f2fs_nm_info *nm_i = NM_I(sbi);
3055     struct free_nid *i, *next_i;
3056     struct nat_entry *natvec[NATVEC_SIZE];
3057     struct nat_entry_set *setvec[SETVEC_SIZE];
3058     nid_t nid = 0;
3059     unsigned int found;
3060 
3061     if (!nm_i)
3062         return;
3063 
3064     /* destroy free nid list */
3065     spin_lock(&nm_i->nid_list_lock);
3066     list_for_each_entry_safe(i, next_i, &nm_i->free_nid_list, list) {
3067         __remove_free_nid(sbi, i, FREE_NID);
3068         spin_unlock(&nm_i->nid_list_lock);
3069         kmem_cache_free(free_nid_slab, i);
3070         spin_lock(&nm_i->nid_list_lock);
3071     }
3072     f2fs_bug_on(sbi, nm_i->nid_cnt[FREE_NID]);
*3073     f2fs_bug_on(sbi, nm_i->nid_cnt[PREALLOC_NID]);
3074     f2fs_bug_on(sbi, !list_empty(&nm_i->free_nid_list));
3075     spin_unlock(&nm_i->nid_list_lock);
3076

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
