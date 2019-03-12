From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 202883] sometime dead lock in getdents64
Date: Tue, 12 Mar 2019 06:53:05 +0000
Message-ID: <bug-202883-202145-2GtIYdaOX4@https.bugzilla.kernel.org/>
References: <bug-202883-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1h3bHl-00080S-Eu
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Mar 2019 06:53:13 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h3bHj-005QG0-JS
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Mar 2019 06:53:13 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id EBB832945F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 12 Mar 2019 06:53:05 +0000 (UTC)
In-Reply-To: <bug-202883-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=202883

--- Comment #1 from Jiqun Li (jiqun.li@unisoc.com) ---
for task 9709, do_page_fault() is triggered by  __put_user_unaligned() in
compat_filldir64(). 

static int compat_filldir64(struct dir_context *ctx, const char *name,
                            int namlen, loff_t offset, u64 ino,
                            unsigned int d_type)
{
        .....
        if (dirent) {
                if (__put_user_unaligned(offset, &dirent->d_off))
                        goto efault;
        }


dirent is a local array[] in user space, when want to access dirent->d_off,
do_page_fault() is triggered and want to alloc real memory.

dirent is a valid user space address

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
