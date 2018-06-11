From: Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v13 56/72] btrfs: Convert page cache to XArray
Date: Mon, 11 Jun 2018 07:06:23 -0700
Message-ID: <20180611140639.17215-57-willy@infradead.org>
References: <20180611140639.17215-1-willy@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180611140639.17215-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Matthew Wilcox <mawilcox@microsoft.com>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@redhat.com>, Lukas Czerner <lczerner@redhat.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, Christoph Hellwig <hch@lst.de>, Goldwyn Rodrigues <rgoldwyn@suse.com>, Nicholas Piggin <npiggin@gmail.com>, Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>, linux-nilfs@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Matthew Wilcox <mawilcox@microsoft.com>

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
Acked-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.c | 4 +---
 fs/btrfs/extent_io.c   | 8 +++-----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 8db29f791984..1d051d841cb7 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -444,9 +444,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		if (pg_index > end_index)
 			break;
 
-		rcu_read_lock();
-		page = radix_tree_lookup(&mapping->i_pages, pg_index);
-		rcu_read_unlock();
+		page = xa_load(&mapping->i_pages, pg_index);
 		if (page && !xa_is_value(page)) {
 			misses++;
 			if (misses > 4)
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 489fe673fbba..115ff9777364 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5286,11 +5286,9 @@ void clear_extent_buffer_dirty(struct extent_buffer *eb)
 
 		clear_page_dirty_for_io(page);
 		xa_lock_irq(&page->mapping->i_pages);
-		if (!PageDirty(page)) {
-			radix_tree_tag_clear(&page->mapping->i_pages,
-						page_index(page),
-						PAGECACHE_TAG_DIRTY);
-		}
+		if (!PageDirty(page))
+			__xa_clear_tag(&page->mapping->i_pages,
+					page_index(page), PAGECACHE_TAG_DIRTY);
 		xa_unlock_irq(&page->mapping->i_pages);
 		ClearPageError(page);
 		unlock_page(page);
-- 
2.17.1
