From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: use wq_has_sleeper for cp_wait wait_queue
Date: Tue, 26 Jan 2016 12:01:03 -0800
Message-ID: <1453838463-42536-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

We need to use wq_has_sleeper including smp_mb to consider cp_wait concurrency.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d0675e5..df4d4cc 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -74,8 +74,7 @@ static void f2fs_write_end_io(struct bio *bio)
 		dec_page_count(sbi, F2FS_WRITEBACK);
 	}
 
-	if (!get_pages(sbi, F2FS_WRITEBACK) &&
-			!list_empty(&sbi->cp_wait.task_list))
+	if (!get_pages(sbi, F2FS_WRITEBACK) && wq_has_sleeper(&sbi->cp_wait))
 		wake_up(&sbi->cp_wait);
 
 	bio_put(bio);
-- 
2.6.3
