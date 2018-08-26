From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 200465] null ptr dereference in
 fscrypt_do_page_crypto() when operating a file on a corrupted f2fs image
Date: Sun, 26 Aug 2018 00:56:29 +0000
Message-ID: <bug-200465-202145-MuT6cpR4PM@https.bugzilla.kernel.org/>
References: <bug-200465-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1ftkWp-0001Ia-Rb
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 26 Aug 2018 02:11:47 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1ftjM4-00EHF9-I9
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 26 Aug 2018 00:56:38 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id ED3AE29D13
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 26 Aug 2018 00:56:29 +0000 (UTC)
In-Reply-To: <bug-200465-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=200465

Chao Yu (chao@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |ASSIGNED
                 CC|                            |chao@kernel.org
          Component|Other                       |f2fs
           Assignee|fs_other@kernel-bugs.osdl.o |filesystem_f2fs@kernel-bugs
                   |rg                          |.kernel.org

--- Comment #1 from Chao Yu (chao@kernel.org) ---
Wen Xu,

I didn't see encryption feature is on in uploaded image, but actually, our
stack is stuck in decrypting flow, could you check the image again?

Info: superblock features = 0 :

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
