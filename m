From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/4] f2fs: clean up some macros in terms of
	GET_SEGNO
Date: Mon, 10 Apr 2017 17:13:07 -0700
Message-ID: <20170411001308.12881-3-jaegeuk@kernel.org>
References: <20170411001308.12881-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cxjR5-0007aR-3E
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Apr 2017 00:13:31 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cxjR3-0001hj-Na
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Apr 2017 00:13:31 +0000
In-Reply-To: <20170411001308.12881-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch cleans several macros by introducing:
- BLKS_PER_SEC
- GET_SEC_FROM_SEG
- GET_SEG_FROM_SEC
- GET_ZONE_FROM_SEC
- GET_ZONE_FROM_SEG

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/debug.c   |  6 +++---
 fs/f2fs/f2fs.h    |  7 +++----
 fs/f2fs/file.c    |  3 +--
 fs/f2fs/gc.c      | 17 ++++++++---------
 fs/f2fs/segment.c | 20 ++++++++++----------
 fs/f2fs/segment.h | 34 ++++++++++++++++++++--------------
 6 files changed, 45 insertions(+), 42 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index dc16a52db275..692beff66bf8 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -109,8 +109,8 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	for (i = CURSEG_HOT_DATA; i <= CURSEG_COLD_NODE; i++) {
 		struct curseg_info *curseg = CURSEG_I(sbi, i);
 		si->curseg[i] = curseg->segno;
-		si->cursec[i] = curseg->segno / sbi->segs_per_sec;
-		si->curzone[i] = si->cursec[i] / sbi->secs_per_zone;
+		si->cursec[i] = GET_SEC_FROM_SEG(sbi, curseg->segno);
+		si->curzone[i] = GET_ZONE_FROM_SEC(sbi, si->cursec[i]);
 	}
 
 	for (i = 0; i < 2; i++) {
@@ -134,7 +134,7 @@ static void update_sit_info(struct f2fs_sb_info *sbi)
 
 	bimodal = 0;
 	total_vblocks = 0;
-	blks_per_sec = sbi->segs_per_sec * sbi->blocks_per_seg;
+	blks_per_sec = BLKS_PER_SEC(sbi);
 	hblks_per_sec = blks_per_sec / 2;
 	for (segno = 0; segno < MAIN_SEGS(sbi); segno += sbi->segs_per_sec) {
 		vblocks = get_valid_blocks(sbi, segno, true);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b5846c086e7d..562db8989a4e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -135,12 +135,11 @@ enum {
 
 #define DEF_BATCHED_TRIM_SECTIONS	2048
 #define BATCHED_TRIM_SEGMENTS(sbi)	\
-		(SM_I(sbi)->trim_sections * (sbi)->segs_per_sec)
+		(GET_SEG_FROM_SEC(sbi, SM_I(sbi)->trim_sections))
 #define BATCHED_TRIM_BLOCKS(sbi)	\
 		(BATCHED_TRIM_SEGMENTS(sbi) << (sbi)->log_blocks_per_seg)
-#define MAX_DISCARD_BLOCKS(sbi)						\
-		((1 << (sbi)->log_blocks_per_seg) * (sbi)->segs_per_sec)
-#define DISCARD_ISSUE_RATE	8
+#define MAX_DISCARD_BLOCKS(sbi)		BLKS_PER_SEC(sbi)
+#define DISCARD_ISSUE_RATE		8
 #define DEF_CP_INTERVAL			60	/* 60 secs */
 #define DEF_IDLE_INTERVAL		5	/* 5 secs */
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f3be240ef129..4731eb587e06 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1892,7 +1892,6 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 	pgoff_t pg_start, pg_end;
 	unsigned int blk_per_seg = sbi->blocks_per_seg;
 	unsigned int total = 0, sec_num;
-	unsigned int pages_per_sec = sbi->segs_per_sec * blk_per_seg;
 	block_t blk_end = 0;
 	bool fragmented = false;
 	int err;
@@ -1956,7 +1955,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 	map.m_lblk = pg_start;
 	map.m_len = pg_end - pg_start;
 
-	sec_num = (map.m_len + pages_per_sec - 1) / pages_per_sec;
+	sec_num = (map.m_len + BLKS_PER_SEC(sbi) - 1) / BLKS_PER_SEC(sbi);
 
 	/*
 	 * make sure there are enough free section for LFS allocation, this can
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 439887c3aaf4..e2f9b2b12b74 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -211,7 +211,7 @@ static unsigned int check_bg_victims(struct f2fs_sb_info *sbi)
 			continue;
 
 		clear_bit(secno, dirty_i->victim_secmap);
-		return secno * sbi->segs_per_sec;
+		return GET_SEG_FROM_SEC(sbi, secno);
 	}
 	return NULL_SEGNO;
 }
@@ -219,8 +219,8 @@ static unsigned int check_bg_victims(struct f2fs_sb_info *sbi)
 static unsigned int get_cb_cost(struct f2fs_sb_info *sbi, unsigned int segno)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
-	unsigned int secno = GET_SECNO(sbi, segno);
-	unsigned int start = secno * sbi->segs_per_sec;
+	unsigned int secno = GET_SEC_FROM_SEG(sbi, segno);
+	unsigned int start = GET_SEG_FROM_SEC(sbi, secno);
 	unsigned long long mtime = 0;
 	unsigned int vblocks;
 	unsigned char age = 0;
@@ -343,7 +343,7 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 			nsearched++;
 		}
 
-		secno = GET_SECNO(sbi, segno);
+		secno = GET_SEC_FROM_SEG(sbi, segno);
 
 		if (sec_usage_check(sbi, secno))
 			goto next;
@@ -372,7 +372,7 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 	if (p.min_segno != NULL_SEGNO) {
 got_it:
 		if (p.alloc_mode == LFS) {
-			secno = GET_SECNO(sbi, p.min_segno);
+			secno = GET_SEC_FROM_SEG(sbi, p.min_segno);
 			if (gc_type == FG_GC)
 				sbi->cur_victim_sec = secno;
 			else
@@ -1006,7 +1006,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync, bool background)
 
 void build_gc_manager(struct f2fs_sb_info *sbi)
 {
-	u64 main_count, resv_count, ovp_count, blocks_per_sec;
+	u64 main_count, resv_count, ovp_count;
 
 	DIRTY_I(sbi)->v_ops = &default_v_ops;
 
@@ -1014,8 +1014,7 @@ void build_gc_manager(struct f2fs_sb_info *sbi)
 	main_count = SM_I(sbi)->main_segments << sbi->log_blocks_per_seg;
 	resv_count = SM_I(sbi)->reserved_segments << sbi->log_blocks_per_seg;
 	ovp_count = SM_I(sbi)->ovp_segments << sbi->log_blocks_per_seg;
-	blocks_per_sec = sbi->blocks_per_seg * sbi->segs_per_sec;
 
-	sbi->fggc_threshold = div64_u64((main_count - ovp_count) * blocks_per_sec,
-					(main_count - resv_count));
+	sbi->fggc_threshold = div64_u64((main_count - ovp_count) *
+				BLKS_PER_SEC(sbi), (main_count - resv_count));
 }
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index ae8331802d05..471ea9944412 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -637,7 +637,7 @@ static void __remove_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
 			dirty_i->nr_dirty[t]--;
 
 		if (get_valid_blocks(sbi, segno, true) == 0)
-			clear_bit(GET_SECNO(sbi, segno),
+			clear_bit(GET_SEC_FROM_SEG(sbi, segno),
 						dirty_i->victim_secmap);
 	}
 }
@@ -1106,8 +1106,8 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 			continue;
 		}
 next:
-		secno = GET_SECNO(sbi, start);
-		start_segno = secno * sbi->segs_per_sec;
+		secno = GET_SEC_FROM_SEG(sbi, start);
+		start_segno = GET_SEG_FROM_SEC(sbi, secno);
 		if (!IS_CURSEC(sbi, secno) &&
 			!get_valid_blocks(sbi, start, true))
 			f2fs_issue_discard(sbi, START_BLOCK(sbi, start_segno),
@@ -1462,8 +1462,8 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
 	struct free_segmap_info *free_i = FREE_I(sbi);
 	unsigned int segno, secno, zoneno;
 	unsigned int total_zones = MAIN_SECS(sbi) / sbi->secs_per_zone;
-	unsigned int hint = *newseg / sbi->segs_per_sec;
-	unsigned int old_zoneno = GET_ZONENO_FROM_SEGNO(sbi, *newseg);
+	unsigned int hint = GET_SEC_FROM_SEG(sbi, *newseg);
+	unsigned int old_zoneno = GET_ZONE_FROM_SEG(sbi, *newseg);
 	unsigned int left_start = hint;
 	bool init = true;
 	int go_left = 0;
@@ -1473,8 +1473,8 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
 
 	if (!new_sec && ((*newseg + 1) % sbi->segs_per_sec)) {
 		segno = find_next_zero_bit(free_i->free_segmap,
-				(hint + 1) * sbi->segs_per_sec, *newseg + 1);
-		if (segno < (hint + 1) * sbi->segs_per_sec)
+			GET_SEG_FROM_SEC(sbi, hint + 1), *newseg + 1);
+		if (segno < GET_SEG_FROM_SEC(sbi, hint + 1))
 			goto got_it;
 	}
 find_other_zone:
@@ -1505,8 +1505,8 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
 	secno = left_start;
 skip_left:
 	hint = secno;
-	segno = secno * sbi->segs_per_sec;
-	zoneno = secno / sbi->secs_per_zone;
+	segno = GET_SEG_FROM_SEC(sbi, secno);
+	zoneno = GET_ZONE_FROM_SEC(sbi, secno);
 
 	/* give up on finding another zone */
 	if (!init)
@@ -1550,7 +1550,7 @@ static void reset_curseg(struct f2fs_sb_info *sbi, int type, int modified)
 	struct summary_footer *sum_footer;
 
 	curseg->segno = curseg->next_segno;
-	curseg->zone = GET_ZONENO_FROM_SEGNO(sbi, curseg->segno);
+	curseg->zone = GET_ZONE_FROM_SEG(sbi, curseg->segno);
 	curseg->next_blkoff = 0;
 	curseg->next_segno = NULL_SEGNO;
 
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 053166038bfe..5f6ef163aa8f 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -78,12 +78,16 @@
 	((((blk_addr) == NULL_ADDR) || ((blk_addr) == NEW_ADDR)) ?	\
 	NULL_SEGNO : GET_L2R_SEGNO(FREE_I(sbi),			\
 		GET_SEGNO_FROM_SEG0(sbi, blk_addr)))
-#define GET_SECNO(sbi, segno)					\
+#define BLKS_PER_SEC(sbi)					\
+	((sbi)->segs_per_sec * (sbi)->blocks_per_seg)
+#define GET_SEC_FROM_SEG(sbi, segno)				\
 	((segno) / (sbi)->segs_per_sec)
-#define GET_SEGNO_FROM_SECNO(sbi, secno)				\
+#define GET_SEG_FROM_SEC(sbi, secno)				\
 	((secno) * (sbi)->segs_per_sec)
-#define GET_ZONENO_FROM_SEGNO(sbi, segno)				\
-	(((segno) / (sbi)->segs_per_sec) / (sbi)->secs_per_zone)
+#define GET_ZONE_FROM_SEC(sbi, secno)				\
+	((secno) / (sbi)->secs_per_zone)
+#define GET_ZONE_FROM_SEG(sbi, segno)				\
+	GET_ZONE_FROM_SEC(sbi, GET_SEC_FROM_SEG(sbi, segno))
 
 #define GET_SUM_BLOCK(sbi, segno)				\
 	((sbi)->sm_info->ssa_blkaddr + (segno))
@@ -305,7 +309,7 @@ static inline struct sec_entry *get_sec_entry(struct f2fs_sb_info *sbi,
 						unsigned int segno)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
-	return &sit_i->sec_entries[GET_SECNO(sbi, segno)];
+	return &sit_i->sec_entries[GET_SEC_FROM_SEG(sbi, segno)];
 }
 
 static inline unsigned int get_valid_blocks(struct f2fs_sb_info *sbi,
@@ -360,8 +364,8 @@ static inline unsigned int find_next_inuse(struct free_segmap_info *free_i,
 static inline void __set_free(struct f2fs_sb_info *sbi, unsigned int segno)
 {
 	struct free_segmap_info *free_i = FREE_I(sbi);
-	unsigned int secno = segno / sbi->segs_per_sec;
-	unsigned int start_segno = secno * sbi->segs_per_sec;
+	unsigned int secno = GET_SEC_FROM_SEG(sbi, segno);
+	unsigned int start_segno = GET_SEG_FROM_SEC(sbi, secno);
 	unsigned int next;
 
 	spin_lock(&free_i->segmap_lock);
@@ -381,7 +385,8 @@ static inline void __set_inuse(struct f2fs_sb_info *sbi,
 		unsigned int segno)
 {
 	struct free_segmap_info *free_i = FREE_I(sbi);
-	unsigned int secno = segno / sbi->segs_per_sec;
+	unsigned int secno = GET_SEC_FROM_SEG(sbi, segno);
+
 	set_bit(segno, free_i->free_segmap);
 	free_i->free_segments--;
 	if (!test_and_set_bit(secno, free_i->free_secmap))
@@ -392,8 +397,8 @@ static inline void __set_test_and_free(struct f2fs_sb_info *sbi,
 		unsigned int segno)
 {
 	struct free_segmap_info *free_i = FREE_I(sbi);
-	unsigned int secno = segno / sbi->segs_per_sec;
-	unsigned int start_segno = secno * sbi->segs_per_sec;
+	unsigned int secno = GET_SEC_FROM_SEG(sbi, segno);
+	unsigned int start_segno = GET_SEG_FROM_SEC(sbi, secno);
 	unsigned int next;
 
 	spin_lock(&free_i->segmap_lock);
@@ -414,7 +419,8 @@ static inline void __set_test_and_inuse(struct f2fs_sb_info *sbi,
 		unsigned int segno)
 {
 	struct free_segmap_info *free_i = FREE_I(sbi);
-	unsigned int secno = segno / sbi->segs_per_sec;
+	unsigned int secno = GET_SEC_FROM_SEG(sbi, segno);
+
 	spin_lock(&free_i->segmap_lock);
 	if (!test_and_set_bit(segno, free_i->free_segmap)) {
 		free_i->free_segments--;
@@ -479,12 +485,12 @@ static inline int overprovision_segments(struct f2fs_sb_info *sbi)
 
 static inline int overprovision_sections(struct f2fs_sb_info *sbi)
 {
-	return ((unsigned int) overprovision_segments(sbi)) / sbi->segs_per_sec;
+	return GET_SEC_FROM_SEG(sbi, (unsigned int)overprovision_segments(sbi));
 }
 
 static inline int reserved_sections(struct f2fs_sb_info *sbi)
 {
-	return ((unsigned int) reserved_segments(sbi)) / sbi->segs_per_sec;
+	return GET_SEC_FROM_SEG(sbi, (unsigned int)reserved_segments(sbi));
 }
 
 static inline bool need_SSR(struct f2fs_sb_info *sbi)
@@ -722,7 +728,7 @@ static inline block_t sum_blk_addr(struct f2fs_sb_info *sbi, int base, int type)
 static inline bool no_fggc_candidate(struct f2fs_sb_info *sbi,
 						unsigned int secno)
 {
-	if (get_valid_blocks(sbi, GET_SEGNO_FROM_SECNO(sbi, secno), true) >=
+	if (get_valid_blocks(sbi, GET_SEG_FROM_SEC(sbi, secno), true) >=
 						sbi->fggc_threshold)
 		return true;
 	return false;
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
