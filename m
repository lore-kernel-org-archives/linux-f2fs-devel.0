From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: enlarge block plug coverage
Date: Wed, 4 Apr 2018 17:02:06 +0800
Message-ID: <20180404090206.83549-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch enlarges block plug coverage in __issue_discard_cmd, in
order to collect more pending bios before issuing them, to avoid
being disturbed by previous discard I/O in IO aware discard mode.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- fix to move plug to correct place.
 fs/f2fs/segment.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8f0b5ba46315..e61faff9b109 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1202,6 +1202,8 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 	int i, iter = 0, issued = 0;
 	bool io_interrupted = false;
 
+	blk_start_plug(&plug);
+
 	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
 		if (i + 1 < dpolicy->granularity)
 			break;
@@ -1211,7 +1213,6 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 		if (list_empty(pend_list))
 			goto next;
 		f2fs_bug_on(sbi, !__check_rb_tree_consistence(sbi, &dcc->root));
-		blk_start_plug(&plug);
 		list_for_each_entry_safe(dc, tmp, pend_list, list) {
 			f2fs_bug_on(sbi, dc->state != D_PREP);
 
@@ -1227,7 +1228,6 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 			if (++iter >= dpolicy->max_requests)
 				break;
 		}
-		blk_finish_plug(&plug);
 next:
 		mutex_unlock(&dcc->cmd_lock);
 
@@ -1235,6 +1235,8 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 			break;
 	}
 
+	blk_finish_plug(&plug);
+
 	if (!issued && io_interrupted)
 		issued = -1;
 
-- 
2.15.0.55.gc2ece9dc4de6
