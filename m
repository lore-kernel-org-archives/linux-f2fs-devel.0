From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 202495] oops in fs/f2fs/checkpoint.c:150
 f2fs_is_valid_blkaddr
Date: Fri, 15 Feb 2019 18:54:04 +0000
Message-ID: <bug-202495-202145-vVRcRUtZyb@https.bugzilla.kernel.org/>
References: <bug-202495-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1guicy-000709-Bn
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 Feb 2019 18:54:24 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1guicl-009QVr-CG
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 Feb 2019 18:54:18 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 473782B95A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 15 Feb 2019 18:54:03 +0000 (UTC)
In-Reply-To: <bug-202495-202145@https.bugzilla.kernel.org/>
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

--- Comment #2 from JWalker (jw7779@gmail.com) ---
Hi Chao,

The kernal code was taken from the raspberry pi git repo, and then the
incremental patches applied.

Yes, fsck has been applied. Please see below the output of the both volumes.

Please let me know if you require any more info.

Regards

John

sudo fsck -t f2fs /dev/sdc3
fsck from util-linux 2.31.1
Info: [/dev/sdc3] Disk Model: USB3.0 CRW   -SD1.00
Info: Segments per section = 1
Info: Sections per zone = 1
Info: sector size = 512
Info: total sectors = 4194304 (2048 MB)
Info: MKFS version
  "Linux version 4.13.0-43-generic (buildd@lgw01-amd64-041) (gcc
version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.9))
#48~16.04.1-Ubuntu SMP Thu May 17 13:00:11 UTC 2018"
Info: FSCK version
  from "Linux version 4.15.0-43-generic (buildd@lgw01-amd64-001) (gcc
version 7.3.0 (Ubuntu 7.3.0-16ubuntu3)) #46-Ubuntu SMP Thu Dec 6
14:45:28 UTC 2018"
    to "Linux version 4.15.0-45-generic (buildd@lgw01-amd64-031) (gcc
version 7.3.0 (Ubuntu 7.3.0-16ubuntu3)) #48-Ubuntu SMP Tue Jan 29
16:28:13 UTC 2019"
Info: superblock features = 0 :
Info: superblock encrypt level = 0, salt = 00000000000000000000000000000000
Info: total FS sectors = 4194304 (2048 MB)
Info: CKPT version = 15a2c
Info: checkpoint state = 41 :  crc unmount

[FSCK] Unreachable nat entries                        [Ok..] [0x0]
[FSCK] SIT valid block bitmap checking                [Ok..]
[FSCK] Hard link checking for regular file            [Ok..] [0x1]
[FSCK] valid_block_count matching with CP             [Ok..] [0x87a0]
[FSCK] valid_node_count matcing with CP (de lookup)   [Ok..] [0x107b]
[FSCK] valid_node_count matcing with CP (nat lookup)  [Ok..] [0x107b]
[FSCK] valid_inode_count matched with CP              [Ok..] [0x1073]
[FSCK] free segment_count matched with CP             [Ok..] [0x296]
[FSCK] next block offset is free                      [Ok..]
[FSCK] fixing SIT types
[FSCK] other corrupted bugs                           [Ok..]

Done.
sudo fsck -t f2fs /dev/sdc4
fsck from util-linux 2.31.1
Info: [/dev/sdc4] Disk Model: USB3.0 CRW   -SD1.00
Info: Segments per section = 1
Info: Sections per zone = 1
Info: sector size = 512
Info: total sectors = 3055616 (1492 MB)
Info: MKFS version
  "Linux version 4.13.0-43-generic (buildd@lgw01-amd64-041) (gcc
version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.9))
#48~16.04.1-Ubuntu SMP Thu May 17 13:00:11 UTC 2018"
Info: FSCK version
  from "Linux version 4.15.0-43-generic (buildd@lgw01-amd64-001) (gcc
version 7.3.0 (Ubuntu 7.3.0-16ubuntu3)) #46-Ubuntu SMP Thu Dec 6
14:45:28 UTC 2018"
    to "Linux version 4.15.0-45-generic (buildd@lgw01-amd64-031) (gcc
version 7.3.0 (Ubuntu 7.3.0-16ubuntu3)) #48-Ubuntu SMP Tue Jan 29
16:28:13 UTC 2019"
Info: superblock features = 0 :
Info: superblock encrypt level = 0, salt = 00000000000000000000000000000000
Info: total FS sectors = 3055616 (1492 MB)
Info: CKPT version = b
Info: checkpoint state = 45 :  crc compacted_summary unmount

[FSCK] Unreachable nat entries                        [Ok..] [0x0]
[FSCK] SIT valid block bitmap checking                [Ok..]
[FSCK] Hard link checking for regular file            [Ok..] [0x0]
[FSCK] valid_block_count matching with CP             [Ok..] [0x2]
[FSCK] valid_node_count matcing with CP (de lookup)   [Ok..] [0x1]
[FSCK] valid_node_count matcing with CP (nat lookup)  [Ok..] [0x1]
[FSCK] valid_inode_count matched with CP              [Ok..] [0x1]
[FSCK] free segment_count matched with CP             [Ok..] [0x2d9]
[FSCK] next block offset is free                      [Ok..]
[FSCK] fixing SIT types
[FSCK] other corrupted bugs                           [Ok..]

Done.

On Fri, 15 Feb 2019 at 08:28, <bugzilla-daemon@bugzilla.kernel.org> wrote:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=202495
>
> Chao Yu (chao@kernel.org) changed:
>
>            What    |Removed                     |Added
> ----------------------------------------------------------------------------
>                  CC|                            |chao@kernel.org
>
> --- Comment #1 from Chao Yu (chao@kernel.org) ---
> Hi,
>
> Do you pick up 4.14 kernel from AOSP, or just kernel.org? did you try fsck on
> this image?
>
> --
> You are receiving this mail because:
> You reported the bug.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
