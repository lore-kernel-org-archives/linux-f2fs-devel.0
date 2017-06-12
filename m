From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: fix ref of discard command
Date: Sun, 11 Jun 2017 20:04:49 -0700
Message-ID: <20170612030449.79290-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch resolves kernel panic for xfstests/081, caused by recent f2fs_bug_on

  f2fs: add f2fs_bug_on in __remove_discard_cmd

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 86a0c1095939..a6d77388a806 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1025,6 +1025,8 @@ static void __wait_discard_cmd(struct f2fs_sb_info *sbi, bool wait_cond)
 	list_for_each_entry_safe(dc, tmp, wait_list, list) {
 		if (!wait_cond || (dc->state == D_DONE && !dc->ref)) {
 			wait_for_completion_io(&dc->wait);
+			if (dc->state == D_DONE && dc->ref)
+				dc->ref--;
 			__remove_discard_cmd(sbi, dc);
 		} else {
 			dc->ref++;
-- 
2.13.0.rc1.294.g07d810a77f-goog
