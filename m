From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 16/19] f2fs: split find_data_page according to specific purposes
Date: Fri,  1 May 2015 17:48:43 -0700
Message-ID: <1430527726-68547-16-git-send-email-jaegeuk@kernel.org>
References: <1430527726-68547-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1430527726-68547-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch splits find_data_page as follows.

1. f2fs_gc
 - use get_read_data_page() with read only

2. find_in_level
 - use find_data_page without locked page

3. truncate_partial_page
 - In the case cache_only mode, just drop cached page.
 - Ohterwise, use get_lock_data_page() and guarantee to truncate

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 127 ++++++++++++++++++++++-----------------------------------
 fs/f2fs/dir.c  |   2 +-
 fs/f2fs/f2fs.h |   3 +-
 fs/f2fs/file.c |  26 +++++++-----
 fs/f2fs/gc.c   |   5 +--
 5 files changed, 68 insertions(+), 95 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9ba30b4..3b76261 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -917,7 +917,7 @@ void f2fs_update_extent_cache(struct dnode_of_data *dn)
 		sync_inode_page(dn);
 }
 
-struct page *find_data_page(struct inode *inode, pgoff_t index, bool sync)
+struct page *get_read_data_page(struct inode *inode, pgoff_t index, int rw)
 {
 	struct address_space *mapping = inode->i_mapping;
 	struct dnode_of_data dn;
@@ -927,84 +927,9 @@ struct page *find_data_page(struct inode *inode, pgoff_t index, bool sync)
 	struct f2fs_io_info fio = {
 		.sbi = F2FS_I_SB(inode),
 		.type = DATA,
-		.rw = sync ? READ_SYNC : READA,
+		.rw = rw,
 	};
 
-	/*
-	 * If sync is false, it needs to check its block allocation.
-	 * This is need and triggered by two flows:
-	 *   gc and truncate_partial_data_page.
-	 */
-	if (!sync)
-		goto search;
-
-	page = find_get_page(mapping, index);
-	if (page && PageUptodate(page))
-		return page;
-	f2fs_put_page(page, 0);
-search:
-	if (f2fs_lookup_extent_cache(inode, index, &ei)) {
-		dn.data_blkaddr = ei.blk + index - ei.fofs;
-		goto got_it;
-	}
-
-	set_new_dnode(&dn, inode, NULL, NULL, 0);
-	err = get_dnode_of_data(&dn, index, LOOKUP_NODE);
-	if (err)
-		return ERR_PTR(err);
-	f2fs_put_dnode(&dn);
-
-	if (dn.data_blkaddr == NULL_ADDR)
-		return ERR_PTR(-ENOENT);
-
-	/* By fallocate(), there is no cached page, but with NEW_ADDR */
-	if (unlikely(dn.data_blkaddr == NEW_ADDR))
-		return ERR_PTR(-EINVAL);
-
-got_it:
-	page = grab_cache_page(mapping, index);
-	if (!page)
-		return ERR_PTR(-ENOMEM);
-
-	if (PageUptodate(page)) {
-		unlock_page(page);
-		return page;
-	}
-
-	fio.blk_addr = dn.data_blkaddr;
-	fio.page = page;
-	err = f2fs_submit_page_bio(&fio);
-	if (err)
-		return ERR_PTR(err);
-
-	if (sync) {
-		wait_on_page_locked(page);
-		if (unlikely(!PageUptodate(page))) {
-			f2fs_put_page(page, 0);
-			return ERR_PTR(-EIO);
-		}
-	}
-	return page;
-}
-
-/*
- * If it tries to access a hole, return an error.
- * Because, the callers, functions in dir.c and GC, should be able to know
- * whether this page exists or not.
- */
-struct page *get_lock_data_page(struct inode *inode, pgoff_t index)
-{
-	struct address_space *mapping = inode->i_mapping;
-	struct dnode_of_data dn;
-	struct page *page;
-	struct extent_info ei;
-	int err;
-	struct f2fs_io_info fio = {
-		.sbi = F2FS_I_SB(inode),
-		.type = DATA,
-		.rw = READ_SYNC,
-	};
-repeat:
 	page = grab_cache_page(mapping, index);
 	if (!page)
 		return ERR_PTR(-ENOMEM);
@@ -1026,10 +951,11 @@ repeat:
 		f2fs_put_page(page, 1);
 		return ERR_PTR(-ENOENT);
 	}
-
 got_it:
