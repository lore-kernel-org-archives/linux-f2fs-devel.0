From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH] f2fs: convert max_orphans to a field of f2fs_sb_info
Date: Thu, 26 Dec 2013 18:24:19 +0800
Message-ID: <52BC03D3.2040002@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kim <jaegeuk.kim@samsung.com>
Cc: f2fs <linux-f2fs-devel@lists.sourceforge.net>, fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Previously, we need to calculate the max orphan num when we try to acquire an
orphan inode, but it's a stable value since the super block was inited. So
converting it to a field of f2fs_sb_info and use it directly when needed seems
a better choose.

Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/checkpoint.c |   20 ++++++++++----------
 fs/f2fs/f2fs.h       |    1 +
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 2fc3b6b..0d78bbe 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -194,23 +194,15 @@ const struct address_space_operations f2fs_meta_aops = {
 
 int acquire_orphan_inode(struct f2fs_sb_info *sbi)
 {
-	unsigned int max_orphans;
 	int err = 0;
 
-	/*
-	 * considering 512 blocks in a segment 8 blocks are needed for cp
-	 * and log segment summaries. Remaining blocks are used to keep
-	 * orphan entries with the limitation one reserved segment
-	 * for cp pack we can have max 1020*504 orphan entries
-	 */
-	max_orphans = (sbi->blocks_per_seg - 2 - NR_CURSEG_TYPE)
-				* F2FS_ORPHANS_PER_BLOCK;
 	mutex_lock(&sbi->orphan_inode_mutex);
-	if (unlikely(sbi->n_orphans >= max_orphans))
+	if (unlikely(sbi->n_orphans >= sbi->max_orphans))
 		err = -ENOSPC;
 	else
 		sbi->n_orphans++;
 	mutex_unlock(&sbi->orphan_inode_mutex);
+
 	return err;
 }
 
@@ -834,6 +826,14 @@ void init_orphan_info(struct f2fs_sb_info *sbi)
 	mutex_init(&sbi->orphan_inode_mutex);
 	INIT_LIST_HEAD(&sbi->orphan_inode_list);
 	sbi->n_orphans = 0;
+	/*
+	 * considering 512 blocks in a segment 8 blocks are needed for cp
+	 * and log segment summaries. Remaining blocks are used to keep
+	 * orphan entries with the limitation one reserved segment
+	 * for cp pack we can have max 1020*504 orphan entries
+	 */
+	sbi->max_orphans = (sbi->blocks_per_seg - 2 - NR_CURSEG_TYPE)
+				* F2FS_ORPHANS_PER_BLOCK;
 }
 
 int __init create_checkpoint_caches(void)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1a06f0a..36211cb 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -414,6 +414,7 @@ struct f2fs_sb_info {
 	struct list_head orphan_inode_list;	/* orphan inode list */
 	struct mutex orphan_inode_mutex;	/* for orphan inode list */
 	unsigned int n_orphans;			/* # of orphan inodes */
+	unsigned int max_orphans;		/* max orphan inodes */
 
 	/* for directory inode management */
 	struct list_head dir_inode_list;	/* dir inode list */
-- 
1.7.7
