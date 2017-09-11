From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: fix double count on issued discard commands
Date: Sun, 10 Sep 2017 20:38:45 -0700
Message-ID: <20170911033845.53701-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

If issue_cond is true, it does double count for # of issued commands.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 7fd742f747ce..25196ff5d587 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1087,7 +1087,7 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi, bool issue_cond)
 				issued++;
 				__submit_discard_cmd(sbi, dc);
 			}
-			if (issue_cond && iter++ > DISCARD_ISSUE_RATE)
+			if (issue_cond && iter > DISCARD_ISSUE_RATE)
 				goto out;
 		}
 		if (list_empty(pend_list) && dcc->pend_list_tag[i] & P_TRIM)
-- 
2.14.0.rc1.383.gd1ce394fe2-goog
