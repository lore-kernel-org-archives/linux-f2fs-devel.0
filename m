From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH v2] f2fs: update cur_valid_map_mir together with cur_valid_map
Date: Wed, 2 Aug 2017 21:20:13 +0800
Message-ID: <1501680013-48861-1-git-send-email-yunlong.song@huawei.com>
References: <1501574206-150946-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501574206-150946-1-git-send-email-yunlong.song@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

When cur_valid_map passes the f2fs_test_and_set(,clear)_bit test,
cur_valid_map_mir update is skipped unlikely, so fix it. The fix
now changes the mirror check together with cur_valid_map all the
time.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 151968e..40e40c5 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1508,6 +1508,7 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 	struct seg_entry *se;
 	unsigned int segno, offset;
 	long int new_vblocks;
+	bool exist, mir_exist;
 
 	segno = GET_SEGNO(sbi, blkaddr);
 
@@ -1524,17 +1525,23 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 
 	/* Update valid block bitmap */
 	if (del > 0) {
-		if (f2fs_test_and_set_bit(offset, se->cur_valid_map)) {
+		exist = f2fs_test_and_set_bit(offset, se->cur_valid_map);
 #ifdef CONFIG_F2FS_CHECK_FS
-			if (f2fs_test_and_set_bit(offset,
-						se->cur_valid_map_mir))
-				f2fs_bug_on(sbi, 1);
-			else
-				WARN_ON(1);
-#else
+		mir_exist = f2fs_test_and_set_bit(offset,
+						se->cur_valid_map_mir);
+		if (exist != mir_exist) {
+			f2fs_msg(sbi->sb, KERN_ERR, "Inconsistent error "
+				"when setting bitmap, blk:%u, old bit:%d",
+				blkaddr, exist);
 			f2fs_bug_on(sbi, 1);
+		}
 #endif
+		if (exist) {
+			f2fs_msg(sbi->sb, KERN_ERR,
+				"Bitmap was wrongly set, blk:%u", blkaddr);
+			f2fs_bug_on(sbi, 1);
 		}
+
 		if (f2fs_discard_en(sbi) &&
 			!f2fs_test_and_set_bit(offset, se->discard_map))
 			sbi->discard_blks--;
@@ -1545,17 +1552,23 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 				se->ckpt_valid_blocks++;
 		}
 	} else {
-		if (!f2fs_test_and_clear_bit(offset, se->cur_valid_map)) {
+		exist = f2fs_test_and_clear_bit(offset, se->cur_valid_map);
 #ifdef CONFIG_F2FS_CHECK_FS
-			if (!f2fs_test_and_clear_bit(offset,
-						se->cur_valid_map_mir))
-				f2fs_bug_on(sbi, 1);
-			else
-				WARN_ON(1);
-#else
+		mir_exist = f2fs_test_and_clear_bit(offset,
+						se->cur_valid_map_mir);
+		if (exist != mir_exist) {
+			f2fs_msg(sbi->sb, KERN_ERR, "Inconsistent error "
+				"when clearing bitmap, blk:%u, old bit:%d",
+				blkaddr, exist);
 			f2fs_bug_on(sbi, 1);
+		}
 #endif
+		if (!exist) {
+			f2fs_msg(sbi->sb, KERN_ERR,
+				"Bitmap was wrongly cleared, blk:%u", blkaddr);
+			f2fs_bug_on(sbi, 1);
 		}
+
 		if (f2fs_discard_en(sbi) &&
 			f2fs_test_and_clear_bit(offset, se->discard_map))
 			sbi->discard_blks++;
-- 
1.8.5.2
