From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 202889] fsync on inode fails to persist its size,
 which is changed by pwrite
Date: Wed, 13 Mar 2019 03:09:17 +0000
Message-ID: <bug-202889-202145-EYrVIByOvD@https.bugzilla.kernel.org/>
References: <bug-202889-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1h3uGj-0007JX-Mg
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 13 Mar 2019 03:09:25 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h3uGi-008aow-2B
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 13 Mar 2019 03:09:25 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 5CB68295C6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 13 Mar 2019 03:09:18 +0000 (UTC)
In-Reply-To: <bug-202889-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=202889

--- Comment #4 from Chao Yu (chao@kernel.org) ---
I checked attachment, but error paths of all syscall still didn't be handled
well?

I doubt the last pwrite64 or fsync failed, actually, it's rare.
Otherwise, I suspect there is a bug when we handle FI_AUTO_RECOVER case,
in where we handle i_size with a tricky way.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
