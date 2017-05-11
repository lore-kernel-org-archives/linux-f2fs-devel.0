From: h00285313 <heyunlei@huawei.com>
Subject: [PATCH RFC] f2fs: unblock operation after flush sit &&
	nat
Date: Thu, 11 May 2017 16:28:45 +0800
Message-ID: <1494491325-15316-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1d8jdr-0004pS-A5
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 11 May 2017 08:40:11 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1d8jdo-00028P-NO
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 11 May 2017 08:40:11 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net

After we flush sit && nat, maybe we can unlock filesystem.
1. Release prefree segments after cp pack write back.
2. Not allowed SSR on dirty sit until cp pack write back.

Signed-off-by: h00285313 <heyunlei@huawei.com>
---
 fs/f2fs/checkpoint.c | 38 +++++++++++++++++++++++++++++++++++++-
 fs/f2fs/gc.c         |  5 ++++-
 fs/f2fs/segment.c    | 17 +----------------
 fs/f2fs/segment.h    |  3 ++-
 4 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index ea9c317b..d11d83f 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1263,6 +1263,40 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	return 0;
 }
 
+void clear_in_cp_flag(struct f2fs_sb_info *sbi)
+{
+	struct sit_info *sit_i = SIT_I(sbi);
+	struct seg_entry *se;
+	unsigned int segno = 0;
+	unsigned int end_segno = MAIN_SEGS(sbi);
+
+	mutex_lock(&sit_i->sentry_lock);
+	while (segno < end_segno) {
+		se = get_seg_entry(sbi, segno);
+		segno++;
+
+		if (!se->in_cp)
+			continue;
+
+		se->in_cp = 0;
+	}
+	mutex_unlock(&sit_i->sentry_lock);
+}
+
+/*
+ * Should call clear_prefree_segments after checkpoint is done.
+ */
+static void set_prefree_as_free_segments(struct f2fs_sb_info *sbi)
+{
+	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
+	unsigned int segno;
+
+	mutex_lock(&dirty_i->seglist_lock);
+	for_each_set_bit(segno, dirty_i->dirty_segmap[PRE], MAIN_SEGS(sbi))
+		__set_test_and_free(sbi, segno);
+	mutex_unlock(&dirty_i->seglist_lock);
+}
+
 /*
  * We guarantee that this checkpoint procedure will not fail.
  */
@@ -1325,6 +1359,7 @@ int write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	/* write cached NAT/SIT entries to NAT/SIT area */
 	flush_nat_entries(sbi, cpc);
 	flush_sit_entries(sbi, cpc);
+	unblock_operations(sbi);
 
 	/* unlock all the fs_lock[] in do_checkpoint() */
 	err = do_checkpoint(sbi, cpc);
@@ -1333,7 +1368,8 @@ int write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	else
 		clear_prefree_segments(sbi, cpc);
 
-	unblock_operations(sbi);
+	set_prefree_as_free_segments(sbi);
+	clear_in_cp_flag(sbi);
 	stat_inc_cp_count(sbi->stat_info);
 
 	if (cpc->reason & CP_RECOVERY)
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 0265221..e5cde89 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -261,8 +261,11 @@ static unsigned int get_greedy_cost(struct f2fs_sb_info *sbi,
 static inline unsigned int get_gc_cost(struct f2fs_sb_info *sbi,
 			unsigned int segno, struct victim_sel_policy *p)
 {
+	struct seg_entry *se;
+
+	se = get_seg_entry(sbi, segno);
 	if (p->alloc_mode == SSR)
-		return get_seg_entry(sbi, segno)->ckpt_valid_blocks;
+		return se->in_cp ? sbi->blocks_per_seg + 1: se->ckpt_valid_blocks;
 
 	/* alloc_mode == LFS */
 	if (p->gc_mode == GC_GREEDY)
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index de31030..0877a2e 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1244,20 +1244,6 @@ void release_discard_addrs(struct f2fs_sb_info *sbi)
 	}
 }
 
-/*
- * Should call clear_prefree_segments after checkpoint is done.
- */
-static void set_prefree_as_free_segments(struct f2fs_sb_info *sbi)
-{
-	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
-	unsigned int segno;
-
-	mutex_lock(&dirty_i->seglist_lock);
-	for_each_set_bit(segno, dirty_i->dirty_segmap[PRE], MAIN_SEGS(sbi))
-		__set_test_and_free(sbi, segno);
-	mutex_unlock(&dirty_i->seglist_lock);
-}
-
 void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 {
 	struct list_head *head = &(SM_I(sbi)->dcc_info->entry_list);
@@ -2815,8 +2801,6 @@ void flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		cpc->trim_start = trim_start;
 	}
 	mutex_unlock(&sit_i->sentry_lock);
-
-	set_prefree_as_free_segments(sbi);
 }
 
 static int build_sit_info(struct f2fs_sb_info *sbi)
@@ -2995,6 +2979,7 @@ static void build_sit_entries(struct f2fs_sb_info *sbi)
 			struct page *page;
 
 			se = &sit_i->sentries[start];
+			se->in_cp = 0;
 			page = get_current_sit_page(sbi, start);
 			sit_blk = (struct f2fs_sit_block *)page_address(page);
 			sit = sit_blk->entries[SIT_ENTRY_OFFSET(sit_i, start)];
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 10bf05d..f69cd5b 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -171,7 +171,7 @@ struct seg_entry {
 	unsigned int type:6;		/* segment type like CURSEG_XXX_TYPE */
 	unsigned int valid_blocks:10;	/* # of valid blocks */
 	unsigned int ckpt_valid_blocks:10;	/* # of valid blocks last cp */
-	unsigned int padding:6;		/* padding */
+	unsigned int in_cp:6;		/* indicate cp or not */
 	unsigned char *cur_valid_map;	/* validity bitmap of blocks */
 #ifdef CONFIG_F2FS_CHECK_FS
 	unsigned char *cur_valid_map_mir;	/* mirror of current valid bitmap */
@@ -352,6 +352,7 @@ static inline void seg_info_to_raw_sit(struct seg_entry *se,
 	rs->vblocks = cpu_to_le16(raw_vblocks);
 	memcpy(rs->valid_map, se->cur_valid_map, SIT_VBLOCK_MAP_SIZE);
 	memcpy(se->ckpt_valid_map, rs->valid_map, SIT_VBLOCK_MAP_SIZE);
+	se->in_cp = 1;
 	se->ckpt_valid_blocks = se->valid_blocks;
 	rs->mtime = cpu_to_le64(se->mtime);
 }
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
