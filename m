From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH 2/2] f2fs: add stat info for moved blocks by background gc
Date: Tue, 23 Dec 2014 08:37:39 +0900
Message-ID: <1419291459-7731-2-git-send-email-cm224.lee@samsung.com>
References: <1419291459-7731-1-git-send-email-cm224.lee@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <1419291459-7731-1-git-send-email-cm224.lee@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Changman Lee <cm224.lee@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch is for looking into gc performance of f2fs in detail.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 fs/f2fs/debug.c | 15 ++++++++++-----
 fs/f2fs/f2fs.h  | 17 ++++++++++++-----
 fs/f2fs/gc.c    |  6 +++---
 3 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 46bef86..285cce1 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -244,11 +244,16 @@ static int stat_show(struct seq_file *s, void *v)
 		seq_printf(s, "CP calls: %d\n", si->cp_count);
 		seq_printf(s, "GC calls: %d (BG: %d)\n",
 			   si->call_count, si->bg_gc);
-		seq_printf(s, "  - data segments : %d\n", si->data_segs);
-		seq_printf(s, "  - node segments : %d\n", si->node_segs);
-		seq_printf(s, "Try to move %d blocks\n", si->tot_blks);
-		seq_printf(s, "  - data blocks : %d\n", si->data_blks);
-		seq_printf(s, "  - node blocks : %d\n", si->node_blks);
+		seq_printf(s, "  - data segments : %d (%d)\n",
+				si->data_segs, si->bg_data_segs);
+		seq_printf(s, "  - node segments : %d (%d)\n",
+				si->node_segs, si->bg_node_segs);
+		seq_printf(s, "Try to move %d blocks (BG: %d)\n", si->tot_blks,
+				si->bg_data_blks + si->bg_node_blks);
+		seq_printf(s, "  - data blocks : %d (%d)\n", si->data_blks,
+				si->bg_data_blks);
+		seq_printf(s, "  - node blocks : %d (%d)\n", si->node_blks,
+				si->bg_node_blks);
 		seq_printf(s, "\nExtent Hit Ratio: %d / %d\n",
 			   si->hit_ext, si->total_ext);
 		seq_puts(s, "\nBalancing F2FS Async:\n");
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c956535..c88e2fc 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1508,7 +1508,9 @@ struct f2fs_stat_info {
 	int dirty_count, node_pages, meta_pages;
 	int prefree_count, call_count, cp_count;
 	int tot_segs, node_segs, data_segs, free_segs, free_secs;
+	int bg_node_segs, bg_data_segs;
 	int tot_blks, data_blks, node_blks;
+	int bg_data_blks, bg_node_blks;
 	int curseg[NR_CURSEG_TYPE];
 	int cursec[NR_CURSEG_TYPE];
 	int curzone[NR_CURSEG_TYPE];
@@ -1557,31 +1559,36 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 		((sbi)->block_count[(curseg)->alloc_type]++)
 #define stat_inc_inplace_blocks(sbi)					\
 		((sbi)->inplace_count++)
-#define stat_inc_seg_count(sbi, type)					\
+#define stat_inc_seg_count(sbi, type, gc_type)				\
 	do {								\
 		struct f2fs_stat_info *si = F2FS_STAT(sbi);		\
 		(si)->tot_segs++;					\
-		if (type == SUM_TYPE_DATA)				\
+		if (type == SUM_TYPE_DATA) {				\
 			si->data_segs++;				\
-		else							\
+			si->bg_data_segs += (gc_type == BG_GC) ? 1 : 0;	\
+		} else {						\
 			si->node_segs++;				\
+			si->bg_node_segs += (gc_type == BG_GC) ? 1 : 0;	\
+		}							\
 	} while (0)
 
 #define stat_inc_tot_blk_count(si, blks)				\
 	(si->tot_blks += (blks))
 
-#define stat_inc_data_blk_count(sbi, blks)				\
+#define stat_inc_data_blk_count(sbi, blks, gc_type)			\
 	do {								\
 		struct f2fs_stat_info *si = F2FS_STAT(sbi);		\
 		stat_inc_tot_blk_count(si, blks);			\
 		si->data_blks += (blks);				\
+		si->bg_data_blks += (gc_type == BG_GC) ? (blks) : 0;	\
 	} while (0)
 
-#define stat_inc_node_blk_count(sbi, blks)				\
+#define stat_inc_node_blk_count(sbi, blks, gc_type)			\
 	do {								\
 		struct f2fs_stat_info *si = F2FS_STAT(sbi);		\
 		stat_inc_tot_blk_count(si, blks);			\
 		si->node_blks += (blks);				\
+		si->bg_node_blks += (gc_type == BG_GC) ? (blks) : 0;	\
 	} while (0)
 
 int f2fs_build_stats(struct f2fs_sb_info *);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index e1fa53a..f67eb2a 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -440,7 +440,7 @@ next_step:
 				set_page_dirty(node_page);
 		}
 		f2fs_put_page(node_page, 1);
-		stat_inc_node_blk_count(sbi, 1);
+		stat_inc_node_blk_count(sbi, 1, gc_type);
 	}
 
 	if (initial) {
@@ -627,7 +627,7 @@ next_step:
 			if (IS_ERR(data_page))
 				continue;
 			move_data_page(inode, data_page, gc_type);
-			stat_inc_data_blk_count(sbi, 1);
+			stat_inc_data_blk_count(sbi, 1, gc_type);
 		}
 	}
 
@@ -685,7 +685,7 @@ static void do_garbage_collect(struct f2fs_sb_info *sbi, unsigned int segno,
 	}
 	blk_finish_plug(&plug);
 
-	stat_inc_seg_count(sbi, GET_SUM_TYPE((&sum->footer)));
+	stat_inc_seg_count(sbi, GET_SUM_TYPE((&sum->footer)), gc_type);
 	stat_inc_call_count(sbi->stat_info);
 
 	f2fs_put_page(sum_page, 1);
-- 
1.9.1

