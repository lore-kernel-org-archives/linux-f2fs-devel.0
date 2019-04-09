From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 203167] Kernel page fault with
 update_sit_entry+0x113/0x420
Date: Tue, 09 Apr 2019 15:48:03 +0000
Message-ID: <bug-203167-202145-WU7xZ99EeC@https.bugzilla.kernel.org/>
References: <bug-203167-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1hDsys-00077s-8m
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Apr 2019 15:48:14 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hDsyq-00BVS5-Tp
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Apr 2019 15:48:14 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id EDFC728818
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  9 Apr 2019 15:48:03 +0000 (UTC)
In-Reply-To: <bug-203167-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=203167

--- Comment #2 from Jungyeon (jungyeon@gatech.edu) ---
I checked with CONFIG_F2FS_CHECK_FS option on, and it shows that f2fs mount
errors not crashing.

However, CONFIG_F2FS_CHECK_FS is not enabled by default, and I guess that there
is a high possibility that many people using f2fs would not enable this options
cause it says that it could make the performance slower.
It seems that this is a problem of robustness. I think that file system should
not crash all the time, with or without special options.

I would appreciate that you could give me your opinion.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
