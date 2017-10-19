From: Colin King <colin.king@canonical.com>
Subject: [PATCH][f2fs-next] f2fs: remove several redundant assignments
Date: Thu, 19 Oct 2017 12:58:21 +0200
Message-ID: <20171019105821.336-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Colin Ian King <colin.king@canonical.com>

There are several assignments to variables that are redundant
as the values are never read when the variables are updated later
and so the redundant statements can be safely removed.

Cleans up clang warnings:
fs/f2fs/segment.c:923:19: warning: Value stored to 'p' during its initialization is never read
fs/f2fs/segment.c:2060:2: warning: Value stored to 'hint' is never read
fs/f2fs/segment.c:2353:2: warning: Value stored to 'start_block' is never read
fs/f2fs/segment.c:2354:2: warning: Value stored to 'end_block' is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/f2fs/segment.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index bfbcff8339c5..df7af294c1e0 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -920,7 +920,7 @@ static struct discard_cmd *__insert_discard_tree(struct f2fs_sb_info *sbi,
 				struct rb_node *insert_parent)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
-	struct rb_node **p = &dcc->root.rb_node;
+	struct rb_node **p;
 	struct rb_node *parent = NULL;
 	struct discard_cmd *dc = NULL;
 
@@ -2057,7 +2057,6 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
 	}
 	secno = left_start;
 skip_left:
-	hint = secno;
 	segno = GET_SEG_FROM_SEC(sbi, secno);
 	zoneno = GET_ZONE_FROM_SEC(sbi, secno);
 
@@ -2350,9 +2349,6 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 	end_segno = (end >= MAX_BLKADDR(sbi)) ? MAIN_SEGS(sbi) - 1 :
 						GET_SEGNO(sbi, end);
 
-	start_block = START_BLOCK(sbi, start_segno);
-	end_block = START_BLOCK(sbi, end_segno + 1);
-
 	cpc.reason = CP_DISCARD;
 	cpc.trim_minlen = max_t(__u64, 1, F2FS_BYTES_TO_BLK(range->minlen));
 
-- 
2.14.1
