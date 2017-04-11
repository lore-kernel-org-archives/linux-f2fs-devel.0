From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/4] f2fs: clean up get_valid_blocks with
	consistent parameter
Date: Mon, 10 Apr 2017 17:13:06 -0700
Message-ID: <20170411001308.12881-2-jaegeuk@kernel.org>
References: <20170411001308.12881-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cxjR2-0006SC-Qy
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Apr 2017 00:13:28 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cxjR1-0001hH-MN
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Apr 2017 00:13:28 +0000
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

This patch cleans up get_valid_blocks, which has no functional change.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/debug.c   | 2 +-
 fs/f2fs/gc.c      | 8 ++++----
 fs/f2fs/segment.c | 8 ++++----
 fs/f2fs/segment.h | 8 ++++----
 fs/f2fs/super.c   | 4 ++--
 5 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 906f627e44fc..dc16a52db275 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -137,7 +137,7 @@ static void update_sit_info(struct f2fs_sb_info *sbi)
 	blks_per_sec = sbi->segs_per_sec * sbi->blocks_per_seg;
 	hblks_per_sec = blks_per_sec / 2;
 	for (segno = 0; segno < MAIN_SEGS(sbi); segno += sbi->segs_per_sec) {
-		vblocks = get_valid_blocks(sbi, segno, sbi->segs_per_sec);
+		vblocks = get_valid_blocks(sbi, segno, true);
 		dist = abs(vblocks - hblks_per_sec);
 		bimodal += dist * dist;
 
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index c52656ccbde5..439887c3aaf4 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -229,7 +229,7 @@ static unsigned int get_cb_cost(struct f2fs_sb_info *sbi, unsigned int segno)
 
 	for (i = 0; i < sbi->segs_per_sec; i++)
 		mtime += get_seg_entry(sbi, start + i)->mtime;
-	vblocks = get_valid_blocks(sbi, segno, sbi->segs_per_sec);
+	vblocks = get_valid_blocks(sbi, segno, true);
 
 	mtime = div_u64(mtime, sbi->segs_per_sec);
 	vblocks = div_u64(vblocks, sbi->segs_per_sec);
@@ -252,7 +252,7 @@ static unsigned int get_greedy_cost(struct f2fs_sb_info *sbi,
 						unsigned int segno)
 {
 	unsigned int valid_blocks =
-			get_valid_blocks(sbi, segno, sbi->segs_per_sec);
+			get_valid_blocks(sbi, segno, true);
 
 	return IS_DATASEG(get_seg_entry(sbi, segno)->type) ?
 				valid_blocks * 2 : valid_blocks;
@@ -897,7 +897,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 					GET_SUM_BLOCK(sbi, segno));
 		f2fs_put_page(sum_page, 0);
 
-		if (get_valid_blocks(sbi, segno, 1) == 0 ||
+		if (get_valid_blocks(sbi, segno, false) == 0 ||
 				!PageUptodate(sum_page) ||
 				unlikely(f2fs_cp_error(sbi)))
 			goto next;
@@ -931,7 +931,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 	blk_finish_plug(&plug);
 
 	if (gc_type == FG_GC &&
-		get_valid_blocks(sbi, start_segno, sbi->segs_per_sec) == 0)
+		get_valid_blocks(sbi, start_segno, true) == 0)
 		sec_freed = 1;
 
 	stat_inc_call_count(sbi->stat_info);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index dca693c16f07..ae8331802d05 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -636,7 +636,7 @@ static void __remove_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
 		if (test_and_clear_bit(segno, dirty_i->dirty_segmap[t]))
 			dirty_i->nr_dirty[t]--;
 
-		if (get_valid_blocks(sbi, segno, sbi->segs_per_sec) == 0)
+		if (get_valid_blocks(sbi, segno, true) == 0)
 			clear_bit(GET_SECNO(sbi, segno),
 						dirty_i->victim_secmap);
 	}
