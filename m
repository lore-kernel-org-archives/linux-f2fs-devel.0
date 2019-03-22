From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 202989] kernel panic during F2FS GC
Date: Fri, 22 Mar 2019 09:24:43 +0000
Message-ID: <bug-202989-202145-t8IjzPD9dF@https.bugzilla.kernel.org/>
References: <bug-202989-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1h7GPy-0007qZ-PN
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 22 Mar 2019 09:24:50 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h7GPx-00G4jx-9S
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 22 Mar 2019 09:24:50 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 9C0792A3BF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 22 Mar 2019 09:24:43 +0000 (UTC)
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

--- Comment #4 from Lianjun Huang (hlianjun@gmail.com) ---
Created attachment 281961
  --> https://bugzilla.kernel.org/attachment.cgi?id=281961&action=edit
f2fs_submit_page_bio and  the file segment.h

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
