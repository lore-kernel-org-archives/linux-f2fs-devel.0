From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 16/17] fsck.f2fs: check next block is free or not
Date: Fri, 29 Aug 2014 17:29:03 -0700
Message-ID: <1409358544-54740-16-git-send-email-jaegeuk@kernel.org>
References: <1409358544-54740-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XNWYS-0007NQ-3V
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Aug 2014 00:30:08 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XNWYQ-00026X-W8 for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Aug 2014 00:30:08 +0000
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

If block allocation is made to the next block offset, we should drop that
block.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/f2fs.h  | 19 +++++++++++++++++--
 fsck/fsck.c  | 27 +++++++++++++++++++++++++++
 fsck/mount.c | 46 +++++++++++++++++++++-------------------------
 3 files changed, 65 insertions(+), 27 deletions(-)

diff --git a/fsck/f2fs.h b/fsck/f2fs.h
index 8c31981..f674ede 100644
--- a/fsck/f2fs.h
+++ b/fsck/f2fs.h
@@ -266,10 +266,15 @@ static inline block_t __start_sum_addr(struct f2fs_sb_info *sbi)
 #define GET_SEGNO_FROM_SEG0(sbi, blk_addr)				\
 	(GET_SEGOFF_FROM_SEG0(sbi, blk_addr) >> sbi->log_blocks_per_seg)
 
-#define FREE_I_START_SEGNO(sbi)		GET_SEGNO_FROM_SEG0(sbi, SM_I(sbi)->main_blkaddr)
+#define GET_BLKOFF_FROM_SEG0(sbi, blk_addr)				\
+	(GET_SEGOFF_FROM_SEG0(sbi, blk_addr) & (sbi->blocks_per_seg - 1))
+
+#define FREE_I_START_SEGNO(sbi)						\
+	GET_SEGNO_FROM_SEG0(sbi, SM_I(sbi)->main_blkaddr)
 #define GET_R2L_SEGNO(sbi, segno)	(segno + FREE_I_START_SEGNO(sbi))
 
-#define START_BLOCK(sbi, segno)	(SM_I(sbi)->main_blkaddr + (segno << sbi->log_blocks_per_seg))
+#define START_BLOCK(sbi, segno)	(SM_I(sbi)->main_blkaddr +		\
+	(segno << sbi->log_blocks_per_seg))
 
 static inline struct curseg_info *CURSEG_I(struct f2fs_sb_info *sbi, int type)
 {
@@ -311,6 +316,8 @@ static inline bool IS_VALID_NID(struct f2fs_sb_info *sbi, u32 nid)
 
 static inline bool IS_VALID_BLK_ADDR(struct f2fs_sb_info *sbi, u32 addr)
 {
+	int i;
+
 	if (addr >= F2FS_RAW_SUPER(sbi)->block_count ||
 				addr < SM_I(sbi)->main_blkaddr) {
 		DBG(0, "block addr [0x%x]\n", addr);
@@ -318,6 +325,14 @@ static inline bool IS_VALID_BLK_ADDR(struct f2fs_sb_info *sbi, u32 addr)
 		ASSERT(addr >= SM_I(sbi)->main_blkaddr);
 		return 0;
 	}
+
+	for (i = 0; i < NO_CHECK_TYPE; i++) {
+		struct curseg_info *curseg = CURSEG_I(sbi, i);
+
+		if (START_BLOCK(sbi, curseg->segno) +
+					curseg->next_blkoff == addr)
+			return 0;
+	}
 	return 1;
 }
 
diff --git a/fsck/fsck.c b/fsck/fsck.c
index 8df489d..560b541 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -843,6 +843,24 @@ static void fix_checkpoint(struct f2fs_sb_info *sbi)
 	ASSERT(ret >= 0);
 }
 
