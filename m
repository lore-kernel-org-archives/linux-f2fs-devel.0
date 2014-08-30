From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 15/17] fsck.f2fs: fix checkpoint
Date: Fri, 29 Aug 2014 17:29:02 -0700
Message-ID: <1409358544-54740-15-git-send-email-jaegeuk@kernel.org>
References: <1409358544-54740-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XNWYP-0005Tl-QW
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Aug 2014 00:30:05 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XNWYO-00026J-K1 for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Aug 2014 00:30:05 +0000
In-Reply-To: <1409358544-54740-1-git-send-email-jaegeuk@kernel.org>
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

- fix nat entries
- fix sit entries
- fix checkpoint

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/f2fs.h  |   1 +
 fsck/fsck.c  |  84 ++++++++++++++++++++++++++++++++++
 fsck/fsck.h  |   3 ++
 fsck/mount.c | 144 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 227 insertions(+), 5 deletions(-)

diff --git a/fsck/f2fs.h b/fsck/f2fs.h
index 2adffd8..8c31981 100644
--- a/fsck/f2fs.h
+++ b/fsck/f2fs.h
@@ -126,6 +126,7 @@ struct f2fs_sb_info {
 	struct f2fs_nm_info *nm_info;
 	struct f2fs_sm_info *sm_info;
 	struct f2fs_checkpoint *ckpt;
+	int cur_cp;
 
 	struct list_head orphan_inode_list;
 	unsigned int n_orphans;
diff --git a/fsck/fsck.c b/fsck/fsck.c
index 0a76c19..8df489d 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -785,6 +785,64 @@ void fsck_init(struct f2fs_sb_info *sbi)
 	ASSERT(tree_mark != NULL);
 }
 
+static void fix_nat_entries(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
+	int i;
+
+	for (i = 0; i < fsck->nr_nat_entries; i++)
+		if (f2fs_test_bit(i, fsck->nat_area_bitmap) != 0)
+			nullify_nat_entry(sbi, i);
+}
+
+static void fix_checkpoint(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
+	struct f2fs_super_block *raw_sb = sbi->raw_super;
+	struct f2fs_checkpoint *ckp = F2FS_CKPT(sbi);
+	unsigned long long cp_blk_no;
+	int i, ret;
+	u_int32_t crc = 0;
+
+	ckp->ckpt_flags = cpu_to_le32(CP_UMOUNT_FLAG);
+	ckp->cp_pack_total_block_count =
+		cpu_to_le32(8 + le32_to_cpu(raw_sb->cp_payload));
+	ckp->cp_pack_start_sum = cpu_to_le32(1 +
+				le32_to_cpu(raw_sb->cp_payload));
+
+	ckp->free_segment_count = cpu_to_le32(fsck->chk.free_segs);
+	ckp->valid_block_count = cpu_to_le32(fsck->chk.valid_blk_cnt);
+	ckp->valid_node_count = cpu_to_le32(fsck->chk.valid_node_cnt);
+	ckp->valid_inode_count = cpu_to_le32(fsck->chk.valid_inode_cnt);
+
+	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, ckp, CHECKSUM_OFFSET);
+	*((__le32 *)((unsigned char *)ckp + CHECKSUM_OFFSET)) =
+							cpu_to_le32(crc);
+
+	cp_blk_no = le32_to_cpu(raw_sb->cp_blkaddr);
+	if (sbi->cur_cp == 2)
+		cp_blk_no += 1 << le32_to_cpu(raw_sb->log_blocks_per_seg);
+
+	ret = dev_write_block(ckp, cp_blk_no++);
+	ASSERT(ret >= 0);
+
+	for (i = 0; i < le32_to_cpu(raw_sb->cp_payload); i++) {
+		ret = dev_write_block(((unsigned char *)ckp) + i * F2FS_BLKSIZE,
+								cp_blk_no++);
+		ASSERT(ret >= 0);
+	}
+
+	for (i = 0; i < NO_CHECK_TYPE; i++) {
+		struct curseg_info *curseg = CURSEG_I(sbi, i);
+
+		ret = dev_write_block(curseg->sum_blk, cp_blk_no++);
+		ASSERT(ret >= 0);
+	}
+
+	ret = dev_write_block(ckp, cp_blk_no++);
+	ASSERT(ret >= 0);
+}
+
 int fsck_verify(struct f2fs_sb_info *sbi)
 {
 	unsigned int i = 0;
@@ -875,6 +933,32 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 		ret = EXIT_ERR_CODE;
 		config.bug_on = 1;
 	}
