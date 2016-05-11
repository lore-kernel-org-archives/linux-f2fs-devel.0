From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: show # of orphan inodes
Date: Wed, 11 May 2016 10:01:08 -0700
Message-ID: <1462986069-19630-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This adds debug information for # of orphan inodes.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/debug.c | 5 ++++-
 fs/f2fs/f2fs.h  | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 818064b..37615b2 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -58,6 +58,7 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->inline_xattr = atomic_read(&sbi->inline_xattr);
 	si->inline_inode = atomic_read(&sbi->inline_inode);
 	si->inline_dir = atomic_read(&sbi->inline_dir);
+	si->orphans = sbi->im[ORPHAN_INO].ino_num;
 	si->utilization = utilization(sbi);
 
 	si->free_segs = free_segments(sbi);
@@ -192,7 +193,7 @@ get_cache:
 	si->cache_mem += NM_I(sbi)->dirty_nat_cnt *
 					sizeof(struct nat_entry_set);
 	si->cache_mem += si->inmem_pages * sizeof(struct inmem_pages);
-	for (i = 0; i <= UPDATE_INO; i++)
+	for (i = 0; i <= ORPHAN_INO; i++)
 		si->cache_mem += sbi->im[i].ino_num * sizeof(struct ino_entry);
 	si->cache_mem += atomic_read(&sbi->total_ext_tree) *
 						sizeof(struct extent_tree);
@@ -238,6 +239,8 @@ static int stat_show(struct seq_file *s, void *v)
 			   si->inline_inode);
 		seq_printf(s, "  - Inline_dentry Inode: %u\n",
 			   si->inline_dir);
+		seq_printf(s, "  - Orphan Inode: %u\n",
+			   si->orphans);
 		seq_printf(s, "\nMain area: %d segs, %d secs %d zones\n",
 			   si->main_area_segs, si->main_area_sections,
 			   si->main_area_zones);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1401c96..ec978b44 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1997,7 +1997,7 @@ struct f2fs_stat_info {
 	int nats, dirty_nats, sits, dirty_sits, fnids;
 	int total_count, utilization;
 	int bg_gc, inmem_pages, wb_pages;
-	int inline_xattr, inline_inode, inline_dir;
+	int inline_xattr, inline_inode, inline_dir, orphans;
 	unsigned int valid_count, valid_node_count, valid_inode_count;
 	unsigned int bimodal, avg_vblocks;
 	int util_free, util_valid, util_invalid;
-- 
2.6.3
