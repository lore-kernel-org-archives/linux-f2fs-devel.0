From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH v2 2/2] f2fs: enhance foreground GC
Date: Sat, 23 Jan 2016 16:23:55 +0800
Message-ID: <000001d155b7$7f140690$7d3c13b0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aMtV2-0001uQ-QH
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 23 Jan 2016 08:24:48 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aMtV0-0003gj-Cj
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 23 Jan 2016 08:24:48 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O1E034BYCOYFG50@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Sat, 23 Jan 2016 17:24:36 +0900 (KST)
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

If we configure section consist of multiple segments, foreground GC will
do the garbage collection with following approach:

	for each segment in victim section
		blk_start_plug
		for each valid block in segment
			write out by OPU method
		submit bio cache   <---
		blk_finish_plug   <---

There are two issue:
1) for most of the time, 'submit bio cache' will break the merging in
current bio buffer from writes of next segments, making a smaller bio
submitting.
2) block plug only cover IO submitting in one segment, which reduce
opportunity of merging IOs in plug with multiple segments.

So refactor the code as below structure to strive for biggest
opportunity of merging IOs:

	blk_start_plug
	for each segment in victim section
		for each valid block in segment
			write out by OPU method
	submit bio cache
	blk_finish_plug

Test method:
1. mkfs.f2fs -s 8 /dev/sdX
2. touch 32 files
3. write 2M data into each file
4. punch 1.5M data from offset 0 for each file
5. trigger foreground gc through ioctl

Before patch, there are totoally 40 bios submitted.
f2fs_submit_write_bio: dev = (8,32), WRITE_SYNC, DATA, sector = 65536, size = 122880
f2fs_submit_write_bio: dev = (8,32), WRITE_SYNC, DATA, sector = 65776, size = 122880
f2fs_submit_write_bio: dev = (8,32), WRITE_SYNC, DATA, sector = 66016, size = 122880
f2fs_submit_write_bio: dev = (8,32), WRITE_SYNC, DATA, sector = 66256, size = 122880
f2fs_submit_write_bio: dev = (8,32), WRITE_SYNC, DATA, sector = 66496, size = 32768
----repeat for 8 times

After patch, there are totally 35 bios submitted.
f2fs_submit_write_bio: dev = (8,32), WRITE_SYNC, DATA, sector = 65536, size = 122880
----repeat 34 times
f2fs_submit_write_bio: dev = (8,32), WRITE_SYNC, DATA, sector = 73696, size = 16384

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---

