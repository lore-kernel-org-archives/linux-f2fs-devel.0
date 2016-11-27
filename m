From: Eric Biggers <ebiggers@google.com>
Subject: f2fs crash when filling up small filesystem
Date: Sat, 26 Nov 2016 20:39:54 -0800
Message-ID: <20161127043954.GB34163@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ebiggers@google.com>) id 1cArG1-0002fD-7K
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 27 Nov 2016 04:40:05 +0000
Received: from mail-pf0-f172.google.com ([209.85.192.172])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cArFz-0004KL-Pt
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 27 Nov 2016 04:40:05 +0000
Received: by mail-pf0-f172.google.com with SMTP id d2so19456396pfd.0
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sat, 26 Nov 2016 20:40:03 -0800 (PST)
Content-Disposition: inline
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

Hello,

While writing an encryption test, I found that f2fs crashes when filling up a
small (32MB) filesystem with data.  It turned out that no special mkfs or mount
options are needed, just a small filesystem.  The steps to reproduce are
roughly:

	mkfs.f2fs /dev/vdd 65536
	mount /dev/vdd /vdd
	dd if=/dev/zero of=/vdd/file
	sync

This produces several WARNs, then a NULL pointer dereference in
update_sit_entry(), shown below.

Let me know if more information is needed.

------------[ cut here ]------------
WARNING: CPU: 0 PID: 20 at fs/f2fs/segment.c:1106 new_curseg+0x24c/0x34c
CPU: 0 PID: 20 Comm: kworker/u4:1 Not tainted 4.9.0-rc4-ext4-00064-g1d85fd5 #898
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Workqueue: writeback wb_workfn (flush-253:48)
 ffffc900003bf3f0 ffffffff815629ac 0000000000000000 0000000000000000
 ffffc900003bf430 ffffffff810dd9a3 0000045279d2da28 ffff880079d2da00
 0000000000000008 0000000000000003 ffff880079d20000 0000000000000001
Call Trace:
 [<ffffffff815629ac>] dump_stack+0x85/0xbe
 [<ffffffff810dd9a3>] __warn+0xc5/0xe0
 [<ffffffff810dda75>] warn_slowpath_null+0x1d/0x1f
 [<ffffffff814cf4e2>] new_curseg+0x24c/0x34c
 [<ffffffff814cf818>] allocate_segment_by_default+0x55/0x2f4
 [<ffffffff814cfd12>] ? allocate_data_block+0x7e/0x307
 [<ffffffff81875236>] ? mutex_lock_nested+0x329/0x34b
 [<ffffffff814cff96>] allocate_data_block+0x302/0x307
 [<ffffffff814d01be>] do_write_page+0x223/0x270
 [<ffffffff814d0292>] write_node_page+0x20/0x22
 [<ffffffff814c7089>] f2fs_write_node_page+0x2a0/0x3b1
 [<ffffffff814c9a68>] sync_node_pages+0x326/0x5a3
 [<ffffffff811215fd>] ? trace_hardirqs_on+0xd/0xf
 [<ffffffff814bbdba>] ? write_checkpoint+0x28a/0x1160
 [<ffffffff814bbdc9>] write_checkpoint+0x299/0x1160
 [<ffffffff8112144b>] ? mark_held_locks+0x58/0x6e
 [<ffffffff811215fd>] ? trace_hardirqs_on+0xd/0xf
 [<ffffffff814bec7b>] f2fs_gc+0x2f4/0x505
 [<ffffffff814bec7b>] ? f2fs_gc+0x2f4/0x505
 [<ffffffff814cdda8>] ? f2fs_balance_fs+0x114/0x129
 [<ffffffff814cddb2>] f2fs_balance_fs+0x11e/0x129
 [<ffffffff814c52de>] f2fs_write_data_page+0x53c/0x5fa
 [<ffffffff814c095f>] f2fs_write_cache_pages+0x267/0x388
 [<ffffffff814c0c7e>] f2fs_write_data_pages+0x1fe/0x40c
 [<ffffffff8111fdac>] ? __lock_is_held+0x38/0x50
 [<ffffffff811bfae7>] do_writepages+0x21/0x2f
 [<ffffffff812350c5>] __writeback_single_inode+0x15c/0x883
 [<ffffffff81235c22>] writeback_sb_inodes+0x2e5/0x4d0
 [<ffffffff81235e83>] __writeback_inodes_wb+0x76/0xad
 [<ffffffff812360d9>] wb_writeback+0x21f/0x5d5
 [<ffffffff812366d8>] wb_workfn+0x249/0x6a4
 [<ffffffff8111fdac>] ? __lock_is_held+0x38/0x50
 [<ffffffff810f6398>] process_one_work+0x327/0x669
 [<ffffffff810f6229>] ? process_one_work+0x1b8/0x669
 [<ffffffff810f69a0>] worker_thread+0x293/0x392
 [<ffffffff810f670d>] ? process_scheduled_works+0x33/0x33
 [<ffffffff810fc604>] kthread+0xf9/0x101
 [<ffffffff810fc50b>] ? __kthread_create_on_node+0x181/0x181
 [<ffffffff8187992a>] ret_from_fork+0x2a/0x40