-	if (PageUptodate(page))
+	if (PageUptodate(page)) {
+		unlock_page(page);
 		return page;
+	}
 
 	/*
 	 * A new dentry page is allocated but not able to be written, since its
@@ -1040,6 +966,7 @@ got_it:
 	if (dn.data_blkaddr == NEW_ADDR) {
 		zero_user_segment(page, 0, PAGE_CACHE_SIZE);
 		SetPageUptodate(page);
+		unlock_page(page);
 		return page;
 	}
 
@@ -1048,7 +975,49 @@ got_it:
 	err = f2fs_submit_page_bio(&fio);
 	if (err)
 		return ERR_PTR(err);
+	return page;
+}
+
+struct page *find_data_page(struct inode *inode, pgoff_t index)
+{
+	struct address_space *mapping = inode->i_mapping;
+	struct page *page;
+
+	page = find_get_page(mapping, index);
+	if (page && PageUptodate(page))
+		return page;
+	f2fs_put_page(page, 0);
+
+	page = get_read_data_page(inode, index, READ_SYNC);
+	if (IS_ERR(page))
+		return page;
+
+	if (PageUptodate(page))
+		return page;
+
+	wait_on_page_locked(page);
+	if (unlikely(!PageUptodate(page))) {
+		f2fs_put_page(page, 0);
+		return ERR_PTR(-EIO);
+	}
+	return page;
+}
+
+/*
+ * If it tries to access a hole, return an error.
+ * Because, the callers, functions in dir.c and GC, should be able to know
+ * whether this page exists or not.
+ */
+struct page *get_lock_data_page(struct inode *inode, pgoff_t index)
+{
+	struct address_space *mapping = inode->i_mapping;
+	struct page *page;
+repeat:
+	page = get_read_data_page(inode, index, READ_SYNC);
+	if (IS_ERR(page))
+		return page;
 
+	/* wait for read completion */
 	lock_page(page);
 	if (unlikely(!PageUptodate(page))) {
 		f2fs_put_page(page, 1);
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 3a3302a..9d558d2 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -177,7 +177,7 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 
 	for (; bidx < end_block; bidx++) {
 		/* no need to allocate new dentry pages to all the indices */
-		dentry_page = find_data_page(dir, bidx, true);
+		dentry_page = find_data_page(dir, bidx);
 		if (IS_ERR(dentry_page)) {
 			room = true;
 			continue;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9e43ddc..78a4300 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1675,7 +1675,8 @@ void f2fs_destroy_extent_tree(struct inode *);
 void f2fs_init_extent_cache(struct inode *, struct f2fs_extent *);
 void f2fs_update_extent_cache(struct dnode_of_data *);
 void f2fs_preserve_extent_tree(struct inode *);
-struct page *find_data_page(struct inode *, pgoff_t, bool);
+struct page *get_read_data_page(struct inode *, pgoff_t, int);
+struct page *find_data_page(struct inode *, pgoff_t);
 struct page *get_lock_data_page(struct inode *, pgoff_t);
 struct page *get_new_data_page(struct inode *, struct page *, pgoff_t, bool);
 int do_write_data_page(struct f2fs_io_info *);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 0e58f02..cb002c0 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -461,28 +461,32 @@ void truncate_data_blocks(struct dnode_of_data *dn)
 }
 
 static int truncate_partial_data_page(struct inode *inode, u64 from,
-								bool force)
+								bool cache_only)
 {
 	unsigned offset = from & (PAGE_CACHE_SIZE - 1);
+	pgoff_t index = from >> PAGE_CACHE_SHIFT;
+	struct address_space *mapping = inode->i_mapping;
 	struct page *page;
 
-	if (!offset && !force)
+	if (!offset && !cache_only)
 		return 0;
 
-	page = find_data_page(inode, from >> PAGE_CACHE_SHIFT, force);
-	if (IS_ERR(page))
+	if (cache_only) {
+		page = grab_cache_page(mapping, index);
+		if (page && PageUptodate(page))
+			goto truncate_out;
+		f2fs_put_page(page, 1);
 		return 0;
+	}
 
-	lock_page(page);
-	if (unlikely(!PageUptodate(page) ||
-			page->mapping != inode->i_mapping))
-		goto out;
-
+	page = get_lock_data_page(inode, index);
+	if (IS_ERR(page))
+		return 0;
+truncate_out:
 	f2fs_wait_on_page_writeback(page, DATA);
 	zero_user(page, offset, PAGE_CACHE_SIZE - offset);
-	if (!force)
+	if (!cache_only)
 		set_page_dirty(page);
-out:
 	f2fs_put_page(page, 1);
 	return 0;
 }
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 1bd11f0..2e2afeb 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -607,9 +607,8 @@ next_step:
 				continue;
 
 			start_bidx = start_bidx_of_node(nofs, F2FS_I(inode));
-
-			data_page = find_data_page(inode,
-					start_bidx + ofs_in_node, false);
+			data_page = get_read_data_page(inode,
+					start_bidx + ofs_in_node, READA);
 			if (IS_ERR(data_page)) {
 				iput(inode);
 				continue;
-- 
2.1.1

