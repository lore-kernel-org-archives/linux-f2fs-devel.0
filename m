From: Fan Li <fanofcode.li@samsung.com>
Subject: [PATCH] f2fs: optimize the flow of f2fs_map_blocks
Date: Thu, 17 Dec 2015 13:20:59 +0800
Message-ID: <004c01d1388a$cfa319b0$6ee94d10$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fanofcode.li@samsung.com>) id 1a9R0i-0004GJ-SJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Dec 2015 05:21:52 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1a9R0h-0002eb-1M
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Dec 2015 05:21:52 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NZH00Z8ELK72A40@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 17 Dec 2015 14:21:43 +0900 (KST)
Content-language: en-us
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

check map->m_len right after it changes to avoid excess call
to update dnode_of_data.

Signed-off-by: Fan li <fanofcode.li@samsung.com>
---
 fs/f2fs/data.c |   69 +++++++++++++++++++++++++++++---------------------------
 1 file changed, 36 insertions(+), 33 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 90a2ffe..8fa4560 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -573,6 +573,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 	int err = 0, ofs = 1;
 	struct extent_info ei;
 	bool allocated = false;
+	block_t blkaddr;

 	map->m_len = 0;
 	map->m_flags = 0;
@@ -636,6 +637,9 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 	pgofs++;

 get_next:
+	if (map->m_len >= maxblocks)
+		goto sync_out;
+
 	if (dn.ofs_in_node >= end_offset) {
 		if (allocated)
 			sync_inode_page(&dn);
@@ -653,44 +657,43 @@ get_next:
 		end_offset = ADDRS_PER_PAGE(dn.node_page, F2FS_I(inode));
 	}

-	if (maxblocks > map->m_len) {
-		block_t blkaddr = datablock_addr(dn.node_page, dn.ofs_in_node);
+	blkaddr = datablock_addr(dn.node_page, dn.ofs_in_node);

-		if (blkaddr == NEW_ADDR || blkaddr == NULL_ADDR) {
-			if (create) {
-				if (unlikely(f2fs_cp_error(sbi))) {
-					err = -EIO;
-					goto sync_out;
-				}
-				err = __allocate_data_block(&dn);
-				if (err)
-					goto sync_out;
-				allocated = true;
-				map->m_flags |= F2FS_MAP_NEW;
-				blkaddr = dn.data_blkaddr;
-			} else {
-				/*
-				 * we only merge preallocated unwritten blocks
-				 * for fiemap.
-				 */
-				if (flag != F2FS_GET_BLOCK_FIEMAP ||
-						blkaddr != NEW_ADDR)
-					goto sync_out;
+	if (blkaddr == NEW_ADDR || blkaddr == NULL_ADDR) {
+		if (create) {
+			if (unlikely(f2fs_cp_error(sbi))) {
+				err = -EIO;
+				goto sync_out;
 			}
+			err = __allocate_data_block(&dn);
+			if (err)
+				goto sync_out;
+			allocated = true;
+			map->m_flags |= F2FS_MAP_NEW;
+			blkaddr = dn.data_blkaddr;
+		} else {
+			/*
+			 * we only merge preallocated unwritten blocks
+			 * for fiemap.
+			 */
+			if (flag != F2FS_GET_BLOCK_FIEMAP ||
+					blkaddr != NEW_ADDR)
+				goto sync_out;
 		}
+	}

-		/* Give more consecutive addresses for the readahead */
-		if ((map->m_pblk != NEW_ADDR &&
-				blkaddr == (map->m_pblk + ofs)) ||
-				(map->m_pblk == NEW_ADDR &&
-				blkaddr == NEW_ADDR)) {
-			ofs++;
-			dn.ofs_in_node++;
-			pgofs++;
-			map->m_len++;
-			goto get_next;
-		}
+	/* Give more consecutive addresses for the readahead */
+	if ((map->m_pblk != NEW_ADDR &&
+			blkaddr == (map->m_pblk + ofs)) ||
+			(map->m_pblk == NEW_ADDR &&
+			blkaddr == NEW_ADDR)) {
+		ofs++;
+		dn.ofs_in_node++;
+		pgofs++;
+		map->m_len++;
+		goto get_next;
 	}
+
 sync_out:
 	if (allocated)
 		sync_inode_page(&dn);
--
1.7.9.5



------------------------------------------------------------------------------
