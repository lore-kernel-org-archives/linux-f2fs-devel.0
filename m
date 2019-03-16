From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 202747] sometime kernel crash when kzfree is called
 in fs/f2fs/xattr.c
Date: Sat, 16 Mar 2019 08:09:22 +0000
Message-ID: <bug-202747-202145-URbu607Els@https.bugzilla.kernel.org/>
References: <bug-202747-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1h54Nm-000237-1a
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 16 Mar 2019 08:09:30 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h54Nk-000Jfj-F9
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 16 Mar 2019 08:09:29 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id C07CC28D14
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 16 Mar 2019 08:09:22 +0000 (UTC)
In-Reply-To: <bug-202747-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=202747

Chao Yu (chao@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|ASSIGNED                    |RESOLVED
         Resolution|---                         |CODE_FIX

--- Comment #2 from Chao Yu (chao@kernel.org) ---
The fixing patch has been merged, close this issue.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2a6a7e722e7a78d774ce02b847c5b183a3ff2672

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
