From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 203197] kernel read fault at __is_cp_guaranteed
Date: Tue, 09 Apr 2019 14:58:45 +0000
Message-ID: <bug-203197-202145-1CdizX7ADp@https.bugzilla.kernel.org/>
References: <bug-203197-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1hDsD7-0008D3-Gc
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Apr 2019 14:58:53 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hDsD6-009gqV-5w
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Apr 2019 14:58:53 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 9AF592094F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  9 Apr 2019 14:58:46 +0000 (UTC)
In-Reply-To: <bug-203197-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=203197

Chao Yu (chao@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |chao@kernel.org

--- Comment #1 from Chao Yu (chao@kernel.org) ---
I only got below info when reproducing this bug in 5.1-rc1 kernel.

[  258.605917] F2FS-fs (loop0): Mismatch start address, segment0(512)
cp_blkaddr(4293329408)
[  258.605917] F2FS-fs (loop0): Can't find valid F2FS filesystem in 2th
superblock
[  258.637909] F2FS-fs (loop0): Try to recover 2th superblock, ret: 0
[  258.637912] F2FS-fs (loop0): Mounted with checkpoint version = 7548c2d6
[  334.914699] F2FS-fs (loop0): sanity_check_inode: corrupted inode i_blocks
i_ino=7 iblocks=0, run fsck to fix.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
