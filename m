From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/2] f2fs-tools: rebase struct f2fs_summary_block
	with upstream
Date: Fri, 11 Mar 2016 16:43:54 +0800
Message-ID: <010201d17b72$4019dce0$c04d96a0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aeIgo-0008HG-7X
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Mar 2016 08:44:54 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aeIgl-0003Mw-Ek
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Mar 2016 08:44:54 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O3V008H79M4IN00@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Mar 2016 17:44:43 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

Struct f2fs_summary_block has been changed in upstream commits:
 - commit 8f1dbbbbdfe9 ("f2fs: introduce lifetime write IO statistics")
 - commit dfc08a12e49a ("f2fs: introduce f2fs_journal struct to wrap journal info")

This patch does the sync work for f2fs_summary_block structure between
f2fs-utils and f2fs kernel module.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fsck/f2fs.h        | 12 ++++++------
 fsck/mount.c       | 50 +++++++++++++++++++++++++-------------------------
 include/f2fs_fs.h  | 25 +++++++++++++++++++++----
 mkfs/f2fs_format.c | 48 +++++++++++++++++++++++++-----------------------
 4 files changed, 77 insertions(+), 58 deletions(-)

diff --git a/fsck/f2fs.h b/fsck/f2fs.h
index f990527..a618b47 100644
--- a/fsck/f2fs.h
+++ b/fsck/f2fs.h
@@ -314,13 +314,13 @@ static inline block_t sum_blk_addr(struct f2fs_sb_info *sbi, int base, int type)
 }
 
 
-#define nats_in_cursum(sum)             (le16_to_cpu(sum->n_nats))
-#define sits_in_cursum(sum)             (le16_to_cpu(sum->n_sits))
+#define nats_in_cursum(jnl)             (le16_to_cpu(jnl->n_nats))
+#define sits_in_cursum(jnl)             (le16_to_cpu(jnl->n_sits))
 
-#define nat_in_journal(sum, i)          (sum->nat_j.entries[i].ne)
-#define nid_in_journal(sum, i)          (sum->nat_j.entries[i].nid)
-#define sit_in_journal(sum, i)          (sum->sit_j.entries[i].se)
-#define segno_in_journal(sum, i)        (sum->sit_j.entries[i].segno)
+#define nat_in_journal(jnl, i)          (jnl->nat_j.entries[i].ne)
+#define nid_in_journal(jnl, i)          (jnl->nat_j.entries[i].nid)
+#define sit_in_journal(jnl, i)          (jnl->sit_j.entries[i].se)
+#define segno_in_journal(jnl, i)        (jnl->sit_j.entries[i].segno)
 
 #define SIT_ENTRY_OFFSET(sit_i, segno)                                  \
 	(segno % sit_i->sents_per_block)
diff --git a/fsck/mount.c b/fsck/mount.c
index f7fbbd9..153055e 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -647,10 +647,10 @@ static void read_compacted_summaries(struct f2fs_sb_info *sbi)
 	ASSERT(ret >= 0);
 
 	curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
-	memcpy(&curseg->sum_blk->n_nats, kaddr, SUM_JOURNAL_SIZE);
+	memcpy(&curseg->sum_blk->journal.n_nats, kaddr, SUM_JOURNAL_SIZE);
 
 	curseg = CURSEG_I(sbi, CURSEG_COLD_DATA);
