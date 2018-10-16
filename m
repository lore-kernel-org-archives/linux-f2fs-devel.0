From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 200871] F2FS experiences data loss (entry is
 completely lost) when an I/O failure occurs.
Date: Tue, 16 Oct 2018 01:48:46 +0000
Message-ID: <bug-200871-202145-gTbdXbAbx6@https.bugzilla.kernel.org/>
References: <bug-200871-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1gCETg-0005aY-75
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 16 Oct 2018 01:48:56 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gCETc-002Pj1-Uh
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 16 Oct 2018 01:48:56 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id BADB6299C2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 16 Oct 2018 01:48:45 +0000 (UTC)
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

--- Comment #17 from Chao Yu (chao@kernel.org) ---
(In reply to Stathis Maneas from comment #16)
> I am sorry for the delay! I can definitely help by adding the aforementioned
> statements!
> 
> After adding them and observing the output of dmesg, I can observe that only
> the second statement gets actually invoked:
> [ 1026.438986] f2fs_wait_on_node_pages_writeback, eio:0
> 
> Therefore, this indicates that the following condition is not true under the
> specified workload:
> if (unlikely(bio->bi_status)) { ... }
> 
> I tried moving the first print statement at the beginning of the following
> for loop,
> bio_for_each_segment_all(bvec, bio, i) { ... }
> 
> but still, I am not observing any errors for the segment (block) of interest:
> [   76.603891] f2fs_write_end_io, ino:1, idx:4, eio:0, type:7
> [   76.603893] f2fs_write_end_io, is_dummy:0 bio_status:0

Sorry for the delay.

Oh, so I guess that you trigger the error injection but didn't set
bio->bi_status to nonzero value, result in fs can not be aware of that.

I think we'd better to double check all your test steps and injection codes.

> 
> Is there something else we can try?

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
