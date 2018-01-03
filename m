From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: enable quota at remount from r to w
Date: Tue,  2 Jan 2018 18:01:08 -0800
Message-ID: <20180103020108.14239-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

We have to enable quota only when remounting from read to write. Otherwise,
we'll get remount failure. (e.g., write to write case)

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3c62492b6a0d..8157f39f8539 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1283,7 +1283,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		err = dquot_suspend(sb, -1);
 		if (err < 0)
 			goto restore_opts;
-	} else {
+	} else if (f2fs_readonly(sb) && !(*flags & MS_RDONLY)) {
 		/* dquot_resume needs RW */
 		sb->s_flags &= ~MS_RDONLY;
 		if (sb_any_quota_suspended(sb)) {
-- 
2.15.0.531.g2ccb3012c9-goog
