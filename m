From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 200465] null ptr dereference in
 fscrypt_do_page_crypto() when operating a file on a corrupted f2fs image
Date: Thu, 13 Sep 2018 18:48:15 +0000
Message-ID: <bug-200465-202145-qBuFS5wDEE@https.bugzilla.kernel.org/>
References: <bug-200465-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1g0Wf8-0003YT-LX
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 13 Sep 2018 18:48:22 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1g0Wf6-00G1Ti-Fg
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 13 Sep 2018 18:48:22 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id C1AA22B130
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 13 Sep 2018 18:48:14 +0000 (UTC)
In-Reply-To: <bug-200465-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=200465

Steve Beattie (sbeattie@ubuntu.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |sbeattie@ubuntu.com

--- Comment #2 from Steve Beattie (sbeattie@ubuntu.com) ---
This was assigned CVE-2018-14616 (see
https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-14616).

Chao, is it correct that the fix for this issue landed as
https://git.kernel.org/linus/91291e9998d208370eb8156c760691b873bd7522 ? Or are
additional fixes needed?

Thanks!

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
