From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2 1/2] f2fs-tools: allow unfixed
 f2fs_checkpoint.checksum_offset
Date: Fri, 26 Apr 2019 10:31:07 +0800
Message-ID: <20190426023108.56826-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hJqe3-0007OP-6X
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 26 Apr 2019 02:31:23 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hJqe1-00EaI4-Ip
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 26 Apr 2019 02:31:23 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: jaegeuk@kernel.org

Previously, f2fs_checkpoint.checksum_offset points fixed position of
f2fs_checkpoint structure:

"#define CP_CHKSUM_OFFSET	4092"

It is unnecessary, and it breaks the consecutiveness of nat and sit
bitmap stored across checkpoint park block and payload blocks.

This patch allows f2fs-tools to handle unfixed .checksum_offset.

In addition, for the case checksum value is stored in the middle of
checkpoint park, calculating checksum value with superposition method
like we did for inode_checksum.

In addition, add below change:
- using MAX_BITMAP_SIZE_IN_CKPT to clean up codes.
- introduce verify_checksum_chksum() to verify chksum_{offset,value}

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- introduce verify_checksum_chksum().
 fsck/fsck.c        |  5 +++--
 fsck/mount.c       | 42 +++++++++++++++++++++++++-----------------
 fsck/resize.c      | 10 +++++-----
 include/f2fs_fs.h  |  1 +
 lib/libf2fs.c      | 14 ++++++++++++++
 mkfs/f2fs_format.c | 16 +++++++---------
 6 files changed, 55 insertions(+), 33 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index a17555c..7ecdee1 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -2056,8 +2056,9 @@ static void fix_checkpoint(struct f2fs_sb_info *sbi)
 	set_cp(valid_node_count, fsck->chk.valid_node_cnt);
 	set_cp(valid_inode_count, fsck->chk.valid_inode_cnt);
 
-	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, cp, CP_CHKSUM_OFFSET);
-	*((__le32 *)((unsigned char *)cp + CP_CHKSUM_OFFSET)) = cpu_to_le32(crc);
+	crc = f2fs_checkpoint_chksum(cp);
+	*((__le32 *)((unsigned char *)cp + get_cp(checksum_offset))) =
+							cpu_to_le32(crc);
 
 	cp_blk_no = get_sb(cp_blkaddr);
 	if (sbi->cur_cp == 2)
diff --git a/fsck/mount.c b/fsck/mount.c
index aa64e93..95c5357 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -769,15 +769,32 @@ int init_sb_info(struct f2fs_sb_info *sbi)
 	return 0;
 }
 
