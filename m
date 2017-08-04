From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: use printk_ratelimited for f2fs_msg
Date: Thu,  3 Aug 2017 19:00:13 -0700
Message-ID: <20170804020013.84078-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch reduces contention of printks.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 4ab6dc31a61b..ca340d84f8c2 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -159,7 +159,7 @@ void f2fs_msg(struct super_block *sb, const char *level, const char *fmt, ...)
 	va_start(args, fmt);
 	vaf.fmt = fmt;
 	vaf.va = &args;
-	printk("%sF2FS-fs (%s): %pV\n", level, sb->s_id, &vaf);
+	printk_ratelimited("%sF2FS-fs (%s): %pV\n", level, sb->s_id, &vaf);
 	va_end(args);
 }
 
-- 
2.13.0.rc1.294.g07d810a77f-goog
