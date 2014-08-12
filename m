From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 12/13] f2fs: check s_dirty under cp_mutex
Date: Tue, 12 Aug 2014 12:49:26 -0700
Message-ID: <1407872967-26423-12-git-send-email-jaegeuk@kernel.org>
References: <1407872967-26423-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1407872967-26423-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

It needs to check s_dirty under cp_mutex, since s_dirty is reset under that
mutex.
And previous condition was not correct, since we can omit doing checkpoint
when checkpoint was done followed by all the node pages were written back.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 8 ++++++--
 fs/f2fs/super.c      | 3 ---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 1161d2a..d074e27 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -952,6 +952,10 @@ void write_checkpoint(struct f2fs_sb_info *sbi, bool is_umount)
 	trace_f2fs_write_checkpoint(sbi->sb, is_umount, "start block_ops");
 
 	mutex_lock(&sbi->cp_mutex);
+
+	if (!sbi->s_dirty)
+		goto out;
+
 	block_operations(sbi);
 
 	trace_f2fs_write_checkpoint(sbi->sb, is_umount, "finish block_ops");
@@ -976,9 +980,9 @@ void write_checkpoint(struct f2fs_sb_info *sbi, bool is_umount)
 	do_checkpoint(sbi, is_umount);
 
 	unblock_operations(sbi);
-	mutex_unlock(&sbi->cp_mutex);
-
 	stat_inc_cp_count(sbi->stat_info);
+out:
+	mutex_unlock(&sbi->cp_mutex);
 	trace_f2fs_write_checkpoint(sbi->sb, is_umount, "finish checkpoint");
 }
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 7e4b631..c4f90cd 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -457,9 +457,6 @@ int f2fs_sync_fs(struct super_block *sb, int sync)
 
 	trace_f2fs_sync_fs(sb, sync);
 
-	if (!sbi->s_dirty && !get_pages(sbi, F2FS_DIRTY_NODES))
-		return 0;
-
 	if (sync) {
 		mutex_lock(&sbi->gc_mutex);
 		write_checkpoint(sbi, false);
-- 
1.8.5.2 (Apple Git-48)
