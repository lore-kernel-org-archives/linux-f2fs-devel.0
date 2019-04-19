From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs-tools: relocate chksum_offset for
 large_nat_bitmap feature
Date: Fri, 19 Apr 2019 15:54:18 +0800
Message-ID: <20190419075418.16670-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hHOLy-00057N-Rr
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 19 Apr 2019 07:54:34 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hHOLw-00Fp5c-8H
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 19 Apr 2019 07:54:34 +0000
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

For large_nat_bitmap feature, there is a design flaw:

Previous:

struct f2fs_checkpoint layout:
+--------------------------+  0x0000
| checkpoint_ver           |
| ......                   |
| checksum_offset          |------+
| ......                   |      |
| sit_nat_version_bitmap[] |<-----|-------+
| ......                   |      |       |
| checksum_value           |<-----+       |
+--------------------------+  0x1000      |
|                          |      nat_bitmap + sit_bitmap
| payload blocks           |              |
|                          |              |
+--------------------------|<-------------+

Obviously, if nat_bitmap size + sit_bitmap size is larger than
MAX_BITMAP_SIZE_IN_CKPT, nat_bitmap or sit_bitmap may overlap
checkpoint checksum's position, once checkpoint() is triggered
from kernel, nat or sit bitmap will be damaged by checksum field.

In order to fix this, let's relocate checksum_value's position
to the head of sit_nat_version_bitmap as below, then nat/sit
bitmap and chksum value update will become safe.

After:

struct f2fs_checkpoint layout:
+--------------------------+  0x0000
| checkpoint_ver           |
| ......                   |
| checksum_offset          |------+
| ......                   |      |
| sit_nat_version_bitmap[] |<-----+
| ......                   |<-------------+
|                          |              |
+--------------------------+  0x1000      |
|                          |      nat_bitmap + sit_bitmap
| payload blocks           |              |
|                          |              |
+--------------------------|<-------------+

Related report and discussion:

https://sourceforge.net/p/linux-f2fs/mailman/message/36642346/

In addition, we did below change as well:
- use MAX_BITMAP_SIZE_IN_CKPT to clean up codes.
- use get_cp(checksum_offset) instead of hard code CP_CHKSUM_OFFSET macro.

Reported-by: Park Ju Hyung <qkrwngud825@gmail.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2: detect deprecated layout with fsck.
 fsck/f2fs.h        |  6 +++++-
 fsck/fsck.c        | 22 +++++++++++++++++++---
 fsck/fsck.h        |  1 +
 fsck/main.c        |  2 ++
 fsck/mount.c       |  9 ++++++---
 fsck/resize.c      | 10 +++++-----
 mkfs/f2fs_format.c | 21 +++++++++++----------
 7 files changed, 49 insertions(+), 22 deletions(-)

diff --git a/fsck/f2fs.h b/fsck/f2fs.h
index 93f01e5..6a6c4a5 100644
--- a/fsck/f2fs.h
+++ b/fsck/f2fs.h
@@ -272,7 +272,11 @@ static inline void *__bitmap_ptr(struct f2fs_sb_info *sbi, int flag)
 	if (is_set_ckpt_flags(ckpt, CP_LARGE_NAT_BITMAP_FLAG)) {
 		offset = (flag == SIT_BITMAP) ?
 			le32_to_cpu(ckpt->nat_ver_bitmap_bytesize) : 0;
-		return &ckpt->sit_nat_version_bitmap + offset;
+		/*
+		 * if large_nat_bitmap feature is enabled, leave checksum
+		 * protection for all nat/sit bitmaps.
+		 */
+		return &ckpt->sit_nat_version_bitmap + offset + sizeof(__le32);
 	}
 
 	if (le32_to_cpu(F2FS_RAW_SUPER(sbi)->cp_payload) > 0) {
diff --git a/fsck/fsck.c b/fsck/fsck.c
index 88ed4d7..9e25477 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -1917,6 +1917,19 @@ int fsck_chk_meta(struct f2fs_sb_info *sbi)
 	return 0;
 }
 
+void fsck_chk_checkpoint(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
+
+	if (get_cp(ckpt_flags) & CP_LARGE_NAT_BITMAP_FLAG) {
+		if (get_cp(checksum_offset) !=
+			sizeof(struct f2fs_checkpoint) - 1) {
+			ASSERT_MSG("Deprecated layout of large_nat_bitmap, "
+				"chksum_offset:%u", get_cp(checksum_offset));
+		}
+	}
+}
+
 void fsck_init(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
@@ -2038,8 +2051,10 @@ static void fix_checkpoint(struct f2fs_sb_info *sbi)
 		flags |= CP_TRIMMED_FLAG;
 	if (is_set_ckpt_flags(cp, CP_DISABLED_FLAG))
 		flags |= CP_DISABLED_FLAG;
-	if (is_set_ckpt_flags(cp, CP_LARGE_NAT_BITMAP_FLAG))
+	if (is_set_ckpt_flags(cp, CP_LARGE_NAT_BITMAP_FLAG)) {
 		flags |= CP_LARGE_NAT_BITMAP_FLAG;
+		set_cp(checksum_offset, sizeof(struct f2fs_checkpoint) - 1);
+	}
 
 	if (flags & CP_UMOUNT_FLAG)
 		cp_blocks = 8;
@@ -2058,8 +2073,9 @@ static void fix_checkpoint(struct f2fs_sb_info *sbi)
 	set_cp(valid_node_count, fsck->chk.valid_node_cnt);
 	set_cp(valid_inode_count, fsck->chk.valid_inode_cnt);
 
-	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, cp, CP_CHKSUM_OFFSET);
-	*((__le32 *)((unsigned char *)cp + CP_CHKSUM_OFFSET)) = cpu_to_le32(crc);
+	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, cp, get_cp(checksum_offset));
+	*((__le32 *)((unsigned char *)cp + get_cp(checksum_offset))) =
+							cpu_to_le32(crc);
 
 	cp_blk_no = get_sb(cp_blkaddr);
 	if (sbi->cur_cp == 2)
