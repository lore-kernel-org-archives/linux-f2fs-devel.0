From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/2] f2fs: correct search area in get_new_segment
Date: Fri, 22 Jan 2016 17:42:06 +0800
Message-ID: <00b601d154f9$4036ad10$c0a40730$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

get_new_segment starts from current segment position, tries to search a
free segment among its right neighbors locate in same section.

But previously our search area was set as [current segment, max segment],
which means we have to search to more bits in free_segmap bitmap for some
worse cases. So here we correct the search area to [current segment, last
segment in section] to avoid unnecessary searching.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/segment.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 5904a41..75413e2 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -873,9 +873,8 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
 
 	if (!new_sec && ((*newseg + 1) % sbi->segs_per_sec)) {
 		segno = find_next_zero_bit(free_i->free_segmap,
-					MAIN_SEGS(sbi), *newseg + 1);
-		if (segno - *newseg < sbi->segs_per_sec -
-					(*newseg % sbi->segs_per_sec))
+				(hint + 1) * sbi->segs_per_sec, *newseg + 1);
+		if (segno < (hint + 1) * sbi->segs_per_sec)
 			goto got_it;
 	}
 find_other_zone:
-- 
2.7.0.2.g1b0b6dd
