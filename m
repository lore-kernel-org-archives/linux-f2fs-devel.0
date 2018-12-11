From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 201911] High frequency of gc cause application
 database corrupt
Date: Tue, 11 Dec 2018 01:14:37 +0000
Message-ID: <bug-201911-202145-hd7rop6m3m@https.bugzilla.kernel.org/>
References: <bug-201911-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1gWWdI-0006oN-BB
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 11 Dec 2018 01:14:44 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gWWdG-00AM8k-HD
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 11 Dec 2018 01:14:44 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id C0A022A1A1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 11 Dec 2018 01:14:36 +0000 (UTC)
In-Reply-To: <bug-201911-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=201911

--- Comment #2 from liushuanglin (liu_shuang_lin@163.com) ---
Hi, Yu, 

Tried two patches you mentioned, still reproduced this issue.

will try latest f2fs codes.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
