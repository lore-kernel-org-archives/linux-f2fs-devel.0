From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 201555] [f2fs] Processes freezing periodically with
 f2fs root
Date: Mon, 05 Nov 2018 03:33:43 +0000
Message-ID: <bug-201555-202145-fSbuIJ67rL@https.bugzilla.kernel.org/>
References: <bug-201555-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1gJVeQ-00024l-Ha
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 05 Nov 2018 03:34:06 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gJVeB-001ZaN-JG
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 05 Nov 2018 03:34:06 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 6245128BE1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon,  5 Nov 2018 03:33:43 +0000 (UTC)
In-Reply-To: <bug-201555-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=201555

Chao Yu (chao@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |ASSIGNED

--- Comment #6 from Chao Yu (chao@kernel.org) ---
(In reply to Pierpaolo Valerio from comment #5)
> So, my office PC is still up after more than 5 days, so I'm assuming the
> problem is either solved or greatly reduced.

I guess below two commits may fix potential deadlock issue:

1) Revert: "f2fs: check last page index in cached bio to decide submission"
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bab475c5414e8d1fa182fd17ae966864e9c85741

2) f2fs: submit cached bio to avoid endless PageWriteback
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=48018b4cfd07dd2df9a067fb3a6a3221c19eed11

I think you can just merge them to stable kernel with the specified version as
you wish, and then have a try.

> When can I expect to see the changes merged? Will it be in a point release

It has been merged into Linux 4.20-rc1, maybe that can be your option if you
don't want to wait 4.20 about 2 months bug fixing iteration.

> or should I wait for 4.20?
> Thanks a lot.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
