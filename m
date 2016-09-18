From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to avoid slowing down background gc
Date: Sun, 18 Sep 2016 19:52:27 +0800
Message-ID: <20160918115227.130658-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Previously, we will choose to speed up background gc when the below
conditions are both satisfied:
a. There are a number of invalid blocks
b. There is not enough free space

But, when space utilization is high (utilization > 60%), there will be
not enough invalid blocks, result in slowing down background gc, after
then there are more opportunities that triggering foreground gc due to
high fragmented free space in fs.

Remove condition a) in order to avoid slow down background gc speed in
a high utilization fs.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/gc.h | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index a993967..5d0a19c 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -16,7 +16,6 @@
 #define DEF_GC_THREAD_MIN_SLEEP_TIME	30000	/* milliseconds */
 #define DEF_GC_THREAD_MAX_SLEEP_TIME	60000
 #define DEF_GC_THREAD_NOGC_SLEEP_TIME	300000	/* wait 5 min */
-#define LIMIT_INVALID_BLOCK	40 /* percentage over total user space */
 #define LIMIT_FREE_BLOCK	40 /* percentage over invalid + free space */
 
 /* Search max. number of dirty segments to select a victim segment */
@@ -52,11 +51,6 @@ static inline block_t free_user_blocks(struct f2fs_sb_info *sbi)
 			<< sbi->log_blocks_per_seg;
 }
 
-static inline block_t limit_invalid_user_blocks(struct f2fs_sb_info *sbi)
-{
-	return (long)(sbi->user_block_count * LIMIT_INVALID_BLOCK) / 100;
-}
-
 static inline block_t limit_free_user_blocks(struct f2fs_sb_info *sbi)
 {
 	block_t reclaimable_user_blocks = sbi->user_block_count -
@@ -88,15 +82,9 @@ static inline void decrease_sleep_time(struct f2fs_gc_kthread *gc_th,
 
 static inline bool has_enough_invalid_blocks(struct f2fs_sb_info *sbi)
 {
-	block_t invalid_user_blocks = sbi->user_block_count -
-					written_block_count(sbi);
 	/*
-	 * Background GC is triggered with the following conditions.
-	 * 1. There are a number of invalid blocks.
-	 * 2. There is not enough free space.
+	 * Background GC should speed up when there is not enough free blocks
+	 * in total unused (free + invalid) blocks.
 	 */
-	if (invalid_user_blocks > limit_invalid_user_blocks(sbi) &&
-			free_user_blocks(sbi) < limit_free_user_blocks(sbi))
-		return true;
-	return false;
+	return free_user_blocks(sbi) < limit_free_user_blocks(sbi);
 }
-- 
2.8.2.311.gee88674
