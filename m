From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/4] mkfs.f2fs: support nat_bits feature
Date: Mon, 13 Feb 2017 18:05:20 -0800
Message-ID: <20170214020520.18091-4-jaegeuk@kernel.org>
References: <20170214020520.18091-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cdSUu-0002Qm-Sd
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 14 Feb 2017 02:05:40 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cdSUp-0006zn-SP
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 14 Feb 2017 02:05:40 +0000
In-Reply-To: <20170214020520.18091-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch adds nat_bits in the last one ore two 4KB-sized blocks of first
checkpoint segment. So, now a set of checkpoint *segment* consists of:

< checkpoint segment >
----------------------
| cp page #1         | 4KB
----------------------
| compacted data sum | 4KB
----------------------
| node sum  #1       | 4KB
----------------------
| node sum  #2       | 4KB
----------------------
| node sum  #3       | 4KB
----------------------
| cp page #2         | 4KB
----------------------
...
----------------------
| crc|cpver          | 8 bytes
----------------------
| full NAT bits      | # of NAT segments / 2 * 512 / 8 bytes
----------------------
| empty NAT bits     | # of NAT segments / 2 * 512 / 8 bytes
----------------------

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c        |   8 +++-
 fsck/fsck.h        |   5 +++
 fsck/mount.c       | 127 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 fsck/resize.c      |  12 ++++-
 include/f2fs_fs.h  |  12 +++++
 mkfs/f2fs_format.c |  48 ++++++++++++++++++--
 6 files changed, 203 insertions(+), 9 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index b625153..116eae5 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -1779,9 +1779,11 @@ static void fix_checkpoint(struct f2fs_sb_info *sbi)
 		flags |= CP_ORPHAN_PRESENT_FLAG;
 	}
 
-	set_cp(ckpt_flags, flags);
 	set_cp(cp_pack_total_block_count, 8 + orphan_blks + get_sb(cp_payload));
 
+	flags = update_nat_bits_flags(sb, cp, flags);
+	set_cp(ckpt_flags, flags);
+
 	set_cp(free_segment_count, get_free_segments(sbi));
 	set_cp(valid_block_count, fsck->chk.valid_blk_cnt);
 	set_cp(valid_node_count, fsck->chk.valid_node_cnt);
@@ -1814,6 +1816,10 @@ static void fix_checkpoint(struct f2fs_sb_info *sbi)
 
 	ret = dev_write_block(cp, cp_blk_no++);
 	ASSERT(ret >= 0);
+
+	/* Write nat bits */
+	if (flags & CP_NAT_BITS_FLAG)
+		write_nat_bits(sbi, sb, cp, sbi->cur_cp);
 }
 
 int check_curseg_offset(struct f2fs_sb_info *sbi)
