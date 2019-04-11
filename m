From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 203197] kernel read fault at __is_cp_guaranteed
Date: Thu, 11 Apr 2019 01:03:23 +0000
Message-ID: <bug-203197-202145-cPYBQk3jHd@https.bugzilla.kernel.org/>
References: <bug-203197-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1hEO7n-0003J0-RX
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 11 Apr 2019 01:03:31 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hEO7m-00EhMn-Fm
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 11 Apr 2019 01:03:31 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 6714828BB6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 11 Apr 2019 01:03:24 +0000 (UTC)
In-Reply-To: <bug-203197-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=203197

--- Comment #3 from Jungyeon (jungyeon@gatech.edu) ---
I've tested with kernel version 5.0.0. 

The image and program is okay. It just seems that the errors are keeping
changing.. I also saw vma_interval_tree_insert() error. 
It's hard to say that when is the exact time that error comes out.

And, in 5.1-rc1 kernel, it seems that error doesn't show up.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
