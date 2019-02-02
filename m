From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 202495] New: oops in fs/f2fs/checkpoint.c:150
 f2fs_is_valid_blkaddr
Date: Sat, 02 Feb 2019 15:48:32 +0000
Message-ID: <bug-202495-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1gpxX7-0001rp-Qy
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 02 Feb 2019 15:48:41 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gpxX6-00G7CP-0n
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 02 Feb 2019 15:48:41 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 77DDA2F2AA
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat,  2 Feb 2019 15:48:33 +0000 (UTC)
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

https://bugzilla.kernel.org/show_bug.cgi?id=202495

            Bug ID: 202495
           Summary: oops in fs/f2fs/checkpoint.c:150 f2fs_is_valid_blkaddr
           Product: File System
           Version: 2.5
    Kernel Version: 4.14.97
          Hardware: ARM
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: f2fs
          Assignee: filesystem_f2fs@kernel-bugs.kernel.org
          Reporter: jw7779@gmail.com
        Regression: No

DMESG buffer filled with several oops's on boot

[   24.810633] ------------[ cut here ]------------
[   24.810690] WARNING: CPU: 0 PID: 140 at fs/f2fs/checkpoint.c:150
f2fs_is_valid_blkaddr+0x1d8/0x25c
[   24.810698] Modules linked in: ipt_MASQUERADE nf_nat_masquerade_ipv4
iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack
ip_tables x_tables arc4 rt2800usb rt2800lib rt2x00usb rt2x00lib crc_ccitt
mac80211 cfg80211 rfkill rtc_ds3232 hwmon i2c_dev i2c_bcm2835
[   24.810836] CPU: 0 PID: 140 Comm: ls Tainted: G        W       4.14.97+ #34
[   24.810842] Hardware name: BCM2835
[   24.810898] [<c0016218>] (unwind_backtrace) from [<c0013b48>]
(show_stack+0x20/0x24)
[   24.810937] [<c0013b48>] (show_stack) from [<c057b694>]
(dump_stack+0x20/0x28)
[   24.810967] [<c057b694>] (dump_stack) from [<c0021ef0>] (__warn+0xe4/0x10c)
[   24.810988] [<c0021ef0>] (__warn) from [<c0021fe4>]
(warn_slowpath_null+0x30/0x38)
[   24.811010] [<c0021fe4>] (warn_slowpath_null) from [<c027c974>]
(f2fs_is_valid_blkaddr+0x1d8/0x25c)
[   24.811043] [<c027c974>] (f2fs_is_valid_blkaddr) from [<c026af84>]
(f2fs_iget+0x764/0x1110)
[   24.811064] [<c026af84>] (f2fs_iget) from [<c026e6fc>]
(f2fs_lookup+0xd4/0x1cc)
[   24.811093] [<c026e6fc>] (f2fs_lookup) from [<c0168744>]
(lookup_slow+0x94/0x13c)
[   24.811113] [<c0168744>] (lookup_slow) from [<c0168fa4>]
(walk_component+0x1bc/0x2e8)
[   24.811134] [<c0168fa4>] (walk_component) from [<c016a9cc>]
(path_lookupat+0x8c/0x1f0)
[   24.811158] [<c016a9cc>] (path_lookupat) from [<c016d474>]
(filename_lookup+0xa0/0xfc)
[   24.811179] [<c016d474>] (filename_lookup) from [<c016d5bc>]
(user_path_at_empty+0x54/0x5c)
[   24.811197] [<c016d5bc>] (user_path_at_empty) from [<c0162974>]
(vfs_statx+0x68/0xbc)
[   24.811215] [<c0162974>] (vfs_statx) from [<c01631bc>]
(SyS_lstat64+0x38/0x58)
[   24.811236] [<c01631bc>] (SyS_lstat64) from [<c000fba0>]
(ret_fast_syscall+0x0/0x28)
[   24.811245] ---[ end trace c72216233c81afbe ]---

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
