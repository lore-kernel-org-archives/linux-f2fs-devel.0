From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: fix to overcome inline_data floods
Date: Sat, 23 Jan 2016 12:15:48 -0800
Message-ID: <1453580148-61861-2-git-send-email-jaegeuk@kernel.org>
References: <1453580148-61861-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453580148-61861-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

The scenario is:
1. create lots of node blocks
2. sync
3. write lots of inline_data
-> got panic due to no free space

In that case, we should flush node blocks when writing inline_data in #3,
and trigger gc as well.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 0204433..8686231 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -838,8 +838,15 @@ gc_more:
 
 	if (gc_type == BG_GC && has_not_enough_free_secs(sbi, sec_freed)) {
 		gc_type = FG_GC;
+		/*
+		 * If there is no victim and no prefree segment but still not
+		 * enough free sections, we should flush dent/node blocks and do
+		 * garbage collections.
+		 */
 		if (__get_victim(sbi, &segno, gc_type) || prefree_segments(sbi))
 			write_checkpoint(sbi, &cpc);
+		else if (has_not_enough_free_secs(sbi, 0))
+			write_checkpoint(sbi, &cpc);
 	}
 
 	if (segno == NULL_SEGNO && !__get_victim(sbi, &segno, gc_type))
-- 
2.6.3
