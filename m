From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: give another chance to issue discard with current granularity
Date: Tue, 3 Jul 2018 20:17:36 +0800
Message-ID: <20180703121736.45229-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

If discard IOs are blocked by user IO, do not skip to select and issue
discard with lower granularity, retry with current granularity.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 60f54ed1413a..13f5e3665bf0 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1199,6 +1199,7 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 		pend_list = &dcc->pend_list[i];
 
 		mutex_lock(&dcc->cmd_lock);
+retry:
 		if (list_empty(pend_list))
 			goto next;
 		if (unlikely(dcc->rbtree_check))
@@ -1221,6 +1222,13 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 				break;
 		}
 		blk_finish_plug(&plug);
+
+		/*
+		 * if discard IO was interrupted by user IOs, give another
+		 * chance to issue discard with current granularity.
+		 */
+		if (io_interrupted)
+			goto retry;
 next:
 		mutex_unlock(&dcc->cmd_lock);
 
-- 
2.18.0.rc1
