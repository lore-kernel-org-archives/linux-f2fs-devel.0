From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 200773] An issue was discovered in the Linux kernel
 through 4.17.3. There is a NULL pointer dereference in
 get_checkpoint_version() in fs/f2fs/checkpoint.c when mounting crafted f2fs
 image.
Date: Thu, 09 Aug 2018 09:03:36 +0000
Message-ID: <bug-200773-202145-ZQz5901zov@https.bugzilla.kernel.org/>
References: <bug-200773-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1fngrA-0005Xi-S3
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 09 Aug 2018 09:03:44 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fngr8-00CGHz-VA
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 09 Aug 2018 09:03:44 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id A84242AB09
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  9 Aug 2018 09:03:35 +0000 (UTC)
In-Reply-To: <bug-200773-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=200773

--- Comment #1 from Shuaibing Lu (datadancer@163.com) ---
-Location
https://elixir.bootlin.com/linux/v4.17.1/source/fs/f2fs/checkpoint.c#L741

        *cp_page = get_meta_page(sbi, cp_addr);
        *cp_block = (struct f2fs_checkpoint *)page_address(*cp_page);
Here cp_page may be NULL, and thus NULL pointer dereference triggered.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