+static int verify_checksum_chksum(struct f2fs_checkpoint *cp)
+{
+	unsigned int chksum_offset = get_cp(checksum_offset);
+	unsigned int crc, cal_crc;
+
+	if (chksum_offset > CP_CHKSUM_OFFSET) {
+		MSG(0, "\tInvalid CP CRC offset: %u\n", chksum_offset);
+		return -1;
+	}
+
+	crc = le32_to_cpu(*(__le32 *)((unsigned char *)cp + chksum_offset));
+	cal_crc = f2fs_checkpoint_chksum(cp);
+	if (cal_crc != crc) {
+		MSG(0, "\tInvalid CP CRC: offset:%u, crc:0x%x, calc:0x%x\n",
+			chksum_offset, crc, cal_crc);
+		return -1;
+	}
+	return 0;
+}
+
 void *validate_checkpoint(struct f2fs_sb_info *sbi, block_t cp_addr,
 				unsigned long long *version)
 {
 	void *cp_page_1, *cp_page_2;
 	struct f2fs_checkpoint *cp;
-	unsigned long blk_size = sbi->blocksize;
 	unsigned long long cur_version = 0, pre_version = 0;
-	unsigned int crc = 0;
-	size_t crc_offset;
 
 	/* Read the 1st cp block in this CP pack */
 	cp_page_1 = malloc(PAGE_SIZE);
@@ -787,12 +804,7 @@ void *validate_checkpoint(struct f2fs_sb_info *sbi, block_t cp_addr,
 		goto invalid_cp1;
 
 	cp = (struct f2fs_checkpoint *)cp_page_1;
-	crc_offset = get_cp(checksum_offset);
-	if (crc_offset > (blk_size - sizeof(__le32)))
-		goto invalid_cp1;
-
-	crc = le32_to_cpu(*(__le32 *)((unsigned char *)cp + crc_offset));
-	if (f2fs_crc_valid(crc, cp, crc_offset))
+	if (verify_checksum_chksum(cp))
 		goto invalid_cp1;
 
 	if (get_cp(cp_pack_total_block_count) > sbi->blocks_per_seg)
@@ -810,12 +822,7 @@ void *validate_checkpoint(struct f2fs_sb_info *sbi, block_t cp_addr,
 		goto invalid_cp2;
 
 	cp = (struct f2fs_checkpoint *)cp_page_2;
-	crc_offset = get_cp(checksum_offset);
-	if (crc_offset > (blk_size - sizeof(__le32)))
-		goto invalid_cp2;
-
-	crc = le32_to_cpu(*(__le32 *)((unsigned char *)cp + crc_offset));
-	if (f2fs_crc_valid(crc, cp, crc_offset))
+	if (verify_checksum_chksum(cp))
 		goto invalid_cp2;
 
 	cur_version = get_cp(checkpoint_ver);
@@ -2373,8 +2380,9 @@ void write_checkpoint(struct f2fs_sb_info *sbi)
 	flags = update_nat_bits_flags(sb, cp, flags);
 	set_cp(ckpt_flags, flags);
 
-	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, cp, CP_CHKSUM_OFFSET);
-	*((__le32 *)((unsigned char *)cp + CP_CHKSUM_OFFSET)) = cpu_to_le32(crc);
+	crc = f2fs_checkpoint_chksum(cp);
+	*((__le32 *)((unsigned char *)cp + get_cp(checksum_offset))) =
+							cpu_to_le32(crc);
 
 	cp_blk_no = get_sb(cp_blkaddr);
 	if (sbi->cur_cp == 2)
diff --git a/fsck/resize.c b/fsck/resize.c
index 56c8103..2c623c5 100644
--- a/fsck/resize.c
+++ b/fsck/resize.c
@@ -90,11 +90,11 @@ static int get_new_sb(struct f2fs_super_block *sb)
 		 * It requires more pages for cp.
 		 */
 		if (max_sit_bitmap_size > MAX_SIT_BITMAP_SIZE_IN_CKPT) {
-			max_nat_bitmap_size = CP_CHKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1;
+			max_nat_bitmap_size = MAX_BITMAP_SIZE_IN_CKPT;
 			set_sb(cp_payload, F2FS_BLK_ALIGN(max_sit_bitmap_size));
 		} else {
-			max_nat_bitmap_size = CP_CHKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1
-				- max_sit_bitmap_size;
+			max_nat_bitmap_size = MAX_BITMAP_SIZE_IN_CKPT -
+							max_sit_bitmap_size;
 			set_sb(cp_payload, 0);
 		}
 
@@ -520,8 +520,8 @@ static void rebuild_checkpoint(struct f2fs_sb_info *sbi,
 						(unsigned char *)cp);
 	new_cp->checkpoint_ver = cpu_to_le64(cp_ver + 1);
 
-	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, new_cp, CP_CHKSUM_OFFSET);
-	*((__le32 *)((unsigned char *)new_cp + CP_CHKSUM_OFFSET)) =
+	crc = f2fs_checkpoint_chksum(cp);
+	*((__le32 *)((unsigned char *)new_cp + get_cp(checksum_offset))) =
 							cpu_to_le32(crc);
 
 	/* Write a new checkpoint in the other set */
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index e84cccc..966e0c8 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -1133,6 +1133,7 @@ extern int utf16_to_utf8(char *, const u_int16_t *, size_t, size_t);
 extern int log_base_2(u_int32_t);
 extern unsigned int addrs_per_inode(struct f2fs_inode *);
 extern __u32 f2fs_inode_chksum(struct f2fs_node *);
+extern __u32 f2fs_checkpoint_chksum(struct f2fs_checkpoint *);
 
 extern int get_bits_in_byte(unsigned char n);
 extern int test_and_set_bit_le(u32, u8 *);
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 60b84e0..fe09ea1 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -532,6 +532,20 @@ __u32 f2fs_inode_chksum(struct f2fs_node *node)
 	return chksum;
 }
 
