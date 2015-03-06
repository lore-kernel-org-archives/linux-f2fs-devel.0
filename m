From: Wanpeng Li <wanpeng.li@linux.intel.com>
Subject: [PATCH 2/2] f2fs: reduce searching region of segmap when set free section
Date: Fri,  6 Mar 2015 15:00:55 +0800
Message-ID: <1425625255-4204-2-git-send-email-wanpeng.li@linux.intel.com>
References: <1425625255-4204-1-git-send-email-wanpeng.li@linux.intel.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1425625255-4204-1-git-send-email-wanpeng.li@linux.intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Changman Lee <cm224.lee@samsung.com>, Chao Yu <chao2.yu@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Wanpeng Li <wanpeng.li@linux.intel.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

In __set_free we will check whether all segment are free in one section 
when free one segment, in order to set section to free status. But the 
searching region of segmap is from start segno to last segno of main 
area, it's not necessary. So let's just only check all segment bitmap 
of target section.

Signed-off-by: Wanpeng Li <wanpeng.li@linux.intel.com>
---
 fs/f2fs/segment.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 7fd3511..85d7fa7 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -336,7 +336,8 @@ static inline void __set_free(struct f2fs_sb_info *sbi, unsigned int segno)
 	clear_bit(segno, free_i->free_segmap);
 	free_i->free_segments++;
 
-	next = find_next_bit(free_i->free_segmap, MAIN_SEGS(sbi), start_segno);
+	next = find_next_bit(free_i->free_segmap,
+			start_segno + sbi->segs_per_sec, start_segno);
 	if (next >= start_segno + sbi->segs_per_sec) {
 		clear_bit(secno, free_i->free_secmap);
 		free_i->free_sections++;
-- 
1.9.1

