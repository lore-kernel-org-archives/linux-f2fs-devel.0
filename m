From: Weichao Guo <guoweichao@huawei.com>
Subject: [PATCH v2] F2FS customized migrate_page callback
Date: Tue, 20 Sep 2016 05:03:27 +0800
Message-ID: <1474319007-87855-1-git-send-email-guoweichao@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guoweichao@huawei.com>) id 1blyH4-0004L2-51
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 19 Sep 2016 13:06:18 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1blyGu-0001CL-3g
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 19 Sep 2016 13:06:18 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org
Cc: huxinwei@huawei.com, Weichao Guo <guoweichao@huawei.com>

This patch improves the migration of dirty pages and allows migrating atomic
written pages that F2FS uses in Page Cache. Instead of the fallback releasing
page path, it provides better performance for memory compaction, CMA and other
users of memory page migrating. For dirty pages, there is no need to write back
first when migrating. For an atomic written page before committing, we can
migrate the page and update the related 'inmem_pages' list at the same time.

Signed-off-by: Weichao Guo <guoweichao@huawei.com>
---
 fs/f2fs/checkpoint.c |  3 +++
 fs/f2fs/data.c       | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/f2fs.h       |  4 ++++
 fs/f2fs/node.c       |  3 +++
 4 files changed, 66 insertions(+)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index df56a43..a366521 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -388,6 +388,9 @@ const struct address_space_operations f2fs_meta_aops = {
 	.set_page_dirty	= f2fs_set_meta_page_dirty,
 	.invalidatepage = f2fs_invalidate_page,
 	.releasepage	= f2fs_release_page,
+#ifdef CONFIG_MIGRATION
+	.migratepage    = f2fs_migrate_page,
+#endif
 };
 
 static void __add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type)
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 528c3c0..eb0d63f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1882,6 +1882,59 @@ static sector_t f2fs_bmap(struct address_space *mapping, sector_t block)
 	return generic_block_bmap(mapping, block, get_data_block_bmap);
 }
 
+#ifdef CONFIG_MIGRATION
+
+#include <linux/migrate.h>
+
+int f2fs_migrate_page(struct address_space *mapping,
+		struct page *newpage, struct page *page, enum migrate_mode mode)
+{
+	int rc, extra_count;
+	struct f2fs_inode_info *fi = F2FS_I(mapping->host);
+	bool atomic_written = IS_ATOMIC_WRITTEN_PAGE(page);
+
+	BUG_ON(PageWriteback(page));
+
+	/* migrating an atomic written page is safe with the inmem_lock hold */
+	if (atomic_written && !mutex_trylock(&fi->inmem_lock))
+		return -EAGAIN;
+
+	/*
+	 * A reference is expected if PagePrivate set when move mapping,
+	 * however F2FS breaks this for maintaining dirty page counts when
+	 * truncating pages. So here adjusting the 'extra_count' make it work.
+	 */
+	extra_count = (atomic_written ? 1 : 0) - page_has_private(page);
+	rc = migrate_page_move_mapping(mapping, newpage,
+				page, NULL, mode, extra_count);
+	if (rc != MIGRATEPAGE_SUCCESS) {
+		if (atomic_written)
+			mutex_unlock(&fi->inmem_lock);
+		return rc;
+	}
+
+	if (atomic_written) {
+		struct inmem_pages *cur;
+		list_for_each_entry(cur, &fi->inmem_pages, list)
+			if (cur->page == page) {
+				cur->page = newpage;
+				break;
+			}
+		mutex_unlock(&fi->inmem_lock);
+		put_page(page);
+		get_page(newpage);
+	}
+
+	if (PagePrivate(page))
+		SetPagePrivate(newpage);
+	set_page_private(newpage, page_private(page));
+
+	migrate_page_copy(newpage, page);
+
+	return MIGRATEPAGE_SUCCESS;
+}
+#endif
+
 const struct address_space_operations f2fs_dblock_aops = {
 	.readpage	= f2fs_read_data_page,
 	.readpages	= f2fs_read_data_pages,
@@ -1894,4 +1947,7 @@ const struct address_space_operations f2fs_dblock_aops = {
 	.releasepage	= f2fs_release_page,
 	.direct_IO	= f2fs_direct_IO,
 	.bmap		= f2fs_bmap,
+#ifdef CONFIG_MIGRATION
+	.migratepage    = f2fs_migrate_page,
+#endif
 };
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5d2aa6a..b951482 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2126,6 +2126,10 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *, u64, u64);
 void f2fs_set_page_dirty_nobuffers(struct page *);
 void f2fs_invalidate_page(struct page *, unsigned int, unsigned int);
 int f2fs_release_page(struct page *, gfp_t);
+#ifdef CONFIG_MIGRATION
+int f2fs_migrate_page(struct address_space *mapping,
+	struct page *newpage, struct page *page, enum migrate_mode mode);
+#endif
 
 /*
  * gc.c
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 2322a8e..55c22a9 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1670,6 +1670,9 @@ const struct address_space_operations f2fs_node_aops = {
 	.set_page_dirty	= f2fs_set_node_page_dirty,
 	.invalidatepage	= f2fs_invalidate_page,
 	.releasepage	= f2fs_release_page,
+#ifdef CONFIG_MIGRATION
+	.migratepage    = f2fs_migrate_page,
+#endif
 };
 
 static struct free_nid *__lookup_free_nid_list(struct f2fs_nm_info *nm_i,
-- 
1.9.1


------------------------------------------------------------------------------
