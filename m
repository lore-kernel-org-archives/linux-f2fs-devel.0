From: Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v14 31/74] radix tree test suite: Convert
 regression1 to XArray
Date: Sat, 16 Jun 2018 19:00:09 -0700
Message-ID: <20180617020052.4759-32-willy@infradead.org>
References: <20180617020052.4759-1-willy@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <willy@infradead.org>) id 1fUN0v-0002l9-Sz
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 17 Jun 2018 02:01:57 +0000
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fUN0u-00HBxC-Gj
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 17 Jun 2018 02:01:57 +0000
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

Now the page cache lookup is using the XArray, let's convert this
regression test from the radix tree API to the XArray so it's testing
roughly the same thing it was testing before.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 tools/testing/radix-tree/regression1.c | 58 +++++++++-----------------
 1 file changed, 19 insertions(+), 39 deletions(-)

diff --git a/tools/testing/radix-tree/regression1.c b/tools/testing/radix-tree/regression1.c
index 0aece092f40e..b4a4a7168986 100644
--- a/tools/testing/radix-tree/regression1.c
+++ b/tools/testing/radix-tree/regression1.c
@@ -53,12 +53,12 @@ struct page {
 	unsigned long index;
 };
 
-static struct page *page_alloc(void)
+static struct page *page_alloc(int index)
 {
 	struct page *p;
 	p = malloc(sizeof(struct page));
 	p->count = 1;
-	p->index = 1;
+	p->index = index;
 	pthread_mutex_init(&p->lock, NULL);
 
 	return p;
@@ -80,53 +80,33 @@ static void page_free(struct page *p)
 static unsigned find_get_pages(unsigned long start,
 			    unsigned int nr_pages, struct page **pages)
 {
-	unsigned int i;
-	unsigned int ret;
-	unsigned int nr_found;
+	XA_STATE(xas, &mt_tree, start);
+	struct page *page;
+	unsigned int ret = 0;
 
 	rcu_read_lock();
-restart:
-	nr_found = radix_tree_gang_lookup_slot(&mt_tree,
-				(void ***)pages, NULL, start, nr_pages);
-	ret = 0;
-	for (i = 0; i < nr_found; i++) {
-		struct page *page;
-repeat:
-		page = radix_tree_deref_slot((void **)pages[i]);
-		if (unlikely(!page))
+	xas_for_each(&xas, page, ULONG_MAX) {
+		if (xas_retry(&xas, page))
 			continue;
 
-		if (radix_tree_exception(page)) {
-			if (radix_tree_deref_retry(page)) {
-				/*
-				 * Transient condition which can only trigger
-				 * when entry at index 0 moves out of or back
-				 * to root: none yet gotten, safe to restart.
-				 */
-				assert((start | i) == 0);
-				goto restart;
-			}
-			/*
-			 * No exceptional entries are inserted in this test.
-			 */
-			assert(0);
-		}
-
 		pthread_mutex_lock(&page->lock);
-		if (!page->count) {
-			pthread_mutex_unlock(&page->lock);
-			goto repeat;
-		}
+		if (!page->count)
+			goto unlock;
+
 		/* don't actually update page refcount */
 		pthread_mutex_unlock(&page->lock);
 
 		/* Has the page moved? */
-		if (unlikely(page != *((void **)pages[i]))) {
-			goto repeat;
-		}
+		if (unlikely(page != xas_reload(&xas)))
+			goto put_page;
 
 		pages[ret] = page;
 		ret++;
+		continue;
+unlock:
+		pthread_mutex_unlock(&page->lock);
+put_page:
+		xas_reset(&xas);
 	}
 	rcu_read_unlock();
 	return ret;
@@ -145,12 +125,12 @@ static void *regression1_fn(void *arg)
 		for (j = 0; j < 1000000; j++) {
 			struct page *p;
 
-			p = page_alloc();
+			p = page_alloc(0);
 			pthread_mutex_lock(&mt_lock);
 			radix_tree_insert(&mt_tree, 0, p);
 			pthread_mutex_unlock(&mt_lock);
 
-			p = page_alloc();
+			p = page_alloc(1);
 			pthread_mutex_lock(&mt_lock);
 			radix_tree_insert(&mt_tree, 1, p);
 			pthread_mutex_unlock(&mt_lock);
-- 
2.17.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
