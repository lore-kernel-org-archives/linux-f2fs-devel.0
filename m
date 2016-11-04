From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: assign segments correctly for direct_io
Date: Fri,  4 Nov 2016 15:56:50 -0700
Message-ID: <20161104225651.4618-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Previously, we assigned CURSEG_WARM_DATA for direct_io, but if we have two or
four logs, we do not use that type at all.
Let's fix it.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6ba4cd4..819209b 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1501,8 +1501,12 @@ void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 	struct curseg_info *curseg;
 	bool direct_io = (type == CURSEG_DIRECT_IO);
 
-	type = direct_io ? CURSEG_WARM_DATA : type;
-
+	if (direct_io) {
+		if (sbi->active_logs <= 4)
+			type = CURSEG_HOT_DATA;
+		else
+			type = CURSEG_WARM_DATA;
+	}
 	curseg = CURSEG_I(sbi, type);
 
 	mutex_lock(&curseg->curseg_mutex);
-- 
2.8.3
