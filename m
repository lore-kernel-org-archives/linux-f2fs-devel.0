From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH v2] f2fs: fix to truncate inline data past EOF
Date: Tue, 10 Mar 2015 13:16:25 +0800
Message-ID: <005001d05af1$7e755020$7b5ff060$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Previously if inode is with inline data, we will try to invalid partial inline
data in page #0 when we truncate size of inode in truncate_partial_data_page().
And then we set page #0 to dirty, after this we can synchronize inode page with
page #0 at ->writepage().

But sometimes we will fail to operate page #0 in truncate_partial_data_page()
due to below reason:
a) if offset is zero, we will skip setting page #0 to dirty.
b) if page #0 is not uptodate, we will fail to update it as it has no mapping
data.

So with following operations, we will meet recent data which should be
truncated.

1.write inline data to file
2.sync first data page to inode page
3.truncate file size to 0
4.truncate file size to max_inline_size
5.echo 1 > /proc/sys/vm/drop_caches
6.read file --> meet original inline data which is remained in inode page.

This patch renames truncate_inline_data() to truncate_inline_inode() for code
readability, then use truncate_inline_inode() to truncate inline data in inode
page in truncate_blocks() and truncate page #0 in truncate_partial_data_page()
for fixing.

v2:
 o truncate partially #0 page in truncate_partial_data_page to avoid keeping
   old data in #0 page.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/f2fs.h   |  1 +
 fs/f2fs/file.c   | 16 +++++++++++-----
 fs/f2fs/inline.c | 26 +++++++++++++++++++++-----
 3 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 511d6cd..c1ad404 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1754,6 +1754,7 @@ extern struct kmem_cache *inode_entry_slab;
  */
 bool f2fs_may_inline(struct inode *);
 void read_inline_data(struct page *, struct page *);
+bool truncate_inline_inode(struct page *, u64);
 int f2fs_read_inline_data(struct inode *, struct page *);
 int f2fs_convert_inline_page(struct dnode_of_data *, struct page *);
 int f2fs_convert_inline_inode(struct inode *);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f1341c7..d927f8e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -456,15 +456,16 @@ void truncate_data_blocks(struct dnode_of_data *dn)
 	truncate_data_blocks_range(dn, ADDRS_PER_BLOCK);
 }
 
-static int truncate_partial_data_page(struct inode *inode, u64 from)
+static int truncate_partial_data_page(struct inode *inode, u64 from,
+								bool force)
 {
 	unsigned offset = from & (PAGE_CACHE_SIZE - 1);
 	struct page *page;
 
-	if (!offset)
+	if (!offset && !force)
 		return 0;
 
-	page = find_data_page(inode, from >> PAGE_CACHE_SHIFT, false);
+	page = find_data_page(inode, from >> PAGE_CACHE_SHIFT, force);
 	if (IS_ERR(page))
 		return 0;
 
@@ -475,7 +476,8 @@ static int truncate_partial_data_page(struct inode *inode, u64 from)
 
 	f2fs_wait_on_page_writeback(page, DATA);
 	zero_user(page, offset, PAGE_CACHE_SIZE - offset);
-	set_page_dirty(page);
+	if (!force)
+		set_page_dirty(page);
 out:
 	f2fs_put_page(page, 1);
 	return 0;
@@ -489,6 +491,7 @@ int truncate_blocks(struct inode *inode, u64 from, bool lock)
 	pgoff_t free_from;
 	int count = 0, err = 0;
 	struct page *ipage;
+	bool truncate_page = false;
 
 	trace_f2fs_truncate_blocks_enter(inode, from);
 
@@ -504,7 +507,10 @@ int truncate_blocks(struct inode *inode, u64 from, bool lock)
 	}
 
 	if (f2fs_has_inline_data(inode)) {
+		if (truncate_inline_inode(ipage, from))
+			set_page_dirty(ipage);
 		f2fs_put_page(ipage, 1);
+		truncate_page = true;
 		goto out;
 	}
 
@@ -535,7 +541,7 @@ out:
 
 	/* lastly zero out the first data page */
 	if (!err)
-		err = truncate_partial_data_page(inode, from);
+		err = truncate_partial_data_page(inode, from, truncate_page);
 
 	trace_f2fs_truncate_blocks_exit(inode, err);
 	return err;
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 4ba9732..153c5e7 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -50,10 +50,26 @@ void read_inline_data(struct page *page, struct page *ipage)
 	SetPageUptodate(page);
 }
 
-static void truncate_inline_data(struct page *ipage)
+bool truncate_inline_inode(struct page *ipage, u64 from)
 {
+	void *addr;
+
+	/*
+	 * we should never truncate inline data past max inline data size,
+	 * because we always convert inline inode to normal one before
+	 * truncating real data if new size is past max inline data size.
+	 */
+	f2fs_bug_on(F2FS_P_SB(ipage), from > MAX_INLINE_DATA);
+
+	if (from >= MAX_INLINE_DATA)
+		return false;
+
+	addr = inline_data_addr(ipage);
+
 	f2fs_wait_on_page_writeback(ipage, NODE);
-	memset(inline_data_addr(ipage), 0, MAX_INLINE_DATA);
+	memset(addr + from, 0, MAX_INLINE_DATA - from);
+
+	return true;
 }
 
 int f2fs_read_inline_data(struct inode *inode, struct page *page)
@@ -131,7 +147,7 @@ no_update:
 	set_inode_flag(F2FS_I(dn->inode), FI_APPEND_WRITE);
 
 	/* clear inline data and flag after data writeback */
-	truncate_inline_data(dn->inode_page);
+	truncate_inline_inode(dn->inode_page, 0);
 clear_out:
 	stat_dec_inline_inode(dn->inode);
 	f2fs_clear_inline_inode(dn->inode);
@@ -245,7 +261,7 @@ process_inline:
 	if (f2fs_has_inline_data(inode)) {
 		ipage = get_node_page(sbi, inode->i_ino);
 		f2fs_bug_on(sbi, IS_ERR(ipage));
-		truncate_inline_data(ipage);
+		truncate_inline_inode(ipage, 0);
 		f2fs_clear_inline_inode(inode);
 		update_inode(inode, ipage);
 		f2fs_put_page(ipage, 1);
@@ -363,7 +379,7 @@ static int f2fs_convert_inline_dir(struct inode *dir, struct page *ipage,
 	set_page_dirty(page);
 
 	/* clear inline dir and flag after data writeback */
-	truncate_inline_data(ipage);
+	truncate_inline_inode(ipage, 0);
 
 	stat_dec_inline_dir(dir);
 	clear_inode_flag(F2FS_I(dir), FI_INLINE_DENTRY);
-- 
2.3.1
