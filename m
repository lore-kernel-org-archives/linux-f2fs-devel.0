From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 202495] oops in fs/f2fs/checkpoint.c:150
 f2fs_is_valid_blkaddr
Date: Mon, 18 Mar 2019 23:26:26 +0000
Message-ID: <bug-202495-202145-yX9VfHKwLl@https.bugzilla.kernel.org/>
References: <bug-202495-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1h61eN-0000Uw-66
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 18 Mar 2019 23:26:35 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h61eL-006wPA-Gq
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 18 Mar 2019 23:26:35 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 1440B29537
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 18 Mar 2019 23:26:27 +0000 (UTC)
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

phiber2000@gmx.de changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |phiber2000@gmx.de

--- Comment #5 from phiber2000@gmx.de ---
The issue was observed in the kernel version 4.14.98 an is still present in
4.14.106.
We successfully backported a commit of Chao Yu from 4.19 to resolve the issue.
Maybe it should be considered to be done here in the kernel.org upstream, too.
Further information: https://github.com/raspberrypi/linux/issues/2894

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
