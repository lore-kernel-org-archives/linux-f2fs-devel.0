From: Junling Zheng <zhengjunling@huawei.com>
Subject: [PATCH 2/5] f2fs-tools: rename CHECKSUM_OFFSET to
 CP_CHKSUM_OFFSET
Date: Wed, 19 Sep 2018 21:53:48 +0800
Message-ID: <20180919135352.173525-2-zhengjunling@huawei.com>
References: <20180919135352.173525-1-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <zhengjunling@huawei.com>) id 1g2cvq-00009C-4q
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 19 Sep 2018 13:54:18 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1g2cvj-00Fs2g-BS
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 19 Sep 2018 13:54:17 +0000
In-Reply-To: <20180919135352.173525-1-zhengjunling@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

This patch renamed CHECKSUM_OFFSET to CP_CHKSUM_OFFSET.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
---
 fsck/fsck.c        |  4 ++--
 fsck/mount.c       |  4 ++--
 fsck/resize.c      |  8 ++++----
 include/f2fs_fs.h  |  6 +++---
 mkfs/f2fs_format.c | 14 +++++++-------
 5 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index d550403..f080d3c 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -2010,8 +2010,8 @@ static void fix_checkpoint(struct f2fs_sb_info *sbi)
 	set_cp(valid_node_count, fsck->chk.valid_node_cnt);
 	set_cp(valid_inode_count, fsck->chk.valid_inode_cnt);
 
-	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, cp, CHECKSUM_OFFSET);
-	*((__le32 *)((unsigned char *)cp + CHECKSUM_OFFSET)) = cpu_to_le32(crc);
+	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, cp, CP_CHKSUM_OFFSET);
+	*((__le32 *)((unsigned char *)cp + CP_CHKSUM_OFFSET)) = cpu_to_le32(crc);
 
 	cp_blk_no = get_sb(cp_blkaddr);
 	if (sbi->cur_cp == 2)
diff --git a/fsck/mount.c b/fsck/mount.c
index 2c2473d..1daef75 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -2252,8 +2252,8 @@ void write_checkpoint(struct f2fs_sb_info *sbi)
 	flags = update_nat_bits_flags(sb, cp, flags);
 	set_cp(ckpt_flags, flags);
 
-	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, cp, CHECKSUM_OFFSET);
-	*((__le32 *)((unsigned char *)cp + CHECKSUM_OFFSET)) = cpu_to_le32(crc);
+	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, cp, CP_CHKSUM_OFFSET);
+	*((__le32 *)((unsigned char *)cp + CP_CHKSUM_OFFSET)) = cpu_to_le32(crc);
 
 	cp_blk_no = get_sb(cp_blkaddr);
 	if (sbi->cur_cp == 2)
diff --git a/fsck/resize.c b/fsck/resize.c
index fe8a61a..e9612b3 100644
--- a/fsck/resize.c
+++ b/fsck/resize.c
@@ -90,10 +90,10 @@ static int get_new_sb(struct f2fs_super_block *sb)
 		 * It requires more pages for cp.
 		 */
 		if (max_sit_bitmap_size > MAX_SIT_BITMAP_SIZE_IN_CKPT) {
-			max_nat_bitmap_size = CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1;
+			max_nat_bitmap_size = CP_CHKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1;
 			set_sb(cp_payload, F2FS_BLK_ALIGN(max_sit_bitmap_size));
 		} else {
-			max_nat_bitmap_size = CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1
+			max_nat_bitmap_size = CP_CHKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1
 				- max_sit_bitmap_size;
 			set_sb(cp_payload, 0);
 		}
@@ -520,8 +520,8 @@ static void rebuild_checkpoint(struct f2fs_sb_info *sbi,
 						(unsigned char *)cp);
 	new_cp->checkpoint_ver = cpu_to_le64(cp_ver + 1);
 
-	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, new_cp, CHECKSUM_OFFSET);
-	*((__le32 *)((unsigned char *)new_cp + CHECKSUM_OFFSET)) =
+	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, new_cp, CP_CHKSUM_OFFSET);
+	*((__le32 *)((unsigned char *)new_cp + CP_CHKSUM_OFFSET)) =
 							cpu_to_le32(crc);
 
 	/* Write a new checkpoint in the other set */
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 2c086a9..38a0da4 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -278,7 +278,7 @@ static inline uint64_t bswap_64(uint64_t val)
 #define PAGE_CACHE_SIZE		4096
 #define BITS_PER_BYTE		8
 #define F2FS_SUPER_MAGIC	0xF2F52010	/* F2FS Magic Number */
-#define CHECKSUM_OFFSET		4092
+#define CP_CHKSUM_OFFSET	4092
 #define MAX_PATH_LEN		64
 #define MAX_DEVICES		8
 
@@ -682,9 +682,9 @@ struct f2fs_checkpoint {
 } __attribute__((packed));
 
 #define MAX_SIT_BITMAP_SIZE_IN_CKPT    \
-	(CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1 - 64)
+	(CP_CHKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1 - 64)
 #define MAX_BITMAP_SIZE_IN_CKPT	\
-	(CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1)
+	(CP_CHKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1)
 
 /*
  * For orphan inode management
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 4b88d93..621126c 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -342,12 +342,12 @@ static int f2fs_prepare_super_block(void)
 		 * It requires more pages for cp.
 		 */
 		if (max_sit_bitmap_size > MAX_SIT_BITMAP_SIZE_IN_CKPT) {
-			max_nat_bitmap_size = CHECKSUM_OFFSET -
+			max_nat_bitmap_size = CP_CHKSUM_OFFSET -
 					sizeof(struct f2fs_checkpoint) + 1;
 			set_sb(cp_payload, F2FS_BLK_ALIGN(max_sit_bitmap_size));
 	        } else {
 			max_nat_bitmap_size =
-				CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1
+				CP_CHKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1
 				- max_sit_bitmap_size;
 			set_sb(cp_payload, 0);
 		}
@@ -684,10 +684,10 @@ static int f2fs_write_check_point_pack(void)
 	set_cp(nat_ver_bitmap_bytesize, ((get_sb(segment_count_nat) / 2) <<
 			 get_sb(log_blocks_per_seg)) / 8);
 
-	set_cp(checksum_offset, CHECKSUM_OFFSET);
+	set_cp(checksum_offset, CP_CHKSUM_OFFSET);
 
-	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, cp, CHECKSUM_OFFSET);
-	*((__le32 *)((unsigned char *)cp + CHECKSUM_OFFSET)) =
+	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, cp, CP_CHKSUM_OFFSET);
+	*((__le32 *)((unsigned char *)cp + CP_CHKSUM_OFFSET)) =
 							cpu_to_le32(crc);
 
 	blk_size_bytes = 1 << get_sb(log_blocksize);
@@ -932,8 +932,8 @@ static int f2fs_write_check_point_pack(void)
 	 */
 	cp->checkpoint_ver = 0;
 
-	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, cp, CHECKSUM_OFFSET);
-	*((__le32 *)((unsigned char *)cp + CHECKSUM_OFFSET)) =
+	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, cp, CP_CHKSUM_OFFSET);
+	*((__le32 *)((unsigned char *)cp + CP_CHKSUM_OFFSET)) =
 							cpu_to_le32(crc);
 	cp_seg_blk = get_sb(segment0_blkaddr) + c.blks_per_seg;
 	DBG(1, "\tWriting cp page 1 of checkpoint pack 2, at offset 0x%08"PRIx64"\n",
-- 
2.19.0