diff --git a/fsck/fsck.h b/fsck/fsck.h
index 376ced7..dd831de 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -154,6 +154,7 @@ extern int fsck_chk_dentry_blk(struct f2fs_sb_info *, u32, struct child_info *,
 		int, int);
 int fsck_chk_inline_dentries(struct f2fs_sb_info *, struct f2fs_node *,
 		struct child_info *);
+void fsck_chk_checkpoint(struct f2fs_sb_info *sbi);
 int fsck_chk_meta(struct f2fs_sb_info *sbi);
 int fsck_chk_curseg_info(struct f2fs_sb_info *);
 int convert_encrypted_name(unsigned char *, u32, unsigned char *, int);
diff --git a/fsck/main.c b/fsck/main.c
index d3f0c0d..e61bb91 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -616,6 +616,8 @@ static void do_fsck(struct f2fs_sb_info *sbi)
 		c.fix_on = 1;
 	}
 
+	fsck_chk_checkpoint(sbi);
+
 	fsck_chk_quota_node(sbi);
 
 	/* Traverse all block recursively from root inode */
diff --git a/fsck/mount.c b/fsck/mount.c
index 20ecf07..5c55308 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -2365,8 +2365,10 @@ void write_checkpoint(struct f2fs_sb_info *sbi)
 		flags |= CP_TRIMMED_FLAG;
 	if (is_set_ckpt_flags(cp, CP_DISABLED_FLAG))
 		flags |= CP_DISABLED_FLAG;
-	if (is_set_ckpt_flags(cp, CP_LARGE_NAT_BITMAP_FLAG))
+	if (is_set_ckpt_flags(cp, CP_LARGE_NAT_BITMAP_FLAG)) {
 		flags |= CP_LARGE_NAT_BITMAP_FLAG;
+		set_cp(checksum_offset, sizeof(struct f2fs_checkpoint) - 1);
+	}
 
 	set_cp(free_segment_count, get_free_segments(sbi));
 	set_cp(valid_block_count, sbi->total_valid_block_count);
@@ -2375,8 +2377,9 @@ void write_checkpoint(struct f2fs_sb_info *sbi)
 	flags = update_nat_bits_flags(sb, cp, flags);
 	set_cp(ckpt_flags, flags);
 
-	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, cp, CP_CHKSUM_OFFSET);
-	*((__le32 *)((unsigned char *)cp + CP_CHKSUM_OFFSET)) = cpu_to_le32(crc);
+	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, cp, get_cp(checksum_offset));
+	*((__le32 *)((unsigned char *)cp + get_cp(checksum_offset))) =
+							cpu_to_le32(crc);
 
 	cp_blk_no = get_sb(cp_blkaddr);
 	if (sbi->cur_cp == 2)
diff --git a/fsck/resize.c b/fsck/resize.c
index 56c8103..2caa234 100644
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
+	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, new_cp, get_cp(checksum_offset));
+	*((__le32 *)((unsigned char *)new_cp + get_cp(checksum_offset))) =
 							cpu_to_le32(crc);
 
 	/* Write a new checkpoint in the other set */
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 4560611..1d54fb9 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -358,13 +358,11 @@ static int f2fs_prepare_super_block(void)
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
@@ -708,10 +706,13 @@ static int f2fs_write_check_point_pack(void)
 	set_cp(nat_ver_bitmap_bytesize, ((get_sb(segment_count_nat) / 2) <<
 			 get_sb(log_blocks_per_seg)) / 8);
 
-	set_cp(checksum_offset, CP_CHKSUM_OFFSET);
+	if (c.large_nat_bitmap)
+		set_cp(checksum_offset, CP_CHKSUM_OFFSET);
+	else
+		set_cp(checksum_offset, sizeof(struct f2fs_checkpoint) - 1);
 
-	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, cp, CP_CHKSUM_OFFSET);
-	*((__le32 *)((unsigned char *)cp + CP_CHKSUM_OFFSET)) =
+	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, cp, get_cp(checksum_offset));
+	*((__le32 *)((unsigned char *)cp + get_cp(checksum_offset))) =
 							cpu_to_le32(crc);
 
 	blk_size_bytes = 1 << get_sb(log_blocksize);
@@ -956,8 +957,8 @@ static int f2fs_write_check_point_pack(void)
 	 */
 	cp->checkpoint_ver = 0;
 
-	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, cp, CP_CHKSUM_OFFSET);
-	*((__le32 *)((unsigned char *)cp + CP_CHKSUM_OFFSET)) =
+	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, cp, get_cp(checksum_offset));
+	*((__le32 *)((unsigned char *)cp + get_cp(checksum_offset))) =
 							cpu_to_le32(crc);
 	cp_seg_blk = get_sb(segment0_blkaddr) + c.blks_per_seg;
 	DBG(1, "\tWriting cp page 1 of checkpoint pack 2, at offset 0x%08"PRIx64"\n",
-- 
2.18.0.rc1
