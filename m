From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: fix to correct no_fggc_candidate
Date: Wed, 18 Oct 2017 10:34:14 +0800
Message-ID: <20171018023414.23078-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

There may be extreme case as below:

For one section contains one segment, and there are total 100 segments
with 10% over-privision ratio in f2fs partition, fggc_threshold will
be rounded down to 460 instead of 460.8 as below caclulation:

sbi->fggc_threshold = div_u64((u64)(main_count - ovp_count) *
			BLKS_PER_SEC(sbi), (main_count - resv_count));

If section usage is as:
60 segments which contain 460 valid blocks
40 segments which contain 462 valid blocks

As valid block number in all sections is large than fggc_threshold, so
none of them will be chosen as candidate due to incorrect fggc_threshold.

Let's just soften the term of choosing foreground GC candidates.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- add missing section usage info.
 fs/f2fs/segment.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 5a1f7b9c8a72..8d93652d5b6a 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -731,7 +731,7 @@ static inline block_t sum_blk_addr(struct f2fs_sb_info *sbi, int base, int type)
 static inline bool no_fggc_candidate(struct f2fs_sb_info *sbi,
 						unsigned int secno)
 {
-	if (get_valid_blocks(sbi, GET_SEG_FROM_SEC(sbi, secno), true) >=
+	if (get_valid_blocks(sbi, GET_SEG_FROM_SEC(sbi, secno), true) >
 						sbi->fggc_threshold)
 		return true;
 	return false;
-- 
2.13.1.388.g69e6b9b4f4a9
