From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 202495] oops in fs/f2fs/checkpoint.c:150
 f2fs_is_valid_blkaddr
Date: Mon, 18 Feb 2019 01:30:21 +0000
Message-ID: <bug-202495-202145-I3D9td7b29@https.bugzilla.kernel.org/>
References: <bug-202495-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1gvXlf-0004bi-GO
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 18 Feb 2019 01:30:47 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gvXlN-00DxM6-3r
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 18 Feb 2019 01:30:44 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id D85E829DC3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 18 Feb 2019 01:30:21 +0000 (UTC)
In-Reply-To: <bug-202495-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=202495

--- Comment #3 from Chao Yu (chao@kernel.org) ---
(In reply to JWalker from comment #2)
> Hi Chao,
> 
> The kernal code was taken from the raspberry pi git repo, and then the
> incremental patches applied.

What patches do you applied? some fixing patches?

> 
> Yes, fsck has been applied. Please see below the output of the both volumes.
> 
> Please let me know if you require any more info.

...

> [FSCK] Unreachable nat entries                        [Ok..] [0x0]
> [FSCK] SIT valid block bitmap checking                [Ok..]
> [FSCK] Hard link checking for regular file            [Ok..] [0x1]
> [FSCK] valid_block_count matching with CP             [Ok..] [0x87a0]
> [FSCK] valid_node_count matcing with CP (de lookup)   [Ok..] [0x107b]
> [FSCK] valid_node_count matcing with CP (nat lookup)  [Ok..] [0x107b]
> [FSCK] valid_inode_count matched with CP              [Ok..] [0x1073]
> [FSCK] free segment_count matched with CP             [Ok..] [0x296]
> [FSCK] next block offset is free                      [Ok..]
> [FSCK] fixing SIT types
> [FSCK] other corrupted bugs                           [Ok..]

I didn't see any corruption there, does this image still panic your kernel?

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
