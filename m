From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev] [PATCH] f2fs: check all ones or zeros bitmap with integer
 data type for better mount performance
Date: Tue, 22 Oct 2013 17:28:18 +0800
Message-ID: <000701cecf09$2b2a2280$817e6780$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: ??? <jaegeuk.kim@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, =?gb2312?B?zLfmrQ==?= <shu.tan@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Previously, check_block_count check valid_map with bit data type in common
scenario that sit has all ones or zeros bitmap, it makes low mount
performance.
So let's check the special bitmap with integer data type instead of the bit
one.

Signed-off-by: Tan Shu <shu.tan@samsung.com>
Signed-off-by: Yu Chao <chao2.yu@samsung.com>
---
 fs/f2fs/segment.h |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 7f94d78..d43ab9f 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -543,6 +543,7 @@ static inline void check_block_count(struct f2fs_sb_info
*sbi,
 {
 	struct f2fs_sm_info *sm_info = SM_I(sbi);
 	unsigned int end_segno = sm_info->segment_count - 1;
+	int *valid_map = (int *)raw_sit->valid_map;
 	int valid_blocks = 0;
 	int i;
 
@@ -552,6 +553,19 @@ static inline void check_block_count(struct
f2fs_sb_info *sbi,
 	/* check boundary of a given segment number */
 	BUG_ON(segno > end_segno);
 
+	/* check all ones or zeros valid_map */
+	if (GET_SIT_VBLOCKS(raw_sit) == 0) {
+		for (i = 0; i < SIT_VBLOCK_MAP_SIZE / sizeof(int); i++)
+			if (unlikely(valid_map[i] != 0))
+				BUG();
+		return;
+	} else if (GET_SIT_VBLOCKS(raw_sit) == sbi->blocks_per_seg) {
+		for (i = 0; i < SIT_VBLOCK_MAP_SIZE / sizeof(int); i++)
+			if (unlikely(valid_map[i] != -1))
+				BUG();
+		return;
+	}
+
 	/* check bitmap with valid block count */
 	for (i = 0; i < sbi->blocks_per_seg; i++)
 		if (f2fs_test_bit(i, raw_sit->valid_map))
---
