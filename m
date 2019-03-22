From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 202989] kernel panic during F2FS GC
Date: Fri, 22 Mar 2019 09:02:01 +0000
Message-ID: <bug-202989-202145-PxiH2o3HQV@https.bugzilla.kernel.org/>
References: <bug-202989-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1h7G46-0006tn-Kf
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 22 Mar 2019 09:02:14 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h7G40-0036E7-3o
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 22 Mar 2019 09:02:14 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 66A192A5FE
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 22 Mar 2019 09:02:02 +0000 (UTC)
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

Chao Yu (chao@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |NEEDINFO

--- Comment #3 from Chao Yu (chao@kernel.org) ---
(In reply to Lianjun Huang from comment #2)
> (In reply to Chao Yu from comment #1)
> > Could you list related kernel source code link address? and please use last
> > fsck.f2fs to check whether image was corrupted.
> 
> I am sorry but there is no public URL for the source code. The kernel

Oops, at least please pasting related source code at below places:
- f2fs_submit_page_bio()
- /ap/kernel/msm-4.14/fs/f2fs/segment.h:654

BTW, it will be hard for me to figure out the root cause if there is any other
private modification in your 4.14.81 kernel, such as Qualcomm's inline
encryption...

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
