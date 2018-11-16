From: Jia Zhu <zhujia13@huawei.com>
Subject: [PATCH] f2fs: fix m_may_create to make OPU DIO write
 correctly
Date: Sat, 17 Nov 2018 03:41:42 +0800
Message-ID: <20181116194142.6343-1-zhujia13@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <zhujia13@huawei.com>) id 1gNcQt-0005zx-6H
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 16 Nov 2018 11:37:07 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gNcQq-002Y39-Tb
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 16 Nov 2018 11:37:07 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, jaizhu.zj@gmail.com
Cc: Jia Zhu <zhujia13@huawei.com>, linux-f2fs-devel@lists.sourceforge.net

Commit 7bc0f46d418a ("f2fs: fix out-place-update DIO write")
added a parameter map.m_may_create to replace @create for
triggering OPU allocation correctly.

But we find it is still in-place-update when used AndroBench
to test this feature.In f2fs_map_blocks(), @create has been
overwritten by the code below. So the function can not allocate
new block address and directly go out.
code:
create = dio->op == REQ_OP_WRITE;
if (dio->flags & DIO_SKIP_HOLES) {
	if (fs_startblk <= ((i_size_read(dio->inode) -1) >>i_blkbits))
		create = 0;
		}

This patch use @map.m_may_create to replace @create to avoid
this problem.

Signed-off-by: Jia Zhu <zhujia13@huawei.com>
---
 fs/f2fs/data.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8780f3d..9b61cba 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1034,7 +1034,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 	pgofs =	(pgoff_t)map->m_lblk;
 	end = pgofs + maxblocks;
 
-	if (!create && f2fs_lookup_extent_cache(inode, pgofs, &ei)) {
+	if (!map->m_may_create && f2fs_lookup_extent_cache(inode, pgofs, &ei)) {
 		map->m_pblk = ei.blk + pgofs - ei.fofs;
 		map->m_len = min((pgoff_t)maxblocks, ei.fofs + ei.len - pgofs);
 		map->m_flags = F2FS_MAP_MAPPED;
@@ -1093,7 +1093,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 				set_inode_flag(inode, FI_APPEND_WRITE);
 		}
 	} else {
-		if (create) {
+		if (map->m_may_create) {
 			if (unlikely(f2fs_cp_error(sbi))) {
 				err = -EIO;
 				goto sync_out;
-- 
2.10.1
