From: Chao Yu <chao@kernel.org>
Subject: [PATCH 2/2] f2fs: detect synchronous writeback more
 earlier
Date: Wed, 23 May 2018 22:25:09 +0800
Message-ID: <20180523142509.17905-2-chao@kernel.org>
References: <20180523142509.17905-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1fLUhr-0007O2-5a
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 23 May 2018 14:25:35 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fLUhk-00EGis-2m
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 23 May 2018 14:25:35 +0000
In-Reply-To: <20180523142509.17905-1-chao@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
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

This patch changes to detect synchronous writeback more earlier before,
in order to avoid unnecessary page writeback before exiting asynchronous
writeback.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index feb4c224b305..91cbf20b448a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1919,6 +1919,13 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 			struct page *page = pvec.pages[i];
 			bool submitted = false;
 
+			/* give a priority to WB_SYNC threads */
+			if (atomic_read(&F2FS_M_SB(mapping)->wb_sync_req) &&
+					wbc->sync_mode == WB_SYNC_NONE) {
+				done = 1;
+				break;
+			}
+
 			done_index = page->index;
 retry_write:
 			lock_page(page);
@@ -1973,9 +1980,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 				last_idx = page->index;
 			}
 
-			/* give a priority to WB_SYNC threads */
-			if ((atomic_read(&F2FS_M_SB(mapping)->wb_sync_req) ||
-					--wbc->nr_to_write <= 0) &&
+			if (--wbc->nr_to_write <= 0 &&
 					wbc->sync_mode == WB_SYNC_NONE) {
 				done = 1;
 				break;
-- 
2.16.2.17.g38e79b1fd


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
