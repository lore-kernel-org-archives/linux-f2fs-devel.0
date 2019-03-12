From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 202883] sometime dead lock in getdents64
Date: Tue, 12 Mar 2019 07:51:36 +0000
Message-ID: <bug-202883-202145-YlL7rqqGjD@https.bugzilla.kernel.org/>
References: <bug-202883-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1h3cCO-0006X5-6p
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Mar 2019 07:51:44 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h3cCM-00Baxw-Is
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Mar 2019 07:51:44 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id E841328F20
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 12 Mar 2019 07:51:36 +0000 (UTC)
In-Reply-To: <bug-202883-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=202883

Chao Yu (chao@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |ASSIGNED
                 CC|                            |chao@kernel.org

--- Comment #2 from Chao Yu (chao@kernel.org) ---
Hi Jiqun,

I just sent one patch for that, could you try the patch?

[PATCH] f2fs: fix to avoid deadlock in f2fs_read_inline_dir()

The solution is very similar to what we did in another patch as below,
we just take off the lock directly, since it's unneeded.

f2fs: no need to take page lock in readdir

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev-test&id=f3d42f6e5087a4b3a52ee4008734af93519dec06

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
