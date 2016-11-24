From: k@vodka.home.kg
Subject: fsck is broken on mips32 platform
Date: Fri, 25 Nov 2016 01:30:35 +0300
Message-ID: <56969233.20161125013035@vodka.home.kg>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <k@vodka.home.kg>) id 1cA2nl-0002J6-Tj
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Nov 2016 22:47:33 +0000
Received: from mail.kotidze.in ([91.92.66.82])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cA2nk-0002fZ-Hc
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Nov 2016 22:47:33 +0000
Received: from private.domain by mail.kotidze.in with [XMail 1.27 ESMTP Server]
	id <S1BA0> for <linux-f2fs-devel@lists.sourceforge.net> from
	<k@vodka.home.kg>; Fri, 25 Nov 2016 01:30:38 +0300
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

Hi !

I'm using f2fs on router Dlink dir-825 with openwrt/LEDE firmware.
Its mips32 rel 2 big endian cpu.

mkfs.f2fs - works
mount - works
fsck.f2fs - corrupts filesystem

# i'm  trying  to fsck valid empty mountable f2fs partition i have just mkfs'ed
fsck.f2fs /dev/sda2
Info: Segments per section = 1
Info: Sections per zone = 1
Info: sector size = 512
Info: total sectors = 6508544 (3178 MB)
Info: MKFS version
  "Linux version 4.4.0-21-generic (buildd@lgw01-21) (gcc version 5.3.1 20160413 (Ubuntu 5.3.1-14ubuntu2) ) #37-Ubuntu SMP Mon Apr 18 18:33:37 UTC 2016"
Info: FSCK version
  from "Linux version 4.4.0-21-generic (buildd@lgw01-21) (gcc version 5.3.1 20160413 (Ubuntu 5.3.1-14ubuntu2) ) #37-Ubuntu SMP Mon Apr 18 18:33:37 UTC 2016"
    to "Linux version 4.4.30 (vasya@nowhere) (gcc version 5.4.0 (LEDE GCC 5.4.0 r2084) ) #0 PREEMPT Thu Nov 3 07:34:38 2016"
Info: superblock features = 0 : 
Info: superblock encrypt level = 0, salt = 00000000000000000000000000000000
Info: total FS sectors = 6508544 (3178 MB)
Info: CKPT version = 1
Info: checkpoint state = 5 :  compacted_summary unmount
[ASSERT] (sanity_check_nid: 356)  --> nid is not valid. [0x3]

NID[0x3] is unreachable
[FSCK] Unreachable nat entries                        [Fail] [0x1]
[FSCK] SIT valid block bitmap checking                [Fail]
[FSCK] Hard link checking for regular file            [Ok..] [0x0]
[FSCK] valid_block_count matching with CP             [Fail] [0x0]
[FSCK] valid_node_count matcing with CP (de lookup)   [Fail] [0x0]
[FSCK] valid_node_count matcing with CP (nat lookup)  [Ok..] [0x1]
[FSCK] valid_inode_count matched with CP              [Fail] [0x0]
[FSCK] free segment_count matched with CP             [Fail] [0x621]
[FSCK] next block offset is free                      [Ok..]
[FSCK] fixing SIT types
[FSCK] other corrupted bugs                           [Fail]
[FIX] (nullify_nat_entry:1688)  --> Remove nid [0x3] in nat journal

After failed mount attempt :

dmesg
F2FS-fs (sda2): Failed to read root inode

On x86 and ARM everything is ok

f2fs-tools 1.7.0
kernel 4.4.30


------------------------------------------------------------------------------
