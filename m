From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH] f2fs: simplify IS_DATASEG and IS_NODESEG macro
Date: Thu, 21 Nov 2013 20:04:21 +0900
Message-ID: <1385031861-19576-1-git-send-email-cm224.lee@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Cc: Changman Lee <cm224.lee@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

It is not efficient comparing each segment type to find node or data.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 fs/f2fs/segment.h |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 269f690..4ace569 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -21,12 +21,10 @@
 #define GET_R2L_SEGNO(free_i, segno)	(segno + free_i->start_segno)
 
 #define IS_DATASEG(t)							\
-	((t == CURSEG_HOT_DATA) || (t == CURSEG_COLD_DATA) ||		\
-	(t == CURSEG_WARM_DATA))
+	(t <= CURSEG_COLD_DATA)
 
 #define IS_NODESEG(t)							\
-	((t == CURSEG_HOT_NODE) || (t == CURSEG_COLD_NODE) ||		\
-	(t == CURSEG_WARM_NODE))
+	(t >= CURSEG_HOT_NODE)
 
 #define IS_CURSEG(sbi, seg)						\
 	((seg == CURSEG_I(sbi, CURSEG_HOT_DATA)->segno) ||	\
-- 
1.7.9.5

