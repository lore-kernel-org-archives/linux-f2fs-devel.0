From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/4 v2 RESEND] f2fs: expose f2fs_write_cache_pages
Date: Tue, 14 Jul 2015 18:56:10 +0800
Message-ID: <00f701d0be23$cc36ca60$64a45f20$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

If there are gced dirty pages and normal dirty pages in the mapping
of one inode, we might writeback them alternately with discontinuous
block address, resulting in low performance.

This patch introduces f2fs_write_cache_pages with codes copied from
write_cache_pages in mm/page-writeback.c.

In this function, we refactor flow with two steps:
1) writeback all cold type pages.
2) writeback all non-cold type pages.

By using this method, f2fs will writeback dirty pages with the same
temperature in bunch mode, it makes writeouted block being with
more continuous address, so they can be merged as much as possible
in f2fs bio cache, and also it will reduce the chance of submiting
small IO from block layer.

Test environment: 8g nokia sd card (very old sd card, but it shows
better effect when testing with this patch, and with a 32g kingston
sd card, I didn't see much more improvement).

Test step:
1. touch testfile;
2. truncate -s 512K testfile;
3. write all pages with odd index;
4. trigger gc by ioctl;
5. write all pages with even index;
6. time fsync testfile.

before:
real	0m0.402s
user	0m0.000s
sys	0m0.000s

after:
real	0m0.143s
user	0m0.004s
sys	0m0.004s

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
v2:
 * use f2fs_wait_on_page_writeback instead of wait_on_page_writeback
   to avoid long delay or deadlock.

 fs/f2fs/data.c | 136 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 135 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f84c268..ee091f3 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -14,6 +14,7 @@
 #include <linux/mpage.h>
 #include <linux/writeback.h>
 #include <linux/backing-dev.h>
+#include <linux/pagevec.h>
 #include <linux/blkdev.h>
 #include <linux/bio.h>
 #include <linux/prefetch.h>
@@ -1127,6 +1128,139 @@ static int __f2fs_writepage(struct page *page, struct writeback_control *wbc,
 	return ret;
 }
 
+/*
+ * This function was copied from write_cche_pages from mm/page-writeback.c.
+ * The major change is making write step of cold data page separately from
+ * warm/hot data page.
+ */
+static int f2fs_write_cache_pages(struct address_space *mapping,
+			struct writeback_control *wbc, writepage_t writepage,
+			void *data)
+{
+	int ret = 0;
+	int done = 0;
+	struct pagevec pvec;
+	int nr_pages;
+	pgoff_t uninitialized_var(writeback_index);
+	pgoff_t index;
+	pgoff_t end;		/* Inclusive */
+	pgoff_t done_index;
+	int cycled;
+	int range_whole = 0;
+	int tag;
+	int step = 0;
+
+	pagevec_init(&pvec, 0);
+next:
+	if (wbc->range_cyclic) {
+		writeback_index = mapping->writeback_index; /* prev offset */
+		index = writeback_index;
+		if (index == 0)
+			cycled = 1;
+		else
+			cycled = 0;
+		end = -1;
+	} else {
+		index = wbc->range_start >> PAGE_CACHE_SHIFT;
+		end = wbc->range_end >> PAGE_CACHE_SHIFT;
+		if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
+			range_whole = 1;
+		cycled = 1; /* ignore range_cyclic tests */
+	}
+	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
+		tag = PAGECACHE_TAG_TOWRITE;
+	else
+		tag = PAGECACHE_TAG_DIRTY;
+retry:
+	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
+		tag_pages_for_writeback(mapping, index, end);
+	done_index = index;
+	while (!done && (index <= end)) {
+		int i;
+
+		nr_pages = pagevec_lookup_tag(&pvec, mapping, &index, tag,
+			      min(end - index, (pgoff_t)PAGEVEC_SIZE - 1) + 1);
+		if (nr_pages == 0)
+			break;
+
+		for (i = 0; i < nr_pages; i++) {
+			struct page *page = pvec.pages[i];
+
+			if (page->index > end) {
+				done = 1;
+				break;
+			}
+
+			done_index = page->index;
+
+			lock_page(page);
+
+			if (unlikely(page->mapping != mapping)) {
+continue_unlock:
+				unlock_page(page);
+				continue;
+			}
+
+			if (!PageDirty(page)) {
+				/* someone wrote it for us */
+				goto continue_unlock;
+			}
+
+			if (step == 0 && !is_cold_data(page))
+				goto continue_unlock;
+			if (step == 1 && is_cold_data(page))
+				goto continue_unlock;
+
+			if (PageWriteback(page)) {
+				if (wbc->sync_mode != WB_SYNC_NONE)
+					f2fs_wait_on_page_writeback(page, DATA);
+				else
+					goto continue_unlock;
+			}
+
+			BUG_ON(PageWriteback(page));
+			if (!clear_page_dirty_for_io(page))
+				goto continue_unlock;
+
+			ret = (*writepage)(page, wbc, data);
+			if (unlikely(ret)) {
+				if (ret == AOP_WRITEPAGE_ACTIVATE) {
+					unlock_page(page);
+					ret = 0;
+				} else {
+					done_index = page->index + 1;
+					done = 1;
+					break;
+				}
+			}
+
+			if (--wbc->nr_to_write <= 0 &&
+			    wbc->sync_mode == WB_SYNC_NONE) {
+				done = 1;
+				break;
+			}
+		}
+		pagevec_release(&pvec);
+		cond_resched();
+	}
+
+	if (step < 1) {
+		step++;
+		goto next;
+	}
+
+	if (!cycled && !done) {
+		cycled = 1;
+		index = 0;
+		end = writeback_index - 1;
+		goto retry;
+	}
+	if (wbc->range_cyclic || (range_whole && wbc->nr_to_write > 0))
+		mapping->writeback_index = done_index;
+
+	return ret;
+}
+
 static int f2fs_write_data_pages(struct address_space *mapping,
 			    struct writeback_control *wbc)
 {
@@ -1157,7 +1291,7 @@ static int f2fs_write_data_pages(struct address_space *mapping,
 		mutex_lock(&sbi->writepages);
 		locked = true;
 	}
-	ret = write_cache_pages(mapping, wbc, __f2fs_writepage, mapping);
+	ret = f2fs_write_cache_pages(mapping, wbc, __f2fs_writepage, mapping);
 	f2fs_submit_merged_bio(sbi, DATA, WRITE);
 	if (locked)
 		mutex_unlock(&sbi->writepages);
-- 
2.4.2
