From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 4/4] f2fs: remove inmem radix tree
Date: Fri, 07 Aug 2015 18:42:09 +0800
Message-ID: <018101d0d0fd$d01959d0$704c0d70$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Previously, we use radix tree to index all registered page entries for
atomic file, but now we only use radix tree to see whether current page
is indexed or not, since the other user of radix tree is gone in commit
042b7816aaeb ("f2fs: remove unnecessary call to invalidate inmemory pages").

So in this patch, we try to use one more efficient way:
Introducing a macro ATOMIC_WRITTEN_PAGE, and setting it as page private
value to indicate page indexing status. By using this way, we can save
memory and lookup time.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c    | 20 ++++++++++++++++++--
 fs/f2fs/f2fs.h    |  1 -
 fs/f2fs/segment.c | 25 +++++++++----------------
 fs/f2fs/segment.h |  9 +++++++++
 fs/f2fs/super.c   |  1 -
 5 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7ea8eda..cad9ebe 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1558,6 +1558,11 @@ void f2fs_invalidate_page(struct page *page, unsigned int offset,
 		else
 			inode_dec_dirty_pages(inode);
 	}
+
+	/* This is atomic written page, keep Private */
+	if (IS_ATOMIC_WRITTEN_PAGE(page))
+		return;
+
 	ClearPagePrivate(page);
 }
 
@@ -1567,6 +1572,10 @@ int f2fs_release_page(struct page *page, gfp_t wait)
 	if (PageDirty(page))
 		return 0;
 
+	/* This is atomic written page, keep Private */
+	if (IS_ATOMIC_WRITTEN_PAGE(page))
+		return 0;
+
 	ClearPagePrivate(page);
 	return 1;
 }
@@ -1581,8 +1590,15 @@ static int f2fs_set_data_page_dirty(struct page *page)
 	SetPageUptodate(page);
 
 	if (f2fs_is_atomic_file(inode)) {
-		register_inmem_page(inode, page);
-		return 1;
+		if (!IS_ATOMIC_WRITTEN_PAGE(page)) {
+			register_inmem_page(inode, page);
+			return 1;
+		}
+		/*
+		 * Previously, this page has been registered, we just
+		 * return here.
+		 */
+		return 0;
 	}
 
 	if (!PageDirty(page)) {
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4a6f69b..23bfc0c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -424,7 +424,6 @@ struct f2fs_inode_info {
 	unsigned long long xattr_ver;	/* cp version of xattr modification */
 	struct inode_entry *dirty_dir;	/* the pointer of dirty dir */
 
-	struct radix_tree_root inmem_root;	/* radix tree for inmem pages */
 	struct list_head inmem_pages;	/* inmemory pages managed by f2fs */
 	struct mutex inmem_lock;	/* lock for inmemory pages */
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1ad3cf3..cb6c61a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -197,28 +197,20 @@ void register_inmem_page(struct inode *inode, struct page *page)
 {
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct inmem_pages *new;
-	int err;
 
-	SetPagePrivate(page);
 	f2fs_trace_pid(page);
 
+	set_page_private(page, (unsigned long)ATOMIC_WRITTEN_PAGE);
+	SetPagePrivate(page);
+
 	new = f2fs_kmem_cache_alloc(inmem_entry_slab, GFP_NOFS);
 
 	/* add atomic page indices to the list */
 	new->page = page;
 	INIT_LIST_HEAD(&new->list);
-retry:
+
 	/* increase reference count with clean state */
 	mutex_lock(&fi->inmem_lock);
-	err = radix_tree_insert(&fi->inmem_root, page->index, new);
-	if (err == -EEXIST) {
-		mutex_unlock(&fi->inmem_lock);
-		kmem_cache_free(inmem_entry_slab, new);
-		return;
-	} else if (err) {
-		mutex_unlock(&fi->inmem_lock);
-		goto retry;
-	}
 	get_page(page);
 	list_add_tail(&new->list, &fi->inmem_pages);
 	inc_page_count(F2FS_I_SB(inode), F2FS_INMEM_PAGES);
@@ -255,8 +247,8 @@ int commit_inmem_pages(struct inode *inode, bool abort)
 
 	mutex_lock(&fi->inmem_lock);
 	list_for_each_entry_safe(cur, tmp, &fi->inmem_pages, list) {
+		lock_page(cur->page);
 		if (!abort) {
-			lock_page(cur->page);
 			if (cur->page->mapping == inode->i_mapping) {
 				set_page_dirty(cur->page);
 				f2fs_wait_on_page_writeback(cur->page, DATA);
@@ -271,12 +263,13 @@ int commit_inmem_pages(struct inode *inode, bool abort)
 					break;
 				}
 			}
-			f2fs_put_page(cur->page, 1);
 		} else {
 			trace_f2fs_commit_inmem_page(cur->page, INMEM_DROP);
-			put_page(cur->page);
 		}
-		radix_tree_delete(&fi->inmem_root, cur->page->index);
+		set_page_private(cur->page, 0);
+		ClearPagePrivate(cur->page);
+		f2fs_put_page(cur->page, 1);
+
 		list_del(&cur->list);
 		kmem_cache_free(inmem_entry_slab, cur);
 		dec_page_count(F2FS_I_SB(inode), F2FS_INMEM_PAGES);
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 230f9cd..d0bd952 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -177,6 +177,15 @@ struct segment_allocation {
 	void (*allocate_segment)(struct f2fs_sb_info *, int, bool);
 };
 
+/*
+ * this value is set in page as a private data which indicate that
+ * the page is atomically written, and it is in inmem_pages list.
+ */
+#define ATOMIC_WRITTEN_PAGE		0x0000ffff
+
+#define IS_ATOMIC_WRITTEN_PAGE(page)			\
+		(page_private(page) == (unsigned long)ATOMIC_WRITTEN_PAGE)
+
 struct inmem_pages {
 	struct list_head list;
 	struct page *page;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index e5efb53..4db5cd9 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -423,7 +423,6 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	fi->i_current_depth = 1;
 	fi->i_advise = 0;
 	init_rwsem(&fi->i_sem);
-	INIT_RADIX_TREE(&fi->inmem_root, GFP_NOFS);
 	INIT_LIST_HEAD(&fi->inmem_pages);
 	mutex_init(&fi->inmem_lock);
 
-- 
2.4.2
