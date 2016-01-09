From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: monitor the number of background checkpoint
Date: Sat,  9 Jan 2016 13:54:53 -0800
Message-ID: <1452376493-25397-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch adds to show the number of background checkpoint.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/debug.c   | 3 ++-
 fs/f2fs/f2fs.h    | 4 +++-
 fs/f2fs/segment.c | 1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index b73e8e1..48f2ae9 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -272,7 +272,8 @@ static int stat_show(struct seq_file *s, void *v)
 			   si->dirty_count);
 		seq_printf(s, "  - Prefree: %d\n  - Free: %d (%d)\n\n",
 			   si->prefree_count, si->free_segs, si->free_secs);
-		seq_printf(s, "CP calls: %d\n", si->cp_count);
+		seq_printf(s, "CP calls: %d (BG: %d)\n",
+				si->cp_count, si->bg_cp_count);
 		seq_printf(s, "GC calls: %d (BG: %d)\n",
 			   si->call_count, si->bg_gc);
 		seq_printf(s, "  - data segments : %d (%d)\n",
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ef6e666..b36249b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1937,7 +1937,7 @@ struct f2fs_stat_info {
 	int util_free, util_valid, util_invalid;
 	int rsvd_segs, overp_segs;
 	int dirty_count, node_pages, meta_pages;
-	int prefree_count, call_count, cp_count;
+	int prefree_count, call_count, cp_count, bg_cp_count;
 	int tot_segs, node_segs, data_segs, free_segs, free_secs;
 	int bg_node_segs, bg_data_segs;
 	int tot_blks, data_blks, node_blks;
@@ -1958,6 +1958,7 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 }
 
 #define stat_inc_cp_count(si)		((si)->cp_count++)
+#define stat_inc_bg_cp_count(si)	((si)->bg_cp_count++)
 #define stat_inc_call_count(si)		((si)->call_count++)
 #define stat_inc_bggc_count(sbi)	((sbi)->bg_gc++)
 #define stat_inc_dirty_inode(sbi, type)	((sbi)->ndirty_inode[type]++)
@@ -2040,6 +2041,7 @@ int __init f2fs_create_root_stats(void);
 void f2fs_destroy_root_stats(void);
 #else
 #define stat_inc_cp_count(si)
+#define stat_inc_bg_cp_count(si)
 #define stat_inc_call_count(si)
 #define stat_inc_bggc_count(si)
 #define stat_inc_dirty_inode(sbi, type)
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index d8ad1ab..5904a41 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -297,6 +297,7 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 		if (test_opt(sbi, DATA_FLUSH))
 			sync_dirty_inodes(sbi, FILE_INODE);
 		f2fs_sync_fs(sbi->sb, true);
+		stat_inc_bg_cp_count(sbi->stat_info);
 	}
 }
 
-- 
2.6.3