+__u32 f2fs_checkpoint_chksum(struct f2fs_checkpoint *cp)
+{
+	unsigned int chksum_ofs = le32_to_cpu(cp->checksum_offset);
+	__u32 chksum;
+
+	chksum = f2fs_cal_crc32(F2FS_SUPER_MAGIC, cp, chksum_ofs);
+	if (chksum_ofs < CP_CHKSUM_OFFSET) {
+		chksum_ofs += sizeof(chksum);
+		chksum = f2fs_cal_crc32(chksum, (__u8 *)cp + chksum_ofs,
+						F2FS_BLKSIZE - chksum_ofs);
+	}
+	return chksum;
+}
+
 /*
  * try to identify the root device
  */
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index a2685cb..ab8103c 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -342,13 +342,11 @@ static int f2fs_prepare_super_block(void)
 		 * It requires more pages for cp.
 		 */
 		if (max_sit_bitmap_size > MAX_SIT_BITMAP_SIZE_IN_CKPT) {
-			max_nat_bitmap_size = CP_CHKSUM_OFFSET -
-					sizeof(struct f2fs_checkpoint) + 1;
+			max_nat_bitmap_size = MAX_BITMAP_SIZE_IN_CKPT;
 			set_sb(cp_payload, F2FS_BLK_ALIGN(max_sit_bitmap_size));
 	        } else {
-			max_nat_bitmap_size =
-				CP_CHKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1
-				- max_sit_bitmap_size;
+			max_nat_bitmap_size = MAX_BITMAP_SIZE_IN_CKPT -
+							max_sit_bitmap_size;
 			set_sb(cp_payload, 0);
 		}
 		max_nat_segments = (max_nat_bitmap_size * 8) >> log_blks_per_seg;
@@ -694,8 +692,8 @@ static int f2fs_write_check_point_pack(void)
 
 	set_cp(checksum_offset, CP_CHKSUM_OFFSET);
 
-	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, cp, CP_CHKSUM_OFFSET);
-	*((__le32 *)((unsigned char *)cp + CP_CHKSUM_OFFSET)) =
+	crc = f2fs_checkpoint_chksum(cp);
+	*((__le32 *)((unsigned char *)cp + get_cp(checksum_offset))) =
 							cpu_to_le32(crc);
 
 	blk_size_bytes = 1 << get_sb(log_blocksize);
@@ -940,8 +938,8 @@ static int f2fs_write_check_point_pack(void)
 	 */
 	cp->checkpoint_ver = 0;
 
-	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, cp, CP_CHKSUM_OFFSET);
-	*((__le32 *)((unsigned char *)cp + CP_CHKSUM_OFFSET)) =
+	crc = f2fs_checkpoint_chksum(cp);
+	*((__le32 *)((unsigned char *)cp + get_cp(checksum_offset))) =
 							cpu_to_le32(crc);
 	cp_seg_blk = get_sb(segment0_blkaddr) + c.blks_per_seg;
 	DBG(1, "\tWriting cp page 1 of checkpoint pack 2, at offset 0x%08"PRIx64"\n",
-- 
2.18.0.rc1
