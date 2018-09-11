From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 200951] kernel NULL pointer dereference in
 update_sit_entry
Date: Tue, 11 Sep 2018 03:15:03 +0000
Message-ID: <bug-200951-202145-0kiIIRIi25@https.bugzilla.kernel.org/>
References: <bug-200951-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1fzZ90-00040o-Bz
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 11 Sep 2018 03:15:14 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fzZ8y-00E4Ef-K9
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 11 Sep 2018 03:15:14 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id B1A4128F64
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 11 Sep 2018 03:15:02 +0000 (UTC)
In-Reply-To: <bug-200951-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=200951

Chao Yu (chao@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--- Comment #18 from Chao Yu (chao@kernel.org) ---
This issue has been fixed with patch listed in below link, so I tag this issue
as resolved one.

https://sourceforge.net/p/linux-f2fs/mailman/message/36407519/

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
