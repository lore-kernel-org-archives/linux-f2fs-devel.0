From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: fix to commit bio cache after flushing
	node pages
Date: Thu, 29 Sep 2016 18:50:10 +0800
Message-ID: <20160929105011.103645-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1bpYvL-0006Ut-2i
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 29 Sep 2016 10:50:43 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1bpYvH-0000Kb-LD
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 29 Sep 2016 10:50:43 +0000
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
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

In sync_node_pages, we won't check and commit last merged pages in private
bio cache of f2fs, as these pages were taged as writeback, someone who is
waiting for writebacking of the page will be blocked until the cache was
committed by someone else.

We need to commit node type bio cache to avoid potential deadlock or long
delay of waiting writeback.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/node.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 9faddcd..8831035 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1312,6 +1312,7 @@ int fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 	struct page *last_page = NULL;
 	bool marked = false;
 	nid_t ino = inode->i_ino;
+	int nwritten = 0;
 
 	if (atomic) {
 		last_page = last_fsync_dnode(sbi, ino);
@@ -1385,7 +1386,10 @@ continue_unlock:
 				unlock_page(page);
 				f2fs_put_page(last_page, 0);
 				break;
+			} else {
+				nwritten++;
 			}
+
 			if (page == last_page) {
 				f2fs_put_page(page, 0);
 				marked = true;
@@ -1407,6 +1411,9 @@ continue_unlock:
 		unlock_page(last_page);
 		goto retry;
 	}
+
+	if (nwritten)
+		f2fs_submit_merged_bio_cond(sbi, NULL, NULL, ino, NODE, WRITE);
 	return ret ? -EIO: 0;
 }
 
@@ -1416,6 +1423,7 @@ int sync_node_pages(struct f2fs_sb_info *sbi, struct writeback_control *wbc)
 	struct pagevec pvec;
 	int step = 0;
 	int nwritten = 0;
+	int ret = 0;
 
 	pagevec_init(&pvec, 0);
 
@@ -1436,7 +1444,8 @@ next_step:
 
 			if (unlikely(f2fs_cp_error(sbi))) {
 				pagevec_release(&pvec);
-				return -EIO;
+				ret = -EIO;
+				goto out;
 			}
 
 			/*
@@ -1487,6 +1496,8 @@ continue_unlock:
 
 			if (NODE_MAPPING(sbi)->a_ops->writepage(page, wbc))
 				unlock_page(page);
+			else
+				nwritten++;
 
 			if (--wbc->nr_to_write == 0)
 				break;
@@ -1504,7 +1515,10 @@ continue_unlock:
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
2.8.2.311.gee88674


------------------------------------------------------------------------------
