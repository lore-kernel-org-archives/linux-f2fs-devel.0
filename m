From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 14/17] fsck.f2fs: handle correctly segment
	summary entries
Date: Fri, 29 Aug 2014 17:29:01 -0700
Message-ID: <1409358544-54740-14-git-send-email-jaegeuk@kernel.org>
References: <1409358544-54740-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XNWYN-00057f-4a
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Aug 2014 00:30:03 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XNWYL-0000P4-RJ for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Aug 2014 00:30:03 +0000
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
 fsck/fsck.c  |  58 ++++++++++++++++--------------
 fsck/mount.c | 113 ++++++++++++++++++++++++++---------------------------------
 2 files changed, 80 insertions(+), 91 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 53a64b7..0a76c19 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -114,34 +114,28 @@ static int is_valid_ssa_node_blk(struct f2fs_sb_info *sbi, u32 nid,
 	struct f2fs_summary sum_entry;
 
 	ret = get_sum_entry(sbi, blk_addr, &sum_entry);
-	ASSERT(ret >= 0);
 
-	if (ret == SEG_TYPE_DATA || ret == SEG_TYPE_CUR_DATA) {
-		ASSERT_MSG("Summary footer is not for node segment\n");
-	} else if (ret == SEG_TYPE_NODE) {
-		if (le32_to_cpu(sum_entry.nid) != nid) {
-			DBG(0, "nid                       [0x%x]\n", nid);
-			DBG(0, "target blk_addr           [0x%x]\n", blk_addr);
-			DBG(0, "summary blk_addr          [0x%x]\n",
+	if (ret != SEG_TYPE_NODE && ret != SEG_TYPE_CUR_NODE) {
+		ASSERT_MSG("Summary footer is not for node segment");
+		return -EINVAL;
+	}
+
+	if (le32_to_cpu(sum_entry.nid) != nid) {
+		DBG(0, "nid                       [0x%x]\n", nid);
+		DBG(0, "target blk_addr           [0x%x]\n", blk_addr);
+		DBG(0, "summary blk_addr          [0x%x]\n",
 					GET_SUM_BLKADDR(sbi,
-						GET_SEGNO(sbi, blk_addr)));
-			DBG(0, "seg no / offset           [0x%x / 0x%x]\n",
+					GET_SEGNO(sbi, blk_addr)));
+		DBG(0, "seg no / offset           [0x%x / 0x%x]\n",
 					GET_SEGNO(sbi, blk_addr),
-						OFFSET_IN_SEG(sbi, blk_addr));
-			DBG(0, "summary_entry.nid         [0x%x]\n",
+					OFFSET_IN_SEG(sbi, blk_addr));
+		DBG(0, "summary_entry.nid         [0x%x]\n",
 					le32_to_cpu(sum_entry.nid));
-			DBG(0, "--> node block's nid      [0x%x]\n", nid);
-			ASSERT_MSG("Invalid node seg summary\n");
-			return -EINVAL;
-		}
-		return 0;
-	} else if (ret == SEG_TYPE_CUR_NODE) {
-		/* current node segment has no ssa */
-		return 0;
-	} else {
-		ASSERT_MSG("Invalid return value of 'get_sum_entry'");
+		DBG(0, "--> node block's nid      [0x%x]\n", nid);
+		ASSERT_MSG("Invalid node seg summary\n");
+		return -EINVAL;
 	}
-	return -EINVAL;
+	return 0;
 }
 
 static int is_valid_ssa_data_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
@@ -151,7 +145,11 @@ static int is_valid_ssa_data_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
 	struct f2fs_summary sum_entry;
 
 	ret = get_sum_entry(sbi, blk_addr, &sum_entry);
-	ASSERT(ret == SEG_TYPE_DATA || ret == SEG_TYPE_CUR_DATA);
+
+	if (ret != SEG_TYPE_DATA && ret != SEG_TYPE_CUR_DATA) {
+		ASSERT_MSG("Summary footer is not for data segment");
+		return -EINVAL;
+	}
 
 	if (le32_to_cpu(sum_entry.nid) != parent_nid ||
 			sum_entry.version != version ||
@@ -169,8 +167,9 @@ static int is_valid_ssa_data_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
 
 		DBG(0, "Target data block addr    [0x%x]\n", blk_addr);
 		ASSERT_MSG("Invalid data seg summary\n");
+		return -EINVAL;
 	}
-	return 1;
+	return 0;
 }
 
 static int sanity_check_nid(struct f2fs_sb_info *sbi, u32 nid,
@@ -697,10 +696,15 @@ int fsck_chk_data_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
 
 	if (!IS_VALID_BLK_ADDR(sbi, blk_addr)) {
 		ASSERT_MSG("blkaddres is not valid. [0x%x]", blk_addr);
-		return 0;
+		return -EINVAL;
 	}
 
-	is_valid_ssa_data_blk(sbi, blk_addr, parent_nid, idx_in_node, ver);
+	if (is_valid_ssa_data_blk(sbi, blk_addr, parent_nid,
+						idx_in_node, ver)) {
+		ASSERT_MSG("summary data block is not valid. [0x%x]",
+						parent_nid);
+		return -EINVAL;
+	}
 
 	if (f2fs_test_sit_bitmap(sbi, blk_addr) == 0)
 		ASSERT_MSG("SIT bitmap is 0x0. blk_addr[0x%x]", blk_addr);
diff --git a/fsck/mount.c b/fsck/mount.c
index 4880848..fb5b261 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -495,26 +495,35 @@ int build_sit_info(struct f2fs_sb_info *sbi)
 void reset_curseg(struct f2fs_sb_info *sbi, int type)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
+	struct summary_footer *sum_footer;
 
 	curseg->segno = curseg->next_segno;
 	curseg->zone = GET_ZONENO_FROM_SEGNO(sbi, curseg->segno);
 	curseg->next_blkoff = 0;
 	curseg->next_segno = NULL_SEGNO;
 
+	sum_footer = &(curseg->sum_blk->footer);
+	memset(sum_footer, 0, sizeof(struct summary_footer));
+	if (IS_DATASEG(type))
+		SET_SUM_TYPE(sum_footer, SUM_TYPE_DATA);
+	if (IS_NODESEG(type))
+		SET_SUM_TYPE(sum_footer, SUM_TYPE_NODE);
 }
 
