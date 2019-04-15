From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 203215] failure at
 fs/f2fs/f2fs.h:2809/verify_blkaddr()!
Date: Mon, 15 Apr 2019 14:56:57 +0000
Message-ID: <bug-203215-202145-xD97OqCHG8@https.bugzilla.kernel.org/>
References: <bug-203215-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1hG32e-00014W-AT
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 15 Apr 2019 14:57:04 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hG32d-007bl2-4C
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 15 Apr 2019 14:57:04 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 86FB9285E3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 15 Apr 2019 14:56:57 +0000 (UTC)
In-Reply-To: <bug-203215-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=203215

Chao Yu (chao@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |ASSIGNED
                 CC|                            |chao@kernel.org

--- Comment #1 from Chao Yu (chao@kernel.org) ---
Fixed with

f2fs: introduce DATA_GENERIC_ENHANCE

And please try this patch with your below issue list:

https://bugzilla.kernel.org/show_bug.cgi?id=203223
https://bugzilla.kernel.org/show_bug.cgi?id=203231
https://bugzilla.kernel.org/show_bug.cgi?id=203235
https://bugzilla.kernel.org/show_bug.cgi?id=203241

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
