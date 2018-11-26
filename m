From: Jia Zhu <zhujia13@huawei.com>
Subject: [PATCH v2] f2fs: fix to update new block address correctly for OPU
Date: Tue, 27 Nov 2018 02:32:32 +0800
Message-ID: <20181126183232.51715-1-zhujia13@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com
Cc: jaizhu.zj@gmail.com, shengyong1@huawei.com, yunlong.song@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, stable@vger.kernel.org, Jia Zhu <zhujia13@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Previously, we allocated a new block address for OPU mode in direct_IO.

But the new address couldn't be assigned to @map->m_pblk correctly.

This patch fix it.

Fixes: 511f52d02f05 ('f2fs: allow out-place-update for direct IO in LFS mode')

Signed-off-by: Jia Zhu <zhujia13@huawei.com>
---
v2:
- update commit message.

 fs/f2fs/data.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7226300..a3a567a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1110,8 +1110,10 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 		if (test_opt(sbi, LFS) && flag == F2FS_GET_BLOCK_DIO &&
 							map->m_may_create) {
 			err = __allocate_data_block(&dn, map->m_seg_type);
-			if (!err)
+			if (!err) {
+				blkaddr = dn.data_blkaddr;
 				set_inode_flag(inode, FI_APPEND_WRITE);
+			}
 		}
 	} else {
 		if (create) {
-- 
2.10.1