@@ -657,7 +657,7 @@ static void locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno)
 
 	mutex_lock(&dirty_i->seglist_lock);
 
-	valid_blocks = get_valid_blocks(sbi, segno, 0);
+	valid_blocks = get_valid_blocks(sbi, segno, false);
 
 	if (valid_blocks == 0) {
 		__locate_dirty_segment(sbi, segno, PRE);
@@ -1109,7 +1109,7 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		secno = GET_SECNO(sbi, start);
 		start_segno = secno * sbi->segs_per_sec;
 		if (!IS_CURSEC(sbi, secno) &&
-			!get_valid_blocks(sbi, start, sbi->segs_per_sec))
+			!get_valid_blocks(sbi, start, true))
 			f2fs_issue_discard(sbi, START_BLOCK(sbi, start_segno),
 				sbi->segs_per_sec << sbi->log_blocks_per_seg);
 
@@ -2859,7 +2859,7 @@ static void init_dirty_segmap(struct f2fs_sb_info *sbi)
 		if (segno >= MAIN_SEGS(sbi))
 			break;
 		offset = segno + 1;
-		valid_blocks = get_valid_blocks(sbi, segno, 0);
+		valid_blocks = get_valid_blocks(sbi, segno, false);
 		if (valid_blocks == sbi->blocks_per_seg || !valid_blocks)
 			continue;
 		if (valid_blocks > sbi->blocks_per_seg) {
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 39ef9cc0093b..053166038bfe 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -309,13 +309,13 @@ static inline struct sec_entry *get_sec_entry(struct f2fs_sb_info *sbi,
 }
 
 static inline unsigned int get_valid_blocks(struct f2fs_sb_info *sbi,
-				unsigned int segno, int section)
+				unsigned int segno, bool use_section)
 {
 	/*
 	 * In order to get # of valid blocks in a section instantly from many
 	 * segments, f2fs manages two counting structures separately.
 	 */
-	if (section > 1)
+	if (use_section && sbi->segs_per_sec > 1)
 		return get_sec_entry(sbi, segno)->valid_blocks;
 	else
 		return get_seg_entry(sbi, segno)->valid_blocks;
@@ -722,8 +722,8 @@ static inline block_t sum_blk_addr(struct f2fs_sb_info *sbi, int base, int type)
 static inline bool no_fggc_candidate(struct f2fs_sb_info *sbi,
 						unsigned int secno)
 {
-	if (get_valid_blocks(sbi, GET_SEGNO_FROM_SECNO(sbi, secno),
-				sbi->segs_per_sec) >= sbi->fggc_threshold)
+	if (get_valid_blocks(sbi, GET_SEGNO_FROM_SECNO(sbi, secno), true) >=
+						sbi->fggc_threshold)
 		return true;
 	return false;
 }
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index cb65e6d0d275..97c07a5153e9 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -996,7 +996,7 @@ static int segment_info_seq_show(struct seq_file *seq, void *offset)
 		if ((i % 10) == 0)
 			seq_printf(seq, "%-10d", i);
 		seq_printf(seq, "%d|%-3u", se->type,
-					get_valid_blocks(sbi, i, 1));
+					get_valid_blocks(sbi, i, false));
 		if ((i % 10) == 9 || i == (total_segs - 1))
 			seq_putc(seq, '\n');
 		else
@@ -1022,7 +1022,7 @@ static int segment_bits_seq_show(struct seq_file *seq, void *offset)
 
 		seq_printf(seq, "%-10d", i);
 		seq_printf(seq, "%d|%-3u|", se->type,
-					get_valid_blocks(sbi, i, 1));
+					get_valid_blocks(sbi, i, false));
 		for (j = 0; j < SIT_VBLOCK_MAP_SIZE; j++)
 			seq_printf(seq, " %.2x", se->cur_valid_map[j]);
 		seq_putc(seq, '\n');
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
