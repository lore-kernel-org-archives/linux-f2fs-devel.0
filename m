From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 202883] New: sometime dead lock in getdents64
Date: Tue, 12 Mar 2019 06:41:08 +0000
Message-ID: <bug-202883-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1h3b6E-0007ZH-VW
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Mar 2019 06:41:18 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h3b6C-005P3s-Nr
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Mar 2019 06:41:18 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 734BB294B8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 12 Mar 2019 06:41:09 +0000 (UTC)
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

https://bugzilla.kernel.org/show_bug.cgi?id=202883

            Bug ID: 202883
           Summary: sometime dead lock in getdents64
           Product: File System
           Version: 2.5
    Kernel Version: f2fs-dev
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: f2fs
          Assignee: filesystem_f2fs@kernel-bugs.kernel.org
          Reporter: jiqun.li@unisoc.com
        Regression: No

sometimes, dead lock when make system call SYS_getdents64 with fsync() is
called by another process.

monkey running on android9.0

1.  task 9785 held sbi->cp_rwsem and waiting lock_page()
2.  task 10349 held mm_sem and waiting sbi->cp_rwsem
3. task 9709 held lock_page() and waiting mm_sem

so this is a dead lock scenario.

task stack is show by crash tools as following

crash_arm64> bt ffffffc03c354080
PID: 9785   TASK: ffffffc03c354080  CPU: 1   COMMAND: "RxIoScheduler-3"
#0 [ffffffc01b50f8a0] __switch_to at ffffff8008086d88
#1 [ffffffc01b50f8c0] __schedule at ffffff8008a90840
#2 [ffffffc01b50f920] schedule at ffffff8008a90f2c
#3 [ffffffc01b50f940] schedule_timeout at ffffff8008a940ec
#4 [ffffffc01b50f9f0] io_schedule_timeout at ffffff8008a90544
#5 [ffffffc01b50fa20] bit_wait_io at ffffff8008a913b4
#6 [ffffffc01b50fa40] __wait_on_bit_lock at ffffff8008a91574
>> #7 [ffffffc01b50fac0] __lock_page at ffffff80081b11e8
#8 [ffffffc01b50fb30] f2fs_sync_node_pages at ffffff8008387d08
#9 [ffffffc01b50fc50] f2fs_write_checkpoint at ffffff8008376620
#10 [ffffffc01b50fd30] f2fs_sync_fs at ffffff800836b030
#11 [ffffffc01b50fda0] f2fs_do_sync_file at ffffff8008358a30
#12 [ffffffc01b50fe50] f2fs_sync_file at ffffff80083591c4
#13 [ffffffc01b50fe90] sys_fsync at ffffff800824cffc




crash-arm64> bt 10349
PID: 10349  TASK: ffffffc018b83080  CPU: 1   COMMAND: "BUGLY_ASYNC_UPL"
#0 [ffffffc01f8cf9a0] __switch_to at ffffff8008086d88
#1 [ffffffc01f8cf9c0] __schedule at ffffff8008a90840
#2 [ffffffc01f8cfa20] schedule at ffffff8008a90f2c
>> #3 [ffffffc01f8cfa40] rwsem_down_read_failed at ffffff8008a93afc
#4 [ffffffc01f8cfab0] down_read at ffffff8008a93360
#5 [ffffffc01f8cfad0] __do_map_lock at ffffff800837e758
#6 [ffffffc01f8cfb00] f2fs_vm_page_mkwrite at ffffff8008359c14
#7 [ffffffc01f8cfb90] do_page_mkwrite at ffffff80081e09cc
#8 [ffffffc01f8cfc10] do_wp_page at ffffff80081e2de8
#9 [ffffffc01f8cfcb0] handle_mm_fault at ffffff80081e5228
#10 [ffffffc01f8cfd80] do_page_fault at ffffff800809d05c
#11 [ffffffc01f8cfdf0] do_mem_abort at ffffff8008081570
#12 [ffffffc01f8cfed0] el0_da at ffffff8008085650
     PC: 00000033  LR: 00000000  SP: 00000000  PSTATE: ffffffffffffffff


crash-arm64> bt 9709
PID: 9709   TASK: ffffffc03e7f3080  CPU: 1   COMMAND: "IntentService[A"
#0 [ffffffc001e677b0] __switch_to at ffffff8008086d88
#1 [ffffffc001e677d0] __schedule at ffffff8008a90840
#2 [ffffffc001e67830] schedule at ffffff8008a90f2c
>> #3 [ffffffc001e67850] rwsem_down_read_failed at ffffff8008a93afc
#4 [ffffffc001e678c0] down_read at ffffff8008a93360
#5 [ffffffc001e678e0] do_page_fault at ffffff800809ceb8
#6 [ffffffc001e67950] do_translation_fault at ffffff800809d250
#7 [ffffffc001e67980] do_mem_abort at ffffff8008081570
>> #8 [ffffffc001e67b80] el1_ia at ffffff8008084fc4
     PC: ffffff8008274114  [compat_filldir64+120]
     LR: ffffff80083584d4  [f2fs_fill_dentries+448]
     SP: ffffffc001e67b80  PSTATE: 80400145
    X29: ffffffc001e67b80  X28: 0000000000000000  X27: 000000000000001a
    X26: 00000000000093d7  X25: ffffffc070d52480  X24: 0000000000000008
    X23: 0000000000000028  X22: 00000000d43dfd60  X21: ffffffc001e67e90
    X20: 0000000000000011  X19: ffffff80093a4000  X18: 0000000000000000
    X17: 0000000000000000  X16: 0000000000000000  X15: 0000000000000000
    X14: ffffffffffffffff  X13: 0000000000000008  X12: 0101010101010101
    X11: 7f7f7f7f7f7f7f7f  X10: 6a6a6a6a6a6a6a6a   X9: 7f7f7f7f7f7f7f7f
     X8: 0000000080808000   X7: ffffff800827409c   X6: 0000000080808000
     X5: 0000000000000008   X4: 00000000000093d7   X3: 000000000000001a
     X2: 0000000000000011   X1: ffffffc070d52480   X0: 0000000000800238
>> #9 [ffffffc001e67be0] f2fs_fill_dentries at ffffff80083584d0
#10 [ffffffc001e67ca0] f2fs_read_inline_dir at ffffff8008372ca4
#11 [ffffffc001e67d20] f2fs_readdir at ffffff80083588a0
#12 [ffffffc001e67de0] iterate_dir at ffffff8008228e90
#13 [ffffffc001e67e30] compat_sys_getdents64 at ffffff8008278894
#14 [ffffffc001e67ed0] __sys_trace at ffffff8008085b48
     PC: 0000003c  LR: 00000000  SP: 00000000  PSTATE: 000000d9
    X12: f48a02ff X11: d4678960 X10: d43dfc00  X9: d4678ae4
     X8: 00000058  X7: d4678994  X6: d43de800  X5: 000000d9
     X4: d43dfc0c  X3: d43dfc10  X2: d46799c8  X1: 00000000
     X0: 00001068

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
