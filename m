From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: fix a deadlock for summary page lock vs. sentry_lock
Date: Fri, 29 May 2015 11:04:38 -0700
Message-ID: <1432922678-22578-2-git-send-email-jaegeuk@kernel.org>
References: <1432922678-22578-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432922678-22578-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

In f2fs_gc:                      In f2fs_replace_block:
 - lock_page(sum_page)
  - check_valid_map()            - mutex_lock(sentry_lock)
   - mutex_lock(sentry_lock)     - change_curseg()
                                  - lock_page(sum_page)

This patch fixes the deadlock condition.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 43354cb..e1e7361 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -750,6 +750,15 @@ static void do_garbage_collect(struct f2fs_sb_info *sbi, unsigned int segno,
 
 	sum = page_address(sum_page);
 
+	/*
+	 * this is to avoid deadlock:
+	 * - lock_page(sum_page)         - f2fs_replace_block
+	 *  - check_valid_map()            - mutex_lock(sentry_lock)
+	 *   - mutex_lock(sentry_lock)     - change_curseg()
+	 *                                  - lock_page(sum_page)
+	 */
+	unlock_page(sum_page);
+
 	switch (GET_SUM_TYPE((&sum->footer))) {
 	case SUM_TYPE_NODE:
 		gc_node_segment(sbi, sum->entries, segno, gc_type);
@@ -763,7 +772,7 @@ static void do_garbage_collect(struct f2fs_sb_info *sbi, unsigned int segno,
 	stat_inc_seg_count(sbi, GET_SUM_TYPE((&sum->footer)), gc_type);
 	stat_inc_call_count(sbi->stat_info);
 
-	f2fs_put_page(sum_page, 1);
+	f2fs_put_page(sum_page, 0);
 }
 
 int f2fs_gc(struct f2fs_sb_info *sbi)
-- 
2.1.1