+
+	printf("[FSCK] free segment_count matched with CP            ");
+	if (le32_to_cpu(F2FS_CKPT(sbi)->free_segment_count) ==
+						fsck->chk.sit_free_segs) {
+		printf(" [Ok..] [0x%x]\n", fsck->chk.sit_free_segs);
+	} else {
+		printf(" [Fail] [0x%x]\n", fsck->chk.sit_free_segs);
+		ret = EXIT_ERR_CODE;
+		config.bug_on = 1;
+	}
+
+	printf("[FSCK] other corrupted bugs                          ");
+	if (config.bug_on == 0) {
+		printf(" [Ok..]\n");
+	} else {
+		printf(" [Fail]\n");
+		ret = EXIT_ERR_CODE;
+		config.bug_on = 1;
+	}
+
+	/* fix global metadata */
+	if (config.bug_on && config.fix_cnt) {
+		fix_nat_entries(sbi);
+		rewrite_sit_area_bitmap(sbi);
+		fix_checkpoint(sbi);
+	}
 	return ret;
 }
 
diff --git a/fsck/fsck.h b/fsck/fsck.h
index 85cc931..64b9984 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -31,6 +31,7 @@ struct f2fs_fsck {
 		u32 multi_hard_link_files;
 		u64 sit_valid_blocks;
 		u32 sit_free_segs;
+		u32 free_segs;
 	} chk;
 
 	struct hard_link_node *hard_link_list_head;
@@ -100,6 +101,8 @@ extern int get_sum_block(struct f2fs_sb_info *, unsigned int,
 				struct f2fs_summary_block *);
 extern int get_sum_entry(struct f2fs_sb_info *, u32, struct f2fs_summary *);
 extern void get_node_info(struct f2fs_sb_info *, nid_t, struct node_info *);
+extern void nullify_nat_entry(struct f2fs_sb_info *, u32);
+extern void rewrite_sit_area_bitmap(struct f2fs_sb_info *);
 extern void build_nat_area_bitmap(struct f2fs_sb_info *);
 extern void build_sit_area_bitmap(struct f2fs_sb_info *);
 extern void fsck_init(struct f2fs_sb_info *);
diff --git a/fsck/mount.c b/fsck/mount.c
index fb5b261..a41320f 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -326,6 +326,7 @@ int get_valid_checkpoint(struct f2fs_sb_info *sbi)
 	unsigned long long cp1_version = 0, cp2_version = 0;
 	unsigned long long cp_start_blk_no;
 	unsigned int cp_blks = 1 + le32_to_cpu(F2FS_RAW_SUPER(sbi)->cp_payload);
+	int ret;
 
 	sbi->ckpt = malloc(cp_blks * blk_size);
 	if (!sbi->ckpt)
@@ -342,14 +343,19 @@ int get_valid_checkpoint(struct f2fs_sb_info *sbi)
 	cp2 = validate_checkpoint(sbi, cp_start_blk_no, &cp2_version);
 
 	if (cp1 && cp2) {
-		if (ver_after(cp2_version, cp1_version))
+		if (ver_after(cp2_version, cp1_version)) {
 			cur_page = cp2;
-		else
+			sbi->cur_cp = 2;
+		} else {
 			cur_page = cp1;
+			sbi->cur_cp = 1;
+		}
 	} else if (cp1) {
 		cur_page = cp1;
+		sbi->cur_cp = 1;
 	} else if (cp2) {
 		cur_page = cp2;
+		sbi->cur_cp = 2;
 	} else {
 		free(cp1);
 		free(cp2);
@@ -369,7 +375,8 @@ int get_valid_checkpoint(struct f2fs_sb_info *sbi)
 		/* copy sit bitmap */
 		for (i = 1; i < cp_blks; i++) {
 			unsigned char *ckpt = (unsigned char *)sbi->ckpt;
-			dev_read_block(cur_page, cp_blk_no + i);
+			ret = dev_read_block(cur_page, cp_blk_no + i);
+			ASSERT(ret >= 0);
 			memcpy(ckpt + i * blk_size, cur_page, blk_size);
 		}
 	}
