From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 07/19] f2fs: expose f2fs_mpage_readpages
Date: Fri,  1 May 2015 17:48:34 -0700
Message-ID: <1430527726-68547-7-git-send-email-jaegeuk@kernel.org>
References: <1430527726-68547-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YoLcT-0003ph-9k
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 02 May 2015 00:49:25 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YoLcS-0006FY-5H for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 02 May 2015 00:49:25 +0000
In-Reply-To: <1430527726-68547-1-git-send-email-jaegeuk@kernel.org>
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

This patch implements f2fs_mpage_readpages for further optimization on
encryption support.

The basic code was taken from fs/mpage.c, and changed to be simple by adjusting
that block_size is equal to page_size in f2fs.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 157 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 154 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index aa3c079..2a3a9cd 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -18,6 +18,7 @@
 #include <linux/bio.h>
 #include <linux/prefetch.h>
 #include <linux/uio.h>
+#include <linux/cleancache.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -47,6 +48,30 @@ static void f2fs_read_end_io(struct bio *bio, int err)
 	bio_put(bio);
 }
 
+/*
+ * I/O completion handler for multipage BIOs.
+ * copied from fs/mpage.c
+ */
+static void mpage_end_io(struct bio *bio, int err)
+{
+	struct bio_vec *bv;
+	int i;
+
+	bio_for_each_segment_all(bv, bio, i) {
+		struct page *page = bv->bv_page;
+
+		if (!err) {
+			SetPageUptodate(page);
+		} else {
+			ClearPageUptodate(page);
+			SetPageError(page);
+		}
+		unlock_page(page);
+	}
+
+	bio_put(bio);
+}
+
 static void f2fs_write_end_io(struct bio *bio, int err)
 {
 	struct f2fs_sb_info *sbi = bio->bi_private;
@@ -1349,6 +1374,133 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 				start, len, get_data_block_fiemap);
 }
 
+/*
+ * This function was originally taken from fs/mpage.c, and customized for f2fs.
+ * Major change was from block_size == page_size in f2fs by default.
+ */
+static int f2fs_mpage_readpages(struct address_space *mapping,
+			struct list_head *pages, struct page *page,
+			unsigned nr_pages)
+{
+	struct bio *bio = NULL;
+	unsigned page_idx;
+	sector_t last_block_in_bio = 0;
+	struct inode *inode = mapping->host;
+	const unsigned blkbits = inode->i_blkbits;
+	const unsigned blocksize = 1 << blkbits;
+	sector_t block_in_file;
+	sector_t last_block;
+	sector_t last_block_in_file;
+	sector_t block_nr;
+	struct block_device *bdev = inode->i_sb->s_bdev;
+	struct f2fs_map_blocks map;
+
+	map.m_pblk = 0;
+	map.m_lblk = 0;
+	map.m_len = 0;
+	map.m_flags = 0;
+
+	for (page_idx = 0; nr_pages; page_idx++, nr_pages--) {
+
+		prefetchw(&page->flags);
+		if (pages) {
+			page = list_entry(pages->prev, struct page, lru);
+			list_del(&page->lru);
+			if (add_to_page_cache_lru(page, mapping,
+						  page->index, GFP_KERNEL))
+				goto next_page;
+		}
+
+		block_in_file = (sector_t)page->index;
+		last_block = block_in_file + nr_pages;
+		last_block_in_file = (i_size_read(inode) + blocksize - 1) >>
+								blkbits;
+		if (last_block > last_block_in_file)
+			last_block = last_block_in_file;
+
+		/*
+		 * Map blocks using the previous result first.
+		 */
+		if ((map.m_flags & F2FS_MAP_MAPPED) &&
+				block_in_file > map.m_lblk &&
+				block_in_file < (map.m_lblk + map.m_len))
+			goto got_it;
+
+		/*
+		 * Then do more f2fs_map_blocks() calls until we are
+		 * done with this page.
+		 */
+		map.m_flags = 0;
+
+		if (block_in_file < last_block) {
+			map.m_lblk = block_in_file;
+			map.m_len = last_block - block_in_file;
+
+			if (f2fs_map_blocks(inode, &map, 0, false))
+				goto set_error_page;
+		}
+got_it:
+		if ((map.m_flags & F2FS_MAP_MAPPED)) {
+			block_nr = map.m_pblk + block_in_file - map.m_lblk;
+			SetPageMappedToDisk(page);
+
+			if (!PageUptodate(page) && !cleancache_get_page(page)) {
+				SetPageUptodate(page);
+				goto confused;
+			}
+		} else {
+			zero_user_segment(page, 0, PAGE_CACHE_SIZE);
+			SetPageUptodate(page);
+			unlock_page(page);
+			goto next_page;
+		}
+
+		/*
+		 * This page will go to BIO.  Do we need to send this
+		 * BIO off first?
+		 */
+		if (bio && (last_block_in_bio != block_nr - 1)) {
+submit_and_realloc:
+			submit_bio(READ, bio);
+			bio = NULL;
+		}
+		if (bio == NULL) {
+			bio = bio_alloc(GFP_KERNEL,
+				min_t(int, nr_pages, bio_get_nr_vecs(bdev)));
+			if (!bio)
+				goto set_error_page;
+			bio->bi_bdev = bdev;
+			bio->bi_iter.bi_sector = SECTOR_FROM_BLOCK(block_nr);
+			bio->bi_end_io = mpage_end_io;
+			bio->bi_private = NULL;
+		}
+
+		if (bio_add_page(bio, page, blocksize, 0) < blocksize)
+			goto submit_and_realloc;
+
+		last_block_in_bio = block_nr;
+		goto next_page;
+set_error_page:
+		SetPageError(page);
+		zero_user_segment(page, 0, PAGE_CACHE_SIZE);
+		unlock_page(page);
+		goto next_page;
+confused:
+		if (bio) {
+			submit_bio(READ, bio);
+			bio = NULL;
+		}
+		unlock_page(page);
+next_page:
+		if (pages)
+			page_cache_release(page);
+	}
+	BUG_ON(pages && !list_empty(pages));
+	if (bio)
+		submit_bio(READ, bio);
+	return 0;
+}
+
 static int f2fs_read_data_page(struct file *file, struct page *page)
 {
 	struct inode *inode = page->mapping->host;
@@ -1360,8 +1512,7 @@ static int f2fs_read_data_page(struct file *file, struct page *page)
 	if (f2fs_has_inline_data(inode))
 		ret = f2fs_read_inline_data(inode, page);
 	if (ret == -EAGAIN)
-		ret = mpage_readpage(page, get_data_block);
-
+		ret = f2fs_mpage_readpages(page->mapping, NULL, page, 1);
 	return ret;
 }
 
@@ -1375,7 +1526,7 @@ static int f2fs_read_data_pages(struct file *file,
 	if (f2fs_has_inline_data(inode))
 		return 0;
 
-	return mpage_readpages(mapping, pages, nr_pages, get_data_block);
+	return f2fs_mpage_readpages(mapping, pages, NULL, nr_pages);
 }
 
 int do_write_data_page(struct page *page, struct f2fs_io_info *fio)
-- 
2.1.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
