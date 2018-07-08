From: Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: stop issuing discard immediately if there is queued IO
Date: Sun,  8 Jul 2018 22:08:09 +0800
Message-ID: <20180708140809.23571-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

For background discard policy, even if there is queued user IO, still
we will check max_requests times for next discard entry, it is unneeded,
let's just stop this round submission immediately.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 99beaf0a2dea..aee198869b1f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1190,7 +1190,7 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 	struct list_head *pend_list;
 	struct discard_cmd *dc, *tmp;
 	struct blk_plug plug;
-	int i, iter = 0, issued = 0;
+	int i, issued = 0;
 	bool io_interrupted = false;
 
 	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
@@ -1211,20 +1211,19 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 			if (dpolicy->io_aware && i < dpolicy->io_aware_gran &&
 								!is_idle(sbi)) {
 				io_interrupted = true;
-				goto skip;
+				break;
 			}
 
 			__submit_discard_cmd(sbi, dpolicy, dc);
-			issued++;
-skip:
-			if (++iter >= dpolicy->max_requests)
+
+			if (++issued >= dpolicy->max_requests)
 				break;
 		}
 		blk_finish_plug(&plug);
 next:
 		mutex_unlock(&dcc->cmd_lock);
 
-		if (iter >= dpolicy->max_requests)
+		if (issued >= dpolicy->max_requests || io_interrupted)
 			break;
 	}
 
-- 
2.16.2.17.g38e79b1fd
