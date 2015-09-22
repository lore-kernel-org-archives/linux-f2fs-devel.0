From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: fix to correct freed section number during gc
Date: Tue, 22 Sep 2015 21:18:18 +0800
Message-ID: <00d601d0f539$3d893e90$b89bbbb0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

We pass 'nfree' to has_not_enough_free_secs to check whether there is
enough free section, but 'nfree' indicates the number of segment gced,
should alter the value to section number.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/gc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index e932740..7ad2a60 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -817,7 +817,8 @@ gc_more:
 	if (unlikely(f2fs_cp_error(sbi)))
 		goto stop;
 
-	if (gc_type == BG_GC && has_not_enough_free_secs(sbi, nfree)) {
+	if (gc_type == BG_GC &&
+		has_not_enough_free_secs(sbi, nfree / sbi->segs_per_sec)) {
 		gc_type = FG_GC;
 		if (__get_victim(sbi, &segno, gc_type) || prefree_segments(sbi))
 			write_checkpoint(sbi, &cpc);
@@ -839,7 +840,7 @@ gc_more:
 	if (gc_type == FG_GC)
 		sbi->cur_victim_sec = NULL_SEGNO;
 
-	if (has_not_enough_free_secs(sbi, nfree))
+	if (has_not_enough_free_secs(sbi, nfree / sbi->segs_per_sec))
 		goto gc_more;
 
 	if (gc_type == FG_GC)
-- 
2.5.2
