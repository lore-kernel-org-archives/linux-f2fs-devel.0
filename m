From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/7] f2fs: split journal cache from curseg cache
Date: Sun, 14 Feb 2016 18:51:41 +0800
Message-ID: <00fb01d16715$c7388800$55a99800$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

In curseg cache, f2fs cached two different parts:
 - datas of current summay block
 - journal info consist of sparse nat/sit entries
And we use the same curseg_mutex lock to protect these two caches.

With this approach, on the one hand, it may cause higher lock contention
when accessing/updating one of two parts of cache since we use the same
lock curseg_mutex to avoid contention. On the other hand, for now, journal
info was cached in current summary block after ->mount or last checkpoint,
so these junk journals could be writebacked into most summary blocks, it
wastes remained space of summary block.

So, in order to fix above issues, we split curseg cache into two parts:
a) journal cache, protected by r/w semaphore journal_rwsem
b) current summary block, protected by mutex lock curseg_mutex

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/checkpoint.c |  2 +-
 fs/f2fs/node.c       | 26 ++++++++--------
 fs/f2fs/segment.c    | 85 +++++++++++++++++++++++++++++++++++++---------------
 fs/f2fs/segment.h    |  2 ++
 4 files changed, 77 insertions(+), 38 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 3cdcdaf..c6d4259 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1051,7 +1051,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	if (sb->s_bdev->bd_part)
 		kbytes_written += BD_PART_WRITTEN(sbi);
 
-	seg_i->sum_blk->journal.info.kbytes_written = cpu_to_le64(kbytes_written);
+	seg_i->journal->info.kbytes_written = cpu_to_le64(kbytes_written);
 
 	if (__remain_node_summaries(cpc->reason)) {
 		write_node_summaries(sbi, start_blk);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 8230e35..94b8016 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -354,7 +354,7 @@ void get_node_info(struct f2fs_sb_info *sbi, nid_t nid, struct node_info *ni)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
-	struct f2fs_journal *journal = &curseg->sum_blk->journal;
+	struct f2fs_journal *journal = curseg->journal;
 	nid_t start_nid = START_NID(nid);
 	struct f2fs_nat_block *nat_blk;
 	struct page *page = NULL;
@@ -381,13 +381,13 @@ void get_node_info(struct f2fs_sb_info *sbi, nid_t nid, struct node_info *ni)
 	down_write(&nm_i->nat_tree_lock);
 
 	/* Check current segment summary */
-	mutex_lock(&curseg->curseg_mutex);
+	down_read(&curseg->journal_rwsem);
 	i = lookup_journal_in_cursum(journal, NAT_JOURNAL, nid, 0);
 	if (i >= 0) {
 		ne = nat_in_journal(journal, i);
 		node_info_from_raw_nat(ni, &ne);
 	}
-	mutex_unlock(&curseg->curseg_mutex);
+	up_read(&curseg->journal_rwsem);
 	if (i >= 0)
 		goto cache;
 
@@ -1613,7 +1613,7 @@ static void build_free_nids(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
-	struct f2fs_journal *journal = &curseg->sum_blk->journal;
+	struct f2fs_journal *journal = curseg->journal;
 	int i = 0;
 	nid_t nid = nm_i->next_scan_nid;
 
@@ -1645,7 +1645,7 @@ static void build_free_nids(struct f2fs_sb_info *sbi)
 	nm_i->next_scan_nid = nid;
 
 	/* find free nids from current sum_pages */
-	mutex_lock(&curseg->curseg_mutex);
+	down_read(&curseg->journal_rwsem);
 	for (i = 0; i < nats_in_cursum(journal); i++) {
 		block_t addr;
 
@@ -1656,7 +1656,7 @@ static void build_free_nids(struct f2fs_sb_info *sbi)
 		else
 			remove_free_nid(nm_i, nid);
 	}
-	mutex_unlock(&curseg->curseg_mutex);
+	up_read(&curseg->journal_rwsem);
 	up_read(&nm_i->nat_tree_lock);
 
 	ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nm_i->next_scan_nid),
@@ -1920,10 +1920,10 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
-	struct f2fs_journal *journal = &curseg->sum_blk->journal;
+	struct f2fs_journal *journal = curseg->journal;
 	int i;
 
-	mutex_lock(&curseg->curseg_mutex);
+	down_write(&curseg->journal_rwsem);
 	for (i = 0; i < nats_in_cursum(journal); i++) {
 		struct nat_entry *ne;
 		struct f2fs_nat_entry raw_ne;
@@ -1939,7 +1939,7 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
 		__set_nat_cache_dirty(nm_i, ne);
 	}
 	update_nats_in_cursum(journal, -i);
-	mutex_unlock(&curseg->curseg_mutex);
+	up_write(&curseg->journal_rwsem);
 }
 
 static void __adjust_nat_entry_set(struct nat_entry_set *nes,
@@ -1964,7 +1964,7 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 					struct nat_entry_set *set)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
-	struct f2fs_journal *journal = &curseg->sum_blk->journal;
+	struct f2fs_journal *journal = curseg->journal;
 	nid_t start_nid = set->set * NAT_ENTRY_PER_BLOCK;
 	bool to_journal = true;
 	struct f2fs_nat_block *nat_blk;
