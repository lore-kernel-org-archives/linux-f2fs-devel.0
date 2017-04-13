From: Raouf Rokhjavan <rokhjavan.r@gmail.com>
Subject: f2fs Crash Consistency Problem
Date: Thu, 13 Apr 2017 19:58:53 +0430
Message-ID: <d5ab8383-25f3-ffd6-c506-20993348c499@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rokhjavan.r@gmail.com>) id 1cyggC-0006eX-WD
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 13 Apr 2017 15:29:05 +0000
Received: from mail-wm0-f68.google.com ([74.125.82.68])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cyggA-0006pK-Jv
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 13 Apr 2017 15:29:04 +0000
Received: by mail-wm0-f68.google.com with SMTP id d79so13234874wmi.2
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Thu, 13 Apr 2017 08:29:02 -0700 (PDT)
Received: from desktopr.example.com ([5.75.219.34])
	by smtp.gmail.com with ESMTPSA id
	j138sm10979771wmg.10.2017.04.13.08.28.54
	for <linux-f2fs-devel@lists.sourceforge.net>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 13 Apr 2017 08:28:55 -0700 (PDT)
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

Hi

The Flash friendly features of f2fs has motivated me to make use of 
these characteristics as rootfs in my project. Since one of my main 
considerations is the resilience in the face of power failure, I've been 
looking for some techniques to prove this assertion. Finally, I ended up 
finding a wonderful device-mapper target, developed by Josef Bacik who 
is btrfs developer, for this purpose..

As you know, log-writes target logs all bios which are passed to the 
block layer and keeps the order of logging to simulate the file system 
logic of maintaining the consistency. To take advantage of this helpful 
tool to verify the consistency of f2fs file system after power failure, 
I combined xfstests test suite with log-writes. According to the LFS 
based nature of f2fs, I expected that I would never encounter with 
inconsistency problem, but test results shows something else.

To clarify further this notion, this is my test environment:

     - Fedora 24

     - kernel 4.9.8 - f2fs was compiled as module which all features

         - mount options: default + noatime

     - f2fs-tools 1.8.0

     - xfstests  1.1.1 - from https://github.com/jaegeuk/xfstests-f2fs

     - device-mapper 1.02.122

In my test environment, I run each generic test of xfstests on 
log-writes device with newly created f2fs. After that, I replay the log 
after the mkfs one by one and check the consistency of file system with 
fsck.f2fs. In test #009 which is fallocate test with 
FALLOC_FL_ZERO_RANGE mode, after a while, fsck.f2fs complains this:

Info: [/dev/sdc] Disk Model: VMware Virtual S1.0
Info: Segments per section = 1
Info: Sections per zone = 1
Info: sector size = 512
Info: total sectors = 2097152 (1024 MB)
Info: MKFS version
   "Linux version 4.9.8 (roraoof@desktopr.example.com) (gcc version 
4.8.5 20150623 (Red Hat 4.8.5-11) (GCC) ) #1 SMP Tue Feb 7 08:24:57 IRST 
2017"
Info: FSCK version
   from "Linux version 4.9.8 (roraoof@desktopr.example.com) (gcc version 
4.8.5 20150623 (Red Hat 4.8.5-11) (GCC) ) #1 SMP Tue Feb 7 08:24:57 IRST 
2017"
     to "Linux version 4.9.8 (roraoof@desktopr.example.com) (gcc version 
4.8.5 20150623 (Red Hat 4.8.5-11) (GCC) ) #1 SMP Tue Feb 7 08:24:57 IRST 
2017"
Info: superblock features = 0 :
Info: superblock encrypt level = 0, salt = 00000000000000000000000000000000
Info: total FS sectors = 2097152 (1024 MB)
Info: CKPT version = 2a4679e0
Info: checkpoint state = 45 :  compacted_summary unmount

NID[0x4c] is unreachable
NID[0x4d] is unreachable
[FSCK] Unreachable nat entries                        [Fail] [0x2]
[FSCK] SIT valid block bitmap checking                [Ok..]
[FSCK] Hard link checking for regular file            [Ok..] [0x0]
[FSCK] valid_block_count matching with CP             [Ok..] [0x2]
[FSCK] valid_node_count matcing with CP (de lookup)   [Ok..] [0x1]
[FSCK] valid_node_count matcing with CP (nat lookup)  [Fail] [0x3]
[FSCK] valid_inode_count matched with CP              [Ok..] [0x1]
[FSCK] free segment_count matched with CP             [Ok..] [0x1f0]
[FSCK] next block offset is free                      [Ok..]
[FSCK] fixing SIT types
[FSCK] other corrupted bugs                           [Fail]

Do you want to restore lost files into ./lost_found/? [Y/N] Y
  - File name         : 009.48244.2
  - File size         : 20,480 (bytes)
Do you want to fix this partition? [Y/N] Y

The interesting side of this is that when I issue fsck.f2fs with -p 
option, fsck.f2fs doesn't complain !!!

Would you please tell me why fsck.f2fs reports an inconsistency which 
needs to be fixed? Does it violate the crash consistency promise of f2fs?

Moreover, Why is fsck.f2fs silent with -p option? Does it mean whether 
f2fs kernel module finds it not serious?

I really appreciate for your help.

Thanks




------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
