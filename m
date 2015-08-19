From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 3/9] f2fs: fix incorrect mapping for bmap
Date: Wed, 19 Aug 2015 19:11:19 +0800
Message-ID: <017701d0da6f$de5127f0$9af377d0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

The test step is like below:
1. touch file
2. truncate -s $((1024*1024)) file
3. fallocate -o 0 -l $((1024*1024)) file
4. fibmap.f2fs file

Our result of fibmap.f2fs showed below is not correct:

file_pos   start_blk     end_blk        blks
       0    -937166132    -937166132           1
    4096    -937166132    -937166132           1
    8192    -937166132    -937166132           1
   12288    -937166132    -937166132           1
   16384    -937166132    -937166132           1
   20480    -937166132    -937166132           1
...
 1040384    -937166132    -937166132           1
 1044480    -937166132    -937166132           1

This is because f2fs_map_blocks will return with no error when meeting
a hole or preallocated block, the caller __get_data_block will map the
uninitialized variable value to bh->b_blocknr.

Unfortunately generic_block_bmap will neither check the return value of
get_data() nor check mapping info of buffer_head, result in returning
the random block address.

After fixing the issue, our result shows correctly:

file_pos   start_blk     end_blk        blks
       0           0           0         256

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c | 48 ++++++++++++++++++++++++++++++++++++------------
 fs/f2fs/f2fs.h |  6 ++++++
 2 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 91d4243..2371e69 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -661,7 +661,7 @@ out:
  *     c. give the block addresses to blockdev
  */
 static int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
-			int create, bool fiemap)
+						int create, int flag)
 {
 	unsigned int maxblocks = map->m_len;
 	struct dnode_of_data dn;
@@ -695,8 +695,19 @@ static int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 			err = 0;
 		goto unlock_out;
 	}
-	if (dn.data_blkaddr == NEW_ADDR && !fiemap)
-		goto put_out;
+	if (dn.data_blkaddr == NEW_ADDR) {
+		if (flag == F2FS_GET_BLOCK_BMAP) {
+			err = -ENOENT;
+			goto put_out;
+		} else if (flag == F2FS_GET_BLOCK_READ ||
+				flag == F2FS_GET_BLOCK_DIO) {
+			goto put_out;
+		}
+		/*
+		 * if it is in fiemap call path (flag = F2FS_GET_BLOCK_FIEMAP),
+		 * mark it as mapped and unwritten block.
+		 */
+	}
 
 	if (dn.data_blkaddr != NULL_ADDR) {
 		map->m_flags = F2FS_MAP_MAPPED;
@@ -711,6 +722,8 @@ static int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 		map->m_flags = F2FS_MAP_NEW | F2FS_MAP_MAPPED;
 		map->m_pblk = dn.data_blkaddr;
 	} else {
+		if (flag == F2FS_GET_BLOCK_BMAP)
+			err = -ENOENT;
 		goto put_out;
 	}
 
@@ -733,7 +746,9 @@ get_next:
 				err = 0;
 			goto unlock_out;
 		}
-		if (dn.data_blkaddr == NEW_ADDR && !fiemap)
+
+		if (dn.data_blkaddr == NEW_ADDR &&
+				flag != F2FS_GET_BLOCK_FIEMAP)
 			goto put_out;
 
 		end_offset = ADDRS_PER_PAGE(dn.node_page, F2FS_I(inode));
@@ -775,7 +790,7 @@ out:
 }
 
 static int __get_data_block(struct inode *inode, sector_t iblock,
-			struct buffer_head *bh, int create, bool fiemap)
+			struct buffer_head *bh, int create, int flag)
 {
 	struct f2fs_map_blocks map;
 	int ret;
@@ -783,7 +798,7 @@ static int __get_data_block(struct inode *inode, sector_t iblock,
 	map.m_lblk = iblock;
 	map.m_len = bh->b_size >> inode->i_blkbits;
 
-	ret = f2fs_map_blocks(inode, &map, create, fiemap);
+	ret = f2fs_map_blocks(inode, &map, create, flag);
 	if (!ret) {
 		map_bh(bh, inode->i_sb, map.m_pblk);
 		bh->b_state = (bh->b_state & ~F2FS_MAP_FLAGS) | map.m_flags;
@@ -793,15 +808,23 @@ static int __get_data_block(struct inode *inode, sector_t iblock,
 }
 
 static int get_data_block(struct inode *inode, sector_t iblock,
+			struct buffer_head *bh_result, int create, int flag)
+{
+	return __get_data_block(inode, iblock, bh_result, create, flag);
+}
+
+static int get_data_block_dio(struct inode *inode, sector_t iblock,
 			struct buffer_head *bh_result, int create)
 {
-	return __get_data_block(inode, iblock, bh_result, create, false);
+	return __get_data_block(inode, iblock, bh_result, create,
+						F2FS_GET_BLOCK_DIO);
 }
 
-static int get_data_block_fiemap(struct inode *inode, sector_t iblock,
+static int get_data_block_bmap(struct inode *inode, sector_t iblock,
 			struct buffer_head *bh_result, int create)
 {
-	return __get_data_block(inode, iblock, bh_result, create, true);
+	return __get_data_block(inode, iblock, bh_result, create,
+						F2FS_GET_BLOCK_BMAP);
 }
 
 static inline sector_t logical_to_blk(struct inode *inode, loff_t offset)
@@ -845,7 +868,8 @@ next:
 	memset(&map_bh, 0, sizeof(struct buffer_head));
 	map_bh.b_size = len;
 
-	ret = get_data_block_fiemap(inode, start_blk, &map_bh, 0);
+	ret = get_data_block(inode, start_blk, &map_bh, 0,
+					F2FS_GET_BLOCK_FIEMAP);
 	if (ret)
 		goto out;
 
@@ -1630,7 +1654,7 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 	if (iov_iter_rw(iter) == WRITE)
 		__allocate_data_blocks(inode, offset, count);
 
-	err = blockdev_direct_IO(iocb, inode, iter, offset, get_data_block);
+	err = blockdev_direct_IO(iocb, inode, iter, offset, get_data_block_dio);
 	if (err < 0 && iov_iter_rw(iter) == WRITE)
 		f2fs_write_failed(mapping, offset + count);
 
@@ -1718,7 +1742,7 @@ static sector_t f2fs_bmap(struct address_space *mapping, sector_t block)
 		if (err)
 			return err;
 	}
-	return generic_block_bmap(mapping, block, get_data_block);
+	return generic_block_bmap(mapping, block, get_data_block_bmap);
 }
 
 const struct address_space_operations f2fs_dblock_aops = {
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8be7ef0..7a62f6c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -378,6 +378,12 @@ struct f2fs_map_blocks {
 	unsigned int m_flags;
 };
 
+/* for flag in get_data_block */
+#define F2FS_GET_BLOCK_READ		0
+#define F2FS_GET_BLOCK_DIO		1
+#define F2FS_GET_BLOCK_FIEMAP		2
+#define F2FS_GET_BLOCK_BMAP		3
+
 /*
  * i_advise uses FADVISE_XXX_BIT. We can add additional hints later.
  */
-- 
2.4.2
