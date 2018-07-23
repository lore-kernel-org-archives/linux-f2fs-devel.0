From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH 4/5] f2fs: let BG_GC check every dirty segments and gc over a threshold
Date: Mon, 23 Jul 2018 22:10:21 +0800
Message-ID: <1532355022-163029-5-git-send-email-yunlong.song@huawei.com>
References: <1532355022-163029-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532355022-163029-1-git-send-email-yunlong.song@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

BG_GC is triggered in idle time, so it is better check every dirty
segment and finds the best victim to gc. Otherwise, BG_GC will be
limited to only 8G areas, and probably select a victim which has nearly
full of valid blocks, resulting a big WAI. Besides, we also add a
bggc_threshold (which is the old "fggc_threshold", so revert commit
"299254") to stop BG_GC when there is no good choice. This is especially
good for large section case to reduce WAI.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/f2fs.h    |  2 ++
 fs/f2fs/gc.c      | 23 ++++++++++++++++++++---
 fs/f2fs/segment.h |  9 +++++++++
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f8a7b42..24a9d7f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1220,6 +1220,8 @@ struct f2fs_sb_info {
 	unsigned int cur_fg_victim_sec;		/* current FG_GC victim section num */
 	unsigned int cur_bg_victim_sec;		/* current BG_GC victim section num */
 	unsigned int gc_mode;			/* current GC state */
+	/* threshold for selecting bg victims */
+	u64 bggc_threshold;
 	/* for skip statistic */
 	unsigned long long skipped_atomic_files[2];	/* FG_GC and BG_GC */
 
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 0e7a265..21e8d59 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -189,9 +189,8 @@ static void select_policy(struct f2fs_sb_info *sbi, int gc_type,
 		p->ofs_unit = sbi->segs_per_sec;
 	}
 
-	/* we need to check every dirty segments in the FG_GC case */
-	if (gc_type != FG_GC &&
-			(sbi->gc_mode != GC_URGENT) &&
+	/* we need to check every dirty segments in the GC case */
+	if (p->alloc_mode == SSR &&
 			p->max_search > sbi->max_victim_search)
 		p->max_search = sbi->max_victim_search;
 
@@ -230,6 +229,10 @@ static unsigned int check_bg_victims(struct f2fs_sb_info *sbi)
 	for_each_set_bit(secno, dirty_i->victim_secmap, MAIN_SECS(sbi)) {
 		if (sec_usage_check(sbi, secno))
 			continue;
+
+		if (no_bggc_candidate(sbi, secno))
+			continue;
+
 		clear_bit(secno, dirty_i->victim_secmap);
 		return GET_SEG_FROM_SEC(sbi, secno);
 	}
@@ -368,6 +371,10 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 		if (sec_usage_check(sbi, secno))
 			goto next;
 
+		if (gc_type == BG_GC && p.alloc_mode == LFS &&
+					no_bggc_candidate(sbi, secno))
+			goto next;
+
 		cost = get_gc_cost(sbi, segno, &p);
 
 		if (p.min_cost > cost) {
@@ -1140,8 +1147,18 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 
 void f2fs_build_gc_manager(struct f2fs_sb_info *sbi)
 {
+	u64 main_count, resv_count, ovp_count;
+
 	DIRTY_I(sbi)->v_ops = &default_v_ops;
 
+	/* threshold of # of valid blocks in a section for victims of BG_GC */
+	main_count = SM_I(sbi)->main_segments << sbi->log_blocks_per_seg;
+	resv_count = SM_I(sbi)->reserved_segments << sbi->log_blocks_per_seg;
+	ovp_count = SM_I(sbi)->ovp_segments << sbi->log_blocks_per_seg;
+
+	sbi->bggc_threshold = div64_u64((main_count - ovp_count) *
+					BLKS_PER_SEC(sbi), (main_count - resv_count));
+
 	sbi->gc_pin_file_threshold = DEF_GC_FAILED_PINNED_FILES;
 
 	/* give warm/cold data area from slower device */
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index b21bb96..932e59b 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -785,6 +785,15 @@ static inline block_t sum_blk_addr(struct f2fs_sb_info *sbi, int base, int type)
 				- (base + 1) + type;
 }
 
+static inline bool no_bggc_candidate(struct f2fs_sb_info *sbi,
+                        unsigned int secno)
+{
+    if (get_valid_blocks(sbi, GET_SEG_FROM_SEC(sbi, secno), true) >
+                        sbi->bggc_threshold)
+        return true;
+    return false;
+}
+
 static inline bool sec_usage_check(struct f2fs_sb_info *sbi, unsigned int secno)
 {
 	if (IS_CURSEC(sbi, secno) || (sbi->cur_fg_victim_sec == secno) ||
-- 
1.8.5.2
