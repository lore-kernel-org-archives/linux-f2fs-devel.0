From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/2] f2fs: remove unnecessary wait in
 write_begin
Date: Fri, 17 Feb 2017 10:21:14 -0800
Message-ID: <20170217182114.GA2951@jaegeuk.local>
References: <20170217091639.29433-1-heyunlei@huawei.com>
	<20170217091639.29433-2-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cen9o-0006fw-TF
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 17 Feb 2017 18:21:24 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cen9m-00082T-CN
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 17 Feb 2017 18:21:24 +0000
Content-Disposition: inline
In-Reply-To: <20170217091639.29433-2-heyunlei@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlei He <heyunlei@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 02/17, Yunlei He wrote:
> It has already waited page stable in grab_cache_page_write_begin,
> so we remove this unnecessary wait.

I also got a deadlock in my perf test, and I wrote another patch to resolve it
by replacing grab_cache_page_write_begin() with pagecache_get_page().

>From 8baf724c638813ab8d2e9bad99f5b8683e788da3 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Fri, 17 Feb 2017 09:55:55 -0800
Subject: [PATCH] f2fs: do not wait for writeback in write_begin

Otherwise we can get livelock like below.

[79880.428136] dbench          D    0 18405  18404 0x00000000
[79880.428139] Call Trace:
[79880.428142]  __schedule+0x219/0x6b0
[79880.428144]  schedule+0x36/0x80
[79880.428147]  schedule_timeout+0x243/0x2e0
[79880.428152]  ? update_sd_lb_stats+0x16b/0x5f0
[79880.428155]  ? ktime_get+0x3c/0xb0
[79880.428157]  io_schedule_timeout+0xa6/0x110
[79880.428161]  __lock_page+0xf7/0x130
[79880.428164]  ? unlock_page+0x30/0x30
[79880.428167]  pagecache_get_page+0x16b/0x250
[79880.428171]  grab_cache_page_write_begin+0x20/0x40
[79880.428182]  f2fs_write_begin+0xa2/0xdb0 [f2fs]
[79880.428192]  ? f2fs_mark_inode_dirty_sync+0x16/0x30 [f2fs]
[79880.428197]  ? kmem_cache_free+0x79/0x200
[79880.428203]  ? __mark_inode_dirty+0x17f/0x360
[79880.428206]  generic_perform_write+0xbb/0x190
[79880.428213]  ? file_update_time+0xa4/0xf0
[79880.428217]  __generic_file_write_iter+0x19b/0x1e0
[79880.428226]  f2fs_file_write_iter+0x9c/0x180 [f2fs]
[79880.428231]  __vfs_write+0xc5/0x140
[79880.428235]  vfs_write+0xb2/0x1b0
[79880.428238]  SyS_write+0x46/0xa0
[79880.428242]  entry_SYSCALL_64_fastpath+0x1e/0xad

Fixes: cae96a5c8ab6 ("f2fs: check io submission more precisely")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8c61fa7fd27d..5f3bc98a387d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1759,7 +1759,12 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 			goto fail;
 	}
 repeat:
-	page = grab_cache_page_write_begin(mapping, index, flags);
+	/*
+	 * Do not use grab_cache_page_write_begin() to avoid deadlock due to
+	 * wait_for_stable_page. Will wait that below with our IO control.
+	 */
+	page = pagecache_get_page(mapping, index,
+				FGP_LOCK | FGP_WRITE | FGP_CREAT, GFP_NOFS);
 	if (!page) {
 		err = -ENOMEM;
 		goto fail;
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
