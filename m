From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 200871] F2FS experiences data loss (entry is
 completely lost) when an I/O failure occurs.
Date: Fri, 31 Aug 2018 07:19:24 +0000
Message-ID: <bug-200871-202145-VwhyHqR8Hv@https.bugzilla.kernel.org/>
References: <bug-200871-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1fvdiN-00031O-QA
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 31 Aug 2018 07:19:31 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fvdiL-004Txl-OQ
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 31 Aug 2018 07:19:31 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id C92442B654
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 31 Aug 2018 07:19:23 +0000 (UTC)
In-Reply-To: <bug-200871-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=200871

--- Comment #3 from Chao Yu (chao@kernel.org) ---
Alright, can you please provider the complete testcase including error
injection script for me? I'd like to reproduce in my environment.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