diff --git a/fsck/fsck.h b/fsck/fsck.h
index 5a6f018..b6c9cbd 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -178,6 +178,11 @@ extern struct f2fs_sit_block *get_current_sit_page(struct f2fs_sb_info *,
 extern void rewrite_current_sit_page(struct f2fs_sb_info *, unsigned int,
 			struct f2fs_sit_block *);
 
+extern u32 update_nat_bits_flags(struct f2fs_super_block *,
+				struct f2fs_checkpoint *, u32);
+extern void write_nat_bits(struct f2fs_sb_info *, struct f2fs_super_block *,
+			struct f2fs_checkpoint *, int);
+
 /* dump.c */
 struct dump_option {
 	nid_t nid;
diff --git a/fsck/mount.c b/fsck/mount.c
index 761baa0..5008437 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -257,6 +257,8 @@ void print_cp_state(u32 flag)
 		MSG(0, "%s", " orphan_inodes");
 	if (flag & CP_FASTBOOT_FLAG)
 		MSG(0, "%s", " fastboot");
+	if (flag & CP_NAT_BITS_FLAG)
+		MSG(0, "%s", " nat_bits");
 	if (flag & CP_UMOUNT_FLAG)
 		MSG(0, "%s", " unmount");
 	else
@@ -746,6 +748,92 @@ static int f2fs_init_nid_bitmap(struct f2fs_sb_info *sbi)
 	return 0;
 }
 
+u32 update_nat_bits_flags(struct f2fs_super_block *sb,
+				struct f2fs_checkpoint *cp, u32 flags)
+{
+	u_int32_t nat_bits_bytes, nat_bits_blocks;
+
+	nat_bits_bytes = get_sb(segment_count_nat) << 5;
+	nat_bits_blocks = F2FS_BYTES_TO_BLK((nat_bits_bytes << 1) + 8 +
+						F2FS_BLKSIZE - 1);
+	if (get_cp(cp_pack_total_block_count) <=
+			(1 << get_sb(log_blocks_per_seg)) - nat_bits_blocks)
+		flags |= CP_NAT_BITS_FLAG;
+	else
+		flags &= (~CP_NAT_BITS_FLAG);
+
+	return flags;
+}
+
+/* should call flush_journal_entries() bfore this */
+void write_nat_bits(struct f2fs_sb_info *sbi,
+	struct f2fs_super_block *sb, struct f2fs_checkpoint *cp, int set)
+{
+	struct f2fs_nm_info *nm_i = NM_I(sbi);
+	u_int32_t nat_blocks = get_sb(segment_count_nat) <<
+				(get_sb(log_blocks_per_seg) - 1);
+	u_int32_t nat_bits_bytes = nat_blocks >> 3;
+	u_int32_t nat_bits_blocks = F2FS_BYTES_TO_BLK((nat_bits_bytes << 1) +
+					8 + F2FS_BLKSIZE - 1);
+	unsigned char *nat_bits, *full_nat_bits, *empty_nat_bits;
+	struct f2fs_nat_block *nat_block;
+	u_int32_t i, j;
+	block_t blkaddr;
+	int ret;
+
+	nat_bits = calloc(F2FS_BLKSIZE, nat_bits_blocks);
+	ASSERT(nat_bits);
+
+	nat_block = malloc(F2FS_BLKSIZE);
+	ASSERT(nat_block);
+
+	full_nat_bits = nat_bits + 8;
+	empty_nat_bits = full_nat_bits + nat_bits_bytes;
+
+	memset(full_nat_bits, 0, nat_bits_bytes);
+	memset(empty_nat_bits, 0, nat_bits_bytes);
+
+	for (i = 0; i < nat_blocks; i++) {
+		int seg_off = i >> get_sb(log_blocks_per_seg);
+		int valid = 0;
+
+		blkaddr = (pgoff_t)(get_sb(nat_blkaddr) +
+				(seg_off << get_sb(log_blocks_per_seg) << 1) +
+				(i & ((1 << get_sb(log_blocks_per_seg)) - 1)));
+
+		if (f2fs_test_bit(i, nm_i->nat_bitmap))
+			blkaddr += (1 << get_sb(log_blocks_per_seg));
+
+		ret = dev_read_block(nat_block, blkaddr);
+		ASSERT(ret >= 0);
+
+		for (j = 0; j < NAT_ENTRY_PER_BLOCK; j++) {
+			if ((i == 0 && j == 0) ||
+				nat_block->entries[j].block_addr != NULL_ADDR)
+				valid++;
+		}
+		if (valid == 0)
+			test_and_set_bit_le(i, empty_nat_bits);
+		else if (valid == NAT_ENTRY_PER_BLOCK)
+			test_and_set_bit_le(i, full_nat_bits);
+	}
+	*(__le64 *)nat_bits = get_cp_crc(cp);
+	free(nat_block);
+
+	blkaddr = get_sb(segment0_blkaddr) + (set <<
+				get_sb(log_blocks_per_seg)) - nat_bits_blocks;
+
+	DBG(1, "\tWriting NAT bits pages, at offset 0x%08x\n", blkaddr);
+
+	for (i = 0; i < nat_bits_blocks; i++) {
+		if (dev_write_block(nat_bits + i * F2FS_BLKSIZE, blkaddr + i))
+			ASSERT_MSG("\tError: write NAT bits to disk!!!\n");
+	}
+	MSG(0, "Info: Write valid nat_bits in checkpoint\n");
+
+	free(nat_bits);
+}
+
 int init_node_manager(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
@@ -1781,12 +1869,13 @@ void write_checkpoint(struct f2fs_sb_info *sbi)
 		flags |= CP_ORPHAN_PRESENT_FLAG;
 	}
 
-	set_cp(ckpt_flags, flags);
-
 	set_cp(free_segment_count, get_free_segments(sbi));
 	set_cp(valid_block_count, sbi->total_valid_block_count);
 	set_cp(cp_pack_total_block_count, 8 + orphan_blks + get_sb(cp_payload));
 
+	flags = update_nat_bits_flags(sb, cp, flags);
+	set_cp(ckpt_flags, flags);
+
 	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, cp, CHECKSUM_OFFSET);
 	*((__le32 *)((unsigned char *)cp + CHECKSUM_OFFSET)) = cpu_to_le32(crc);
 
@@ -1820,6 +1909,10 @@ void write_checkpoint(struct f2fs_sb_info *sbi)
 	/* write the last cp */
 	ret = dev_write_block(cp, cp_blk_no++);
 	ASSERT(ret >= 0);
+
+	/* Write nat bits */
+	if (flags & CP_NAT_BITS_FLAG)
+		write_nat_bits(sbi, sb, cp, sbi->cur_cp);
 }
 
 void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