+int check_curseg_offset(struct f2fs_sb_info *sbi)
+{
+	int i;
+
+	for (i = 0; i < NO_CHECK_TYPE; i++) {
+		struct curseg_info *curseg = CURSEG_I(sbi, i);
+		struct seg_entry *se;
+
+		se = get_seg_entry(sbi, curseg->segno);
+		if (f2fs_test_bit(curseg->next_blkoff,
+				(const char *)se->cur_valid_map) == 1) {
+			ASSERT_MSG("Next block offset is not free, type:%d", i);
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
 int fsck_verify(struct f2fs_sb_info *sbi)
 {
 	unsigned int i = 0;
@@ -944,6 +962,15 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 		config.bug_on = 1;
 	}
 
+	printf("[FSCK] next block offset is free                     ");
+	if (check_curseg_offset(sbi) == 0) {
+		printf(" [Ok..]\n");
+	} else {
+		printf(" [Fail]\n");
+		ret = EXIT_ERR_CODE;
+		config.bug_on = 1;
+	}
+
 	printf("[FSCK] other corrupted bugs                          ");
 	if (config.bug_on == 0) {
 		printf(" [Ok..]\n");
diff --git a/fsck/mount.c b/fsck/mount.c
index a41320f..2bbd3c5 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -505,11 +505,6 @@ void reset_curseg(struct f2fs_sb_info *sbi, int type)
 	struct summary_footer *sum_footer;
 	struct seg_entry *se;
 
-	curseg->segno = curseg->next_segno;
-	curseg->zone = GET_ZONENO_FROM_SEGNO(sbi, curseg->segno);
-	curseg->next_blkoff = 0;
-	curseg->next_segno = NULL_SEGNO;
-
 	sum_footer = &(curseg->sum_blk->footer);
 	memset(sum_footer, 0, sizeof(struct summary_footer));
 	if (IS_DATASEG(type))
@@ -522,7 +517,6 @@ void reset_curseg(struct f2fs_sb_info *sbi, int type)
 
 static void read_compacted_summaries(struct f2fs_sb_info *sbi)
 {
-	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
 	struct curseg_info *curseg;
 	unsigned int i, j, offset;
 	block_t start;
@@ -545,18 +539,14 @@ static void read_compacted_summaries(struct f2fs_sb_info *sbi)
 	offset = 2 * SUM_JOURNAL_SIZE;
 	for (i = CURSEG_HOT_DATA; i <= CURSEG_COLD_DATA; i++) {
 		unsigned short blk_off;
-		unsigned int segno;
+		struct curseg_info *curseg = CURSEG_I(sbi, i);
 
-		curseg = CURSEG_I(sbi, i);
-		segno = le32_to_cpu(ckpt->cur_data_segno[i]);
-		blk_off = le16_to_cpu(ckpt->cur_data_blkoff[i]);
-		curseg->next_segno = segno;
 		reset_curseg(sbi, i);
-		curseg->alloc_type = ckpt->alloc_type[i];
-		curseg->next_blkoff = blk_off;
 
 		if (curseg->alloc_type == SSR)
 			blk_off = sbi->blocks_per_seg;
+		else
+			blk_off = curseg->next_blkoff;
 
 		for (j = 0; j < blk_off; j++) {
 			struct f2fs_summary *s;
@@ -605,16 +595,12 @@ static void read_normal_summaries(struct f2fs_sb_info *sbi, int type)
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
 	struct f2fs_summary_block *sum_blk;
 	struct curseg_info *curseg;
-	unsigned short blk_off;
 	unsigned int segno = 0;
 	block_t blk_addr = 0;
 	int ret;
 
 	if (IS_DATASEG(type)) {
 		segno = le32_to_cpu(ckpt->cur_data_segno[type]);
-		blk_off = le16_to_cpu(ckpt->cur_data_blkoff[type -
-							CURSEG_HOT_DATA]);
-
 		if (is_set_ckpt_flags(ckpt, CP_UMOUNT_FLAG))
 			blk_addr = sum_blk_addr(sbi, NR_CURSEG_TYPE, type);
 		else
@@ -622,9 +608,6 @@ static void read_normal_summaries(struct f2fs_sb_info *sbi, int type)
 	} else {
 		segno = le32_to_cpu(ckpt->cur_node_segno[type -
 							CURSEG_HOT_NODE]);
-		blk_off = le16_to_cpu(ckpt->cur_node_blkoff[type -
-							CURSEG_HOT_NODE]);
-
 		if (is_set_ckpt_flags(ckpt, CP_UMOUNT_FLAG))
 			blk_addr = sum_blk_addr(sbi, NR_CURSEG_NODE_TYPE,
 							type - CURSEG_HOT_NODE);
@@ -641,10 +624,7 @@ static void read_normal_summaries(struct f2fs_sb_info *sbi, int type)
 
 	curseg = CURSEG_I(sbi, type);
 	memcpy(curseg->sum_blk, sum_blk, PAGE_CACHE_SIZE);
-	curseg->next_segno = segno;
 	reset_curseg(sbi, type);
-	curseg->alloc_type = ckpt->alloc_type[type];
-	curseg->next_blkoff = blk_off;
 	free(sum_blk);
 }
 
@@ -663,7 +643,10 @@ static void restore_curseg_summaries(struct f2fs_sb_info *sbi)
 
 static void build_curseg(struct f2fs_sb_info *sbi)
 {
+	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
 	struct curseg_info *array;
+	unsigned short blk_off;
+	unsigned int segno;
 	int i;
 
 	array = malloc(sizeof(*array) * NR_CURSEG_TYPE);
@@ -674,8 +657,21 @@ static void build_curseg(struct f2fs_sb_info *sbi)
 	for (i = 0; i < NR_CURSEG_TYPE; i++) {
 		array[i].sum_blk = malloc(PAGE_CACHE_SIZE);
 		ASSERT(array[i].sum_blk);
-		array[i].segno = NULL_SEGNO;
-		array[i].next_blkoff = 0;
+		if (i <= CURSEG_COLD_DATA) {
+			blk_off = le16_to_cpu(ckpt->cur_data_blkoff[i]);
+			segno = le32_to_cpu(ckpt->cur_data_segno[i]);
+		}
+		if (i > CURSEG_COLD_DATA) {
+			blk_off = le16_to_cpu(ckpt->cur_node_blkoff[i -
+							CURSEG_HOT_NODE]);
+			segno = le32_to_cpu(ckpt->cur_node_segno[i -
+							CURSEG_HOT_NODE]);
+		}
+		array[i].segno = segno;
+		array[i].zone = GET_ZONENO_FROM_SEGNO(sbi, segno);
+		array[i].next_segno = NULL_SEGNO;
+		array[i].next_blkoff = blk_off;
+		array[i].alloc_type = ckpt->alloc_type[i];
 	}
 	restore_curseg_summaries(sbi);
 }
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
