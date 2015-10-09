From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: set GFP_NOFS for grab_cache_page
Date: Fri,  9 Oct 2015 15:55:40 -0700
Message-ID: <1444431340-45355-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

For normal inodes, their pages are allocated with __GFP_FS, which can cause
filesystem calls when reclaiming memory.
This can incur a dead lock condition accordingly.

So, this patch addresses this problem by introducing
f2fs_grab_cache_page(.., bool for_write), which calls
grab_cache_page_write_begin() with AOP_FLAG_NOFS.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 16 +++++++++-------
 fs/f2fs/dir.c  |  6 +++---
 fs/f2fs/f2fs.h | 12 ++++++++++--
 fs/f2fs/file.c |  6 +++---
 fs/f2fs/gc.c   |  6 +++---
 5 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index bc04e92..d4f1c74 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -275,7 +275,8 @@ int f2fs_get_block(struct dnode_of_data *dn, pgoff_t index)
 	return f2fs_reserve_block(dn, index);
 }
 
-struct page *get_read_data_page(struct inode *inode, pgoff_t index, int rw)
+struct page *get_read_data_page(struct inode *inode, pgoff_t index,
+						int rw, bool for_write)
 {
 	struct address_space *mapping = inode->i_mapping;
 	struct dnode_of_data dn;
@@ -292,7 +293,7 @@ struct page *get_read_data_page(struct inode *inode, pgoff_t index, int rw)
 	if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
 		return read_mapping_page(mapping, index, NULL);
 
-	page = grab_cache_page(mapping, index);
+	page = f2fs_grab_cache_page(mapping, index, for_write);
 	if (!page)
 		return ERR_PTR(-ENOMEM);
 
@@ -352,7 +353,7 @@ struct page *find_data_page(struct inode *inode, pgoff_t index)
 		return page;
 	f2fs_put_page(page, 0);
 
-	page = get_read_data_page(inode, index, READ_SYNC);
+	page = get_read_data_page(inode, index, READ_SYNC, false);
 	if (IS_ERR(page))
 		return page;
 
@@ -372,12 +373,13 @@ struct page *find_data_page(struct inode *inode, pgoff_t index)
  * Because, the callers, functions in dir.c and GC, should be able to know
  * whether this page exists or not.
  */
-struct page *get_lock_data_page(struct inode *inode, pgoff_t index)
+struct page *get_lock_data_page(struct inode *inode, pgoff_t index,
+							bool for_write)
 {
 	struct address_space *mapping = inode->i_mapping;
 	struct page *page;
 repeat:
-	page = get_read_data_page(inode, index, READ_SYNC);
+	page = get_read_data_page(inode, index, READ_SYNC, for_write);
 	if (IS_ERR(page))
 		return page;
 
@@ -411,7 +413,7 @@ struct page *get_new_data_page(struct inode *inode,
 	struct dnode_of_data dn;
 	int err;
 repeat:
-	page = grab_cache_page(mapping, index);
+	page = f2fs_grab_cache_page(mapping, index, true);
 	if (!page) {
 		/*
 		 * before exiting, we should make sure ipage will be released
@@ -439,7 +441,7 @@ repeat:
 	} else {
 		f2fs_put_page(page, 1);
 
-		page = get_read_data_page(inode, index, READ_SYNC);
+		page = get_read_data_page(inode, index, READ_SYNC, true);
 		if (IS_ERR(page))
 			goto repeat;
 
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 6726c4a..7c1678b 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -258,7 +258,7 @@ struct f2fs_dir_entry *f2fs_parent_dir(struct inode *dir, struct page **p)
 	if (f2fs_has_inline_dentry(dir))
 		return f2fs_parent_inline_dir(dir, p);
 
-	page = get_lock_data_page(dir, 0);
+	page = get_lock_data_page(dir, 0, false);
 	if (IS_ERR(page))
 		return NULL;
 
@@ -740,7 +740,7 @@ bool f2fs_empty_dir(struct inode *dir)
 		return f2fs_empty_inline_dir(dir);
 
 	for (bidx = 0; bidx < nblock; bidx++) {
-		dentry_page = get_lock_data_page(dir, bidx);
+		dentry_page = get_lock_data_page(dir, bidx, false);
 		if (IS_ERR(dentry_page)) {
 			if (PTR_ERR(dentry_page) == -ENOENT)
 				continue;
@@ -854,7 +854,7 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 				min(npages - n, (pgoff_t)MAX_DIR_RA_PAGES));
 
 	for (; n < npages; n++) {
-		dentry_page = get_lock_data_page(inode, n);
+		dentry_page = get_lock_data_page(inode, n, false);
 		if (IS_ERR(dentry_page))
 			continue;
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6f2310c..6ba5a59 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1233,6 +1233,14 @@ static inline unsigned int valid_inode_count(struct f2fs_sb_info *sbi)
 	return sbi->total_valid_inode_count;
 }
 
+static inline struct page *f2fs_grab_cache_page(struct address_space *mapping,
+						pgoff_t index, bool for_write)
+{
+	if (!for_write)
+		return grab_cache_page(mapping, index);
+	return grab_cache_page_write_begin(mapping, index, AOP_FLAG_NOFS);
+}
+
 static inline void f2fs_copy_page(struct page *src, struct page *dst)
 {
 	char *src_kaddr = kmap(src);
@@ -1831,9 +1839,9 @@ void set_data_blkaddr(struct dnode_of_data *);
 int reserve_new_block(struct dnode_of_data *);
 int f2fs_get_block(struct dnode_of_data *, pgoff_t);
 int f2fs_reserve_block(struct dnode_of_data *, pgoff_t);
-struct page *get_read_data_page(struct inode *, pgoff_t, int);
+struct page *get_read_data_page(struct inode *, pgoff_t, int, bool);
 struct page *find_data_page(struct inode *, pgoff_t);
-struct page *get_lock_data_page(struct inode *, pgoff_t);
+struct page *get_lock_data_page(struct inode *, pgoff_t, bool);
 struct page *get_new_data_page(struct inode *, struct page *, pgoff_t, bool);
 int do_write_data_page(struct f2fs_io_info *);
 int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *, u64, u64);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 8d5583b..5d2a2ee 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -505,14 +505,14 @@ static int truncate_partial_data_page(struct inode *inode, u64 from,
 		return 0;
 
 	if (cache_only) {
-		page = grab_cache_page(mapping, index);
+		page = f2fs_grab_cache_page(mapping, index, false);
 		if (page && PageUptodate(page))
 			goto truncate_out;
 		f2fs_put_page(page, 1);
 		return 0;
 	}
 
-	page = get_lock_data_page(inode, index);
+	page = get_lock_data_page(inode, index, true);
 	if (IS_ERR(page))
 		return 0;
 truncate_out:
@@ -879,7 +879,7 @@ static int __exchange_data_block(struct inode *inode, pgoff_t src,
 	} else {
 		struct page *psrc, *pdst;
 
-		psrc = get_lock_data_page(inode, src);
+		psrc = get_lock_data_page(inode, src, true);
 		if (IS_ERR(psrc))
 			return PTR_ERR(psrc);
 		pdst = get_new_data_page(inode, NULL, dst, false);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index e7cec86..94278db 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -550,7 +550,7 @@ static void move_encrypted_block(struct inode *inode, block_t bidx)
 	int err;
 
 	/* do not read out */
-	page = grab_cache_page(inode->i_mapping, bidx);
+	page = f2fs_grab_cache_page(inode->i_mapping, bidx, false);
 	if (!page)
 		return;
 
@@ -620,7 +620,7 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type)
 {
 	struct page *page;
 
-	page = get_lock_data_page(inode, bidx);
+	page = get_lock_data_page(inode, bidx, true);
 	if (IS_ERR(page))
 		return;
 
@@ -714,7 +714,7 @@ next_step:
 
 			start_bidx = start_bidx_of_node(nofs, F2FS_I(inode));
 			data_page = get_read_data_page(inode,
-					start_bidx + ofs_in_node, READA);
+					start_bidx + ofs_in_node, READA, true);
 			if (IS_ERR(data_page)) {
 				iput(inode);
 				continue;
-- 
2.1.1
