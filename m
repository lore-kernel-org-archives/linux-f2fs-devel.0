From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH] f2fs: show counts of checkpoint in status
Date: Thu, 13 Feb 2014 15:12:29 +0900
Message-ID: <1392271949-12284-1-git-send-email-cm224.lee@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Cc: Changman Lee <cm224.lee@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch shows the counts of checkpoint in f2fs' status.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 fs/f2fs/checkpoint.c |    1 +
 fs/f2fs/debug.c      |    1 +
 fs/f2fs/f2fs.h       |    4 +++-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 8f5dff1..0482354 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -837,6 +837,7 @@ void write_checkpoint(struct f2fs_sb_info *sbi, bool is_umount)
 	unblock_operations(sbi);
 	mutex_unlock(&sbi->cp_mutex);
 
+	stat_inc_cp_count(sbi->stat_info);
 	trace_f2fs_write_checkpoint(sbi->sb, is_umount, "finish checkpoint");
 }
 
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 3de9d20..46a12e4 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -236,6 +236,7 @@ static int stat_show(struct seq_file *s, void *v)
 			   si->dirty_count);
 		seq_printf(s, "  - Prefree: %d\n  - Free: %d (%d)\n\n",
 			   si->prefree_count, si->free_segs, si->free_secs);
+		seq_printf(s, "CP calls: %d\n", si->cp_count);
 		seq_printf(s, "GC calls: %d (BG: %d)\n",
 			   si->call_count, si->bg_gc);
 		seq_printf(s, "  - data segments : %d\n", si->data_segs);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index aeff132..91a4cd1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1240,7 +1240,7 @@ struct f2fs_stat_info {
 	int util_free, util_valid, util_invalid;
 	int rsvd_segs, overp_segs;
 	int dirty_count, node_pages, meta_pages;
-	int prefree_count, call_count;
+	int prefree_count, call_count, cp_count;
 	int tot_segs, node_segs, data_segs, free_segs, free_secs;
 	int tot_blks, data_blks, node_blks;
 	int curseg[NR_CURSEG_TYPE];
@@ -1257,6 +1257,7 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 	return (struct f2fs_stat_info *)sbi->stat_info;
 }
 
+#define stat_inc_cp_count(si)		((si)->cp_count++)
 #define stat_inc_call_count(si)		((si)->call_count++)
 #define stat_inc_bggc_count(sbi)	((sbi)->bg_gc++)
 #define stat_inc_dirty_dir(sbi)		((sbi)->n_dirty_dirs++)
@@ -1311,6 +1312,7 @@ void f2fs_destroy_stats(struct f2fs_sb_info *);
 void __init f2fs_create_root_stats(void);
 void f2fs_destroy_root_stats(void);
 #else
+#define stat_inc_cp_count(si)
 #define stat_inc_call_count(si)
 #define stat_inc_bggc_count(si)
 #define stat_inc_dirty_dir(sbi)
-- 
1.7.10.4

