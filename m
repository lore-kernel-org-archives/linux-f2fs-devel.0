From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: update i_size after DIO completion
Date: Thu, 20 Sep 2018 14:51:08 -0700
Message-ID: <20180920215108.38802-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1g36qy-0006OR-N6
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 20 Sep 2018 21:51:16 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1g36qx-003OuE-3J
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 20 Sep 2018 21:51:16 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This is related to
ee70daaba82d ("xfs: update i_size after unwritten conversion in dio completion")

If we update i_size during dio_write, dio_read can read out stale data, which
breaks xfstests/465.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 15 +++++++--------
 fs/f2fs/f2fs.h |  1 +
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index aac426109489..5a80654499c9 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -881,7 +881,6 @@ static int __allocate_data_block(struct dnode_of_data *dn, int seg_type)
 	struct f2fs_summary sum;
 	struct node_info ni;
 	block_t old_blkaddr;
-	pgoff_t fofs;
 	blkcnt_t count = 1;
 	int err;
 
@@ -910,12 +909,10 @@ static int __allocate_data_block(struct dnode_of_data *dn, int seg_type)
 					old_blkaddr, old_blkaddr);
 	f2fs_set_data_blkaddr(dn);
 
-	/* update i_size */
-	fofs = f2fs_start_bidx_of_node(ofs_of_node(dn->node_page), dn->inode) +
-							dn->ofs_in_node;
-	if (i_size_read(dn->inode) < ((loff_t)(fofs + 1) << PAGE_SHIFT))
-		f2fs_i_size_write(dn->inode,
-				((loff_t)(fofs + 1) << PAGE_SHIFT));
+	/*
+	 * i_size will be updated by direct_IO. Otherwise, we'll get stale
+	 * data from unwritten block via dio_read.
+	 */
 	return 0;
 }
 
@@ -1081,6 +1078,8 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 					last_ofs_in_node = dn.ofs_in_node;
 				}
 			} else {
+				WARN_ON(flag != F2FS_GET_BLOCK_PRE_DIO &&
+					flag != F2FS_GET_BLOCK_DIO);
 				err = __allocate_data_block(&dn,
 							map->m_seg_type);
 				if (!err)
@@ -1260,7 +1259,7 @@ static int get_data_block_dio(struct inode *inode, sector_t iblock,
 			struct buffer_head *bh_result, int create)
 {
 	return __get_data_block(inode, iblock, bh_result, create,
-						F2FS_GET_BLOCK_DEFAULT, NULL,
+						F2FS_GET_BLOCK_DIO, NULL,
 						f2fs_rw_hint_to_seg_type(
 							inode->i_write_hint));
 }
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b5c1f8e3d62f..50af57c6ecf3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -602,6 +602,7 @@ enum {
 	F2FS_GET_BLOCK_DEFAULT,
 	F2FS_GET_BLOCK_FIEMAP,
 	F2FS_GET_BLOCK_BMAP,
+	F2FS_GET_BLOCK_DIO,
 	F2FS_GET_BLOCK_PRE_DIO,
 	F2FS_GET_BLOCK_PRE_AIO,
 	F2FS_GET_BLOCK_PRECACHE,
-- 
2.17.0.441.gb46fe60e1d-goog
