From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] Revert "f2fs: introduce
 f2fs_set_page_dirty_nobuffer"
Date: Fri, 20 Apr 2018 21:08:25 -0700
Message-ID: <20180421040825.77660-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1f9jpD-0007OD-KM
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 21 Apr 2018 04:08:35 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f9jpC-005drt-7x
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 21 Apr 2018 04:08:35 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch reverts copied f2fs_set_page_dirty_nobuffer to use generic function
for stability.

This reverts commit fe76b796fc5194cc3d57265002e3a748566d073f.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c |  2 +-
 fs/f2fs/data.c       | 33 +--------------------------------
 fs/f2fs/f2fs.h       |  1 -
 fs/f2fs/node.c       |  2 +-
 4 files changed, 3 insertions(+), 35 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 2e23b953d304..8fc55d42ba25 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -384,7 +384,7 @@ static int f2fs_set_meta_page_dirty(struct page *page)
 	if (!PageUptodate(page))
 		SetPageUptodate(page);
 	if (!PageDirty(page)) {
-		f2fs_set_page_dirty_nobuffers(page);
+		__set_page_dirty_nobuffers(page);
 		inc_page_count(F2FS_P_SB(page), F2FS_DIRTY_META);
 		SetPagePrivate(page);
 		f2fs_trace_pid(page);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d32bf363cb60..5477fc09c3cd 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -19,8 +19,6 @@
 #include <linux/bio.h>
 #include <linux/prefetch.h>
 #include <linux/uio.h>
-#include <linux/mm.h>
-#include <linux/memcontrol.h>
 #include <linux/cleancache.h>
 #include <linux/sched/signal.h>
 
@@ -2471,35 +2469,6 @@ int f2fs_release_page(struct page *page, gfp_t wait)
 	return 1;
 }
 
-/*
- * This was copied from __set_page_dirty_buffers which gives higher performance
- * in very high speed storages. (e.g., pmem)
- */
-void f2fs_set_page_dirty_nobuffers(struct page *page)
-{
-	struct address_space *mapping = page->mapping;
-	unsigned long flags;
-
-	if (unlikely(!mapping))
-		return;
-
-	spin_lock(&mapping->private_lock);
-	lock_page_memcg(page);
-	SetPageDirty(page);
-	spin_unlock(&mapping->private_lock);
-
-	xa_lock_irqsave(&mapping->i_pages, flags);
-	WARN_ON_ONCE(!PageUptodate(page));
-	account_page_dirtied(page, mapping);
-	radix_tree_tag_set(&mapping->i_pages,
-			page_index(page), PAGECACHE_TAG_DIRTY);
-	xa_unlock_irqrestore(&mapping->i_pages, flags);
-	unlock_page_memcg(page);
-
-	__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
-	return;
-}
-
 static int f2fs_set_data_page_dirty(struct page *page)
 {
 	struct address_space *mapping = page->mapping;
@@ -2523,7 +2492,7 @@ static int f2fs_set_data_page_dirty(struct page *page)
 	}
 
 	if (!PageDirty(page)) {
-		f2fs_set_page_dirty_nobuffers(page);
+		__set_page_dirty_nobuffers(page);
 		update_dirty_page(inode, page);
 		return 1;
 	}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 0c72908f3185..9f2bc78a9f5b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2939,7 +2939,6 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			u64 start, u64 len);
 bool should_update_inplace(struct inode *inode, struct f2fs_io_info *fio);
 bool should_update_outplace(struct inode *inode, struct f2fs_io_info *fio);
-void f2fs_set_page_dirty_nobuffers(struct page *page);
 int __f2fs_write_data_pages(struct address_space *mapping,
 						struct writeback_control *wbc,
 						enum iostat_type io_type);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index f202398e20ea..ae83ca9d2d31 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1753,7 +1753,7 @@ static int f2fs_set_node_page_dirty(struct page *page)
 	if (!PageUptodate(page))
 		SetPageUptodate(page);
 	if (!PageDirty(page)) {
-		f2fs_set_page_dirty_nobuffers(page);
+		__set_page_dirty_nobuffers(page);
 		inc_page_count(F2FS_P_SB(page), F2FS_DIRTY_NODES);
 		SetPagePrivate(page);
 		f2fs_trace_pid(page);
-- 
2.17.0.484.g0c8726318c-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
