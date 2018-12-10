From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 201911] High frequency of gc cause application
 database corrupt
Date: Mon, 10 Dec 2018 02:55:32 +0000
Message-ID: <bug-201911-202145-5jkmqb4rwE@https.bugzilla.kernel.org/>
References: <bug-201911-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1gWBjS-0004Sa-0H
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 10 Dec 2018 02:55:42 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gWBjQ-008gm7-A0
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 10 Dec 2018 02:55:41 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 0F80629EB5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 10 Dec 2018 02:55:33 +0000 (UTC)
In-Reply-To: <bug-201911-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=201911

Chao Yu (chao@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |chao@kernel.org

--- Comment #1 from Chao Yu (chao@kernel.org) ---
Sounds like that the problem was caused by GC, so could you merge below two
commits and retry the test?

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-stable.git/commit/?h=linux-4.9.y&id=1d8aac3a98acaeb102083074b67da08ec9e9d440

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-stable.git/commit/?h=linux-4.9.y&id=787485b8082e2271a01fab6f0bf267680e381bac

Or in order to make sure whether there is the same issue in last 4.9 version
kernel of AOSP, it will be better to use last f2fs codes in below branch:

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-stable.git/log/?h=linux-4.9.y

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
