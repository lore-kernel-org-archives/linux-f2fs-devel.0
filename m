From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: fix to return correct trimmed block number in FITRIM interface
Date: Thu, 30 Jun 2016 16:42:47 +0800
Message-ID: <20160630084248.57469-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

During tiggering fstrim, in case of issuing discard for prefree segments,
we miss acclumulating trimmed block number which will be return to user.
Fix it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6d16ecf..5dc14d6 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -732,15 +732,20 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		if (!test_opt(sbi, LFS) || sbi->segs_per_sec == 1) {
 			f2fs_issue_discard(sbi, START_BLOCK(sbi, start),
 				(end - start) << sbi->log_blocks_per_seg);
+			cpc->trimmed +=
+				(end - start) << sbi->log_blocks_per_seg;
 			continue;
 		}
 next:
 		secno = GET_SECNO(sbi, start);
 		start_segno = secno * sbi->segs_per_sec;
 		if (!IS_CURSEC(sbi, secno) &&
-			!get_valid_blocks(sbi, start, sbi->segs_per_sec))
+			!get_valid_blocks(sbi, start, sbi->segs_per_sec)) {
 			f2fs_issue_discard(sbi, START_BLOCK(sbi, start_segno),
 				sbi->segs_per_sec << sbi->log_blocks_per_seg);
+			cpc->trimmed +=
+				sbi->segs_per_sec << sbi->log_blocks_per_seg;
+		}
 
 		start = start_segno + sbi->segs_per_sec;
 		if (start < end)
-- 
2.8.2.311.gee88674
