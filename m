From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 202637] Chmod'ed directory permission is not
 persisted with fsync
Date: Tue, 26 Feb 2019 08:40:00 +0000
Message-ID: <bug-202637-202145-qBuQU93GQv@https.bugzilla.kernel.org/>
References: <bug-202637-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1gyYHW-0002pE-2N
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 26 Feb 2019 08:40:06 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gyYHU-00Gn2d-H2
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 26 Feb 2019 08:40:06 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 9BA482A503
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 26 Feb 2019 08:39:58 +0000 (UTC)
In-Reply-To: <bug-202637-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=202637

--- Comment #3 from Chao Yu (chao@kernel.org) ---
Thanks for the quick test. :)

I've also sent a patch to simulate your testcase for fstest suit, you can find
it in below link:

https://sourceforge.net/p/linux-f2fs/mailman/linux-f2fs-devel/thread/20190226070302.17756-1-yuchao0%40huawei.com/#msg36597256

Once the kernel fix patch is merged in upstream, I will close this issue.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
