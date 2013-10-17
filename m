From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH] f2fs: avoid to write during the recovery
Date: Thu, 17 Oct 2013 17:31:12 +0900
Message-ID: <1381998672-19014-1-git-send-email-jaegeuk.kim@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk.kim@samsung.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch enhances the recovery routine not to write any data/node/meta until
its completion.
If any writes are sent to the disk, it could contaminate the written history
that will be used for further recovery.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/checkpoint.c |  2 +-
 fs/f2fs/node.c       | 17 +++++++++++------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 2a5999d..8d16071 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -81,7 +81,7 @@ static int f2fs_write_meta_page(struct page *page,
 	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
 
 	/* Should not write any meta pages, if any IO error was occurred */
-	if (wbc->for_reclaim ||
+	if (wbc->for_reclaim || sbi->por_doing ||
 			is_set_ckpt_flags(F2FS_CKPT(sbi), CP_ERROR_FLAG)) {
 		dec_page_count(sbi, F2FS_DIRTY_META);
 		wbc->pages_skipped++;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 51ef278..ef80f79 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1156,6 +1156,9 @@ static int f2fs_write_node_page(struct page *page,
 	block_t new_addr;
 	struct node_info ni;
 
+	if (sbi->por_doing)
+		goto redirty_out;
+
 	wait_on_page_writeback(page);
 
 	/* get old block addr of this node page */
@@ -1171,12 +1174,8 @@ static int f2fs_write_node_page(struct page *page,
 		return 0;
 	}
 
-	if (wbc->for_reclaim) {
-		dec_page_count(sbi, F2FS_DIRTY_NODES);
-		wbc->pages_skipped++;
-		set_page_dirty(page);
-		return AOP_WRITEPAGE_ACTIVATE;
-	}
+	if (wbc->for_reclaim)
+		goto redirty_out;
 
 	mutex_lock(&sbi->node_write);
 	set_page_writeback(page);
@@ -1186,6 +1185,12 @@ static int f2fs_write_node_page(struct page *page,
 	mutex_unlock(&sbi->node_write);
 	unlock_page(page);
 	return 0;
+
+redirty_out:
+	dec_page_count(sbi, F2FS_DIRTY_NODES);
+	wbc->pages_skipped++;
+	set_page_dirty(page);
+	return AOP_WRITEPAGE_ACTIVATE;
 }
 
 /*
-- 
1.8.4.474.g128a96c
