From: Chao Yu <chao@kernel.org>
Subject: [PATCH 1/2] f2fs: fix to commit bio cache after flushing
	node pages
Date: Tue, 27 Sep 2016 00:09:52 +0800
Message-ID: <1474906193-6487-1-git-send-email-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1boYVk-0004He-TP
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 26 Sep 2016 16:12:08 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1boYVj-0002i4-T6
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 26 Sep 2016 16:12:08 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

In sync_node_pages, we won't check and commit last merged pages in private
bio cache of f2fs, as these pages were taged as writeback, someone who is
waiting for writebacking of the page will be blocked until the cache was
committed by someone else.

We need to commit node type bio cache to avoid potential deadlock or long
delay of waiting writeback.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/node.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 9faddcd..f73f774 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1416,6 +1416,7 @@ int sync_node_pages(struct f2fs_sb_info *sbi, struct writeback_control *wbc)
 	struct pagevec pvec;
 	int step = 0;
 	int nwritten = 0;
+	int ret = 0;
 
 	pagevec_init(&pvec, 0);
 
@@ -1436,7 +1437,8 @@ next_step:
 
 			if (unlikely(f2fs_cp_error(sbi))) {
 				pagevec_release(&pvec);
-				return -EIO;
+				ret = -EIO;
+				goto out;
 			}
 
 			/*
@@ -1487,6 +1489,8 @@ continue_unlock:
 
 			if (NODE_MAPPING(sbi)->a_ops->writepage(page, wbc))
 				unlock_page(page);
+			else
+				nwritten++;
 
 			if (--wbc->nr_to_write == 0)
 				break;
@@ -1504,7 +1508,10 @@ continue_unlock:
 		step++;
 		goto next_step;
 	}
-	return nwritten;
+out:
+	if (nwritten)
+		f2fs_submit_merged_bio(sbi, NODE, WRITE);
+	return ret;
 }
 
 int wait_on_node_pages_writeback(struct f2fs_sb_info *sbi, nid_t ino)
-- 
2.7.2


------------------------------------------------------------------------------
