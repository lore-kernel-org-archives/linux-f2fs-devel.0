From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: cover number of dirty node pages under
	node_write lock
Date: Tue, 15 Sep 2015 09:55:45 -0700
Message-ID: <1442336146-82492-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZbtWJ-0007PZ-Rq
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Sep 2015 16:55:51 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZbtWH-00013n-Dh for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Sep 2015 16:55:51 +0000
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

This number is referenced by checkpoint under node_write lock.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 27d1a74..4d9bedf 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1323,23 +1323,24 @@ static int f2fs_write_node_page(struct page *page,
 	nid = nid_of_node(page);
 	f2fs_bug_on(sbi, page->index != nid);
 
+	if (wbc->for_reclaim) {
+		if (!down_read_trylock(&sbi->node_write))
+			goto redirty_out;
+	} else {
+		down_read(&sbi->node_write);
+	}
+
 	get_node_info(sbi, nid, &ni);
 
 	/* This page is already truncated */
 	if (unlikely(ni.blk_addr == NULL_ADDR)) {
 		ClearPageUptodate(page);
 		dec_page_count(sbi, F2FS_DIRTY_NODES);
+		up_read(&sbi->node_write);
 		unlock_page(page);
 		return 0;
 	}
 
-	if (wbc->for_reclaim) {
-		if (!down_read_trylock(&sbi->node_write))
-			goto redirty_out;
-	} else {
-		down_read(&sbi->node_write);
-	}
-
 	set_page_writeback(page);
 	fio.blk_addr = ni.blk_addr;
 	write_node_page(nid, &fio);
-- 
2.1.1


------------------------------------------------------------------------------
