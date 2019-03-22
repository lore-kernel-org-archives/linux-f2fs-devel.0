From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 202989] kernel panic during F2FS GC
Date: Fri, 22 Mar 2019 04:08:46 +0000
Message-ID: <bug-202989-202145-P50hjbbzEt@https.bugzilla.kernel.org/>
References: <bug-202989-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1h7BUF-0001lg-4u
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 22 Mar 2019 04:08:55 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h7BUD-0029rf-Pc
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 22 Mar 2019 04:08:55 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 01C2B2A571
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 22 Mar 2019 04:08:47 +0000 (UTC)
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

--- Comment #2 from Lianjun Huang (hlianjun@gmail.com) ---
(In reply to Chao Yu from comment #1)
> Could you list related kernel source code link address? and please use last
> fsck.f2fs to check whether image was corrupted.

I am sorry but there is no public URL for the source code. The kernel version
is 4.14.81. I will check the image later.

I would like to clarify that kernel panic are from two different machines. And
both new_blkaddr and old_blkaddr of fio are 0xFFFFFFFF.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
