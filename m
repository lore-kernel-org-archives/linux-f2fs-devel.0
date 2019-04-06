From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 203169] crash at fs/f2fs/checkpoint.c:160
 f2fs_is_valid_blkaddr
Date: Sat, 06 Apr 2019 01:53:35 +0000
Message-ID: <bug-203169-202145-bSc0QFy9B5@https.bugzilla.kernel.org/>
References: <bug-203169-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1hCaWf-0002XB-7T
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 06 Apr 2019 01:53:45 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hCaWd-003J6m-Tq
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 06 Apr 2019 01:53:45 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id D08AD28B8D
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat,  6 Apr 2019 01:53:36 +0000 (UTC)
In-Reply-To: <bug-203169-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=203169

Chao Yu (chao@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |chao@kernel.org

--- Comment #3 from Chao Yu (chao@kernel.org) ---
I don't think this is a bug.

[   44.217508] F2FS-fs (sdb): access invalid blkaddr:56
[   44.217529] WARNING: CPU: 0 PID: 1036 at fs/f2fs/checkpoint.c:160 

fs/f2fs/checkpoint.c:160

f2fs_is_valid_blkaddr() {
...
f2fs_msg(sbi->sb, KERN_WARNING, "access invalid blkaddr:%u", blkaddr);
WARN_ON(1);
...
}

BTW, with your image, I just hit below dmesg during mount:

[34996.986845] F2FS-fs (loop0): Invalid segment count (555819297)
[34996.986845] F2FS-fs (loop0): Can't find valid F2FS filesystem in 2th
superblock
[34996.991449] F2FS-fs (loop0): Mismatch valid blocks 0 vs. 12
[34996.991449] F2FS-fs (loop0): Failed to initialize F2FS segment manager

Are you sure, you attached the right image?

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