-int read_compacted_summaries(struct f2fs_sb_info *sbi)
+static void read_compacted_summaries(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
 	struct curseg_info *curseg;
+	unsigned int i, j, offset;
 	block_t start;
 	char *kaddr;
-	unsigned int i, j, offset;
+	int ret;
 
 	start = start_sum_block(sbi);
 
 	kaddr = (char *)malloc(PAGE_SIZE);
-	dev_read_block(kaddr, start++);
+	ret = dev_read_block(kaddr, start++);
+	ASSERT(ret >= 0);
 
 	curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
 	memcpy(&curseg->sum_blk->n_nats, kaddr, SUM_JOURNAL_SIZE);
@@ -548,52 +557,40 @@ int read_compacted_summaries(struct f2fs_sb_info *sbi)
 					PAGE_CACHE_SIZE - SUM_FOOTER_SIZE)
 				continue;
 			memset(kaddr, 0, PAGE_SIZE);
-			dev_read_block(kaddr, start++);
+			ret = dev_read_block(kaddr, start++);
+			ASSERT(ret >= 0);
 			offset = 0;
 		}
 	}
-
 	free(kaddr);
-	return 0;
 }
 
-int restore_node_summary(struct f2fs_sb_info *sbi,
+static void restore_node_summary(struct f2fs_sb_info *sbi,
 		unsigned int segno, struct f2fs_summary_block *sum_blk)
 {
 	struct f2fs_node *node_blk;
 	struct f2fs_summary *sum_entry;
-	void *page;
 	block_t addr;
 	unsigned int i;
+	int ret;
 
-	page = malloc(PAGE_SIZE);
-	if (!page)
-		return -ENOMEM;
+	node_blk = malloc(F2FS_BLKSIZE);
+	ASSERT(node_blk);
 
 	/* scan the node segment */
 	addr = START_BLOCK(sbi, segno);
 	sum_entry = &sum_blk->entries[0];
 
 	for (i = 0; i < sbi->blocks_per_seg; i++, sum_entry++) {
-		if (dev_read_block(page, addr))
-			goto out;
-
-		node_blk = (struct f2fs_node *)page;
+		ret = dev_read_block(node_blk, addr);
+		ASSERT(ret >= 0);
 		sum_entry->nid = node_blk->footer.nid;
-		/* do not change original value */
-#if 0
-		sum_entry->version = 0;
-		sum_entry->ofs_in_node = 0;
-#endif
 		addr++;
-
 	}
-out:
-	free(page);
-	return 0;
+	free(node_blk);
 }
 
-int read_normal_summaries(struct f2fs_sb_info *sbi, int type)
+static void read_normal_summaries(struct f2fs_sb_info *sbi, int type)
 {
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
 	struct f2fs_summary_block *sum_blk;
@@ -601,6 +598,7 @@ int read_normal_summaries(struct f2fs_sb_info *sbi, int type)
 	unsigned short blk_off;
 	unsigned int segno = 0;
 	block_t blk_addr = 0;
+	int ret;
 
 	if (IS_DATASEG(type)) {
 		segno = le32_to_cpu(ckpt->cur_data_segno[type]);
@@ -625,26 +623,11 @@ int read_normal_summaries(struct f2fs_sb_info *sbi, int type)
 	}
 
 	sum_blk = (struct f2fs_summary_block *)malloc(PAGE_SIZE);
-	dev_read_block(sum_blk, blk_addr);
-
-	if (IS_NODESEG(type)) {
-		if (is_set_ckpt_flags(ckpt, CP_UMOUNT_FLAG)) {
-			struct f2fs_summary *sum_entry = &sum_blk->entries[0];
-			unsigned int i;
-			for (i = 0; i < sbi->blocks_per_seg; i++, sum_entry++) {
-				/* do not change original value */
-#if 0
-				sum_entry->version = 0;
-				sum_entry->ofs_in_node = 0;
-#endif
-			}
-		} else {
-			if (restore_node_summary(sbi, segno, sum_blk)) {
-				free(sum_blk);
-				return -EINVAL;
-			}
-		}
-	}
+	ret = dev_read_block(sum_blk, blk_addr);
+	ASSERT(ret >= 0);
+
+	if (IS_NODESEG(type) && !is_set_ckpt_flags(ckpt, CP_UMOUNT_FLAG))
+		restore_node_summary(sbi, segno, sum_blk);
 
 	curseg = CURSEG_I(sbi, type);
 	memcpy(curseg->sum_blk, sum_blk, PAGE_CACHE_SIZE);
@@ -653,44 +636,38 @@ int read_normal_summaries(struct f2fs_sb_info *sbi, int type)
 	curseg->alloc_type = ckpt->alloc_type[type];
 	curseg->next_blkoff = blk_off;
 	free(sum_blk);
-
-	return 0;
 }
 
-int restore_curseg_summaries(struct f2fs_sb_info *sbi)
+static void restore_curseg_summaries(struct f2fs_sb_info *sbi)
 {
 	int type = CURSEG_HOT_DATA;
 
 	if (is_set_ckpt_flags(F2FS_CKPT(sbi), CP_COMPACT_SUM_FLAG)) {
-		if (read_compacted_summaries(sbi))
-			return -EINVAL;
+		read_compacted_summaries(sbi);
 		type = CURSEG_HOT_NODE;
 	}
 
-	for (; type <= CURSEG_COLD_NODE; type++) {
-		if (read_normal_summaries(sbi, type))
-			return -EINVAL;
-	}
-	return 0;
+	for (; type <= CURSEG_COLD_NODE; type++)
+		read_normal_summaries(sbi, type);
 }
 
-int build_curseg(struct f2fs_sb_info *sbi)
+static void build_curseg(struct f2fs_sb_info *sbi)
 {
 	struct curseg_info *array;
 	int i;
 
 	array = malloc(sizeof(*array) * NR_CURSEG_TYPE);
+	ASSERT(array);
 
 	SM_I(sbi)->curseg_array = array;
 
 	for (i = 0; i < NR_CURSEG_TYPE; i++) {
 		array[i].sum_blk = malloc(PAGE_CACHE_SIZE);
-		if (!array[i].sum_blk)
-			return -ENOMEM;
+		ASSERT(array[i].sum_blk);
 		array[i].segno = NULL_SEGNO;
 		array[i].next_blkoff = 0;
 	}
-	return restore_curseg_summaries(sbi);
+	restore_curseg_summaries(sbi);
 }
 
 inline void check_seg_range(struct f2fs_sb_info *sbi, unsigned int segno)
@@ -774,8 +751,13 @@ int get_sum_block(struct f2fs_sb_info *sbi, unsigned int segno,
 	for (type = 0; type < NR_CURSEG_NODE_TYPE; type++) {
 		if (segno == ckpt->cur_node_segno[type]) {
 			curseg = CURSEG_I(sbi, CURSEG_HOT_NODE + type);
+			if (!IS_SUM_NODE_SEG(curseg->sum_blk->footer)) {
+				ASSERT_MSG("segno [0x%x] indicates a data "
+						"segment, but should be node",
+						segno);
+				return -EINVAL;
+			}
 			memcpy(sum_blk, curseg->sum_blk, BLOCK_SZ);
-			/* current node seg was not stored */
 			return SEG_TYPE_CUR_NODE;
 		}
 	}
@@ -783,11 +765,15 @@ int get_sum_block(struct f2fs_sb_info *sbi, unsigned int segno,
 	for (type = 0; type < NR_CURSEG_DATA_TYPE; type++) {
 		if (segno == ckpt->cur_data_segno[type]) {
 			curseg = CURSEG_I(sbi, type);
-			memcpy(sum_blk, curseg->sum_blk, BLOCK_SZ);
-			ASSERT(!IS_SUM_NODE_SEG(sum_blk->footer));
+			if (IS_SUM_NODE_SEG(curseg->sum_blk->footer)) {
+				ASSERT_MSG("segno [0x%x] indicates a node "
+						"segment, but should be data",
+						segno);
+				return -EINVAL;
+			}
 			DBG(2, "segno [0x%x] is current data seg[0x%x]\n",
 								segno, type);
-			/* current data seg was not stored */
+			memcpy(sum_blk, curseg->sum_blk, BLOCK_SZ);
 			return SEG_TYPE_CUR_DATA;
 		}
 	}
@@ -815,7 +801,6 @@ int get_sum_entry(struct f2fs_sb_info *sbi, u32 blk_addr,
 	sum_blk = calloc(BLOCK_SZ, 1);
 
 	ret = get_sum_block(sbi, segno, sum_blk);
-
 	memcpy(sum_entry, &(sum_blk->entries[offset]),
 				sizeof(struct f2fs_summary));
 	free(sum_blk);
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
