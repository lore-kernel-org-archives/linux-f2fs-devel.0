From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH] f2fs: update dirty status for CURSEG as well
Date: Wed, 11 Oct 2017 21:25:18 +0800
Message-ID: <1507728318-113117-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Without this patch, it will cause all the free segments using up in some
corner case. For example, there are 100 segments, and 20 of them are
reserved for ovp. If 79 segments are full of data, segment 80 becomes
CURSEG segment, write 512 blocks and then delete 511 blocks. Since it is
CURSEG segment, the __locate_dirty_segment will not update its dirty
status. Then the dirty_segments(sbi) is 0, f2fs_gc will fail to
get_victim, and f2fs_balance_fs will fail to trigger gc action. After
f2fs_balance_fs returns, f2fs can continue to write data to segment 81.
Again, segment 81 becomes CURSEG segment, write 512 blocks and delete
511 blocks, the dirty_segments(sbi) is 0 and f2fs_gc fail again. This
can finally use up all the free segments and cause panic.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/segment.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index bfbcff8..0ff52d5 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -686,10 +686,6 @@ static void __locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
 {
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
 
-	/* need not be added */
-	if (IS_CURSEG(sbi, segno))
-		return;
-
 	if (!test_and_set_bit(segno, dirty_i->dirty_segmap[dirty_type]))
 		dirty_i->nr_dirty[dirty_type]++;
 
-- 
1.8.5.2
