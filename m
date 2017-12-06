From: Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v4 35/73] mm: Convert __do_page_cache_readahead to XArray
Date: Tue,  5 Dec 2017 16:41:21 -0800
Message-ID: <20171206004159.3755-36-willy@infradead.org>
References: <20171206004159.3755-1-willy@infradead.org>
Return-path: <linux-btrfs-owner@vger.kernel.org>
In-Reply-To: <20171206004159.3755-1-willy@infradead.org>
Sender: linux-btrfs-owner@vger.kernel.org
Cc: Matthew Wilcox <mawilcox@microsoft.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, Jens Axboe <axboe@kernel.dk>, Rehas Sachdeva <aquannie@gmail.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-nilfs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Matthew Wilcox <mawilcox@microsoft.com>

This one is trivial.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 mm/readahead.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index f64b31b3a84a..66bcaffd47f0 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -174,9 +174,7 @@ int __do_page_cache_readahead(struct address_space *mapping, struct file *filp,
 		if (page_offset > end_index)
 			break;
 
-		rcu_read_lock();
-		page = radix_tree_lookup(&mapping->pages, page_offset);
-		rcu_read_unlock();
+		page = xa_load(&mapping->pages, page_offset);
 		if (page && !xa_is_value(page))
 			continue;
 
-- 
2.15.0