---[ end trace 91a1217bf9eae6df ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 20 at fs/f2fs/segment.c:1145 new_curseg+0x2c3/0x34c
CPU: 0 PID: 20 Comm: kworker/u4:1 Tainted: G        W       4.9.0-rc4-ext4-00064-g1d85fd5 #898
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Workqueue: writeback wb_workfn (flush-253:48)
 ffffc900003bf3f0 ffffffff815629ac 0000000000000000 0000000000000000
 ffffc900003bf430 ffffffff810dd9a3 0000047900000000 ffff880079d2da00
 0000000000000008 0000000000000001 ffff880079d20000 0000000000000001
Call Trace:
 [<ffffffff815629ac>] dump_stack+0x85/0xbe
 [<ffffffff810dd9a3>] __warn+0xc5/0xe0
 [<ffffffff810dda75>] warn_slowpath_null+0x1d/0x1f
 [<ffffffff814cf559>] new_curseg+0x2c3/0x34c
 [<ffffffff814cf818>] allocate_segment_by_default+0x55/0x2f4
 [<ffffffff814cfd12>] ? allocate_data_block+0x7e/0x307
 [<ffffffff81875236>] ? mutex_lock_nested+0x329/0x34b
 [<ffffffff814cff96>] allocate_data_block+0x302/0x307
 [<ffffffff814d01be>] do_write_page+0x223/0x270
 [<ffffffff814d0292>] write_node_page+0x20/0x22
 [<ffffffff814c7089>] f2fs_write_node_page+0x2a0/0x3b1
 [<ffffffff814c9a68>] sync_node_pages+0x326/0x5a3
 [<ffffffff811215fd>] ? trace_hardirqs_on+0xd/0xf
 [<ffffffff814bbdba>] ? write_checkpoint+0x28a/0x1160
 [<ffffffff814bbdc9>] write_checkpoint+0x299/0x1160
 [<ffffffff8112144b>] ? mark_held_locks+0x58/0x6e
 [<ffffffff811215fd>] ? trace_hardirqs_on+0xd/0xf
 [<ffffffff814bec7b>] f2fs_gc+0x2f4/0x505
 [<ffffffff814bec7b>] ? f2fs_gc+0x2f4/0x505
 [<ffffffff814cdda8>] ? f2fs_balance_fs+0x114/0x129
 [<ffffffff814cddb2>] f2fs_balance_fs+0x11e/0x129
 [<ffffffff814c52de>] f2fs_write_data_page+0x53c/0x5fa
 [<ffffffff814c095f>] f2fs_write_cache_pages+0x267/0x388
 [<ffffffff814c0c7e>] f2fs_write_data_pages+0x1fe/0x40c
 [<ffffffff8111fdac>] ? __lock_is_held+0x38/0x50
 [<ffffffff811bfae7>] do_writepages+0x21/0x2f
 [<ffffffff812350c5>] __writeback_single_inode+0x15c/0x883
 [<ffffffff81235c22>] writeback_sb_inodes+0x2e5/0x4d0
 [<ffffffff81235e83>] __writeback_inodes_wb+0x76/0xad
 [<ffffffff812360d9>] wb_writeback+0x21f/0x5d5
 [<ffffffff812366d8>] wb_workfn+0x249/0x6a4
 [<ffffffff8111fdac>] ? __lock_is_held+0x38/0x50
 [<ffffffff810f6398>] process_one_work+0x327/0x669
 [<ffffffff810f6229>] ? process_one_work+0x1b8/0x669
 [<ffffffff810f69a0>] worker_thread+0x293/0x392
 [<ffffffff810f670d>] ? process_scheduled_works+0x33/0x33
 [<ffffffff810fc604>] kthread+0xf9/0x101
 [<ffffffff810fc50b>] ? __kthread_create_on_node+0x181/0x181
 [<ffffffff8187992a>] ret_from_fork+0x2a/0x40
---[ end trace 91a1217bf9eae6e0 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 20 at fs/f2fs/segment.c:2155 flush_sit_entries+0x45d/0x75e
CPU: 0 PID: 20 Comm: kworker/u4:1 Tainted: G        W       4.9.0-rc4-ext4-00064-g1d85fd5 #898
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Workqueue: writeback wb_workfn (flush-253:48)
 ffffc900003bf638 ffffffff815629ac 0000000000000000 0000000000000000
 ffffc900003bf678 ffffffff810dd9a3 0000086b82e80460 ffff88007a92c370
 0000000000000000 ffff88007a8f92f0 0000000000000008 ffff880079d20000
Call Trace:
 [<ffffffff815629ac>] dump_stack+0x85/0xbe
 [<ffffffff810dd9a3>] __warn+0xc5/0xe0
 [<ffffffff810dda75>] warn_slowpath_null+0x1d/0x1f
 [<ffffffff814d192b>] flush_sit_entries+0x45d/0x75e
 [<ffffffff814bc01d>] write_checkpoint+0x4ed/0x1160
 [<ffffffff811215fd>] ? trace_hardirqs_on+0xd/0xf
 [<ffffffff814bec7b>] f2fs_gc+0x2f4/0x505
 [<ffffffff814bec7b>] ? f2fs_gc+0x2f4/0x505
 [<ffffffff814cdda8>] ? f2fs_balance_fs+0x114/0x129
 [<ffffffff814cddb2>] f2fs_balance_fs+0x11e/0x129
 [<ffffffff814c52de>] f2fs_write_data_page+0x53c/0x5fa
 [<ffffffff814c095f>] f2fs_write_cache_pages+0x267/0x388
 [<ffffffff814c0c7e>] f2fs_write_data_pages+0x1fe/0x40c
 [<ffffffff8111fdac>] ? __lock_is_held+0x38/0x50
 [<ffffffff811bfae7>] do_writepages+0x21/0x2f
 [<ffffffff812350c5>] __writeback_single_inode+0x15c/0x883
 [<ffffffff81235c22>] writeback_sb_inodes+0x2e5/0x4d0
 [<ffffffff81235e83>] __writeback_inodes_wb+0x76/0xad
 [<ffffffff812360d9>] wb_writeback+0x21f/0x5d5
 [<ffffffff812366d8>] wb_workfn+0x249/0x6a4
 [<ffffffff8111fdac>] ? __lock_is_held+0x38/0x50
 [<ffffffff810f6398>] process_one_work+0x327/0x669
 [<ffffffff810f6229>] ? process_one_work+0x1b8/0x669
 [<ffffffff810f69a0>] worker_thread+0x293/0x392
 [<ffffffff810f670d>] ? process_scheduled_works+0x33/0x33
 [<ffffffff810fc604>] kthread+0xf9/0x101
 [<ffffffff810fc50b>] ? __kthread_create_on_node+0x181/0x181
 [<ffffffff8187992a>] ret_from_fork+0x2a/0x40
---[ end trace 91a1217bf9eae6e1 ]---
BUG: unable to handle kernel NULL pointer dereference at           (null)
IP: [<ffffffff814cca85>] update_sit_entry+0x10f/0x2a0
PGD 7a919067 PUD 0 

Oops: 0000 [#1] SMP
CPU: 0 PID: 20 Comm: kworker/u4:1 Tainted: G        W       4.9.0-rc4-ext4-00064-g1d85fd5 #898
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Workqueue: writeback wb_workfn (flush-253:48)
task: ffff88007c9c8540 task.stack: ffffc900003bc000
RIP: 0010:[<ffffffff814cca85>]  [<ffffffff814cca85>] update_sit_entry+0x10f/0x2a0
RSP: 0000:ffffc900003bf580  EFLAGS: 00010202
RAX: 0000000000000000 RBX: ffff88007a8f9340 RCX: 0000000000000007
RDX: 0000000000000008 RSI: 0000000000000000 RDI: 0000000000000200
RBP: ffffc900003bf5c0 R08: 0000000000000001 R09: 0000000000000000
R10: ffff88007a8ae4a0 R11: 000000000001b548 R12: 0000000000000000
R13: ffff880079d20000 R14: 00000000ffffffff R15: 0000000000000080
FS:  0000000000000000(0000) GS:ffff88007fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000007a988000 CR4: 00000000000006f0
Stack:
 ffffc900003bf5e8 0000000000000246 0000000800000001 ffff880079d20000
 0000000000002000 0000000000001601 0000000000000000 ffff88007a8ae400
 ffffc900003bf5e8 ffffffff814ce898 ffff88007aafa4a0 0000000000000004
Call Trace:
 [<ffffffff814ce898>] refresh_sit_entry+0x24/0xad
 [<ffffffff814cfeb5>] allocate_data_block+0x221/0x307
 [<ffffffff814d01be>] do_write_page+0x223/0x270
 [<ffffffff814d0292>] write_node_page+0x20/0x22
 [<ffffffff814c7089>] f2fs_write_node_page+0x2a0/0x3b1
 [<ffffffff814c9183>] move_node_page+0xa8/0x101
 [<ffffffff814be2a9>] do_garbage_collect+0x43e/0xb1c
 [<ffffffff81876b71>] ? __mutex_unlock_slowpath+0x156/0x175
 [<ffffffff81876b9e>] ? mutex_unlock+0xe/0x10
 [<ffffffff814becab>] f2fs_gc+0x324/0x505
 [<ffffffff814cdda8>] ? f2fs_balance_fs+0x114/0x129
 [<ffffffff814cddb2>] f2fs_balance_fs+0x11e/0x129
 [<ffffffff814c52de>] f2fs_write_data_page+0x53c/0x5fa
 [<ffffffff814c095f>] f2fs_write_cache_pages+0x267/0x388
 [<ffffffff814c0c7e>] f2fs_write_data_pages+0x1fe/0x40c
 [<ffffffff8111fdac>] ? __lock_is_held+0x38/0x50
 [<ffffffff811bfae7>] do_writepages+0x21/0x2f
 [<ffffffff812350c5>] __writeback_single_inode+0x15c/0x883
 [<ffffffff81235c22>] writeback_sb_inodes+0x2e5/0x4d0
 [<ffffffff81235e83>] __writeback_inodes_wb+0x76/0xad
 [<ffffffff812360d9>] wb_writeback+0x21f/0x5d5
 [<ffffffff812366d8>] wb_workfn+0x249/0x6a4
 [<ffffffff8111fdac>] ? __lock_is_held+0x38/0x50
 [<ffffffff810f6398>] process_one_work+0x327/0x669
 [<ffffffff810f6229>] ? process_one_work+0x1b8/0x669
 [<ffffffff810f69a0>] worker_thread+0x293/0x392
 [<ffffffff810f670d>] ? process_scheduled_works+0x33/0x33
 [<ffffffff810fc604>] kthread+0xf9/0x101
 [<ffffffff810fc50b>] ? __kthread_create_on_node+0x181/0x181
 [<ffffffff8187992a>] ret_from_fork+0x2a/0x40
Code: 8b 09 48 89 81 e8 00 00 00 48 8b 73 08 0f 8e 96 00 00 00 44 89 e0 44 89 f1 41 bf 01 00 00 00 c1 e8 03 83 e1 07 48 01 c6 41 d3 e7 <0f> be 0e 40 88 cf 44 09 ff 44 85 f9 40 88 3e 74 1f be 6d 03 00 
RIP  [<ffffffff814cca85>] update_sit_entry+0x10f/0x2a0
 RSP <ffffc900003bf580>
CR2: 0000000000000000
---[ end trace 91a1217bf9eae6e2 ]---
BUG: sleeping function called from invalid context at ./include/linux/sched.h:3109
in_atomic(): 0, irqs_disabled(): 1, pid: 20, name: kworker/u4:1
INFO: lockdep is turned off.
irq event stamp: 222342
hardirqs last  enabled at (222341): [<ffffffff81875236>] mutex_lock_nested+0x329/0x34b
hardirqs last disabled at (222342): [<ffffffff8187aa79>] error_entry+0x69/0xc0
softirqs last  enabled at (218088): [<ffffffff8187c54c>] __do_softirq+0x3b4/0x4be
softirqs last disabled at (218071): [<ffffffff810e38d0>] irq_exit+0x69/0xb9
CPU: 0 PID: 20 Comm: kworker/u4:1 Tainted: G      D W       4.9.0-rc4-ext4-00064-g1d85fd5 #898
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Workqueue:  0xffff88007c9c8540 (	)
 ffffc900003bfe60 ffffffff815629ac ffff88007c9c8540 0000000000000c25
 ffffc900003bfe88 ffffffff8110ca0c ffffffff81be5c64 0000000000000c25
 0000000000000000 ffffc900003bfeb0 ffffffff8110ca98 ffff88007c9c8540
Call Trace:
 [<ffffffff815629ac>] dump_stack+0x85/0xbe
 [<ffffffff8110ca0c>] ___might_sleep+0x201/0x214
 [<ffffffff8110ca98>] __might_sleep+0x79/0x80
 [<ffffffff810ed593>] exit_signals+0x26/0x20d
 [<ffffffff810e229c>] do_exit+0x130/0x9ff
 [<ffffffff8187aca7>] rewind_stack_do_exit+0x17/0x20
QEMU: Terminated
WARNING: CPU: 0 PID: 20 at fs/f2fs/segment.c:1106 new_curseg+0x24c/0x34c
WARNING: CPU: 0 PID: 20 at fs/f2fs/segment.c:1145 new_curseg+0x2c3/0x34c
WARNING: CPU: 0 PID: 20 at fs/f2fs/segment.c:2155 flush_sit_entries+0x45d/0x75e

------------------------------------------------------------------------------
