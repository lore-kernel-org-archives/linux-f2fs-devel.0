From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH] f2fs: improve searching speed of __next_free_blkoff
Date: Fri, 15 Nov 2013 13:21:16 +0900
Message-ID: <1384489276-12228-1-git-send-email-cm224.lee@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Cc: Changman Lee <cm224.lee@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

To find a zero bit using the result of OR operation between ckpt_valid_map
and cur_valid_map is more fast than find a zero bit in each bitmap.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 fs/f2fs/segment.c |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b2de887..8537b41 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -602,13 +602,19 @@ static void __next_free_blkoff(struct f2fs_sb_info *sbi,
 			struct curseg_info *seg, block_t start)
 {
 	struct seg_entry *se = get_seg_entry(sbi, seg->segno);
-	block_t ofs;
-	for (ofs = start; ofs < sbi->blocks_per_seg; ofs++) {
-		if (!f2fs_test_bit(ofs, se->ckpt_valid_map)
-			&& !f2fs_test_bit(ofs, se->cur_valid_map))
-			break;
-	}
-	seg->next_blkoff = ofs;
+	int entries = SIT_VBLOCK_MAP_SIZE / sizeof(unsigned long);
+	unsigned long target_map[entries];
+	unsigned long *ckpt_map = (unsigned long *)se->ckpt_valid_map;
+	unsigned long *cur_map = (unsigned long *)se->cur_valid_map;
+	int i, pos;
+
+	for (i = 0; i < entries; i++)
+		target_map[i] = ckpt_map[i] | cur_map[i];
+
+	pos = f2fs_find_next_zero_bit(target_map, sbi->blocks_per_seg,
+			start);
+
+	seg->next_blkoff = pos;
 }
 
 /*
-- 
1.7.10.4

