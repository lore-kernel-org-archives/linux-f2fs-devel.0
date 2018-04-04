From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: enlarge block plug coverage
Date: Wed, 4 Apr 2018 16:54:04 +0800
Message-ID: <20180404085404.82184-1-yuchao0@huawei.com>
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
 fs/f2fs/segment.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8f0b5ba46315..4287e208c040 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1208,10 +1208,12 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 		pend_list = &dcc->pend_list[i];
 
 		mutex_lock(&dcc->cmd_lock);
+
+		blk_start_plug(&plug);
+
 		if (list_empty(pend_list))
 			goto next;
 		f2fs_bug_on(sbi, !__check_rb_tree_consistence(sbi, &dcc->root));
-		blk_start_plug(&plug);
 		list_for_each_entry_safe(dc, tmp, pend_list, list) {
 			f2fs_bug_on(sbi, dc->state != D_PREP);
 
@@ -1227,8 +1229,9 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 			if (++iter >= dpolicy->max_requests)
 				break;
 		}
-		blk_finish_plug(&plug);
 next:
+		blk_finish_plug(&plug);
+
 		mutex_unlock(&dcc->cmd_lock);
 
 		if (iter >= dpolicy->max_requests)
-- 
2.15.0.55.gc2ece9dc4de6
