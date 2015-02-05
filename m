From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: merge {invalidate,release}page for meta/node/data pages
Date: Thu, 05 Feb 2015 17:44:29 +0800
Message-ID: <006401d04128$7349ad50$59dd07f0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch merges ->{invalidate,release}page function for meta/node/data pages.

After this, duplication of codes could be removed.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/checkpoint.c | 24 ++----------------------
 fs/f2fs/data.c       | 24 ++++++++++++++++--------
 fs/f2fs/f2fs.h       |  2 ++
 fs/f2fs/node.c       | 23 ++---------------------
 4 files changed, 22 insertions(+), 51 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 470fa58..31a715b 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -309,32 +309,12 @@ static int f2fs_set_meta_page_dirty(struct page *page)
 	return 0;
 }
 
-static void f2fs_invalidate_meta_page(struct page *page, unsigned int offset,
-				      unsigned int length)
-{
-	struct inode *inode = page->mapping->host;
-
-	if (PageDirty(page))
-		dec_page_count(F2FS_I_SB(inode), F2FS_DIRTY_META);
-	ClearPagePrivate(page);
-}
-
-static int f2fs_release_meta_page(struct page *page, gfp_t wait)
-{
-	/* If this is dirty page, keep PagePrivate */
-	if (PageDirty(page))
-		return 0;
-
-	ClearPagePrivate(page);
-	return 1;
-}
-
 const struct address_space_operations f2fs_meta_aops = {
 	.writepage	= f2fs_write_meta_page,
 	.writepages	= f2fs_write_meta_pages,
 	.set_page_dirty	= f2fs_set_meta_page_dirty,
-	.invalidatepage = f2fs_invalidate_meta_page,
-	.releasepage	= f2fs_release_meta_page,
+	.invalidatepage = f2fs_invalidate_page,
+	.releasepage	= f2fs_release_page,
 };
 
 static void __add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type)
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 27dc3fd..d166557 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1115,20 +1115,28 @@ static ssize_t f2fs_direct_IO(int rw, struct kiocb *iocb,
 	return err;
 }
 
-static void f2fs_invalidate_data_page(struct page *page, unsigned int offset,
-				      unsigned int length)
+void f2fs_invalidate_page(struct page *page, unsigned int offset,
+							unsigned int length)
 {
 	struct inode *inode = page->mapping->host;
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 
-	if (offset % PAGE_CACHE_SIZE || length != PAGE_CACHE_SIZE)
+	if (inode->i_ino >= F2FS_ROOT_INO(sbi) &&
+		(offset % PAGE_CACHE_SIZE || length != PAGE_CACHE_SIZE))
 		return;
 
-	if (PageDirty(page))
-		inode_dec_dirty_pages(inode);
+	if (PageDirty(page)) {
+		if (inode->i_ino == F2FS_META_INO(sbi))
+			dec_page_count(sbi, F2FS_DIRTY_META);
+		else if (inode->i_ino == F2FS_NODE_INO(sbi))
+			dec_page_count(sbi, F2FS_DIRTY_NODES);
+		else
+			inode_dec_dirty_pages(inode);
+	}
 	ClearPagePrivate(page);
 }
 
-static int f2fs_release_data_page(struct page *page, gfp_t wait)
+int f2fs_release_page(struct page *page, gfp_t wait)
 {
 	/* If this is dirty page, keep PagePrivate */
 	if (PageDirty(page))
@@ -1183,8 +1191,8 @@ const struct address_space_operations f2fs_dblock_aops = {
 	.write_begin	= f2fs_write_begin,
 	.write_end	= f2fs_write_end,
 	.set_page_dirty	= f2fs_set_data_page_dirty,
-	.invalidatepage	= f2fs_invalidate_data_page,
-	.releasepage	= f2fs_release_data_page,
+	.invalidatepage	= f2fs_invalidate_page,
+	.releasepage	= f2fs_release_page,
 	.direct_IO	= f2fs_direct_IO,
 	.bmap		= f2fs_bmap,
 };
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 47a8857..03929dc 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1522,6 +1522,8 @@ struct page *get_lock_data_page(struct inode *, pgoff_t);
 struct page *get_new_data_page(struct inode *, struct page *, pgoff_t, bool);
 int do_write_data_page(struct page *, struct f2fs_io_info *);
 int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *, u64, u64);
+void f2fs_invalidate_page(struct page *, unsigned int, unsigned int);
+int f2fs_release_page(struct page *, gfp_t);
 
 /*
  * gc.c
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 9feda38..ea22c32 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1370,25 +1370,6 @@ static int f2fs_set_node_page_dirty(struct page *page)
 	return 0;
 }
 
-static void f2fs_invalidate_node_page(struct page *page, unsigned int offset,
-				      unsigned int length)
-{
-	struct inode *inode = page->mapping->host;
-	if (PageDirty(page))
-		dec_page_count(F2FS_I_SB(inode), F2FS_DIRTY_NODES);
-	ClearPagePrivate(page);
-}
-
-static int f2fs_release_node_page(struct page *page, gfp_t wait)
-{
-	/* If this is dirty page, keep PagePrivate */
-	if (PageDirty(page))
-		return 0;
-
-	ClearPagePrivate(page);
-	return 1;
-}
-
 /*
  * Structure of the f2fs node operations
  */
@@ -1396,8 +1377,8 @@ const struct address_space_operations f2fs_node_aops = {
 	.writepage	= f2fs_write_node_page,
 	.writepages	= f2fs_write_node_pages,
 	.set_page_dirty	= f2fs_set_node_page_dirty,
-	.invalidatepage	= f2fs_invalidate_node_page,
-	.releasepage	= f2fs_release_node_page,
+	.invalidatepage	= f2fs_invalidate_page,
+	.releasepage	= f2fs_release_page,
 };
 
 static struct free_nid *__lookup_free_nid_list(struct f2fs_nm_info *nm_i,
-- 
2.2.1
