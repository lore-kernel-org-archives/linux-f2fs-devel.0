From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 200635] Oops error in refresh_sit_entry() while
 unmounting a crafted F2FS image
Date: Sun, 26 Aug 2018 01:54:00 +0000
Message-ID: <bug-200635-202145-xArlskvARY@https.bugzilla.kernel.org/>
References: <bug-200635-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1ftkbJ-00019Y-Q2
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 26 Aug 2018 02:16:25 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1ftkFi-009hGm-3H
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 26 Aug 2018 01:54:07 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 69639297CE
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 26 Aug 2018 01:54:00 +0000 (UTC)
In-Reply-To: <bug-200635-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=200635

--- Comment #4 from Chao Yu (chao@kernel.org) ---
Thanks for reminding that, IMO, yes, after we enable superblock checksum
feature, we can know which sb is corrupted, and try to recovery corrupted sb
with another good one.

Although, for your case, I guess the only corrupted field is
f2fs_super_block.cp_payload, which should be 0 instead of 1, as it can be
correctly hinted from checkpoint package fields that are under checksum
protection already.

So, w/o sb checksum feature, do you wish that we can have a try with recovering
sb fields from checkpoint pack?

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
