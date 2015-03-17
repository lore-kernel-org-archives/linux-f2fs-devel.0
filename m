From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/4] f2fs: fix to cover sentry_lock for block allocation
Date: Tue, 17 Mar 2015 09:57:38 -0700
Message-ID: <1426611461-690-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

In the following call stack, f2fs changes the bitmap for dirty segments and # of
dirty sentries without grabbing sit_i->sentry_lock.
This can result in mismatch on bitmap and # of dirty sentries, since if there
are some direct_io operations.

In allocate_data_block,
 - __allocate_new_segments
  - mutex_lock(&curseg->curseg_mutex);
  - s_ops->allocate_segment
   - new_curseg/change_curseg
    - reset_curseg
     - __set_sit_entry_type
      - __mark_sit_entry_dirty
       - set_bit(dirty_sentries_bitmap)
       - dirty_sentries++;

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 3e80bd6..eafaf72 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1167,6 +1167,7 @@ void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 	curseg = CURSEG_I(sbi, type);
 
 	mutex_lock(&curseg->curseg_mutex);
+	mutex_lock(&sit_i->sentry_lock);
 
 	/* direct_io'ed data is aligned to the segment for better performance */
 	if (direct_io && curseg->next_blkoff)
@@ -1181,7 +1182,6 @@ void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 	 */
 	__add_sum_entry(sbi, type, sum);
 
-	mutex_lock(&sit_i->sentry_lock);
 	__refresh_next_blkoff(sbi, curseg);
 
 	stat_inc_block_count(sbi, curseg);
-- 
2.1.1

