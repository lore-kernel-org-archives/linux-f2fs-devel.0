From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] fsck.f2fs: use get_{sb|cp} and set_{sb|cp}
	macros
Date: Wed,  2 Dec 2015 13:40:41 -0800
Message-ID: <1449092441-61376-2-git-send-email-jaegeuk@kernel.org>
References: <1449092441-61376-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1a4F8z-0003fo-Lr
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 02 Dec 2015 21:40:57 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1a4F8x-0002QV-Q3 for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 02 Dec 2015 21:40:57 +0000
In-Reply-To: <1449092441-61376-1-git-send-email-jaegeuk@kernel.org>
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

We can use get_cp, set_cp, get_sb, and set_sb in fsck.f2fs.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c  |  43 ++++++-------
 fsck/mount.c | 204 ++++++++++++++++++++++++++++-------------------------------
 2 files changed, 116 insertions(+), 131 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index faa1568..c71f225 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -1137,14 +1137,13 @@ void fsck_chk_orphan_node(struct f2fs_sb_info *sbi)
 	u32 blk_cnt = 0;
 	block_t start_blk, orphan_blkaddr, i, j;
 	struct f2fs_orphan_block *orphan_blk, *new_blk;
-	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
+	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
 	u32 entry_count;
 
-	if (!is_set_ckpt_flags(ckpt, CP_ORPHAN_PRESENT_FLAG))
+	if (!is_set_ckpt_flags(F2FS_CKPT(sbi), CP_ORPHAN_PRESENT_FLAG))
 		return;
 
-	start_blk = __start_cp_addr(sbi) + 1 +
-		le32_to_cpu(F2FS_RAW_SUPER(sbi)->cp_payload);
+	start_blk = __start_cp_addr(sbi) + 1 + get_sb(cp_payload);
 	orphan_blkaddr = __start_sum_addr(sbi) - 1;
 
 	orphan_blk = calloc(BLOCK_SZ, 1);
@@ -1262,8 +1261,8 @@ static void fix_nat_entries(struct f2fs_sb_info *sbi)
 static void fix_checkpoint(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
-	struct f2fs_super_block *raw_sb = sbi->raw_super;
-	struct f2fs_checkpoint *ckp = F2FS_CKPT(sbi);
+	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
+	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
 	unsigned long long cp_blk_no;
 	u32 flags = CP_UMOUNT_FLAG;
 	block_t orphan_blks = 0;
@@ -1271,33 +1270,31 @@ static void fix_checkpoint(struct f2fs_sb_info *sbi)
 	int ret;
 	u_int32_t crc = 0;
 
-	if (is_set_ckpt_flags(ckp, CP_ORPHAN_PRESENT_FLAG)) {
+	if (is_set_ckpt_flags(cp, CP_ORPHAN_PRESENT_FLAG)) {
 		orphan_blks = __start_sum_addr(sbi) - 1;
 		flags |= CP_ORPHAN_PRESENT_FLAG;
 	}
 
-	ckp->ckpt_flags = cpu_to_le32(flags);
-	ckp->cp_pack_total_block_count =
-		cpu_to_le32(8 + orphan_blks + le32_to_cpu(raw_sb->cp_payload));
+	set_cp(ckpt_flags, flags);
+	set_cp(cp_pack_total_block_count, 8 + orphan_blks + get_sb(cp_payload));
 
-	ckp->free_segment_count = cpu_to_le32(fsck->chk.free_segs);
-	ckp->valid_block_count = cpu_to_le32(fsck->chk.valid_blk_cnt);
-	ckp->valid_node_count = cpu_to_le32(fsck->chk.valid_node_cnt);
-	ckp->valid_inode_count = cpu_to_le32(fsck->chk.valid_inode_cnt);
+	set_cp(free_segment_count, fsck->chk.free_segs);
+	set_cp(valid_block_count, fsck->chk.valid_blk_cnt);
+	set_cp(valid_node_count, fsck->chk.valid_node_cnt);
+	set_cp(valid_inode_count, fsck->chk.valid_inode_cnt);
 
-	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, ckp, CHECKSUM_OFFSET);
-	*((__le32 *)((unsigned char *)ckp + CHECKSUM_OFFSET)) =
-							cpu_to_le32(crc);
+	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, cp, CHECKSUM_OFFSET);
+	*((__le32 *)((unsigned char *)cp + CHECKSUM_OFFSET)) = cpu_to_le32(crc);
 
