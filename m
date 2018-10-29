From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 201555] New: [f2fs] Processes freezing periodically
 with f2fs root
Date: Mon, 29 Oct 2018 09:02:40 +0000
Message-ID: <bug-201555-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1gH3Rg-0002tq-E6
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 29 Oct 2018 09:02:48 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gH3Re-0069Xw-Cb
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 29 Oct 2018 09:02:48 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 92DD72981B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 29 Oct 2018 09:02:40 +0000 (UTC)
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

https://bugzilla.kernel.org/show_bug.cgi?id=201555

            Bug ID: 201555
           Summary: [f2fs] Processes freezing periodically with f2fs root
           Product: File System
           Version: 2.5
    Kernel Version: 4.14 - 4.19 (at least)
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: f2fs
          Assignee: filesystem_f2fs@kernel-bugs.kernel.org
          Reporter: gondsman@techgeek.co.in
        Regression: No

I'm running Manjaro linux on two separate machines with very different hardware
and both experience processes (mostly systemd-journal) freeze after long-ish
uptimes (sometimes hours, sometimes days). After that the system eventually
becomes unresponsive and a hard reset is needed.

I assume this is related to the fact that I have f2fs as a root partition on
both machines. I can read something like this in my dmesg, repeating every 120
seconds:

[322559.191681] INFO: task systemd-journal:260 blocked for more than 120
seconds.
[322559.191692]       Tainted: P           O    4.14.74-1-MANJARO #1
[322559.191695] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
this message.
[322559.191700] systemd-journal D    0   260      1 0x00000104
[322559.191706] Call Trace:
[322559.191720]  ? __schedule+0x286/0x890
[322559.191725]  schedule+0x2f/0x90
[322559.191731]  rwsem_down_read_failed+0xe3/0x150
[322559.191738]  ? dput.part.35+0x28/0x1e0
[322559.191744]  call_rwsem_down_read_failed+0x14/0x30
[322559.191750]  down_read+0x13/0x30
[322559.191770]  f2fs_vm_page_mkwrite+0x72/0x550 [f2fs]
[322559.191778]  do_page_mkwrite+0x31/0x90
[322559.191783]  do_wp_page+0x400/0x560
[322559.191789]  ? _copy_to_user+0x26/0x30
[322559.191796]  ? cp_new_stat+0x150/0x180
[322559.191801]  __handle_mm_fault+0xbf2/0x1520
[322559.191809]  handle_mm_fault+0xaa/0x1d0
[322559.191817]  __do_page_fault+0x258/0x530
[322559.191825]  ? page_fault+0x2f/0x50
[322559.191831]  page_fault+0x45/0x50
[322559.191836] RIP: b737dfa0:0x559314bf7c60
[322559.191839] RSP: 0050:0000000000000001 EFLAGS: 7ffeb737dfa8
[322601.532195] systemd[1]: systemd-journald.service: State 'stop-sigabrt'
timed out. Terminating.

I can rule out a hardware issue because I even swapped disks on one of my
machines and it didn't solve it. It happens on both SATA and NVMe drives. I
tried every kernel version from 4.14 to 4.19 and it didn't make a difference.
I've read bug 195983 as my issue looked similar to it, but adding nomerge_flush
mount flag also had no effect.

Unfortunately it's pretty difficult to reproduce the bug consistently, as it
can take literally days for it to show up.

Can I do anything else to help debugging it?

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
