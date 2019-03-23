From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 202989] kernel panic during F2FS GC
Date: Sat, 23 Mar 2019 02:51:21 +0000
Message-ID: <bug-202989-202145-KAQaEpg01q@https.bugzilla.kernel.org/>
References: <bug-202989-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1h7Wkt-0008Ae-Sy
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 23 Mar 2019 02:51:31 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h7Wkq-004ymv-6y
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 23 Mar 2019 02:51:29 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 8F4952A1AD
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 23 Mar 2019 02:51:21 +0000 (UTC)
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

--- Comment #6 from Chao Yu (chao@kernel.org) ---
> I would like to clarify that kernel panic are from two different machines.
> And both new_blkaddr and old_blkaddr of fio are 0xFFFFFFFF.

Okay, so that we need to add log to track block address return from
f2fs_allocate_data_block(). If it allocates 0xffffffff, should kernel panic in
update_sit_entry() in prior to f2fs_submit_page_bio()?

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
