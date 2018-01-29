From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] fsck.f2fs: reduce mem alloc during read sit block
Date: Mon, 29 Jan 2018 11:22:14 +0800
Message-ID: <1517196134-30520-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <heyunlei@huawei.com>) id 1eg0Fi-0002hZ-63
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 29 Jan 2018 03:37:02 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eg0Fg-0002Ab-Jl
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 29 Jan 2018 03:37:02 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net
Cc: ning.jia@huawei.com, heyunlei@huawei.com

This patch reduce mem alloc during read sit block

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fsck/fsck.c  |  9 ++++++---
 fsck/fsck.h  |  4 ++--
 fsck/mount.c | 45 ++++++++++++++++++++++++++-------------------
 3 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 6c1b9a7..d5c18d3 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -1895,25 +1895,28 @@ static void fix_nat_entries(struct f2fs_sb_info *sbi)
 static void flush_curseg_sit_entries(struct f2fs_sb_info *sbi)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
+	struct f2fs_sit_block *sit_blk;
 	int i;
 
+	sit_blk = calloc(BLOCK_SZ, 1);
+	ASSERT(sit_blk);
 	/* update curseg sit entries, since we may change
 	 * a segment type in move_curseg_info
 	 */
 	for (i = 0; i < NO_CHECK_TYPE; i++) {
 		struct curseg_info *curseg = CURSEG_I(sbi, i);
-		struct f2fs_sit_block *sit_blk;
 		struct f2fs_sit_entry *sit;
 		struct seg_entry *se;
 
 		se = get_seg_entry(sbi, curseg->segno);
-		sit_blk = get_current_sit_page(sbi, curseg->segno);
+		get_current_sit_page(sbi, curseg->segno, sit_blk);
 		sit = &sit_blk->entries[SIT_ENTRY_OFFSET(sit_i, curseg->segno)];
 		sit->vblocks = cpu_to_le16((se->type << SIT_VBLOCKS_SHIFT) |
 							se->valid_blocks);
 		rewrite_current_sit_page(sbi, curseg->segno, sit_blk);
-		free(sit_blk);
 	}
+
+	free(sit_blk);
 }
 
 static void fix_checkpoint(struct f2fs_sb_info *sbi)
diff --git a/fsck/fsck.h b/fsck/fsck.h
index d635c5a..648c2db 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -182,8 +182,8 @@ extern void update_nat_blkaddr(struct f2fs_sb_info *, nid_t, nid_t, block_t);
 extern void print_raw_sb_info(struct f2fs_super_block *);
 
 extern u32 get_free_segments(struct f2fs_sb_info *);
-extern struct f2fs_sit_block *get_current_sit_page(struct f2fs_sb_info *,
-			unsigned int);
+extern void get_current_sit_page(struct f2fs_sb_info *,
+			unsigned int, struct f2fs_sit_block *);
 extern void rewrite_current_sit_page(struct f2fs_sb_info *, unsigned int,
 			struct f2fs_sit_block *);
 
diff --git a/fsck/mount.c b/fsck/mount.c
index fe0d510..247bc96 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1324,17 +1324,14 @@ static inline void check_seg_range(struct f2fs_sb_info *sbi, unsigned int segno)
 	ASSERT(segno <= end_segno);
 }
 
-struct f2fs_sit_block *get_current_sit_page(struct f2fs_sb_info *sbi,
-						unsigned int segno)
+void get_current_sit_page(struct f2fs_sb_info *sbi,
+			unsigned int segno, struct f2fs_sit_block *sit_blk)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
 	unsigned int offset = SIT_BLOCK_OFFSET(sit_i, segno);
 	block_t blk_addr = sit_i->sit_base_addr + offset;
-	struct f2fs_sit_block *sit_blk;
 	int ret;
 
-	sit_blk = calloc(BLOCK_SZ, 1);
-	ASSERT(sit_blk);
 	check_seg_range(sbi, segno);
 
 	/* calculate sit block address */
@@ -1343,10 +1340,11 @@ struct f2fs_sit_block *get_current_sit_page(struct f2fs_sb_info *sbi,
 
 	ret = dev_read_block(sit_blk, blk_addr);
 	ASSERT(ret >= 0);
-
-	return sit_blk;
 }
 
