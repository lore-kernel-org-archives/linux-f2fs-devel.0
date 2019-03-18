From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 202749] f2fs: possibly fail to pageout because
 PagePrivate is set without increasing page count in .set_page_dirty()
Date: Mon, 18 Mar 2019 08:25:53 +0000
Message-ID: <bug-202749-202145-MwLRyvdDBB@https.bugzilla.kernel.org/>
References: <bug-202749-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1h5nas-0008It-7n
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 18 Mar 2019 08:26:02 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h5naq-00A3rX-Dq
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 18 Mar 2019 08:26:01 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id C873B2919F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 18 Mar 2019 08:25:53 +0000 (UTC)
In-Reply-To: <bug-202749-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=202749

Gao Xiang (hsiangkao@aol.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--- Comment #1 from Gao Xiang (hsiangkao@aol.com) ---
mark as fixed.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
