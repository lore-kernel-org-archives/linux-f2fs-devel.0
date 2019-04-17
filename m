From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 203167] Kernel page fault with
 update_sit_entry+0x113/0x420
Date: Wed, 17 Apr 2019 02:34:00 +0000
Message-ID: <bug-203167-202145-nDtY0EUndK@https.bugzilla.kernel.org/>
References: <bug-203167-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1hGaOn-0005yC-Gt
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Apr 2019 02:34:09 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hGaOm-00B1sW-9O
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Apr 2019 02:34:09 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 1A381289F0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 17 Apr 2019 02:34:01 +0000 (UTC)
In-Reply-To: <bug-203167-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=203167

Chao Yu (chao@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |ASSIGNED

--- Comment #3 from Chao Yu (chao@kernel.org) ---
I just enable valid block consistent check in check_block_count() by default,
which is enabled only CONFIG_F2FS_CHECK_FS is set previously.

f2fs: fix to do sanity check on valid block count of segment

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
