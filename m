From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 200951] kernel NULL pointer dereference in
 update_sit_entry
Date: Mon, 03 Sep 2018 01:27:12 +0000
Message-ID: <bug-200951-202145-lBDwBkpU1U@https.bugzilla.kernel.org/>
References: <bug-200951-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1fwdeB-0002Is-5x
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 03 Sep 2018 01:27:19 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fwde9-006hqB-Ar
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 03 Sep 2018 01:27:19 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 87337295A7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon,  3 Sep 2018 01:27:11 +0000 (UTC)
In-Reply-To: <bug-200951-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=200951

--- Comment #11 from Chao Yu (chao@kernel.org) ---
Actually, the problem here is during mount(),  both blk_queue_discard(q) and
f2fs_sb_has_blkzoned(sbi) return false, so f2fs will skip allocating memory for
se->discard_map.

static inline bool f2fs_discard_en(struct f2fs_sb_info *sbi)
{
        struct request_queue *q = bdev_get_queue(sbi->sb->s_bdev);

        return blk_queue_discard(q) || f2fs_sb_has_blkzoned(sbi);
}

[    4.372580] f2fs_discard_en(1):0
[    4.498957] f2fs_discard_en(2):0

But later, during update_sit_entiry(), f2fs_discard_en() return true, then it
will cause f2fs to update se->discard_map bitmap, result in panic.

[   56.939547] f2fs_discard_en(3):1 new_blkaddr:0xFFFF00000AB0383C
[   56.945027] f2fs_discard_en(5):1 se:0xFFFF8000ED285ED8


Is there any interface we can turn on discard of device in real time?

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
