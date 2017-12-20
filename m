From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: return error during fill_super
Date: Wed, 20 Dec 2017 12:39:56 -0800
Message-ID: <20171220203956.53166-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1eRl9n-0004mP-Tr
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 20 Dec 2017 20:40:03 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eRl9n-0001Zq-1P
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 20 Dec 2017 20:40:03 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

Let's avoid BUG_ON during fill_super, when on-disk was totall corrupted.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 16 ++++++++++++----
 fs/f2fs/segment.h | 22 ++++++++++++++++++----
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 40e1d20b8080..b03f65e5dfdc 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3476,7 +3476,7 @@ static int build_curseg(struct f2fs_sb_info *sbi)
 	return restore_curseg_summaries(sbi);
 }
 
-static void build_sit_entries(struct f2fs_sb_info *sbi)
+static int build_sit_entries(struct f2fs_sb_info *sbi)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_COLD_DATA);
@@ -3486,6 +3486,7 @@ static void build_sit_entries(struct f2fs_sb_info *sbi)
 	int sit_blk_cnt = SIT_BLK_CNT(sbi);
 	unsigned int i, start, end;
 	unsigned int readed, start_blk = 0;
+	int err = 0;
 
 	do {
 		readed = ra_meta_pages(sbi, start_blk, BIO_MAX_PAGES,
@@ -3504,7 +3505,9 @@ static void build_sit_entries(struct f2fs_sb_info *sbi)
 			sit = sit_blk->entries[SIT_ENTRY_OFFSET(sit_i, start)];
 			f2fs_put_page(page, 1);
 
-			check_block_count(sbi, start, &sit);
+			err = check_block_count(sbi, start, &sit);
+			if (err)
+				return err;
 			seg_info_from_raw_sit(se, &sit);
 
 			/* build discard map only one time */
@@ -3539,7 +3542,9 @@ static void build_sit_entries(struct f2fs_sb_info *sbi)
 
 		old_valid_blocks = se->valid_blocks;
 
-		check_block_count(sbi, start, &sit);
+		err = check_block_count(sbi, start, &sit);
+		if (err)
+			break;
 		seg_info_from_raw_sit(se, &sit);
 
 		if (f2fs_discard_en(sbi)) {
@@ -3559,6 +3564,7 @@ static void build_sit_entries(struct f2fs_sb_info *sbi)
 				se->valid_blocks - old_valid_blocks;
 	}
 	up_read(&curseg->journal_rwsem);
+	return err;
 }
 
 static void init_free_segmap(struct f2fs_sb_info *sbi)
@@ -3733,7 +3739,9 @@ int build_segment_manager(struct f2fs_sb_info *sbi)
 		return err;
 
 	/* reinit free segmap based on SIT */
-	build_sit_entries(sbi);
+	err = build_sit_entries(sbi);
+	if (err)
+		return err;
 
 	init_free_segmap(sbi);
 	err = build_dirty_segmap(sbi);
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index d1d394cdf61d..71a2aaa286df 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -655,7 +655,7 @@ static inline void verify_block_addr(struct f2fs_sb_info *sbi, block_t blk_addr)
 /*
  * Summary block is always treated as an invalid block
  */
-static inline void check_block_count(struct f2fs_sb_info *sbi,
+static inline int check_block_count(struct f2fs_sb_info *sbi,
 		int segno, struct f2fs_sit_entry *raw_sit)
 {
 #ifdef CONFIG_F2FS_CHECK_FS
@@ -677,11 +677,25 @@ static inline void check_block_count(struct f2fs_sb_info *sbi,
 		cur_pos = next_pos;
 		is_valid = !is_valid;
 	} while (cur_pos < sbi->blocks_per_seg);
-	BUG_ON(GET_SIT_VBLOCKS(raw_sit) != valid_blocks);
+
+	if (unlikely(GET_SIT_VBLOCKS(raw_sit) != valid_blocks)) {
+		f2fs_msg(sbi->sb, KERN_ERR,
+				"Mismatch valid blocks %d vs. %d",
+					GET_SIT_VBLOCKS(raw_sit), valid_blocks);
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
+		return -EINVAL;
+	}
 #endif
 	/* check segment usage, and check boundary of a given segment number */
-	f2fs_bug_on(sbi, GET_SIT_VBLOCKS(raw_sit) > sbi->blocks_per_seg
-					|| segno > TOTAL_SEGS(sbi) - 1);
+	if (unlikely(GET_SIT_VBLOCKS(raw_sit) > sbi->blocks_per_seg
+					|| segno > TOTAL_SEGS(sbi) - 1)) {
+		f2fs_msg(sbi->sb, KERN_ERR,
+				"Wrong valid blocks %d or segno %u",
+					GET_SIT_VBLOCKS(raw_sit), segno);
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
+		return -EINVAL;
+	}
+	return 0;
 }
 
 static inline pgoff_t current_sit_addr(struct f2fs_sb_info *sbi,
-- 
2.15.0.531.g2ccb3012c9-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
