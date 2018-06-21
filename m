From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: don't issue discard commands in online discard is on
Date: Thu, 21 Jun 2018 11:05:18 -0700
Message-ID: <20180621180518.76856-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Actually, we don't need to issue discard commands, if discard is on, as
mentioned in the comment.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6dbdf2c48fba..553075973be4 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2469,23 +2469,24 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 	if (err)
 		goto out;
 
-	start_block = START_BLOCK(sbi, start_segno);
-	end_block = START_BLOCK(sbi, end_segno + 1);
-
-	__init_discard_policy(sbi, &dpolicy, DPOLICY_FSTRIM, cpc.trim_minlen);
-	__issue_discard_cmd_range(sbi, &dpolicy, start_block, end_block);
-
 	/*
 	 * We filed discard candidates, but actually we don't need to wait for
 	 * all of them, since they'll be issued in idle time along with runtime
 	 * discard option. User configuration looks like using runtime discard
 	 * or periodic fstrim instead of it.
 	 */
-	if (!test_opt(sbi, DISCARD)) {
-		trimmed = __wait_discard_cmd_range(sbi, &dpolicy,
+	if (test_opt(sbi, DISCARD))
+		goto out;
+
+	start_block = START_BLOCK(sbi, start_segno);
+	end_block = START_BLOCK(sbi, end_segno + 1);
+
+	__init_discard_policy(sbi, &dpolicy, DPOLICY_FSTRIM, cpc.trim_minlen);
+	__issue_discard_cmd_range(sbi, &dpolicy, start_block, end_block);
+
+	trimmed = __wait_discard_cmd_range(sbi, &dpolicy,
 					start_block, end_block);
-		range->len = F2FS_BLK_TO_BYTES(trimmed);
-	}
+	range->len = F2FS_BLK_TO_BYTES(trimmed);
 out:
 	return err;
 }
-- 
2.17.0.441.gb46fe60e1d-goog
