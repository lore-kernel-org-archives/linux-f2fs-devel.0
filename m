From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 07/17] fsck.f2fs: cleanup mount.c
Date: Fri, 29 Aug 2014 17:28:54 -0700
Message-ID: <1409358544-54740-7-git-send-email-jaegeuk@kernel.org>
References: <1409358544-54740-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XNWY6-0005RG-Fh
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Aug 2014 00:29:46 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XNWY5-0001ku-7k for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Aug 2014 00:29:46 +0000
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

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/mount.c | 116 +++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 70 insertions(+), 46 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index a766157..b0dd5c7 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -53,7 +53,7 @@ void print_inode_info(struct f2fs_inode *inode)
 
 	for (i = 4; i < ADDRS_PER_INODE(inode); i++) {
 		if (inode->i_addr[i] != 0x0) {
-			printf("i_addr[0x%x] points data block\r\t\t\t\t[0x%4x]\n",
+			printf("i_addr[0x%x] points data block\r\t\t[0x%4x]\n",
 					i, inode->i_addr[i]);
 			break;
 		}
@@ -79,9 +79,11 @@ void print_node_info(struct f2fs_node *node_block)
 	} else {
 		int i;
 		u32 *dump_blk = (u32 *)node_block;
-		DBG(0, "Node ID [0x%x:%u] is direct node or indirect node.\n", nid, nid);
+		DBG(0, "Node ID [0x%x:%u] is direct node or indirect node.\n",
+								nid, nid);
 		for (i = 0; i <= 10; i++)
-			MSG(0, "[%d]\t\t\t[0x%8x : %d]\n", i, dump_blk[i], dump_blk[i]);
+			MSG(0, "[%d]\t\t\t[0x%8x : %d]\n",
+						i, dump_blk[i], dump_blk[i]);
 	}
 }
 
@@ -211,7 +213,8 @@ int sanity_check_raw_super(struct f2fs_super_block *raw_super)
 		return -1;
 	}
 
-	if (F2FS_LOG_SECTORS_PER_BLOCK != le32_to_cpu(raw_super->log_sectors_per_block)) {
+	if (F2FS_LOG_SECTORS_PER_BLOCK !=
+				le32_to_cpu(raw_super->log_sectors_per_block)) {
 		return -1;
 	}
 
@@ -230,7 +233,7 @@ int validate_super_block(struct f2fs_sb_info *sbi, int block)
 		return 0;
 
 	free(sbi->raw_super);
-	MSG(0, "\tCan't find a valid F2FS filesystem in %d superblock\n", block);
+	MSG(0, "\tCan't find a valid F2FS superblock at 0x%x\n", block);
 
 	return -EINVAL;
 }
@@ -258,7 +261,8 @@ int init_sb_info(struct f2fs_sb_info *sbi)
 	return 0;
 }
 
