From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: submit node page write bios when
	really required
Date: Fri, 11 Mar 2016 16:14:36 -0800
Message-ID: <1457741677-67046-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aeXCh-0003Vu-Nv
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 12 Mar 2016 00:14:47 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aeXCg-0000Nb-0t
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 12 Mar 2016 00:14:47 +0000
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

If many threads calls fsync with data writes, we don't need to flush every
bios having node page writes.
The f2fs_wait_on_page_writeback will flush its bios when the page is really
needed.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 771166d..118321b 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1236,7 +1236,7 @@ int sync_node_pages(struct f2fs_sb_info *sbi, nid_t ino,
 	pgoff_t index, end;
 	struct pagevec pvec;
 	int step = ino ? 2 : 0;
-	int nwritten = 0, wrote = 0;
+	int nwritten = 0;
 
 	pagevec_init(&pvec, 0);
 
@@ -1326,8 +1326,6 @@ continue_unlock:
 
 			if (NODE_MAPPING(sbi)->a_ops->writepage(page, wbc))
 				unlock_page(page);
-			else
-				wrote++;
 
 			if (--wbc->nr_to_write == 0)
 				break;
@@ -1345,14 +1343,6 @@ continue_unlock:
 		step++;
 		goto next_step;
 	}
-
-	if (wrote) {
-		if (ino)
-			f2fs_submit_merged_bio_cond(sbi, NULL, NULL,
-							ino, NODE, WRITE);
-		else
-			f2fs_submit_merged_bio(sbi, NODE, WRITE);
-	}
 	return nwritten;
 }
 
-- 
2.6.3


------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785111&iu=/4140
