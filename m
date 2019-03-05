From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 202747] sometime kernel crash when kzfree is called
 in fs/f2fs/xattr.c
Date: Tue, 05 Mar 2019 06:40:30 +0000
Message-ID: <bug-202747-202145-vOMSx4rC2N@https.bugzilla.kernel.org/>
References: <bug-202747-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1h13kk-0000B4-H1
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 05 Mar 2019 06:40:38 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h13ki-00Arb7-SB
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 05 Mar 2019 06:40:38 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 17A2C2B7F7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  5 Mar 2019 06:40:31 +0000 (UTC)
In-Reply-To: <bug-202747-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=202747

Chao Yu (chao@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |ASSIGNED
                 CC|                            |chao@kernel.org

--- Comment #1 from Chao Yu (chao@kernel.org) ---
I didn't see many filesystems are using kzfree(), instead, there are many
callers come from crypto module, I guess they use the buffer to store
ciphertext or crypto key temporarily, so, before freeing those buffer it will
be better to clean the data in buffer to avoid confidential data leak.

For f2fs, I think there is no such demand, and we just missed to change kzfree
to kvfree in below commit:

5222595d093e ("f2fs: use kvmalloc, if kmalloc is failed")

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
