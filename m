From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/7] f2fs: introduce f2fs_journal struct to wrap
	journal info
Date: Sun, 14 Feb 2016 18:50:40 +0800
Message-ID: <00fa01d16715$a353b040$e9fb10c0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aUuH8-0005Aj-KO
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 14 Feb 2016 10:51:34 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aUuH6-0002F1-B3
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 14 Feb 2016 10:51:34 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O2J01RRAA5OY210@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Sun, 14 Feb 2016 19:51:24 +0900 (KST)
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Introduce a new structure f2fs_journal to wrap journal info in struct
f2fs_summary_block for readability.

struct f2fs_journal {
	union {
		__le16 n_nats;
		__le16 n_sits;
	};
	union {
		struct nat_journal nat_j;
		struct sit_journal sit_j;
		struct f2fs_extra_info info;
	};
} __packed;

struct f2fs_summary_block {
	struct f2fs_summary entries[ENTRIES_IN_SUM];
	struct f2fs_journal journal;
	struct summary_footer footer;
} __packed;

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/checkpoint.c    |  2 +-
 fs/f2fs/f2fs.h          | 39 +++++++++++++++++------------------
 fs/f2fs/node.c          | 42 ++++++++++++++++++++------------------
 fs/f2fs/segment.c       | 54 ++++++++++++++++++++++++-------------------------
 fs/f2fs/super.c         |  2 +-
 include/linux/f2fs_fs.h | 10 ++++++---
 6 files changed, 77 insertions(+), 72 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 536bec9..3cdcdaf 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1051,7 +1051,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	if (sb->s_bdev->bd_part)
 		kbytes_written += BD_PART_WRITTEN(sbi);
 
