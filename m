From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: fix to correct return value of f2fs_trim_fs
Date: Wed, 30 May 2018 18:11:30 +0800
Message-ID: <20180530101131.107083-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

We should account trimmed block number from __wait_all_discard_cmd
in __issue_discard_cmd_range, otherwise trimmed blocks returned
by f2fs_trim_fs will be wrong, this patch fixes it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 4b24a68f4dc7..8ef87f6e0fb2 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1319,15 +1319,13 @@ static unsigned int __wait_discard_cmd_range(struct f2fs_sb_info *sbi,
 	return trimmed;
 }
 
-static void __wait_all_discard_cmd(struct f2fs_sb_info *sbi,
+static unsigned int __wait_all_discard_cmd(struct f2fs_sb_info *sbi,
 						struct discard_policy *dpolicy)
 {
 	struct discard_policy dp;
 
-	if (dpolicy) {
-		__wait_discard_cmd_range(sbi, dpolicy, 0, UINT_MAX);
-		return;
-	}
+	if (dpolicy)
+		return __wait_discard_cmd_range(sbi, dpolicy, 0, UINT_MAX);
 
 	/* wait all */
 	__init_discard_policy(sbi, &dp, DPOLICY_FSTRIM, 1);
@@ -2365,7 +2363,7 @@ bool f2fs_exist_trim_candidates(struct f2fs_sb_info *sbi,
 	return has_candidate;
 }
 
-static void __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
+static unsigned int __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
 					struct discard_policy *dpolicy,
 					unsigned int start, unsigned int end)
 {
@@ -2375,6 +2373,7 @@ static void __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
 	struct discard_cmd *dc;
 	struct blk_plug plug;
 	int issued;
+	unsigned int trimmed = 0;
 
 next:
 	issued = 0;
@@ -2410,7 +2409,7 @@ static void __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
 
 			blk_finish_plug(&plug);
 			mutex_unlock(&dcc->cmd_lock);
-			__wait_all_discard_cmd(sbi, NULL);
+			trimmed += __wait_all_discard_cmd(sbi, NULL);
 			congestion_wait(BLK_RW_ASYNC, HZ/50);
 			goto next;
 		}
@@ -2424,6 +2423,8 @@ static void __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
 
 	blk_finish_plug(&plug);
 	mutex_unlock(&dcc->cmd_lock);
+
+	return trimmed;
 }
 
 int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
@@ -2434,7 +2435,7 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 	block_t start_block, end_block;
 	struct cp_control cpc;
 	struct discard_policy dpolicy;
-	unsigned long long trimmed = 0;
+	unsigned long long trimmed;
 	int err = 0;
 
 	if (start >= MAX_BLKADDR(sbi) || range->len < sbi->blocksize)
@@ -2472,8 +2473,9 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 	end_block = START_BLOCK(sbi, end_segno + 1);
 
 	__init_discard_policy(sbi, &dpolicy, DPOLICY_FSTRIM, cpc.trim_minlen);
-	__issue_discard_cmd_range(sbi, &dpolicy, start_block, end_block);
-	trimmed = __wait_discard_cmd_range(sbi, &dpolicy,
+	trimmed = __issue_discard_cmd_range(sbi, &dpolicy,
+					start_block, end_block);
+	trimmed += __wait_discard_cmd_range(sbi, &dpolicy,
 					start_block, end_block);
 	range->len = F2FS_BLK_TO_BYTES(trimmed);
 out:
-- 
2.17.0.391.g1f1cddd558b5
