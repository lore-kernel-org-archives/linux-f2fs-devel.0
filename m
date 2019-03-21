From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 202989] New: kernel panic during F2FS GC
Date: Thu, 21 Mar 2019 14:39:15 +0000
Message-ID: <bug-202989-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1h6yqq-0000UY-J1
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Mar 2019 14:39:24 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h6yqp-0019zt-2T
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Mar 2019 14:39:24 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 85D252A1FA
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 21 Mar 2019 14:39:16 +0000 (UTC)
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

https://bugzilla.kernel.org/show_bug.cgi?id=202989

            Bug ID: 202989
           Summary: kernel panic during F2FS GC
           Product: File System
           Version: 2.5
    Kernel Version: 4.14.81
          Hardware: ARM
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: f2fs
          Assignee: filesystem_f2fs@kernel-bugs.kernel.org
          Reporter: hlianjun@gmail.com
        Regression: No

kernel panic twice during F2FS GC.

dmesg as below:

[ 4983.497816] ------------[ cut here ]------------
[ 4983.497831] kernel BUG at /ap/kernel/msm-4.14/fs/f2fs/segment.h:654!
[ 4983.497847] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
[ 4983.497871] ipa ipa3_active_clients_panic_notifier:262 
[ 4983.497871] ---- Active Clients Table ----
[ 4983.497871] TAG_PROCESS                              -22 SPECIAL
[ 4983.497871] 
[ 4983.497871] Total active clients count: 0
[ 4983.497871] 
[ 4983.497896] Kernel Offset: 0x4a00000 from 0xffffff8008000000
[ 4983.497903] CPU features: 0x05022218
[ 4983.497908] Memory Limit: none

[ 4983.497990] CPU: 1 PID: 517 Comm: f2fs_gc-259:28 Tainted: G S      W  O   
4.14.81-perf+ #1
[ 4983.497994] Hardware name: Qualcomm Technologies, Inc. SM6150 PM6150
Qualcomm Technologies, Inc. SM6150 QRD (DT)
[ 4983.498000] task: ffffffcda8e3bc00 task.stack: ffffff8015ff8000
[ 4983.498016] pc : f2fs_submit_page_bio+0xcc/0x710
[ 4983.498022] lr : f2fs_gc+0x10ac/0x2658
[ 4983.498027] sp : ffffff8015ffbab0 pstate : 00c00145
[ 4983.498031] x29: ffffff8015ffbb10 x28: ffffffcc97a20000 
[ 4983.498037] x27: ffffffcc97a20270 x26: 0000000000041202 
[ 4983.498044] x25: ffffffcd2ea84641 x24: 0000000000000000 
[ 4983.498050] x23: 00000000000000e4 x22: ffffffbf34baa200 
[ 4983.498056] x21: ffffffbf34ad1980 x20: ffffff8015ffbcf0 
[ 4983.498062] x19: ffffffcc97a20000 x18: 0000000001b3d600 
[ 4983.498068] x17: 0000000000000200 x16: 000000000000d9eb 
[ 4983.498074] x15: 0000000000000009 x14: ffffffcdaaa91e54 
[ 4983.498080] x13: ffffffbf34ad1980 x12: 0000000000000001 
[ 4983.498086] x11: ffffffcdaaa91e5c x10: ffffffcdaaa91e50 
[ 4983.498092] x9 : ffffffcdab64e800 x8 : 00000000ffffffff 
[ 4983.498098] x7 : 2ae5373e5569c600 x6 : ffffff800e6f1ba0 
[ 4983.498104] x5 : 0000000000000000 x4 : ffffffcc97a20170 
[ 4983.498110] x3 : ffffffbf34ad1980 x2 : 0000000001b3d800 
[ 4983.498117] x1 : ffffffbf34ad1980 x0 : ffffff8015ffbcf0 
[ 4983.498124] 
[ 4983.498124] PC: 0xffffff800ce243b4:
[ 4983.498130] 43b4  6b0801ff 540001e8 b4000090 9101420a 9101720b 14000004
f9400933 9101226a
[ 4983.498145] 43d4  9100c26b b9400170 b944312f b9400151 1acf2212 0b110242
6b08005f 54000208
[ 4983.498158] 43f4  d4210000 14000000 f9400925 910120ac b940018d 6b0801bf
540030a8 b4000071
[ 4983.498171] 4414  9101522d 14000003 f9400926 910170cd b94001ae 6b0801df
54002fa9 d001000a
[ 4983.498185] 
[ 4983.498185] LR: 0xffffff800ce21acc:
[ 4983.498191] 1acc  2a1f03e7 f81683b6 292b8ba2 940063c6 f85403a5 52800803
b85043a1 321f07e2
[ 4983.498205] 1aec  72a02803 f940c0b0 f9401a00 97f7bf56 f81703a0 b4002a00
d10303a0 94000a08
[ 4983.498218] 1b0c  2a0003f8 340029d8 f85703bb b400369b f9401366 d10004cf
f24000df 9a8f0360
[ 4983.498230] 1b2c  f940000d 3607c8cd aa1b03e0 97f7bcca f940136e d10005d1
f24001df 9a910360
[ 4983.498244] 
[ 4983.498244] SP: 0xffffff8015ffba70:
[ 4983.498250] ba70  0ce243f4 ffffff80 00c00145 00000000 00000000 00000000
5569c600 2ae5373e
[ 4983.498263] ba90  ffffffff ffffffff 00f142a7 00000000 15ffbb10 ffffff80
0ce243f4 ffffff80
[ 4983.498276] bab0  15ffbb10 ffffff80 97a20000 ffffffcc 97a20000 ffffffcc
97a20270 ffffffcc
[ 4983.498289] bad0  00041202 00000000 2ea84641 ffffffcd 00000000 00000000
000000e4 00000000
[ 4983.498302] 
[ 4983.498307] Process f2fs_gc-259:28 (pid: 517, stack limit =
0xffffff8015ff8000)
[ 4983.498311] Call trace:
[ 4983.498318]  f2fs_submit_page_bio+0xcc/0x710
[ 4983.498323]  f2fs_gc+0x10ac/0x2658
[ 4983.498329]  gc_thread_func+0x188/0x398
[ 4983.498339]  kthread+0x110/0x120
[ 4983.498346]  ret_from_fork+0x10/0x18
[ 4983.498355] Code: 1acf2212 0b110242 6b08005f 54000208 (d4210000) 
[ 4983.498363] ---[ end trace 48f10a63e91d9ade ]---

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
