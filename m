From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH] f2fs: fix the size value in __check_sit_bitmap
Date: Fri, 4 Aug 2017 17:07:15 +0800
Message-ID: <1501837635-128934-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

The current size value is not correct and will miss bitmap check.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/segment.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index f336f8c..45fb534 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -787,11 +787,14 @@ void __check_sit_bitmap(struct f2fs_sb_info *sbi,
 		sentry = get_seg_entry(sbi, segno);
 		offset = GET_BLKOFF_FROM_SEG0(sbi, blk);
 
-		size = min((unsigned long)(end - blk), max_blocks);
+		if (end < START_BLOCK(sbi, segno + 1))
+			size = GET_BLKOFF_FROM_SEG0(sbi, end);
+		else
+			size = max_blocks;
 		map = (unsigned long *)(sentry->cur_valid_map);
 		offset = __find_rev_next_bit(map, size, offset);
 		f2fs_bug_on(sbi, offset != size);
-		blk += size;
+		blk = START_BLOCK(sbi, segno + 1);
 	}
 #endif
 }
-- 
1.8.5.2