@@ -1980,7 +1980,7 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 		to_journal = false;
 
 	if (to_journal) {
-		mutex_lock(&curseg->curseg_mutex);
+		down_write(&curseg->journal_rwsem);
 	} else {
 		page = get_next_nat_page(sbi, start_nid);
 		nat_blk = page_address(page);
@@ -2013,7 +2013,7 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 	}
 
 	if (to_journal)
-		mutex_unlock(&curseg->curseg_mutex);
+		up_write(&curseg->journal_rwsem);
 	else
 		f2fs_put_page(page, 1);
 
@@ -2030,7 +2030,7 @@ void flush_nat_entries(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
-	struct f2fs_journal *journal = &curseg->sum_blk->journal;
+	struct f2fs_journal *journal = curseg->journal;
 	struct nat_entry_set *setvec[SETVEC_SIZE];
 	struct nat_entry_set *set, *tmp;
 	unsigned int found;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 5902a67..7cb9a54 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -917,6 +917,31 @@ static void write_sum_page(struct f2fs_sb_info *sbi,
 	update_meta_page(sbi, (void *)sum_blk, blk_addr);
 }
 
+static void write_current_sum_page(struct f2fs_sb_info *sbi,
+						int type, block_t blk_addr)
+{
+	struct curseg_info *curseg = CURSEG_I(sbi, type);
+	struct page *page = grab_meta_page(sbi, blk_addr);
+	struct f2fs_summary_block *src = curseg->sum_blk;
+	struct f2fs_summary_block *dst;
+
+	dst = (struct f2fs_summary_block *)page_address(page);
+
+	mutex_lock(&curseg->curseg_mutex);
+
+	down_read(&curseg->journal_rwsem);
+	memcpy(&dst->journal, curseg->journal, SUM_JOURNAL_SIZE);
+	up_read(&curseg->journal_rwsem);
+
+	memcpy(dst->entries, src->entries, SUM_ENTRY_SIZE);
+	memcpy(&dst->footer, &src->footer, SUM_FOOTER_SIZE);
+
+	mutex_unlock(&curseg->curseg_mutex);
+
+	set_page_dirty(page);
+	f2fs_put_page(page, 1);
+}
+
 static int is_next_segment_free(struct f2fs_sb_info *sbi, int type)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
@@ -1539,12 +1564,11 @@ static int read_compacted_summaries(struct f2fs_sb_info *sbi)
 
 	/* Step 1: restore nat cache */
 	seg_i = CURSEG_I(sbi, CURSEG_HOT_DATA);
-	memcpy(&seg_i->sum_blk->journal.n_nats, kaddr, SUM_JOURNAL_SIZE);
+	memcpy(seg_i->journal, kaddr, SUM_JOURNAL_SIZE);
 
 	/* Step 2: restore sit cache */
 	seg_i = CURSEG_I(sbi, CURSEG_COLD_DATA);
-	memcpy(&seg_i->sum_blk->journal.n_sits, kaddr + SUM_JOURNAL_SIZE,
-						SUM_JOURNAL_SIZE);
+	memcpy(seg_i->journal, kaddr + SUM_JOURNAL_SIZE, SUM_JOURNAL_SIZE);
 	offset = 2 * SUM_JOURNAL_SIZE;
 
 	/* Step 3: restore summary entries */
@@ -1640,7 +1664,14 @@ static int read_normal_summaries(struct f2fs_sb_info *sbi, int type)
 	/* set uncompleted segment to curseg */
 	curseg = CURSEG_I(sbi, type);
 	mutex_lock(&curseg->curseg_mutex);
-	memcpy(curseg->sum_blk, sum, PAGE_CACHE_SIZE);
+
+	/* update journal info */
+	down_write(&curseg->journal_rwsem);
+	memcpy(curseg->journal, &sum->journal, SUM_JOURNAL_SIZE);
+	up_write(&curseg->journal_rwsem);
+
+	memcpy(curseg->sum_blk->entries, sum->entries, SUM_ENTRY_SIZE);
+	memcpy(&curseg->sum_blk->footer, &sum->footer, SUM_FOOTER_SIZE);
 	curseg->next_segno = segno;
 	reset_curseg(sbi, type, 0);
 	curseg->alloc_type = ckpt->alloc_type[type];
@@ -1695,13 +1726,12 @@ static void write_compacted_summaries(struct f2fs_sb_info *sbi, block_t blkaddr)
 
 	/* Step 1: write nat cache */
 	seg_i = CURSEG_I(sbi, CURSEG_HOT_DATA);
-	memcpy(kaddr, &seg_i->sum_blk->journal.n_nats, SUM_JOURNAL_SIZE);
+	memcpy(kaddr, seg_i->journal, SUM_JOURNAL_SIZE);
 	written_size += SUM_JOURNAL_SIZE;
 
 	/* Step 2: write sit cache */
 	seg_i = CURSEG_I(sbi, CURSEG_COLD_DATA);
-	memcpy(kaddr + written_size, &seg_i->sum_blk->journal.n_sits,
-						SUM_JOURNAL_SIZE);
+	memcpy(kaddr + written_size, seg_i->journal, SUM_JOURNAL_SIZE);
 	written_size += SUM_JOURNAL_SIZE;
 
 	/* Step 3: write summary entries */
@@ -1747,12 +1777,8 @@ static void write_normal_summaries(struct f2fs_sb_info *sbi,
 	else
 		end = type + NR_CURSEG_NODE_TYPE;
 
-	for (i = type; i < end; i++) {
-		struct curseg_info *sum = CURSEG_I(sbi, i);
-		mutex_lock(&sum->curseg_mutex);
-		write_sum_page(sbi, sum->sum_blk, blkaddr + (i - type));
-		mutex_unlock(&sum->curseg_mutex);
-	}
+	for (i = type; i < end; i++)
+		write_current_sum_page(sbi, i, blkaddr + (i - type));
 }
 
 void write_data_summaries(struct f2fs_sb_info *sbi, block_t start_blk)
@@ -1889,9 +1915,10 @@ static void add_sits_in_set(struct f2fs_sb_info *sbi)
 static void remove_sits_in_journal(struct f2fs_sb_info *sbi)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_COLD_DATA);
