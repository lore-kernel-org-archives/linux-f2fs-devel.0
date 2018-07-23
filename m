From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH 1/5] f2fs: clear victim_secmap when section has full valid blocks
Date: Mon, 23 Jul 2018 22:10:18 +0800
Message-ID: <1532355022-163029-2-git-send-email-yunlong.song@huawei.com>
References: <1532355022-163029-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532355022-163029-1-git-send-email-yunlong.song@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Without this patch, f2fs only clears victim_secmap when it finds out
that the section has no valid blocks at all, but forgets to clear the
victim_secmap when the whole section has full valid blocks.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/segment.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index cfff7cf..255bff5 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -776,7 +776,9 @@ static void __remove_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
 		if (test_and_clear_bit(segno, dirty_i->dirty_segmap[t]))
 			dirty_i->nr_dirty[t]--;
 
-		if (get_valid_blocks(sbi, segno, true) == 0)
+		if (get_valid_blocks(sbi, segno, true) == 0 ||
+			get_valid_blocks(sbi, segno, true) ==
+			(sbi->segs_per_sec << sbi->log_blocks_per_seg))
 			clear_bit(GET_SEC_FROM_SEG(sbi, segno),
 						dirty_i->victim_secmap);
 	}
-- 
1.8.5.2
