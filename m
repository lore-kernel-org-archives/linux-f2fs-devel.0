From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] fsck.f2fs: introduce check_curseg_offsets()
Date: Thu, 16 May 2019 20:40:42 +0800
Message-ID: <20190516124043.90103-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hRFhG-0002uF-KP
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 16 May 2019 12:41:18 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hRFhC-006BlX-Ut
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 16 May 2019 12:41:18 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: jaegeuk@kernel.org

Let check_curseg_offset() just check one curseg, and introduce
check_curseg_offsets() to check all cursegs, no logic changes.

In addition, update message printed a bit.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/fsck.c | 58 ++++++++++++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 23 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index b5daeb4..b10b201 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -2129,33 +2129,45 @@ static void fix_checkpoint(struct f2fs_sb_info *sbi)
 		write_nat_bits(sbi, sb, cp, sbi->cur_cp);
 }
 
-int check_curseg_offset(struct f2fs_sb_info *sbi)
+int check_curseg_offset(struct f2fs_sb_info *sbi, int type)
 {
-	int i;
+	struct curseg_info *curseg = CURSEG_I(sbi, type);
+	struct seg_entry *se;
+	int j, nblocks;
 
-	for (i = 0; i < NO_CHECK_TYPE; i++) {
-		struct curseg_info *curseg = CURSEG_I(sbi, i);
-		struct seg_entry *se;
-		int j, nblocks;
+	if ((curseg->next_blkoff >> 3) >= SIT_VBLOCK_MAP_SIZE) {
+		ASSERT_MSG("Next block offset:%u is invalid, type:%d",
+			curseg->next_blkoff, type);
+		return -EINVAL;
+	}
+	se = get_seg_entry(sbi, curseg->segno);
+	if (f2fs_test_bit(curseg->next_blkoff,
+				(const char *)se->cur_valid_map)) {
+		ASSERT_MSG("Next block offset is not free, type:%d", type);
+		return -EINVAL;
+	}
+	if (curseg->alloc_type == SSR)
+		return 0;
 
-		if ((curseg->next_blkoff >> 3) >= SIT_VBLOCK_MAP_SIZE)
-			return -EINVAL;
-		se = get_seg_entry(sbi, curseg->segno);
-		if (f2fs_test_bit(curseg->next_blkoff,
-					(const char *)se->cur_valid_map)) {
-			ASSERT_MSG("Next block offset is not free, type:%d", i);
+	nblocks = sbi->blocks_per_seg;
+	for (j = curseg->next_blkoff + 1; j < nblocks; j++) {
+		if (f2fs_test_bit(j, (const char *)se->cur_valid_map)) {
+			ASSERT_MSG("For LFS curseg, space after .next_blkoff "
+				"should be unused, type:%d", type);
 			return -EINVAL;
 		}
-		if (curseg->alloc_type == SSR)
-			continue;
+	}
+	return 0;
+}
 
-		nblocks = sbi->blocks_per_seg;
-		for (j = curseg->next_blkoff + 1; j < nblocks; j++) {
-			if (f2fs_test_bit(j, (const char *)se->cur_valid_map)) {
-				ASSERT_MSG("LFS must have free section:%d", i);
-				return -EINVAL;
-			}
-		}
+int check_curseg_offsets(struct f2fs_sb_info *sbi)
+{
+	int i, ret;
+
+	for (i = 0; i < NO_CHECK_TYPE; i++) {
+		ret = check_curseg_offset(sbi, i);
+		if (ret)
+			return ret;
 	}
 	return 0;
 }
@@ -2703,7 +2715,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 	}
 
 	printf("[FSCK] next block offset is free                     ");
-	if (check_curseg_offset(sbi) == 0) {
+	if (check_curseg_offsets(sbi) == 0) {
 		printf(" [Ok..]\n");
 	} else {
 		printf(" [Fail]\n");
@@ -2748,7 +2760,7 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 			fix_hard_links(sbi);
 			fix_nat_entries(sbi);
 			rewrite_sit_area_bitmap(sbi);
-			if (check_curseg_offset(sbi)) {
+			if (check_curseg_offsets(sbi)) {
 				move_curseg_info(sbi, SM_I(sbi)->main_blkaddr, 0);
 				write_curseg_info(sbi);
 				flush_curseg_sit_entries(sbi);
-- 
2.18.0.rc1
