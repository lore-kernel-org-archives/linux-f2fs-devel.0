From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH v2 1/7] f2fs: reorganize f2fs_map_blocks
Date: Fri, 18 Sep 2015 16:51:51 +0800
Message-ID: <00ca01d0f1ef$5b231d10$11695730$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZcrPc-0004z4-4C
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 18 Sep 2015 08:52:56 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZcrPa-0001Hj-8a
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 18 Sep 2015 08:52:56 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NUV01QOR7BKQS40@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 18 Sep 2015 17:52:32 +0900 (KST)
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

In this patch, we try to reorganize f2fs_map_blocks to make block mapping
flow more clear by using following structure:

/* check status of mapping */

if (unmapped) {
	/* blkaddr == NULL_ADDR || blkaddr == NEW_ADDR */

	if (create) {
		/* write path, handle dio write case here */
		alloc_and_map;
	} else {
		/*
		 * handle read cases from all call paths:
		 *     1. generic read;
		 *     2. dio read;
		 *     3. fiemap;
		 *     4. bmap
		 */
	}
}

/* map buffer_header */

Besides, this patch handles the missing case correctly for dio write:
When we fail in __allocate_data_blocks, then in f2fs_map_blocks, we will
not allocate blocks correctly for preallocated blocks, but returning with
an unmapped buffer head, which will result in failure of dio write.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
v2:
 o fix incorrect judgment condition pointed out by Fan Li.
 fs/f2fs/data.c | 84 ++++++++++++++++++++++++++++++----------------------------
 1 file changed, 44 insertions(+), 40 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 681373e..883b649 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -596,40 +596,36 @@ static int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 			err = 0;
 		goto unlock_out;
 	}
-	if (dn.data_blkaddr == NEW_ADDR) {
-		if (flag == F2FS_GET_BLOCK_BMAP) {
-			err = -ENOENT;
-			goto put_out;
-		} else if (flag == F2FS_GET_BLOCK_READ ||
-				flag == F2FS_GET_BLOCK_DIO) {
-			goto put_out;
+
+	if (dn.data_blkaddr == NEW_ADDR || dn.data_blkaddr == NULL_ADDR) {
+		if (create) {
+			err = __allocate_data_block(&dn);
+			if (err)
+				goto put_out;
+			allocated = true;
+			map->m_flags = F2FS_MAP_NEW;
+		} else {
+			if (flag != F2FS_GET_BLOCK_FIEMAP ||
+						dn.data_blkaddr != NEW_ADDR) {
+				if (flag == F2FS_GET_BLOCK_BMAP)
+					err = -ENOENT;
+				goto put_out;
+			}
+
+			/*
+			 * preallocated unwritten block should be mapped
+			 * for fiemap.
+			 */
+			if (dn.data_blkaddr == NEW_ADDR)
+				map->m_flags = F2FS_MAP_UNWRITTEN;
 		}
-		/*
-		 * if it is in fiemap call path (flag = F2FS_GET_BLOCK_FIEMAP),
-		 * mark it as mapped and unwritten block.
-		 */
 	}
 
-	if (dn.data_blkaddr != NULL_ADDR) {
-		map->m_flags = F2FS_MAP_MAPPED;
-		map->m_pblk = dn.data_blkaddr;
-		if (dn.data_blkaddr == NEW_ADDR)
-			map->m_flags |= F2FS_MAP_UNWRITTEN;
-	} else if (create) {
-		err = __allocate_data_block(&dn);
-		if (err)
-			goto put_out;
-		allocated = true;
-		map->m_flags = F2FS_MAP_NEW | F2FS_MAP_MAPPED;
-		map->m_pblk = dn.data_blkaddr;
-	} else {
-		if (flag == F2FS_GET_BLOCK_BMAP)
-			err = -ENOENT;
-		goto put_out;
-	}
+	map->m_flags |= F2FS_MAP_MAPPED;
+	map->m_pblk = dn.data_blkaddr;
+	map->m_len = 1;
 
 	end_offset = ADDRS_PER_PAGE(dn.node_page, F2FS_I(inode));
-	map->m_len = 1;
 	dn.ofs_in_node++;
 	pgofs++;
 
@@ -648,23 +644,31 @@ get_next:
 			goto unlock_out;
 		}
 
-		if (dn.data_blkaddr == NEW_ADDR &&
-				flag != F2FS_GET_BLOCK_FIEMAP)
-			goto put_out;
-
 		end_offset = ADDRS_PER_PAGE(dn.node_page, F2FS_I(inode));
 	}
 
 	if (maxblocks > map->m_len) {
 		block_t blkaddr = datablock_addr(dn.node_page, dn.ofs_in_node);
-		if (blkaddr == NULL_ADDR && create) {
-			err = __allocate_data_block(&dn);
-			if (err)
-				goto sync_out;
-			allocated = true;
-			map->m_flags |= F2FS_MAP_NEW;
-			blkaddr = dn.data_blkaddr;
+
+		if (blkaddr == NEW_ADDR || blkaddr == NULL_ADDR) {
+			if (create) {
+				err = __allocate_data_block(&dn);
+				if (err)
+					goto sync_out;
+				allocated = true;
+				map->m_flags |= F2FS_MAP_NEW;
+				blkaddr = dn.data_blkaddr;
+			} else {
+				/*
+				 * we only merge preallocated unwritten blocks
+				 * for fiemap.
+				 */
+				if (flag != F2FS_GET_BLOCK_FIEMAP ||
+						blkaddr != NEW_ADDR)
+					goto sync_out;
+			}
 		}
+
 		/* Give more consecutive addresses for the readahead */
 		if ((map->m_pblk != NEW_ADDR &&
 				blkaddr == (map->m_pblk + ofs)) ||
-- 
2.5.2



------------------------------------------------------------------------------
