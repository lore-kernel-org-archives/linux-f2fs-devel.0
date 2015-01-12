From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev][RFC PATCH 02/10] f2fs: simplfy a field name in struct
 f2fs_extent,extent_info
Date: Mon, 12 Jan 2015 15:10:01 +0800
Message-ID: <000601d02e36$e2a8f660$a7fae320$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Rename a filed name from 'blk_addr' to 'blk' in struct {f2fs_extent,extent_info}
as annotation of this field descripts its meaning well to us.
By this way, we can avoid long statement in code of following patches.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c          | 13 ++++++-------
 fs/f2fs/f2fs.h          |  6 +++---
 include/linux/f2fs_fs.h |  2 +-
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index fece5cc..935a23b 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -268,7 +268,7 @@ static int check_extent_cache(struct inode *inode, pgoff_t pgofs,
 
 	start_fofs = fi->ext.fofs;
 	end_fofs = fi->ext.fofs + fi->ext.len - 1;
-	start_blkaddr = fi->ext.blk_addr;
+	start_blkaddr = fi->ext.blk;
 
 	if (pgofs >= start_fofs && pgofs <= end_fofs) {
 		unsigned int blkbits = inode->i_sb->s_blocksize_bits;
@@ -313,8 +313,8 @@ void update_extent_cache(struct dnode_of_data *dn)
 
 	start_fofs = fi->ext.fofs;
 	end_fofs = fi->ext.fofs + fi->ext.len - 1;
-	start_blkaddr = fi->ext.blk_addr;
-	end_blkaddr = fi->ext.blk_addr + fi->ext.len - 1;
+	start_blkaddr = fi->ext.blk;
+	end_blkaddr = fi->ext.blk + fi->ext.len - 1;
 
 	/* Drop and initialize the matched extent */
 	if (fi->ext.len == 1 && fofs == start_fofs)
@@ -324,7 +324,7 @@ void update_extent_cache(struct dnode_of_data *dn)
 	if (fi->ext.len == 0) {
 		if (dn->data_blkaddr != NULL_ADDR) {
 			fi->ext.fofs = fofs;
-			fi->ext.blk_addr = dn->data_blkaddr;
+			fi->ext.blk = dn->data_blkaddr;
 			fi->ext.len = 1;
 		}
 		goto end_update;
@@ -333,7 +333,7 @@ void update_extent_cache(struct dnode_of_data *dn)
 	/* Front merge */
 	if (fofs == start_fofs - 1 && dn->data_blkaddr == start_blkaddr - 1) {
 		fi->ext.fofs--;
-		fi->ext.blk_addr--;
+		fi->ext.blk--;
 		fi->ext.len++;
 		goto end_update;
 	}
@@ -351,8 +351,7 @@ void update_extent_cache(struct dnode_of_data *dn)
 			fi->ext.len = fofs - start_fofs;
 		} else {
 			fi->ext.fofs = fofs + 1;
-			fi->ext.blk_addr = start_blkaddr +
-					fofs - start_fofs + 1;
+			fi->ext.blk = start_blkaddr + fofs - start_fofs + 1;
 			fi->ext.len -= fofs - start_fofs + 1;
 		}
 	} else {
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index beacda0..a74ad85 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -272,7 +272,7 @@ enum {
 
 struct extent_info {
 	unsigned int fofs;	/* start offset in a file */
-	u32 blk_addr;		/* start block address of the extent */
+	u32 blk;		/* start block address of the extent */
 	unsigned int len;	/* length of the extent */
 };
 
@@ -314,7 +314,7 @@ static inline void get_extent_info(struct extent_info *ext,
 					struct f2fs_extent i_ext)
 {
 	ext->fofs = le32_to_cpu(i_ext.fofs);
-	ext->blk_addr = le32_to_cpu(i_ext.blk_addr);
+	ext->blk = le32_to_cpu(i_ext.blk);
 	ext->len = le32_to_cpu(i_ext.len);
 }
 
@@ -322,7 +322,7 @@ static inline void set_raw_extent(struct extent_info *ext,
 					struct f2fs_extent *i_ext)
 {
 	i_ext->fofs = cpu_to_le32(ext->fofs);
-	i_ext->blk_addr = cpu_to_le32(ext->blk_addr);
+	i_ext->blk = cpu_to_le32(ext->blk);
 	i_ext->len = cpu_to_le32(ext->len);
 }
 
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index e993b0b..295acfa 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -148,7 +148,7 @@ struct f2fs_orphan_block {
  */
 struct f2fs_extent {
 	__le32 fofs;		/* start file offset of the extent */
-	__le32 blk_addr;	/* start block address of the extent */
+	__le32 blk;		/* start block address of the extent */
 	__le32 len;		/* lengh of the extent */
 } __packed;
 
-- 
2.2.1
