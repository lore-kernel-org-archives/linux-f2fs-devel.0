From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev][PATCH] f2fs: remove unused variables in f2fs_sm_info
Date: Wed, 11 Jun 2014 18:32:23 +0800
Message-ID: <006b01cf8560$91034920$b309db60$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Remove unused variables in struct f2fs_sm_info.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/f2fs.h    |    3 ---
 fs/f2fs/segment.c |    2 --
 2 files changed, 5 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e51c732..7ef7acd 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -342,9 +342,6 @@ struct f2fs_sm_info {
 	struct dirty_seglist_info *dirty_info;	/* dirty segment information */
 	struct curseg_info *curseg_array;	/* active segment information */
 
-	struct list_head wblist_head;	/* list of under-writeback pages */
-	spinlock_t wblist_lock;		/* lock for checkpoint */
-
 	block_t seg0_blkaddr;		/* block address of 0'th segment */
 	block_t main_blkaddr;		/* start block address of main area */
 	block_t ssa_blkaddr;		/* start block address of SSA area */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index f25f0e0..b22d5a0 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1885,8 +1885,6 @@ int build_segment_manager(struct f2fs_sb_info *sbi)
 
 	/* init sm info */
 	sbi->sm_info = sm_info;
-	INIT_LIST_HEAD(&sm_info->wblist_head);
-	spin_lock_init(&sm_info->wblist_lock);
 	sm_info->seg0_blkaddr = le32_to_cpu(raw_super->segment0_blkaddr);
 	sm_info->main_blkaddr = le32_to_cpu(raw_super->main_blkaddr);
 	sm_info->segment_count = le32_to_cpu(raw_super->segment_count);
-- 
1.7.9.5
