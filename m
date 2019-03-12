From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 202889] fsync on inode fails to persist its size,
 which is changed by pwrite
Date: Tue, 12 Mar 2019 20:59:54 +0000
Message-ID: <bug-202889-202145-CPZCXMZoJv@https.bugzilla.kernel.org/>
References: <bug-202889-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1h3oVK-0006Wa-49
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Mar 2019 21:00:06 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h3oVG-00DAWC-Q7
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Mar 2019 21:00:06 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 5C58A288D8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 12 Mar 2019 20:59:55 +0000 (UTC)
In-Reply-To: <bug-202889-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=202889

Seulbae Kim (seulbae@gatech.edu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
            Summary|fsync on file fails to      |fsync on inode fails to
                   |persist its size, which is  |persist its size, which is
                   |changed by pwrite           |changed by pwrite

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
