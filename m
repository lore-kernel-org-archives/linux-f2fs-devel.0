From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/4] f2fs: split set_data_blkaddr from f2fs_update_extent_cache
Date: Thu, 19 Mar 2015 19:23:32 +0800
Message-ID: <000001d06237$3ba58150$b2f083f0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Split __set_data_blkaddr from f2fs_update_extent_cache for readability.

Additionally rename __set_data_blkaddr to set_data_blkaddr for exporting.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c     | 10 ++++------
 fs/f2fs/f2fs.h     |  1 +
 fs/f2fs/file.c     |  1 +
 fs/f2fs/inline.c   |  1 +
 fs/f2fs/recovery.c |  1 +
 5 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 1a3d86a..edeba35 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -200,7 +200,7 @@ alloc_new:
  *  ->node_page
  *    update block addresses in the node page
  */
-static void __set_data_blkaddr(struct dnode_of_data *dn)
+void set_data_blkaddr(struct dnode_of_data *dn)
 {
 	struct f2fs_node *rn;
 	__le32 *addr_array;
@@ -229,7 +229,7 @@ int reserve_new_block(struct dnode_of_data *dn)
 	trace_f2fs_reserve_new_block(dn->inode, dn->nid, dn->ofs_in_node);
 
 	dn->data_blkaddr = NEW_ADDR;
-	__set_data_blkaddr(dn);
+	set_data_blkaddr(dn);
 	mark_inode_dirty(dn->inode);
 	sync_inode_page(dn);
 	return 0;
@@ -783,9 +783,6 @@ void f2fs_update_extent_cache(struct dnode_of_data *dn)
 
 	f2fs_bug_on(F2FS_I_SB(dn->inode), dn->data_blkaddr == NEW_ADDR);
 
-	/* Update the page address in the parent node */
-	__set_data_blkaddr(dn);
-
 	if (is_inode_flag_set(fi, FI_NO_EXTENT))
 		return;
 
@@ -1031,7 +1028,7 @@ static int __allocate_data_block(struct dnode_of_data *dn)
 	allocate_data_block(sbi, NULL, NULL_ADDR, &dn->data_blkaddr, &sum, seg);
 
 	/* direct IO doesn't use extent cache to maximize the performance */
-	__set_data_blkaddr(dn);
+	set_data_blkaddr(dn);
 
 	/* update i_size */
 	fofs = start_bidx_of_node(ofs_of_node(dn->node_page), fi) +
@@ -1288,6 +1285,7 @@ int do_write_data_page(struct page *page, struct f2fs_io_info *fio)
 		set_inode_flag(F2FS_I(inode), FI_UPDATE_WRITE);
 	} else {
 		write_data_page(page, &dn, fio);
+		set_data_blkaddr(&dn);
 		f2fs_update_extent_cache(&dn);
 		set_inode_flag(F2FS_I(inode), FI_APPEND_WRITE);
 	}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f2909c6..c5c3ae9 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1572,6 +1572,7 @@ int f2fs_submit_page_bio(struct f2fs_sb_info *, struct page *,
 						struct f2fs_io_info *);
 void f2fs_submit_page_mbio(struct f2fs_sb_info *, struct page *,
 						struct f2fs_io_info *);
+void set_data_blkaddr(struct dnode_of_data *);
 int reserve_new_block(struct dnode_of_data *);
 int f2fs_reserve_block(struct dnode_of_data *, pgoff_t);
 void f2fs_shrink_extent_tree(struct f2fs_sb_info *, int);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d927f8e..e0f6b94 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -435,6 +435,7 @@ int truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 			continue;
 
 		dn->data_blkaddr = NULL_ADDR;
+		set_data_blkaddr(dn);
 		f2fs_update_extent_cache(dn);
 		invalidate_blocks(sbi, blkaddr);
 		nr_free++;
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index d3e0599..7484cff 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -131,6 +131,7 @@ no_update:
 	set_page_writeback(page);
 	fio.blk_addr = dn->data_blkaddr;
 	write_data_page(page, dn, &fio);
+	set_data_blkaddr(dn);
 	f2fs_update_extent_cache(dn);
 	f2fs_wait_on_page_writeback(page, DATA);
 	if (dirty)
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 6e40874..e60ffaa 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -403,6 +403,7 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 			/* write dummy data page */
 			recover_data_page(sbi, NULL, &sum, src, dest);
 			dn.data_blkaddr = dest;
+			set_data_blkaddr(&dn);
 			f2fs_update_extent_cache(&dn);
 			recovered++;
 		}
-- 
2.3.1
