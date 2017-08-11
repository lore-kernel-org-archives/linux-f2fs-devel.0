From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: let fill_super handle roll-forward errors
Date: Thu, 10 Aug 2017 17:42:04 -0700
Message-ID: <20170811004204.24078-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, stable@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

If we set CP_ERROR_FLAG in roll-forward error, f2fs is no longer to proceed
any IOs due to f2fs_cp_error(). But, for example, if some stale data is involved
on roll-forward process, we're able to get -ENOENT, getting fs stuck.
If we get any error, let fill_super set SBI_NEED_FSCK and try to recover back
to stable point.

Cc: <stable@vger.kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/recovery.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index a3d02613934a..f707d810c87d 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -649,8 +649,6 @@ int recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	}
 
 	clear_sbi_flag(sbi, SBI_POR_DOING);
-	if (err)
-		set_ckpt_flags(sbi, CP_ERROR_FLAG);
 	mutex_unlock(&sbi->cp_mutex);
 
 	/* let's drop all the directory inodes for clean checkpoint */
-- 
2.14.0.rc1.383.gd1ce394fe2-goog
