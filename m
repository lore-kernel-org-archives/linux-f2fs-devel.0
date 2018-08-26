From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 200871] F2FS experiences data loss (entry is
 completely lost) when an I/O failure occurs.
Date: Sun, 26 Aug 2018 09:09:48 +0000
Message-ID: <bug-200871-202145-AWBDR0Eobp@https.bugzilla.kernel.org/>
References: <bug-200871-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1ftr3T-0000GG-Sr
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 26 Aug 2018 09:09:55 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1ftr3R-00FPrP-Op
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 26 Aug 2018 09:09:55 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 1B09C29BC4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 26 Aug 2018 09:09:48 +0000 (UTC)
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

Chao Yu (chao@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |ASSIGNED

--- Comment #1 from Chao Yu (chao@kernel.org) ---
I think there are two problems:

1. you made IO error, and return the error to upper, but fsync() didn't fail.

To reproduce this:
a) I add below code in f2fs_write_end_io, and use fault_injection to simulate
error under block layer:

        if (time_to_inject(F2FS_P_SB(bio_first_page_all(bio)), FAULT_IO)) {
                f2fs_show_injection_info(FAULT_IO);
                bio->bi_status = BLK_STS_IOERR;
        }

b) xfs_io -f /mnt/f2fs/file -c "pwrite 0 4k" -c "fsync"
fsync: Input/output error

This is because, in f2fs_write_end_io(), if error is injected, -EIO will be set
into node inode's page mapping as below:
                if (unlikely(bio->bi_status)) {
                        mapping_set_error(page->mapping, -EIO);
                        if (type == F2FS_WB_CP_DATA)
                                f2fs_stop_checkpoint(sbi, true);
                }
And later filemap_check_errors() in f2fs_sync_file() will capture such error,
and propagate it to user.

So how you inject error in bio? by fail_make_request?

2. image became inconsistent, so that we can index node block of inlien_file,
but could not read detail info of it due to the node block is corrupted.

"inconsistent node block, nid:4,
node_footer[nid:0,ino:0,ofs:0,cpver:0,blkaddr:0]"

I think this is related to first problem.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
