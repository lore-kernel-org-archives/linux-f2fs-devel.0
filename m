From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 200871] F2FS experiences data loss (entry is
 completely lost) when an I/O failure occurs.
Date: Sun, 26 Aug 2018 23:43:23 +0000
Message-ID: <bug-200871-202145-Ve7lJpu59R@https.bugzilla.kernel.org/>
References: <bug-200871-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1fu4gt-0008Cl-NL
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 26 Aug 2018 23:43:31 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fu4gr-00F6zZ-SV
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 26 Aug 2018 23:43:31 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 666C229755
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 26 Aug 2018 23:43:23 +0000 (UTC)
In-Reply-To: <bug-200871-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=200871

--- Comment #2 from Stathis Maneas (smaneas@cs.toronto.edu) ---
1. I am using a device mapper module similar to the existing dm-flakey module:
https://elixir.bootlin.com/linux/v4.18/source/drivers/md/dm-flakey.c

Specifically, an error is introduced to an I/O operation in the same way as
implemented by the dm-flakey module
(https://elixir.bootlin.com/linux/v4.18/source/drivers/md/dm-flakey.c#L348):
...
else if (test_bit(ERROR_WRITES, &fc->flags)) {
        bio_io_error(bio);
        return DM_MAPIO_SUBMITTED;
}
...

In this case, fsync is not able to capture the error and returns as if no error
has taken place.

Here, I would like to mention that using this mechanism to introduce errors
when ext4 is used as the underlying file system, results in fsync returning an
error.

2. Indeed, the problem here is that the corresponding NAT table entry points to
an inode that has never been persisted on disk. However, since fsync does not
report an error, someone would hope that the entry would be there.

Moreover, the problem here is worse, because after invoking fsck, the entry
completely disappears from the file system and cannot be restored in any way.

Had fsync returned with an error, the user would have known that the operation
has failed and thus, they would not have excepted any modifications to have
taken place.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
