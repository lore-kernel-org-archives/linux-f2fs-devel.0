From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 203221] New: kernel BUG at fs/f2fs/node.c:1279!
Date: Tue, 09 Apr 2019 21:29:59 +0000
Message-ID: <bug-203221-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1hDyJj-0005Xl-Eh
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Apr 2019 21:30:07 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hDyJh-00ALWj-UG
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Apr 2019 21:30:07 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 498AE286C4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  9 Apr 2019 21:30:00 +0000 (UTC)
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

https://bugzilla.kernel.org/show_bug.cgi?id=203221

            Bug ID: 203221
           Summary: kernel BUG at fs/f2fs/node.c:1279!
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

Created attachment 282219
  --> https://bugzilla.kernel.org/attachment.cgi?id=282219&action=edit
The (compressed) crafted image which causes crash

- Overview
When mounting the attached crafted image and running program, this error is
reported.

The image is intentionally fuzzed from a normal f2fs image for testing and I
enabled option CONFIG_F2FS_CHECK_FS on.

- Reproduces
cc poc_07.c
mkdir test
mount -t f2fs tmp.img test
cp a.out test
cd test
sudo ./a.out

- Messages
[   60.310824] kernel BUG at fs/f2fs/node.c:1279!
[   60.311440] invalid opcode: 0000 [#1] SMP PTI
[   60.312054] CPU: 0 PID: 1896 Comm: a.out Not tainted 5.0.0 #5
[   60.312808] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   60.314054] RIP: 0010:read_node_page+0xcf/0xf0
[   60.314634] Code: f9 ff ff 85 c0 75 d5 8b 44 24 08 85 c0 74 1d 48 8b 55 48
83 e2 40 75 14 4c 89 e7 89 44 24 30 89 44 24 2c e8 13 84 ff ff eb b2 <0f> 0b 48
8b 53 08 48 8d 42 ff 83 e2 01 48 0f 45 d8 3e 80 23 fb b8
[   60.317121] RSP: 0018:ffffb15e00cf3ae8 EFLAGS: 00010246
[   60.317807] RAX: 0000000000000001 RBX: ffffe7e708c86d40 RCX:
0000000000000000
[   60.318742] RDX: 0000000000000000 RSI: ffff976df7a15418 RDI:
ffff976df7a15418
[   60.319736] RBP: ffff976dec3ed800 R08: 0000000000007be0 R09:
ffffffff914d0614
[   60.320673] R10: 0000000000000004 R11: 00000000000001ae R12:
ffffb15e00cf3af8
[   60.321621] R13: 0000000000000000 R14: 000000000000000a R15:
ffff976dec3ed800
[   60.322540] FS:  00007f7de5494700(0000) GS:ffff976df7a00000(0000)
knlGS:0000000000000000
[   60.323614] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   60.324379] CR2: 00007f7de4faf4c0 CR3: 000000022ecb0005 CR4:
00000000001606f0
[   60.325308] Call Trace:
[   60.325652]  __get_node_page+0x6b/0x2f0
[   60.326162]  ? iget_locked+0x17e/0x1d0
[   60.326654]  f2fs_iget+0x8f/0xdf0
[   60.327091]  f2fs_lookup+0x136/0x320
[   60.327586]  __lookup_slow+0x92/0x140
[   60.328067]  lookup_slow+0x30/0x50
[   60.328499]  walk_component+0x1c1/0x350
[   60.329015]  ? __switch_to_asm+0x34/0x70
[   60.329536]  ? __switch_to_asm+0x40/0x70
[   60.330073]  ? __switch_to_asm+0x34/0x70
[   60.330584]  ? __switch_to_asm+0x40/0x70
[   60.331098]  path_lookupat+0x62/0x200
[   60.331604]  ? __switch_to_asm+0x34/0x70
[   60.332157]  ? __switch_to_asm+0x40/0x70
[   60.332676]  ? __switch_to_asm+0x34/0x70
[   60.333195]  ? __switch_to_asm+0x40/0x70
[   60.333713]  ? __switch_to_asm+0x34/0x70
[   60.334232]  filename_lookup+0xb3/0x1a0
[   60.334752]  ? f2fs_sync_fs+0xa3/0x130
[   60.335270]  ? _cond_resched+0x11/0x40
[   60.335825]  ? kmem_cache_alloc+0x33/0x160
[   60.336383]  ? getname_flags+0x6a/0x1d0
[   60.336926]  ? do_fchmodat+0x3e/0xa0
[   60.337412]  do_fchmodat+0x3e/0xa0
[   60.337870]  __x64_sys_chmod+0x12/0x20
[   60.338385]  do_syscall_64+0x43/0xf0
[   60.338855]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   60.339538] RIP: 0033:0x7f7de4faf4d9
[   60.340025] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89
f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 8b 0d 8f 29 2c 00 f7 d8 64 89 01 48
[   60.342463] RSP: 002b:00007fff97df5e88 EFLAGS: 00000217 ORIG_RAX:
000000000000005a
[   60.343486] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f7de4faf4d9
[   60.344441] RDX: 00007f7de4faf4d9 RSI: 0000000000000c00 RDI:
00007fff97df5f30
[   60.345368] RBP: 00007fff97dfa0a0 R08: 00007fff97dfa188 R09:
00007fff97dfa188
[   60.346321] R10: 00007fff97dfa188 R11: 0000000000000217 R12:
00000000004004e0
[   60.347264] R13: 00007fff97dfa180 R14: 0000000000000000 R15:
0000000000000000
[   60.348222] Modules linked in:
[   60.348641] ---[ end trace b0f535db0cf81616 ]---
[   60.349265] RIP: 0010:read_node_page+0xcf/0xf0
[   60.349869] Code: f9 ff ff 85 c0 75 d5 8b 44 24 08 85 c0 74 1d 48 8b 55 48
83 e2 40 75 14 4c 89 e7 89 44 24 30 89 44 24 2c e8 13 84 ff ff eb b2 <0f> 0b 48
8b 53 08 48 8d 42 ff 83 e2 01 48 0f 45 d8 3e 80 23 fb b8
[   60.352351] RSP: 0018:ffffb15e00cf3ae8 EFLAGS: 00010246
[   60.353043] RAX: 0000000000000001 RBX: ffffe7e708c86d40 RCX:
0000000000000000
[   60.354005] RDX: 0000000000000000 RSI: ffff976df7a15418 RDI:
ffff976df7a15418
[   60.354957] RBP: ffff976dec3ed800 R08: 0000000000007be0 R09:
ffffffff914d0614
[   60.355934] R10: 0000000000000004 R11: 00000000000001ae R12:
ffffb15e00cf3af8
[   60.356877] R13: 0000000000000000 R14: 000000000000000a R15:
ffff976dec3ed800
[   60.357803] FS:  00007f7de5494700(0000) GS:ffff976df7a00000(0000)
knlGS:0000000000000000
[   60.358858] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   60.359654] CR2: 00007f7de4faf4c0 CR3: 000000022ecb0005 CR4:
00000000001606f0

- Error location
1263 static int read_node_page(struct page *page, int op_flags)
1264 {
1265     struct f2fs_sb_info *sbi = F2FS_P_SB(page);
1266     struct node_info ni;
1267     struct f2fs_io_info fio = {
1268         .sbi = sbi,
1269         .type = NODE,
1270         .op = REQ_OP_READ,
1271         .op_flags = op_flags,
1272         .page = page,
1273         .encrypted_page = NULL,
1274     };
1275     int err;
1276 
1277     if (PageUptodate(page)) {
1278 #ifdef CONFIG_F2FS_CHECK_FS
*1279         f2fs_bug_on(sbi, !f2fs_inode_chksum_verify(sbi, page));
1280 #endif
1281         return LOCKED_PAGE;
1282     }
1283 
1284     err = f2fs_get_node_info(sbi, page->index, &ni);
1285     if (err)
1286         return err;
1287 
1288     if (unlikely(ni.blk_addr == NULL_ADDR) ||
1289             is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN)) {
1290         ClearPageUptodate(page);
1291         return -ENOENT;
1292     }
1293 
1294     fio.new_blkaddr = fio.old_blkaddr = ni.blk_addr;
1295     return f2fs_submit_page_bio(&fio);
1296 }

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
