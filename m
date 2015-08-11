From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: do not assing a new segment for dio under space shortage
Date: Tue, 11 Aug 2015 11:33:46 -0700
Message-ID: <1439318026-16036-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

If there is not enough free segment, we should not assign a new segment
explicitly. Otherwise, we can run out of free segment.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 7d53cb4..bf1605d 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1225,7 +1225,8 @@ void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 	mutex_lock(&sit_i->sentry_lock);
 
 	/* direct_io'ed data is aligned to the segment for better performance */
-	if (direct_io && curseg->next_blkoff)
+	if (direct_io && curseg->next_blkoff &&
+				!has_not_enough_free_secs(sbi, 0))
 		__allocate_new_segments(sbi, type);
 
 	*new_blkaddr = NEXT_FREE_BLKADDR(sbi, curseg);
-- 
2.1.1
