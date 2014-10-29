From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/4] f2fs: call write_checkpoint under disabled gc
Date: Tue, 28 Oct 2014 22:05:50 -0700
Message-ID: <1414559153-92771-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

During the write_checkpoint, we should avoid f2fs_gc trigger to avoid any
filesystem consistency.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 21ccc48..d391a59 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1046,7 +1046,9 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 	cpc.trim_minlen = range->minlen >> sbi->log_blocksize;
 
 	/* do checkpoint to issue discard commands safely */
+	mutex_lock(&sbi->gc_mutex);
 	write_checkpoint(sbi, &cpc);
+	mutex_unlock(&sbi->gc_mutex);
 out:
 	range->len = cpc.trimmed << sbi->log_blocksize;
 	return 0;
-- 
2.1.1