-	cp_blk_no = le32_to_cpu(raw_sb->cp_blkaddr);
+	cp_blk_no = get_sb(cp_blkaddr);
 	if (sbi->cur_cp == 2)
-		cp_blk_no += 1 << le32_to_cpu(raw_sb->log_blocks_per_seg);
+		cp_blk_no += 1 << get_sb(log_blocks_per_seg);
 
-	ret = dev_write_block(ckp, cp_blk_no++);
+	ret = dev_write_block(cp, cp_blk_no++);
 	ASSERT(ret >= 0);
 
-	for (i = 0; i < le32_to_cpu(raw_sb->cp_payload); i++) {
-		ret = dev_write_block(((unsigned char *)ckp) + i * F2FS_BLKSIZE,
+	for (i = 0; i < get_sb(cp_payload); i++) {
+		ret = dev_write_block(((unsigned char *)cp) + i * F2FS_BLKSIZE,
 								cp_blk_no++);
 		ASSERT(ret >= 0);
 	}
@@ -1311,7 +1308,7 @@ static void fix_checkpoint(struct f2fs_sb_info *sbi)
 		ASSERT(ret >= 0);
 	}
 
-	ret = dev_write_block(ckp, cp_blk_no++);
+	ret = dev_write_block(cp, cp_blk_no++);
 	ASSERT(ret >= 0);
 }
 
diff --git a/fsck/mount.c b/fsck/mount.c
index ae3065f..9431cd0 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -242,34 +242,27 @@ void print_sb_state(struct f2fs_super_block *sb)
 	MSG(0, "\n");
 }
 
-int sanity_check_raw_super(struct f2fs_super_block *raw_super)
+int sanity_check_raw_super(struct f2fs_super_block *sb)
 {
 	unsigned int blocksize;
 
-	if (F2FS_SUPER_MAGIC != le32_to_cpu(raw_super->magic)) {
+	if (F2FS_SUPER_MAGIC != get_sb(magic))
 		return -1;
-	}
 
-	if (F2FS_BLKSIZE != PAGE_CACHE_SIZE) {
+	if (F2FS_BLKSIZE != PAGE_CACHE_SIZE)
 		return -1;
-	}
 
-	blocksize = 1 << le32_to_cpu(raw_super->log_blocksize);
-	if (F2FS_BLKSIZE != blocksize) {
+	blocksize = 1 << get_sb(log_blocksize);
+	if (F2FS_BLKSIZE != blocksize)
 		return -1;
-	}
 
-	if (le32_to_cpu(raw_super->log_sectorsize) > F2FS_MAX_LOG_SECTOR_SIZE ||
-		le32_to_cpu(raw_super->log_sectorsize) <
-						F2FS_MIN_LOG_SECTOR_SIZE) {
+	if (get_sb(log_sectorsize) > F2FS_MAX_LOG_SECTOR_SIZE ||
+			get_sb(log_sectorsize) < F2FS_MIN_LOG_SECTOR_SIZE)
 		return -1;
-	}
 
-	if (le32_to_cpu(raw_super->log_sectors_per_block) +
-				le32_to_cpu(raw_super->log_sectorsize) !=
-						F2FS_MAX_LOG_SECTOR_SIZE) {
+	if (get_sb(log_sectors_per_block) + get_sb(log_sectorsize) !=
+						F2FS_MAX_LOG_SECTOR_SIZE)
 		return -1;
-	}
 
 	return 0;
 }
