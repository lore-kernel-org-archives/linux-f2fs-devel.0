From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 200951] kernel NULL pointer dereference in
 update_sit_entry
Date: Sat, 01 Sep 2018 12:54:28 +0000
Message-ID: <bug-200951-202145-MyXSXVAEUj@https.bugzilla.kernel.org/>
References: <bug-200951-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1fw5QB-00034E-5Q
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 01 Sep 2018 12:54:35 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fw5Q9-005DnF-Br
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 01 Sep 2018 12:54:35 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id B31F029D8B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat,  1 Sep 2018 12:54:27 +0000 (UTC)
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

--- Comment #5 from vicencb@gmail.com ---
Created attachment 278227
  --> https://bugzilla.kernel.org/attachment.cgi?id=278227&action=edit
fsck.f2fs

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
