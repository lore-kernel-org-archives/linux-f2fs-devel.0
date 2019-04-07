From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 203167] Kernel page fault with
 update_sit_entry+0x113/0x420
Date: Sun, 07 Apr 2019 09:55:53 +0000
Message-ID: <bug-203167-202145-ecvbN9KjDa@https.bugzilla.kernel.org/>
References: <bug-203167-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1hD4Ww-0003Xz-EU
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 07 Apr 2019 09:56:02 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hD4Wv-004FVj-22
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 07 Apr 2019 09:56:02 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 6F1C32872A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun,  7 Apr 2019 09:55:55 +0000 (UTC)
In-Reply-To: <bug-203167-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=203167

Chao Yu (chao@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |chao@kernel.org

--- Comment #1 from Chao Yu (chao@kernel.org) ---
Hello,

Could you please recompile f2fs.ko with CONFIG_F2FS_CHECK_FS enabled,
In my environment, all mounts failed due to valid block check under
CONFIG_F2FS_CHECK_FS.

Could you please confirm that, including images in all your issues.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
