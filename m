From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to correct return value of f2fs_trim_fs
Date: Mon, 25 Jun 2018 20:33:24 +0800
Message-ID: <20180625123324.88616-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fXQhP-0006Og-Vy
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 25 Jun 2018 12:34:27 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fXQhN-008nG3-Jw
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 25 Jun 2018 12:34:27 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

We should account trimmed block number from __wait_all_discard_cmd
in __issue_discard_cmd_range, otherwise trimmed blocks returned
by f2fs_trim_fs will be wrong, this patch fixes it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b613d2a64586..cb509760fb45 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1320,21 +1320,22 @@ static unsigned int __wait_discard_cmd_range(struct f2fs_sb_info *sbi,
 	return trimmed;
 }
 
-static void __wait_all_discard_cmd(struct f2fs_sb_info *sbi,
+static unsigned int __wait_all_discard_cmd(struct f2fs_sb_info *sbi,
 						struct discard_policy *dpolicy)
 {
 	struct discard_policy dp;
+	unsigned int discard_blks;
 
-	if (dpolicy) {
-		__wait_discard_cmd_range(sbi, dpolicy, 0, UINT_MAX);
-		return;
-	}
+	if (dpolicy)
+		return __wait_discard_cmd_range(sbi, dpolicy, 0, UINT_MAX);
 
 	/* wait all */
 	__init_discard_policy(sbi, &dp, DPOLICY_FSTRIM, 1);
-	__wait_discard_cmd_range(sbi, &dp, 0, UINT_MAX);
+	discard_blks = __wait_discard_cmd_range(sbi, &dp, 0, UINT_MAX);
 	__init_discard_policy(sbi, &dp, DPOLICY_UMOUNT, 1);
-	__wait_discard_cmd_range(sbi, &dp, 0, UINT_MAX);
+	discard_blks += __wait_discard_cmd_range(sbi, &dp, 0, UINT_MAX);
+
+	return discard_blks;
 }
 
 /* This should be covered by global mutex, &sit_i->sentry_lock */
@@ -2368,7 +2369,7 @@ bool f2fs_exist_trim_candidates(struct f2fs_sb_info *sbi,
 	return has_candidate;
 }
 
-static void __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
+static unsigned int __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
 					struct discard_policy *dpolicy,
 					unsigned int start, unsigned int end)
 {
@@ -2378,6 +2379,7 @@ static void __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
 	struct discard_cmd *dc;
 	struct blk_plug plug;
 	int issued;
+	unsigned int trimmed = 0;
 
 next:
 	issued = 0;
@@ -2415,7 +2417,7 @@ static void __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
 
 			blk_finish_plug(&plug);
 			mutex_unlock(&dcc->cmd_lock);
-			__wait_all_discard_cmd(sbi, NULL);
+			trimmed += __wait_all_discard_cmd(sbi, NULL);
 			congestion_wait(BLK_RW_ASYNC, HZ/50);
 			goto next;
 		}
@@ -2429,6 +2431,8 @@ static void __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
 
 	blk_finish_plug(&plug);
 	mutex_unlock(&dcc->cmd_lock);
+
+	return trimmed;
 }
 
 int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
@@ -2486,9 +2490,10 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 	end_block = START_BLOCK(sbi, end_segno + 1);
 
 	__init_discard_policy(sbi, &dpolicy, DPOLICY_FSTRIM, cpc.trim_minlen);
-	__issue_discard_cmd_range(sbi, &dpolicy, start_block, end_block);
+	trimmed = __issue_discard_cmd_range(sbi, &dpolicy,
+					start_block, end_block);
 
-	trimmed = __wait_discard_cmd_range(sbi, &dpolicy,
+	trimmed += __wait_discard_cmd_range(sbi, &dpolicy,
 					start_block, end_block);
 	range->len = F2FS_BLK_TO_BYTES(trimmed);
 out:
-- 
2.18.0.rc1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
