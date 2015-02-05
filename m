From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH v3 03/10] f2fs: introduce f2fs_map_bh to clean codes of
 check_extent_cache
Date: Thu, 05 Feb 2015 17:50:30 +0800
Message-ID: <000001d04129$48365810$d8a30830$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch introduces f2fs_map_bh to clean codes of check_extent_cache.

v2:
 o cleanup f2fs_map_bh pointed out by Jaegeuk Kim.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 335df0d..f2d8deb 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -248,8 +248,23 @@ int f2fs_reserve_block(struct dnode_of_data *dn, pgoff_t index)
 	return err;
 }
 
+static void f2fs_map_bh(struct super_block *sb, pgoff_t pgofs,
+			struct extent_info *ei, struct buffer_head *bh_result)
+{
+	unsigned int blkbits = sb->s_blocksize_bits;
+	size_t count;
+
+	clear_buffer_new(bh_result);
+	map_bh(bh_result, sb, ei->blk + pgofs - ei->fofs);
+	count = ei->fofs + ei->len - pgofs;
+	if (count < (UINT_MAX >> blkbits))
+		bh_result->b_size = (count << blkbits);
+	else
+		bh_result->b_size = UINT_MAX;
+}
+
 static int check_extent_cache(struct inode *inode, pgoff_t pgofs,
-					struct buffer_head *bh_result)
+					struct extent_info *ei)
 {
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	pgoff_t start_fofs, end_fofs;
@@ -271,18 +286,7 @@ static int check_extent_cache(struct inode *inode, pgoff_t pgofs,
 	start_blkaddr = fi->ext.blk;
 
 	if (pgofs >= start_fofs && pgofs <= end_fofs) {
-		unsigned int blkbits = inode->i_sb->s_blocksize_bits;
-		size_t count;
-
-		clear_buffer_new(bh_result);
-		map_bh(bh_result, inode->i_sb,
-				start_blkaddr + pgofs - start_fofs);
-		count = end_fofs - pgofs + 1;
-		if (count < (UINT_MAX >> blkbits))
-			bh_result->b_size = (count << blkbits);
-		else
-			bh_result->b_size = UINT_MAX;
-
+		*ei = fi->ext;
 		stat_inc_read_hit(inode->i_sb);
 		read_unlock(&fi->ext_lock);
 		return 1;
@@ -608,13 +612,16 @@ static int __get_data_block(struct inode *inode, sector_t iblock,
 	int mode = create ? ALLOC_NODE : LOOKUP_NODE_RA;
 	pgoff_t pgofs, end_offset;
 	int err = 0, ofs = 1;
+	struct extent_info ei;
 	bool allocated = false;
 
 	/* Get the page offset from the block offset(iblock) */
 	pgofs =	(pgoff_t)(iblock >> (PAGE_CACHE_SHIFT - blkbits));
 
-	if (check_extent_cache(inode, pgofs, bh_result))
+	if (check_extent_cache(inode, pgofs, &ei)) {
+		f2fs_map_bh(inode->i_sb, pgofs, &ei, bh_result);
 		goto out;
+	}
 
 	if (create) {
 		f2fs_balance_fs(F2FS_I_SB(inode));
-- 
2.2.1
