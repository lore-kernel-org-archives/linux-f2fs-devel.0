From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH] f2fs: clear get_ssr_cost
Date: Fri, 1 Sep 2017 20:14:35 +0800
Message-ID: <1504268075-81858-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

se->ckpt_valid_blocks is always larger than se->valid_blocks, so
get_ssr_cost can be cleared.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/gc.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index cd147e7..b226760 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -277,20 +277,11 @@ static unsigned int get_greedy_cost(struct f2fs_sb_info *sbi,
 				valid_blocks * 2 : valid_blocks;
 }
 
-static unsigned int get_ssr_cost(struct f2fs_sb_info *sbi,
-						unsigned int segno)
-{
-	struct seg_entry *se = get_seg_entry(sbi, segno);
-
-	return se->ckpt_valid_blocks > se->valid_blocks ?
-				se->ckpt_valid_blocks : se->valid_blocks;
-}
-
 static inline unsigned int get_gc_cost(struct f2fs_sb_info *sbi,
 			unsigned int segno, struct victim_sel_policy *p)
 {
 	if (p->alloc_mode == SSR)
-		return get_ssr_cost(sbi, segno);
+		return get_seg_entry(sbi, segno)->ckpt_valid_blocks;
 
 	/* alloc_mode == LFS */
 	if (p->gc_mode == GC_GREEDY)
-- 
1.8.5.2
