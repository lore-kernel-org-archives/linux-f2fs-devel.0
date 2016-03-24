From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: treat as a normal umount when remounting ro
Date: Thu, 24 Mar 2016 12:59:52 -0700
Message-ID: <1458849592-34163-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

When user remounts f2fs as read-only, we can mark the checkpoint as umount.
Moreover, if we umounted the partition successfully, we don't need to proceed
the roll-forward recovery at all.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index abc0d75..2e6b7bf 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -791,11 +791,6 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	org_mount_opt = sbi->mount_opt;
 	active_logs = sbi->active_logs;
 
-	if (*flags & MS_RDONLY) {
-		set_opt(sbi, FASTBOOT);
-		set_sbi_flag(sbi, SBI_IS_DIRTY);
-	}
-
 	/* recover superblocks we couldn't write due to previous RO mount */
 	if (!(*flags & MS_RDONLY) && is_sbi_flag_set(sbi, SBI_NEED_SB_WRITE)) {
 		err = f2fs_commit_super(sbi, false);
@@ -805,8 +800,6 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 			clear_sbi_flag(sbi, SBI_NEED_SB_WRITE);
 	}
 
-	sync_filesystem(sb);
-
 	sbi->mount_opt.opt = 0;
 	default_options(sbi);
 
@@ -838,7 +831,6 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	if ((*flags & MS_RDONLY) || !test_opt(sbi, BG_GC)) {
 		if (sbi->gc_thread) {
 			stop_gc_thread(sbi);
-			f2fs_sync_fs(sb, 1);
 			need_restart_gc = true;
 		}
 	} else if (!sbi->gc_thread) {
@@ -848,6 +840,15 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		need_stop_gc = true;
 	}
 
+	if (*flags & MS_RDONLY) {
+		sync_inodes_sb(sb);
+
+		set_sbi_flag(sbi, SBI_IS_DIRTY);
+		set_sbi_flag(sbi, SBI_IS_CLOSE);
+		f2fs_sync_fs(sb, 1);
+		clear_sbi_flag(sbi, SBI_IS_CLOSE);
+	}
+
 	/*
 	 * We stop issue flush thread if FS is mounted as RO
 	 * or if flush_merge is not passed in mount option.
@@ -1548,13 +1549,14 @@ try_onemore:
 		goto free_proc;
 
 	/* recover fsynced data */
+	if (is_set_ckpt_flags(sbi->ckpt, CP_UMOUNT_FLAG))
+		goto skip_recovery;
+
 	if (!test_opt(sbi, DISABLE_ROLL_FORWARD)) {
 		/*
-		 * mount should be failed, when device has readonly mode, and
-		 * previous checkpoint was not done by clean system shutdown.
+		 * mount should be failed, when device has readonly mode.
 		 */
-		if (bdev_read_only(sb->s_bdev) &&
-				!is_set_ckpt_flags(sbi->ckpt, CP_UMOUNT_FLAG)) {
+		if (bdev_read_only(sb->s_bdev)) {
 			err = -EROFS;
 			goto free_kobj;
 		}
@@ -1579,7 +1581,7 @@ try_onemore:
 			goto free_kobj;
 		}
 	}
-
+skip_recovery:
 	/* recover_fsync_data() cleared this already */
 	clear_sbi_flag(sbi, SBI_POR_DOING);
 
-- 
2.6.3

