From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 200951] kernel NULL pointer dereference in
 update_sit_entry
Date: Sun, 02 Sep 2018 16:49:16 +0000
Message-ID: <bug-200951-202145-x694FO6a5I@https.bugzilla.kernel.org/>
References: <bug-200951-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1fwVYz-0007S6-Jj
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 02 Sep 2018 16:49:25 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fwVYx-006OpG-WD
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 02 Sep 2018 16:49:25 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 9D5DE29661
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun,  2 Sep 2018 16:49:16 +0000 (UTC)
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

--- Comment #9 from vicencb@gmail.com ---
Created attachment 278243
  --> https://bugzilla.kernel.org/attachment.cgi?id=278243&action=edit
add some log (bis)

Hi, added a few more printk for extra verbosity.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
