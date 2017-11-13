From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: check sit bitmap under sentry_lock
Date: Mon, 13 Nov 2017 17:54:39 +0800
Message-ID: <20171113095439.49897-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch protects sit bitmap accessing in __check_sit_bitmap with
sentry_lock, meanwhile, in allocate_data_block, f2fs_wait_discard_bio
will not access/update sit cache, let's exclude it from sentry_lock's
region.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index c117e0913f2a..464696b1612a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -894,6 +894,8 @@ void __check_sit_bitmap(struct f2fs_sb_info *sbi,
 	unsigned long offset, size, max_blocks = sbi->blocks_per_seg;
 	unsigned long *map;
 
+	down_read(&SIT_I(sbi)->sentry_lock);
+
 	while (blk < end) {
 		segno = GET_SEGNO(sbi, blk);
 		sentry = get_seg_entry(sbi, segno);
@@ -908,6 +910,8 @@ void __check_sit_bitmap(struct f2fs_sb_info *sbi,
 		f2fs_bug_on(sbi, offset != size);
 		blk = START_BLOCK(sbi, segno + 1);
 	}
+
+	up_read(&SIT_I(sbi)->sentry_lock);
 #endif
 }
 
@@ -2527,12 +2531,13 @@ void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 	down_read(&SM_I(sbi)->curseg_lock);
 
 	mutex_lock(&curseg->curseg_mutex);
-	down_write(&sit_i->sentry_lock);
 
 	*new_blkaddr = NEXT_FREE_BLKADDR(sbi, curseg);
 
 	f2fs_wait_discard_bio(sbi, *new_blkaddr);
 
+	down_write(&sit_i->sentry_lock);
+
 	/*
 	 * __add_sum_entry should be resided under the curseg_mutex
 	 * because, this function updates a summary entry in the
-- 
2.15.0.55.gc2ece9dc4de6
