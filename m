From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/2] f2fs: speed up handling holes in fiemap
Date: Tue, 26 Jan 2016 15:42:58 +0800
Message-ID: <009601d1580d$454d5490$cfe7fdb0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aNyI2-00034T-8m
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Jan 2016 07:43:50 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aNyHz-0008Ae-W5
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Jan 2016 07:43:50 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O1J033G6USGC850@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Jan 2016 16:43:40 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch makes f2fs_map_blocks supporting returning next potential
page offset which skips hole region in indirect tree of inode, and
use it to speed up fiemap in handling big hole case.

Test method:
xfs_io -f /mnt/f2fs/file  -c "pwrite 1099511627776 4096"
time xfs_io -f /mnt/f2fs/file -c "fiemap -v"

Before:
time xfs_io -f /mnt/f2fs/file -c "fiemap -v"
/mnt/f2fs/file:
 EXT: FILE-OFFSET              BLOCK-RANGE      TOTAL FLAGS
   0: [0..2147483647]:         hole             2147483648
   1: [2147483648..2147483655]: 81920..81927         8   0x1

real    3m3.518s
user    0m0.000s
sys     3m3.456s

After:
time xfs_io -f /mnt/f2fs/file -c "fiemap -v"
/mnt/f2fs/file:
 EXT: FILE-OFFSET              BLOCK-RANGE      TOTAL FLAGS
   0: [0..2147483647]:         hole             2147483648
   1: [2147483648..2147483655]: 81920..81927         8   0x1

real    0m0.008s
user    0m0.000s
sys     0m0.008s

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c | 35 ++++++++++++++++++++++++++---------
 fs/f2fs/f2fs.h |  1 +
 fs/f2fs/file.c |  2 +-
 3 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 0956219..59460af 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -540,6 +540,7 @@ static int __allocate_data_blocks(struct inode *inode, loff_t offset,
 
 	map.m_lblk = F2FS_BYTES_TO_BLK(offset);
 	map.m_len = F2FS_BYTES_TO_BLK(count);
+	map.m_next_pgofs = NULL;
 
 	return f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_DIO);
 }
@@ -587,8 +588,12 @@ next_dnode:
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
 	err = get_dnode_of_data(&dn, pgofs, mode);
 	if (err) {
-		if (err == -ENOENT)
+		if (err == -ENOENT) {
 			err = 0;
+			if (map->m_next_pgofs)
+				*map->m_next_pgofs =
+					get_next_page_offset(&dn, pgofs);
+		}
 		goto unlock_out;
 	}
 
@@ -610,6 +615,11 @@ next_block:
 			map->m_flags = F2FS_MAP_NEW;
 			blkaddr = dn.data_blkaddr;
 		} else {
+			if (flag == F2FS_GET_BLOCK_FIEMAP &&
+						blkaddr == NULL_ADDR) {
+				if (map->m_next_pgofs)
+					*map->m_next_pgofs = pgofs + 1;
+			}
 			if (flag != F2FS_GET_BLOCK_FIEMAP ||
 						blkaddr != NEW_ADDR) {
 				if (flag == F2FS_GET_BLOCK_BMAP)
@@ -670,13 +680,15 @@ out:
 }
 
 static int __get_data_block(struct inode *inode, sector_t iblock,
-			struct buffer_head *bh, int create, int flag)
+			struct buffer_head *bh, int create, int flag,
+			pgoff_t *next_pgofs)
 {
 	struct f2fs_map_blocks map;
 	int ret;
 
 	map.m_lblk = iblock;
 	map.m_len = bh->b_size >> inode->i_blkbits;
+	map.m_next_pgofs = next_pgofs;
 
 	ret = f2fs_map_blocks(inode, &map, create, flag);
 	if (!ret) {
@@ -688,16 +700,18 @@ static int __get_data_block(struct inode *inode, sector_t iblock,
 }
 
 static int get_data_block(struct inode *inode, sector_t iblock,
-			struct buffer_head *bh_result, int create, int flag)
+			struct buffer_head *bh_result, int create, int flag,
+			pgoff_t *next_pgofs)
 {
-	return __get_data_block(inode, iblock, bh_result, create, flag);
+	return __get_data_block(inode, iblock, bh_result, create,
+							flag, next_pgofs);
 }
 
 static int get_data_block_dio(struct inode *inode, sector_t iblock,
 			struct buffer_head *bh_result, int create)
 {
 	return __get_data_block(inode, iblock, bh_result, create,
-						F2FS_GET_BLOCK_DIO);
+						F2FS_GET_BLOCK_DIO, NULL);
 }
 
 static int get_data_block_bmap(struct inode *inode, sector_t iblock,
@@ -708,7 +722,7 @@ static int get_data_block_bmap(struct inode *inode, sector_t iblock,
 		return -EFBIG;
 
 	return __get_data_block(inode, iblock, bh_result, create,
-						F2FS_GET_BLOCK_BMAP);
+						F2FS_GET_BLOCK_BMAP, NULL);
 }
 
 static inline sector_t logical_to_blk(struct inode *inode, loff_t offset)
@@ -726,6 +740,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 {
 	struct buffer_head map_bh;
 	sector_t start_blk, last_blk;
+	pgoff_t next_pgofs;
 	loff_t isize;
 	u64 logical = 0, phys = 0, size = 0;
 	u32 flags = 0;
@@ -761,14 +776,15 @@ next:
 	map_bh.b_size = len;
 
 	ret = get_data_block(inode, start_blk, &map_bh, 0,
-					F2FS_GET_BLOCK_FIEMAP);
+					F2FS_GET_BLOCK_FIEMAP, &next_pgofs);
 	if (ret)
 		goto out;
 
 	/* HOLE */
 	if (!buffer_mapped(&map_bh)) {
+		start_blk = next_pgofs;
 		/* Go through holes util pass the EOF */
-		if (blk_to_logical(inode, start_blk++) < isize)
+		if (blk_to_logical(inode, start_blk) < isize)
 			goto prep_next;
 		/* Found a hole beyond isize means no more extents.
 		 * Note that the premise is that filesystems don't
@@ -836,6 +852,7 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 	map.m_lblk = 0;
 	map.m_len = 0;
 	map.m_flags = 0;
+	map.m_next_pgofs = NULL;
 
 	for (page_idx = 0; nr_pages; page_idx++, nr_pages--) {
 
@@ -874,7 +891,7 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 			map.m_len = last_block - block_in_file;
 
 			if (f2fs_map_blocks(inode, &map, 0,
-							F2FS_GET_BLOCK_READ))
+						F2FS_GET_BLOCK_READ))
 				goto set_error_page;
 		}
 got_it:
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3e1ba0a..d3dcf08 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -384,6 +384,7 @@ struct f2fs_map_blocks {
 	block_t m_lblk;
 	unsigned int m_len;
 	unsigned int m_flags;
+	pgoff_t *m_next_pgofs;		/* point next possible non-hole pgofs */
 };
 
 /* for flag in get_data_block */
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 2d73f14..bc6221f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1647,7 +1647,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 					struct f2fs_defragment *range)
 {
 	struct inode *inode = file_inode(filp);
-	struct f2fs_map_blocks map;
+	struct f2fs_map_blocks map = { .m_next_pgofs = NULL };
 	struct extent_info ei;
 	pgoff_t pg_start, pg_end;
 	unsigned int blk_per_seg = sbi->blocks_per_seg;
-- 
2.7.0.2.g1b0b6dd



------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
