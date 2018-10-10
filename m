From: Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH] f2fs: fix data corruption issue with hardware encryption
Date: Wed, 10 Oct 2018 10:56:22 +0530
Message-ID: <1539149182-12729-1-git-send-email-stummala@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, Sahitya Tummala <stummala@codeaurora.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Direct IO can be used in case of hardware encryption. The following
scenario results into data corruption issue in this path -

Thread A -                          Thread B-
-> write file#1 in direct IO
                                    -> GC gets kicked in
                                    -> GC submitted bio on meta mapping
				       for file#1, but pending completion
-> write file#1 again with new data
   in direct IO
                                    -> GC bio gets completed now
                                    -> GC writes old data to the new
                                       location and thus file#1 is
				       corrupted.

Fix this by submitting and waiting for pending io on meta mapping
for direct IO case in f2fs_map_blocks().

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/data.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9ef6f1f..7b2fef0 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1028,6 +1028,12 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 		map->m_pblk = ei.blk + pgofs - ei.fofs;
 		map->m_len = min((pgoff_t)maxblocks, ei.fofs + ei.len - pgofs);
 		map->m_flags = F2FS_MAP_MAPPED;
+		/* for HW encryption, but to avoid potential issue in future */
+		if (flag == F2FS_GET_BLOCK_DIO) {
+			blkaddr = map->m_pblk;
+			for (; blkaddr < map->m_pblk + map->m_len; blkaddr++)
+				f2fs_wait_on_block_writeback(sbi, blkaddr);
+		}
 		if (map->m_next_extent)
 			*map->m_next_extent = pgofs + map->m_len;
 		goto out;
@@ -1188,6 +1194,12 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 	goto next_dnode;
 
 sync_out:
+	/* for hardware encryption, but to avoid potential issue in future */
+	if (flag == F2FS_GET_BLOCK_DIO && map->m_flags & F2FS_MAP_MAPPED) {
+		blkaddr = map->m_pblk;
+		for (; blkaddr < map->m_pblk + map->m_len; blkaddr++)
+			f2fs_wait_on_block_writeback(sbi, blkaddr);
+	}
 	if (flag == F2FS_GET_BLOCK_PRECACHE) {
 		if (map->m_flags & F2FS_MAP_MAPPED) {
 			unsigned int ofs = start_pgofs - map->m_lblk;
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
