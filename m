From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH] f2fs: fix the way to wake up issue_flush thread
Date: Thu, 3 May 2018 15:45:43 +0800
Message-ID: <1525333543-106702-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Commit 6f890df0 ("f2fs: fix out-of-order execution in f2fs_issue_flush")
uses waitqueue_active to wake up issue_flush thread, but there is no
wait entry to wake in this queue, so change it back to use the original
fcc->dispatch_list to wake up issue_flush thread.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 503a98a..5aa5ee4e 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -612,7 +612,7 @@ int f2fs_issue_flush(struct f2fs_sb_info *sbi, nid_t ino)
 	/* update issue_list before we wake up issue_flush thread */
 	smp_mb();
 
-	if (waitqueue_active(&fcc->flush_wait_queue))
+	if (!fcc->dispatch_list)
 		wake_up(&fcc->flush_wait_queue);
 
 	if (fcc->f2fs_issue_flush) {
-- 
1.8.5.2