@@ -330,28 +323,25 @@ int validate_super_block(struct f2fs_sb_info *sbi, int block)
 
 int init_sb_info(struct f2fs_sb_info *sbi)
 {
-	struct f2fs_super_block *raw_super = sbi->raw_super;
+	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
 	u64 total_sectors;
 
-	sbi->log_sectors_per_block =
-		le32_to_cpu(raw_super->log_sectors_per_block);
-	sbi->log_blocksize = le32_to_cpu(raw_super->log_blocksize);
+	sbi->log_sectors_per_block = get_sb(log_sectors_per_block);
+	sbi->log_blocksize = get_sb(log_blocksize);
 	sbi->blocksize = 1 << sbi->log_blocksize;
-	sbi->log_blocks_per_seg = le32_to_cpu(raw_super->log_blocks_per_seg);
+	sbi->log_blocks_per_seg = get_sb(log_blocks_per_seg);
 	sbi->blocks_per_seg = 1 << sbi->log_blocks_per_seg;
-	sbi->segs_per_sec = le32_to_cpu(raw_super->segs_per_sec);
-	sbi->secs_per_zone = le32_to_cpu(raw_super->secs_per_zone);
-	sbi->total_sections = le32_to_cpu(raw_super->section_count);
-	sbi->total_node_count =
-		(le32_to_cpu(raw_super->segment_count_nat) / 2)
-		* sbi->blocks_per_seg * NAT_ENTRY_PER_BLOCK;
-	sbi->root_ino_num = le32_to_cpu(raw_super->root_ino);
-	sbi->node_ino_num = le32_to_cpu(raw_super->node_ino);
-	sbi->meta_ino_num = le32_to_cpu(raw_super->meta_ino);
+	sbi->segs_per_sec = get_sb(segs_per_sec);
+	sbi->secs_per_zone = get_sb(secs_per_zone);
+	sbi->total_sections = get_sb(section_count);
+	sbi->total_node_count = (get_sb(segment_count_nat) / 2) *
+				sbi->blocks_per_seg * NAT_ENTRY_PER_BLOCK;
+	sbi->root_ino_num = get_sb(root_ino);
+	sbi->node_ino_num = get_sb(node_ino);
+	sbi->meta_ino_num = get_sb(meta_ino);
 	sbi->cur_victim_sec = NULL_SEGNO;
 
-	total_sectors = le64_to_cpu(raw_super->block_count) <<
-					sbi->log_sectors_per_block;
+	total_sectors = get_sb(block_count) << sbi->log_sectors_per_block;
 	MSG(0, "Info: total FS sectors = %"PRIu64" (%"PRIu64" MB)\n",
 				total_sectors, total_sectors >> 11);
 	return 0;
@@ -361,7 +351,7 @@ void *validate_checkpoint(struct f2fs_sb_info *sbi, block_t cp_addr,
 				unsigned long long *version)
 {
 	void *cp_page_1, *cp_page_2;
-	struct f2fs_checkpoint *cp_block;
+	struct f2fs_checkpoint *cp;
 	unsigned long blk_size = sbi->blocksize;
 	unsigned long long cur_version = 0, pre_version = 0;
 	unsigned int crc = 0;
@@ -372,34 +362,34 @@ void *validate_checkpoint(struct f2fs_sb_info *sbi, block_t cp_addr,
 	if (dev_read_block(cp_page_1, cp_addr) < 0)
 		return NULL;
 
-	cp_block = (struct f2fs_checkpoint *)cp_page_1;
-	crc_offset = le32_to_cpu(cp_block->checksum_offset);
+	cp = (struct f2fs_checkpoint *)cp_page_1;
+	crc_offset = get_cp(checksum_offset);
 	if (crc_offset >= blk_size)
 		goto invalid_cp1;
 
-	crc = *(unsigned int *)((unsigned char *)cp_block + crc_offset);
-	if (f2fs_crc_valid(crc, cp_block, crc_offset))
+	crc = *(unsigned int *)((unsigned char *)cp + crc_offset);
+	if (f2fs_crc_valid(crc, cp, crc_offset))
 		goto invalid_cp1;
 
-	pre_version = le64_to_cpu(cp_block->checkpoint_ver);
+	pre_version = get_cp(checkpoint_ver);
 
 	/* Read the 2nd cp block in this CP pack */
 	cp_page_2 = malloc(PAGE_SIZE);
-	cp_addr += le32_to_cpu(cp_block->cp_pack_total_block_count) - 1;
+	cp_addr += get_cp(cp_pack_total_block_count) - 1;
 
 	if (dev_read_block(cp_page_2, cp_addr) < 0)
 		goto invalid_cp2;
 
-	cp_block = (struct f2fs_checkpoint *)cp_page_2;
-	crc_offset = le32_to_cpu(cp_block->checksum_offset);
+	cp = (struct f2fs_checkpoint *)cp_page_2;
+	crc_offset = get_cp(checksum_offset);
 	if (crc_offset >= blk_size)
 		goto invalid_cp2;
 
-	crc = *(unsigned int *)((unsigned char *)cp_block + crc_offset);
-	if (f2fs_crc_valid(crc, cp_block, crc_offset))
+	crc = *(unsigned int *)((unsigned char *)cp + crc_offset);
+	if (f2fs_crc_valid(crc, cp, crc_offset))
 		goto invalid_cp2;
 
-	cur_version = le64_to_cpu(cp_block->checkpoint_ver);
+	cur_version = get_cp(checkpoint_ver);
 
 	if (cur_version == pre_version) {
 		*version = cur_version;
@@ -416,12 +406,12 @@ invalid_cp1:
 
 int get_valid_checkpoint(struct f2fs_sb_info *sbi)
 {
-	struct f2fs_super_block *raw_sb = sbi->raw_super;
+	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
 	void *cp1, *cp2, *cur_page;
 	unsigned long blk_size = sbi->blocksize;
 	unsigned long long cp1_version = 0, cp2_version = 0, version;
 	unsigned long long cp_start_blk_no;
-	unsigned int cp_blks = 1 + le32_to_cpu(F2FS_RAW_SUPER(sbi)->cp_payload);
+	unsigned int cp_blks = 1 + get_sb(cp_payload);
 	int ret;
 
 	sbi->ckpt = malloc(cp_blks * blk_size);
@@ -431,11 +421,11 @@ int get_valid_checkpoint(struct f2fs_sb_info *sbi)
 	 * Finding out valid cp block involves read both
 	 * sets( cp pack1 and cp pack 2)
 	 */
-	cp_start_blk_no = le32_to_cpu(raw_sb->cp_blkaddr);
+	cp_start_blk_no = get_sb(cp_blkaddr);
 	cp1 = validate_checkpoint(sbi, cp_start_blk_no, &cp1_version);
 
 	/* The second checkpoint pack should start at the next segment */
-	cp_start_blk_no += 1 << le32_to_cpu(raw_sb->log_blocks_per_seg);
+	cp_start_blk_no += 1 << get_sb(log_blocks_per_seg);
 	cp2 = validate_checkpoint(sbi, cp_start_blk_no, &cp2_version);
 
 	if (cp1 && cp2) {
@@ -470,10 +460,10 @@ int get_valid_checkpoint(struct f2fs_sb_info *sbi)
 		unsigned int i;
 		unsigned long long cp_blk_no;
 
-		cp_blk_no = le32_to_cpu(raw_sb->cp_blkaddr);
+		cp_blk_no = get_sb(cp_blkaddr);
 		if (cur_page == cp2)
-			cp_blk_no += 1 <<
-				le32_to_cpu(raw_sb->log_blocks_per_seg);
+			cp_blk_no += 1 << get_sb(log_blocks_per_seg);
+
 		/* copy sit bitmap */
 		for (i = 1; i < cp_blks; i++) {
 			unsigned char *ckpt = (unsigned char *)sbi->ckpt;
@@ -494,15 +484,15 @@ fail_no_cp:
 int sanity_check_ckpt(struct f2fs_sb_info *sbi)
 {
 	unsigned int total, fsmeta;
-	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
-	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
+	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
+	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
 
-	total = le32_to_cpu(raw_super->segment_count);
-	fsmeta = le32_to_cpu(raw_super->segment_count_ckpt);
-	fsmeta += le32_to_cpu(raw_super->segment_count_sit);
-	fsmeta += le32_to_cpu(raw_super->segment_count_nat);
-	fsmeta += le32_to_cpu(ckpt->rsvd_segment_count);
-	fsmeta += le32_to_cpu(raw_super->segment_count_ssa);
+	total = get_sb(segment_count);
+	fsmeta = get_sb(segment_count_ckpt);
+	fsmeta += get_sb(segment_count_sit);
+	fsmeta += get_sb(segment_count_nat);
+	fsmeta += get_cp(rsvd_segment_count);
+	fsmeta += get_sb(segment_count_ssa);
 
 	if (fsmeta >= total)
 		return 1;
@@ -512,21 +502,22 @@ int sanity_check_ckpt(struct f2fs_sb_info *sbi)
 
 int init_node_manager(struct f2fs_sb_info *sbi)
 {
-	struct f2fs_super_block *sb_raw = F2FS_RAW_SUPER(sbi);
+	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
+	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	unsigned char *version_bitmap;
 	unsigned int nat_segs, nat_blocks;
 
-	nm_i->nat_blkaddr = le32_to_cpu(sb_raw->nat_blkaddr);
+	nm_i->nat_blkaddr = get_sb(nat_blkaddr);
 
 	/* segment_count_nat includes pair segment so divide to 2. */
-	nat_segs = le32_to_cpu(sb_raw->segment_count_nat) >> 1;
-	nat_blocks = nat_segs << le32_to_cpu(sb_raw->log_blocks_per_seg);
+	nat_segs = get_sb(segment_count_nat) >> 1;
+	nat_blocks = nat_segs << get_sb(log_blocks_per_seg);
 	nm_i->max_nid = NAT_ENTRY_PER_BLOCK * nat_blocks;
 	nm_i->fcnt = 0;
 	nm_i->nat_cnt = 0;
-	nm_i->init_scan_nid = le32_to_cpu(sbi->ckpt->next_free_nid);
-	nm_i->next_scan_nid = le32_to_cpu(sbi->ckpt->next_free_nid);
+	nm_i->init_scan_nid = get_cp(next_free_nid);
+	nm_i->next_scan_nid = get_cp(next_free_nid);
 
 	nm_i->bitmap_size = __bitmap_size(sbi, NAT_BITMAP);
 
@@ -558,8 +549,8 @@ int build_node_manager(struct f2fs_sb_info *sbi)
 
 int build_sit_info(struct f2fs_sb_info *sbi)
 {
-	struct f2fs_super_block *raw_sb = F2FS_RAW_SUPER(sbi);
-	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
+	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
+	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
 	struct sit_info *sit_i;
 	unsigned int sit_segs, start;
 	char *src_bitmap, *dst_bitmap;
@@ -583,21 +574,21 @@ int build_sit_info(struct f2fs_sb_info *sbi)
 			return -ENOMEM;
 	}
 
-	sit_segs = le32_to_cpu(raw_sb->segment_count_sit) >> 1;
+	sit_segs = get_sb(segment_count_sit) >> 1;
 	bitmap_size = __bitmap_size(sbi, SIT_BITMAP);
 	src_bitmap = __bitmap_ptr(sbi, SIT_BITMAP);
 
 	dst_bitmap = malloc(bitmap_size);
 	memcpy(dst_bitmap, src_bitmap, bitmap_size);
 
-	sit_i->sit_base_addr = le32_to_cpu(raw_sb->sit_blkaddr);
+	sit_i->sit_base_addr = get_sb(sit_blkaddr);
 	sit_i->sit_blocks = sit_segs << sbi->log_blocks_per_seg;
-	sit_i->written_valid_blocks = le64_to_cpu(ckpt->valid_block_count);
+	sit_i->written_valid_blocks = get_cp(valid_block_count);
 	sit_i->sit_bitmap = dst_bitmap;
 	sit_i->bitmap_size = bitmap_size;
 	sit_i->dirty_sentries = 0;
 	sit_i->sents_per_block = SIT_ENTRY_PER_BLOCK;
-	sit_i->elapsed_time = le64_to_cpu(ckpt->elapsed_time);
+	sit_i->elapsed_time = get_cp(elapsed_time);
 	return 0;
 }
 
@@ -694,7 +685,7 @@ static void restore_node_summary(struct f2fs_sb_info *sbi,
 
 static void read_normal_summaries(struct f2fs_sb_info *sbi, int type)
 {
-	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
+	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
 	struct f2fs_summary_block *sum_blk;
 	struct curseg_info *curseg;
 	unsigned int segno = 0;
@@ -702,15 +693,14 @@ static void read_normal_summaries(struct f2fs_sb_info *sbi, int type)
 	int ret;
 
 	if (IS_DATASEG(type)) {
-		segno = le32_to_cpu(ckpt->cur_data_segno[type]);
-		if (is_set_ckpt_flags(ckpt, CP_UMOUNT_FLAG))
+		segno = get_cp(cur_data_segno[type]);
+		if (is_set_ckpt_flags(cp, CP_UMOUNT_FLAG))
 			blk_addr = sum_blk_addr(sbi, NR_CURSEG_TYPE, type);
 		else
 			blk_addr = sum_blk_addr(sbi, NR_CURSEG_DATA_TYPE, type);
 	} else {
-		segno = le32_to_cpu(ckpt->cur_node_segno[type -
-							CURSEG_HOT_NODE]);
-		if (is_set_ckpt_flags(ckpt, CP_UMOUNT_FLAG))
+		segno = get_cp(cur_node_segno[type - CURSEG_HOT_NODE]);
+		if (is_set_ckpt_flags(cp, CP_UMOUNT_FLAG))
 			blk_addr = sum_blk_addr(sbi, NR_CURSEG_NODE_TYPE,
 							type - CURSEG_HOT_NODE);
 		else
@@ -721,7 +711,7 @@ static void read_normal_summaries(struct f2fs_sb_info *sbi, int type)
 	ret = dev_read_block(sum_blk, blk_addr);
 	ASSERT(ret >= 0);
 
-	if (IS_NODESEG(type) && !is_set_ckpt_flags(ckpt, CP_UMOUNT_FLAG))
+	if (IS_NODESEG(type) && !is_set_ckpt_flags(cp, CP_UMOUNT_FLAG))
 		restore_node_summary(sbi, segno, sum_blk);
 
 	curseg = CURSEG_I(sbi, type);
@@ -745,7 +735,7 @@ static void restore_curseg_summaries(struct f2fs_sb_info *sbi)
 
 static void build_curseg(struct f2fs_sb_info *sbi)
 {
-	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
+	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
 	struct curseg_info *array;
 	unsigned short blk_off;
 	unsigned int segno;
@@ -760,20 +750,18 @@ static void build_curseg(struct f2fs_sb_info *sbi)
 		array[i].sum_blk = malloc(PAGE_CACHE_SIZE);
 		ASSERT(array[i].sum_blk);
 		if (i <= CURSEG_COLD_DATA) {
-			blk_off = le16_to_cpu(ckpt->cur_data_blkoff[i]);
-			segno = le32_to_cpu(ckpt->cur_data_segno[i]);
+			blk_off = get_cp(cur_data_blkoff[i]);
+			segno = get_cp(cur_data_segno[i]);
 		}
 		if (i > CURSEG_COLD_DATA) {
-			blk_off = le16_to_cpu(ckpt->cur_node_blkoff[i -
-							CURSEG_HOT_NODE]);
-			segno = le32_to_cpu(ckpt->cur_node_segno[i -
-							CURSEG_HOT_NODE]);
+			blk_off = get_cp(cur_node_blkoff[i - CURSEG_HOT_NODE]);
+			segno = get_cp(cur_node_segno[i - CURSEG_HOT_NODE]);
 		}
 		array[i].segno = segno;
 		array[i].zone = GET_ZONENO_FROM_SEGNO(sbi, segno);
 		array[i].next_segno = NULL_SEGNO;
 		array[i].next_blkoff = blk_off;
-		array[i].alloc_type = ckpt->alloc_type[i];
+		array[i].alloc_type = cp->alloc_type[i];
 	}
 	restore_curseg_summaries(sbi);
 }
@@ -873,7 +861,7 @@ struct seg_entry *get_seg_entry(struct f2fs_sb_info *sbi,
 struct f2fs_summary_block *get_sum_block(struct f2fs_sb_info *sbi,
 				unsigned int segno, int *ret_type)
 {
-	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
+	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
 	struct f2fs_summary_block *sum_blk;
 	struct curseg_info *curseg;
 	int type, ret;
@@ -883,7 +871,7 @@ struct f2fs_summary_block *get_sum_block(struct f2fs_sb_info *sbi,
 
 	ssa_blk = GET_SUM_BLKADDR(sbi, segno);
 	for (type = 0; type < NR_CURSEG_NODE_TYPE; type++) {
-		if (segno == ckpt->cur_node_segno[type]) {
+		if (segno == get_cp(cur_node_segno[type])) {
 			curseg = CURSEG_I(sbi, CURSEG_HOT_NODE + type);
 			if (!IS_SUM_NODE_SEG(curseg->sum_blk->footer)) {
 				ASSERT_MSG("segno [0x%x] indicates a data "
@@ -898,7 +886,7 @@ struct f2fs_summary_block *get_sum_block(struct f2fs_sb_info *sbi,
 	}
 
 	for (type = 0; type < NR_CURSEG_DATA_TYPE; type++) {
-		if (segno == ckpt->cur_data_segno[type]) {
+		if (segno == get_cp(cur_data_segno[type])) {
 			curseg = CURSEG_I(sbi, type);
 			if (IS_SUM_NODE_SEG(curseg->sum_blk->footer)) {
 				ASSERT_MSG("segno [0x%x] indicates a node "
@@ -1018,8 +1006,8 @@ got_it:
 
 int build_segment_manager(struct f2fs_sb_info *sbi)
 {
-	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
-	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
+	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
+	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
 	struct f2fs_sm_info *sm_info;
 
 	sm_info = malloc(sizeof(struct f2fs_sm_info));
@@ -1028,13 +1016,13 @@ int build_segment_manager(struct f2fs_sb_info *sbi)
 
 	/* init sm info */
 	sbi->sm_info = sm_info;
-	sm_info->seg0_blkaddr = le32_to_cpu(raw_super->segment0_blkaddr);
-	sm_info->main_blkaddr = le32_to_cpu(raw_super->main_blkaddr);
-	sm_info->segment_count = le32_to_cpu(raw_super->segment_count);
-	sm_info->reserved_segments = le32_to_cpu(ckpt->rsvd_segment_count);
-	sm_info->ovp_segments = le32_to_cpu(ckpt->overprov_segment_count);
-	sm_info->main_segments = le32_to_cpu(raw_super->segment_count_main);
-	sm_info->ssa_blkaddr = le32_to_cpu(raw_super->ssa_blkaddr);
+	sm_info->seg0_blkaddr = get_sb(segment0_blkaddr);
+	sm_info->main_blkaddr = get_sb(main_blkaddr);
+	sm_info->segment_count = get_sb(segment_count);
+	sm_info->reserved_segments = get_cp(rsvd_segment_count);
+	sm_info->ovp_segments = get_cp(overprov_segment_count);
+	sm_info->main_segments = get_sb(segment_count_main);
+	sm_info->ssa_blkaddr = get_sb(ssa_blkaddr);
 
 	build_sit_info(sbi);
 
@@ -1213,7 +1201,7 @@ void nullify_nat_entry(struct f2fs_sb_info *sbi, u32 nid)
 void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
-	struct f2fs_super_block *raw_sb = F2FS_RAW_SUPER(sbi);
+	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct f2fs_nat_block *nat_block;
 	u32 nid, nr_nat_blks;
@@ -1227,8 +1215,8 @@ void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
 	ASSERT(nat_block);
 
 	/* Alloc & build nat entry bitmap */
-	nr_nat_blks = (le32_to_cpu(raw_sb->segment_count_nat) / 2) <<
-						sbi->log_blocks_per_seg;
+	nr_nat_blks = (get_sb(segment_count_nat) / 2) <<
+					sbi->log_blocks_per_seg;
 
 	fsck->nr_nat_entries = nr_nat_blks * NAT_ENTRY_PER_BLOCK;
 	fsck->nat_area_bitmap_sz = (fsck->nr_nat_entries + 7) / 8;
@@ -1293,6 +1281,7 @@ void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
 
 int f2fs_do_mount(struct f2fs_sb_info *sbi)
 {
+	struct f2fs_checkpoint *cp = NULL;
 	int ret;
 
 	sbi->active_logs = NR_CURSEG_TYPE;
@@ -1321,7 +1310,7 @@ int f2fs_do_mount(struct f2fs_sb_info *sbi)
 	print_ckpt_info(sbi);
 
 	if (config.auto_fix) {
-		u32 flag = le32_to_cpu(sbi->ckpt->ckpt_flags);
+		u32 flag = get_cp(ckpt_flags);
 
 		if (flag & CP_FSCK_FLAG)
 			config.fix_on = 1;
@@ -1331,12 +1320,11 @@ int f2fs_do_mount(struct f2fs_sb_info *sbi)
 
 	config.bug_on = 0;
 
-	sbi->total_valid_node_count = le32_to_cpu(sbi->ckpt->valid_node_count);
-	sbi->total_valid_inode_count =
-			le32_to_cpu(sbi->ckpt->valid_inode_count);
-	sbi->user_block_count = le64_to_cpu(sbi->ckpt->user_block_count);
-	sbi->total_valid_block_count =
-			le64_to_cpu(sbi->ckpt->valid_block_count);
+	cp = F2FS_CKPT(sbi);
+	sbi->total_valid_node_count = get_cp(valid_node_count);
+	sbi->total_valid_inode_count = get_cp(valid_inode_count);
+	sbi->user_block_count = get_cp(user_block_count);
+	sbi->total_valid_block_count = get_cp(valid_block_count);
 	sbi->last_valid_block_count = sbi->total_valid_block_count;
 	sbi->alloc_valid_block_count = 0;
 
-- 
2.4.9 (Apple Git-60)


------------------------------------------------------------------------------
Go from Idea to Many App Stores Faster with Intel(R) XDK
Give your users amazing mobile app experiences with Intel(R) XDK.
Use one codebase in this all-in-one HTML5 development environment.
Design, debug & build mobile apps & 2D/3D high-impact games for multiple OSs.
http://pubads.g.doubleclick.net/gampad/clk?id=254741911&iu=/4140
