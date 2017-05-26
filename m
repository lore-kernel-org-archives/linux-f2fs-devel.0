From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v2] f2fs: Do not issue small discards in LFS mode
Date: Fri, 26 May 2017 17:04:40 +0900
Message-ID: <20170526080440.11160-1-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-fsdevel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

clear_prefree_segments() issues small discards after discarding full
segments. These small discards may not be section aligned, so not zone
aligned on a zoned block device, causing __f2fs_iissue_discard_zone() to fail.
Fix this by not issuing small discards for a volume mounted with the BLKZONED
feature enabled.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 fs/f2fs/segment.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 9684585..1279650 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1322,7 +1322,8 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 					sbi->blocks_per_seg, cur_pos);
 			len = next_pos - cur_pos;
 
-			if (force && len < cpc->trim_minlen)
+			if (f2fs_sb_mounted_blkzoned(sbi->sb) ||
+			    (force && len < cpc->trim_minlen))
 				goto skip;
 
 			f2fs_issue_discard(sbi, entry->start_blkaddr + cur_pos,
-- 
2.9.4
