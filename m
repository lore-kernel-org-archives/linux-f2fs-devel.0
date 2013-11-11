From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH v2] f2fs: issue more large discard command
Date: Mon, 11 Nov 2013 09:24:37 +0900
Message-ID: <1384129477-7845-1-git-send-email-cm224.lee@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Cc: Changman Lee <cm224.lee@samsung.com>, Jaegeuk Kim <jaegeuk.kim@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

o Changes from v1
  Use find_next(_zero)_bit suggested by jg.kim

When f2fs issues discard command, if segment is contiguous,
let's issue more large segment to gather adjacent segments.

** blktrace **
179,1    0     5859    42.619023770   971  C   D 131072 + 2097152 [0]
179,1    0    33665   108.840475468   971  C   D 2228224 + 2494464 [0]
179,1    0    33671   109.131616427   971  C   D 14909440 + 344064 [0]
179,1    0    33677   109.137100677   971  C   D 15261696 + 4096 [0]

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/segment.c |   36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 3d4d5fc..8d329c3 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -139,27 +139,33 @@ static void set_prefree_as_free_segments(struct f2fs_sb_info *sbi)
 void clear_prefree_segments(struct f2fs_sb_info *sbi)
 {
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
-	unsigned int segno = -1;
+	unsigned long *prefree_map = dirty_i->dirty_segmap[PRE];
 	unsigned int total_segs = TOTAL_SEGS(sbi);
+	unsigned int start = 0, end = -1;
 
 	mutex_lock(&dirty_i->seglist_lock);
+
 	while (1) {
-		segno = find_next_bit(dirty_i->dirty_segmap[PRE], total_segs,
-				segno + 1);
-		if (segno >= total_segs)
+		int i;
+		start = find_next_bit(prefree_map, total_segs, end + 1);
+		if (start >= total_segs)
 			break;
+		end = find_next_zero_bit(prefree_map, total_segs, start + 1);
+
+		for (i = start; i < end; i++)
+			clear_bit(i, prefree_map);
+
+		dirty_i->nr_dirty[PRE] -= end - start;
+
+		if (!test_opt(sbi, DISCARD))
+			continue;
 
-		if (test_and_clear_bit(segno, dirty_i->dirty_segmap[PRE]))
-			dirty_i->nr_dirty[PRE]--;
-
-		/* Let's use trim */
-		if (test_opt(sbi, DISCARD))
-			blkdev_issue_discard(sbi->sb->s_bdev,
-					START_BLOCK(sbi, segno) <<
-					sbi->log_sectors_per_block,
-					1 << (sbi->log_sectors_per_block +
-						sbi->log_blocks_per_seg),
-					GFP_NOFS, 0);
+		blkdev_issue_discard(sbi->sb->s_bdev,
+				START_BLOCK(sbi, start) <<
+				sbi->log_sectors_per_block,
+				(1 << (sbi->log_sectors_per_block +
+				sbi->log_blocks_per_seg)) * (end - start),
+				GFP_NOFS, 0);
 	}
 	mutex_unlock(&dirty_i->seglist_lock);
 }
-- 
1.7.10.4

