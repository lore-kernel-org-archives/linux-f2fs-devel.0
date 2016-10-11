From: Chao Yu <chao@kernel.org>
Subject: [PATCH 4/7] f2fs: show pending allocated nids count in debugfs
Date: Tue, 11 Oct 2016 22:31:33 +0800
Message-ID: <20161011143136.2107-4-chao@kernel.org>
References: <20161011143136.2107-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161011143136.2107-1-chao@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

Add to show pending allocated nids count in debugfs.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/debug.c | 7 ++++---
 fs/f2fs/f2fs.h  | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 9789138..05a70b4 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -74,7 +74,8 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->dirty_nats = NM_I(sbi)->dirty_nat_cnt;
 	si->sits = MAIN_SEGS(sbi);
 	si->dirty_sits = SIT_I(sbi)->dirty_sentries;
-	si->fnids = NM_I(sbi)->free_nid_cnt;
+	si->free_nids = NM_I(sbi)->free_nid_cnt;
+	si->alloc_nids = NM_I(sbi)->alloc_nid_cnt;
 	si->bg_gc = sbi->bg_gc;
 	si->util_free = (int)(free_user_blocks(sbi) >> sbi->log_blocks_per_seg)
 		* 100 / (int)(sbi->user_block_count >> sbi->log_blocks_per_seg)
@@ -325,8 +326,8 @@ static int stat_show(struct seq_file *s, void *v)
 			   si->ndirty_imeta);
 		seq_printf(s, "  - NATs: %9d/%9d\n  - SITs: %9d/%9d\n",
 			   si->dirty_nats, si->nats, si->dirty_sits, si->sits);
-		seq_printf(s, "  - free_nids: %9d\n",
-			   si->fnids);
+		seq_printf(s, "  - free_nids: %9d, alloc_nids: %9d\n",
+			   si->free_nids, si->alloc_nids);
 		seq_puts(s, "\nDistribution of User Blocks:");
 		seq_puts(s, " [ valid | invalid | free ]\n");
 		seq_puts(s, "  [");
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d6dff15..a726e47 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2206,7 +2206,7 @@ struct f2fs_stat_info {
 	s64 ndirty_node, ndirty_dent, ndirty_meta, ndirty_data, ndirty_imeta;
 	s64 inmem_pages;
 	unsigned int ndirty_dirs, ndirty_files, ndirty_all;
-	int nats, dirty_nats, sits, dirty_sits, fnids;
+	int nats, dirty_nats, sits, dirty_sits, free_nids, alloc_nids;
 	int total_count, utilization;
 	int bg_gc, wb_bios;
 	int inline_xattr, inline_inode, inline_dir, orphans;
-- 
2.10.1
