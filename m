From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 203861] New: Division by zero error in fsck.f2fs
 when fixing a corrupted image
Date: Mon, 10 Jun 2019 18:17:12 +0000
Message-ID: <bug-203861-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1haOrE-0004Dl-8w
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 10 Jun 2019 18:17:24 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1haOrD-006RNF-GA
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 10 Jun 2019 18:17:24 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 3BA1F28613
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 10 Jun 2019 18:17:14 +0000 (UTC)
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

https://bugzilla.kernel.org/show_bug.cgi?id=203861

            Bug ID: 203861
           Summary: Division by zero error in fsck.f2fs when fixing a
                    corrupted image
           Product: File System
           Version: 2.5
    Kernel Version: v4.18
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: f2fs
          Assignee: filesystem_f2fs@kernel-bugs.kernel.org
          Reporter: seulbae@gatech.edu
        Regression: No

Created attachment 283179
  --> https://bugzilla.kernel.org/attachment.cgi?id=283179&action=edit
Corrupted f2fs image (compressed)

[Overview]
fsck.f2fs of f2fs-tools (master at commit 54244dcafd) triggers a division by
zero error while fixing a corrupted image, in which segs->secs_per_zone is set
to 0.

[Reproduction]
Download and uncompress the attached image.
Run fsck.f2fs against the downloaded image:
$ cd path/to/f2fs-tools/
$ ./fsck/fsck.f2fs -d 0 -f /tmp/f2fs.img
Info: Force to fix corruption
Info: Segments per section = 1
Info: Sections per zone = 1
Info: sector size = 512
Info: total sectors = 131072 (64 MB)
Info: MKFS version
  "Linux version 4.13.0-45-generic (buildd@lgw01-amd64-011) (gcc version 5.4.0
20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.9)) #50~16.04.1-Ubuntu SMP Wed May 30
11:18:27 UTC 2018"
Info: FSCK version
  from "Linux version 4.13.0-45-generic (buildd@lgw01-amd64-011) (gcc version
5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.9)) #50~16.04.1-Ubuntu SMP Wed May
30 11:18:27 UTC 2018"
    to "Linux version 4.18.0-21-generic (buildd@lcy01-amd64-006) (gcc version
7.3.0 (Ubuntu 7.3.0-16ubuntu3)) #22~18.04.1-Ubuntu SMP Thu May 16 15:07:19 UTC
2019"
[update_superblock: 503] Info: Done to update superblock
Info: superblock features = 0 : 
Info: superblock encrypt level = 0, salt = 00000000000000000000000000000000
Info: total FS sectors = 131072 (64 MB)
Info: CKPT version = 3
[1]    13488 floating point exception (core dumped)  ./fsck/fsck.f2fs -f
/tmp/f2fs.img

[Location]
- build_curseg at fsck/mount.c:1589
  1589  array[i].zone = GET_ZONENO_FROM_SEGNO(sbi, segno);
- GET_ZONENO_FROM_SEGNO(sbi, segno) at fsck/f2fs.h:317
  318 ((segno / sbi->segs_per_sec) / sbi->secs_per_zone)
Causes division by zero error when sbi->secs_per_zone is corrupted to be 0.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
