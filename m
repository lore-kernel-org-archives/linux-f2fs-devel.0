From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 203213] kernel BUG at fs/f2fs/f2fs.h:2012 and hangs
Date: Tue, 09 Apr 2019 20:30:00 +0000
Message-ID: <bug-203213-202145-ygo85CJsrz@https.bugzilla.kernel.org/>
References: <bug-203213-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1hDxNg-00064D-Ey
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Apr 2019 20:30:08 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hDxNe-00AG38-VR
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Apr 2019 20:30:08 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 53816285AA
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  9 Apr 2019 20:30:01 +0000 (UTC)
In-Reply-To: <bug-203213-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=203213

--- Comment #1 from Jungyeon (jungyeon@gatech.edu) ---
Created attachment 282207
  --> https://bugzilla.kernel.org/attachment.cgi?id=282207&action=edit
poc_03.c

I missed the program.
Please compile this before starting to reproduce, like below.

- Reproduces
cc poc_03.c
mkdir test
mount -t f2fs tmp.img test
cp a.out test
cd test
sudo ./a.out
sync

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
