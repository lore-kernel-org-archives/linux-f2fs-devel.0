From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH] f2fs: Do not issue small discards in LFS mode
Date: Wed, 24 May 2017 14:02:29 +0900
Message-ID: <20170524050229.13213-1-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-fsdevel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

clear_prefree_segments() issues small discards after discarding full
segments. These small discards may not be section aligned, so not zone
aligned when using a zoned block device, or more generally, when
mounted in LFS mode. So do not issue these small discards when mounted
in LFS mode.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 fs/f2fs/segment.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 9684585..3d190a7 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1322,7 +1322,8 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 					sbi->blocks_per_seg, cur_pos);
 			len = next_pos - cur_pos;
 
-			if (force && len < cpc->trim_minlen)
+			if (test_opt(sbi, LFS) ||
+			    (force && len < cpc->trim_minlen))
 				goto skip;
 
 			f2fs_issue_discard(sbi, entry->start_blkaddr + cur_pos,
-- 
2.9.4
