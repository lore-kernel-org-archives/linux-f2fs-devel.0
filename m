From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 200871] F2FS experiences data loss (entry is
 completely lost) when an I/O failure occurs.
Date: Wed, 26 Sep 2018 09:45:45 +0000
Message-ID: <bug-200871-202145-7Pib4eYaQ8@https.bugzilla.kernel.org/>
References: <bug-200871-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1g56OH-0002Sy-9o
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 26 Sep 2018 09:45:53 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1g56OF-00BL2H-Al
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 26 Sep 2018 09:45:53 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id C686E2A6BF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 26 Sep 2018 09:45:44 +0000 (UTC)
In-Reply-To: <bug-200871-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=200871

--- Comment #14 from Chao Yu (chao@kernel.org) ---
(In reply to Stathis Maneas from comment #13)
> Indeed, I can tell what is the block address in which the updated inode is
> going to be stored using both dump.f2fs and the output of the SSA blocks.

OK, let me catch the address where inode block will update to, and try your
case again.

> 
> Then, the file system gets initialized from scratch before the operation is
> executed once again. Based on the file system's deterministic behaviour,
> when the operation is repeated, then the updated inode will eventually be
> stored into the same block.

In your case, once inode udpates, LBA of inode block will change to LBA+1.

We can record finial LBA of inode block locates in first round, then in next
round, we can inject error directly in fixed LBA.

> 
> Please let me know if my understanding is accurate.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
