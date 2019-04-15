From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 203221] kernel BUG at fs/f2fs/node.c:1279!
Date: Mon, 15 Apr 2019 14:52:18 +0000
Message-ID: <bug-203221-202145-KayKQt8YMw@https.bugzilla.kernel.org/>
References: <bug-203221-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1hG2yA-0006vp-62
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 15 Apr 2019 14:52:26 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hG2y8-0088au-RD
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 15 Apr 2019 14:52:26 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 30BD22890C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 15 Apr 2019 14:52:19 +0000 (UTC)
In-Reply-To: <bug-203221-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=203221

Chao Yu (chao@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |ASSIGNED
                 CC|                            |chao@kernel.org

--- Comment #2 from Chao Yu (chao@kernel.org) ---
Fixed with

f2fs: fix to do checksum even if inode page is uptodate

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
