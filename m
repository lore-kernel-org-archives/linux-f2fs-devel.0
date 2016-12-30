From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 01/10] f2fs: reassign new segment for mode=lfs
Date: Fri, 30 Dec 2016 10:51:08 -0800
Message-ID: <20161230185117.3832-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Otherwise we can remain wrong curseg->next_blkoff, resulting in fsck failure.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index be9e4d244d75..4e5ffe1d97e4 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1428,9 +1428,6 @@ void allocate_new_segments(struct f2fs_sb_info *sbi)
 	unsigned int old_segno;
 	int i;
 
-	if (test_opt(sbi, LFS))
-		return;
-
 	for (i = CURSEG_HOT_DATA; i <= CURSEG_COLD_DATA; i++) {
 		curseg = CURSEG_I(sbi, i);
 		old_segno = curseg->segno;
-- 
2.11.0
