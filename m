From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 3/6] f2fs: call f2fs_put_page at the error case
Date: Fri, 27 Dec 2013 13:00:17 +0900
Message-ID: <1388116820-15038-3-git-send-email-jaegeuk.kim@samsung.com>
References: <1388116820-15038-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1VwOcO-0008UH-Ld
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Dec 2013 04:01:48 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1VwOcM-0001CU-H6
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Dec 2013 04:01:48 +0000
Received: from epcpsbgr1.samsung.com
	(u141.gpu120.samsung.co.kr [203.254.230.141])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MYG004AQ5UMDID0@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Dec 2013 13:01:34 +0900 (KST)
In-reply-to: <1388116820-15038-1-git-send-email-jaegeuk.kim@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

In f2fs_write_begin(), if f2fs_conver_inline_data() returns an error like
-ENOSPC, f2fs should call f2fs_put_page().
Otherwise, it is remained as a locked page, resulting in the following bug.

[<ffffffff8114657e>] sleep_on_page+0xe/0x20
[<ffffffff81146567>] __lock_page+0x67/0x70
[<ffffffff81157d08>] truncate_inode_pages_range+0x368/0x5d0
[<ffffffff81157ff5>] truncate_inode_pages+0x15/0x20
[<ffffffff8115804b>] truncate_pagecache+0x4b/0x70
[<ffffffff81158082>] truncate_setsize+0x12/0x20
[<ffffffffa02a1842>] f2fs_setattr+0x72/0x270 [f2fs]
[<ffffffff811cdae3>] notify_change+0x213/0x400
[<ffffffff811ab376>] do_truncate+0x66/0xa0
[<ffffffff811ab541>] vfs_truncate+0x191/0x1b0
[<ffffffff811ab5bc>] do_sys_truncate+0x5c/0xa0
[<ffffffff811ab78e>] SyS_truncate+0xe/0x10
[<ffffffff81756052>] system_call_fastpath+0x16/0x1b
[<ffffffffffffffff>] 0xffffffffffffffff

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/data.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index bf39eed..253e663 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -916,8 +916,10 @@ repeat:
 			goto inline_data;
 	} else if (f2fs_has_inline_data(inode)) {
 		err = f2fs_convert_inline_data(inode, page, flags);
-		if (err)
+		if (err) {
+			f2fs_put_page(page, 1);
 			return err;
+		}
 	}
 
 	f2fs_lock_op(sbi);
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
