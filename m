From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: show current cp state
Date: Thu, 26 Oct 2017 10:32:58 +0200
Message-ID: <20171026083258.54211-1-jaegeuk@kernel.org>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch shows whether checkpoint met any error case.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/debug.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index d441660c3ba6..f7eec506ceea 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -264,9 +264,10 @@ static int stat_show(struct seq_file *s, void *v)
 	list_for_each_entry(si, &f2fs_stat_list, stat_list) {
 		update_general_status(si->sbi);
 
-		seq_printf(s, "\n=====[ partition info(%pg). #%d, %s]=====\n",
+		seq_printf(s, "\n=====[ partition info(%pg). #%d, %s, CP: %s]=====\n",
 			si->sbi->sb->s_bdev, i++,
-			f2fs_readonly(si->sbi->sb) ? "RO": "RW");
+			f2fs_readonly(si->sbi->sb) ? "RO": "RW",
+			f2fs_cp_error(si->sbi) ? "Error": "Good");
 		seq_printf(s, "[SB: 1] [CP: 2] [SIT: %d] [NAT: %d] ",
 			   si->sit_area_segs, si->nat_area_segs);
 		seq_printf(s, "[SSA: %d] [MAIN: %d",
-- 
2.14.0.rc1.383.gd1ce394fe2-goog
