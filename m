From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: fix incorrect mapping in ->bmap
Date: Thu, 5 May 2016 19:13:02 +0800
Message-ID: <20160505111303.30783-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Currently, generic_block_bmap is used in f2fs_bmap, its semantics is when
the mapping is been found, return position of target physical block,
otherwise return zero.

But, previously, when there is no mapping info for specified logical block,
f2fs_bmap will map target physical block to a uninitialized variable, which
should be wrong. Fix it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 888f178..96b0353 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -648,6 +648,8 @@ next_dnode:
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
 	err = get_dnode_of_data(&dn, pgofs, mode);
 	if (err) {
+		if (flag == F2FS_GET_BLOCK_BMAP)
+			map->m_pblk = 0;
 		if (err == -ENOENT) {
 			err = 0;
 			if (map->m_next_pgofs)
@@ -683,17 +685,18 @@ next_block:
 			map->m_flags = F2FS_MAP_NEW;
 			blkaddr = dn.data_blkaddr;
 		} else {
+			if (flag == F2FS_GET_BLOCK_BMAP) {
+				map->m_pblk = 0;
+				goto sync_out;
+			}
 			if (flag == F2FS_GET_BLOCK_FIEMAP &&
 						blkaddr == NULL_ADDR) {
 				if (map->m_next_pgofs)
 					*map->m_next_pgofs = pgofs + 1;
 			}
 			if (flag != F2FS_GET_BLOCK_FIEMAP ||
-						blkaddr != NEW_ADDR) {
-				if (flag == F2FS_GET_BLOCK_BMAP)
-					err = -ENOENT;
+						blkaddr != NEW_ADDR)
 				goto sync_out;
-			}
 		}
 	}
 
-- 
2.8.2.311.gee88674
