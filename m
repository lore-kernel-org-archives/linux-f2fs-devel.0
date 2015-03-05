From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: fix to truncate inline data past EOF
Date: Thu, 05 Mar 2015 17:41:32 +0800
Message-ID: <00d101d05728$aac41570$004c4050$@samsung.com>
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
readability, then intruduces new truncate_inline_data() and use it to truncate
inline data in page #0 and inode page in truncate_partial_data_page() for
fixing.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/f2fs.h   |  1 +
 fs/f2fs/file.c   | 13 ++++++++-----
 fs/f2fs/inline.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 61 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 511d6cd..55dbbe7 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1754,6 +1754,7 @@ extern struct kmem_cache *inode_entry_slab;
  */
 bool f2fs_may_inline(struct inode *);
 void read_inline_data(struct page *, struct page *);
+int truncate_inline_data(struct inode *, u64 from);
 int f2fs_read_inline_data(struct inode *, struct page *);
 int f2fs_convert_inline_page(struct dnode_of_data *, struct page *);
 int f2fs_convert_inline_inode(struct inode *);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f1341c7..6c4443e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -461,6 +461,9 @@ static int truncate_partial_data_page(struct inode *inode, u64 from)
 	unsigned offset = from & (PAGE_CACHE_SIZE - 1);
 	struct page *page;
 
+	if (f2fs_has_inline_data(inode))
+		return 0;
+
 	if (!offset)
 		return 0;
 
@@ -497,14 +500,14 @@ int truncate_blocks(struct inode *inode, u64 from, bool lock)
 	if (lock)
 		f2fs_lock_op(sbi);
 
-	ipage = get_node_page(sbi, inode->i_ino);
-	if (IS_ERR(ipage)) {
-		err = PTR_ERR(ipage);
+	if (f2fs_has_inline_data(inode)) {
+		err = truncate_inline_data(inode, from);
 		goto out;
 	}
 
-	if (f2fs_has_inline_data(inode)) {
-		f2fs_put_page(ipage, 1);
+	ipage = get_node_page(sbi, inode->i_ino);
+	if (IS_ERR(ipage)) {
+		err = PTR_ERR(ipage);
 		goto out;
 	}
 
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 4ba9732..a8189c92 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -50,10 +50,57 @@ void read_inline_data(struct page *page, struct page *ipage)
 	SetPageUptodate(page);
 }
 
-static void truncate_inline_data(struct page *ipage)
+static void truncate_inline_inode(struct page *ipage, u64 from)
 {
+	void *addr = inline_data_addr(ipage);
+
 	f2fs_wait_on_page_writeback(ipage, NODE);
-	memset(inline_data_addr(ipage), 0, MAX_INLINE_DATA);
+	memset(addr + from, 0, MAX_INLINE_DATA - from);
+}
+
+int truncate_inline_data(struct inode *inode, u64 from)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct page *page, *ipage;
+	void *addr;
+	int err = 0;
+
+	/*
+	 * we should never truncate inline data past max inline data size,
+	 * because we always convert inline inode to normal one before
+	 * truncating real data if new size is past max inline data size.
+	 */
+	f2fs_bug_on(sbi, from > MAX_INLINE_DATA);
+
+	if (from == MAX_INLINE_DATA)
+		return 0;
+
+	page = grab_cache_page(inode->i_mapping, 0);
+	if (!page)
+		return -ENOMEM;
+
+	ipage = get_node_page(sbi, inode->i_ino);
+	if (IS_ERR(ipage)) {
+		err = PTR_ERR(ipage);
+		goto out;
+	}
+
+	if (!f2fs_has_inline_data(inode)) {
+		f2fs_put_page(ipage, 1);
+		goto out;
+	}
+
+	truncate_inline_inode(ipage, from);
+	set_page_dirty(ipage);
+
+	read_inline_data(page, ipage);
+	f2fs_put_page(ipage, 1);
+
+	addr = inline_data_addr(page);
+	memset(addr + from, 0, MAX_INLINE_DATA - from);
+out:
+	f2fs_put_page(page, 1);
+	return err;
 }
 
 int f2fs_read_inline_data(struct inode *inode, struct page *page)
@@ -131,7 +178,7 @@ no_update:
 	set_inode_flag(F2FS_I(dn->inode), FI_APPEND_WRITE);
 
 	/* clear inline data and flag after data writeback */
-	truncate_inline_data(dn->inode_page);
+	truncate_inline_inode(dn->inode_page, 0);
 clear_out:
 	stat_dec_inline_inode(dn->inode);
 	f2fs_clear_inline_inode(dn->inode);
@@ -245,7 +292,7 @@ process_inline:
 	if (f2fs_has_inline_data(inode)) {
 		ipage = get_node_page(sbi, inode->i_ino);
 		f2fs_bug_on(sbi, IS_ERR(ipage));
-		truncate_inline_data(ipage);
+		truncate_inline_inode(ipage, 0);
 		f2fs_clear_inline_inode(inode);
 		update_inode(inode, ipage);
 		f2fs_put_page(ipage, 1);
@@ -363,7 +410,7 @@ static int f2fs_convert_inline_dir(struct inode *dir, struct page *ipage,
 	set_page_dirty(page);
 
 	/* clear inline dir and flag after data writeback */
-	truncate_inline_data(ipage);
+	truncate_inline_inode(ipage, 0);
 
 	stat_dec_inline_dir(dir);
 	clear_inode_flag(F2FS_I(dir), FI_INLINE_DENTRY);
-- 
2.3.1
