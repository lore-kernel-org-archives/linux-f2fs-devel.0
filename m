From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 200773] An issue was discovered in the Linux kernel
 through 4.17.3. There is a NULL pointer dereference in
 get_checkpoint_version() in fs/f2fs/checkpoint.c when mounting crafted f2fs
 image.
Date: Fri, 21 Sep 2018 01:44:32 +0000
Message-ID: <bug-200773-202145-OywdYnfs86@https.bugzilla.kernel.org/>
References: <bug-200773-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1g3AUs-0006GY-Gy
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 21 Sep 2018 01:44:42 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1g3AUn-00HKu9-Je
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 21 Sep 2018 01:44:42 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 09EBE2DFF6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 21 Sep 2018 01:44:32 +0000 (UTC)
In-Reply-To: <bug-200773-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=200773

Chao Yu (chao@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |datadancer@163.com

--- Comment #3 from Chao Yu (chao@kernel.org) ---
Hi Shuaibing,

Can you confirm this issue is fixed?

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