-void *validate_checkpoint(struct f2fs_sb_info *sbi, block_t cp_addr, unsigned long long *version)
+void *validate_checkpoint(struct f2fs_sb_info *sbi, block_t cp_addr,
+				unsigned long long *version)
 {
 	void *cp_page_1, *cp_page_2;
 	struct f2fs_checkpoint *cp_block;
@@ -360,7 +364,8 @@ int get_valid_checkpoint(struct f2fs_sb_info *sbi)
 
 		cp_blk_no = le32_to_cpu(raw_sb->cp_blkaddr);
 		if (cur_page == cp2)
-			cp_blk_no += 1 << le32_to_cpu(raw_sb->log_blocks_per_seg);
+			cp_blk_no += 1 <<
+				le32_to_cpu(raw_sb->log_blocks_per_seg);
 		/* copy sit bitmap */
 		for (i = 1; i < cp_blks; i++) {
 			unsigned char *ckpt = (unsigned char *)sbi->ckpt;
@@ -515,7 +520,8 @@ int read_compacted_summaries(struct f2fs_sb_info *sbi)
 	memcpy(&curseg->sum_blk->n_nats, kaddr, SUM_JOURNAL_SIZE);
 
 	curseg = CURSEG_I(sbi, CURSEG_COLD_DATA);
-	memcpy(&curseg->sum_blk->n_sits, kaddr + SUM_JOURNAL_SIZE, SUM_JOURNAL_SIZE);
+	memcpy(&curseg->sum_blk->n_sits, kaddr + SUM_JOURNAL_SIZE,
+						SUM_JOURNAL_SIZE);
 
 	offset = 2 * SUM_JOURNAL_SIZE;
 	for (i = CURSEG_HOT_DATA; i <= CURSEG_COLD_DATA; i++) {
@@ -538,7 +544,8 @@ int read_compacted_summaries(struct f2fs_sb_info *sbi)
 			s = (struct f2fs_summary *)(kaddr + offset);
 			curseg->sum_blk->entries[j] = *s;
 			offset += SUMMARY_SIZE;
-			if (offset + SUMMARY_SIZE <= PAGE_CACHE_SIZE - SUM_FOOTER_SIZE)
+			if (offset + SUMMARY_SIZE <=
+					PAGE_CACHE_SIZE - SUM_FOOTER_SIZE)
 				continue;
 			memset(kaddr, 0, PAGE_SIZE);
 			dev_read_block(kaddr, start++);
@@ -597,18 +604,22 @@ int read_normal_summaries(struct f2fs_sb_info *sbi, int type)
 
 	if (IS_DATASEG(type)) {
 		segno = le32_to_cpu(ckpt->cur_data_segno[type]);
-		blk_off = le16_to_cpu(ckpt->cur_data_blkoff[type - CURSEG_HOT_DATA]);
+		blk_off = le16_to_cpu(ckpt->cur_data_blkoff[type -
+							CURSEG_HOT_DATA]);
 
 		if (is_set_ckpt_flags(ckpt, CP_UMOUNT_FLAG))
 			blk_addr = sum_blk_addr(sbi, NR_CURSEG_TYPE, type);
 		else
 			blk_addr = sum_blk_addr(sbi, NR_CURSEG_DATA_TYPE, type);
 	} else {
-		segno = le32_to_cpu(ckpt->cur_node_segno[type - CURSEG_HOT_NODE]);
-		blk_off = le16_to_cpu(ckpt->cur_node_blkoff[type - CURSEG_HOT_NODE]);
+		segno = le32_to_cpu(ckpt->cur_node_segno[type -
+							CURSEG_HOT_NODE]);
+		blk_off = le16_to_cpu(ckpt->cur_node_blkoff[type -
+							CURSEG_HOT_NODE]);
 
 		if (is_set_ckpt_flags(ckpt, CP_UMOUNT_FLAG))
-			blk_addr = sum_blk_addr(sbi, NR_CURSEG_NODE_TYPE, type - CURSEG_HOT_NODE);
+			blk_addr = sum_blk_addr(sbi, NR_CURSEG_NODE_TYPE,
+							type - CURSEG_HOT_NODE);
 		else
 			blk_addr = GET_SUM_BLKADDR(sbi, segno);
 	}
@@ -688,7 +699,8 @@ inline void check_seg_range(struct f2fs_sb_info *sbi, unsigned int segno)
 	ASSERT(segno <= end_segno);
 }
 
-struct f2fs_sit_block *get_current_sit_page(struct f2fs_sb_info *sbi, unsigned int segno)
+struct f2fs_sit_block *get_current_sit_page(struct f2fs_sb_info *sbi,
+						unsigned int segno)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
 	unsigned int offset = SIT_BLOCK_OFFSET(sit_i, segno);
@@ -746,7 +758,8 @@ struct seg_entry *get_seg_entry(struct f2fs_sb_info *sbi,
 	return &sit_i->sentries[segno];
 }
 
-int get_sum_block(struct f2fs_sb_info *sbi, unsigned int segno, struct f2fs_summary_block *sum_blk)
+int get_sum_block(struct f2fs_sb_info *sbi, unsigned int segno,
+				struct f2fs_summary_block *sum_blk)
 {
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
 	struct curseg_info *curseg;
@@ -758,7 +771,8 @@ int get_sum_block(struct f2fs_sb_info *sbi, unsigned int segno, struct f2fs_summ
 		if (segno == ckpt->cur_node_segno[type]) {
 			curseg = CURSEG_I(sbi, CURSEG_HOT_NODE + type);
 			memcpy(sum_blk, curseg->sum_blk, BLOCK_SZ);
-			return SEG_TYPE_CUR_NODE; /* current node seg was not stored */
+			/* current node seg was not stored */
+			return SEG_TYPE_CUR_NODE;
 		}
 	}
 
@@ -767,8 +781,10 @@ int get_sum_block(struct f2fs_sb_info *sbi, unsigned int segno, struct f2fs_summ
 			curseg = CURSEG_I(sbi, type);
 			memcpy(sum_blk, curseg->sum_blk, BLOCK_SZ);
 			ASSERT(!IS_SUM_NODE_SEG(sum_blk->footer));
-			DBG(2, "segno [0x%x] is current data seg[0x%x]\n", segno, type);
-			return SEG_TYPE_CUR_DATA; /* current data seg was not stored */
+			DBG(2, "segno [0x%x] is current data seg[0x%x]\n",
+								segno, type);
+			/* current data seg was not stored */
+			return SEG_TYPE_CUR_DATA;
 		}
 	}
 
@@ -782,7 +798,8 @@ int get_sum_block(struct f2fs_sb_info *sbi, unsigned int segno, struct f2fs_summ
 
 }
 
-int get_sum_entry(struct f2fs_sb_info *sbi, u32 blk_addr, struct f2fs_summary *sum_entry)
+int get_sum_entry(struct f2fs_sb_info *sbi, u32 blk_addr,
+				struct f2fs_summary *sum_entry)
 {
 	struct f2fs_summary_block *sum_blk;
 	u32 segno, offset;
@@ -795,8 +812,8 @@ int get_sum_entry(struct f2fs_sb_info *sbi, u32 blk_addr, struct f2fs_summary *s
 
 	ret = get_sum_block(sbi, segno, sum_blk);
 
-	memcpy(sum_entry, &(sum_blk->entries[offset]), sizeof(struct f2fs_summary));
-
+	memcpy(sum_entry, &(sum_blk->entries[offset]),
+				sizeof(struct f2fs_summary));
 	free(sum_blk);
 	return ret;
 }
@@ -955,12 +972,14 @@ int build_sit_area_bitmap(struct f2fs_sb_info *sbi)
 	fsck->chk.sit_valid_blocks = sum_vblocks;
 	fsck->chk.sit_free_segs = free_segs;
 
-	DBG(1, "Blocks [0x%x : %d] Free Segs [0x%x : %d]\n\n", sum_vblocks, sum_vblocks,
+	DBG(1, "Blocks [0x%x : %d] Free Segs [0x%x : %d]\n\n",
+			sum_vblocks, sum_vblocks,
 			free_segs, free_segs);
 	return 0;
 }
 
-int lookup_nat_in_journal(struct f2fs_sb_info *sbi, u32 nid, struct f2fs_nat_entry *raw_nat)
+int lookup_nat_in_journal(struct f2fs_sb_info *sbi, u32 nid,
+					struct f2fs_nat_entry *raw_nat)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
 	struct f2fs_summary_block *sum = curseg->sum_blk;
@@ -968,7 +987,8 @@ int lookup_nat_in_journal(struct f2fs_sb_info *sbi, u32 nid, struct f2fs_nat_ent
 
 	for (i = 0; i < nats_in_cursum(sum); i++) {
 		if (le32_to_cpu(nid_in_journal(sum, i)) == nid) {
-			memcpy(raw_nat, &nat_in_journal(sum, i), sizeof(struct f2fs_nat_entry));
+			memcpy(raw_nat, &nat_in_journal(sum, i),
+						sizeof(struct f2fs_nat_entry));
 			DBG(3, "==> Found nid [0x%x] in nat cache\n", nid);
 			return i;
 		}
@@ -994,7 +1014,8 @@ void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
 	nat_block = (struct f2fs_nat_block *)calloc(BLOCK_SZ, 1);
 
 	/* Alloc & build nat entry bitmap */
-	nr_nat_blks = (le32_to_cpu(raw_sb->segment_count_nat) / 2) << sbi->log_blocks_per_seg;
+	nr_nat_blks = (le32_to_cpu(raw_sb->segment_count_nat) / 2) <<
+						sbi->log_blocks_per_seg;
 
 	fsck->nr_nat_entries = nr_nat_blks * NAT_ENTRY_PER_BLOCK;
 	fsck->nat_area_bitmap_sz = (fsck->nr_nat_entries + 7) / 8;
@@ -1005,8 +1026,8 @@ void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
 
 		seg_off = block_off >> sbi->log_blocks_per_seg;
 		block_addr = (pgoff_t)(nm_i->nat_blkaddr +
-				(seg_off << sbi->log_blocks_per_seg << 1) +
-				(block_off & ((1 << sbi->log_blocks_per_seg) - 1)));
+			(seg_off << sbi->log_blocks_per_seg << 1) +
+			(block_off & ((1 << sbi->log_blocks_per_seg) - 1)));
 
 		if (f2fs_test_bit(block_off, nm_i->nat_bitmap))
 			block_addr += sbi->blocks_per_seg;
@@ -1026,34 +1047,35 @@ void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
 				continue;
 			}
 
-			if (lookup_nat_in_journal(sbi, nid + i, &raw_nat) >= 0) {
+			if (lookup_nat_in_journal(sbi, nid + i,
+							&raw_nat) >= 0) {
 				node_info_from_raw_nat(&ni, &raw_nat);
 				if (ni.blk_addr != 0x0) {
-					f2fs_set_bit(nid + i, fsck->nat_area_bitmap);
+					f2fs_set_bit(nid + i,
+							fsck->nat_area_bitmap);
 					fsck->chk.valid_nat_entry_cnt++;
-					DBG(3, "nid[0x%x] in nat cache\n", nid + i);
+					DBG(3, "nid[0x%x] in nat cache\n",
+								nid + i);
 				}
 			} else {
-				node_info_from_raw_nat(&ni, &nat_block->entries[i]);
-				if (ni.blk_addr != 0) {
-					ASSERT(nid + i != 0x0);
-
-					DBG(3, "nid[0x%8x] in nat entry [0x%16x] [0x%8x]\n",
-							nid + i,
-							ni.blk_addr,
-							ni.ino);
-
-					f2fs_set_bit(nid + i, fsck->nat_area_bitmap);
-					fsck->chk.valid_nat_entry_cnt++;
-				}
+				node_info_from_raw_nat(&ni,
+						&nat_block->entries[i]);
+				if (ni.blk_addr == 0)
+					continue;
+				ASSERT(nid + i != 0x0);
+
+				DBG(3, "nid[0x%8x] addr[0x%16x] ino[0x%8x]\n",
+					nid + i, ni.blk_addr, ni.ino);
+				f2fs_set_bit(nid + i, fsck->nat_area_bitmap);
+				fsck->chk.valid_nat_entry_cnt++;
 			}
 		}
 	}
 	free(nat_block);
 
 	DBG(1, "valid nat entries (block_addr != 0x0) [0x%8x : %u]\n",
-			fsck->chk.valid_nat_entry_cnt, fsck->chk.valid_nat_entry_cnt);
-
+			fsck->chk.valid_nat_entry_cnt,
+			fsck->chk.valid_nat_entry_cnt);
 }
 
 int f2fs_do_mount(struct f2fs_sb_info *sbi)
@@ -1085,9 +1107,11 @@ int f2fs_do_mount(struct f2fs_sb_info *sbi)
 	print_ckpt_info(sbi);
 
 	sbi->total_valid_node_count = le32_to_cpu(sbi->ckpt->valid_node_count);
-	sbi->total_valid_inode_count = le32_to_cpu(sbi->ckpt->valid_inode_count);
+	sbi->total_valid_inode_count =
+			le32_to_cpu(sbi->ckpt->valid_inode_count);
 	sbi->user_block_count = le64_to_cpu(sbi->ckpt->user_block_count);
-	sbi->total_valid_block_count = le64_to_cpu(sbi->ckpt->valid_block_count);
+	sbi->total_valid_block_count =
+			le64_to_cpu(sbi->ckpt->valid_block_count);
 	sbi->last_valid_block_count = sbi->total_valid_block_count;
 	sbi->alloc_valid_block_count = 0;
 
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
