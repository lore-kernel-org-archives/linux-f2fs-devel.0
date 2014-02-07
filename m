From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH] f2fs: clean up redundant function call
Date: Fri, 07 Feb 2014 14:44:37 +0900
Message-ID: <1391751877-21388-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1WBeGh-000462-Ps
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 07 Feb 2014 05:46:27 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WBeGf-0005LW-Lh
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 07 Feb 2014 05:46:27 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N0M006MK2OX8Y30@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 07 Feb 2014 14:46:09 +0900 (KST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch integrates inode_[inc|dec]_dirty_dents with inc_page_count to remove
redundant calls.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/checkpoint.c |  1 -
 fs/f2fs/data.c       | 11 ++---------
 fs/f2fs/dir.c        |  4 ++--
 fs/f2fs/f2fs.h       |  5 +++++
 fs/f2fs/gc.c         |  7 +------
 5 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 8f5dff1..427dd55 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -508,7 +508,6 @@ void set_dirty_dir_page(struct inode *inode, struct page *page)
 	if (__add_dirty_inode(inode, new))
 		kmem_cache_free(inode_entry_slab, new);
 
-	inc_page_count(sbi, F2FS_DIRTY_DENTS);
 	inode_inc_dirty_dents(inode);
 	SetPagePrivate(page);
 	spin_unlock(&sbi->dir_inode_lock);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d175ae3..b401be7 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -799,10 +799,7 @@ static int f2fs_write_data_page(struct page *page,
 	 */
 	offset = i_size & (PAGE_CACHE_SIZE - 1);
 	if ((page->index >= end_index + 1) || !offset) {
-		if (S_ISDIR(inode->i_mode)) {
-			dec_page_count(sbi, F2FS_DIRTY_DENTS);
-			inode_dec_dirty_dents(inode);
-		}
+		inode_dec_dirty_dents(inode);
 		goto out;
 	}
 
@@ -815,7 +812,6 @@ write:
 
 	/* Dentry blocks are controlled by checkpoint */
 	if (S_ISDIR(inode->i_mode)) {
-		dec_page_count(sbi, F2FS_DIRTY_DENTS);
 		inode_dec_dirty_dents(inode);
 		err = do_write_data_page(page, &fio);
 	} else {
@@ -1033,11 +1029,8 @@ static void f2fs_invalidate_data_page(struct page *page, unsigned int offset,
 				      unsigned int length)
 {
 	struct inode *inode = page->mapping->host;
-	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
-	if (S_ISDIR(inode->i_mode) && PageDirty(page)) {
-		dec_page_count(sbi, F2FS_DIRTY_DENTS);
+	if (PageDirty(page))
 		inode_dec_dirty_dents(inode);
-	}
 	ClearPagePrivate(page);
 }
 
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 92ce1db..e095a4f 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -531,7 +531,6 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	unsigned int bit_pos;
 	struct address_space *mapping = page->mapping;
 	struct inode *dir = mapping->host;
-	struct f2fs_sb_info *sbi = F2FS_SB(dir->i_sb);
 	int slots = GET_DENTRY_SLOTS(le16_to_cpu(dentry->name_len));
 	void *kaddr = page_address(page);
 	int i;
@@ -554,6 +553,8 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	dir->i_ctime = dir->i_mtime = CURRENT_TIME;
 
 	if (inode) {
+		struct f2fs_sb_info *sbi = F2FS_SB(dir->i_sb);
+
 		if (S_ISDIR(inode->i_mode)) {
 			drop_nlink(dir);
 			update_inode_page(dir);
@@ -576,7 +577,6 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 		truncate_hole(dir, page->index, page->index + 1);
 		clear_page_dirty_for_io(page);
 		ClearPageUptodate(page);
-		dec_page_count(sbi, F2FS_DIRTY_DENTS);
 		inode_dec_dirty_dents(dir);
 	}
 	f2fs_put_page(page, 1);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index aeff132..4841d12 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -662,6 +662,7 @@ static inline void inc_page_count(struct f2fs_sb_info *sbi, int count_type)
 
 static inline void inode_inc_dirty_dents(struct inode *inode)
 {
+	inc_page_count(F2FS_SB(inode->i_sb), F2FS_DIRTY_DENTS);
 	atomic_inc(&F2FS_I(inode)->dirty_dents);
 }
 
@@ -672,6 +673,10 @@ static inline void dec_page_count(struct f2fs_sb_info *sbi, int count_type)
 
 static inline void inode_dec_dirty_dents(struct inode *inode)
 {
+	if (!S_ISDIR(inode->i_mode))
+		return;
+
+	dec_page_count(F2FS_SB(inode->i_sb), F2FS_DIRTY_DENTS);
 	atomic_dec(&F2FS_I(inode)->dirty_dents);
 }
 
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index b0f5762..b161db4 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -531,15 +531,10 @@ static void move_data_page(struct inode *inode, struct page *page, int gc_type)
 		set_page_dirty(page);
 		set_cold_data(page);
 	} else {
-		struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
-
 		f2fs_wait_on_page_writeback(page, DATA);
 
-		if (clear_page_dirty_for_io(page) &&
-			S_ISDIR(inode->i_mode)) {
-			dec_page_count(sbi, F2FS_DIRTY_DENTS);
+		if (clear_page_dirty_for_io(page))
 			inode_dec_dirty_dents(inode);
-		}
 		set_cold_data(page);
 		do_write_data_page(page, &fio);
 		clear_cold_data(page);
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121051231&iu=/4140/ostg.clktrk
