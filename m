From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: preallocate blocks for buffered aio writes
Date: Fri,  5 Feb 2016 18:57:10 -0800
Message-ID: <1454727430-13699-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch preallocates data blocks for buffered aio writes.
With this patch, we can avoid redundant locking and unlocking of node pages
given consecutive aio request.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c          | 36 ++++++++++++++++++++++++++++++------
 fs/f2fs/f2fs.h          |  1 +
 include/linux/f2fs_fs.h |  2 +-
 3 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b95e28e..5071cf3 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -571,16 +571,25 @@ ssize_t f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
 	ssize_t ret = 0;
 
 	map.m_lblk = F2FS_BYTES_TO_BLK(iocb->ki_pos);
-	map.m_len = F2FS_BYTES_TO_BLK(iov_iter_count(from));
+	map.m_len = F2FS_BLK_ALIGN(iov_iter_count(from));
 	map.m_next_pgofs = NULL;
 
-	if (iocb->ki_flags & IOCB_DIRECT &&
-		!(f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))) {
+	if (f2fs_encrypted_inode(inode))
+		return 0;
+
+	if (iocb->ki_flags & IOCB_DIRECT) {
+		ret = f2fs_convert_inline_inode(inode);
+		if (ret)
+			return ret;
+		return f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_DIO);
+	}
+	if (iocb->ki_pos + iov_iter_count(from) > MAX_INLINE_DATA) {
 		ret = f2fs_convert_inline_inode(inode);
 		if (ret)
 			return ret;
-		ret = f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_DIO);
 	}
+	if (!f2fs_has_inline_data(inode))
+		return f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_AIO);
 	return ret;
 }
 
@@ -647,7 +656,13 @@ next_block:
 				err = -EIO;
 				goto sync_out;
 			}
-			err = __allocate_data_block(&dn);
+			if (flag == F2FS_GET_BLOCK_PRE_AIO) {
+				if (blkaddr == NULL_ADDR)
+					err = reserve_new_block(&dn);
+				dn.data_blkaddr = NEW_ADDR;
+			} else {
+				err = __allocate_data_block(&dn);
+			}
 			if (err)
 				goto sync_out;
 			allocated = true;
@@ -679,7 +694,8 @@ next_block:
 	} else if ((map->m_pblk != NEW_ADDR &&
 			blkaddr == (map->m_pblk + ofs)) ||
 			(map->m_pblk == NEW_ADDR && blkaddr == NEW_ADDR) ||
-			flag == F2FS_GET_BLOCK_PRE_DIO) {
+			flag == F2FS_GET_BLOCK_PRE_DIO ||
+			flag == F2FS_GET_BLOCK_PRE_AIO) {
 		ofs++;
 		map->m_len++;
 	} else {
@@ -1417,6 +1433,14 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 	struct extent_info ei;
 	int err = 0;
 
+	/*
+	 * we already allocated all the blocks, so we don't need to get
+	 * the block addresses when there is no need to fill the page.
+	 */
+	if (!f2fs_has_inline_data(inode) && !f2fs_encrypted_inode(inode) &&
+					len == PAGE_CACHE_SIZE)
+		return 0;
+
 	if (f2fs_has_inline_data(inode) ||
 			(pos & PAGE_CACHE_MASK) >= i_size_read(inode)) {
 		f2fs_lock_op(sbi);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4451791..f6a841b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -392,6 +392,7 @@ struct f2fs_map_blocks {
 #define F2FS_GET_BLOCK_FIEMAP		2
 #define F2FS_GET_BLOCK_BMAP		3
 #define F2FS_GET_BLOCK_PRE_DIO		4
+#define F2FS_GET_BLOCK_PRE_AIO		5
 
 /*
  * i_advise uses FADVISE_XXX_BIT. We can add additional hints later.
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index ac80402..f43e6a0 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -21,7 +21,7 @@
 #define F2FS_BLKSIZE			4096	/* support only 4KB block */
 #define F2FS_BLKSIZE_BITS		12	/* bits for F2FS_BLKSIZE */
 #define F2FS_MAX_EXTENSION		64	/* # of extension entries */
-#define F2FS_BLK_ALIGN(x)	(((x) + F2FS_BLKSIZE - 1) / F2FS_BLKSIZE)
+#define F2FS_BLK_ALIGN(x)	(((x) + F2FS_BLKSIZE - 1) >> F2FS_BLKSIZE_BITS)
 
 #define NULL_ADDR		((block_t)0)	/* used as block_t addresses */
 #define NEW_ADDR		((block_t)-1)	/* used as block_t addresses */
-- 
2.6.3
