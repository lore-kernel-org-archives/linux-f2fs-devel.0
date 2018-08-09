From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 200773] An issue was discovered in the Linux kernel
 through 4.17.3. There is a NULL pointer dereference in
 get_checkpoint_version() in fs/f2fs/checkpoint.c when mounting crafted f2fs
 image.
Date: Thu, 09 Aug 2018 15:19:07 +0000
Message-ID: <bug-200773-202145-44Sh5Wbnhh@https.bugzilla.kernel.org/>
References: <bug-200773-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1fnmiZ-0005Bi-Ab
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 09 Aug 2018 15:19:15 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fnmiX-00CVgl-Ak
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 09 Aug 2018 15:19:15 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id DCD2F2B4E2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  9 Aug 2018 15:19:06 +0000 (UTC)
In-Reply-To: <bug-200773-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=200773

Chao Yu (chao@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |chao@kernel.org

--- Comment #2 from Chao Yu (chao@kernel.org) ---
Hi Shuaibing,

I tried your attached image with last f2fs, it failed and below dmesg shown:

[ 3865.295211] F2FS-fs (loop0): Magic Mismatch, valid(0xf2f52010) -
read(0xf2f52090)
[ 3865.295236] F2FS-fs (loop0): Can't find valid F2FS filesystem in 1th
superblock
[ 3865.295277] F2FS-fs (loop0): Invalid segment/section count (14, 7 x 1)
[ 3865.295284] F2FS-fs (loop0): Can't find valid F2FS filesystem in 2th
superblock
[ 3865.295309] F2FS-fs (loop0): Magic Mismatch, valid(0xf2f52010) -
read(0xf2f52090)
[ 3865.295316] F2FS-fs (loop0): Can't find valid F2FS filesystem in 1th
superblock
[ 3865.295327] F2FS-fs (loop0): Invalid segment/section count (14, 7 x 1)
[ 3865.295333] F2FS-fs (loop0): Can't find valid F2FS filesystem in 2th
superblock


I tracked the code history, it seems that below commit can fix this issue, you
can update f2fs module with this commit and retry your case.


commit 0cfe75c5b011994651a4ca6d74f20aa997bfc69a
Author: Jaegeuk Kim <jaegeuk@kernel.org>
Date:   Fri Apr 27 19:03:22 2018 -0700

    f2fs: enhance sanity_check_raw_super() to avoid potential overflows

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0cfe75c5b011994651a4ca6d74f20aa997bfc69a

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
