From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: avoid migratepage for atomic written page
Date: Mon,  3 Jul 2017 16:08:20 -0700
Message-ID: <20170703230820.63929-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1dSASB-0006qg-Pc
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 03 Jul 2017 23:08:27 +0000
Received: from mail.kernel.org ([198.145.29.99])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dSASA-0003Rz-Sx
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 03 Jul 2017 23:08:27 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

In order to avoid lock contention for atomic written pages, we'd better give
EAGAIN in f2fs_migrate_page. We expect it will be released soon as transaction
commits.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 35 ++++++++++-------------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d58b81213a86..1458e3a6d630 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2197,41 +2197,26 @@ static sector_t f2fs_bmap(struct address_space *mapping, sector_t block)
 int f2fs_migrate_page(struct address_space *mapping,
 		struct page *newpage, struct page *page, enum migrate_mode mode)
 {
-	int rc, extra_count;
-	struct f2fs_inode_info *fi = F2FS_I(mapping->host);
-	bool atomic_written = IS_ATOMIC_WRITTEN_PAGE(page);
+	int rc;
 
-	BUG_ON(PageWriteback(page));
-
-	/* migrating an atomic written page is safe with the inmem_lock hold */
-	if (atomic_written && !mutex_trylock(&fi->inmem_lock))
+	/*
+	 * We'd better return EAGAIN for atomic pages, which will be committed
+	 * sooner or later. Don't botter transactions with inmem_lock.
+	 */
+	if (IS_ATOMIC_WRITTEN_PAGE(page))
 		return -EAGAIN;
 
+	BUG_ON(PageWriteback(page));	/* Writeback must be complete */
+
 	/*
 	 * A reference is expected if PagePrivate set when move mapping,
 	 * however F2FS breaks this for maintaining dirty page counts when
 	 * truncating pages. So here adjusting the 'extra_count' make it work.
 	 */
-	extra_count = (atomic_written ? 1 : 0) - page_has_private(page);
 	rc = migrate_page_move_mapping(mapping, newpage,
-				page, NULL, mode, extra_count);
-	if (rc != MIGRATEPAGE_SUCCESS) {
-		if (atomic_written)
-			mutex_unlock(&fi->inmem_lock);
+			page, NULL, mode, (page_has_private(page) ? -1 : 0));
+	if (rc != MIGRATEPAGE_SUCCESS)
 		return rc;
-	}
-
-	if (atomic_written) {
-		struct inmem_pages *cur;
-		list_for_each_entry(cur, &fi->inmem_pages, list)
-			if (cur->page == page) {
-				cur->page = newpage;
-				break;
-			}
-		mutex_unlock(&fi->inmem_lock);
-		put_page(page);
-		get_page(newpage);
-	}
 
 	if (PagePrivate(page))
 		SetPagePrivate(newpage);
-- 
2.13.0.rc1.294.g07d810a77f-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