@@ -496,6 +503,7 @@ void reset_curseg(struct f2fs_sb_info *sbi, int type)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
 	struct summary_footer *sum_footer;
+	struct seg_entry *se;
 
 	curseg->segno = curseg->next_segno;
 	curseg->zone = GET_ZONENO_FROM_SEGNO(sbi, curseg->segno);
@@ -508,6 +516,8 @@ void reset_curseg(struct f2fs_sb_info *sbi, int type)
 		SET_SUM_TYPE(sum_footer, SUM_TYPE_DATA);
 	if (IS_NODESEG(type))
 		SET_SUM_TYPE(sum_footer, SUM_TYPE_NODE);
+	se = get_seg_entry(sbi, curseg->segno);
+	se->type = type;
 }
 
 static void read_compacted_summaries(struct f2fs_sb_info *sbi)
@@ -676,13 +686,14 @@ inline void check_seg_range(struct f2fs_sb_info *sbi, unsigned int segno)
 	ASSERT(segno <= end_segno);
 }
 
-struct f2fs_sit_block *get_current_sit_page(struct f2fs_sb_info *sbi,
+static struct f2fs_sit_block *get_current_sit_page(struct f2fs_sb_info *sbi,
 						unsigned int segno)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
 	unsigned int offset = SIT_BLOCK_OFFSET(sit_i, segno);
 	block_t blk_addr = sit_i->sit_base_addr + offset;
 	struct f2fs_sit_block *sit_blk = calloc(BLOCK_SZ, 1);
+	int ret;
 
 	check_seg_range(sbi, segno);
 
@@ -690,11 +701,28 @@ struct f2fs_sit_block *get_current_sit_page(struct f2fs_sb_info *sbi,
 	if (f2fs_test_bit(offset, sit_i->sit_bitmap))
 		blk_addr += sit_i->sit_blocks;
 
-	dev_read_block(sit_blk, blk_addr);
+	ret = dev_read_block(sit_blk, blk_addr);
+	ASSERT(ret >= 0);
 
 	return sit_blk;
 }
 
+void rewrite_current_sit_page(struct f2fs_sb_info *sbi,
+			unsigned int segno, struct f2fs_sit_block *sit_blk)
+{
+	struct sit_info *sit_i = SIT_I(sbi);
+	unsigned int offset = SIT_BLOCK_OFFSET(sit_i, segno);
+	block_t blk_addr = sit_i->sit_base_addr + offset;
+	int ret;
+
+	/* calculate sit block address */
+	if (f2fs_test_bit(offset, sit_i->sit_bitmap))
+		blk_addr += sit_i->sit_blocks;
+
+	ret = dev_write_block(sit_blk, blk_addr);
+	ASSERT(ret >= 0);
+}
+
 void check_block_count(struct f2fs_sb_info *sbi,
 		unsigned int segno, struct f2fs_sit_entry *raw_sit)
 {
@@ -719,6 +747,10 @@ void check_block_count(struct f2fs_sb_info *sbi,
 	if (GET_SIT_VBLOCKS(raw_sit) != valid_blocks)
 		ASSERT_MSG("Wrong SIT valid blocks: segno=0x%x, %u vs. %u",
 				segno, GET_SIT_VBLOCKS(raw_sit), valid_blocks);
+
+	if (GET_SIT_TYPE(raw_sit) >= NO_CHECK_TYPE)
+		ASSERT_MSG("Wrong SIT type: segno=0x%x, %u",
+				segno, GET_SIT_TYPE(raw_sit));
 }
 
 void seg_info_from_raw_sit(struct seg_entry *se,
@@ -952,6 +984,62 @@ void build_sit_area_bitmap(struct f2fs_sb_info *sbi)
 			free_segs, free_segs);
 }
 
+void rewrite_sit_area_bitmap(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
+	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_COLD_DATA);
+	struct sit_info *sit_i = SIT_I(sbi);
+	unsigned int segno = 0;
+	struct f2fs_summary_block *sum = curseg->sum_blk;
+	char *ptr = NULL;
+
+	/* remove sit journal */
+	sum->n_sits = 0;
+
+	fsck->chk.free_segs = 0;
+
+	ptr = fsck->main_area_bitmap;
+
+	for (segno = 0; segno < TOTAL_SEGS(sbi); segno++) {
+		struct f2fs_sit_block *sit_blk;
+		struct f2fs_sit_entry *sit;
+		struct seg_entry *se;
+		u16 valid_blocks = 0;
+		u16 type;
+		int i;
+
+		sit_blk = get_current_sit_page(sbi, segno);
+		sit = &sit_blk->entries[SIT_ENTRY_OFFSET(sit_i, segno)];
+		memcpy(sit->valid_map, ptr, SIT_VBLOCK_MAP_SIZE);
+
+		/* update valid block count */
+		for (i = 0; i < SIT_VBLOCK_MAP_SIZE; i++)
+			valid_blocks += get_bits_in_byte(sit->valid_map[i]);
+
+		se = get_seg_entry(sbi, segno);
+		type = se->type;
+		if (type >= NO_CHECK_TYPE) {
+			ASSERT(valid_blocks);
+			type = 0;
+		}
+		sit->vblocks = cpu_to_le16((type << SIT_VBLOCKS_SHIFT) |
+								valid_blocks);
+		rewrite_current_sit_page(sbi, segno, sit_blk);
+		free(sit_blk);
+
+		if (valid_blocks == 0 &&
+				sbi->ckpt->cur_node_segno[0] != segno &&
+				sbi->ckpt->cur_data_segno[0] != segno &&
+				sbi->ckpt->cur_node_segno[1] != segno &&
+				sbi->ckpt->cur_data_segno[1] != segno &&
+				sbi->ckpt->cur_node_segno[2] != segno &&
+				sbi->ckpt->cur_data_segno[2] != segno)
+			fsck->chk.free_segs++;
+
+		ptr += SIT_VBLOCK_MAP_SIZE;
+	}
+}
+
 int lookup_nat_in_journal(struct f2fs_sb_info *sbi, u32 nid,
 					struct f2fs_nat_entry *raw_nat)
 {
@@ -970,6 +1058,51 @@ int lookup_nat_in_journal(struct f2fs_sb_info *sbi, u32 nid,
 	return -1;
 }
 
+void nullify_nat_entry(struct f2fs_sb_info *sbi, u32 nid)
+{
+	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
+	struct f2fs_summary_block *sum = curseg->sum_blk;
+	struct f2fs_nm_info *nm_i = NM_I(sbi);
+	struct f2fs_nat_block *nat_block;
+	pgoff_t block_off;
+	pgoff_t block_addr;
+	int seg_off, entry_off;
+	int ret;
+	int i = 0;
+
+	/* check in journal */
+	for (i = 0; i < nats_in_cursum(sum); i++) {
+		if (le32_to_cpu(nid_in_journal(sum, i)) == nid) {
+			memset(&nat_in_journal(sum, i), 0,
+					sizeof(struct f2fs_nat_entry));
+			FIX_MSG("Remove nid [0x%x] in nat journal\n", nid);
+			return;
+		}
+	}
+	nat_block = (struct f2fs_nat_block *)calloc(BLOCK_SZ, 1);
+
+	block_off = nid / NAT_ENTRY_PER_BLOCK;
+	entry_off = nid % NAT_ENTRY_PER_BLOCK;
+
+	seg_off = block_off >> sbi->log_blocks_per_seg;
+	block_addr = (pgoff_t)(nm_i->nat_blkaddr +
+			(seg_off << sbi->log_blocks_per_seg << 1) +
+			(block_off & ((1 << sbi->log_blocks_per_seg) - 1)));
+
+	if (f2fs_test_bit(block_off, nm_i->nat_bitmap))
+		block_addr += sbi->blocks_per_seg;
+
+	ret = dev_read_block(nat_block, block_addr);
+	ASSERT(ret >= 0);
+
+	memset(&nat_block->entries[entry_off], 0,
+					sizeof(struct f2fs_nat_entry));
+
+	ret = dev_write_block(nat_block, block_addr);
+	ASSERT(ret >= 0);
+	free(nat_block);
+}
+
 void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
@@ -984,6 +1117,7 @@ void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
 	unsigned int i;
 
 	nat_block = (struct f2fs_nat_block *)calloc(BLOCK_SZ, 1);
+	ASSERT(nat_block);
 
 	/* Alloc & build nat entry bitmap */
 	nr_nat_blks = (le32_to_cpu(raw_sb->segment_count_nat) / 2) <<
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