-	memcpy(&curseg->sum_blk->n_sits, kaddr + SUM_JOURNAL_SIZE,
+	memcpy(&curseg->sum_blk->journal.n_sits, kaddr + SUM_JOURNAL_SIZE,
 						SUM_JOURNAL_SIZE);
 
 	offset = 2 * SUM_JOURNAL_SIZE;
@@ -1115,7 +1115,7 @@ void build_sit_entries(struct f2fs_sb_info *sbi)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_COLD_DATA);
-	struct f2fs_summary_block *sum = curseg->sum_blk;
+	struct f2fs_journal *journal = &curseg->sum_blk->journal;
 	unsigned int segno;
 
 	for (segno = 0; segno < TOTAL_SEGS(sbi); segno++) {
@@ -1124,9 +1124,9 @@ void build_sit_entries(struct f2fs_sb_info *sbi)
 		struct f2fs_sit_entry sit;
 		int i;
 
-		for (i = 0; i < sits_in_cursum(sum); i++) {
-			if (le32_to_cpu(segno_in_journal(sum, i)) == segno) {
-				sit = sit_in_journal(sum, i);
+		for (i = 0; i < sits_in_cursum(journal); i++) {
+			if (le32_to_cpu(segno_in_journal(journal, i)) == segno) {
+				sit = sit_in_journal(journal, i);
 				goto got_it;
 			}
 		}
@@ -1224,7 +1224,7 @@ void rewrite_sit_area_bitmap(struct f2fs_sb_info *sbi)
 	char *ptr = NULL;
 
 	/* remove sit journal */
-	sum->n_sits = 0;
+	sum->journal.n_sits = 0;
 
 	fsck->chk.free_segs = 0;
 
@@ -1274,17 +1274,17 @@ void rewrite_sit_area_bitmap(struct f2fs_sb_info *sbi)
 static void flush_sit_journal_entries(struct f2fs_sb_info *sbi)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_COLD_DATA);
-	struct f2fs_summary_block *sum = curseg->sum_blk;
+	struct f2fs_journal *journal = &curseg->sum_blk->journal;
 	struct sit_info *sit_i = SIT_I(sbi);
 	unsigned int segno;
 	int i;
 
-	for (i = 0; i < sits_in_cursum(sum); i++) {
+	for (i = 0; i < sits_in_cursum(journal); i++) {
 		struct f2fs_sit_block *sit_blk;
 		struct f2fs_sit_entry *sit;
 		struct seg_entry *se;
 
-		segno = segno_in_journal(sum, i);
+		segno = segno_in_journal(journal, i);
 		se = get_seg_entry(sbi, segno);
 
 		sit_blk = get_current_sit_page(sbi, segno);
@@ -1298,13 +1298,13 @@ static void flush_sit_journal_entries(struct f2fs_sb_info *sbi)
 		rewrite_current_sit_page(sbi, segno, sit_blk);
 		free(sit_blk);
 	}
-	sum->n_sits = 0;
+	journal->n_sits = 0;
 }
 
 static void flush_nat_journal_entries(struct f2fs_sb_info *sbi)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
-	struct f2fs_summary_block *sum = curseg->sum_blk;
+	struct f2fs_journal *journal = &curseg->sum_blk->journal;
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct f2fs_nat_block *nat_block;
 	pgoff_t block_off;
@@ -1315,12 +1315,12 @@ static void flush_nat_journal_entries(struct f2fs_sb_info *sbi)
 	int i = 0;
 
 next:
-	if (i >= nats_in_cursum(sum)) {
-		sum->n_nats = 0;
+	if (i >= nats_in_cursum(journal)) {
+		journal->n_nats = 0;
 		return;
 	}
 
-	nid = le32_to_cpu(nid_in_journal(sum, i));
+	nid = le32_to_cpu(nid_in_journal(journal, i));
 	nat_block = (struct f2fs_nat_block *)calloc(BLOCK_SZ, 1);
 
 	block_off = nid / NAT_ENTRY_PER_BLOCK;
@@ -1337,7 +1337,7 @@ next:
 	ret = dev_read_block(nat_block, block_addr);
 	ASSERT(ret >= 0);
 
-	memcpy(&nat_block->entries[entry_off], &nat_in_journal(sum, i),
+	memcpy(&nat_block->entries[entry_off], &nat_in_journal(journal, i),
 					sizeof(struct f2fs_nat_entry));
 
 	ret = dev_write_block(nat_block, block_addr);
@@ -1477,7 +1477,7 @@ void zero_journal_entries(struct f2fs_sb_info *sbi)
 	int i;
 
 	for (i = 0; i < NO_CHECK_TYPE; i++)
-		CURSEG_I(sbi, i)->sum_blk->n_nats = 0;
+		CURSEG_I(sbi, i)->sum_blk->journal.n_nats = 0;
 }
 
 void write_curseg_info(struct f2fs_sb_info *sbi)
@@ -1505,12 +1505,12 @@ int lookup_nat_in_journal(struct f2fs_sb_info *sbi, u32 nid,
 					struct f2fs_nat_entry *raw_nat)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
-	struct f2fs_summary_block *sum = curseg->sum_blk;
+	struct f2fs_journal *journal = &curseg->sum_blk->journal;
 	int i = 0;
 
-	for (i = 0; i < nats_in_cursum(sum); i++) {
-		if (le32_to_cpu(nid_in_journal(sum, i)) == nid) {
-			memcpy(raw_nat, &nat_in_journal(sum, i),
+	for (i = 0; i < nats_in_cursum(journal); i++) {
+		if (le32_to_cpu(nid_in_journal(journal, i)) == nid) {
+			memcpy(raw_nat, &nat_in_journal(journal, i),
 						sizeof(struct f2fs_nat_entry));
 			DBG(3, "==> Found nid [0x%x] in nat cache\n", nid);
 			return i;
@@ -1522,7 +1522,7 @@ int lookup_nat_in_journal(struct f2fs_sb_info *sbi, u32 nid,
 void nullify_nat_entry(struct f2fs_sb_info *sbi, u32 nid)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
-	struct f2fs_summary_block *sum = curseg->sum_blk;
+	struct f2fs_journal *journal = &curseg->sum_blk->journal;
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct f2fs_nat_block *nat_block;
 	pgoff_t block_off;
@@ -1532,9 +1532,9 @@ void nullify_nat_entry(struct f2fs_sb_info *sbi, u32 nid)
 	int i = 0;
 
 	/* check in journal */
-	for (i = 0; i < nats_in_cursum(sum); i++) {
-		if (le32_to_cpu(nid_in_journal(sum, i)) == nid) {
-			memset(&nat_in_journal(sum, i), 0,
+	for (i = 0; i < nats_in_cursum(journal); i++) {
+		if (le32_to_cpu(nid_in_journal(journal, i)) == nid) {
+			memset(&nat_in_journal(journal, i), 0,
 					sizeof(struct f2fs_nat_entry));
 			FIX_MSG("Remove nid [0x%x] in nat journal\n", nid);
 			return;
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index aaf534a..0046be6 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -720,6 +720,13 @@ struct summary_footer {
 				sizeof(struct sit_journal_entry))
 #define SIT_JOURNAL_RESERVED	((SUM_JOURNAL_SIZE - 2) %\
 				sizeof(struct sit_journal_entry))
+
+/*
+ * Reserved area should make size of f2fs_extra_info equals to
+ * that of nat_journal and sit_journal.
+ */
+#define EXTRA_INFO_RESERVED	(SUM_JOURNAL_SIZE - 2 - 8)
+
 /*
  * frequently updated NAT/SIT entries can be stored in the spare area in
  * summary blocks
@@ -749,18 +756,28 @@ struct sit_journal {
 	__u8 reserved[SIT_JOURNAL_RESERVED];
 } __attribute__((packed));
 
-/* 4KB-sized summary block structure */
-struct f2fs_summary_block {
-	struct f2fs_summary entries[ENTRIES_IN_SUM];
+struct f2fs_extra_info {
+	__le64 kbytes_written;
+	__u8 reserved[EXTRA_INFO_RESERVED];
+} __attribute__((packed));
+
+struct f2fs_journal {
 	union {
 		__le16 n_nats;
 		__le16 n_sits;
 	};
-	/* spare area is used by NAT or SIT journals */
+	/* spare area is used by NAT or SIT journals or extra info */
 	union {
 		struct nat_journal nat_j;
 		struct sit_journal sit_j;
+		struct f2fs_extra_info info;
 	};
+} __attribute__((packed));
+
+/* 4KB-sized summary block structure */
+struct f2fs_summary_block {
+	struct f2fs_summary entries[ENTRIES_IN_SUM];
+	struct f2fs_journal journal;
 	struct summary_footer footer;
 } __attribute__((packed));
 
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 645c2aa..4f38f03 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -410,6 +410,7 @@ static int f2fs_init_nat_area(void)
 static int f2fs_write_check_point_pack(void)
 {
 	struct f2fs_summary_block *sum = NULL;
+	struct f2fs_journal *journal;
 	u_int32_t blk_size_bytes;
 	u_int64_t cp_seg_blk_offset = 0;
 	u_int32_t crc = 0;
@@ -532,38 +533,39 @@ static int f2fs_write_check_point_pack(void)
 	memset(sum, 0, sizeof(struct f2fs_summary_block));
 	SET_SUM_TYPE((&sum->footer), SUM_TYPE_DATA);
 
-	sum->n_nats = cpu_to_le16(1);
-	sum->nat_j.entries[0].nid = sb->root_ino;
-	sum->nat_j.entries[0].ne.version = 0;
-	sum->nat_j.entries[0].ne.ino = sb->root_ino;
-	sum->nat_j.entries[0].ne.block_addr = cpu_to_le32(
+	journal = &sum->journal;
+	journal->n_nats = cpu_to_le16(1);
+	journal->nat_j.entries[0].nid = sb->root_ino;
+	journal->nat_j.entries[0].ne.version = 0;
+	journal->nat_j.entries[0].ne.ino = sb->root_ino;
+	journal->nat_j.entries[0].ne.block_addr = cpu_to_le32(
 			get_sb(main_blkaddr) +
 			get_cp(cur_node_segno[0]) * config.blks_per_seg);
 
-	memcpy(sum_compact_p, &sum->n_nats, SUM_JOURNAL_SIZE);
+	memcpy(sum_compact_p, &journal->n_nats, SUM_JOURNAL_SIZE);
 	sum_compact_p += SUM_JOURNAL_SIZE;
 
 	memset(sum, 0, sizeof(struct f2fs_summary_block));
 	/* inode sit for root */
-	sum->n_sits = cpu_to_le16(6);
-	sum->sit_j.entries[0].segno = cp->cur_node_segno[0];
-	sum->sit_j.entries[0].se.vblocks = cpu_to_le16((CURSEG_HOT_NODE << 10) | 1);
-	f2fs_set_bit(0, (char *)sum->sit_j.entries[0].se.valid_map);
-	sum->sit_j.entries[1].segno = cp->cur_node_segno[1];
-	sum->sit_j.entries[1].se.vblocks = cpu_to_le16((CURSEG_WARM_NODE << 10));
-	sum->sit_j.entries[2].segno = cp->cur_node_segno[2];
-	sum->sit_j.entries[2].se.vblocks = cpu_to_le16((CURSEG_COLD_NODE << 10));
+	journal->n_sits = cpu_to_le16(6);
+	journal->sit_j.entries[0].segno = cp->cur_node_segno[0];
+	journal->sit_j.entries[0].se.vblocks = cpu_to_le16((CURSEG_HOT_NODE << 10) | 1);
+	f2fs_set_bit(0, (char *)journal->sit_j.entries[0].se.valid_map);
+	journal->sit_j.entries[1].segno = cp->cur_node_segno[1];
+	journal->sit_j.entries[1].se.vblocks = cpu_to_le16((CURSEG_WARM_NODE << 10));
+	journal->sit_j.entries[2].segno = cp->cur_node_segno[2];
+	journal->sit_j.entries[2].se.vblocks = cpu_to_le16((CURSEG_COLD_NODE << 10));
 
 	/* data sit for root */
-	sum->sit_j.entries[3].segno = cp->cur_data_segno[0];
-	sum->sit_j.entries[3].se.vblocks = cpu_to_le16((CURSEG_HOT_DATA << 10) | 1);
-	f2fs_set_bit(0, (char *)sum->sit_j.entries[3].se.valid_map);
-	sum->sit_j.entries[4].segno = cp->cur_data_segno[1];
-	sum->sit_j.entries[4].se.vblocks = cpu_to_le16((CURSEG_WARM_DATA << 10));
-	sum->sit_j.entries[5].segno = cp->cur_data_segno[2];
-	sum->sit_j.entries[5].se.vblocks = cpu_to_le16((CURSEG_COLD_DATA << 10));
-
-	memcpy(sum_compact_p, &sum->n_sits, SUM_JOURNAL_SIZE);
+	journal->sit_j.entries[3].segno = cp->cur_data_segno[0];
+	journal->sit_j.entries[3].se.vblocks = cpu_to_le16((CURSEG_HOT_DATA << 10) | 1);
+	f2fs_set_bit(0, (char *)journal->sit_j.entries[3].se.valid_map);
+	journal->sit_j.entries[4].segno = cp->cur_data_segno[1];
+	journal->sit_j.entries[4].se.vblocks = cpu_to_le16((CURSEG_WARM_DATA << 10));
+	journal->sit_j.entries[5].segno = cp->cur_data_segno[2];
+	journal->sit_j.entries[5].se.vblocks = cpu_to_le16((CURSEG_COLD_DATA << 10));
+
+	memcpy(sum_compact_p, &journal->n_sits, SUM_JOURNAL_SIZE);
 	sum_compact_p += SUM_JOURNAL_SIZE;
 
 	/* hot data summary */
-- 
2.7.0



------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785111&iu=/4140
