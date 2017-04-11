From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/4] f2fs: use segment number for get_valid_blocks
Date: Mon, 10 Apr 2017 17:13:05 -0700
Message-ID: <20170411001308.12881-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch fixes to submit a segment number for get_valid_blocks.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index b8a1bac9355d..39ef9cc0093b 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -80,6 +80,8 @@
 		GET_SEGNO_FROM_SEG0(sbi, blk_addr)))
 #define GET_SECNO(sbi, segno)					\
 	((segno) / (sbi)->segs_per_sec)
+#define GET_SEGNO_FROM_SECNO(sbi, secno)				\
+	((secno) * (sbi)->segs_per_sec)
 #define GET_ZONENO_FROM_SEGNO(sbi, segno)				\
 	(((segno) / (sbi)->segs_per_sec) / (sbi)->secs_per_zone)
 
@@ -720,8 +722,8 @@ static inline block_t sum_blk_addr(struct f2fs_sb_info *sbi, int base, int type)
 static inline bool no_fggc_candidate(struct f2fs_sb_info *sbi,
 						unsigned int secno)
 {
-	if (get_valid_blocks(sbi, secno, sbi->segs_per_sec) >=
-						sbi->fggc_threshold)
+	if (get_valid_blocks(sbi, GET_SEGNO_FROM_SECNO(sbi, secno),
+				sbi->segs_per_sec) >= sbi->fggc_threshold)
 		return true;
 	return false;
 }
-- 
2.11.0
