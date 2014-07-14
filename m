From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev][PATCH] f2fs: reduce searching region of segmap when free
 section
Date: Mon, 14 Jul 2014 16:45:15 +0800
Message-ID: <000001cf9f40$28976ed0$79c64c70$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

In __set_test_and_free we will check whether all segment are free in one section
When free one segment, in order to set section to free status.
But the searching region of segmap is from start segno to last segno of f2fs,
it's not necessary. So let's just only check all segment bitmap of target
section.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/segment.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 7091204..ee5c75e 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -347,8 +347,8 @@ static inline void __set_test_and_free(struct f2fs_sb_info *sbi,
 	if (test_and_clear_bit(segno, free_i->free_segmap)) {
 		free_i->free_segments++;
 
-		next = find_next_bit(free_i->free_segmap, TOTAL_SEGS(sbi),
-								start_segno);
+		next = find_next_bit(free_i->free_segmap,
+				start_segno + sbi->segs_per_sec, start_segno);
 		if (next >= start_segno + sbi->segs_per_sec) {
 			if (test_and_clear_bit(secno, free_i->free_secmap))
 				free_i->free_sections++;
-- 
2.0.0.421.g786a89d


