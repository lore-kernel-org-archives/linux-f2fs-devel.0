From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: avoid punch_hole overhead when releasing volatile data
Date: Wed, 18 Mar 2015 11:18:20 -0700
Message-ID: <1426702701-7757-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch is to avoid some punch_hole overhead when releasing volatile data.
If volatile data was not written yet, we just can make the first page as zero.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c  |  2 ++
 fs/f2fs/f2fs.h  |  6 ++++++
 fs/f2fs/file.c  |  6 ++++++
 fs/f2fs/inode.c | 10 ++++++++++
 4 files changed, 24 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f0a18a0..486113d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1291,6 +1291,8 @@ int do_write_data_page(struct page *page, struct f2fs_io_info *fio)
 		write_data_page(page, &dn, fio);
 		f2fs_update_extent_cache(&dn);
 		set_inode_flag(F2FS_I(inode), FI_APPEND_WRITE);
+		if (page->index == 0)
+			set_inode_flag(F2FS_I(inode), FI_FIRST_BLOCK_WRITTEN);
 	}
 out_writepage:
 	f2fs_put_dnode(&dn);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f2909c6..fec8acc 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1223,6 +1223,7 @@ enum {
 	FI_NEED_IPU,		/* used for ipu per file */
 	FI_ATOMIC_FILE,		/* indicate atomic file */
 	FI_VOLATILE_FILE,	/* indicate volatile file */
+	FI_FIRST_BLOCK_WRITTEN,	/* indicate #0 data block was written */
 	FI_DROP_CACHE,		/* drop dirty page cache */
 	FI_DATA_EXIST,		/* indicate data exists */
 };
@@ -1331,6 +1332,11 @@ static inline bool f2fs_is_volatile_file(struct inode *inode)
 	return is_inode_flag_set(F2FS_I(inode), FI_VOLATILE_FILE);
 }
 
+static inline bool f2fs_is_first_block_written(struct inode *inode)
+{
+	return is_inode_flag_set(F2FS_I(inode), FI_FIRST_BLOCK_WRITTEN);
+}
+
 static inline bool f2fs_is_drop_cache(struct inode *inode)
 {
 	return is_inode_flag_set(F2FS_I(inode), FI_DROP_CACHE);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d927f8e..d17ac60 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -437,6 +437,9 @@ int truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 		dn->data_blkaddr = NULL_ADDR;
 		f2fs_update_extent_cache(dn);
 		invalidate_blocks(sbi, blkaddr);
+		if (dn->ofs_in_node == 0 && IS_INODE(dn->node_page))
+			clear_inode_flag(F2FS_I(dn->inode),
+						FI_FIRST_BLOCK_WRITTEN);
 		nr_free++;
 	}
 	if (nr_free) {
@@ -1005,6 +1008,9 @@ static int f2fs_ioc_release_volatile_write(struct file *filp)
 	if (!f2fs_is_volatile_file(inode))
 		return 0;
 
+	if (!f2fs_is_first_block_written(inode))
+		return truncate_partial_data_page(inode, 0, true);
+
 	punch_hole(inode, 0, F2FS_BLKSIZE);
 	return 0;
 }
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index b508744..bb58009 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -51,6 +51,13 @@ static void __get_inode_rdev(struct inode *inode, struct f2fs_inode *ri)
 	}
 }
 
+static bool __written_first_block(struct f2fs_inode *ri)
+{
+	if (ri->i_addr[0] != NEW_ADDR && ri->i_addr[0] != NULL_ADDR)
+		return true;
+	return false;
+}
+
 static void __set_inode_rdev(struct inode *inode, struct f2fs_inode *ri)
 {
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode)) {
@@ -143,6 +150,9 @@ static int do_read_inode(struct inode *inode)
 	/* get rdev by using inline_info */
 	__get_inode_rdev(inode, ri);
 
+	if (__written_first_block(ri))
+		set_inode_flag(F2FS_I(inode), FI_FIRST_BLOCK_WRITTEN);
+
 	f2fs_put_page(node_page, 1);
 
 	stat_inc_inline_inode(inode);
-- 
2.1.1