+void get_current_nat_page(struct f2fs_sb_info *sbi,
+			)
+
 void rewrite_current_sit_page(struct f2fs_sb_info *sbi,
 			unsigned int segno, struct f2fs_sit_block *sit_blk)
 {
@@ -1607,22 +1605,24 @@ void build_sit_entries(struct f2fs_sb_info *sbi)
 	struct sit_info *sit_i = SIT_I(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_COLD_DATA);
 	struct f2fs_journal *journal = &curseg->sum_blk->journal;
+	struct f2fs_sit_block *sit_blk;
 	struct seg_entry *se;
 	struct f2fs_sit_entry sit;
 	unsigned int i, segno;
 
+	sit_blk = calloc(BLOCK_SZ, 1);
+	ASSERT(sit_blk);
 	for (segno = 0; segno < TOTAL_SEGS(sbi); segno++) {
 		se = &sit_i->sentries[segno];
-		struct f2fs_sit_block *sit_blk;
 
-		sit_blk = get_current_sit_page(sbi, segno);
+		get_current_sit_page(sbi, segno, sit_blk);
 		sit = sit_blk->entries[SIT_ENTRY_OFFSET(sit_i, segno)];
-		free(sit_blk);
 
 		check_block_count(sbi, segno, &sit);
 		seg_info_from_raw_sit(se, &sit);
 	}
 
+	free(sit_blk);
 	for (i = 0; i < sits_in_cursum(journal); i++) {
 		segno = le32_to_cpu(segno_in_journal(journal, i));
 		se = &sit_i->sentries[segno];
@@ -1714,24 +1714,26 @@ void rewrite_sit_area_bitmap(struct f2fs_sb_info *sbi)
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_COLD_DATA);
 	struct sit_info *sit_i = SIT_I(sbi);
+	struct f2fs_sit_block *sit_blk;
 	unsigned int segno = 0;
 	struct f2fs_summary_block *sum = curseg->sum_blk;
 	char *ptr = NULL;
 
+	sit_blk = calloc(BLOCK_SZ, 1);
+	ASSERT(sit_blk);
 	/* remove sit journal */
 	sum->journal.n_sits = 0;
 
 	ptr = fsck->main_area_bitmap;
 
 	for (segno = 0; segno < TOTAL_SEGS(sbi); segno++) {
-		struct f2fs_sit_block *sit_blk;
 		struct f2fs_sit_entry *sit;
 		struct seg_entry *se;
 		u16 valid_blocks = 0;
 		u16 type;
 		int i;
 
-		sit_blk = get_current_sit_page(sbi, segno);
+		get_current_sit_page(sbi, segno, sit_blk);
 		sit = &sit_blk->entries[SIT_ENTRY_OFFSET(sit_i, segno)];
 		memcpy(sit->valid_map, ptr, SIT_VBLOCK_MAP_SIZE);
 
@@ -1751,10 +1753,11 @@ void rewrite_sit_area_bitmap(struct f2fs_sb_info *sbi)
 		sit->vblocks = cpu_to_le16((type << SIT_VBLOCKS_SHIFT) |
 								valid_blocks);
 		rewrite_current_sit_page(sbi, segno, sit_blk);
-		free(sit_blk);
 
 		ptr += SIT_VBLOCK_MAP_SIZE;
 	}
+
+	free(sit_blk);
 }
 
 static int flush_sit_journal_entries(struct f2fs_sb_info *sbi)
@@ -1762,18 +1765,20 @@ static int flush_sit_journal_entries(struct f2fs_sb_info *sbi)
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_COLD_DATA);
 	struct f2fs_journal *journal = &curseg->sum_blk->journal;
 	struct sit_info *sit_i = SIT_I(sbi);
+	struct f2fs_sit_block *sit_blk;
 	unsigned int segno;
 	int i;
 
+	sit_blk = calloc(BLOCK_SZ, 1);
+	ASSERT(sit_blk);
 	for (i = 0; i < sits_in_cursum(journal); i++) {
-		struct f2fs_sit_block *sit_blk;
 		struct f2fs_sit_entry *sit;
 		struct seg_entry *se;
 
 		segno = segno_in_journal(journal, i);
 		se = get_seg_entry(sbi, segno);
 
-		sit_blk = get_current_sit_page(sbi, segno);
+		get_current_sit_page(sbi, segno, sit_blk);
 		sit = &sit_blk->entries[SIT_ENTRY_OFFSET(sit_i, segno)];
 
 		memcpy(sit->valid_map, se->cur_valid_map, SIT_VBLOCK_MAP_SIZE);
@@ -1782,9 +1787,9 @@ static int flush_sit_journal_entries(struct f2fs_sb_info *sbi)
 		sit->mtime = cpu_to_le64(se->mtime);
 
 		rewrite_current_sit_page(sbi, segno, sit_blk);
-		free(sit_blk);
 	}
 
+	free(sit_blk);
 	journal->n_sits = 0;
 	return i;
 }
@@ -1839,12 +1844,14 @@ void flush_sit_entries(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
 	struct sit_info *sit_i = SIT_I(sbi);
+	struct f2fs_sit_block *sit_blk;
 	unsigned int segno = 0;
 	u32 free_segs = 0;
 
+	sit_blk = calloc(BLOCK_SZ, 1);
+	ASSERT(sit_blk);
 	/* update free segments */
 	for (segno = 0; segno < TOTAL_SEGS(sbi); segno++) {
-		struct f2fs_sit_block *sit_blk;
 		struct f2fs_sit_entry *sit;
 		struct seg_entry *se;
 
@@ -1853,19 +1860,19 @@ void flush_sit_entries(struct f2fs_sb_info *sbi)
 		if (!se->dirty)
 			continue;
 
-		sit_blk = get_current_sit_page(sbi, segno);
+		get_current_sit_page(sbi, segno, sit_blk);
 		sit = &sit_blk->entries[SIT_ENTRY_OFFSET(sit_i, segno)];
 		memcpy(sit->valid_map, se->cur_valid_map, SIT_VBLOCK_MAP_SIZE);
 		sit->vblocks = cpu_to_le16((se->type << SIT_VBLOCKS_SHIFT) |
 							se->valid_blocks);
 		rewrite_current_sit_page(sbi, segno, sit_blk);
-		free(sit_blk);
 
 		if (se->valid_blocks == 0x0 &&
 				!IS_CUR_SEGNO(sbi, segno, NO_CHECK_TYPE))
 			free_segs++;
 	}
 
+	free(sit_blk);
 	set_cp(free_segment_count, free_segs);
 }
 
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
