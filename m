From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 18/19] f2fs: introduce discard_map for
	f2fs_trim_fs
Date: Fri,  1 May 2015 17:48:45 -0700
Message-ID: <1430527726-68547-18-git-send-email-jaegeuk@kernel.org>
References: <1430527726-68547-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YoLcx-0001gK-MC
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 02 May 2015 00:49:55 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YoLcw-0000pw-ID for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 02 May 2015 00:49:55 +0000
In-Reply-To: <1430527726-68547-1-git-send-email-jaegeuk@kernel.org>
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

This patch adds a bitmap for discard issues from f2fs_trim_fs.
There-in rule is to issue discard commands only for invalidated blocks
after mount.
Once mount is done, f2fs_trim_fs trims out whole invalid area.
After ehn, it will not issue and discrads redundantly.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/debug.c   |  2 +-
 fs/f2fs/f2fs.h    | 21 +++++++++++++++++++++
 fs/f2fs/segment.c | 52 +++++++++++++++++++++++++++++++++++++++-------------
 fs/f2fs/segment.h |  1 +
 4 files changed, 62 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index f5388f3..f50acbc 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -143,7 +143,7 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
 	si->base_mem += sizeof(struct sit_info);
 	si->base_mem += MAIN_SEGS(sbi) * sizeof(struct seg_entry);
 	si->base_mem += f2fs_bitmap_size(MAIN_SEGS(sbi));
