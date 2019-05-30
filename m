From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: add a rw_sem to cover quota flag changes
Date: Wed, 29 May 2019 20:31:15 -0700
Message-ID: <20190530033115.16853-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

thread 1:                        thread 2:
writeback                        checkpoint
set QUOTA_NEED_FLUSH
                                 clear QUOTA_NEED_FLUSH
f2fs_dquot_commit
dquot_commit
clear_dquot_dirty
                                 f2fs_quota_sync
                                 dquot_writeback_dquots
				 nothing to commit
commit_dqblk
quota_write
f2fs_quota_write
waiting for f2fs_lock_op()
				 pass __need_flush_quota
                                 (no F2FS_DIRTY_QDATA)

-> up-to-date quota is not written

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 26 ++++++++++++++++----------
 fs/f2fs/f2fs.h       |  1 +
 fs/f2fs/super.c      | 27 ++++++++++++++++++++++-----
 3 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 89825261d474..cf3b15c963d2 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1131,17 +1131,23 @@ static void __prepare_cp_block(struct f2fs_sb_info *sbi)
 
 static bool __need_flush_quota(struct f2fs_sb_info *sbi)
 {
+	bool ret = false;
+
+	down_write(&sbi->quota_sem);
 	if (!is_journalled_quota(sbi))
-		return false;
-	if (is_sbi_flag_set(sbi, SBI_QUOTA_SKIP_FLUSH))
-		return false;
-	if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_REPAIR))
-		return false;
-	if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_FLUSH))
-		return true;
-	if (get_pages(sbi, F2FS_DIRTY_QDATA))
-		return true;
-	return false;
+		ret = false;
+	else if (is_sbi_flag_set(sbi, SBI_QUOTA_SKIP_FLUSH))
+		ret = false;
+	else if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_REPAIR))
+		ret = false;
+	else if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_FLUSH))
+		ret = true;
+	else if (get_pages(sbi, F2FS_DIRTY_QDATA))
+		ret = true;
+	else
+		ret = false;
+	up_write(&sbi->quota_sem);
+	return ret;
 }
 
 /*
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9b3d9977cd1e..692c0922f5b2 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1250,6 +1250,7 @@ struct f2fs_sb_info {
 	block_t unusable_block_count;		/* # of blocks saved by last cp */
 
 	unsigned int nquota_files;		/* # of quota sysfile */
+	struct rw_semaphore quota_sem;		/* blocking cp for flags */
 
 	/* # of pages, see count_type */
 	atomic_t nr_pages[NR_COUNT_TYPE];
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 912e2619d581..5ddf5e97ee60 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1944,7 +1944,10 @@ int f2fs_quota_sync(struct super_block *sb, int type)
 	int cnt;
 	int ret;
 
+	down_read(&sbi->quota_sem);
 	ret = dquot_writeback_dquots(sb, type);
+	up_read(&sbi->quota_sem);
+
 	if (ret)
 		goto out;
 
@@ -2074,32 +2077,40 @@ static void f2fs_truncate_quota_inode_pages(struct super_block *sb)
 
 static int f2fs_dquot_commit(struct dquot *dquot)
 {
+	struct f2fs_sb_info *sbi = F2FS_SB(dquot->dq_sb);
 	int ret;
 
+	down_read(&sbi->quota_sem);
 	ret = dquot_commit(dquot);
 	if (ret < 0)
-		set_sbi_flag(F2FS_SB(dquot->dq_sb), SBI_QUOTA_NEED_REPAIR);
+		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
+	up_read(&sbi->quota_sem);
 	return ret;
 }
 
 static int f2fs_dquot_acquire(struct dquot *dquot)
 {
+	struct f2fs_sb_info *sbi = F2FS_SB(dquot->dq_sb);
 	int ret;
 
+	down_read(&sbi->quota_sem);
 	ret = dquot_acquire(dquot);
 	if (ret < 0)
-		set_sbi_flag(F2FS_SB(dquot->dq_sb), SBI_QUOTA_NEED_REPAIR);
-
+		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
+	up_read(&sbi->quota_sem);
 	return ret;
 }
 
 static int f2fs_dquot_release(struct dquot *dquot)
 {
+	struct f2fs_sb_info *sbi = F2FS_SB(dquot->dq_sb);
 	int ret;
 
+	down_read(&sbi->quota_sem);
 	ret = dquot_release(dquot);
 	if (ret < 0)
-		set_sbi_flag(F2FS_SB(dquot->dq_sb), SBI_QUOTA_NEED_REPAIR);
+		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
+	up_read(&sbi->quota_sem);
 	return ret;
 }
 
@@ -2109,22 +2120,27 @@ static int f2fs_dquot_mark_dquot_dirty(struct dquot *dquot)
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 	int ret;
 
+	down_read(&sbi->quota_sem);
 	ret = dquot_mark_dquot_dirty(dquot);
 
 	/* if we are using journalled quota */
 	if (is_journalled_quota(sbi))
 		set_sbi_flag(sbi, SBI_QUOTA_NEED_FLUSH);
 
+	up_read(&sbi->quota_sem);
 	return ret;
 }
 
 static int f2fs_dquot_commit_info(struct super_block *sb, int type)
 {
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 	int ret;
 
+	down_read(&sbi->quota_sem);
 	ret = dquot_commit_info(sb, type);
 	if (ret < 0)
-		set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
+		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
+	up_read(&sbi->quota_sem);
 	return ret;
 }
 
@@ -3233,6 +3249,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	}
 
 	init_rwsem(&sbi->cp_rwsem);
+	init_rwsem(&sbi->quota_sem);
 	init_waitqueue_head(&sbi->cp_wait);
 	init_sb_info(sbi);
 
-- 
2.19.0.605.g01d371f741-goog
