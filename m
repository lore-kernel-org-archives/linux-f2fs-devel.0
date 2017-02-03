From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/5] f2fs: show # of APPEND and UPDATE inodes
Date: Fri,  3 Feb 2017 15:48:12 -0800
Message-ID: <20170203234816.12723-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch shows cached # of APPEND and UPDATE inode entries.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/debug.c | 6 ++++--
 fs/f2fs/f2fs.h  | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 0ca977a94c13..de8da9fc5c99 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -70,6 +70,8 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->inline_xattr = atomic_read(&sbi->inline_xattr);
 	si->inline_inode = atomic_read(&sbi->inline_inode);
 	si->inline_dir = atomic_read(&sbi->inline_dir);
+	si->append = sbi->im[APPEND_INO].ino_num;
+	si->update = sbi->im[UPDATE_INO].ino_num;
 	si->orphans = sbi->im[ORPHAN_INO].ino_num;
 	si->utilization = utilization(sbi);
 
@@ -264,8 +266,8 @@ static int stat_show(struct seq_file *s, void *v)
 			   si->inline_inode);
 		seq_printf(s, "  - Inline_dentry Inode: %u\n",
 			   si->inline_dir);
-		seq_printf(s, "  - Orphan Inode: %u\n",
-			   si->orphans);
+		seq_printf(s, "  - Orphan/Append/Update Inode: %u, %u, %u\n",
+			   si->orphans, si->append, si->update);
 		seq_printf(s, "\nMain area: %d segs, %d secs %d zones\n",
 			   si->main_area_segs, si->main_area_sections,
 			   si->main_area_zones);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e97b4a0453d8..23b34d01e454 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2293,7 +2293,7 @@ struct f2fs_stat_info {
 	int nats, dirty_nats, sits, dirty_sits, free_nids, alloc_nids;
 	int total_count, utilization;
 	int bg_gc, nr_wb_cp_data, nr_wb_data, nr_flush, nr_discard;
-	int inline_xattr, inline_inode, inline_dir, orphans;
+	int inline_xattr, inline_inode, inline_dir, append, update, orphans;
 	int aw_cnt, max_aw_cnt;
 	unsigned int valid_count, valid_node_count, valid_inode_count, discard_blks;
 	unsigned int bimodal, avg_vblocks;
-- 
2.11.0
