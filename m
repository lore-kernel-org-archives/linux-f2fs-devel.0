From: Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v14 23/74] page cache: Convert page deletion to
 XArray
Date: Sat, 16 Jun 2018 19:00:01 -0700
Message-ID: <20180617020052.4759-24-willy@infradead.org>
References: <20180617020052.4759-1-willy@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <willy@infradead.org>) id 1fUN0R-0002Wa-9d
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 17 Jun 2018 02:01:27 +0000
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fUN0P-00HBvB-89
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 17 Jun 2018 02:01:26 +0000
In-Reply-To: <20180617020052.4759-1-willy@infradead.org>
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
Cc: linux-nilfs@vger.kernel.org, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@redhat.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-f2fs-devel@lists.sourceforge.net, Nicholas Piggin <npiggin@gmail.com>, Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>, Lukas Czerner <lczerner@redhat.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, Christoph Hellwig <hch@lst.de>, Goldwyn Rodrigues <rgoldwyn@suse.com>

The code is slightly shorter and simpler.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 mm/filemap.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 965ff68e5b8d..7cdb1d4b8117 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -111,31 +111,26 @@
  *   ->tasklist_lock            (memory_failure, collect_procs_ao)
  */
 
-static void page_cache_tree_delete(struct address_space *mapping,
+static void page_cache_delete(struct address_space *mapping,
 				   struct page *page, void *shadow)
 {
-	int i, nr;
+	XA_STATE(xas, &mapping->i_pages, page->index);
+	unsigned int nr = 1;
 
-	/* hugetlb pages are represented by one entry in the radix tree */
-	nr = PageHuge(page) ? 1 : hpage_nr_pages(page);
+	mapping_set_update(&xas, mapping);
+
+	/* hugetlb pages are represented by a single entry in the xarray */
+	if (!PageHuge(page)) {
+		xas_set_order(&xas, page->index, compound_order(page));
+		nr = 1U << compound_order(page);
+	}
 
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	VM_BUG_ON_PAGE(PageTail(page), page);
 	VM_BUG_ON_PAGE(nr != 1 && shadow, page);
 
-	for (i = 0; i < nr; i++) {
-		struct radix_tree_node *node;
-		void **slot;
-
-		__radix_tree_lookup(&mapping->i_pages, page->index + i,
-				    &node, &slot);
-
-		VM_BUG_ON_PAGE(!node && nr != 1, page);
-
-		radix_tree_clear_tags(&mapping->i_pages, node, slot);
-		__radix_tree_replace(&mapping->i_pages, node, slot, shadow,
-				workingset_lookup_update(mapping));
-	}
+	xas_store(&xas, shadow);
+	xas_init_tags(&xas);
 
 	page->mapping = NULL;
 	/* Leave page->index set: truncation lookup relies upon it */
@@ -234,7 +229,7 @@ void __delete_from_page_cache(struct page *page, void *shadow)
 	trace_mm_filemap_delete_from_page_cache(page);
 
 	unaccount_page_cache_page(mapping, page);
-	page_cache_tree_delete(mapping, page, shadow);
+	page_cache_delete(mapping, page, shadow);
 }
 
 static void page_cache_free_page(struct address_space *mapping,
-- 
2.17.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
