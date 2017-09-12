From: Chao Yu <chao@kernel.org>
Subject: [PATCH v2] f2fs: hurry up to issue discard after io interruption
Date: Tue, 12 Sep 2017 21:35:12 +0800
Message-ID: <20170912133512.7057-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

Once we encounter I/O interruption during issuing discards, we will delay
long time before next round, but if system status is I/O idle during the
time, it may loses opportunity to issue discards. So this patch changes
to hurry up to issue discard after io interruption.

Besides, this patch also fixes to issue discards accurately with assigned
rate.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- remove unneeded judgment condition
- fixes to issue discards accurately with assigned rate
 fs/f2fs/segment.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 7fd742f747ce..dedf0209d820 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1062,6 +1062,7 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi, bool issue_cond)
 	struct blk_plug plug;
 	int iter = 0, issued = 0;
 	int i;
+	bool io_interrupted = false;
 
 	mutex_lock(&dcc->cmd_lock);
 	f2fs_bug_on(sbi,
@@ -1083,11 +1084,20 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi, bool issue_cond)
 				continue;
 			}
 
-			if (!issue_cond || is_idle(sbi)) {
+			if (!issue_cond) {
+				__submit_discard_cmd(sbi, dc);
 				issued++;
+				continue;
+			}
+
+			if (is_idle(sbi)) {
 				__submit_discard_cmd(sbi, dc);
+				issued++;
+			} else {
+				io_interrupted = true;
 			}
-			if (issue_cond && iter++ > DISCARD_ISSUE_RATE)
+
+			if (++iter >= DISCARD_ISSUE_RATE)
 				goto out;
 		}
 		if (list_empty(pend_list) && dcc->pend_list_tag[i] & P_TRIM)
@@ -1097,6 +1107,9 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi, bool issue_cond)
 	blk_finish_plug(&plug);
 	mutex_unlock(&dcc->cmd_lock);
 
+	if (!issued && io_interrupted)
+		issued = -1;
+
 	return issued;
 }
 
-- 
2.14.1.145.gb3622a4ee
