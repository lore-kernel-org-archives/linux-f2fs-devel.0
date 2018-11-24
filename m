From: Jia Zhu <zhujia13@huawei.com>
Subject: [PATCH] f2fs: fix to update new block address correctly
 for OPU
Date: Sun, 25 Nov 2018 06:17:42 +0800
Message-ID: <20181124221742.135673-1-zhujia13@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <zhujia13@huawei.com>) id 1gQYgd-0001xR-Ei
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 24 Nov 2018 14:13:31 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gQYgZ-00DBmF-In
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 24 Nov 2018 14:13:31 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com
Cc: jaizhu.zj@gmail.com, Jia Zhu <zhujia13@huawei.com>, linux-f2fs-devel@lists.sourceforge.net

Previously, we allocated a new block address for OPU mode in direct_IO.

But the new address couldn't be assigned to @map->m_pblk correctly.

This patch fix it.

Signed-off-by: Jia Zhu <zhujia13@huawei.com>
---
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
