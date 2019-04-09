From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 203231] kernel BUG at fs/f2fs/segment.c:2079! and
 hangs on sync
Date: Tue, 09 Apr 2019 23:00:45 +0000
Message-ID: <bug-203231-202145-cTUggMBpGB@https.bugzilla.kernel.org/>
References: <bug-203231-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1hDzjZ-0006IA-Aa
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Apr 2019 23:00:53 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hDzjY-00Cg2H-1Y
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Apr 2019 23:00:53 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 682962896F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  9 Apr 2019 23:00:46 +0000 (UTC)
In-Reply-To: <bug-203231-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=203231

--- Comment #1 from Jungyeon (jungyeon@gatech.edu) ---
Created attachment 282235
  --> https://bugzilla.kernel.org/attachment.cgi?id=282235&action=edit
poc_12.c

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
