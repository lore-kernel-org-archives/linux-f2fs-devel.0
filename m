From: Fan Li <fanofcode.li@samsung.com>
Subject: [PATCH] f2fs: optimize f2fs_write_cache_pages()
Date: Tue, 19 Jan 2016 13:38:17 +0800
Message-ID: <003b01d1527b$b35719e0$1a054da0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fanofcode.li@samsung.com>) id 1aLP0Z-0004y8-E6
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 19 Jan 2016 05:39:11 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aLP0X-0001Gg-G7
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 19 Jan 2016 05:39:11 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O16009K8QCR1SE0@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 19 Jan 2016 14:39:01 +0900 (KST)
Content-language: en-us
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

f2fs_write_cache_pages() writes cold/warm pages in different traverse to
make sure pages are written in continuous blocks.
There are three modifications in this patch:
1. If file is cold, all its pages are written in cold section. So don't
    distinguish the type of pages in such case.
2. f2fs_write_cache_pages() always writes cold pages first and then 
    warm pages.
    But it's rare that cold/warm pages both exist in mapping of the same
    file because of the policy of gc. So if there are only one type of
    pages, we only go through the mapping once.
3. If cycled is 0, the traverse will be separated into two parts if it
    reachs the end of mapping. In that case if there are warm pages in
    both parts, the second parts won't be handled correctly since step
    is already set to 1 for dealing the first part. So move the assignment
    of step after processing the second part.

I also found another two problems and describe them in comment
beginning with "FIXME". I tried to fix them, but my method is too complex,
so I mark it and hope someone else has better solution.

Signed-off-by: Fan li <fanofcode.li@samsung.com>
---
 fs/f2fs/data.c |   39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ac9e7c6..8dfdbf3 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1211,7 +1211,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 	int ret = 0;
 	int done = 0;
 	struct pagevec pvec;
-	int nr_pages;
+	int nr_pages, skipped_pages = 0;
 	pgoff_t uninitialized_var(writeback_index);
 	pgoff_t index;
 	pgoff_t end;		/* Inclusive */
@@ -1220,8 +1220,12 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 	int range_whole = 0;
 	int tag;
 	int step = 0;
+	int skip_type = -1;	/* which type of pages needs to be skipped */

 	pagevec_init(&pvec, 0);
+	/* no need to skip any page when file is cold */
+	if (file_is_cold(mapping->host))
+		skip_type = 2;
 next:
 	if (wbc->range_cyclic) {
 		writeback_index = mapping->writeback_index; /* prev offset */
@@ -1277,16 +1281,21 @@ continue_unlock:
 				goto continue_unlock;
 			}

-			if (step == is_cold_data(page))
-				goto continue_unlock;
-
 			if (PageWriteback(page)) {
-				if (wbc->sync_mode != WB_SYNC_NONE)
+				if (wbc->sync_mode != WB_SYNC_NONE &&
+					skip_type != is_cold_data(page))
 					f2fs_wait_on_page_writeback(page, DATA);
 				else
 					goto continue_unlock;
 			}

+			if (skip_type == -1) {
+				skip_type = !is_cold_data(page);
+			} else if (unlikely(skip_type == is_cold_data(page))) {
+				skipped_pages++;
+				goto continue_unlock;
+			}
+
 			BUG_ON(PageWriteback(page));
 			if (!clear_page_dirty_for_io(page))
 				goto continue_unlock;
@@ -1313,17 +1322,27 @@ continue_unlock:
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
 		end = writeback_index - 1;
 		goto retry;
 	}
+
+	/*
+	 * Retry when there are skipped pages.
+	 * FIXME: when done is 1, there may still be some
+	 * skipped pages, and will not be written.
+	 */
+	if (!done && !step && skipped_pages) {
+		skip_type = !skip_type;
+		step = 1;
+		goto next;
+	}
+	/*
+	 * FIXME: if step is 1, index of the last written page may
+	 * not indicate the end of range we searched.
+	 */
 	if (wbc->range_cyclic || (range_whole && wbc->nr_to_write > 0))
 		mapping->writeback_index = done_index;

--
1.7.9.5



------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
