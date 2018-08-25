From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 200183] Divide zero in reset_curseg() when mounting
 a crafted f2fs image
Date: Sat, 25 Aug 2018 23:31:12 +0000
Message-ID: <bug-200183-202145-r8hCMfwAlE@https.bugzilla.kernel.org/>
References: <bug-200183-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1fti1X-0006b3-62
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 25 Aug 2018 23:31:19 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fti1V-00F651-Hh
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 25 Aug 2018 23:31:19 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id B50162A1C0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 25 Aug 2018 23:31:11 +0000 (UTC)
In-Reply-To: <bug-200183-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=200183

Chao Yu (chao@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
                 CC|                            |chao@kernel.org
          Component|Other                       |f2fs
         Resolution|---                         |CODE_FIX
           Assignee|fs_other@kernel-bugs.osdl.o |linux-f2fs-devel@lists.sour
                   |rg                          |ceforge.net

--- Comment #1 from Chao Yu (chao@kernel.org) ---
Fixed by below commit:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=42bf546c1fe3f3654bdf914e977acbc2b80a5be5

-- 
You are receiving this mail because:
You are the assignee for the bug.
------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
