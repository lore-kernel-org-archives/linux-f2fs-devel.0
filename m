From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 3/4] f2fs: avoid high cpu usage in discard thread
Date: Mon, 8 Jan 2018 18:48:33 +0800
Message-ID: <20180108104834.108983-3-yuchao0@huawei.com>
References: <20180108104834.108983-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180108104834.108983-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

We take very long time to finish generic/476, this is because we will
check consistence of all discard entries in global rb tree while
traversing all different granularity pending lists, even when the list
is empty, in order to avoid that unneeded overhead, we have to skip
the check when coming up an empty list.

generic/476 time consumption:
					cost
Before patch & w/o consistence check	57s
Before patch & w/ consistence check	1426s
After patch				78s

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index f2842a8a1341..4a40ef1326a9 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1204,6 +1204,8 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 		pend_list = &dcc->pend_list[i];
 
 		mutex_lock(&dcc->cmd_lock);
+		if (list_empty(pend_list))
+			goto next;
 		f2fs_bug_on(sbi, !__check_rb_tree_consistence(sbi, &dcc->root));
 		blk_start_plug(&plug);
 		list_for_each_entry_safe(dc, tmp, pend_list, list) {
@@ -1222,6 +1224,7 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 				break;
 		}
 		blk_finish_plug(&plug);
+next:
 		mutex_unlock(&dcc->cmd_lock);
 
 		if (iter >= dpolicy->max_requests)
-- 
2.15.0.55.gc2ece9dc4de6
