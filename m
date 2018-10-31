From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 201555] [f2fs] Processes freezing periodically with
 f2fs root
Date: Wed, 31 Oct 2018 08:02:07 +0000
Message-ID: <bug-201555-202145-S2FinkOkHY@https.bugzilla.kernel.org/>
References: <bug-201555-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1gHlSC-0007nM-Bv
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 31 Oct 2018 08:02:16 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gHlSA-003UfY-JI
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 31 Oct 2018 08:02:16 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 3450729FDE
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 31 Oct 2018 08:02:07 +0000 (UTC)
In-Reply-To: <bug-201555-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=201555

--- Comment #2 from Pierpaolo Valerio (gondsman@techgeek.co.in) ---
I'll try the dev branch as soon as I get the time to do it. I can attach the
full dmesg I got a few days ago for the time being.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
