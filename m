From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: add tracepoint for f2fs_gc
Date: Fri, 11 Aug 2017 18:00:15 +0800
Message-ID: <20170811100015.66839-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch adds tracepoint for f2fs_gc.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/gc.c                |  50 +++++++++++++++------
 include/trace/events/f2fs.h | 107 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 143 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index e60480f71bb5..57bea2182f30 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -919,7 +919,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 	struct blk_plug plug;
 	unsigned int segno = start_segno;
 	unsigned int end_segno = start_segno + sbi->segs_per_sec;
-	int sec_freed = 0;
+	int seg_freed = 0;
 	unsigned char type = IS_DATASEG(get_seg_entry(sbi, segno)->type) ?
 						SUM_TYPE_DATA : SUM_TYPE_NODE;
 
@@ -965,6 +965,10 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 								gc_type);
 
 		stat_inc_seg_count(sbi, type, gc_type);
+
+		if (gc_type == FG_GC &&
+				get_valid_blocks(sbi, segno, false) == 0)
+			seg_freed++;
 next:
 		f2fs_put_page(sum_page, 0);
 	}
@@ -975,21 +979,17 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 
 	blk_finish_plug(&plug);
 
-	if (gc_type == FG_GC &&
-		get_valid_blocks(sbi, start_segno, true) == 0)
-		sec_freed = 1;
-
 	stat_inc_call_count(sbi->stat_info);
 
-	return sec_freed;
+	return seg_freed;
 }
 
 int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 			bool background, unsigned int segno)
 {
 	int gc_type = sync ? FG_GC : BG_GC;
-	int sec_freed = 0;
-	int ret;
+	int sec_freed = 0, seg_freed = 0, total_freed = 0;
+	int ret = 0;
 	struct cp_control cpc;
 	unsigned int init_segno = segno;
 	struct gc_inode_list gc_list = {
@@ -997,6 +997,15 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 		.iroot = RADIX_TREE_INIT(GFP_NOFS),
 	};
 
+	trace_f2fs_gc_begin(sbi->sb, sync, background,
+				get_pages(sbi, F2FS_DIRTY_NODES),
+				get_pages(sbi, F2FS_DIRTY_DENTS),
+				get_pages(sbi, F2FS_DIRTY_IMETA),
+				free_sections(sbi),
+				free_segments(sbi),
+				reserved_segments(sbi),
+				prefree_segments(sbi));
+
 	cpc.reason = __get_cp_reason(sbi);
 gc_more:
 	if (unlikely(!(sbi->sb->s_flags & MS_ACTIVE))) {
@@ -1023,17 +1032,20 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 			gc_type = FG_GC;
 	}
 
-	ret = -EINVAL;
 	/* f2fs_balance_fs doesn't need to do BG_GC in critical path. */
-	if (gc_type == BG_GC && !background)
+	if (gc_type == BG_GC && !background) {
+		ret = -EINVAL;
 		goto stop;
-	if (!__get_victim(sbi, &segno, gc_type))
+	}
+	if (!__get_victim(sbi, &segno, gc_type)) {
+		ret = -ENODATA;
 		goto stop;
-	ret = 0;
+	}
 
-	if (do_garbage_collect(sbi, segno, &gc_list, gc_type) &&
-			gc_type == FG_GC)
+	seg_freed = do_garbage_collect(sbi, segno, &gc_list, gc_type);
+	if (gc_type == FG_GC && seg_freed == sbi->segs_per_sec)
 		sec_freed++;
+	total_freed += seg_freed;
 
 	if (gc_type == FG_GC)
 		sbi->cur_victim_sec = NULL_SEGNO;
@@ -1050,6 +1062,16 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 stop:
 	SIT_I(sbi)->last_victim[ALLOC_NEXT] = 0;
 	SIT_I(sbi)->last_victim[FLUSH_DEVICE] = init_segno;
+
+	trace_f2fs_gc_end(sbi->sb, ret, total_freed, sec_freed,
+				get_pages(sbi, F2FS_DIRTY_NODES),
+				get_pages(sbi, F2FS_DIRTY_DENTS),
+				get_pages(sbi, F2FS_DIRTY_IMETA),
+				free_sections(sbi),
+				free_segments(sbi),
+				reserved_segments(sbi),
+				prefree_segments(sbi));
+
 	mutex_unlock(&sbi->gc_mutex);
 
 	put_gc_inode(&gc_list);
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index db5c98256147..8955e75dd48e 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -569,6 +569,113 @@ TRACE_EVENT(f2fs_background_gc,
 		__entry->free)
 );
 
