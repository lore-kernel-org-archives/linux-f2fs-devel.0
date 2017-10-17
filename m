From: Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to correct no_fggc_candidate
Date: Tue, 17 Oct 2017 23:01:39 +0800
Message-ID: <20171017150139.6348-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <chao@kernel.org>) id 1e4TNS-0003j2-9d
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 Oct 2017 15:01:54 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1e4TNQ-0005PS-Ds
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 Oct 2017 15:01:54 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

There may be extreme case as below:

For one section contains one segment, and there are total 100 segments
with 10% over-privision ratio in f2fs partition, fggc_threshold will
be rounded down to 460 instead of 460.8 as below caclulation:

sbi->fggc_threshold = div_u64((u64)(main_count - ovp_count) *
			BLKS_PER_SEC(sbi), (main_count - resv_count));

If section usage is as:

As valid block number in all sections is large than fggc_threshold, so
none of them will be chosen as candidate due to incorrect fggc_threshold.

Let's just soften the term of choosing foreground GC candidates.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
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
2.14.1.145.gb3622a4ee


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
