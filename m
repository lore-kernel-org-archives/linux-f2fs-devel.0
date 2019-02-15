From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 202495] oops in fs/f2fs/checkpoint.c:150
 f2fs_is_valid_blkaddr
Date: Fri, 15 Feb 2019 08:28:07 +0000
Message-ID: <bug-202495-202145-k0Cx2GfrJi@https.bugzilla.kernel.org/>
References: <bug-202495-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1guYr4-0001B0-NV
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 Feb 2019 08:28:18 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1guYr3-00Glca-1V
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 Feb 2019 08:28:18 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 4082D2A998
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 15 Feb 2019 08:28:11 +0000 (UTC)
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

Chao Yu (chao@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |chao@kernel.org

--- Comment #1 from Chao Yu (chao@kernel.org) ---
Hi,

Do you pick up 4.14 kernel from AOSP, or just kernel.org? did you try fsck on
this image?

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
