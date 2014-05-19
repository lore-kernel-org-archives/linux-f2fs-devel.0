From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH] f2fs: large volume support
Date: Mon, 19 May 2014 13:29:50 +0900
Message-ID: <1400473790-15333-1-git-send-email-cm224.lee@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Cc: Changman Lee <cm224.lee@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

f2fs's cp has one page which consists of struct f2fs_checkpoint and
version bitmap of sit and nat. To support lots of segments, we need more
blocks for sit bitmap. So let's arrange sit bitmap as following:
+-----------------+------------+
| f2fs_checkpoint | sit bitmap |
| + nat bitmap    |            |
+-----------------+------------+
0                 4k        N blocks

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 fs/f2fs/checkpoint.c    |   55 +++++++++++++++++++++++++++++++++++++++++++----
 fs/f2fs/f2fs.h          |   13 +++++++++--
 include/linux/f2fs_fs.h |    2 ++
 3 files changed, 64 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index fe968c7..05e18f8 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -366,12 +366,18 @@ static void recover_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
 void recover_orphan_inodes(struct f2fs_sb_info *sbi)
 {
 	block_t start_blk, orphan_blkaddr, i, j;
+	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
 
 	if (!is_set_ckpt_flags(F2FS_CKPT(sbi), CP_ORPHAN_PRESENT_FLAG))
 		return;
 
 	sbi->por_doing = true;
-	start_blk = __start_cp_addr(sbi) + 1;
+
+	if (is_set_ckpt_flags(ckpt, CP_LARGE_VOL_FLAG))
+		start_blk = __start_cp_addr(sbi) +
+			F2FS_BLK_ALIGN(ckpt->sit_ver_bitmap_bytesize);
+	else
+		start_blk = __start_cp_addr(sbi) + 1;
 	orphan_blkaddr = __start_sum_addr(sbi) - 1;
 
 	ra_meta_pages(sbi, start_blk, orphan_blkaddr, META_CP);
@@ -544,6 +550,32 @@ int get_valid_checkpoint(struct f2fs_sb_info *sbi)
 	cp_block = (struct f2fs_checkpoint *)page_address(cur_page);
 	memcpy(sbi->ckpt, cp_block, blk_size);
 
+	if (is_set_ckpt_flags(sbi->ckpt, CP_LARGE_VOL_FLAG)) {
+		int i, cp_blks;
+		block_t cp_blk_no;
+
+		cp_blk_no = le32_to_cpu(fsb->cp_blkaddr);
+		if (cur_page == cp2)
+			cp_blk_no += 1 << le32_to_cpu(fsb->log_blocks_per_seg);
+
+		cp_blks = 1 + F2FS_BLK_ALIGN(cp_block->sit_ver_bitmap_bytesize);
+
+		kfree(sbi->ckpt);
+		sbi->ckpt = kzalloc(cp_blks * blk_size, GFP_KERNEL);
+
+		memcpy(sbi->ckpt, cp_block, blk_size);
+
+		for (i = 1; i < cp_blks; i++) {
+			void *sit_bitmap_ptr;
+			unsigned char *ckpt = (unsigned char *)sbi->ckpt;
+
+			cur_page = get_meta_page(sbi, cp_blk_no + i);
+			sit_bitmap_ptr = page_address(cur_page);
+			memcpy(ckpt + i * blk_size, sit_bitmap_ptr, blk_size);
+			f2fs_put_page(cur_page, 1);
+		}
+	}
+
 	f2fs_put_page(cp1, 1);
 	f2fs_put_page(cp2, 1);
 	return 0;
@@ -736,6 +768,7 @@ static void do_checkpoint(struct f2fs_sb_info *sbi, bool is_umount)
 	__u32 crc32 = 0;
 	void *kaddr;
 	int i;
+	int sit_bitmap_blks = 0;
 
 	/*
 	 * This avoids to conduct wrong roll-forward operations and uses
@@ -786,16 +819,21 @@ static void do_checkpoint(struct f2fs_sb_info *sbi, bool is_umount)
 
 	orphan_blocks = (sbi->n_orphans + F2FS_ORPHANS_PER_BLOCK - 1)
 					/ F2FS_ORPHANS_PER_BLOCK;
-	ckpt->cp_pack_start_sum = cpu_to_le32(1 + orphan_blocks);
+	if (is_set_ckpt_flags(ckpt, CP_LARGE_VOL_FLAG))
+		sit_bitmap_blks = F2FS_BLK_ALIGN(ckpt->sit_ver_bitmap_bytesize);
+	ckpt->cp_pack_start_sum = cpu_to_le32(1 + sit_bitmap_blks +
+			orphan_blocks);
 
 	if (is_umount) {
 		set_ckpt_flags(ckpt, CP_UMOUNT_FLAG);
 		ckpt->cp_pack_total_block_count = cpu_to_le32(2 +
-			data_sum_blocks + orphan_blocks + NR_CURSEG_NODE_TYPE);
+				sit_bitmap_blks + data_sum_blocks +
+				orphan_blocks + NR_CURSEG_NODE_TYPE);
 	} else {
 		clear_ckpt_flags(ckpt, CP_UMOUNT_FLAG);
 		ckpt->cp_pack_total_block_count = cpu_to_le32(2 +
-			data_sum_blocks + orphan_blocks);
+				sit_bitmap_blks + data_sum_blocks +
+				orphan_blocks);
 	}
 
 	if (sbi->n_orphans)
@@ -821,6 +859,15 @@ static void do_checkpoint(struct f2fs_sb_info *sbi, bool is_umount)
 	set_page_dirty(cp_page);
 	f2fs_put_page(cp_page, 1);
 
+	for (i = 1; i < 1 + sit_bitmap_blks; i++) {
+		cp_page = grab_meta_page(sbi, start_blk++);
+		kaddr = page_address(cp_page);
+		memcpy(kaddr, (char *)ckpt + i * F2FS_BLKSIZE,
+				(1 << sbi->log_blocksize));
+		set_page_dirty(cp_page);
+		f2fs_put_page(cp_page, 1);
+	}
+
 	if (sbi->n_orphans) {
 		write_orphan_inodes(sbi, start_blk);
 		start_blk += orphan_blocks;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 676a2c6..9e147ae 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -764,9 +764,18 @@ static inline unsigned long __bitmap_size(struct f2fs_sb_info *sbi, int flag)
 static inline void *__bitmap_ptr(struct f2fs_sb_info *sbi, int flag)
 {
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
-	int offset = (flag == NAT_BITMAP) ?
+	int offset;
+
+	if (ckpt->ckpt_flags & CP_LARGE_VOL_FLAG) {
+		if (flag == NAT_BITMAP)
+			return &ckpt->sit_nat_version_bitmap;
+		else
+			return ((unsigned char *)ckpt + F2FS_BLKSIZE);
+	} else {
+		offset = (flag == NAT_BITMAP) ?
 			le32_to_cpu(ckpt->sit_ver_bitmap_bytesize) : 0;
-	return &ckpt->sit_nat_version_bitmap + offset;
+		return &ckpt->sit_nat_version_bitmap + offset;
+	}
 }
 
 static inline block_t __start_cp_addr(struct f2fs_sb_info *sbi)
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 8c03f71..0f0b788 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -19,6 +19,7 @@
 #define F2FS_LOG_SECTORS_PER_BLOCK	3	/* 4KB: F2FS_BLKSIZE */
 #define F2FS_BLKSIZE			4096	/* support only 4KB block */
 #define F2FS_MAX_EXTENSION		64	/* # of extension entries */
+#define F2FS_BLK_ALIGN(x)	(((x) + F2FS_BLKSIZE - 1) / F2FS_BLKSIZE)
 
 #define NULL_ADDR		((block_t)0)	/* used as block_t addresses */
 #define NEW_ADDR		((block_t)-1)	/* used as block_t addresses */
@@ -80,6 +81,7 @@ struct f2fs_super_block {
 /*
  * For checkpoint
  */
+#define CP_LARGE_VOL_FLAG	0x00000010
 #define CP_ERROR_FLAG		0x00000008
 #define CP_COMPACT_SUM_FLAG	0x00000004
 #define CP_ORPHAN_PRESENT_FLAG	0x00000002
-- 
1.7.9.5

