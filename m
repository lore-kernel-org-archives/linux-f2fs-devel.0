From: Haicheng Li <haicheng.li@linux.intel.com>
Subject: [PATCH 2/2] f2fs: no need to check other dirty_segmap when the seg has been found
Date: Fri, 18 Oct 2013 17:24:08 +0800
Message-ID: <1382088248-10615-2-git-send-email-haicheng.li@linux.intel.com>
References: <1382088248-10615-1-git-send-email-haicheng.li@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1382088248-10615-1-git-send-email-haicheng.li@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk.kim@samsung.com>
Cc: linux-kernel@vger.kernel.org, Haicheng Li <haicheng.lee@gmail.com>, Haicheng Li <haicheng.li@linux.intel.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Because one dirty seg can only be mapped to one dirty_type. Otherwise, it's a bug.

Signed-off-by: Haicheng Li <haicheng.li@linux.intel.com>
---
 fs/f2fs/segment.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 862fef3..5ff0524 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -79,9 +79,13 @@ static void __remove_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
 		enum dirty_type t = DIRTY_HOT_DATA;
 
 		/* clear all the bitmaps */
-		for (; t <= DIRTY_COLD_NODE; t++)
-			if (test_and_clear_bit(segno, dirty_i->dirty_segmap[t]))
+		for (; t <= DIRTY_COLD_NODE; t++) {
+			if (test_and_clear_bit(segno,
+						dirty_i->dirty_segmap[t])) {
 				dirty_i->nr_dirty[t]--;
+				break;
+			}
+		}
 
 		if (get_valid_blocks(sbi, segno, sbi->segs_per_sec) == 0)
 			clear_bit(GET_SECNO(sbi, segno),
-- 
1.7.9.5
