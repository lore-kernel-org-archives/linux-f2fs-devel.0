From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/5] f2fs: fix the wrong stat count of calling gc
Date: Mon, 22 Feb 2016 18:32:13 +0800
Message-ID: <004701d16d5c$62e1f790$28a5e6b0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

With a partition which was formated as multi segments in one section,
we stated incorrectly for count of gc operation.

e.g., for a partition with segs_per_sec = 4

cat /sys/kernel/debug/f2fs/status

GC calls: 208 (BG: 7)
  - data segments : 104 (52)
  - node segments : 104 (24)

GC called count should be (104 (data segs) + 104 (node segs)) / 4 = 52,
rather than 208. Fix it.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/gc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 47ade35..6b2d704 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -816,7 +816,6 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 								gc_type);
 
 		stat_inc_seg_count(sbi, type, gc_type);
-		stat_inc_call_count(sbi->stat_info);
 
 		f2fs_put_page(sum_page, 0);
 	}
@@ -841,6 +840,9 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 			if (get_valid_blocks(sbi, start_segno++, 1) == 0)
 				seg_freed++;
 	}
+
+	stat_inc_call_count(sbi->stat_info);
+
 	return seg_freed;
 }
 
-- 
2.7.0
