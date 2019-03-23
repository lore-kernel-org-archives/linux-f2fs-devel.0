From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 202989] [MSM-4.14] kernel panic during F2FS GC
Date: Sat, 23 Mar 2019 07:38:09 +0000
Message-ID: <bug-202989-202145-60eOUVPfED@https.bugzilla.kernel.org/>
References: <bug-202989-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1h7bEP-0002a0-Hw
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 23 Mar 2019 07:38:17 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h7bEO-004ym7-8g
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 23 Mar 2019 07:38:17 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 7A3BF2A711
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 23 Mar 2019 07:38:10 +0000 (UTC)
In-Reply-To: <bug-202989-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=202989

Chao Yu (chao@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
            Summary|kernel panic during F2FS GC |[MSM-4.14] kernel panic
                   |                            |during F2FS GC

--- Comment #7 from Chao Yu (chao@kernel.org) ---
I've changed this issue's title to indicate it is from private code repo.

Could you add to Cc below email address of qualcomm's guys, since maybe they
can provide some help.

stummala@codeaurora.org
riteshh@codeaurora.org

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
