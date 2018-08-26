From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 200423] Out-of-bound access in
 f2fs_get_dnode_of_data() when operating file on an f2fs image
Date: Sun, 26 Aug 2018 00:20:25 +0000
Message-ID: <bug-200423-202145-IBHdPbIFnB@https.bugzilla.kernel.org/>
References: <bug-200423-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1ftinC-0007Yx-GT
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 26 Aug 2018 00:20:34 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1ftinA-009dv9-KB
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 26 Aug 2018 00:20:34 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id EF16629F86
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 26 Aug 2018 00:20:26 +0000 (UTC)
In-Reply-To: <bug-200423-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=200423

Chao Yu (chao@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
                 CC|                            |chao@kernel.org
          Component|Other                       |f2fs
         Resolution|---                         |CODE_FIX
           Assignee|fs_other@kernel-bugs.osdl.o |linux-f2fs-devel@lists.sour
                   |rg                          |ceforge.net

--- Comment #4 from Chao Yu (chao@kernel.org) ---
After disableing CONFIG_F2FS_CHECK_FS and do retest, below dmesg was printed:

[ 2549.717979] F2FS-fs (loop0): Invalid log blocks per segment (8)
[ 2549.717987] F2FS-fs (loop0): Can't find valid F2FS filesystem in 2th
superblock
[ 2549.718721] F2FS-fs (loop0): invalid crc_offset: 30716
[ 2549.718729] F2FS-fs (loop0): Wrong cp_pack_start_sum: 4194305
[ 2549.718738] F2FS-fs (loop0): Failed to get valid F2FS checkpoint


So I think it has been fixed by below commit:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e494c2f995d6181d6e29c4927d68e0f295ecf75b

-- 
You are receiving this mail because:
You are the assignee for the bug.
------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
