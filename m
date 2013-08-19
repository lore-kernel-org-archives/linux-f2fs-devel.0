From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH] f2fs: fix a compound statement label error
Date: Mon, 19 Aug 2013 09:50:59 +0800
Message-ID: <52117A03.4030800@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kim <jaegeuk.kim@samsung.com>
Cc: f2fs <linux-f2fs-devel@lists.sourceforge.net>, linux-kernel <linux-kernel@vger.kernel.org>, Fengguang Wu <fengguang.wu@intel.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

>From 685b72b66cb8ce019429b1958c91f346b260bc65 Mon Sep 17 00:00:00 2001
From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Date: Mon, 19 Aug 2013 09:41:15 +0800
Subject: [PATCH] f2fs: fix a compound statement label error
An error "label at end of compound statement" will occur if CONFIG_F2FS_STAT_FS
disabled.
fs/f2fs/segment.c:556:1: error: label at end of compound statement
So clean up the 'out' label to fix it.

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/segment.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 9c45b8e..09af9c7 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -540,12 +540,9 @@ static void allocate_segment_by_default(struct f2fs_sb_info *sbi,
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
 
-	if (force) {
+	if (force)
 		new_curseg(sbi, type, true);
-		goto out;
-	}
-
-	if (type == CURSEG_WARM_NODE)
+	else if (type == CURSEG_WARM_NODE)
 		new_curseg(sbi, type, false);
 	else if (curseg->alloc_type == LFS && is_next_segment_free(sbi, type))
 		new_curseg(sbi, type, false);
@@ -553,7 +550,6 @@ static void allocate_segment_by_default(struct f2fs_sb_info *sbi,
 		change_curseg(sbi, type, true);
 	else
 		new_curseg(sbi, type, false);
-out:
 #ifdef CONFIG_F2FS_STAT_FS
 	sbi->segment_count[curseg->alloc_type]++;
 #endif
-- 
1.7.7
