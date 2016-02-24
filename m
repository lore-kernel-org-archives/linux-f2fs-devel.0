From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/3] f2fs: introduce f2fs_update_data_blkaddr for cleanup
Date: Wed, 24 Feb 2016 17:16:47 +0800
Message-ID: <00e401d16ee4$2d5159c0$87f40d40$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Add a new help f2fs_update_data_blkaddr to clean up redundant codes.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c         |  9 +++++++--
 fs/f2fs/extent_cache.c |  9 ++++++---
 fs/f2fs/f2fs.h         |  1 +
 fs/f2fs/file.c         | 15 +++------------
 fs/f2fs/gc.c           |  4 +---
 fs/f2fs/inline.c       |  2 --
 fs/f2fs/segment.c      |  6 ++----
 7 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a6e7133..060c5f7 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -295,6 +295,13 @@ void set_data_blkaddr(struct dnode_of_data *dn)
 		dn->node_changed = true;
 }
 
+void f2fs_update_data_blkaddr(struct dnode_of_data *dn, block_t blkaddr)
+{
+	dn->data_blkaddr = blkaddr;
+	set_data_blkaddr(dn);
+	f2fs_update_extent_cache(dn);
+}
+
 int reserve_new_block(struct dnode_of_data *dn)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
@@ -1105,8 +1112,6 @@ int do_write_data_page(struct f2fs_io_info *fio)
 		trace_f2fs_do_write_data_page(page, IPU);
 	} else {
 		write_data_page(&dn, fio);
-		set_data_blkaddr(&dn);
-		f2fs_update_extent_cache(&dn);
 		trace_f2fs_do_write_data_page(page, OPU);
 		set_inode_flag(F2FS_I(inode), FI_APPEND_WRITE);
 		if (page->index == 0)
diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 071a1b1..c859bb0 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -674,17 +674,20 @@ bool f2fs_lookup_extent_cache(struct inode *inode, pgoff_t pgofs,
 void f2fs_update_extent_cache(struct dnode_of_data *dn)
 {
 	pgoff_t fofs;
+	block_t blkaddr;
 
 	if (!f2fs_may_extent_tree(dn->inode))
 		return;
 
-	f2fs_bug_on(F2FS_I_SB(dn->inode), dn->data_blkaddr == NEW_ADDR);
-
+	if (dn->data_blkaddr == NEW_ADDR)
+		blkaddr = NULL_ADDR;
+	else
+		blkaddr = dn->data_blkaddr;
 
 	fofs = start_bidx_of_node(ofs_of_node(dn->node_page), dn->inode) +
 								dn->ofs_in_node;
 
-	if (f2fs_update_extent_tree_range(dn->inode, fofs, dn->data_blkaddr, 1))
+	if (f2fs_update_extent_tree_range(dn->inode, fofs, blkaddr, 1))
 		sync_inode_page(dn);
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a7197b3..6e88a66 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1876,6 +1876,7 @@ void f2fs_submit_merged_bio_cond(struct f2fs_sb_info *, struct inode *,
 int f2fs_submit_page_bio(struct f2fs_io_info *);
 void f2fs_submit_page_mbio(struct f2fs_io_info *);
 void set_data_blkaddr(struct dnode_of_data *);
+void f2fs_update_data_blkaddr(struct dnode_of_data *, block_t);
 int reserve_new_block(struct dnode_of_data *);
 int f2fs_get_block(struct dnode_of_data *, pgoff_t);
 ssize_t f2fs_preallocate_blocks(struct kiocb *, struct iov_iter *);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index aa30ff0..935a60a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -858,10 +858,8 @@ static int __exchange_data_block(struct inode *inode, pgoff_t src,
 	} else {
 		new_addr = dn.data_blkaddr;
 		if (!is_checkpointed_data(sbi, new_addr)) {
-			dn.data_blkaddr = NULL_ADDR;
 			/* do not invalidate this block address */
-			set_data_blkaddr(&dn);
-			f2fs_update_extent_cache(&dn);
+			f2fs_update_data_blkaddr(&dn, NULL_ADDR);
 			do_replace = true;
 		}
 		f2fs_put_dnode(&dn);
@@ -912,9 +910,7 @@ static int __exchange_data_block(struct inode *inode, pgoff_t src,
 
 err_out:
 	if (!get_dnode_of_data(&dn, src, LOOKUP_NODE)) {
-		dn.data_blkaddr = new_addr;
-		set_data_blkaddr(&dn);
-		f2fs_update_extent_cache(&dn);
+		f2fs_update_data_blkaddr(&dn, new_addr);
 		f2fs_put_dnode(&dn);
 	}
 	return ret;
@@ -1054,12 +1050,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 
 			if (dn.data_blkaddr != NEW_ADDR) {
 				invalidate_blocks(sbi, dn.data_blkaddr);
-
-				dn.data_blkaddr = NEW_ADDR;
-				set_data_blkaddr(&dn);
-
-				dn.data_blkaddr = NULL_ADDR;
-				f2fs_update_extent_cache(&dn);
+				f2fs_update_data_blkaddr(&dn, NEW_ADDR);
 			}
 			f2fs_put_dnode(&dn);
 			f2fs_unlock_op(sbi);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 5368a6b..d0b80ab 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -621,9 +621,7 @@ static void move_encrypted_block(struct inode *inode, block_t bidx)
 	fio.new_blkaddr = newaddr;
 	f2fs_submit_page_mbio(&fio);
 
-	dn.data_blkaddr = fio.new_blkaddr;
-	set_data_blkaddr(&dn);
-	f2fs_update_extent_cache(&dn);
+	f2fs_update_data_blkaddr(&dn, newaddr);
 	set_inode_flag(F2FS_I(inode), FI_APPEND_WRITE);
 	if (page->index == 0)
 		set_inode_flag(F2FS_I(inode), FI_FIRST_BLOCK_WRITTEN);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index a89ca37..f0c6aca 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -133,8 +133,6 @@ int f2fs_convert_inline_page(struct dnode_of_data *dn, struct page *page)
 	set_page_writeback(page);
 	fio.old_blkaddr = dn->data_blkaddr;
 	write_data_page(dn, &fio);
-	set_data_blkaddr(dn);
-	f2fs_update_extent_cache(dn);
 	f2fs_wait_on_page_writeback(page, DATA, true);
 	if (dirty)
 		inode_dec_dirty_pages(dn->inode);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 639c4ff..6f16b39 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1429,7 +1429,7 @@ void write_data_page(struct dnode_of_data *dn, struct f2fs_io_info *fio)
 	get_node_info(sbi, dn->nid, &ni);
 	set_summary(&sum, dn->nid, dn->ofs_in_node, ni.version);
 	do_write_page(&sum, fio);
-	dn->data_blkaddr = fio->new_blkaddr;
+	f2fs_update_data_blkaddr(dn, fio->new_blkaddr);
 }
 
 void rewrite_data_page(struct f2fs_io_info *fio)
@@ -1518,9 +1518,7 @@ void f2fs_replace_block(struct f2fs_sb_info *sbi, struct dnode_of_data *dn,
 	__f2fs_replace_block(sbi, &sum, old_addr, new_addr,
 					recover_curseg, recover_newaddr);
 
-	dn->data_blkaddr = new_addr;
-	set_data_blkaddr(dn);
-	f2fs_update_extent_cache(dn);
+	f2fs_update_data_blkaddr(dn, new_addr);
 }
 
 void f2fs_wait_on_page_writeback(struct page *page,
-- 
2.7.0
