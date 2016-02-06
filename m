From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: move dio preallocation into f2fs_file_write_iter
Date: Fri,  5 Feb 2016 18:53:25 -0800
Message-ID: <1454727206-13615-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch moves preallocation code for direct IOs into f2fs_file_write_iter.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 38 +++++++++++++++++---------------------
 fs/f2fs/f2fs.h |  2 ++
 fs/f2fs/file.c | 22 ++++++++++++++++++++--
 3 files changed, 39 insertions(+), 23 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9ae43a7..b95e28e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -564,16 +564,24 @@ alloc:
 	return 0;
 }
 
-static int __allocate_data_blocks(struct inode *inode, loff_t offset,
-							size_t count)
+ssize_t f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
 {
+	struct inode *inode = file_inode(iocb->ki_filp);
 	struct f2fs_map_blocks map;
+	ssize_t ret = 0;
 
-	map.m_lblk = F2FS_BYTES_TO_BLK(offset);
-	map.m_len = F2FS_BYTES_TO_BLK(count);
+	map.m_lblk = F2FS_BYTES_TO_BLK(iocb->ki_pos);
+	map.m_len = F2FS_BYTES_TO_BLK(iov_iter_count(from));
 	map.m_next_pgofs = NULL;
 
-	return f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_DIO);
+	if (iocb->ki_flags & IOCB_DIRECT &&
+		!(f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))) {
+		ret = f2fs_convert_inline_inode(inode);
+		if (ret)
+			return ret;
+		ret = f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_DIO);
+	}
+	return ret;
 }
 
 /*
@@ -670,7 +678,8 @@ next_block:
 		map->m_len = 1;
 	} else if ((map->m_pblk != NEW_ADDR &&
 			blkaddr == (map->m_pblk + ofs)) ||
-			(map->m_pblk == NEW_ADDR && blkaddr == NEW_ADDR)) {
+			(map->m_pblk == NEW_ADDR && blkaddr == NEW_ADDR) ||
+			flag == F2FS_GET_BLOCK_PRE_DIO) {
 		ofs++;
 		map->m_len++;
 	} else {
@@ -1614,34 +1623,21 @@ static int check_direct_IO(struct inode *inode, struct iov_iter *iter,
 static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 			      loff_t offset)
 {
-	struct file *file = iocb->ki_filp;
-	struct address_space *mapping = file->f_mapping;
+	struct address_space *mapping = iocb->ki_filp->f_mapping;
 	struct inode *inode = mapping->host;
 	size_t count = iov_iter_count(iter);
 	int err;
 
-	/* we don't need to use inline_data strictly */
-	err = f2fs_convert_inline_inode(inode);
+	err = check_direct_IO(inode, iter, offset);
 	if (err)
 		return err;
 
 	if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
 		return 0;
 
-	err = check_direct_IO(inode, iter, offset);
-	if (err)
-		return err;
-
 	trace_f2fs_direct_IO_enter(inode, offset, count, iov_iter_rw(iter));
 
-	if (iov_iter_rw(iter) == WRITE) {
-		err = __allocate_data_blocks(inode, offset, count);
-		if (err)
-			goto out;
-	}
-
 	err = blockdev_direct_IO(iocb, inode, iter, offset, get_data_block_dio);
-out:
 	if (err < 0 && iov_iter_rw(iter) == WRITE)
 		f2fs_write_failed(mapping, offset + count);
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5f98236..4451791 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -391,6 +391,7 @@ struct f2fs_map_blocks {
 #define F2FS_GET_BLOCK_DIO		1
 #define F2FS_GET_BLOCK_FIEMAP		2
 #define F2FS_GET_BLOCK_BMAP		3
+#define F2FS_GET_BLOCK_PRE_DIO		4
 
 /*
  * i_advise uses FADVISE_XXX_BIT. We can add additional hints later.
@@ -1905,6 +1906,7 @@ void f2fs_submit_page_mbio(struct f2fs_io_info *);
 void set_data_blkaddr(struct dnode_of_data *);
 int reserve_new_block(struct dnode_of_data *);
 int f2fs_get_block(struct dnode_of_data *, pgoff_t);
+ssize_t f2fs_preallocate_blocks(struct kiocb *, struct iov_iter *);
 int f2fs_reserve_block(struct dnode_of_data *, pgoff_t);
 struct page *get_read_data_page(struct inode *, pgoff_t, int, bool);
 struct page *find_data_page(struct inode *, pgoff_t);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 50fa296..3ffb6c1 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1873,14 +1873,32 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct inode *inode = file_inode(iocb->ki_filp);
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file_inode(file);
+	ssize_t ret;
 
 	if (f2fs_encrypted_inode(inode) &&
 				!f2fs_has_encryption_key(inode) &&
 				f2fs_get_encryption_info(inode))
 		return -EACCES;
 
-	return generic_file_write_iter(iocb, from);
+	mutex_lock(&inode->i_mutex);
+	ret = generic_write_checks(iocb, from);
+	if (ret > 0) {
+		ret = f2fs_preallocate_blocks(iocb, from);
+		if (!ret)
+			ret = __generic_file_write_iter(iocb, from);
+	}
+	mutex_unlock(&inode->i_mutex);
+
+	if (ret > 0) {
+		ssize_t err;
+
+		err = generic_write_sync(file, iocb->ki_pos - ret, ret);
+		if (err < 0)
+			ret = err;
+	}
+	return ret;
 }
 
 #ifdef CONFIG_COMPAT
-- 
2.6.3
