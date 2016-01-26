From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH v2 1/3] f2fs: simplify f2fs_map_blocks
Date: Tue, 26 Jan 2016 15:37:38 +0800
Message-ID: <009201d1580c$86b5faa0$9421efe0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aNyCs-0008O2-Ff
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Jan 2016 07:38:30 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aNyCq-0000mr-H0
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Jan 2016 07:38:30 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O1J02I47UJN4M30@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Jan 2016 16:38:20 +0900 (KST)
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

In f2fs_map_blocks, we use duplicated codes to handle first block mapping
and the following blocks mapping, it's unnecessary. This patch simplifies
f2fs_map_blocks to avoid using copied codes.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---

 V2:
 - rebase on last dev-test

 fs/f2fs/data.c | 101 ++++++++++++++++++---------------------------------------
 1 file changed, 32 insertions(+), 69 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c85acbc..f570d37 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -632,6 +632,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 		goto out;
 	}
 
+next_dnode:
 	if (create)
 		f2fs_lock_op(sbi);
 
@@ -644,47 +645,57 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 		goto unlock_out;
 	}
 
-	if (dn.data_blkaddr == NEW_ADDR || dn.data_blkaddr == NULL_ADDR) {
+	end_offset = ADDRS_PER_PAGE(dn.node_page, F2FS_I(inode));
+
+next_block:
+	blkaddr = datablock_addr(dn.node_page, dn.ofs_in_node);
+
+	if (blkaddr == NEW_ADDR || blkaddr == NULL_ADDR) {
 		if (create) {
 			if (unlikely(f2fs_cp_error(sbi))) {
 				err = -EIO;
-				goto put_out;
+				goto sync_out;
 			}
 			err = __allocate_data_block(&dn);
 			if (err)
-				goto put_out;
+				goto sync_out;
 			allocated = true;
 			map->m_flags = F2FS_MAP_NEW;
+			blkaddr = dn.data_blkaddr;
 		} else {
 			if (flag != F2FS_GET_BLOCK_FIEMAP ||
-						dn.data_blkaddr != NEW_ADDR) {
+						blkaddr != NEW_ADDR) {
 				if (flag == F2FS_GET_BLOCK_BMAP)
 					err = -ENOENT;
-				goto put_out;
+				goto sync_out;
 			}
-
-			/*
-			 * preallocated unwritten block should be mapped
-			 * for fiemap.
-			 */
-			if (dn.data_blkaddr == NEW_ADDR)
-				map->m_flags = F2FS_MAP_UNWRITTEN;
 		}
 	}
 
-	map->m_flags |= F2FS_MAP_MAPPED;
-	map->m_pblk = dn.data_blkaddr;
-	map->m_len = 1;
+	if (map->m_len == 0) {
+		/* preallocated unwritten block should be mapped for fiemap. */
+		if (blkaddr == NEW_ADDR)
+			map->m_flags |= F2FS_MAP_UNWRITTEN;
+		map->m_flags |= F2FS_MAP_MAPPED;
+
+		map->m_pblk = blkaddr;
+		map->m_len = 1;
+	} else if ((map->m_pblk != NEW_ADDR &&
+			blkaddr == (map->m_pblk + ofs)) ||
+			(map->m_pblk == NEW_ADDR && blkaddr == NEW_ADDR)) {
+		ofs++;
+		map->m_len++;
+	} else {
+		goto sync_out;
+	}
 
-	end_offset = ADDRS_PER_PAGE(dn.node_page, F2FS_I(inode));
 	dn.ofs_in_node++;
 	pgofs++;
 
-get_next:
-	if (map->m_len >= maxblocks)
-		goto sync_out;
+	if (map->m_len < maxblocks) {
+		if (dn.ofs_in_node < end_offset)
+			goto next_block;
 
-	if (dn.ofs_in_node >= end_offset) {
 		if (allocated)
 			sync_inode_page(&dn);
 		f2fs_put_dnode(&dn);
@@ -692,62 +703,14 @@ get_next:
 		if (create) {
 			f2fs_unlock_op(sbi);
 			f2fs_balance_fs(sbi, allocated);
-			f2fs_lock_op(sbi);
 		}
 		allocated = false;
-
-		set_new_dnode(&dn, inode, NULL, NULL, 0);
-		err = get_dnode_of_data(&dn, pgofs, mode);
-		if (err) {
-			if (err == -ENOENT)
-				err = 0;
-			goto unlock_out;
-		}
-
-		end_offset = ADDRS_PER_PAGE(dn.node_page, F2FS_I(inode));
-	}
-
-	blkaddr = datablock_addr(dn.node_page, dn.ofs_in_node);
-
-	if (blkaddr == NEW_ADDR || blkaddr == NULL_ADDR) {
-		if (create) {
-			if (unlikely(f2fs_cp_error(sbi))) {
-				err = -EIO;
-				goto sync_out;
-			}
-			err = __allocate_data_block(&dn);
-			if (err)
-				goto sync_out;
-			allocated = true;
-			map->m_flags |= F2FS_MAP_NEW;
-			blkaddr = dn.data_blkaddr;
-		} else {
-			/*
-			 * we only merge preallocated unwritten blocks
-			 * for fiemap.
-			 */
-			if (flag != F2FS_GET_BLOCK_FIEMAP ||
-					blkaddr != NEW_ADDR)
-				goto sync_out;
-		}
-	}
-
-	/* Give more consecutive addresses for the readahead */
-	if ((map->m_pblk != NEW_ADDR &&
-			blkaddr == (map->m_pblk + ofs)) ||
-			(map->m_pblk == NEW_ADDR &&
-			blkaddr == NEW_ADDR)) {
-		ofs++;
-		dn.ofs_in_node++;
-		pgofs++;
-		map->m_len++;
-		goto get_next;
+		goto next_dnode;
 	}
 
 sync_out:
 	if (allocated)
 		sync_inode_page(&dn);
-put_out:
 	f2fs_put_dnode(&dn);
 unlock_out:
 	if (create) {
-- 
2.7.0.2.g1b0b6dd



------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
