From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: remove unneeded parameter of change_curseg
Date: Wed, 30 Aug 2017 18:04:48 +0800
Message-ID: <20170830100448.2569-2-yuchao0@huawei.com>
References: <20170830100448.2569-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170830100448.2569-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

allocate_segment_by_default is the only caller of change_curseg passing
@reuse with 'false', but commit 763bfe1bc575 ("f2fs: remove reusing any
prefree segments") removes the calling, after that, @reuse in
change_curseg always be true, so, let's clean up the unneeded parameter.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8375257b6b26..d6c3f456ea51 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2012,7 +2012,7 @@ static void __refresh_next_blkoff(struct f2fs_sb_info *sbi,
  * This function always allocates a used segment(from dirty seglist) by SSR
  * manner, so it should recover the existing segment information of valid blocks
  */
-static void change_curseg(struct f2fs_sb_info *sbi, int type, bool reuse)
+static void change_curseg(struct f2fs_sb_info *sbi, int type)
 {
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
@@ -2033,12 +2033,10 @@ static void change_curseg(struct f2fs_sb_info *sbi, int type, bool reuse)
 	curseg->alloc_type = SSR;
 	__next_free_blkoff(sbi, curseg, 0);
 
-	if (reuse) {
-		sum_page = get_sum_page(sbi, new_segno);
-		sum_node = (struct f2fs_summary_block *)page_address(sum_page);
-		memcpy(curseg->sum_blk, sum_node, SUM_ENTRY_SIZE);
-		f2fs_put_page(sum_page, 1);
-	}
+	sum_page = get_sum_page(sbi, new_segno);
+	sum_node = (struct f2fs_summary_block *)page_address(sum_page);
+	memcpy(curseg->sum_blk, sum_node, SUM_ENTRY_SIZE);
+	f2fs_put_page(sum_page, 1);
 }
 
 static int get_ssr_segment(struct f2fs_sb_info *sbi, int type)
@@ -2102,7 +2100,7 @@ static void allocate_segment_by_default(struct f2fs_sb_info *sbi,
 	else if (curseg->alloc_type == LFS && is_next_segment_free(sbi, type))
 		new_curseg(sbi, type, false);
 	else if (need_SSR(sbi) && get_ssr_segment(sbi, type))
-		change_curseg(sbi, type, true);
+		change_curseg(sbi, type);
 	else
 		new_curseg(sbi, type, false);
 
@@ -2455,7 +2453,7 @@ void __f2fs_replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 	/* change the current segment */
 	if (segno != curseg->segno) {
 		curseg->next_segno = segno;
-		change_curseg(sbi, type, true);
+		change_curseg(sbi, type);
 	}
 
 	curseg->next_blkoff = GET_BLKOFF_FROM_SEG0(sbi, new_blkaddr);
@@ -2474,7 +2472,7 @@ void __f2fs_replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 	if (recover_curseg) {
 		if (old_cursegno != curseg->segno) {
 			curseg->next_segno = old_cursegno;
-			change_curseg(sbi, type, true);
+			change_curseg(sbi, type);
 		}
 		curseg->next_blkoff = old_blkoff;
 	}
-- 
2.13.1.388.g69e6b9b4f4a9
