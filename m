From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 203197] kernel read fault at __is_cp_guaranteed
Date: Wed, 10 Apr 2019 00:55:21 +0000
Message-ID: <bug-203197-202145-RqY67RzcJC@https.bugzilla.kernel.org/>
References: <bug-203197-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1hE1WU-0002US-E1
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 10 Apr 2019 00:55:30 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hE1WT-00Cr7v-6R
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 10 Apr 2019 00:55:30 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 72A3728998
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 10 Apr 2019 00:55:23 +0000 (UTC)
In-Reply-To: <bug-203197-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=203197

Chao Yu (chao@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |NEEDINFO

--- Comment #2 from Chao Yu (chao@kernel.org) ---
>From your kernel message, I only see we crashed at __rb_insert_augmented() or
vma_interval_tree_insert(), did you pick the wrong kernel message and incorrect
tmp.img and poc.c?

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
