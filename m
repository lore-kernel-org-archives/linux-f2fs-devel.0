From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 202709] Crafted image causes buffer overflow in
 read_inline_xattr
Date: Tue, 19 Mar 2019 14:09:18 +0000
Message-ID: <bug-202709-202145-druYzllu8l@https.bugzilla.kernel.org/>
References: <bug-202709-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1h6FQl-0006tK-6d
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 19 Mar 2019 14:09:27 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h6FQj-00Djkf-9J
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 19 Mar 2019 14:09:27 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 28E1A2881E
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 19 Mar 2019 14:09:19 +0000 (UTC)
In-Reply-To: <bug-202709-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=202709

Paul Bandha (bandha890@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|ASSIGNED                    |RESOLVED
         Resolution|---                         |CODE_FIX

--- Comment #2 from Paul Bandha (bandha890@gmail.com) ---
Thanks marking as resolved

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