-	si->base_mem += 2 * SIT_VBLOCK_MAP_SIZE * MAIN_SEGS(sbi);
+	si->base_mem += 3 * SIT_VBLOCK_MAP_SIZE * MAIN_SEGS(sbi);
 	si->base_mem += SIT_VBLOCK_MAP_SIZE;
 	if (sbi->segs_per_sec > 1)
 		si->base_mem += MAIN_SECS(sbi) * sizeof(struct sec_entry);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 78a4300..98fc719 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -117,6 +117,8 @@ enum {
 #define DEF_BATCHED_TRIM_SECTIONS	32
 #define BATCHED_TRIM_SEGMENTS(sbi)	\
 		(SM_I(sbi)->trim_sections * (sbi)->segs_per_sec)
+#define BATCHED_TRIM_BLOCKS(sbi)	\
+		(BATCHED_TRIM_SEGMENTS(sbi) << (sbi)->log_blocks_per_seg)
 
 struct cp_control {
 	int reason;
@@ -698,6 +700,7 @@ struct f2fs_sb_info {
 	block_t user_block_count;		/* # of user blocks */
 	block_t total_valid_block_count;	/* # of valid blocks */
 	block_t alloc_valid_block_count;	/* # of allocated blocks */
+	block_t discard_blks;			/* discard command candidats */
 	block_t last_valid_block_count;		/* for recovery */
 	u32 s_next_generation;			/* for NFS support */
 	atomic_t nr_pages[NR_COUNT_TYPE];	/* # of pages, see count_type */
@@ -1225,6 +1228,24 @@ static inline int f2fs_test_bit(unsigned int nr, char *addr)
 	return mask & *addr;
 }
 
+static inline void f2fs_set_bit(unsigned int nr, char *addr)
+{
+	int mask;
+
+	addr += (nr >> 3);
+	mask = 1 << (7 - (nr & 0x07));
+	*addr |= mask;
+}
+
+static inline void f2fs_clear_bit(unsigned int nr, char *addr)
+{
+	int mask;
+
+	addr += (nr >> 3);
+	mask = 1 << (7 - (nr & 0x07));
+	*addr &= ~mask;
+}
+
 static inline int f2fs_test_and_set_bit(unsigned int nr, char *addr)
 {
 	int mask;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index df8bce5..5a4ec01 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -483,10 +483,12 @@ void discard_next_dnode(struct f2fs_sb_info *sbi, block_t blkaddr)
 }
 
 static void __add_discard_entry(struct f2fs_sb_info *sbi,
-		struct cp_control *cpc, unsigned int start, unsigned int end)
+		struct cp_control *cpc, struct seg_entry *se,
+		unsigned int start, unsigned int end)
 {
 	struct list_head *head = &SM_I(sbi)->discard_list;
 	struct discard_entry *new, *last;
+	unsigned int i;
 
 	if (!list_empty(head)) {
 		last = list_last_entry(head, struct discard_entry, list);
@@ -504,6 +506,10 @@ static void __add_discard_entry(struct f2fs_sb_info *sbi,
 	list_add_tail(&new->list, head);
 done:
 	SM_I(sbi)->nr_discards += end - start;
+	for (i = start; i < end; i++) {
+		f2fs_set_bit(i, se->discard_map);
+		sbi->discard_blks--;
+	}
 	cpc->trimmed += end - start;
 }
 
@@ -514,6 +520,7 @@ static void add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	struct seg_entry *se = get_seg_entry(sbi, cpc->trim_start);
 	unsigned long *cur_map = (unsigned long *)se->cur_valid_map;
 	unsigned long *ckpt_map = (unsigned long *)se->ckpt_valid_map;
+	unsigned long *discard_map = (unsigned long *)se->discard_map;
 	unsigned long *dmap = SIT_I(sbi)->tmp_map;
 	unsigned int start = 0, end = -1;
 	bool force = (cpc->reason == CP_DISCARD);
@@ -523,8 +530,11 @@ static void add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 			SM_I(sbi)->nr_discards >= SM_I(sbi)->max_discards))
 		return;
 
-	if (force && !se->valid_blocks) {
+	if (!se->valid_blocks) {
 		struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
+
+		if (!force)
+			return;
 		/*
 		 * if this segment is registered in the prefree list, then
 		 * we should skip adding a discard candidate, and let the
@@ -537,18 +547,14 @@ static void add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 			return;
 		}
 		mutex_unlock(&dirty_i->seglist_lock);
-
-		__add_discard_entry(sbi, cpc, 0, sbi->blocks_per_seg);
+	} else if (se->valid_blocks == max_blocks) {
+		/* zero block will be discarded through the prefree list */
 		return;
 	}
 
-	/* zero block will be discarded through the prefree list */
-	if (!se->valid_blocks || se->valid_blocks == max_blocks)
-		return;
-
 	/* SIT_VBLOCK_MAP_SIZE should be multiple of sizeof(unsigned long) */
 	for (i = 0; i < entries; i++)
-		dmap[i] = force ? ~ckpt_map[i] :
+		dmap[i] = force ? ~ckpt_map[i] & ~discard_map[i] :
 				(cur_map[i] ^ ckpt_map[i]) & ckpt_map[i];
 
 	while (force || SM_I(sbi)->nr_discards <= SM_I(sbi)->max_discards) {
@@ -561,7 +567,7 @@ static void add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		if (force && end - start < cpc->trim_minlen)
 			continue;
 
-		__add_discard_entry(sbi, cpc, start, end);
+		__add_discard_entry(sbi, cpc, se, start, end);
 	}
 }
 
@@ -675,9 +681,13 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 	if (del > 0) {
 		if (f2fs_test_and_set_bit(offset, se->cur_valid_map))
 			f2fs_bug_on(sbi, 1);
+		if (f2fs_test_and_set_bit(offset, se->discard_map))
+			sbi->discard_blks--;
 	} else {
 		if (!f2fs_test_and_clear_bit(offset, se->cur_valid_map))
 			f2fs_bug_on(sbi, 1);
+		if (f2fs_test_and_clear_bit(offset, se->discard_map))
+			sbi->discard_blks++;
 	}
 	if (!f2fs_test_bit(offset, se->ckpt_valid_map))
 		se->ckpt_valid_blocks += del;
@@ -1080,7 +1090,14 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 	/* do checkpoint to issue discard commands safely */
 	for (; start_segno <= end_segno; start_segno = cpc.trim_end + 1) {
 		cpc.trim_start = start_segno;
-		cpc.trim_end = min_t(unsigned int, rounddown(start_segno +
+
+		if (sbi->discard_blks == 0)
+			break;
+		else if (sbi->discard_blks < BATCHED_TRIM_BLOCKS(sbi))
+			cpc.trim_end = end_segno;
+		else
+			cpc.trim_end = min_t(unsigned int,
+				rounddown(start_segno +
 				BATCHED_TRIM_SEGMENTS(sbi),
 				sbi->segs_per_sec) - 1, end_segno);
 
@@ -1859,8 +1876,11 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
 			= kzalloc(SIT_VBLOCK_MAP_SIZE, GFP_KERNEL);
 		sit_i->sentries[start].ckpt_valid_map
 			= kzalloc(SIT_VBLOCK_MAP_SIZE, GFP_KERNEL);
-		if (!sit_i->sentries[start].cur_valid_map
-				|| !sit_i->sentries[start].ckpt_valid_map)
+		sit_i->sentries[start].discard_map
+			= kzalloc(SIT_VBLOCK_MAP_SIZE, GFP_KERNEL);
+		if (!sit_i->sentries[start].cur_valid_map ||
+				!sit_i->sentries[start].ckpt_valid_map ||
+				!sit_i->sentries[start].discard_map)
 			return -ENOMEM;
 	}
 
@@ -1998,6 +2018,11 @@ static void build_sit_entries(struct f2fs_sb_info *sbi)
 got_it:
 			check_block_count(sbi, start, &sit);
 			seg_info_from_raw_sit(se, &sit);
+
+			/* build discard map only one time */
+			memcpy(se->discard_map, se->cur_valid_map, SIT_VBLOCK_MAP_SIZE);
+			sbi->discard_blks += sbi->blocks_per_seg - se->valid_blocks;
+
 			if (sbi->segs_per_sec > 1) {
 				struct sec_entry *e = get_sec_entry(sbi, start);
 				e->valid_blocks += se->valid_blocks;
@@ -2247,6 +2272,7 @@ static void destroy_sit_info(struct f2fs_sb_info *sbi)
 		for (start = 0; start < MAIN_SEGS(sbi); start++) {
 			kfree(sit_i->sentries[start].cur_valid_map);
 			kfree(sit_i->sentries[start].ckpt_valid_map);
+			kfree(sit_i->sentries[start].discard_map);
 		}
 	}
 	kfree(sit_i->tmp_map);
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 85d7fa7..8496357 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -163,6 +163,7 @@ struct seg_entry {
 	 */
 	unsigned short ckpt_valid_blocks;
 	unsigned char *ckpt_valid_map;
+	unsigned char *discard_map;
 	unsigned char type;		/* segment type like CURSEG_XXX_TYPE */
 	unsigned long long mtime;	/* modification time of the segment */
 };
-- 
2.1.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
