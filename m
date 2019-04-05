From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 203165] Kernel panic - not syncing: corrupted stack
 end detected inside scheduler
Date: Fri, 05 Apr 2019 23:11:00 +0000
Message-ID: <bug-203165-202145-sqUxLJ9uQI@https.bugzilla.kernel.org/>
References: <bug-203165-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1hCXzJ-0004R4-3e
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 05 Apr 2019 23:11:09 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hCXzH-003X8d-CX
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 05 Apr 2019 23:11:09 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 6D39028B35
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  5 Apr 2019 23:11:01 +0000 (UTC)
In-Reply-To: <bug-203165-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=203165

--- Comment #1 from Jungyeon (jungyeon@gatech.edu) ---
Created attachment 282149
  --> https://bugzilla.kernel.org/attachment.cgi?id=282149&action=edit
The (compressed) crafted image which causes crash

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