@@ -1995,6 +2088,7 @@ static int check_sector_size(struct f2fs_super_block *sb)
 int f2fs_do_mount(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_checkpoint *cp = NULL;
+	struct f2fs_super_block *sb = NULL;
 	int ret;
 
 	sbi->active_logs = NR_CURSEG_TYPE;
@@ -2004,12 +2098,13 @@ int f2fs_do_mount(struct f2fs_sb_info *sbi)
 		if (ret)
 			return -1;
 	}
+	sb = F2FS_RAW_SUPER(sbi);
 
-	ret = check_sector_size(sbi->raw_super);
+	ret = check_sector_size(sb);
 	if (ret)
 		return -1;
 
-	print_raw_sb_info(F2FS_RAW_SUPER(sbi));
+	print_raw_sb_info(sb);
 
 	init_sb_info(sbi);
 
@@ -2055,6 +2150,30 @@ int f2fs_do_mount(struct f2fs_sb_info *sbi)
 		return -1;
 	}
 
+	/* Check nat_bits */
+	if (is_set_ckpt_flags(cp, CP_NAT_BITS_FLAG)) {
+		u_int32_t nat_bits_bytes, nat_bits_blocks;
+		__le64 *kaddr;
+		u_int32_t blk;
+
+		blk = get_sb(cp_blkaddr) + (1 << get_sb(log_blocks_per_seg));
+		if (sbi->cur_cp == 2)
+			blk += 1 << get_sb(log_blocks_per_seg);
+
+		nat_bits_bytes = get_sb(segment_count_nat) << 5;
+		nat_bits_blocks = F2FS_BYTES_TO_BLK((nat_bits_bytes << 1) + 8 +
+				F2FS_BLKSIZE - 1);
+		blk -= nat_bits_blocks;
+
+		kaddr = malloc(PAGE_SIZE);
+		ret = dev_read_block(kaddr, blk);
+		ASSERT(ret >= 0);
+		if (*kaddr != get_cp_crc(cp))
+			write_nat_bits(sbi, sb, cp, sbi->cur_cp);
+		else
+			MSG(0, "Info: Found valid nat_bits in checkpoint\n");
+		free(kaddr);
+	}
 	return 0;
 }
 
diff --git a/fsck/resize.c b/fsck/resize.c
index 4791f74..4584d6f 100644
--- a/fsck/resize.c
+++ b/fsck/resize.c
@@ -423,6 +423,7 @@ static void rebuild_checkpoint(struct f2fs_sb_info *sbi,
 	block_t orphan_blks = 0;
 	block_t new_cp_blk_no, old_cp_blk_no;
 	u_int32_t crc = 0;
+	u32 flags;
 	void *buf;
 	int i, ret;
 
@@ -475,12 +476,17 @@ static void rebuild_checkpoint(struct f2fs_sb_info *sbi,
 			((get_newsb(segment_count_nat) / 2) <<
 			get_newsb(log_blocks_per_seg)) / 8);
 
+	/* update nat_bits flag */
+	flags = update_nat_bits_flags(new_sb, cp, get_cp(ckpt_flags));
+	set_cp(ckpt_flags, flags);
+
 	memcpy(new_cp, cp, (unsigned char *)cp->sit_nat_version_bitmap -
 						(unsigned char *)cp);
 	new_cp->checkpoint_ver = cpu_to_le64(cp_ver + 1);
 
 	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, new_cp, CHECKSUM_OFFSET);
-	*((__le32 *)((unsigned char *)new_cp + CHECKSUM_OFFSET)) = cpu_to_le32(crc);
+	*((__le32 *)((unsigned char *)new_cp + CHECKSUM_OFFSET)) =
+							cpu_to_le32(crc);
 
 	/* Write a new checkpoint in the other set */
 	new_cp_blk_no = old_cp_blk_no = get_sb(cp_blkaddr);
