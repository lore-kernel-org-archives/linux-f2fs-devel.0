From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: do checkpoint when umount flag is not set
Date: Thu, 22 Jan 2015 16:08:50 -0800
Message-ID: <1421971730-17024-2-git-send-email-jaegeuk@kernel.org>
References: <1421971730-17024-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1421971730-17024-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

If the previous checkpoint was done without CP_UMOUNT flag, it needs to do
checkpoint with CP_UMOUNT for the next fast boot.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 3 ++-
 fs/f2fs/super.c      | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 9f5317c..231d8c9 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1043,7 +1043,8 @@ void write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	mutex_lock(&sbi->cp_mutex);
 
-	if (!sbi->s_dirty && cpc->reason != CP_DISCARD)
+	if (!sbi->s_dirty &&
+			cpc->reason != CP_DISCARD && cpc->reason != CP_UMOUNT)
 		goto out;
 	if (unlikely(f2fs_cp_error(sbi)))
 		goto out;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 84f95cd..6ef1458 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -448,7 +448,8 @@ static void f2fs_put_super(struct super_block *sb)
 	stop_gc_thread(sbi);
 
 	/* We don't need to do checkpoint when it's clean */
-	if (sbi->s_dirty) {
+	if (sbi->s_dirty ||
+			!is_set_ckpt_flags(F2FS_CKPT(sbi), CP_UMOUNT_FLAG)) {
 		struct cp_control cpc = {
 			.reason = CP_UMOUNT,
 		};
-- 
2.1.1