V2:
 - Fix compiler warning reported by 0-Day test project.

 fs/f2fs/gc.c | 143 ++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 72 insertions(+), 71 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index f610c2a..cd5a5c7 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -399,7 +399,7 @@ static int check_valid_map(struct f2fs_sb_info *sbi,
  * On validity, copy that node with cold status, otherwise (invalid node)
  * ignore that.
  */
-static int gc_node_segment(struct f2fs_sb_info *sbi,
+static void gc_node_segment(struct f2fs_sb_info *sbi,
 		struct f2fs_summary *sum, unsigned int segno, int gc_type)
 {
 	bool initial = true;
@@ -419,7 +419,7 @@ next_step:
 
 		/* stop BG_GC if there is not enough free sections. */
 		if (gc_type == BG_GC && has_not_enough_free_secs(sbi, 0))
-			return 0;
+			return;
 
 		if (check_valid_map(sbi, segno, off) == 0)
 			continue;
@@ -460,20 +460,6 @@ next_step:
 		initial = false;
 		goto next_step;
 	}
-
-	if (gc_type == FG_GC) {
-		struct writeback_control wbc = {
-			.sync_mode = WB_SYNC_ALL,
-			.nr_to_write = LONG_MAX,
-			.for_reclaim = 0,
-		};
-		sync_node_pages(sbi, 0, &wbc);
-
-		/* return 1 only if FG_GC succefully reclaimed one */
-		if (get_valid_blocks(sbi, segno, 1) == 0)
-			return 1;
-	}
-	return 0;
 }
 
 /*
@@ -663,7 +649,7 @@ out:
  * If the parent node is not valid or the data block address is different,
  * the victim data block is ignored.
  */
-static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
+static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 		struct gc_inode_list *gc_list, unsigned int segno, int gc_type)
 {
 	struct super_block *sb = sbi->sb;
@@ -686,7 +672,7 @@ next_step:
 
 		/* stop BG_GC if there is not enough free sections. */
 		if (gc_type == BG_GC && has_not_enough_free_secs(sbi, 0))
-			return 0;
+			return;
 
 		if (check_valid_map(sbi, segno, off) == 0)
 			continue;
@@ -747,15 +733,6 @@ next_step:
 
 	if (++phase < 4)
 		goto next_step;
-
-	if (gc_type == FG_GC) {
-		f2fs_submit_merged_bio(sbi, DATA, WRITE);
-
-		/* return 1 only if FG_GC succefully reclaimed one */
-		if (get_valid_blocks(sbi, segno, 1) == 0)
-			return 1;
-	}
-	return 0;
 }
 
 static int __get_victim(struct f2fs_sb_info *sbi, unsigned int *victim,
@@ -771,53 +748,90 @@ static int __get_victim(struct f2fs_sb_info *sbi, unsigned int *victim,
 	return ret;
 }
 
-static int do_garbage_collect(struct f2fs_sb_info *sbi, unsigned int segno,
+static int do_garbage_collect(struct f2fs_sb_info *sbi,
+				unsigned int start_segno,
 				struct gc_inode_list *gc_list, int gc_type)
 {
 	struct page *sum_page;
 	struct f2fs_summary_block *sum;
 	struct blk_plug plug;
-	int nfree = 0;
+	unsigned int segno = start_segno;
+	unsigned int end_segno = start_segno + sbi->segs_per_sec;
+	int seg_freed = 0;
+	unsigned char type = IS_DATASEG(get_seg_entry(sbi, segno)->type) ?
+						SUM_TYPE_DATA : SUM_TYPE_NODE;
 
-	/* read segment summary of victim */
-	sum_page = get_sum_page(sbi, segno);
+	/* readahead multi ssa blocks those have contiguous address */
+	if (sbi->segs_per_sec > 1)
+		ra_meta_pages(sbi, GET_SUM_BLOCK(sbi, segno),
+					sbi->segs_per_sec, META_SSA, true);
+
+	/* reference all summary page */
+	while (segno < end_segno) {
+		sum_page = get_sum_page(sbi, segno++);
+		unlock_page(sum_page);
+	}
 
 	blk_start_plug(&plug);
 
-	sum = page_address(sum_page);
+	for (segno = start_segno; segno < end_segno; segno++) {
+		/* find segment summary of victim */
+		sum_page = find_get_page(META_MAPPING(sbi),
+					GET_SUM_BLOCK(sbi, segno));
+		f2fs_bug_on(sbi, !PageUptodate(sum_page));
+		f2fs_put_page(sum_page, 0);
 
-	/*
-	 * this is to avoid deadlock:
-	 * - lock_page(sum_page)         - f2fs_replace_block
-	 *  - check_valid_map()            - mutex_lock(sentry_lock)
-	 *   - mutex_lock(sentry_lock)     - change_curseg()
-	 *                                  - lock_page(sum_page)
-	 */
-	unlock_page(sum_page);
-
-	switch (GET_SUM_TYPE((&sum->footer))) {
-	case SUM_TYPE_NODE:
-		nfree = gc_node_segment(sbi, sum->entries, segno, gc_type);
-		break;
-	case SUM_TYPE_DATA:
-		nfree = gc_data_segment(sbi, sum->entries, gc_list,
-							segno, gc_type);
-		break;
+		sum = page_address(sum_page);
+		f2fs_bug_on(sbi, type != GET_SUM_TYPE((&sum->footer)));
+
+		/*
+		 * this is to avoid deadlock:
+		 * - lock_page(sum_page)         - f2fs_replace_block
+		 *  - check_valid_map()            - mutex_lock(sentry_lock)
+		 *   - mutex_lock(sentry_lock)     - change_curseg()
+		 *                                  - lock_page(sum_page)
+		 */
+
+		if (type == SUM_TYPE_NODE)
+			gc_node_segment(sbi, sum->entries, segno, gc_type);
+		else
+			gc_data_segment(sbi, sum->entries, gc_list, segno,
+								gc_type);
+
+		stat_inc_seg_count(sbi, type, gc_type);
+		stat_inc_call_count(sbi->stat_info);
+
+		f2fs_put_page(sum_page, 0);
+	}
+
+	if (gc_type == FG_GC) {
+		if (type == SUM_TYPE_NODE) {
+			struct writeback_control wbc = {
+				.sync_mode = WB_SYNC_ALL,
+				.nr_to_write = LONG_MAX,
+				.for_reclaim = 0,
+			};
+			sync_node_pages(sbi, 0, &wbc);
+		} else {
+			f2fs_submit_merged_bio(sbi, DATA, WRITE);
+		}
 	}
-	blk_finish_plug(&plug);
 
-	stat_inc_seg_count(sbi, GET_SUM_TYPE((&sum->footer)), gc_type);
-	stat_inc_call_count(sbi->stat_info);
+	blk_finish_plug(&plug);
 
-	f2fs_put_page(sum_page, 0);
-	return nfree;
+	if (gc_type == FG_GC) {
+		while (start_segno < end_segno)
+			if (get_valid_blocks(sbi, start_segno++, 1) == 0)
+				seg_freed++;
+	}
+	return seg_freed;
 }
 
 int f2fs_gc(struct f2fs_sb_info *sbi, bool sync)
 {
-	unsigned int segno, i;
+	unsigned int segno;
 	int gc_type = sync ? FG_GC : BG_GC;
-	int sec_freed = 0;
+	int sec_freed = 0, seg_freed;
 	int ret = -EINVAL;
 	struct cp_control cpc;
 	struct gc_inode_list gc_list = {
@@ -846,22 +860,9 @@ gc_more:
 		goto stop;
 	ret = 0;
 
-	/* readahead multi ssa blocks those have contiguous address */
-	if (sbi->segs_per_sec > 1)
-		ra_meta_pages(sbi, GET_SUM_BLOCK(sbi, segno), sbi->segs_per_sec,
-							META_SSA, true);
-
-	for (i = 0; i < sbi->segs_per_sec; i++) {
-		/*
-		 * for FG_GC case, halt gcing left segments once failed one
-		 * of segments in selected section to avoid long latency.
-		 */
-		if (!do_garbage_collect(sbi, segno + i, &gc_list, gc_type) &&
-				gc_type == FG_GC)
-			break;
-	}
+	seg_freed = do_garbage_collect(sbi, segno, &gc_list, gc_type);
 
-	if (i == sbi->segs_per_sec && gc_type == FG_GC)
+	if (gc_type == FG_GC && seg_freed == sbi->segs_per_sec)
 		sec_freed++;
 
 	if (gc_type == FG_GC)
-- 
2.7.0.2.g1b0b6dd



------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
