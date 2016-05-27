From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/4] f2fs: remove two steps to flush dirty data
	pages
Date: Thu, 26 May 2016 17:25:24 -0700
Message-ID: <1464308724-71070-4-git-send-email-jaegeuk@kernel.org>
References: <1464308724-71070-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1b65as-00034E-7Z
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 May 2016 00:25:38 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1b65ar-0003LW-IV
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 May 2016 00:25:38 +0000
In-Reply-To: <1464308724-71070-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

If there is no cold page, we don't need to do a loop to flush dirty
data pages.

On /dev/pmem0,

1. dd if=/dev/zero of=/mnt/test/testfile bs=1M count=2048 conv=fsync
 Before : 1.1 GB/s
 After  : 1.2 GB/s

2. dd if=/dev/zero of=/mnt/test/testfile bs=1M count=2048
 Before : 2.2 GB/s
 After  : 2.3 GB/s

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 85ceb2b..5dcd8db 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1326,10 +1326,9 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 	int cycled;
 	int range_whole = 0;
 	int tag;
-	int step = 0;
 
 	pagevec_init(&pvec, 0);
-next:
+
 	if (wbc->range_cyclic) {
 		writeback_index = mapping->writeback_index; /* prev offset */
 		index = writeback_index;
@@ -1384,9 +1383,6 @@ continue_unlock:
 				goto continue_unlock;
 			}
 
-			if (step == is_cold_data(page))
-				goto continue_unlock;
-
 			if (PageWriteback(page)) {
 				if (wbc->sync_mode != WB_SYNC_NONE)
 					f2fs_wait_on_page_writeback(page,
@@ -1421,11 +1417,6 @@ continue_unlock:
 		cond_resched();
 	}
 
-	if (step < 1) {
-		step++;
-		goto next;
-	}
-
 	if (!cycled && !done) {
 		cycled = 1;
 		index = 0;
-- 
2.6.3


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity 
planning reports. https://ad.doubleclick.net/ddm/clk/305295220;132659582;e
