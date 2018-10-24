From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/3] f2fs: support subsectional garbage collection
Date: Wed, 24 Oct 2018 18:37:27 +0800
Message-ID: <20181024103728.9870-2-yuchao0@huawei.com>
References: <20181024103728.9870-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181024103728.9870-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Section is minimal garbage collection unit of f2fs, in zoned block
device, or ancient block mapping flash device, in order to improve
GC efficiency, we can align GC unit to lower device erase unit,
normally, it consists of multiple of segments.

Once background or foreground GC triggers, it brings a large number
of IOs, which will impact user IO, and also occupy cpu/memory resource
intensively.

So, to reduce impact of GC on large size section, this patch supports
subsectional GC, in one cycle of GC, it only migrate partial segment{s}
in victim section. Currently, by default, we use sbi->segs_per_sec as
migration granularity.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h  |  3 +++
 fs/f2fs/gc.c    | 43 ++++++++++++++++++++++++++++++++++++-------
 fs/f2fs/super.c |  3 +++
 3 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e57e7874d162..b9cec3f2184c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1266,6 +1266,7 @@ struct f2fs_sb_info {
 	struct f2fs_gc_kthread	*gc_thread;	/* GC thread */
 	unsigned int cur_victim_sec;		/* current victim section num */
 	unsigned int gc_mode;			/* current GC state */
+	unsigned int next_victim_seg[2];	/* next segment in victim section */
 	/* for skip statistic */
 	unsigned long long skipped_atomic_files[2];	/* FG_GC and BG_GC */
 	unsigned long long skipped_gc_rwsem;		/* FG_GC only */
@@ -1275,6 +1276,8 @@ struct f2fs_sb_info {
 
 	/* maximum # of trials to find a victim segment for SSR and GC */
 	unsigned int max_victim_search;
+	/* migration granularity of garbage collection, unit: segment */
+	unsigned int migration_granularity;
 
 	/*
 	 * for stat information.
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 34b9d56f5f9e..d5d8c433178b 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -333,6 +333,22 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 	if (p.max_search == 0)
 		goto out;
 
+	if (__is_large_section(sbi) && p.alloc_mode == LFS) {
+		if (sbi->next_victim_seg[BG_GC] != NULL_SEGNO) {
+			p.min_segno = sbi->next_victim_seg[BG_GC];
+			*result = p.min_segno;
+			sbi->next_victim_seg[BG_GC] = NULL_SEGNO;
+			goto got_result;
+		}
+		if (gc_type == FG_GC &&
+				sbi->next_victim_seg[FG_GC] != NULL_SEGNO) {
+			p.min_segno = sbi->next_victim_seg[FG_GC];
+			*result = p.min_segno;
+			sbi->next_victim_seg[FG_GC] = NULL_SEGNO;
+			goto got_result;
+		}
+	}
+
 	last_victim = sm->last_victim[p.gc_mode];
 	if (p.alloc_mode == LFS && gc_type == FG_GC) {
 		p.min_segno = check_bg_victims(sbi);
@@ -395,6 +411,8 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 	}
 	if (p.min_segno != NULL_SEGNO) {
 got_it:
+		*result = (p.min_segno / p.ofs_unit) * p.ofs_unit;
+got_result:
 		if (p.alloc_mode == LFS) {
 			secno = GET_SEC_FROM_SEG(sbi, p.min_segno);
 			if (gc_type == FG_GC)
@@ -402,7 +420,6 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 			else
 				set_bit(secno, dirty_i->victim_secmap);
 		}
-		*result = (p.min_segno / p.ofs_unit) * p.ofs_unit;
 
 		trace_f2fs_get_victim(sbi->sb, type, gc_type, &p,
 				sbi->cur_victim_sec,
@@ -1093,15 +1110,18 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 	struct blk_plug plug;
 	unsigned int segno = start_segno;
 	unsigned int end_segno = start_segno + sbi->segs_per_sec;
-	int seg_freed = 0;
+	int seg_freed = 0, migrated = 0;
 	unsigned char type = IS_DATASEG(get_seg_entry(sbi, segno)->type) ?
 						SUM_TYPE_DATA : SUM_TYPE_NODE;
 	int submitted = 0;
 
+	if (__is_large_section(sbi))
+		end_segno = rounddown(end_segno, sbi->segs_per_sec);
+
 	/* readahead multi ssa blocks those have contiguous address */
 	if (__is_large_section(sbi))
 		f2fs_ra_meta_pages(sbi, GET_SUM_BLOCK(sbi, segno),
-					sbi->segs_per_sec, META_SSA, true);
+					end_segno - segno, META_SSA, true);
 
 	/* reference all summary page */
 	while (segno < end_segno) {
@@ -1130,18 +1150,23 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 					GET_SUM_BLOCK(sbi, segno));
 		f2fs_put_page(sum_page, 0);
 
-		if (get_valid_blocks(sbi, segno, false) == 0 ||
-				!PageUptodate(sum_page) ||
-				unlikely(f2fs_cp_error(sbi)))
+		if (get_valid_blocks(sbi, segno, false) == 0)
 			goto next;
 
+		if (__is_large_section(sbi) &&
+				migrated >= sbi->migration_granularity)
+			goto skip;
+
+		if (!PageUptodate(sum_page) || unlikely(f2fs_cp_error(sbi)))
+			goto skip;
+
 		sum = page_address(sum_page);
 		if (type != GET_SUM_TYPE((&sum->footer))) {
 			f2fs_msg(sbi->sb, KERN_ERR, "Inconsistent segment (%u) "
 				"type [%d, %d] in SSA and SIT",
 				segno, type, GET_SUM_TYPE((&sum->footer)));
 			set_sbi_flag(sbi, SBI_NEED_FSCK);
-			goto next;
+			goto skip;
 		}
 
 		/*
@@ -1163,7 +1188,11 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 		if (gc_type == FG_GC &&
 				get_valid_blocks(sbi, segno, false) == 0)
 			seg_freed++;
+		migrated++;
 next:
+		if (__is_large_section(sbi) && segno + 1 < end_segno)
+			sbi->next_victim_seg[gc_type] = segno + 1;
+skip:
 		f2fs_put_page(sum_page, 0);
 	}
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 5b297f3b55e4..c85e3a17aaa0 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2692,7 +2692,10 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 	sbi->node_ino_num = le32_to_cpu(raw_super->node_ino);
 	sbi->meta_ino_num = le32_to_cpu(raw_super->meta_ino);
 	sbi->cur_victim_sec = NULL_SECNO;
+	sbi->next_victim_seg[BG_GC] = NULL_SEGNO;
+	sbi->next_victim_seg[FG_GC] = NULL_SEGNO;
 	sbi->max_victim_search = DEF_MAX_VICTIM_SEARCH;
+	sbi->migration_granularity = sbi->segs_per_sec;
 
 	sbi->dir_level = DEF_DIR_LEVEL;
 	sbi->interval_time[CP_TIME] = DEF_CP_INTERVAL;
-- 
2.18.0.rc1
