From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 203341] New: Kernel read fault when mounting a
 crafted image and running program
Date: Tue, 16 Apr 2019 23:53:28 +0000
Message-ID: <bug-203341-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1hGXtR-0007rM-Oz
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 16 Apr 2019 23:53:37 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hGXtP-009zSp-Lp
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 16 Apr 2019 23:53:37 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 07BC92884F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 16 Apr 2019 23:53:30 +0000 (UTC)
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

https://bugzilla.kernel.org/show_bug.cgi?id=203341

            Bug ID: 203341
           Summary: Kernel read fault when mounting a crafted image and
                    running program
           Product: File System
           Version: 2.5
    Kernel Version: 5.0
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

Created attachment 282359
  --> https://bugzilla.kernel.org/attachment.cgi?id=282359&action=edit
The (compressed) crafted image which causes crash

- Overview
When mounting attached crafted image and running this program,
I got this kernel page fault.

- Reproduces
cc poc_6.c
./run.sh f2fs
sync

- Kernel Messages
[  185.865830] F2FS-fs (sdb): Can't find valid F2FS filesystem in 2th 
[  186.537086] BUG: unable to handle kernel paging request at ffffa0ef00000000
[  186.538220] #PF error: [normal kernel read fault]
[  186.538954] PGD 1e0e01067 P4D 1e0e01067 PUD 0 
[  186.539648] Oops: 0000 [#1] SMP PTI
[  186.540181] CPU: 0 PID: 1219 Comm: apport Not tainted 5.0.0 #3
[  186.541094] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[  186.542556] RIP: 0010:proc_pid_status+0x35b/0x970
[  186.543282] Code: 8b 7d 88 45 31 f6 e8 74 1f e2 ff 4c 89 a5 78 ff ff ff 89
c2 45 89 f4 48 c7 c6 cc da 13 ba 4c 8b 75 88 eb 27 49 63 c4 4c 89 f7 <41> 8b 74
85 08 e8 4b 1f e2 ff 45 85 e4 89 c2 48 c7 c6 de 7f 1b ba
[  186.546133] RSP: 0018:ffffb1bb0118bcd8 EFLAGS: 00010297
[  186.546919] RAX: 0000000002fe7b32 RBX: ffffa0eef60d6300 RCX:
0000000000000000
[  186.548000] RDX: 0000000000000000 RSI: ffffffffba1b7fde RDI:
ffffffffba457480
[  186.549099] RBP: ffffb1bb0118bd70 R08: 0000000000001002 R09:
abcc77118461cefd
[  186.550178] R10: 0000000000000015 R11: ffffa0eef4f7fffd R12:
0000000002fe7b32
[  186.551237] R13: ffffa0eef4061330 R14: ffffffffba457480 R15:
ffffa0eef4002e00
[  186.552295] FS:  00007f235ff77700(0000) GS:ffffa0eef7a00000(0000)
knlGS:0000000000000000
[  186.553534] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  186.554399] CR2: ffffa0ef00000000 CR3: 000000023474e003 CR4:
00000000001606f0
[  186.555469] Call Trace:
[  186.555850]  ? memcg_kmem_get_cache+0x58/0x1e0
[  186.556518]  proc_single_show+0x52/0x90
[  186.557116]  seq_read+0xe1/0x470
[  186.557627]  ? cp_new_stat+0x156/0x190
[  186.558192]  __vfs_read+0x3a/0x1a0
[  186.558707]  ? security_file_permission+0xa0/0xf0
[  186.559410]  vfs_read+0x95/0x140
[  186.559897]  ksys_read+0x55/0xc0
[  186.560395]  __x64_sys_read+0x1a/0x20
[  186.560935]  do_syscall_64+0x5a/0x110
[  186.561543]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  186.562304] RIP: 0033:0x7f235fb51500
[  186.562853] Code: 73 01 c3 48 8b 0d a8 7a 20 00 f7 d8 64 89 01 48 83 c8 ff
c3 66 0f 1f 44 00 00 83 3d a9 be 20 00 00 75 10 b8 00 00 00 00 0f 05 <48> 3d 01
f0 ff ff 73 31 c3 48 83 ec 08 e8 4e fc ff ff 48 89 04 24
[  186.565631] RSP: 002b:00007ffd8f6e04d8 EFLAGS: 00000246 ORIG_RAX:
0000000000000000
[  186.566716] RAX: ffffffffffffffda RBX: 00007f235ff77698 RCX:
00007f235fb51500
[  186.567742] RDX: 0000000000002000 RSI: 00000000022fa6d0 RDI:
0000000000000004
[  186.568767] RBP: 0000000000002000 R08: 0000000000000000 R09:
00007ffd8f6e01f0
[  186.569857] R10: 0000000000000100 R11: 0000000000000246 R12:
00007ffd8f6e0530
[  186.570923] R13: 0000000000000004 R14: 00000000022fa6d0 R15:
0000000001f752d0
[  186.571993] Modules linked in:
[  186.572458] CR2: ffffa0ef00000000
[  186.572961] ---[ end trace 4b158d975c6da9bc ]---
[  186.573723] RIP: 0010:proc_pid_status+0x35b/0x970
[  186.574451] Code: 8b 7d 88 45 31 f6 e8 74 1f e2 ff 4c 89 a5 78 ff ff ff 89
c2 45 89 f4 48 c7 c6 cc da 13 ba 4c 8b 75 88 eb 27 49 63 c4 4c 89 f7 <41> 8b 74
85 08 e8 4b 1f e2 ff 45 85 e4 89 c2 48 c7 c6 de 7f 1b ba
[  186.577135] RSP: 0018:ffffb1bb0118bcd8 EFLAGS: 00010297
[  186.577945] RAX: 0000000002fe7b32 RBX: ffffa0eef60d6300 RCX:
0000000000000000
[  186.578956] RDX: 0000000000000000 RSI: ffffffffba1b7fde RDI:
ffffffffba457480
[  186.579968] RBP: ffffb1bb0118bd70 R08: 0000000000001002 R09:
abcc77118461cefd
[  186.580980] R10: 0000000000000015 R11: ffffa0eef4f7fffd R12:
0000000002fe7b32
[  186.582094] R13: ffffa0eef4061330 R14: ffffffffba457480 R15:
ffffa0eef4002e00
[  186.583115] FS:  00007f235ff77700(0000) GS:ffffa0eef7a00000(0000)
knlGS:0000000000000000
[  186.584301] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  186.585159] CR2: ffffa0ef00000000 CR3: 000000023474e003 CR4:
00000000001606f0
[  186.589589] BUG: unable to handle kernel paging request at ffffa0efeec02bc4
[  186.590664] #PF error: [normal kernel read fault]
[  186.591370] PGD 1e0e01067 P4D 1e0e01067 PUD 0 
[  186.592027] Oops: 0000 [#2] SMP PTI
[  186.592540] CPU: 0 PID: 1203 Comm: bash Tainted: G      D           5.0.0 #3
[  186.593627] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[  186.595035] RIP: 0010:in_group_p+0x44/0x60
[  186.595632] Code: 78 20 74 39 4c 8b 80 90 00 00 00 4d 85 c0 74 29 41 8b 50
04 85 d2 74 21 31 c9 eb 07 8d 48 01 39 d1 73 16 8d 04 0a d1 e8 89 c6 <41> 39 7c
b0 08 72 eb 76 0a 89 c2 39 d1 72 ea 31 c0 5d c3 b8 01 00
[  186.598380] RSP: 0018:ffffb1bb01157bb8 EFLAGS: 00010206
[  186.599131] RAX: 000000003eae83d7 RBX: 00000000000041ed RCX:
0000000000000000
[  186.600181] RDX: 000000007d5d07ae RSI: 000000003eae83d7 RDI:
0000000000000000
[  186.601240] RBP: ffffb1bb01157bb8 R08: ffffa0eef4061c60 R09:
ffffa0eef7401900
[  186.602301] R10: 2f2f2f2f2f2f2f2f R11: ffffa0eef756da80 R12:
ffffa0eeeacec0e8
[  186.603357] R13: 0000000000000081 R14: ffffb1bb01157da0 R15:
ffffb1bb01157da0
[  186.604379] FS:  00007f080a234700(0000) GS:ffffa0eef7a00000(0000)
knlGS:0000000000000000
[  186.605587] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  186.606429] CR2: ffffa0efeec02bc4 CR3: 00000002328e8001 CR4:
00000000001606f0
[  186.607446] Call Trace:
[  186.607809]  generic_permission+0x116/0x190
[  186.608432]  inode_permission+0x3a/0x1b0
[  186.609035]  link_path_walk+0x92/0x5f0
[  186.609602]  ? path_init+0x21a/0x300
[  186.610135]  path_openat+0xde/0x1540
[  186.610680]  ? reuse_swap_page+0x112/0x340
[  186.611274]  do_filp_open+0x99/0x110
[  186.611798]  ? __handle_mm_fault+0x883/0x12c0
[  186.612448]  ? __check_object_size+0x17c/0x1b0
[  186.613149]  ? strncpy_from_user+0x50/0x1b0
[  186.613796]  ? __alloc_fd+0x46/0x170
[  186.614333]  do_sys_open+0x128/0x220
[  186.614875]  ? do_sys_open+0x128/0x220
[  186.615434]  __x64_sys_open+0x21/0x30
[  186.615991]  do_syscall_64+0x5a/0x110
[  186.616533]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  186.617311] RIP: 0033:0x7f0809852a0f
[  186.617864] Code: 51 39 00 75 4b 48 8b 3b 4d 89 c6 c7 43 08 ff ff ff ff 48
c7 43 10 00 00 00 00 48 85 ff 74 2a b9 02 00 00 00 31 f6 89 c8 0f 05 <48> 3d 00
f0 ff ff 49 89 c4 76 7e 48 8b 15 57 34 39 00 8b 05 7d 51
[  186.620621] RSP: 002b:00007ffc05259ab0 EFLAGS: 00000246 ORIG_RAX:
0000000000000002
[  186.621770] RAX: ffffffffffffffda RBX: 00000000007eb388 RCX:
00007f0809852a0f
[  186.622825] RDX: 00007f080a234700 RSI: 0000000000000000 RDI:
00000000008a9688
[  186.623843] RBP: 00007ffc05259c10 R08: 0000000000000000 R09:
0000000000000010
[  186.624859] R10: 00007f08098b2330 R11: 0000000000000246 R12:
0000000000000000
[  186.625972] R13: 00007ffc05259ca0 R14: 0000000000000000 R15:
0000000000000000
[  186.627010] Modules linked in:
[  186.627481] CR2: ffffa0efeec02bc4
[  186.627967] ---[ end trace 4b158d975c6da9bd ]---
[  186.628637] RIP: 0010:proc_pid_status+0x35b/0x970
[  186.629398] Code: 8b 7d 88 45 31 f6 e8 74 1f e2 ff 4c 89 a5 78 ff ff ff 89
c2 45 89 f4 48 c7 c6 cc da 13 ba 4c 8b 75 88 eb 27 49 63 c4 4c 89 f7 <41> 8b 74
85 08 e8 4b 1f e2 ff 45 85 e4 89 c2 48 c7 c6 de 7f 1b ba
[  186.632112] RSP: 0018:ffffb1bb0118bcd8 EFLAGS: 00010297
[  186.632871] RAX: 0000000002fe7b32 RBX: ffffa0eef60d6300 RCX:
0000000000000000
[  186.633937] RDX: 0000000000000000 RSI: ffffffffba1b7fde RDI:
ffffffffba457480
[  186.634994] RBP: ffffb1bb0118bd70 R08: 0000000000001002 R09:
abcc77118461cefd
[  186.636035] R10: 0000000000000015 R11: ffffa0eef4f7fffd R12:
0000000002fe7b32
[  186.637094] R13: ffffa0eef4061330 R14: ffffffffba457480 R15:
ffffa0eef4002e00
[  186.638139] FS:  00007f080a234700(0000) GS:ffffa0eef7a00000(0000)
knlGS:0000000000000000
[  186.639299] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  186.640152] CR2: ffffa0efeec02bc4 CR3: 00000002328e8001 CR4:
00000000001606f0
[  186.642262] BUG: unable to handle kernel paging request at ffffa0efeec02bc4
[  186.643321] #PF error: [normal kernel read fault]
[  186.644014] PGD 1e0e01067 P4D 1e0e01067 PUD 0 
[  186.644700] Oops: 0000 [#3] SMP PTI
[  186.645259] CPU: 0 PID: 1134 Comm: bash Tainted: G      D           5.0.0 #3
[  186.646315] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[  186.647660] RIP: 0010:in_group_p+0x44/0x60
[  186.648257] Code: 78 20 74 39 4c 8b 80 90 00 00 00 4d 85 c0 74 29 41 8b 50
04 85 d2 74 21 31 c9 eb 07 8d 48 01 39 d1 73 16 8d 04 0a d1 e8 89 c6 <41> 39 7c
b0 08 72 eb 76 0a 89 c2 39 d1 72 ea 31 c0 5d c3 b8 01 00
[  186.651004] RSP: 0018:ffffb1bb0186bbb8 EFLAGS: 00010206
[  186.651757] RAX: 000000003eae83d7 RBX: 00000000000041ed RCX:
0000000000000000
[  186.652817] RDX: 000000007d5d07ae RSI: 000000003eae83d7 RDI:
0000000000000000
[  186.653877] RBP: ffffb1bb0186bbb8 R08: ffffa0eef4061c60 R09:
ffffa0eef7401900
[  186.654899] R10: 2f2f2f2f2f2f2f2f R11: ffffa0eef756da80 R12:
ffffa0eeeacec0e8
[  186.655920] R13: 0000000000000081 R14: ffffb1bb0186bda0 R15:
ffffb1bb0186bda0
[  186.656944] FS:  00007f080a234700(0000) GS:ffffa0eef7a00000(0000)
knlGS:0000000000000000
[  186.658165] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  186.659006] CR2: ffffa0efeec02bc4 CR3: 0000000231e96001 CR4:
00000000001606f0
[  186.660015] Call Trace:
[  186.660390]  generic_permission+0x116/0x190
[  186.661053]  inode_permission+0x3a/0x1b0
[  186.661670]  link_path_walk+0x92/0x5f0
[  186.662211]  ? path_init+0x21a/0x300
[  186.662747]  path_openat+0xde/0x1540
[  186.663284]  ? copy_termios+0x71/0x80
[  186.663835]  ? _copy_to_user+0x2a/0x40
[  186.664379]  ? reuse_swap_page+0x112/0x340
[  186.664989]  do_filp_open+0x99/0x110
[  186.665545]  ? __handle_mm_fault+0x883/0x12c0
[  186.666191]  ? __check_object_size+0x17c/0x1b0
[  186.666842]  ? strncpy_from_user+0x50/0x1b0
[  186.667467]  ? __alloc_fd+0x46/0x170
[  186.667982]  do_sys_open+0x128/0x220
[  186.668517]  ? do_sys_open+0x128/0x220
[  186.669091]  __x64_sys_open+0x21/0x30
[  186.669668]  do_syscall_64+0x5a/0x110
[  186.670203]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  186.670926] RIP: 0033:0x7f0809852a0f
[  186.671480] Code: 51 39 00 75 4b 48 8b 3b 4d 89 c6 c7 43 08 ff ff ff ff 48
c7 43 10 00 00 00 00 48 85 ff 74 2a b9 02 00 00 00 31 f6 89 c8 0f 05 <48> 3d 00
f0 ff ff 49 89 c4 76 7e 48 8b 15 57 34 39 00 8b 05 7d 51
[  186.674272] RSP: 002b:00007ffc05259b10 EFLAGS: 00000246 ORIG_RAX:
0000000000000002
[  186.675392] RAX: ffffffffffffffda RBX: 000000000077ac08 RCX:
00007f0809852a0f
[  186.676395] RDX: 00007f080a234700 RSI: 0000000000000000 RDI:
000000000085a008
[  186.677473] RBP: 00007ffc05259c70 R08: 0000000000000000 R09:
0000000000000010
[  186.678477] R10: 00007f08098b2330 R11: 0000000000000246 R12:
0000000000000000
[  186.679501] R13: 00007ffc05259d00 R14: 0000000000000000 R15:
0000000000000000
[  186.680547] Modules linked in:
[  186.681015] CR2: ffffa0efeec02bc4
[  186.681527] ---[ end trace 4b158d975c6da9be ]---
[  186.682215] RIP: 0010:proc_pid_status+0x35b/0x970
[  186.682870] Code: 8b 7d 88 45 31 f6 e8 74 1f e2 ff 4c 89 a5 78 ff ff ff 89
c2 45 89 f4 48 c7 c6 cc da 13 ba 4c 8b 75 88 eb 27 49 63 c4 4c 89 f7 <41> 8b 74
85 08 e8 4b 1f e2 ff 45 85 e4 89 c2 48 c7 c6 de 7f 1b ba
[  186.685581] RSP: 0018:ffffb1bb0118bcd8 EFLAGS: 00010297
[  186.686372] RAX: 0000000002fe7b32 RBX: ffffa0eef60d6300 RCX:
0000000000000000
[  186.687398] RDX: 0000000000000000 RSI: ffffffffba1b7fde RDI:
ffffffffba457480
[  186.688457] RBP: ffffb1bb0118bd70 R08: 0000000000001002 R09:
abcc77118461cefd
[  186.689543] R10: 0000000000000015 R11: ffffa0eef4f7fffd R12:
0000000002fe7b32
[  186.690589] R13: ffffa0eef4061330 R14: ffffffffba457480 R15:
ffffa0eef4002e00
[  186.691629] FS:  00007f080a234700(0000) GS:ffffa0eef7a00000(0000)
knlGS:0000000000000000
[  186.692807] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  186.693726] CR2: ffffa0efeec02bc4 CR3: 0000000231e96001 CR4:
00000000001606f0
[  187.142234] BUG: unable to handle kernel paging request at ffffa0ef00000000
[  187.143382] #PF error: [normal kernel read fault]
[  187.144103] PGD 1e0e01067 P4D 1e0e01067 PUD 0 
[  187.144780] Oops: 0000 [#4] SMP PTI
[  187.145347] CPU: 0 PID: 387 Comm: systemd-journal Tainted: G      D         
 5.0.0 #3
[  187.146560] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[  187.147989] RIP: 0010:proc_pid_status+0x35b/0x970
[  187.148691] Code: 8b 7d 88 45 31 f6 e8 74 1f e2 ff 4c 89 a5 78 ff ff ff 89
c2 45 89 f4 48 c7 c6 cc da 13 ba 4c 8b 75 88 eb 27 49 63 c4 4c 89 f7 <41> 8b 74
85 08 e8 4b 1f e2 ff 45 85 e4 89 c2 48 c7 c6 de 7f 1b ba
[  187.151519] RSP: 0018:ffffb1bb010e3cd8 EFLAGS: 00010293
[  187.152337] RAX: 0000000002fe78e6 RBX: ffffa0eeeb883800 RCX:
0000000000000000
[  187.153435] RDX: 0000000000000000 RSI: ffffffffba1b7fde RDI:
ffffffffba457480
[  187.154473] RBP: ffffb1bb010e3d70 R08: 0000000000001002 R09:
abcc77118461cefd
[  187.155462] R10: 000000000000001b R11: ffffa0eef54dbff8 R12:
0000000002fe78e6
[  187.156509] R13: ffffa0eef4061c60 R14: ffffffffba457480 R15:
ffffa0eef1a08000
[  187.157583] FS:  00007fa639135840(0000) GS:ffffa0eef7a00000(0000)
knlGS:0000000000000000
[  187.158786] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  187.159617] CR2: ffffa0ef00000000 CR3: 000000022f5fa005 CR4:
00000000001606f0
[  187.160650] Call Trace:
[  187.161033]  ? memcg_kmem_get_cache+0x58/0x1e0
[  187.161700]  proc_single_show+0x52/0x90
[  187.162281]  seq_read+0xe1/0x470
[  187.162770]  ? cp_new_stat+0x156/0x190
[  187.163335]  __vfs_read+0x3a/0x1a0
[  187.163850]  ? security_file_permission+0xa0/0xf0
[  187.164558]  vfs_read+0x95/0x140
[  187.165068]  ksys_read+0x55/0xc0
[  187.165583]  __x64_sys_read+0x1a/0x20
[  187.166136]  do_syscall_64+0x5a/0x110
[  187.166689]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  187.167444] RIP: 0033:0x7fa637ef9260
[  187.167984] Code: 0b 31 c0 48 83 c4 08 e9 ae fe ff ff 48 8d 3d 27 b4 09 00
e8 b2 1e 02 00 66 90 83 3d e9 24 2d 00 00 75 10 b8 00 00 00 00 0f 05 <48> 3d 01
f0 ff ff 73 31 c3 48 83 ec 08 e8 5e de 01 00 48 89 04 24
[  187.170734] RSP: 002b:00007ffe2c827708 EFLAGS: 00000246 ORIG_RAX:
0000000000000000
[  187.171845] RAX: ffffffffffffffda RBX: 000055d7f94da060 RCX:
00007fa637ef9260
[  187.172867] RDX: 0000000000000800 RSI: 000055d7f94dfe30 RDI:
0000000000000016
[  187.173939] RBP: 0000000000000000 R08: 00007fa6381c6bd8 R09:
000055d7f94dfe30
[  187.175000] R10: 00007fa639135840 R11: 0000000000000246 R12:
0000000000000800
[  187.176023] R13: 0000000000000800 R14: 000055d7f94dfe30 R15:
000055d7f94dfe30
[  187.177074] Modules linked in:
[  187.177569] CR2: ffffa0ef00000000
[  187.178067] ---[ end trace 4b158d975c6da9bf ]---
[  187.178742] RIP: 0010:proc_pid_status+0x35b/0x970
[  187.179422] Code: 8b 7d 88 45 31 f6 e8 74 1f e2 ff 4c 89 a5 78 ff ff ff 89
c2 45 89 f4 48 c7 c6 cc da 13 ba 4c 8b 75 88 eb 27 49 63 c4 4c 89 f7 <41> 8b 74
85 08 e8 4b 1f e2 ff 45 85 e4 89 c2 48 c7 c6 de 7f 1b ba
[  187.182196] RSP: 0018:ffffb1bb0118bcd8 EFLAGS: 00010297
[  187.182952] RAX: 0000000002fe7b32 RBX: ffffa0eef60d6300 RCX:
0000000000000000
[  187.184000] RDX: 0000000000000000 RSI: ffffffffba1b7fde RDI:
ffffffffba457480
[  187.185082] RBP: ffffb1bb0118bd70 R08: 0000000000001002 R09:
abcc77118461cefd
[  187.186149] R10: 0000000000000015 R11: ffffa0eef4f7fffd R12:
0000000002fe7b32
[  187.187171] R13: ffffa0eef4061330 R14: ffffffffba457480 R15:
ffffa0eef4002e00
[  187.188193] FS:  00007fa639135840(0000) GS:ffffa0eef7a00000(0000)
knlGS:0000000000000000
[  187.189441] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  187.190291] CR2: ffffa0ef00000000 CR3: 000000022f5fa005 CR4:
00000000001606f0
[  187.192221] polkitd[663]: segfault at 0 ip 0000000000000000 sp
00007ffec242ab70 error 14 in polkitd[400000+3000]
[  187.193806] Code: Bad RIP value.
[  187.208225] systemd[1]: systemd-journald.service: Failed with result
'signal'.
[  187.209669] systemd[1]: systemd-journald.service: Service has no hold-off
time, scheduling restart.
[  187.211481] systemd[1]: Stopped Flush Journal to Persistent Storage.
[  187.228383] systemd[1]: Stopping Flush Journal to Persistent Storage...
[  187.229471] systemd[1]: Stopped Journal Service.
[  187.230743] systemd[1]: Starting Journal Service...
[  187.239367] systemd[1]: Stopped User Manager for UID 1001.
[  187.245115] systemd-journald[1238]: File
/run/log/journal/b06a8bea3dae9be55b4b41f35aa719d0/system.journal corrupted or
uncleanly shut down, renaming and replacing.
[  187.264358] systemd[1]: Removed slice User Slice of jungyeon.
[  187.272976] systemd[1]: Started Journal Service.
[  187.733515] BUG: unable to handle kernel NULL pointer dereference at
0000000000000038
[  187.734699] #PF error: [normal kernel read fault]
[  187.735392] PGD 8000000234147067 P4D 8000000234147067 PUD 234c94067 PMD 0 
[  187.736414] Oops: 0000 [#5] SMP PTI
[  187.736928] CPU: 0 PID: 666 Comm: gdbus Tainted: G      D           5.0.0 #3
[  187.737986] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[  187.739383] RIP: 0010:do_exit+0x347/0xba0
[  187.739972] Code: 65 c0 4c 89 65 c8 e8 98 0d b5 00 48 8b 83 f0 08 00 00 48
8d 93 f0 08 00 00 48 39 c2 0f 85 49 06 00 00 48 89 df e8 49 e8 01 00 <4c> 8b 68
38 4c 39 eb 0f 84 df 05 00 00 48 8d 83 c8 08 00 00 48 89
[  187.742679] RSP: 0018:ffffb1bb010f3d10 EFLAGS: 00010006
[  187.743435] RAX: 0000000000000000 RBX: ffffa0eef4752e00 RCX:
0000000000000000
[  187.744462] RDX: ffffa0eef4060300 RSI: 000000000000000d RDI:
ffffa0eef4752e00
[  187.745557] RBP: ffffb1bb010f3d70 R08: 0000000000000001 R09:
0000000000000000
[  187.746610] R10: 0000000000000000 R11: ffffa0eeef531798 R12:
ffffb1bb010f3d30
[  187.747637] R13: ffffa0eef4752e00 R14: ffffa0eeeb293bf0 R15:
ffffa0eef4753930
[  187.748670] FS:  00007f9947c5b700(0000) GS:ffffa0eef7a00000(0000)
knlGS:0000000000000000
[  187.749872] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  187.750700] CR2: 0000000000000038 CR3: 000000022f582002 CR4:
00000000001606f0
[  187.751730] Call Trace:
[  187.752099]  do_group_exit+0x43/0xb0
[  187.752624]  get_signal+0x16b/0x790
[  187.753158]  do_signal+0x34/0x710
[  187.753670]  ? vfs_read+0x127/0x140
[  187.754175]  exit_to_usermode_loop+0xb6/0x120
[  187.754801]  do_syscall_64+0xda/0x110
[  187.755330]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  187.756051] RIP: 0033:0x7f994a99474d
[  187.756567] Code: e0 2c 00 00 75 10 b8 07 00 00 00 0f 05 48 3d 01 f0 ff ff
73 31 c3 48 83 ec 08 e8 8e 99 01 00 48 89 04 24 b8 07 00 00 00 0f 05 <48> 8b 3c
24 48 89 c2 e8 d7 99 01 00 48 89 d0 48 83 c4 08 48 3d 01
[  187.759150] RSP: 002b:00007f9947c5ad20 EFLAGS: 00000293 ORIG_RAX:
0000000000000007
[  187.760183] RAX: 0000000000000001 RBX: 00007f993800e4a0 RCX:
00007f994a99474d
[  187.761206] RDX: 00000000ffffffff RSI: 0000000000000002 RDI:
00007f993c0010c0
[  187.762214] RBP: 0000000000000002 R08: 0000000000000002 R09:
0000000000000001
[  187.763230] R10: 00007f993800c460 R11: 0000000000000293 R12:
00007f993c0010c0
[  187.764240] R13: 00000000ffffffff R14: 00007f994b0f2280 R15:
0000000000000002
[  187.765306] Modules linked in:
[  187.765767] CR2: 0000000000000038
[  187.766250] ---[ end trace 4b158d975c6da9c0 ]---
[  187.766918] RIP: 0010:proc_pid_status+0x35b/0x970
[  187.767594] Code: 8b 7d 88 45 31 f6 e8 74 1f e2 ff 4c 89 a5 78 ff ff ff 89
c2 45 89 f4 48 c7 c6 cc da 13 ba 4c 8b 75 88 eb 27 49 63 c4 4c 89 f7 <41> 8b 74
85 08 e8 4b 1f e2 ff 45 85 e4 89 c2 48 c7 c6 de 7f 1b ba
[  187.770271] RSP: 0018:ffffb1bb0118bcd8 EFLAGS: 00010297
[  187.771037] RAX: 0000000002fe7b32 RBX: ffffa0eef60d6300 RCX:
0000000000000000
[  187.772096] RDX: 0000000000000000 RSI: ffffffffba1b7fde RDI:
ffffffffba457480
[  187.773133] RBP: ffffb1bb0118bd70 R08: 0000000000001002 R09:
abcc77118461cefd
[  187.774177] R10: 0000000000000015 R11: ffffa0eef4f7fffd R12:
0000000002fe7b32
[  187.775200] R13: ffffa0eef4061330 R14: ffffffffba457480 R15:
ffffa0eef4002e00
[  187.776220] FS:  00007f9947c5b700(0000) GS:ffffa0eef7a00000(0000)
knlGS:0000000000000000
[  187.777453] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  187.778289] CR2: 0000000000000038 CR3: 000000022f582002 CR4:
00000000001606f0
[  187.779310] Fixing recursive fault but reboot is needed!

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
