From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH] f2fs: issue more large discard command
Date: Fri, 08 Nov 2013 14:46:13 +0900
Message-ID: <1383889573-7727-1-git-send-email-cm224.lee@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Cc: Changman Lee <cm224.lee@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

When f2fs issues discard command, if segment is contiguous,
let's issue more large segment to gather adjacent segments.

** blktrace **
179,1    0     5859    42.619023770   971  C   D 131072 + 2097152 [0]
179,1    0    33665   108.840475468   971  C   D 2228224 + 2494464 [0]
179,1    0    33671   109.131616427   971  C   D 14909440 + 344064 [0]
179,1    0    33677   109.137100677   971  C   D 15261696 + 4096 [0]

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 fs/f2fs/segment.c |   40 ++++++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b7186a3..09f1375 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -141,8 +141,12 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi)
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
 	unsigned int segno = -1;
 	unsigned int total_segs = TOTAL_SEGS(sbi);
+	bool init = true;
+	int count = 0;
+	int start_segno, prev_segno;
 
 	mutex_lock(&dirty_i->seglist_lock);
+
 	while (1) {
 		segno = find_next_bit(dirty_i->dirty_segmap[PRE], total_segs,
 				segno + 1);
@@ -152,15 +156,39 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi)
 		if (test_and_clear_bit(segno, dirty_i->dirty_segmap[PRE]))
 			dirty_i->nr_dirty[PRE]--;
 
-		/* Let's use trim */
-		if (test_opt(sbi, DISCARD))
-			blkdev_issue_discard(sbi->sb->s_bdev,
-					START_BLOCK(sbi, segno) <<
+		if (init) {
+			init = false;
+			start_segno = segno;
+			prev_segno = segno;
+			count = 1;
+			continue;
+		}
+
+		if (segno == prev_segno + 1) {
+			count++;
+			prev_segno = segno;
+		} else {
+			if (test_opt(sbi, DISCARD))
+				blkdev_issue_discard(sbi->sb->s_bdev,
+					START_BLOCK(sbi, start_segno) <<
 					sbi->log_sectors_per_block,
-					1 << (sbi->log_sectors_per_block +
-						sbi->log_blocks_per_seg),
+					(1 << (sbi->log_sectors_per_block +
+					sbi->log_blocks_per_seg)) * count,
 					GFP_NOFS, 0);
+			start_segno = segno;
+			prev_segno = segno;
+			count = 1;
+		}
 	}
+
+	if (count && test_opt(sbi, DISCARD))
+		blkdev_issue_discard(sbi->sb->s_bdev,
+			START_BLOCK(sbi, start_segno) <<
+			sbi->log_sectors_per_block,
+			(1 << (sbi->log_sectors_per_block +
+			       sbi->log_blocks_per_seg)) * count,
+			GFP_NOFS, 0);
+
 	mutex_unlock(&dirty_i->seglist_lock);
 }
 
-- 
1.7.9.5

