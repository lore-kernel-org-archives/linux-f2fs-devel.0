From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: don't submit irrelevant page
Date: Thu, 29 Sep 2016 18:50:11 +0800
Message-ID: <20160929105011.103645-2-yuchao0@huawei.com>
References: <20160929105011.103645-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1bpYvL-0004Z0-Ju
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 29 Sep 2016 10:50:43 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1bpYvH-0000Kc-L4
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 29 Sep 2016 10:50:43 +0000
In-Reply-To: <20160929105011.103645-1-yuchao0@huawei.com>
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

While we call ->writepages, there are two cases:
a. we didn't writeout any dirty pages, since they are writebacked by other
thread concurrently.
b. we writeout dirty pages, and have already submitted bio to block layer.

In these cases, we don't need to do additional bio flushing unnecessarily,
it may split bio in cache into smaller one.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8b9a1dc..0d0177c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1355,6 +1355,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 	int cycled;
 	int range_whole = 0;
 	int tag;
+	int nwritten = 0;
 
 	pagevec_init(&pvec, 0);
 
@@ -1429,6 +1430,8 @@ continue_unlock:
 				done_index = page->index + 1;
 				done = 1;
 				break;
+			} else {
+				nwritten++;
 			}
 
 			if (--wbc->nr_to_write <= 0 &&
@@ -1450,6 +1453,10 @@ continue_unlock:
 	if (wbc->range_cyclic || (range_whole && wbc->nr_to_write > 0))
 		mapping->writeback_index = done_index;
 
+	if (nwritten)
+		f2fs_submit_merged_bio_cond(F2FS_M_SB(mapping), mapping->host,
+							NULL, 0, DATA, WRITE);
+
 	return ret;
 }
 
@@ -1491,7 +1498,6 @@ static int f2fs_write_data_pages(struct address_space *mapping,
 	 * if some pages were truncated, we cannot guarantee its mapping->host
 	 * to detect pending bios.
 	 */
-	f2fs_submit_merged_bio(sbi, DATA, WRITE);
 
 	remove_dirty_inode(inode);
 	return ret;
-- 
2.8.2.311.gee88674


------------------------------------------------------------------------------
