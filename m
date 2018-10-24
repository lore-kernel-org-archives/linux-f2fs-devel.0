From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH v2] f2fs: fix count of seg_freed to make sec_freed correct
Date: Wed, 24 Oct 2018 16:08:30 +0800
Message-ID: <1540368510-14270-1-git-send-email-yunlong.song@huawei.com>
References: <1539168739-79848-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539168739-79848-1-git-send-email-yunlong.song@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

When sbi->segs_per_sec > 1, and if some segno has 0 valid blocks before
gc starts, do_garbage_collect will skip counting seg_freed++, and this
will cause seg_freed < sbi->segs_per_sec and finally skip sec_freed++.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/gc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index a07241f..57841e9 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1130,9 +1130,9 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 					GET_SUM_BLOCK(sbi, segno));
 		f2fs_put_page(sum_page, 0);
 
-		if (get_valid_blocks(sbi, segno, false) == 0 ||
-				!PageUptodate(sum_page) ||
-				unlikely(f2fs_cp_error(sbi)))
+		if (get_valid_blocks(sbi, segno, false) == 0)
+			goto freed;
+		if (!PageUptodate(sum_page) || unlikely(f2fs_cp_error(sbi)))
 			goto next;
 
 		sum = page_address(sum_page);
@@ -1160,6 +1160,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 
 		stat_inc_seg_count(sbi, type, gc_type);
 
+freed:
 		if (gc_type == FG_GC &&
 				get_valid_blocks(sbi, segno, false) == 0)
 			seg_freed++;
-- 
1.8.5.2
