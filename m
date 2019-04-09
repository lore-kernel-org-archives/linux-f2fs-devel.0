From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 203235] kernel BUG at fs/f2fs/segment.c:2131! and
 hangs on sync
Date: Tue, 09 Apr 2019 23:32:50 +0000
Message-ID: <bug-203235-202145-96ykp32nCe@https.bugzilla.kernel.org/>
References: <bug-203235-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1hE0Ec-0001U4-Dc
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Apr 2019 23:32:58 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hE0Eb-00CE4i-45
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Apr 2019 23:32:58 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 2A44F288AA
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  9 Apr 2019 23:32:51 +0000 (UTC)
In-Reply-To: <bug-203235-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=203235

--- Comment #1 from Jungyeon (jungyeon@gatech.edu) ---
Created attachment 282243
  --> https://bugzilla.kernel.org/attachment.cgi?id=282243&action=edit
poc_14.c

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
