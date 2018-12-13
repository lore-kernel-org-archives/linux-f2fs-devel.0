From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 201911] High frequency of gc cause application
 database corrupt
Date: Thu, 13 Dec 2018 03:42:23 +0000
Message-ID: <bug-201911-202145-RUWhOo2Qr4@https.bugzilla.kernel.org/>
References: <bug-201911-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1gXHtO-00086F-29
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 13 Dec 2018 03:42:30 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gXHtM-00EUU9-E8
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 13 Dec 2018 03:42:30 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id A86372BC13
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 13 Dec 2018 03:42:22 +0000 (UTC)
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

Jaegeuk Kim (jaegeuk@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jaegeuk@kernel.org

--- Comment #3 from Jaegeuk Kim (jaegeuk@kernel.org) ---
I suspect it's caused by HW encryption.

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-stable.git/commit/?h=linux-4.9.y&id=3d571474ab517bc05cd79e91735861c7e7918681

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=9bf1a3f73927492c8be127b642197125e9d52be8

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
