From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 200635] Oops error in refresh_sit_entry() while
 unmounting a crafted F2FS image
Date: Wed, 05 Sep 2018 16:44:46 +0000
Message-ID: <bug-200635-202145-Fd1qLvQr0K@https.bugzilla.kernel.org/>
References: <bug-200635-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1fxavI-0003l0-2v
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 05 Sep 2018 16:44:56 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fxavE-001yO9-Jd
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 05 Sep 2018 16:44:55 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id EA7A42928D
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  5 Sep 2018 16:44:46 +0000 (UTC)
In-Reply-To: <bug-200635-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=200635

Stathis Maneas (smaneas@cs.toronto.edu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|REOPENED                    |RESOLVED
         Resolution|---                         |CODE_FIX

--- Comment #7 from Stathis Maneas (smaneas@cs.toronto.edu) ---
I can verify that the latter patch is able to resolved the error and thus, I am
marking the issue as resolved.

Thanks a lot!

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
