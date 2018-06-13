From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH] f2fs-tools: do not count free_segs in
 flush_sit_entries
Date: Wed, 13 Jun 2018 18:13:59 +0800
Message-ID: <20180613101359.1184-1-shengyong1@huawei.com>
References: <20180613015150.197854-2-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <shengyong1@huawei.com>) id 1fT2nT-0002Rs-5U
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 13 Jun 2018 10:14:35 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fT2nR-005SVF-0g
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 13 Jun 2018 10:14:35 +0000
In-Reply-To: <20180613015150.197854-2-shengyong1@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

flush_sit_entries() is always called before write_checkpoint(). Since
free_segs is counted in write_checkpoint, there is no need to do that
in flush_sit_entries. Besides, the value of free_segs may be not
correct if we skip uptodate seg_entries.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fsck/mount.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index 68278c5..80a4849 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1867,11 +1867,9 @@ void flush_journal_entries(struct f2fs_sb_info *sbi)
 
 void flush_sit_entries(struct f2fs_sb_info *sbi)
 {
-	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
 	struct sit_info *sit_i = SIT_I(sbi);
 	struct f2fs_sit_block *sit_blk;
 	unsigned int segno = 0;
-	u32 free_segs = 0;
 
 	sit_blk = calloc(BLOCK_SZ, 1);
 	ASSERT(sit_blk);
@@ -1891,14 +1889,9 @@ void flush_sit_entries(struct f2fs_sb_info *sbi)
 		sit->vblocks = cpu_to_le16((se->type << SIT_VBLOCKS_SHIFT) |
 							se->valid_blocks);
 		rewrite_current_sit_page(sbi, segno, sit_blk);
-
-		if (se->valid_blocks == 0x0 &&
-				!IS_CUR_SEGNO(sbi, segno, NO_CHECK_TYPE))
-			free_segs++;
 	}
 
 	free(sit_blk);
-	set_cp(free_segment_count, free_segs);
 }
 
 int find_next_free_block(struct f2fs_sb_info *sbi, u64 *to, int left, int type)
-- 
2.17.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