+TRACE_EVENT(f2fs_gc_begin,
+
+	TP_PROTO(struct super_block *sb, bool sync, bool background,
+			long long dirty_nodes, long long dirty_dents,
+			long long dirty_imeta, unsigned int free_sec,
+			unsigned int free_seg, int reserved_seg,
+			unsigned int prefree_seg),
+
+	TP_ARGS(sb, sync, background, dirty_nodes, dirty_dents, dirty_imeta,
+		free_sec, free_seg, reserved_seg, prefree_seg),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		dev)
+		__field(bool,		sync)
+		__field(bool,		background)
+		__field(long long,	dirty_nodes)
+		__field(long long,	dirty_dents)
+		__field(long long,	dirty_imeta)
+		__field(unsigned int,	free_sec)
+		__field(unsigned int,	free_seg)
+		__field(int,		reserved_seg)
+		__field(unsigned int,	prefree_seg)
+	),
+
+	TP_fast_assign(
+		__entry->dev		= sb->s_dev;
+		__entry->sync		= sync;
+		__entry->background	= background;
+		__entry->dirty_nodes	= dirty_nodes;
+		__entry->dirty_dents	= dirty_dents;
+		__entry->dirty_imeta	= dirty_imeta;
+		__entry->free_sec	= free_sec;
+		__entry->free_seg	= free_seg;
+		__entry->reserved_seg	= reserved_seg;
+		__entry->prefree_seg	= prefree_seg;
+	),
+
+	TP_printk("dev = (%d,%d), sync = %d, background = %d, nodes = %lld, "
+		"dents = %lld, imeta = %lld, free_sec:%u, free_seg:%u, "
+		"rsv_seg:%d, prefree_seg:%u",
+		show_dev(__entry->dev),
+		__entry->sync,
+		__entry->background,
+		__entry->dirty_nodes,
+		__entry->dirty_dents,
+		__entry->dirty_imeta,
+		__entry->free_sec,
+		__entry->free_seg,
+		__entry->reserved_seg,
+		__entry->prefree_seg)
+);
+
+TRACE_EVENT(f2fs_gc_end,
+
+	TP_PROTO(struct super_block *sb, int ret, int seg_freed,
+			int sec_freed, long long dirty_nodes,
+			long long dirty_dents, long long dirty_imeta,
+			unsigned int free_sec, unsigned int free_seg,
+			int reserved_seg, unsigned int prefree_seg),
+
+	TP_ARGS(sb, ret, seg_freed, sec_freed, dirty_nodes, dirty_dents,
+		dirty_imeta, free_sec, free_seg, reserved_seg, prefree_seg),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		dev)
+		__field(int,		ret)
+		__field(int,		seg_freed)
+		__field(int,		sec_freed)
+		__field(long long,	dirty_nodes)
+		__field(long long,	dirty_dents)
+		__field(long long,	dirty_imeta)
+		__field(unsigned int,	free_sec)
+		__field(unsigned int,	free_seg)
+		__field(int,		reserved_seg)
+		__field(unsigned int,	prefree_seg)
+	),
+
+	TP_fast_assign(
+		__entry->dev		= sb->s_dev;
+		__entry->ret		= ret;
+		__entry->seg_freed	= seg_freed;
+		__entry->sec_freed	= sec_freed;
+		__entry->dirty_nodes	= dirty_nodes;
+		__entry->dirty_dents	= dirty_dents;
+		__entry->dirty_imeta	= dirty_imeta;
+		__entry->free_sec	= free_sec;
+		__entry->free_seg	= free_seg;
+		__entry->reserved_seg	= reserved_seg;
+		__entry->prefree_seg	= prefree_seg;
+	),
+
+	TP_printk("dev = (%d,%d), ret = %d, seg_freed = %d, sec_freed = %d, "
+		"nodes = %lld, dents = %lld, imeta = %lld, free_sec:%u, "
+		"free_seg:%u, rsv_seg:%d, prefree_seg:%u",
+		show_dev(__entry->dev),
+		__entry->ret,
+		__entry->seg_freed,
+		__entry->sec_freed,
+		__entry->dirty_nodes,
+		__entry->dirty_dents,
+		__entry->dirty_imeta,
+		__entry->free_sec,
+		__entry->free_seg,
+		__entry->reserved_seg,
+		__entry->prefree_seg)
+);
+
 TRACE_EVENT(f2fs_get_victim,
 
 	TP_PROTO(struct super_block *sb, int type, int gc_type,
-- 
2.13.1.388.g69e6b9b4f4a9
