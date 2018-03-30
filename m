From: Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v10 24/62] page cache: Convert
 filemap_range_has_page to XArray
Date: Thu, 29 Mar 2018 20:42:07 -0700
Message-ID: <20180330034245.10462-25-willy@infradead.org>
References: <20180330034245.10462-1-willy@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <willy@infradead.org>) id 1f1kwe-0004PC-AV
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 30 Mar 2018 03:43:16 +0000
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f1kwc-00FCz4-W5
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 30 Mar 2018 03:43:16 +0000
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

Instead of calling find_get_pages_range() and putting any reference,
use xas_find() to iterate over any entries in the range, skipping the
shadow/swap entries.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 mm/filemap.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 86c83014c909..9bc417913269 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -458,20 +458,30 @@ EXPORT_SYMBOL(filemap_flush);
 bool filemap_range_has_page(struct address_space *mapping,
 			   loff_t start_byte, loff_t end_byte)
 {
-	pgoff_t index = start_byte >> PAGE_SHIFT;
-	pgoff_t end = end_byte >> PAGE_SHIFT;
 	struct page *page;
+	XA_STATE(xas, &mapping->i_pages, start_byte >> PAGE_SHIFT);
+	pgoff_t max = end_byte >> PAGE_SHIFT;
 
 	if (end_byte < start_byte)
 		return false;
 
-	if (mapping->nrpages == 0)
-		return false;
+	rcu_read_lock();
+	do {
+		page = xas_find(&xas, max);
+		if (xas_retry(&xas, page))
+			continue;
+		/* Shadow entries don't count */
+		if (xa_is_value(page))
+			continue;
+		/*
+		 * We don't need to try to pin this page; we're about to
+		 * release the RCU lock anyway.  It is enough to know that
+		 * there was a page here recently.
+		 */
+	} while (0);
+	rcu_read_unlock();
 
-	if (!find_get_pages_range(mapping, &index, end, 1, &page))
-		return false;
-	put_page(page);
-	return true;
+	return page != NULL;
 }
 EXPORT_SYMBOL(filemap_range_has_page);
 
-- 
2.16.2


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
