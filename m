From: Liu Xue <liuxueliu.liu@huawei.com>
Subject: [PATCH] f2fs: unify f2fs_bug_on when check blocks and
	segment
Date: Mon, 27 Jul 2015 10:17:59 +0000
Message-ID: <1437992279-143535-1-git-send-email-liuxueliu.liu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liuxueliu.liu@huawei.com>) id 1ZJfUG-0005k6-0R
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Jul 2015 10:18:24 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZJfUB-0001W0-I6
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Jul 2015 10:18:23 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

Replace BUG_ON with f2fs_bug_on to deal with
block and segment validity check failed.

Signed-off-by: Xue Liu <liuxueliu.liu@huawei.com>
---
 fs/f2fs/segment.h | 45 ++++++++-------------------------------------
 1 file changed, 8 insertions(+), 37 deletions(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 79e7b87..230f9cd 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -555,16 +555,15 @@ static inline unsigned short curseg_blkoff(struct f2fs_sb_info *sbi, int type)
 	return curseg->next_blkoff;
 }
 
-#ifdef CONFIG_F2FS_CHECK_FS
 static inline void check_seg_range(struct f2fs_sb_info *sbi, unsigned int segno)
 {
-	BUG_ON(segno > TOTAL_SEGS(sbi) - 1);
+	f2fs_bug_on(sbi, segno > TOTAL_SEGS(sbi) - 1);
 }
 
 static inline void verify_block_addr(struct f2fs_sb_info *sbi, block_t blk_addr)
 {
-	BUG_ON(blk_addr < SEG0_BLKADDR(sbi));
-	BUG_ON(blk_addr >= MAX_BLKADDR(sbi));
+	f2fs_bug_on(sbi, blk_addr < SEG0_BLKADDR(sbi)
+					|| blk_addr >= MAX_BLKADDR(sbi));
 }
 
 /*
@@ -577,12 +576,11 @@ static inline void check_block_count(struct f2fs_sb_info *sbi,
 	int valid_blocks = 0;
 	int cur_pos = 0, next_pos;
 
-	/* check segment usage */
-	BUG_ON(GET_SIT_VBLOCKS(raw_sit) > sbi->blocks_per_seg);
-
-	/* check boundary of a given segment number */
-	BUG_ON(segno > TOTAL_SEGS(sbi) - 1);
+	/* check segment usage, and check boundary of a given segment number */
+	f2fs_bug_on(sbi, GET_SIT_VBLOCKS(raw_sit) > sbi->blocks_per_seg
+					|| segno > TOTAL_SEGS(sbi) - 1);
 
+#ifdef CONFIG_F2FS_CHECK_FS
 	/* check bitmap with valid block count */
 	do {
 		if (is_valid) {
@@ -598,35 +596,8 @@ static inline void check_block_count(struct f2fs_sb_info *sbi,
 		is_valid = !is_valid;
 	} while (cur_pos < sbi->blocks_per_seg);
 	BUG_ON(GET_SIT_VBLOCKS(raw_sit) != valid_blocks);
-}
-#else
-static inline void check_seg_range(struct f2fs_sb_info *sbi, unsigned int segno)
-{
-	if (segno > TOTAL_SEGS(sbi) - 1)
-		set_sbi_flag(sbi, SBI_NEED_FSCK);
-}
-
-static inline void verify_block_addr(struct f2fs_sb_info *sbi, block_t blk_addr)
-{
-	if (blk_addr < SEG0_BLKADDR(sbi) || blk_addr >= MAX_BLKADDR(sbi))
-		set_sbi_flag(sbi, SBI_NEED_FSCK);
-}
-
-/*
- * Summary block is always treated as an invalid block
- */
-static inline void check_block_count(struct f2fs_sb_info *sbi,
-		int segno, struct f2fs_sit_entry *raw_sit)
-{
-	/* check segment usage */
-	if (GET_SIT_VBLOCKS(raw_sit) > sbi->blocks_per_seg)
-		set_sbi_flag(sbi, SBI_NEED_FSCK);
-
-	/* check boundary of a given segment number */
-	if (segno > TOTAL_SEGS(sbi) - 1)
-		set_sbi_flag(sbi, SBI_NEED_FSCK);
-}
 #endif
+}
 
 static inline pgoff_t current_sit_addr(struct f2fs_sb_info *sbi,
 						unsigned int start)
-- 
1.8.3.4


------------------------------------------------------------------------------
