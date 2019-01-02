From: sunqiuyang <sunqiuyang@huawei.com>
Subject: [PATCH 1/2] f2fs-dev: support multi-device direct IO
Date: Wed, 2 Jan 2019 17:06:59 +0800
Message-ID: <20190102090659.7974-1-sunqiuyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <sunqiuyang@huawei.com>) id 1gecWA-0005Mf-4D
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 02 Jan 2019 09:08:50 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gecW7-00BGyT-T5
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 02 Jan 2019 09:08:50 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: sunqiuyang@huawei.com

From: Qiuyang Sun <sunqiuyang@huawei.com>

The physical blocks in struct f2fs_map_blocks must be in the same device.

Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>
---
 fs/f2fs/data.c | 20 +++++++++++++++++++-
 fs/f2fs/f2fs.h |  2 --
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e5cd3fd..7a6369e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1076,6 +1076,8 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 	struct extent_info ei = {0,0,0};
 	block_t blkaddr;
 	unsigned int start_pgofs;
+	int devi;
+	block_t end_blk;
 
 	if (!maxblocks)
 		return 0;
@@ -1207,8 +1209,15 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 
 		map->m_pblk = blkaddr;
 		map->m_len = 1;
+
+		if (sbi->s_ndevs && blkaddr != NEW_ADDR &&
+							blkaddr != NULL_ADDR) {
+			devi = f2fs_target_device_index(sbi, blkaddr);
+			end_blk = FDEV(devi).end_blk;
+		}
 	} else if ((map->m_pblk != NEW_ADDR &&
-			blkaddr == (map->m_pblk + ofs)) ||
+			blkaddr == (map->m_pblk + ofs) &&
+			(!sbi->s_ndevs || blkaddr <= end_blk)) ||
 			(map->m_pblk == NEW_ADDR && blkaddr == NEW_ADDR) ||
 			flag == F2FS_GET_BLOCK_PRE_DIO) {
 		ofs++;
@@ -1322,6 +1331,8 @@ static int __get_data_block(struct inode *inode, sector_t iblock,
 {
 	struct f2fs_map_blocks map;
 	int err;
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	int devi;
 
 	map.m_lblk = iblock;
 	map.m_len = bh->b_size >> inode->i_blkbits;
@@ -1333,6 +1344,13 @@ static int __get_data_block(struct inode *inode, sector_t iblock,
 	err = f2fs_map_blocks(inode, &map, create, flag);
 	if (!err) {
 		map_bh(bh, inode->i_sb, map.m_pblk);
+		if (sbi->s_ndevs) {
+			devi = f2fs_target_device_index(sbi, map.m_pblk);
+			if (devi) {
+				bh->b_bdev = FDEV(devi).bdev;
+				bh->b_blocknr -= FDEV(devi).start_blk;
+			}
+		}
 		bh->b_state = (bh->b_state & ~F2FS_MAP_FLAGS) | map.m_flags;
 		bh->b_size = (u64)map.m_len << inode->i_blkbits;
 	}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index eeede26..b311471 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3595,8 +3595,6 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
 
 	if (f2fs_post_read_required(inode))
 		return true;
-	if (sbi->s_ndevs)
-		return true;
 	/*
 	 * for blkzoned device, fallback direct IO to buffered IO, so
 	 * all IOs can be serialized by log-structured write.
-- 
1.8.3.1
