From: Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v4 60/73] dax: Convert __dax_invalidate_mapping_entry to XArray
Date: Tue,  5 Dec 2017 16:41:46 -0800
Message-ID: <20171206004159.3755-61-willy@infradead.org>
References: <20171206004159.3755-1-willy@infradead.org>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20171206004159.3755-1-willy@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Cc: Matthew Wilcox <mawilcox@microsoft.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, Jens Axboe <axboe@kernel.dk>, Rehas Sachdeva <aquannie@gmail.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-nilfs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Matthew Wilcox <mawilcox@microsoft.com>

Simple now that we already have an xa_state!

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 fs/dax.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index ad984dece12e..66f6c4ea18f7 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -413,24 +413,24 @@ static int __dax_invalidate_mapping_entry(struct address_space *mapping,
 	XA_STATE(xas, &mapping->pages, index);
 	int ret = 0;
 	void *entry;
-	struct radix_tree_root *pages = &mapping->pages;
 
 	xa_lock_irq(&mapping->pages);
 	entry = get_unlocked_mapping_entry(&xas);
 	if (!entry || WARN_ON_ONCE(!xa_is_value(entry)))
 		goto out;
 	if (!trunc &&
-	    (radix_tree_tag_get(pages, index, PAGECACHE_TAG_DIRTY) ||
-	     radix_tree_tag_get(pages, index, PAGECACHE_TAG_TOWRITE)))
+	    (xas_get_tag(&xas, PAGECACHE_TAG_DIRTY) ||
+	     xas_get_tag(&xas, PAGECACHE_TAG_TOWRITE)))
 		goto out;
-	radix_tree_delete(pages, index);
+	xas_store(&xas, NULL);
 	mapping->nrexceptional--;
 	ret = 1;
 out:
 	put_unlocked_mapping_entry(&xas, entry);
-	xa_unlock_irq(&mapping->pages);
+	xas_unlock_irq(&xas);
 	return ret;
 }
+
 /*
  * Delete DAX data value entry at @index from @mapping. Wait for radix tree
  * entry to get unlocked before deleting it.
-- 
2.15.0