-	struct f2fs_journal *journal = &curseg->sum_blk->journal;
+	struct f2fs_journal *journal = curseg->journal;
 	int i;
 
+	down_write(&curseg->journal_rwsem);
 	for (i = 0; i < sits_in_cursum(journal); i++) {
 		unsigned int segno;
 		bool dirtied;
@@ -1903,6 +1930,7 @@ static void remove_sits_in_journal(struct f2fs_sb_info *sbi)
 			add_sit_entry(segno, &SM_I(sbi)->sit_entry_set);
 	}
 	update_sits_in_cursum(journal, -i);
+	up_write(&curseg->journal_rwsem);
 }
 
 /*
@@ -1914,13 +1942,12 @@ void flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	struct sit_info *sit_i = SIT_I(sbi);
 	unsigned long *bitmap = sit_i->dirty_sentries_bitmap;
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_COLD_DATA);
-	struct f2fs_journal *journal = &curseg->sum_blk->journal;
+	struct f2fs_journal *journal = curseg->journal;
 	struct sit_entry_set *ses, *tmp;
 	struct list_head *head = &SM_I(sbi)->sit_entry_set;
 	bool to_journal = true;
 	struct seg_entry *se;
 
-	mutex_lock(&curseg->curseg_mutex);
 	mutex_lock(&sit_i->sentry_lock);
 
 	if (!sit_i->dirty_sentries)
@@ -1957,7 +1984,9 @@ void flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 			!__has_cursum_space(journal, ses->entry_cnt, SIT_JOURNAL))
 			to_journal = false;
 
-		if (!to_journal) {
+		if (to_journal) {
+			down_write(&curseg->journal_rwsem);
+		} else {
 			page = get_next_sit_page(sbi, start_segno);
 			raw_sit = page_address(page);
 		}
@@ -1993,7 +2022,9 @@ void flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 			ses->entry_cnt--;
 		}
 
-		if (!to_journal)
+		if (to_journal)
+			up_write(&curseg->journal_rwsem);
+		else
 			f2fs_put_page(page, 1);
 
 		f2fs_bug_on(sbi, ses->entry_cnt);
@@ -2008,7 +2039,6 @@ out:
 			add_discard_addrs(sbi, cpc);
 	}
 	mutex_unlock(&sit_i->sentry_lock);
-	mutex_unlock(&curseg->curseg_mutex);
 
 	set_prefree_as_free_segments(sbi);
 }
@@ -2140,6 +2170,11 @@ static int build_curseg(struct f2fs_sb_info *sbi)
 		array[i].sum_blk = kzalloc(PAGE_CACHE_SIZE, GFP_KERNEL);
 		if (!array[i].sum_blk)
 			return -ENOMEM;
+		init_rwsem(&array[i].journal_rwsem);
+		array[i].journal = kzalloc(sizeof(struct f2fs_journal),
+							GFP_KERNEL);
+		if (!array[i].journal)
+			return -ENOMEM;
 		array[i].segno = NULL_SEGNO;
 		array[i].next_blkoff = 0;
 	}
@@ -2150,7 +2185,7 @@ static void build_sit_entries(struct f2fs_sb_info *sbi)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_COLD_DATA);
-	struct f2fs_journal *journal = &curseg->sum_blk->journal;
+	struct f2fs_journal *journal = curseg->journal;
 	int sit_blk_cnt = SIT_BLK_CNT(sbi);
 	unsigned int i, start, end;
 	unsigned int readed, start_blk = 0;
@@ -2168,16 +2203,16 @@ static void build_sit_entries(struct f2fs_sb_info *sbi)
 			struct f2fs_sit_entry sit;
 			struct page *page;
 
-			mutex_lock(&curseg->curseg_mutex);
+			down_read(&curseg->journal_rwsem);
 			for (i = 0; i < sits_in_cursum(journal); i++) {
 				if (le32_to_cpu(segno_in_journal(journal, i))
 								== start) {
 					sit = sit_in_journal(journal, i);
-					mutex_unlock(&curseg->curseg_mutex);
+					up_read(&curseg->journal_rwsem);
 					goto got_it;
 				}
 			}
-			mutex_unlock(&curseg->curseg_mutex);
+			up_read(&curseg->journal_rwsem);
 
 			page = get_current_sit_page(sbi, start);
 			sit_blk = (struct f2fs_sit_block *)page_address(page);
@@ -2412,8 +2447,10 @@ static void destroy_curseg(struct f2fs_sb_info *sbi)
 	if (!array)
 		return;
 	SM_I(sbi)->curseg_array = NULL;
-	for (i = 0; i < NR_CURSEG_TYPE; i++)
+	for (i = 0; i < NR_CURSEG_TYPE; i++) {
 		kfree(array[i].sum_blk);
+		kfree(array[i].journal);
+	}
 	kfree(array);
 }
 
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 2f1a422..975c33d 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -258,6 +258,8 @@ struct victim_selection {
 struct curseg_info {
 	struct mutex curseg_mutex;		/* lock for consistency */
 	struct f2fs_summary_block *sum_blk;	/* cached summary block */
+	struct rw_semaphore journal_rwsem;	/* protect journal area */
+	struct f2fs_journal *journal;		/* cached journal info */
 	unsigned char alloc_type;		/* current allocation type */
 	unsigned int segno;			/* current segment number */
 	unsigned short next_blkoff;		/* next block offset to write */
-- 
2.7.0.2.g1b0b6dd
