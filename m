From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 203223] New: hangs on running program after
 mounting a crafted image
Date: Tue, 09 Apr 2019 21:53:25 +0000
Message-ID: <bug-203223-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1hDygR-0000g0-7N
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Apr 2019 21:53:35 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hDygO-00CZzY-W9
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Apr 2019 21:53:35 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 0AAAC2885F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  9 Apr 2019 21:53:27 +0000 (UTC)
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

https://bugzilla.kernel.org/show_bug.cgi?id=203223

            Bug ID: 203223
           Summary: hangs on running program after mounting a crafted
                    image
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

Created attachment 282223
  --> https://bugzilla.kernel.org/attachment.cgi?id=282223&action=edit
The (compressed) crafted image which causes crash

- Overview
When mounting the attached crafted image and running program, this error is
reported and it hangs.

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
cc poc_test_08.c
mkdir test
(Directory name must be test in this script)
mount -t f2fs tmp.img test
sudo ./a.out


- Messages
[   38.103369] BUG: unable to handle kernel NULL pointer dereference at
0000000000000108
[   38.104536] #PF error: [normal kernel read fault]
[   38.105208] PGD 0 P4D 0 
[   38.105575] Oops: 0000 [#1] SMP PTI
[   38.106071] CPU: 0 PID: 1887 Comm: sudo Tainted: G        W         5.0.0 #5
[   38.107066] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   38.108420] RIP: 0010:find_vma+0x3b/0x70
[   38.108974] Code: 48 85 c0 74 07 48 83 c4 08 5b 5d c3 48 8b 55 08 48 85 d2
75 15 eb ee 48 3b 5a e0 48 8d 42 e0 73 15 48 8b 52 10 48 85 d2 74 0c <48> 3b 5a
e8 72 e7 48 8b 52 08 eb ef 48 85 c0 74 ca 48 89 c6 48 89
[   38.111612] RSP: 0000:ffff95fb80d0bed8 EFLAGS: 00010202
[   38.112343] RAX: ffff92afb2a31c00 RBX: 00007fc24587e138 RCX:
0000000000000000
[   38.113342] RDX: 0000000000000120 RSI: 00007fc24587e138 RDI:
0000000000000000
[   38.114342] RBP: ffff92afb511e800 R08: ffff92afabecde80 R09:
0000000000000000
[   38.115373] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff95fb80d0bf58
[   38.116369] R13: 0000000000000055 R14: ffff92afb511e800 R15:
ffff92afabecde80
[   38.117387] FS:  00007fc247ab8800(0000) GS:ffff92afb7a00000(0000)
knlGS:0000000000000000
[   38.118519] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   38.119338] CR2: 0000000000000108 CR3: 0000000235c5a005 CR4:
00000000001606f0
[   38.120362] Call Trace:
[   38.120722]  __do_page_fault+0x138/0x4b0
[   38.121281]  ? page_fault+0x8/0x30
[   38.121765]  page_fault+0x1e/0x30
[   38.122238] RIP: 0033:0x7fc2478afb07
[   38.122764] Code: 85 f6 74 3f 4d 85 c0 74 42 49 8b 00 0f b6 56 04 48 03 46
08 83 e2 0f 80 fa 0a 0f 84 93 00 00 00 8b 15 e5 61 21 00 85 d2 75 03 <48> 89 03
48 83 c4 10 5b c3 45 31 c0 e9 75 ff ff ff 0f 1f 84 00 00
[   38.125432] RSP: 002b:00007ffd5b2162e0 EFLAGS: 00010246
[   38.126165] RAX: 00007fc246802fe0 RBX: 00007fc24587e138 RCX:
0000000000000001
[   38.127165] RDX: 0000000000000000 RSI: 00007fc246802560 RDI:
0000000000000001
[   38.128177] RBP: 000056427458edb0 R08: 00007fc247abb000 R09:
00007fc247abb000
[   38.129178] R10: 000000000000001b R11: 00007fc24680229c R12:
00005642745941f8
[   38.130230] R13: 00007ffd5b2165e0 R14: 0000564274593770 R15:
0000000000000000
[   38.131232] Modules linked in:
[   38.131668] CR2: 0000000000000108
[   38.132199] ---[ end trace de88ab9c8de99a02 ]---
[   38.132867] RIP: 0010:find_vma+0x3b/0x70
[   38.133434] Code: 48 85 c0 74 07 48 83 c4 08 5b 5d c3 48 8b 55 08 48 85 d2
75 15 eb ee 48 3b 5a e0 48 8d 42 e0 73 15 48 8b 52 10 48 85 d2 74 0c <48> 3b 5a
e8 72 e7 48 8b 52 08 eb ef 48 85 c0 74 ca 48 89 c6 48 89
[   38.136053] RSP: 0000:ffff95fb80d0bed8 EFLAGS: 00010202
[   38.136834] RAX: ffff92afb2a31c00 RBX: 00007fc24587e138 RCX:
0000000000000000
[   38.137836] RDX: 0000000000000120 RSI: 00007fc24587e138 RDI:
0000000000000000
[   38.138885] RBP: ffff92afb511e800 R08: ffff92afabecde80 R09:
0000000000000000
[   38.139925] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff95fb80d0bf58
[   38.140980] R13: 0000000000000055 R14: ffff92afb511e800 R15:
ffff92afabecde80
[   38.142007] FS:  00007fc247ab8800(0000) GS:ffff92afb7a00000(0000)
knlGS:0000000000000000
[   38.143165] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   38.143990] CR2: 0000000000000108 CR3: 0000000235c5a005 CR4:
00000000001606f0
[   38.148557] BUG: unable to handle kernel NULL pointer dereference at
0000000000000928
[   38.149680] #PF error: [normal kernel read fault]
[   38.150344] PGD 0 P4D 0 
[   38.150711] Oops: 0000 [#2] SMP PTI
[   38.151224] CPU: 0 PID: 1887 Comm: sudo Tainted: G      D W         5.0.0 #5
[   38.152204] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   38.153547] RIP: 0010:unmap_page_range+0xdb/0x890
[   38.154219] Code: 01 f0 48 21 d0 48 89 c3 48 83 e8 01 48 3b 84 24 88 00 00
00 48 89 d8 48 0f 43 44 24 78 48 89 44 24 40 48 8b 84 24 80 00 00 00 <48> 8b 08
48 f7 c1 9f ff ff ff 75 45 48 83 84 24 80 00 00 00 08 48
[   38.156835] RSP: 0018:ffff95fb80d0bcf8 EFLAGS: 00010206
[   38.157550] RAX: 0000000000000928 RBX: ffff930000000000 RCX:
ffff92afb5262e60
[   38.158511] RDX: ffffff8000000000 RSI: 0000000000000000 RDI:
ffff95fb80d0be38
[   38.159519] RBP: ffffffffffffffff R08: 0000000000000000 R09:
ffff92afb5262e60
[   38.160531] R10: ffff95fb80d0bd78 R11: 0000000000000ce1 R12:
0000000000000000
[   38.161499] R13: ffff95fb80d0be38 R14: ffff92afb5262e40 R15:
ffff95fb80d0be38
[   38.162469] FS:  0000000000000000(0000) GS:ffff92afb7a00000(0000)
knlGS:0000000000000000
[   38.163612] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   38.164401] CR2: 0000000000000928 CR3: 000000013da0e004 CR4:
00000000001606f0
[   38.165380] Call Trace:
[   38.165723]  unmap_vmas+0x67/0xc0
[   38.166178]  exit_mmap+0xa6/0x1a0
[   38.166638]  ? __schedule+0x309/0x6f0
[   38.167183]  mmput+0x29/0xd0
[   38.167584]  do_exit+0x26f/0xbf0
[   38.168030]  rewind_stack_do_exit+0x17/0x20
[   38.168601] Modules linked in:
[   38.169038] CR2: 0000000000000928
[   38.169493] ---[ end trace de88ab9c8de99a03 ]---
[   38.170153] RIP: 0010:find_vma+0x3b/0x70
[   38.170686] Code: 48 85 c0 74 07 48 83 c4 08 5b 5d c3 48 8b 55 08 48 85 d2
75 15 eb ee 48 3b 5a e0 48 8d 42 e0 73 15 48 8b 52 10 48 85 d2 74 0c <48> 3b 5a
e8 72 e7 48 8b 52 08 eb ef 48 85 c0 74 ca 48 89 c6 48 89
[   38.173339] RSP: 0000:ffff95fb80d0bed8 EFLAGS: 00010202
[   38.174118] RAX: ffff92afb2a31c00 RBX: 00007fc24587e138 RCX:
0000000000000000
[   38.175113] RDX: 0000000000000120 RSI: 00007fc24587e138 RDI:
0000000000000000
[   38.176128] RBP: ffff92afb511e800 R08: ffff92afabecde80 R09:
0000000000000000
[   38.177143] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff95fb80d0bf58
[   38.178136] R13: 0000000000000055 R14: ffff92afb511e800 R15:
ffff92afabecde80
[   38.179154] FS:  0000000000000000(0000) GS:ffff92afb7a00000(0000)
knlGS:0000000000000000
[   38.180278] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   38.181101] CR2: 0000000000000928 CR3: 000000013da0e004 CR4:
00000000001606f0
[   38.182093] Fixing recursive fault but reboot is needed!
[   39.309929] BUG: unable to handle kernel paging request at ffffffff87026510
[   39.310946] #PF error: [PROT] [WRITE]
[   39.311472] PGD 13da10067 P4D 13da10067 PUD 13da11063 PMD 800000013d6000e1 
[   39.312423] Oops: 0003 [#3] SMP PTI
[   39.312925] CPU: 0 PID: 1889 Comm: systemd-cgroups Tainted: G      D W      
  5.0.0 #5
[   39.314034] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   39.315372] RIP: 0010:__rb_insert_augmented+0x8b/0x210
[   39.316071] Code: ff 00 00 00 48 8b 1f 48 89 d5 f6 c3 01 74 bb 48 83 c4 08
5b 5d 41 5c 41 5d c3 4c 8b 67 08 49 39 ec 0f 84 f2 00 00 00 4d 85 e4 <4c> 89 63
10 48 89 5f 08 74 0b 48 89 d8 48 83 c8 01 49 89 04 24 48
[   39.318639] RSP: 0018:ffff95fb80d13b68 EFLAGS: 00010246
[   39.319398] RAX: ffff92afb59cc600 RBX: ffffffff87026500 RCX:
ffff92afb596ced0
[   39.320444] RDX: 0000000000000000 RSI: ffff92afb4510598 RDI:
ffff92afb4510598
[   39.321407] RBP: ffff92afb4510598 R08: ffffffff8617d350 R09:
ffff92afb2a31f78
[   39.322364] R10: 0000000000000000 R11: ffff92afb4510540 R12:
0000000000000000
[   39.323385] R13: ffff92afb596cec8 R14: ffff92afb45100f0 R15:
ffff92afb596cea8
[   39.324351] FS:  0000000000000000(0000) GS:ffff92afb7a00000(0000)
knlGS:0000000000000000
[   39.325444] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   39.326287] CR2: ffffffff87026510 CR3: 0000000236210001 CR4:
00000000001606f0
[   39.327310] Call Trace:
[   39.327654]  ? vmacache_find+0xa0/0xa0
[   39.328188]  vma_link+0x68/0xb0
[   39.328636]  mmap_region+0x3e4/0x600
[   39.329143]  ? selinux_task_prlimit+0x50/0x50
[   39.329757]  do_mmap+0x48a/0x650
[   39.330219]  ? security_mmap_file+0x5f/0xe0
[   39.330812]  vm_mmap_pgoff+0xc7/0x110
[   39.331348]  elf_map+0x8f/0x110
[   39.331786]  load_elf_binary+0x1346/0x16e0
[   39.332350]  search_binary_handler+0x98/0x1b0
[   39.332941]  __do_execve_file.isra.46+0x63a/0x910
[   39.333610]  do_execve+0x1c/0x20
[   39.334054]  call_usermodehelper_exec_async+0x154/0x170
[   39.334762]  ? umh_complete+0x30/0x30
[   39.335331]  ret_from_fork+0x35/0x40
[   39.335823] Modules linked in:
[   39.336247] CR2: ffffffff87026510
[   39.336703] ---[ end trace de88ab9c8de99a04 ]---
[   39.337331] RIP: 0010:find_vma+0x3b/0x70
[   39.337866] Code: 48 85 c0 74 07 48 83 c4 08 5b 5d c3 48 8b 55 08 48 85 d2
75 15 eb ee 48 3b 5a e0 48 8d 42 e0 73 15 48 8b 52 10 48 85 d2 74 0c <48> 3b 5a
e8 72 e7 48 8b 52 08 eb ef 48 85 c0 74 ca 48 89 c6 48 89
[   39.340408] RSP: 0000:ffff95fb80d0bed8 EFLAGS: 00010202
[   39.341148] RAX: ffff92afb2a31c00 RBX: 00007fc24587e138 RCX:
0000000000000000
[   39.342109] RDX: 0000000000000120 RSI: 00007fc24587e138 RDI:
0000000000000000
[   39.343091] RBP: ffff92afb511e800 R08: ffff92afabecde80 R09:
0000000000000000
[   39.344057] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff95fb80d0bf58
[   39.345014] R13: 0000000000000055 R14: ffff92afb511e800 R15:
ffff92afabecde80
[   39.345972] FS:  0000000000000000(0000) GS:ffff92afb7a00000(0000)
knlGS:0000000000000000
[   39.347083] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   39.347898] CR2: ffffffff87026510 CR3: 0000000236210001 CR4:
00000000001606f0
[   39.847977] BUG: unable to handle kernel paging request at 00000002004840c0
[   39.848937] #PF error: [normal kernel read fault]
[   39.849558] PGD 0 P4D 0 
[   39.849902] Oops: 0000 [#4] SMP PTI
[   39.850368] CPU: 0 PID: 1 Comm: systemd Tainted: G      D W         5.0.0 #5
[   39.851417] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   39.852683] RIP: 0010:kmem_cache_alloc+0x6b/0x160
[   39.853309] Code: 00 00 00 4d 8b 06 65 49 8b 50 08 65 4c 03 05 f4 18 e6 79
49 8b 28 48 85 ed 0f 84 b7 00 00 00 41 8b 46 20 48 8d 4a 01 49 8b 3e <48> 8b 5c
05 00 48 89 e8 65 48 0f c7 0f 0f 94 c0 84 c0 74 c5 41 8b
[   39.855810] RSP: 0018:ffff95fb80c5bc60 EFLAGS: 00010206
[   39.856498] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
0000000000009e44
[   39.857426] RDX: 0000000000009e43 RSI: 00000000006080c0 RDI:
0000000000024140
[   39.858355] RBP: 00000002004840c0 R08: ffff92afb7a24140 R09:
21404000000f0000
[   39.859354] R10: ffff95fb80c5bee8 R11: 8080808080808080 R12:
00000000006080c0
[   39.860289] R13: ffffffff861ba6ce R14: ffff92afb7405b00 R15:
ffff95fb80c5bdc0
[   39.861237] FS:  00007f32c4d2f8c0(0000) GS:ffff92afb7a00000(0000)
knlGS:0000000000000000
[   39.862313] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   39.863110] CR2: 00000002004840c0 CR3: 00000002366a8006 CR4:
00000000001606f0
[   39.864063] Call Trace:
[   39.864396]  __alloc_file+0x1e/0xe0
[   39.864879]  alloc_empty_file+0x3e/0xe0
[   39.865388]  path_openat+0x46/0x13a0
[   39.865877]  ? ___sys_recvmsg+0x17d/0x230
[   39.866410]  do_filp_open+0x94/0x110
[   39.866907]  ? ep_scan_ready_list+0x1c1/0x1e0
[   39.867521]  ? ep_poll+0x130/0x410
[   39.867976]  ? _cond_resched+0x11/0x40
[   39.868476]  ? kmem_cache_alloc+0x33/0x160
[   39.869024]  ? __alloc_fd+0x38/0x160
[   39.869501]  ? do_sys_open+0x125/0x220
[   39.869998]  do_sys_open+0x125/0x220
[   39.870474]  do_syscall_64+0x43/0xf0
[   39.870975]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   39.871709] RIP: 0033:0x7f32c3313040
[   39.872204] Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00
00 00 0f 1f 44 00 00 83 3d 09 27 2d 00 00 75 10 b8 02 00 00 00 0f 05 <48> 3d 01
f0 ff ff 73 31 c3 48 83 ec 08 e8 7e e0 01 00 48 89 04 24
[   39.874623] RSP: 002b:00007ffeb4496128 EFLAGS: 00000246 ORIG_RAX:
0000000000000002
[   39.875656] RAX: ffffffffffffffda RBX: 000055c4828764b0 RCX:
00007f32c3313040
[   39.876604] RDX: 00000000000001b6 RSI: 0000000000080000 RDI:
00007ffeb44961f0
[   39.877545] RBP: 00007ffeb44961f0 R08: 0000000000000008 R09:
0000000000000001
[   39.878509] R10: 0000000000080000 R11: 0000000000000246 R12:
000055c481f7ede6
[   39.879484] R13: 0000000000000001 R14: 00007ffeb4496260 R15:
000055c481f83963
[   39.880436] Modules linked in:
[   39.880844] CR2: 00000002004840c0
[   39.881313] ---[ end trace de88ab9c8de99a05 ]---
[   39.881965] RIP: 0010:find_vma+0x3b/0x70
[   39.882488] Code: 48 85 c0 74 07 48 83 c4 08 5b 5d c3 48 8b 55 08 48 85 d2
75 15 eb ee 48 3b 5a e0 48 8d 42 e0 73 15 48 8b 52 10 48 85 d2 74 0c <48> 3b 5a
e8 72 e7 48 8b 52 08 eb ef 48 85 c0 74 ca 48 89 c6 48 89
[   39.884934] RSP: 0000:ffff95fb80d0bed8 EFLAGS: 00010202
[   39.885622] RAX: ffff92afb2a31c00 RBX: 00007fc24587e138 RCX:
0000000000000000
[   39.886555] RDX: 0000000000000120 RSI: 00007fc24587e138 RDI:
0000000000000000
[   39.887568] RBP: ffff92afb511e800 R08: ffff92afabecde80 R09:
0000000000000000
[   39.888501] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff95fb80d0bf58
[   39.889451] R13: 0000000000000055 R14: ffff92afb511e800 R15:
ffff92afabecde80
[   39.890383] FS:  00007f32c4d2f8c0(0000) GS:ffff92afb7a00000(0000)
knlGS:0000000000000000
[   39.891560] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   39.892316] CR2: 00000002004840c0 CR3: 00000002366a8006 CR4:
00000000001606f0
[   39.893520] BUG: unable to handle kernel paging request at 00000002004840c0
[   39.894441] #PF error: [normal kernel read fault]
[   39.895103] PGD 0 P4D 0 
[   39.895460] Oops: 0000 [#5] SMP PTI
[   39.895924] CPU: 0 PID: 1416 Comm: systemd-timesyn Tainted: G      D W      
  5.0.0 #5
[   39.896990] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   39.898243] RIP: 0010:kmem_cache_alloc+0x6b/0x160
[   39.898889] Code: 00 00 00 4d 8b 06 65 49 8b 50 08 65 4c 03 05 f4 18 e6 79
49 8b 28 48 85 ed 0f 84 b7 00 00 00 41 8b 46 20 48 8d 4a 01 49 8b 3e <48> 8b 5c
05 00 48 89 e8 65 48 0f c7 0f 0f 94 c0 84 c0 74 c5 41 8b
[   39.901419] RSP: 0018:ffff95fb81023c60 EFLAGS: 00010206
[   39.902138] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
0000000000009e44
[   39.903133] RDX: 0000000000009e43 RSI: 00000000006080c0 RDI:
0000000000024140
[   39.904140] RBP: 00000002004840c0 R08: ffff92afb7a24140 R09:
ffffffffffffe000
[   39.905084] R10: ffff95fb81023ee8 R11: 8080808080808080 R12:
00000000006080c0
[   39.906101] R13: ffffffff861ba6ce R14: ffff92afb7405b00 R15:
ffff95fb81023dc0
[   39.907066] FS:  00007f3595458780(0000) GS:ffff92afb7a00000(0000)
knlGS:0000000000000000
[   39.908138] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   39.908891] CR2: 00000002004840c0 CR3: 000000022ed3e005 CR4:
00000000001606f0
[   39.909840] Call Trace:
[   39.910173]  __alloc_file+0x1e/0xe0
[   39.910641]  alloc_empty_file+0x3e/0xe0
[   39.911211]  path_openat+0x46/0x13a0
[   39.911707]  ? ___sys_sendmsg+0x9f/0x2d0
[   39.912377]  ? kmem_cache_alloc+0x154/0x160
[   39.912995]  do_filp_open+0x94/0x110
[   39.913494]  ? fsnotify_destroy_marks+0x1d/0xe0
[   39.914118]  ? __dentry_kill+0x10d/0x160
[   39.914692]  ? _cond_resched+0x11/0x40
[   39.915263]  ? kmem_cache_alloc+0x33/0x160
[   39.915847]  ? __alloc_fd+0x38/0x160
[   39.916361]  ? do_sys_open+0x125/0x220
[   39.916899]  do_sys_open+0x125/0x220
[   39.917412]  do_syscall_64+0x43/0xf0
[   39.917923]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   39.918636] RIP: 0033:0x7f35945baa5f
[   39.919150] Code: 00 66 2e 0f 1f 84 00 00 00 00 00 55 53 48 89 fb 48 89 f7
48 63 f2 48 83 ec 18 f6 43 74 02 74 6b 48 63 d1 b8 02 00 00 00 0f 05 <48> 3d 00
f0 ff ff 89 c5 77 47 85 ed 78 4f 8b 13 44 89 c0 41 81 e0
[   39.921735] RSP: 002b:00007ffd4aed1300 EFLAGS: 00000202 ORIG_RAX:
0000000000000002
[   39.922792] RAX: ffffffffffffffda RBX: 0000560468468030 RCX:
00007f35945baa5f
[   39.923794] RDX: 00000000000001b6 RSI: 0000000000080000 RDI:
00007f35946d0945
[   39.924783] RBP: 00007f35946d0945 R08: 0000000000000008 R09:
0000000000000001
[   39.925801] R10: 0000000000080000 R11: 0000000000000202 R12:
00007f35946cd733
[   39.926796] R13: 0000000000000001 R14: 0000000000000000 R15:
0000000000000000
[   39.927783] Modules linked in:
[   39.928192] CR2: 00000002004840c0
[   39.928647] ---[ end trace de88ab9c8de99a06 ]---
[   39.929260] RIP: 0010:find_vma+0x3b/0x70
[   39.929785] Code: 48 85 c0 74 07 48 83 c4 08 5b 5d c3 48 8b 55 08 48 85 d2
75 15 eb ee 48 3b 5a e0 48 8d 42 e0 73 15 48 8b 52 10 48 85 d2 74 0c <48> 3b 5a
e8 72 e7 48 8b 52 08 eb ef 48 85 c0 74 ca 48 89 c6 48 89
[   39.932297] RSP: 0000:ffff95fb80d0bed8 EFLAGS: 00010202
[   39.932991] RAX: ffff92afb2a31c00 RBX: 00007fc24587e138 RCX:
0000000000000000
[   39.933928] RDX: 0000000000000120 RSI: 00007fc24587e138 RDI:
0000000000000000
[   39.934880] RBP: ffff92afb511e800 R08: ffff92afabecde80 R09:
0000000000000000
[   39.935857] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff95fb80d0bf58
[   39.936797] R13: 0000000000000055 R14: ffff92afb511e800 R15:
ffff92afabecde80
[   39.937738] FS:  00007f3595458780(0000) GS:ffff92afb7a00000(0000)
knlGS:0000000000000000
[   39.938804] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   39.939646] CR2: 00000002004840c0 CR3: 000000022ed3e005 CR4:
00000000001606f0
[   39.940822] BUG: unable to handle kernel paging request at 0000000000001030
[   39.941814] #PF error: [normal kernel read fault]
[   39.942468] PGD 0 P4D 0 
[   39.942819] Oops: 0000 [#6] SMP PTI
[   39.943361] CPU: 0 PID: 1 Comm: systemd Tainted: G      D W         5.0.0 #5
[   39.944351] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   39.945693] RIP: 0010:vma_interval_tree_remove+0x53/0x2a0
[   39.946451] Code: 4d 85 ed 0f 84 80 01 00 00 4d 85 e4 0f 84 ae 01 00 00 49
8b 44 24 10 4c 89 e7 48 85 c0 75 0b e9 08 02 00 00 48 89 c7 48 89 d0 <48> 8b 50
10 48 85 d2 75 f1 4c 8b 48 08 49 89 c2 4c 89 4f 10 4c 89
[   39.949082] RSP: 0018:ffff95fb80c5bda0 EFLAGS: 00010202
[   39.949869] RAX: 0000000000001020 RBX: ffff92afabc55840 RCX:
ffff92afabc558b8
[   39.950834] RDX: 0000000000001020 RSI: ffff92afb5b7c268 RDI:
ffff92afabd5c1a0
[   39.951859] RBP: ffff92afabc55898 R08: 00007f32c3e8d000 R09:
ffffffff86192900
[   39.952873] R10: ffff92afab9cff80 R11: 0000000000000001 R12:
ffff92afb3209958
[   39.953879] R13: ffff92afabc55dd8 R14: ffff95fb80c5be38 R15:
0000000000000000
[   39.954875] FS:  0000000000000000(0000) GS:ffff92afb7a00000(0000)
knlGS:0000000000000000
[   39.955975] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   39.956746] CR2: 0000000000001030 CR3: 000000013da0e001 CR4:
00000000001606f0
[   39.957698] Call Trace:
[   39.958042]  unlink_file_vma+0x36/0x50
[   39.958555]  free_pgtables+0x9c/0x100
[   39.959080]  exit_mmap+0xbb/0x1a0
[   39.959572]  ? __schedule+0x37d/0x6f0
[   39.960087]  mmput+0x29/0xd0
[   39.960484]  do_exit+0x26f/0xbf0
[   39.960945]  rewind_stack_do_exit+0x17/0x20
[   39.961515] Modules linked in:
[   39.961934] CR2: 0000000000001030
[   39.962387] ---[ end trace de88ab9c8de99a07 ]---
[   39.963036] RIP: 0010:find_vma+0x3b/0x70
[   39.963581] Code: 48 85 c0 74 07 48 83 c4 08 5b 5d c3 48 8b 55 08 48 85 d2
75 15 eb ee 48 3b 5a e0 48 8d 42 e0 73 15 48 8b 52 10 48 85 d2 74 0c <48> 3b 5a
e8 72 e7 48 8b 52 08 eb ef 48 85 c0 74 ca 48 89 c6 48 89
[   39.966053] RSP: 0000:ffff95fb80d0bed8 EFLAGS: 00010202
[   39.966755] RAX: ffff92afb2a31c00 RBX: 00007fc24587e138 RCX:
0000000000000000
[   39.967750] RDX: 0000000000000120 RSI: 00007fc24587e138 RDI:
0000000000000000
[   39.968704] RBP: ffff92afb511e800 R08: ffff92afabecde80 R09:
0000000000000000
[   39.969656] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff95fb80d0bf58
[   39.970635] R13: 0000000000000055 R14: ffff92afb511e800 R15:
ffff92afabecde80
[   39.971639] FS:  0000000000000000(0000) GS:ffff92afb7a00000(0000)
knlGS:0000000000000000
[   39.972802] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   39.973579] CR2: 0000000000001030 CR3: 000000013da0e001 CR4:
00000000001606f0
[   39.974539] Fixing recursive fault but reboot is needed!

(hangs)

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