@@ -521,6 +527,10 @@ static void rebuild_checkpoint(struct f2fs_sb_info *sbi,
 	ret = dev_write_block(new_cp, new_cp_blk_no++);
 	ASSERT(ret >= 0);
 
+	/* Write nat bits */
+	if (flags & CP_NAT_BITS_FLAG)
+		write_nat_bits(sbi, new_sb, new_cp, sbi->cur_cp == 1 ? 2 : 1);
+
 	/* disable old checkpoint */
 	memset(buf, 0, BLOCK_SZ);
 	ret = dev_write_block(buf, old_cp_blk_no);
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 44c5d61..057adf3 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -514,6 +514,7 @@ struct f2fs_super_block {
 /*
  * For checkpoint
  */
+#define CP_NAT_BITS_FLAG	0x00000080
 #define CP_CRC_RECOVERY_FLAG	0x00000040
 #define CP_FASTBOOT_FLAG	0x00000020
 #define CP_FSCK_FLAG		0x00000010
@@ -1084,4 +1085,15 @@ static inline double get_best_overprovision(struct f2fs_super_block *sb)
 	return max_ovp;
 }
 
+static inline __le64 get_cp_crc(struct f2fs_checkpoint *cp)
+{
+	u_int64_t cp_ver = get_cp(checkpoint_ver);
+	size_t crc_offset = get_cp(checksum_offset);
+	u_int32_t crc = le32_to_cpu(*(__le32 *)((unsigned char *)cp +
+							crc_offset));
+
+	cp_ver |= ((u_int64_t)crc << 32);
+	return cpu_to_le64(cp_ver);
+}
+
 #endif	/*__F2FS_FS_H */
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index e61adaa..f6279b5 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -472,8 +472,10 @@ static int f2fs_write_check_point_pack(void)
 	struct f2fs_summary_block *sum = NULL;
 	struct f2fs_journal *journal;
 	u_int32_t blk_size_bytes;
+	u_int32_t nat_bits_bytes, nat_bits_blocks;
+	unsigned char *nat_bits = NULL, *empty_nat_bits;
 	u_int64_t cp_seg_blk = 0;
-	u_int32_t crc = 0;
+	u_int32_t crc = 0, flags;
 	unsigned int i;
 	char *cp_payload = NULL;
 	char *sum_compact, *sum_compact_p;
@@ -499,10 +501,19 @@ static int f2fs_write_check_point_pack(void)
 	}
 	sum_compact_p = sum_compact;
 
+	nat_bits_bytes = get_sb(segment_count_nat) << 5;
+	nat_bits_blocks = F2FS_BYTES_TO_BLK((nat_bits_bytes << 1) + 8 +
+						F2FS_BLKSIZE - 1);
+	nat_bits = calloc(F2FS_BLKSIZE, nat_bits_blocks);
+	if (nat_bits == NULL) {
+		MSG(1, "\tError: Calloc Failed for nat bits buffer!!!\n");
+		goto free_sum_compact;
+	}
+
 	cp_payload = calloc(F2FS_BLKSIZE, 1);
 	if (cp_payload == NULL) {
 		MSG(1, "\tError: Calloc Failed for cp_payload!!!\n");
-		goto free_sum_compact;
+		goto free_nat_bits;
 	}
 
 	/* 1. cp page 1 of checkpoint pack 1 */
@@ -539,7 +550,11 @@ static int f2fs_write_check_point_pack(void)
 			get_cp(overprov_segment_count)) * c.blks_per_seg));
 	/* cp page (2), data summaries (1), node summaries (3) */
 	set_cp(cp_pack_total_block_count, 6 + get_sb(cp_payload));
-	set_cp(ckpt_flags, CP_UMOUNT_FLAG | CP_COMPACT_SUM_FLAG);
+	flags = CP_UMOUNT_FLAG | CP_COMPACT_SUM_FLAG;
+	if (get_cp(cp_pack_total_block_count) <=
+			(1 << get_sb(log_blocks_per_seg)) - nat_bits_blocks)
+		flags |= CP_NAT_BITS_FLAG;
+	set_cp(ckpt_flags, flags);
 	set_cp(cp_pack_start_sum, 1 + get_sb(cp_payload));
 	set_cp(valid_node_count, 1);
 	set_cp(valid_inode_count, 1);
@@ -702,6 +717,31 @@ static int f2fs_write_check_point_pack(void)
 		goto free_cp_payload;
 	}
 
+	/* write NAT bits, if possible */
+	if (flags & CP_NAT_BITS_FLAG) {
+		int i;
+
+		*(__le64 *)nat_bits = get_cp_crc(cp);
+		empty_nat_bits = nat_bits + 8 + nat_bits_bytes;
+		memset(empty_nat_bits, 0xff, nat_bits_bytes);
+		test_and_clear_bit_le(0, empty_nat_bits);
+
+		/* write the last blocks in cp pack */
+		cp_seg_blk = get_sb(segment0_blkaddr) + (1 <<
+				get_sb(log_blocks_per_seg)) - nat_bits_blocks;
+
+		DBG(1, "\tWriting NAT bits pages, at offset 0x%08"PRIx64"\n",
+					cp_seg_blk);
+
+		for (i = 0; i < nat_bits_blocks; i++) {
+			if (dev_write_block(nat_bits + i *
+						F2FS_BLKSIZE, cp_seg_blk + i)) {
+				MSG(1, "\tError: write NAT bits to disk!!!\n");
+				goto free_cp_payload;
+			}
+		}
+	}
+
 	/* cp page 1 of check point pack 2
 	 * Initiatialize other checkpoint pack with version zero
 	 */
@@ -741,6 +781,8 @@ static int f2fs_write_check_point_pack(void)
 
 free_cp_payload:
 	free(cp_payload);
+free_nat_bits:
+	free(nat_bits);
 free_sum_compact:
 	free(sum_compact);
 free_sum:
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
