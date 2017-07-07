From: Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: use spin_{,un}lock_irq{save,restore} in end_io
Date: Fri,  7 Jul 2017 08:54:34 +0800
Message-ID: <20170707005434.14695-1-chao@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>, stable@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

generic/361 reports below warning, this is because, end_io is
triggered from IRQ, if we want to use spinlock here, it needs
to avoid IRQ in the region of spinlock protected.

So this patch changes to use spin_{,un}lock_irq{save,restore}
in end_io to avoid potential deadlock.

 irq event stamp: 83391573
 loop: Write error at byte offset 438729728, length 1024.
 hardirqs last  enabled at (83391573): [<c1809752>] restore_all+0xf/0x65
 hardirqs last disabled at (83391572): [<c1809eac>] reschedule_interrupt+0x30/0x3c
 loop: Write error at byte offset 438860288, length 1536.
 softirqs last  enabled at (83389244): [<c180cc4e>] __do_softirq+0x1ae/0x476
 softirqs last disabled at (83389237): [<c101ca7c>] do_softirq_own_stack+0x2c/0x40
 loop: Write error at byte offset 438990848, length 2048.
 ================================
 WARNING: inconsistent lock state
 4.12.0-rc2+ #30 Tainted: G           O
 --------------------------------
 inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
 xfs_io/7959 [HC1[1]:SC0[0]:HE0:SE1] takes:
  (&(&sbi->cp_lock)->rlock){?.+...}, at: [<f96f96cc>] f2fs_stop_checkpoint+0x1c/0x50 [f2fs]
 {HARDIRQ-ON-W} state was registered at:
   __lock_acquire+0x527/0x7b0
   lock_acquire+0xae/0x220
   _raw_spin_lock+0x42/0x50
   do_checkpoint+0x165/0x9e0 [f2fs]
   write_checkpoint+0x33f/0x740 [f2fs]
   __f2fs_sync_fs+0x92/0x1f0 [f2fs]
   f2fs_sync_fs+0x12/0x20 [f2fs]
   sync_filesystem+0x67/0x80
   generic_shutdown_super+0x27/0x100
   kill_block_super+0x22/0x50
   kill_f2fs_super+0x3a/0x40 [f2fs]
   deactivate_locked_super+0x3d/0x70
   deactivate_super+0x40/0x60
   cleanup_mnt+0x39/0x70
   __cleanup_mnt+0x10/0x20
   task_work_run+0x69/0x80
   exit_to_usermode_loop+0x57/0x85
   do_fast_syscall_32+0x18c/0x1b0
   entry_SYSENTER_32+0x4c/0x7b
 irq event stamp: 1957420
 hardirqs last  enabled at (1957419): [<c1808f37>] _raw_spin_unlock_irq+0x27/0x50
 hardirqs last disabled at (1957420): [<c1809f9c>] call_function_single_interrupt+0x30/0x3c
 softirqs last  enabled at (1953784): [<c180cc4e>] __do_softirq+0x1ae/0x476
 softirqs last disabled at (1953773): [<c101ca7c>] do_softirq_own_stack+0x2c/0x40

 other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&(&sbi->cp_lock)->rlock);
   <Interrupt>
     lock(&(&sbi->cp_lock)->rlock);

  *** DEADLOCK ***

 2 locks held by xfs_io/7959:
  #0:  (sb_writers#13){.+.+.+}, at: [<c11fd7ca>] vfs_write+0x16a/0x190
  #1:  (&sb->s_type->i_mutex_key#16){+.+.+.}, at: [<f96e33f5>] f2fs_file_write_iter+0x25/0x140 [f2fs]

 stack backtrace:
 CPU: 2 PID: 7959 Comm: xfs_io Tainted: G           O    4.12.0-rc2+ #30
 Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
 Call Trace:
  dump_stack+0x5f/0x92
  print_usage_bug+0x1d3/0x1dd
  ? check_usage_backwards+0xe0/0xe0
  mark_lock+0x23d/0x280
  __lock_acquire+0x699/0x7b0
  ? __this_cpu_preempt_check+0xf/0x20
  ? trace_hardirqs_off_caller+0x91/0xe0
  lock_acquire+0xae/0x220
  ? f2fs_stop_checkpoint+0x1c/0x50 [f2fs]
  _raw_spin_lock+0x42/0x50
  ? f2fs_stop_checkpoint+0x1c/0x50 [f2fs]
  f2fs_stop_checkpoint+0x1c/0x50 [f2fs]
  f2fs_write_end_io+0x147/0x150 [f2fs]
  bio_endio+0x7a/0x1e0
  blk_update_request+0xad/0x410
  blk_mq_end_request+0x16/0x60
  lo_complete_rq+0x3c/0x70
  __blk_mq_complete_request_remote+0x11/0x20
  flush_smp_call_function_queue+0x6d/0x120
  ? debug_smp_processor_id+0x12/0x20
  generic_smp_call_function_single_interrupt+0x12/0x30
  smp_call_function_single_interrupt+0x25/0x40
  call_function_single_interrupt+0x37/0x3c
 EIP: _raw_spin_unlock_irq+0x2d/0x50
 EFLAGS: 00000296 CPU: 2
 EAX: 00000001 EBX: d2ccc51c ECX: 00000001 EDX: c1aacebd
 ESI: 00000000 EDI: 00000000 EBP: c96c9d1c ESP: c96c9d18
  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
  ? inherit_task_group.isra.98.part.99+0x6b/0xb0
  __add_to_page_cache_locked+0x1d4/0x290
  add_to_page_cache_lru+0x38/0xb0
  pagecache_get_page+0x8e/0x200
  f2fs_write_begin+0x96/0xf00 [f2fs]
  ? trace_hardirqs_on_caller+0xdd/0x1c0
  ? current_time+0x17/0x50
  ? trace_hardirqs_on+0xb/0x10
  generic_perform_write+0xa9/0x170
  __generic_file_write_iter+0x1a2/0x1f0
  ? f2fs_preallocate_blocks+0x137/0x160 [f2fs]
  f2fs_file_write_iter+0x6e/0x140 [f2fs]
  ? __lock_acquire+0x429/0x7b0
  __vfs_write+0xc1/0x140
  vfs_write+0x9b/0x190
  SyS_pwrite64+0x63/0xa0
  do_fast_syscall_32+0xa1/0x1b0
  entry_SYSENTER_32+0x4c/0x7b
 EIP: 0xb7786c61
 EFLAGS: 00000293 CPU: 2
 EAX: ffffffda EBX: 00000003 ECX: 08416000 EDX: 00001000
 ESI: 18b24000 EDI: 00000000 EBP: 00000003 ESP: bf9b36b0
  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b

Fixes: aaec2b1d1879 ("f2fs: introduce cp_lock to protect updating of ckpt_flags")
Cc: stable@vger.kernel.org
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 954917d582f8..079c49145d78 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -28,7 +28,18 @@ struct kmem_cache *inode_entry_slab;
 
 void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io)
 {
-	set_ckpt_flags(sbi, CP_ERROR_FLAG);
+	unsigned long flags;
+
+	if (end_io)
+		spin_lock_irqsave(&sbi->cp_lock, flags);
+	else
+		spin_lock(&sbi->cp_lock);
+	__set_ckpt_flags(F2FS_CKPT(sbi), CP_ERROR_FLAG);
+	if (end_io)
+		spin_unlock_irqrestore(&sbi->cp_lock, flags);
+	else
+		spin_unlock(&sbi->cp_lock);
+
 	sbi->sb->s_flags |= MS_RDONLY;
 	if (!end_io)
 		f2fs_flush_merged_writes(sbi);
-- 
2.13.0.90.g1eb437020
