From: Weichao Guo <guoweichao@huawei.com>
Subject: [PATCH] F2FS customized migrate_page callback
Date: Mon, 19 Sep 2016 18:52:14 +0800
Message-ID: <1474282334-52304-1-git-send-email-guoweichao@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guoweichao@huawei.com>) id 1blok8-0004ui-49
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 19 Sep 2016 02:55:40 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1blok2-0002Yy-9t
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 19 Sep 2016 02:55:40 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, yuchao0@huawei.com
Cc: huxinwei@huawei.com, Weichao Guo <guoweichao@huawei.com>

This patch improves the migration of dirty pages and allows migrating atomic
written pages that F2FS uses in Page Cache. Instead of the fallback releasing
page path, it provides better performance for memory compaction, CMA and other
users of memory page migrating. For dirty pages, there is no need to write back
first when migrating. For an atomic written page before committing, we can
migrate the page and update the related 'inmem_pages' list at the same time.
---
 fs/f2fs/checkpoint.c |  1 +
 fs/f2fs/data.c       | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/f2fs.h       |  2 ++
 fs/f2fs/node.c       |  1 +
 4 files changed, 53 insertions(+)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index df56a43..fdb1c27 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -388,6 +388,7 @@ const struct address_space_operations f2fs_meta_aops = {
 	.set_page_dirty	= f2fs_set_meta_page_dirty,
 	.invalidatepage = f2fs_invalidate_page,
 	.releasepage	= f2fs_release_page,
+	.migratepage    = f2fs_migrate_page,
 };
 
 static void __add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type)
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 528c3c0..3444648 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -22,6 +22,7 @@
 #include <linux/mm.h>
 #include <linux/memcontrol.h>
 #include <linux/cleancache.h>
+#include <linux/migrate.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -1882,6 +1883,53 @@ static sector_t f2fs_bmap(struct address_space *mapping, sector_t block)
 	return generic_block_bmap(mapping, block, get_data_block_bmap);
 }
 
+int f2fs_migrate_page(struct address_space *mapping,
+		struct page *newpage, struct page *page, enum migrate_mode mode)
+{
+	int rc, extra_count;
+	struct f2fs_inode_info *fi = F2FS_I(mapping->host);
+
+	BUG_ON(PageWriteback(page));
+
+	/* migrating an atomic written page is safe with the inmem_lock hold */
+	if (IS_ATOMIC_WRITTEN_PAGE(page) && !mutex_trylock(&fi->inmem_lock))
+		return -EAGAIN;
+
+	/*
+	 * A reference is expected if PagePrivate set when move mapping,
+	 * however F2FS breaks this for maintaining dirty page counts when
+	 * truncating pages. So here adjusting the 'extra_count' make it work.
+	 */
+	extra_count = !!IS_ATOMIC_WRITTEN_PAGE(page) - page_has_private(page);
+	rc = migrate_page_move_mapping(mapping, newpage,
+				page, NULL, mode, extra_count);
+	if (rc != MIGRATEPAGE_SUCCESS) {
+		if (IS_ATOMIC_WRITTEN_PAGE(page))
+			mutex_unlock(&fi->inmem_lock);
+		return rc;
+	}
+
+	if (IS_ATOMIC_WRITTEN_PAGE(page)) {
+		struct inmem_pages *cur, *tmp;
+		list_for_each_entry_safe(cur, tmp, &fi->inmem_pages, list)
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
+
 const struct address_space_operations f2fs_dblock_aops = {
 	.readpage	= f2fs_read_data_page,
 	.readpages	= f2fs_read_data_pages,
@@ -1894,4 +1942,5 @@ const struct address_space_operations f2fs_dblock_aops = {
 	.releasepage	= f2fs_release_page,
 	.direct_IO	= f2fs_direct_IO,
 	.bmap		= f2fs_bmap,
+	.migratepage    = f2fs_migrate_page,
 };
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5d2aa6a..c7274bb 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2126,6 +2126,8 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *, u64, u64);
 void f2fs_set_page_dirty_nobuffers(struct page *);
 void f2fs_invalidate_page(struct page *, unsigned int, unsigned int);
 int f2fs_release_page(struct page *, gfp_t);
+int f2fs_migrate_page(struct address_space *mapping,
+	struct page *newpage, struct page *page, enum migrate_mode mode);
 
 /*
  * gc.c
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 2322a8e..7c6bf6d 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1670,6 +1670,7 @@ const struct address_space_operations f2fs_node_aops = {
 	.set_page_dirty	= f2fs_set_node_page_dirty,
 	.invalidatepage	= f2fs_invalidate_page,
 	.releasepage	= f2fs_release_page,
+	.migratepage    = f2fs_migrate_page,
 };
 
 static struct free_nid *__lookup_free_nid_list(struct f2fs_nm_info *nm_i,
-- 
1.9.1


------------------------------------------------------------------------------
