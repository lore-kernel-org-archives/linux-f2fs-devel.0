From: Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v13 27/72] page cache;
 Convert find_get_pages_range_tag to XArray
Date: Mon, 11 Jun 2018 07:05:54 -0700
Message-ID: <20180611140639.17215-28-willy@infradead.org>
References: <20180611140639.17215-1-willy@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <willy@infradead.org>) id 1fSNTV-00008Q-Cs
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 11 Jun 2018 14:07:13 +0000
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fSNTT-00GC8l-3c
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 11 Jun 2018 14:07:13 +0000
In-Reply-To: <20180611140639.17215-1-willy@infradead.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-nilfs@vger.kernel.org, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@redhat.com>, Matthew Wilcox <mawilcox@microsoft.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, linux-f2fs-devel@lists.sourceforge.net, Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>, Lukas Czerner <lczerner@redhat.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, Christoph Hellwig <hch@lst.de>, Goldwyn Rodrigues <rgoldwyn@suse.com>

From: Matthew Wilcox <mawilcox@microsoft.com>

The 'end' parameter of the xas_for_each iterator avoids a useless
iteration at the end of the range.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 include/linux/pagemap.h |  4 +--
 mm/filemap.c            | 68 ++++++++++++++++-------------------------
 2 files changed, 28 insertions(+), 44 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 2f5d2d3ebaac..a6d635fefb01 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -363,10 +363,10 @@ static inline unsigned find_get_pages(struct address_space *mapping,
 unsigned find_get_pages_contig(struct address_space *mapping, pgoff_t start,
 			       unsigned int nr_pages, struct page **pages);
 unsigned find_get_pages_range_tag(struct address_space *mapping, pgoff_t *index,
-			pgoff_t end, int tag, unsigned int nr_pages,
+			pgoff_t end, xa_tag_t tag, unsigned int nr_pages,
 			struct page **pages);
 static inline unsigned find_get_pages_tag(struct address_space *mapping,
-			pgoff_t *index, int tag, unsigned int nr_pages,
+			pgoff_t *index, xa_tag_t tag, unsigned int nr_pages,
 			struct page **pages)
 {
 	return find_get_pages_range_tag(mapping, index, (pgoff_t)-1, tag,
diff --git a/mm/filemap.c b/mm/filemap.c
index 8a69613fcdf3..83328635edaa 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1789,74 +1789,58 @@ EXPORT_SYMBOL(find_get_pages_contig);
  * @tag.   We update @index to index the next page for the traversal.
  */
 unsigned find_get_pages_range_tag(struct address_space *mapping, pgoff_t *index,
-			pgoff_t end, int tag, unsigned int nr_pages,
+			pgoff_t end, xa_tag_t tag, unsigned int nr_pages,
 			struct page **pages)
 {
-	struct radix_tree_iter iter;
-	void **slot;
+	XA_STATE(xas, &mapping->i_pages, *index);
+	struct page *page;
 	unsigned ret = 0;
 
 	if (unlikely(!nr_pages))
 		return 0;
 
 	rcu_read_lock();
-	radix_tree_for_each_tagged(slot, &mapping->i_pages, &iter, *index, tag) {
-		struct page *head, *page;
-
-		if (iter.index > end)
-			break;
-repeat:
-		page = radix_tree_deref_slot(slot);
-		if (unlikely(!page))
+	xas_for_each_tagged(&xas, page, end, tag) {
+		struct page *head;
+		if (xas_retry(&xas, page))
 			continue;
-
-		if (radix_tree_exception(page)) {
-			if (radix_tree_deref_retry(page)) {
-				slot = radix_tree_iter_retry(&iter);
-				continue;
-			}
-			/*
-			 * A shadow entry of a recently evicted page.
-			 *
-			 * Those entries should never be tagged, but
-			 * this tree walk is lockless and the tags are
-			 * looked up in bulk, one radix tree node at a
-			 * time, so there is a sizable window for page
-			 * reclaim to evict a page we saw tagged.
-			 *
-			 * Skip over it.
-			 */
+		/*
+		 * Shadow entries should never be tagged, but this iteration
+		 * is lockless so there is a window for page reclaim to evict
+		 * a page we saw tagged.  Skip over it.
+		 */
+		if (xa_is_value(page))
 			continue;
-		}
 
 		head = compound_head(page);
 		if (!page_cache_get_speculative(head))
-			goto repeat;
+			goto retry;
 
 		/* The page was split under us? */
-		if (compound_head(page) != head) {
-			put_page(head);
-			goto repeat;
-		}
+		if (compound_head(page) != head)
+			goto put_page;
 
 		/* Has the page moved? */
-		if (unlikely(page != *slot)) {
-			put_page(head);
-			goto repeat;
-		}
+		if (unlikely(page != xas_reload(&xas)))
+			goto put_page;
 
 		pages[ret] = page;
 		if (++ret == nr_pages) {
-			*index = pages[ret - 1]->index + 1;
+			*index = page->index + 1;
 			goto out;
 		}
+		continue;
+put_page:
+		put_page(head);
+retry:
+		xas_reset(&xas);
 	}
 
 	/*
-	 * We come here when we got at @end. We take care to not overflow the
+	 * We come here when we got to @end. We take care to not overflow the
 	 * index @index as it confuses some of the callers. This breaks the
-	 * iteration when there is page at index -1 but that is already broken
-	 * anyway.
+	 * iteration when there is a page at index -1 but that is already
+	 * broken anyway.
 	 */
 	if (end == (pgoff_t)-1)
 		*index = (pgoff_t)-1;
-- 
2.17.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
