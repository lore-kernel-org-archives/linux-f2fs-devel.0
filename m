From: Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v10 31/62] mm: Convert page migration to XArray
Date: Thu, 29 Mar 2018 20:42:14 -0700
Message-ID: <20180330034245.10462-32-willy@infradead.org>
References: <20180330034245.10462-1-willy@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <willy@infradead.org>) id 1f1kwm-0004RW-04
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 30 Mar 2018 03:43:24 +0000
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f1kwk-004tRz-Jn
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 30 Mar 2018 03:43:23 +0000
In-Reply-To: <20180330034245.10462-1-willy@infradead.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc: linux-nilfs@vger.kernel.org, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@redhat.com>, Matthew Wilcox <mawilcox@microsoft.com>, James Simmons <jsimmons@infradead.org>, Jaegeuk Kim <jaegeuk@kernel.org>, Andreas Dilger <andreas.dilger@intel.com>, Nicholas Piggin <npiggin@gmail.com>, linux-f2fs-devel@lists.sourceforge.net, Oleg Drokin <oleg.drokin@intel.com>, Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>, Lukas Czerner <lczerner@redhat.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, Christoph Hellwig <hch@lst.de>, Goldwyn Rodrigues <rgoldwyn@suse.com>, Mike Kravetz <mike.kravetz@oracle.com>

From: Matthew Wilcox <mawilcox@microsoft.com>

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 mm/migrate.c | 41 ++++++++++++++++-------------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index bdef905b1737..16fbbffec185 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -323,7 +323,7 @@ void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
 	page = migration_entry_to_page(entry);
 
 	/*
-	 * Once radix-tree replacement of page migration started, page_count
+	 * Once page cache replacement of page migration started, page_count
 	 * *must* be zero. And, we don't want to call wait_on_page_locked()
 	 * against a page without get_page().
 	 * So, we use get_page_unless_zero(), here. Even failed, page fault
@@ -438,10 +438,10 @@ int migrate_page_move_mapping(struct address_space *mapping,
 		struct buffer_head *head, enum migrate_mode mode,
 		int extra_count)
 {
+	XA_STATE(xas, &mapping->i_pages, page_index(page));
 	struct zone *oldzone, *newzone;
 	int dirty;
 	int expected_count = 1 + extra_count;
-	void **pslot;
 
 	/*
 	 * Device public or private pages have an extra refcount as they are
@@ -467,21 +467,16 @@ int migrate_page_move_mapping(struct address_space *mapping,
 	oldzone = page_zone(page);
 	newzone = page_zone(newpage);
 
-	xa_lock_irq(&mapping->i_pages);
-
-	pslot = radix_tree_lookup_slot(&mapping->i_pages,
- 					page_index(page));
+	xas_lock_irq(&xas);
 
 	expected_count += 1 + page_has_private(page);
-	if (page_count(page) != expected_count ||
-		radix_tree_deref_slot_protected(pslot,
-					&mapping->i_pages.xa_lock) != page) {
-		xa_unlock_irq(&mapping->i_pages);
+	if (page_count(page) != expected_count || xas_load(&xas) != page) {
+		xas_unlock_irq(&xas);
 		return -EAGAIN;
 	}
 
 	if (!page_ref_freeze(page, expected_count)) {
-		xa_unlock_irq(&mapping->i_pages);
+		xas_unlock_irq(&xas);
 		return -EAGAIN;
 	}
 
@@ -495,7 +490,7 @@ int migrate_page_move_mapping(struct address_space *mapping,
 	if (mode == MIGRATE_ASYNC && head &&
 			!buffer_migrate_lock_buffers(head, mode)) {
 		page_ref_unfreeze(page, expected_count);
-		xa_unlock_irq(&mapping->i_pages);
+		xas_unlock_irq(&xas);
 		return -EAGAIN;
 	}
 
@@ -523,7 +518,7 @@ int migrate_page_move_mapping(struct address_space *mapping,
 		SetPageDirty(newpage);
 	}
 
-	radix_tree_replace_slot(&mapping->i_pages, pslot, newpage);
+	xas_store(&xas, newpage);
 
 	/*
 	 * Drop cache reference from old page by unfreezing
@@ -532,7 +527,7 @@ int migrate_page_move_mapping(struct address_space *mapping,
 	 */
 	page_ref_unfreeze(page, expected_count - 1);
 
-	xa_unlock(&mapping->i_pages);
+	xas_unlock(&xas);
 	/* Leave irq disabled to prevent preemption while updating stats */
 
 	/*
@@ -572,22 +567,18 @@ EXPORT_SYMBOL(migrate_page_move_mapping);
 int migrate_huge_page_move_mapping(struct address_space *mapping,
 				   struct page *newpage, struct page *page)
 {
+	XA_STATE(xas, &mapping->i_pages, page_index(page));
 	int expected_count;
-	void **pslot;
-
-	xa_lock_irq(&mapping->i_pages);
-
-	pslot = radix_tree_lookup_slot(&mapping->i_pages, page_index(page));
 
+	xas_lock_irq(&xas);
 	expected_count = 2 + page_has_private(page);
-	if (page_count(page) != expected_count ||
-		radix_tree_deref_slot_protected(pslot, &mapping->i_pages.xa_lock) != page) {
-		xa_unlock_irq(&mapping->i_pages);
+	if (page_count(page) != expected_count || xas_load(&xas) != page) {
+		xas_unlock_irq(&xas);
 		return -EAGAIN;
 	}
 
 	if (!page_ref_freeze(page, expected_count)) {
-		xa_unlock_irq(&mapping->i_pages);
+		xas_unlock_irq(&xas);
 		return -EAGAIN;
 	}
 
@@ -596,11 +587,11 @@ int migrate_huge_page_move_mapping(struct address_space *mapping,
 
 	get_page(newpage);
 
-	radix_tree_replace_slot(&mapping->i_pages, pslot, newpage);
+	xas_store(&xas, newpage);
 
 	page_ref_unfreeze(page, expected_count - 1);
 
-	xa_unlock_irq(&mapping->i_pages);
+	xas_unlock_irq(&xas);
 
 	return MIGRATEPAGE_SUCCESS;
 }
-- 
2.16.2


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
