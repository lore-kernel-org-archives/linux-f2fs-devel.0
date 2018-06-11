From: Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v13 23/72] page cache: Convert find_get_entry to
 XArray
Date: Mon, 11 Jun 2018 07:05:50 -0700
Message-ID: <20180611140639.17215-24-willy@infradead.org>
References: <20180611140639.17215-1-willy@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <willy@infradead.org>) id 1fSNTN-0000Qp-JH
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 11 Jun 2018 14:07:05 +0000
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fSNTM-0001Og-A9
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 11 Jun 2018 14:07:05 +0000
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

Slightly shorter and simpler code.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 mm/filemap.c | 63 +++++++++++++++++++++++-----------------------------
 1 file changed, 28 insertions(+), 35 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 7cdb1d4b8117..6db3d35ff5f6 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1382,47 +1382,40 @@ EXPORT_SYMBOL(page_cache_prev_gap);
  */
 struct page *find_get_entry(struct address_space *mapping, pgoff_t offset)
 {
-	void **pagep;
+	XA_STATE(xas, &mapping->i_pages, offset);
 	struct page *head, *page;
 
 	rcu_read_lock();
 repeat:
-	page = NULL;
-	pagep = radix_tree_lookup_slot(&mapping->i_pages, offset);
-	if (pagep) {
-		page = radix_tree_deref_slot(pagep);
-		if (unlikely(!page))
-			goto out;
-		if (radix_tree_exception(page)) {
-			if (radix_tree_deref_retry(page))
-				goto repeat;
-			/*
-			 * A shadow entry of a recently evicted page,
-			 * or a swap entry from shmem/tmpfs.  Return
-			 * it without attempting to raise page count.
-			 */
-			goto out;
-		}
+	xas_reset(&xas);
+	page = xas_load(&xas);
+	if (xas_retry(&xas, page))
+		goto repeat;
+	/*
+	 * A shadow entry of a recently evicted page, or a swap entry from
+	 * shmem/tmpfs.  Return it without attempting to raise page count.
+	 */
+	if (!page || xa_is_value(page))
+		goto out;
 
-		head = compound_head(page);
-		if (!page_cache_get_speculative(head))
-			goto repeat;
+	head = compound_head(page);
+	if (!page_cache_get_speculative(head))
+		goto repeat;
 
-		/* The page was split under us? */
-		if (compound_head(page) != head) {
-			put_page(head);
-			goto repeat;
-		}
+	/* The page was split under us? */
+	if (compound_head(page) != head) {
+		put_page(head);
+		goto repeat;
+	}
 
-		/*
-		 * Has the page moved?
-		 * This is part of the lockless pagecache protocol. See
-		 * include/linux/pagemap.h for details.
-		 */
-		if (unlikely(page != *pagep)) {
-			put_page(head);
-			goto repeat;
-		}
+	/*
+	 * Has the page moved?
+	 * This is part of the lockless pagecache protocol. See
+	 * include/linux/pagemap.h for details.
+	 */
+	if (unlikely(page != xas_reload(&xas))) {
+		put_page(head);
+		goto repeat;
 	}
 out:
 	rcu_read_unlock();
@@ -1453,7 +1446,7 @@ struct page *find_lock_entry(struct address_space *mapping, pgoff_t offset)
 
 repeat:
 	page = find_get_entry(mapping, offset);
-	if (page && !radix_tree_exception(page)) {
+	if (page && !xa_is_value(page)) {
 		lock_page(page);
 		/* Has the page been truncated? */
 		if (unlikely(page_mapping(page) != mapping)) {
-- 
2.17.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
