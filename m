From: Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix out-of-order execution in f2fs_issue_flush
Date: Mon, 21 Aug 2017 22:53:45 +0800
Message-ID: <20170821145345.3828-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

In f2fs_issue_flush, due to out-of-order execution of CPU, wake_up can
be called before we insert issue_list, result in long latency of
wait_for_completion. Fix this by adding smp_mb() to force the order of
related codes.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index dd97d2f282a6..29de70b7a6c0 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -549,7 +549,10 @@ int f2fs_issue_flush(struct f2fs_sb_info *sbi)
 	atomic_inc(&fcc->issing_flush);
 	llist_add(&cmd.llnode, &fcc->issue_list);
 
-	if (!fcc->dispatch_list)
+	/* update issue_list before we wake up issue_flush thread */
+	smp_mb();
+
+	if (waitqueue_active(&fcc->flush_wait_queue))
 		wake_up(&fcc->flush_wait_queue);
 
 	if (fcc->f2fs_issue_flush) {
-- 
2.14.1.145.gb3622a4ee
