From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: fix a problem of a truncated inmem page
Date: Wed, 15 Mar 2017 20:45:45 +0800
Message-ID: <20170315124545.9777-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1co8Fv-00037Q-8X
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 15 Mar 2017 12:42:19 +0000
Received: from [45.249.212.187] (helo=dggrg01-dlp.huawei.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1co8Fs-0004u2-44
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 15 Mar 2017 12:42:19 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net

-start atomic write
   -set_page_dirty
      -register_inmem_page
				<--- truncate or punch hole
	  -commit atomic write

Here, may cause memory reclaim painc for page->mapping is null,
but private is -1.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/data.c    | 8 --------
 fs/f2fs/segment.c | 5 ++++-
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 1375fef..a91e479 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1948,10 +1948,6 @@ void f2fs_invalidate_page(struct page *page, unsigned int offset,
 		}
 	}
 
-	/* This is atomic written page, keep Private */
-	if (IS_ATOMIC_WRITTEN_PAGE(page))
-		return;
-
 	set_page_private(page, 0);
 	ClearPagePrivate(page);
 }
@@ -1962,10 +1958,6 @@ int f2fs_release_page(struct page *page, gfp_t wait)
 	if (PageDirty(page))
 		return 0;
 
-	/* This is atomic written page, keep Private */
-	if (IS_ATOMIC_WRITTEN_PAGE(page))
-		return 0;
-
 	set_page_private(page, 0);
 	ClearPagePrivate(page);
 	return 1;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 42727e4..bebac9a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -207,6 +207,9 @@ static int __revoke_inmem_pages(struct inode *inode,
 
 		lock_page(page);
 
+		if (page->mapping != inode->i_mapping)
+			goto delete;
+
 		if (recover) {
 			struct dnode_of_data dn;
 			struct node_info ni;
@@ -230,7 +233,7 @@ static int __revoke_inmem_pages(struct inode *inode,
 		set_page_private(page, 0);
 		ClearPagePrivate(page);
 		f2fs_put_page(page, 1);
-
+delete:
 		list_del(&cur->list);
 		kmem_cache_free(inmem_entry_slab, cur);
 		dec_page_count(F2FS_I_SB(inode), F2FS_INMEM_PAGES);
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