-	seg_i->sum_blk->info.kbytes_written = cpu_to_le64(kbytes_written);
+	seg_i->sum_blk->journal.info.kbytes_written = cpu_to_le64(kbytes_written);
 
 	if (__remain_node_summaries(cpc->reason)) {
 		write_node_summaries(sbi, start_blk);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 0d2b1ba..c4c7bf1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -183,37 +183,37 @@ struct fsync_inode_entry {
 	block_t last_inode;	/* block address locating the last inode */
 };
 
-#define nats_in_cursum(sum)		(le16_to_cpu(sum->n_nats))
-#define sits_in_cursum(sum)		(le16_to_cpu(sum->n_sits))
+#define nats_in_cursum(jnl)		(le16_to_cpu(jnl->n_nats))
+#define sits_in_cursum(jnl)		(le16_to_cpu(jnl->n_sits))
 
-#define nat_in_journal(sum, i)		(sum->nat_j.entries[i].ne)
-#define nid_in_journal(sum, i)		(sum->nat_j.entries[i].nid)
-#define sit_in_journal(sum, i)		(sum->sit_j.entries[i].se)
-#define segno_in_journal(sum, i)	(sum->sit_j.entries[i].segno)
+#define nat_in_journal(jnl, i)		(jnl->nat_j.entries[i].ne)
+#define nid_in_journal(jnl, i)		(jnl->nat_j.entries[i].nid)
+#define sit_in_journal(jnl, i)		(jnl->sit_j.entries[i].se)
+#define segno_in_journal(jnl, i)	(jnl->sit_j.entries[i].segno)
 
-#define MAX_NAT_JENTRIES(sum)	(NAT_JOURNAL_ENTRIES - nats_in_cursum(sum))
-#define MAX_SIT_JENTRIES(sum)	(SIT_JOURNAL_ENTRIES - sits_in_cursum(sum))
+#define MAX_NAT_JENTRIES(jnl)	(NAT_JOURNAL_ENTRIES - nats_in_cursum(jnl))
+#define MAX_SIT_JENTRIES(jnl)	(SIT_JOURNAL_ENTRIES - sits_in_cursum(jnl))
 
-static inline int update_nats_in_cursum(struct f2fs_summary_block *rs, int i)
+static inline int update_nats_in_cursum(struct f2fs_journal *journal, int i)
 {
-	int before = nats_in_cursum(rs);
-	rs->n_nats = cpu_to_le16(before + i);
+	int before = nats_in_cursum(journal);
+	journal->n_nats = cpu_to_le16(before + i);
 	return before;
 }
 
-static inline int update_sits_in_cursum(struct f2fs_summary_block *rs, int i)
+static inline int update_sits_in_cursum(struct f2fs_journal *journal, int i)
 {
-	int before = sits_in_cursum(rs);
-	rs->n_sits = cpu_to_le16(before + i);
+	int before = sits_in_cursum(journal);
+	journal->n_sits = cpu_to_le16(before + i);
 	return before;
 }
 
-static inline bool __has_cursum_space(struct f2fs_summary_block *sum, int size,
-								int type)
+static inline bool __has_cursum_space(struct f2fs_journal *journal,
+							int size, int type)
 {
 	if (type == NAT_JOURNAL)
-		return size <= MAX_NAT_JENTRIES(sum);
-	return size <= MAX_SIT_JENTRIES(sum);
+		return size <= MAX_NAT_JENTRIES(journal);
+	return size <= MAX_SIT_JENTRIES(journal);
 }
 
 /*
@@ -1862,8 +1862,7 @@ void f2fs_wait_on_page_writeback(struct page *, enum page_type, bool);
 void f2fs_wait_on_encrypted_page_writeback(struct f2fs_sb_info *, block_t);
 void write_data_summaries(struct f2fs_sb_info *, block_t);
 void write_node_summaries(struct f2fs_sb_info *, block_t);
-int lookup_journal_in_cursum(struct f2fs_summary_block *,
-					int, unsigned int, int);
+int lookup_journal_in_cursum(struct f2fs_journal *, int, unsigned int, int);
 void flush_sit_entries(struct f2fs_sb_info *, struct cp_control *);
 int build_segment_manager(struct f2fs_sb_info *);
 void destroy_segment_manager(struct f2fs_sb_info *);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 150907f..8230e35 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -354,7 +354,7 @@ void get_node_info(struct f2fs_sb_info *sbi, nid_t nid, struct node_info *ni)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
-	struct f2fs_summary_block *sum = curseg->sum_blk;
+	struct f2fs_journal *journal = &curseg->sum_blk->journal;
 	nid_t start_nid = START_NID(nid);
 	struct f2fs_nat_block *nat_blk;
 	struct page *page = NULL;
@@ -382,9 +382,9 @@ void get_node_info(struct f2fs_sb_info *sbi, nid_t nid, struct node_info *ni)
 
 	/* Check current segment summary */
 	mutex_lock(&curseg->curseg_mutex);
-	i = lookup_journal_in_cursum(sum, NAT_JOURNAL, nid, 0);
+	i = lookup_journal_in_cursum(journal, NAT_JOURNAL, nid, 0);
 	if (i >= 0) {
-		ne = nat_in_journal(sum, i);
+		ne = nat_in_journal(journal, i);
 		node_info_from_raw_nat(ni, &ne);
 	}
 	mutex_unlock(&curseg->curseg_mutex);
@@ -1613,7 +1613,7 @@ static void build_free_nids(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
-	struct f2fs_summary_block *sum = curseg->sum_blk;
+	struct f2fs_journal *journal = &curseg->sum_blk->journal;
 	int i = 0;
 	nid_t nid = nm_i->next_scan_nid;
 
@@ -1646,9 +1646,11 @@ static void build_free_nids(struct f2fs_sb_info *sbi)
 
 	/* find free nids from current sum_pages */
 	mutex_lock(&curseg->curseg_mutex);
-	for (i = 0; i < nats_in_cursum(sum); i++) {
-		block_t addr = le32_to_cpu(nat_in_journal(sum, i).block_addr);
-		nid = le32_to_cpu(nid_in_journal(sum, i));
+	for (i = 0; i < nats_in_cursum(journal); i++) {
+		block_t addr;
+
+		addr = le32_to_cpu(nat_in_journal(journal, i).block_addr);
+		nid = le32_to_cpu(nid_in_journal(journal, i));
 		if (addr == NULL_ADDR)
 			add_free_nid(sbi, nid, true);
 		else
@@ -1918,16 +1920,16 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
-	struct f2fs_summary_block *sum = curseg->sum_blk;
+	struct f2fs_journal *journal = &curseg->sum_blk->journal;
 	int i;
 
 	mutex_lock(&curseg->curseg_mutex);
-	for (i = 0; i < nats_in_cursum(sum); i++) {
+	for (i = 0; i < nats_in_cursum(journal); i++) {
 		struct nat_entry *ne;
 		struct f2fs_nat_entry raw_ne;
-		nid_t nid = le32_to_cpu(nid_in_journal(sum, i));
+		nid_t nid = le32_to_cpu(nid_in_journal(journal, i));
 
-		raw_ne = nat_in_journal(sum, i);
+		raw_ne = nat_in_journal(journal, i);
 
 		ne = __lookup_nat_cache(nm_i, nid);
 		if (!ne) {
@@ -1936,7 +1938,7 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
 		}
 		__set_nat_cache_dirty(nm_i, ne);
 	}
-	update_nats_in_cursum(sum, -i);
+	update_nats_in_cursum(journal, -i);
 	mutex_unlock(&curseg->curseg_mutex);
 }
 
@@ -1962,7 +1964,7 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 					struct nat_entry_set *set)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
-	struct f2fs_summary_block *sum = curseg->sum_blk;
+	struct f2fs_journal *journal = &curseg->sum_blk->journal;
 	nid_t start_nid = set->set * NAT_ENTRY_PER_BLOCK;
 	bool to_journal = true;
 	struct f2fs_nat_block *nat_blk;
@@ -1974,7 +1976,7 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 	 * #1, flush nat entries to journal in current hot data summary block.
 	 * #2, flush nat entries to nat page.
 	 */
-	if (!__has_cursum_space(sum, set->entry_cnt, NAT_JOURNAL))
+	if (!__has_cursum_space(journal, set->entry_cnt, NAT_JOURNAL))
 		to_journal = false;
 
 	if (to_journal) {
@@ -1995,11 +1997,11 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 			continue;
 
 		if (to_journal) {
-			offset = lookup_journal_in_cursum(sum,
+			offset = lookup_journal_in_cursum(journal,
 							NAT_JOURNAL, nid, 1);
 			f2fs_bug_on(sbi, offset < 0);
-			raw_ne = &nat_in_journal(sum, offset);
-			nid_in_journal(sum, offset) = cpu_to_le32(nid);
+			raw_ne = &nat_in_journal(journal, offset);
+			nid_in_journal(journal, offset) = cpu_to_le32(nid);
 		} else {
 			raw_ne = &nat_blk->entries[nid - start_nid];
 		}
@@ -2028,7 +2030,7 @@ void flush_nat_entries(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
-	struct f2fs_summary_block *sum = curseg->sum_blk;
+	struct f2fs_journal *journal = &curseg->sum_blk->journal;
 	struct nat_entry_set *setvec[SETVEC_SIZE];
 	struct nat_entry_set *set, *tmp;
 	unsigned int found;
@@ -2045,7 +2047,7 @@ void flush_nat_entries(struct f2fs_sb_info *sbi)
 	 * entries, remove all entries from journal and merge them
 	 * into nat entry set.
 	 */
-	if (!__has_cursum_space(sum, nm_i->dirty_nat_cnt, NAT_JOURNAL))
+	if (!__has_cursum_space(journal, nm_i->dirty_nat_cnt, NAT_JOURNAL))
 		remove_nats_in_journal(sbi);
 
 	while ((found = __gang_lookup_nat_set(nm_i,
@@ -2054,7 +2056,7 @@ void flush_nat_entries(struct f2fs_sb_info *sbi)
 		set_idx = setvec[found - 1]->set + 1;
 		for (idx = 0; idx < found; idx++)
 			__adjust_nat_entry_set(setvec[idx], &sets,
-							MAX_NAT_JENTRIES(sum));
+						MAX_NAT_JENTRIES(journal));
 	}
 
 	/* flush dirty nats in nat entry set */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index ad5da89..5902a67 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1539,11 +1539,11 @@ static int read_compacted_summaries(struct f2fs_sb_info *sbi)
 
 	/* Step 1: restore nat cache */
 	seg_i = CURSEG_I(sbi, CURSEG_HOT_DATA);
-	memcpy(&seg_i->sum_blk->n_nats, kaddr, SUM_JOURNAL_SIZE);
+	memcpy(&seg_i->sum_blk->journal.n_nats, kaddr, SUM_JOURNAL_SIZE);
 
 	/* Step 2: restore sit cache */
 	seg_i = CURSEG_I(sbi, CURSEG_COLD_DATA);
-	memcpy(&seg_i->sum_blk->n_sits, kaddr + SUM_JOURNAL_SIZE,
+	memcpy(&seg_i->sum_blk->journal.n_sits, kaddr + SUM_JOURNAL_SIZE,
 						SUM_JOURNAL_SIZE);
 	offset = 2 * SUM_JOURNAL_SIZE;
 
@@ -1695,12 +1695,12 @@ static void write_compacted_summaries(struct f2fs_sb_info *sbi, block_t blkaddr)
 
 	/* Step 1: write nat cache */
 	seg_i = CURSEG_I(sbi, CURSEG_HOT_DATA);
-	memcpy(kaddr, &seg_i->sum_blk->n_nats, SUM_JOURNAL_SIZE);
+	memcpy(kaddr, &seg_i->sum_blk->journal.n_nats, SUM_JOURNAL_SIZE);
 	written_size += SUM_JOURNAL_SIZE;
 
 	/* Step 2: write sit cache */
 	seg_i = CURSEG_I(sbi, CURSEG_COLD_DATA);
-	memcpy(kaddr + written_size, &seg_i->sum_blk->n_sits,
+	memcpy(kaddr + written_size, &seg_i->sum_blk->journal.n_sits,
 						SUM_JOURNAL_SIZE);
 	written_size += SUM_JOURNAL_SIZE;
 
@@ -1768,24 +1768,24 @@ void write_node_summaries(struct f2fs_sb_info *sbi, block_t start_blk)
 	write_normal_summaries(sbi, start_blk, CURSEG_HOT_NODE);
 }
 
-int lookup_journal_in_cursum(struct f2fs_summary_block *sum, int type,
+int lookup_journal_in_cursum(struct f2fs_journal *journal, int type,
 					unsigned int val, int alloc)
 {
 	int i;
 
 	if (type == NAT_JOURNAL) {
-		for (i = 0; i < nats_in_cursum(sum); i++) {
-			if (le32_to_cpu(nid_in_journal(sum, i)) == val)
+		for (i = 0; i < nats_in_cursum(journal); i++) {
+			if (le32_to_cpu(nid_in_journal(journal, i)) == val)
 				return i;
 		}
-		if (alloc && __has_cursum_space(sum, 1, NAT_JOURNAL))
-			return update_nats_in_cursum(sum, 1);
+		if (alloc && __has_cursum_space(journal, 1, NAT_JOURNAL))
+			return update_nats_in_cursum(journal, 1);
 	} else if (type == SIT_JOURNAL) {
-		for (i = 0; i < sits_in_cursum(sum); i++)
-			if (le32_to_cpu(segno_in_journal(sum, i)) == val)
+		for (i = 0; i < sits_in_cursum(journal); i++)
+			if (le32_to_cpu(segno_in_journal(journal, i)) == val)
 				return i;
-		if (alloc && __has_cursum_space(sum, 1, SIT_JOURNAL))
-			return update_sits_in_cursum(sum, 1);
+		if (alloc && __has_cursum_space(journal, 1, SIT_JOURNAL))
+			return update_sits_in_cursum(journal, 1);
 	}
 	return -1;
 }
@@ -1889,20 +1889,20 @@ static void add_sits_in_set(struct f2fs_sb_info *sbi)
 static void remove_sits_in_journal(struct f2fs_sb_info *sbi)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_COLD_DATA);
-	struct f2fs_summary_block *sum = curseg->sum_blk;
+	struct f2fs_journal *journal = &curseg->sum_blk->journal;
 	int i;
 
-	for (i = sits_in_cursum(sum) - 1; i >= 0; i--) {
+	for (i = 0; i < sits_in_cursum(journal); i++) {
 		unsigned int segno;
 		bool dirtied;
 
-		segno = le32_to_cpu(segno_in_journal(sum, i));
+		segno = le32_to_cpu(segno_in_journal(journal, i));
 		dirtied = __mark_sit_entry_dirty(sbi, segno);
 
 		if (!dirtied)
 			add_sit_entry(segno, &SM_I(sbi)->sit_entry_set);
 	}
-	update_sits_in_cursum(sum, -sits_in_cursum(sum));
+	update_sits_in_cursum(journal, -i);
 }
 
 /*
@@ -1914,7 +1914,7 @@ void flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	struct sit_info *sit_i = SIT_I(sbi);
 	unsigned long *bitmap = sit_i->dirty_sentries_bitmap;
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_COLD_DATA);
-	struct f2fs_summary_block *sum = curseg->sum_blk;
+	struct f2fs_journal *journal = &curseg->sum_blk->journal;
 	struct sit_entry_set *ses, *tmp;
 	struct list_head *head = &SM_I(sbi)->sit_entry_set;
 	bool to_journal = true;
@@ -1937,7 +1937,7 @@ void flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	 * entries, remove all entries from journal and add and account
 	 * them in sit entry set.
 	 */
-	if (!__has_cursum_space(sum, sit_i->dirty_sentries, SIT_JOURNAL))
+	if (!__has_cursum_space(journal, sit_i->dirty_sentries, SIT_JOURNAL))
 		remove_sits_in_journal(sbi);
 
 	/*
@@ -1954,7 +1954,7 @@ void flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		unsigned int segno = start_segno;
 
 		if (to_journal &&
-			!__has_cursum_space(sum, ses->entry_cnt, SIT_JOURNAL))
+			!__has_cursum_space(journal, ses->entry_cnt, SIT_JOURNAL))
 			to_journal = false;
 
 		if (!to_journal) {
@@ -1975,13 +1975,13 @@ void flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 			}
 
 			if (to_journal) {
-				offset = lookup_journal_in_cursum(sum,
+				offset = lookup_journal_in_cursum(journal,
 							SIT_JOURNAL, segno, 1);
 				f2fs_bug_on(sbi, offset < 0);
-				segno_in_journal(sum, offset) =
+				segno_in_journal(journal, offset) =
 							cpu_to_le32(segno);
 				seg_info_to_raw_sit(se,
-						&sit_in_journal(sum, offset));
+					&sit_in_journal(journal, offset));
 			} else {
 				sit_offset = SIT_ENTRY_OFFSET(sit_i, segno);
 				seg_info_to_raw_sit(se,
@@ -2150,7 +2150,7 @@ static void build_sit_entries(struct f2fs_sb_info *sbi)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_COLD_DATA);
-	struct f2fs_summary_block *sum = curseg->sum_blk;
+	struct f2fs_journal *journal = &curseg->sum_blk->journal;
 	int sit_blk_cnt = SIT_BLK_CNT(sbi);
 	unsigned int i, start, end;
 	unsigned int readed, start_blk = 0;
@@ -2169,10 +2169,10 @@ static void build_sit_entries(struct f2fs_sb_info *sbi)
 			struct page *page;
 
 			mutex_lock(&curseg->curseg_mutex);
-			for (i = 0; i < sits_in_cursum(sum); i++) {
-				if (le32_to_cpu(segno_in_journal(sum, i))
+			for (i = 0; i < sits_in_cursum(journal); i++) {
+				if (le32_to_cpu(segno_in_journal(journal, i))
 								== start) {
-					sit = sit_in_journal(sum, i);
+					sit = sit_in_journal(journal, i);
 					mutex_unlock(&curseg->curseg_mutex);
 					goto got_it;
 				}
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index fa4bbe0..ecee9ef 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1414,7 +1414,7 @@ try_onemore:
 	seg_i = CURSEG_I(sbi, CURSEG_HOT_NODE);
 	if (__exist_node_summaries(sbi))
 		sbi->kbytes_written =
-			le64_to_cpu(seg_i->sum_blk->info.kbytes_written);
+			le64_to_cpu(seg_i->sum_blk->journal.info.kbytes_written);
 
 	build_gc_manager(sbi);
 
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index f43e6a0..9eb215a 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -398,9 +398,7 @@ struct f2fs_extra_info {
 	__u8 reserved[EXTRA_INFO_RESERVED];
 } __packed;
 
-/* 4KB-sized summary block structure */
-struct f2fs_summary_block {
-	struct f2fs_summary entries[ENTRIES_IN_SUM];
+struct f2fs_journal {
 	union {
 		__le16 n_nats;
 		__le16 n_sits;
@@ -411,6 +409,12 @@ struct f2fs_summary_block {
 		struct sit_journal sit_j;
 		struct f2fs_extra_info info;
 	};
+} __packed;
+
+/* 4KB-sized summary block structure */
+struct f2fs_summary_block {
+	struct f2fs_summary entries[ENTRIES_IN_SUM];
+	struct f2fs_journal journal;
 	struct summary_footer footer;
 } __packed;
 
-- 
2.7.0.2.g1b0b6dd



------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
