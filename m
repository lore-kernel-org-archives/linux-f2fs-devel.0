From: Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH] f2fs: fix unnecessary periodic wakeup of discard thread when dev is busy
Date: Fri, 31 Aug 2018 15:09:26 +0530
Message-ID: <1535708366-11318-1-git-send-email-stummala@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, Sahitya Tummala <stummala@codeaurora.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

When dev is busy, discard thread wake up timeout can be aligned with the
exact time that it needs to wait for dev to come out of busy. This helps
to avoid unnecessary periodic wakeups and thus save some power.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/segment.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8bcbb50..df14030 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1379,6 +1379,8 @@ static int issue_discard_thread(void *data)
 	struct discard_policy dpolicy;
 	unsigned int wait_ms = DEF_MIN_DISCARD_ISSUE_TIME;
 	int issued;
+	unsigned long interval = sbi->interval_time[REQ_TIME] * HZ;
+	long delta;
 
 	set_freezable();
 
@@ -1410,7 +1412,11 @@ static int issue_discard_thread(void *data)
 			__wait_all_discard_cmd(sbi, &dpolicy);
 			wait_ms = dpolicy.min_interval;
 		} else if (issued == -1){
-			wait_ms = dpolicy.mid_interval;
+			delta = (sbi->last_time[REQ_TIME] + interval) - jiffies;
+			if (delta > 0)
+				wait_ms = jiffies_to_msecs(delta);
+			else
+				wait_ms = dpolicy.mid_interval;
 		} else {
 			wait_ms = dpolicy.max_interval;
 		}
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
