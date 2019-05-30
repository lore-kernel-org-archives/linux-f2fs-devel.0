From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2] f2fs: add a rw_sem to cover quota flag changes
Date: Thu, 30 May 2019 10:57:14 -0700
Message-ID: <20190530175714.GB28719@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190530033115.16853-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190530033115.16853-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
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

v2 from v1:
 - avoid deadlock.
 - shorten the loop path

 fs/f2fs/checkpoint.c | 40 ++++++++++++++++++++--------------------
 fs/f2fs/f2fs.h       |  1 +
 fs/f2fs/super.c      | 27 ++++++++++++++++++++++-----
 3 files changed, 43 insertions(+), 25 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 89825261d474..66f29907fc0e 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1131,17 +1131,26 @@ static void __prepare_cp_block(struct f2fs_sb_info *sbi)
 
 static bool __need_flush_quota(struct f2fs_sb_info *sbi)
 {
+	bool ret;
+
 	if (!is_journalled_quota(sbi))
 		return false;
-	if (is_sbi_flag_set(sbi, SBI_QUOTA_SKIP_FLUSH))
-		return false;
-	if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_REPAIR))
-		return false;
-	if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_FLUSH))
-		return true;
-	if (get_pages(sbi, F2FS_DIRTY_QDATA))
+
+	if (!down_write_trylock(&sbi->quota_sem))
 		return true;
-	return false;
+
+	if (is_sbi_flag_set(sbi, SBI_QUOTA_SKIP_FLUSH))
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
@@ -1160,14 +1169,16 @@ static int block_operations(struct f2fs_sb_info *sbi)
 	blk_start_plug(&plug);
 
 retry_flush_quotas:
+	f2fs_lock_all(sbi);
 	if (__need_flush_quota(sbi)) {
 		int locked;
 
 		if (++cnt > DEFAULT_RETRY_QUOTA_FLUSH_COUNT) {
 			set_sbi_flag(sbi, SBI_QUOTA_SKIP_FLUSH);
-			f2fs_lock_all(sbi);
 			goto retry_flush_dents;
 		}
+
+		f2fs_unlock_all(sbi);
 		clear_sbi_flag(sbi, SBI_QUOTA_NEED_FLUSH);
 
 		/* only failed during mount/umount/freeze/quotactl */
@@ -1175,11 +1186,6 @@ static int block_operations(struct f2fs_sb_info *sbi)
 		f2fs_quota_sync(sbi->sb, -1);
 		if (locked)
 			up_read(&sbi->sb->s_umount);
-	}
-
-	f2fs_lock_all(sbi);
-	if (__need_flush_quota(sbi)) {
-		f2fs_unlock_all(sbi);
 		cond_resched();
 		goto retry_flush_quotas;
 	}
@@ -1201,12 +1207,6 @@ static int block_operations(struct f2fs_sb_info *sbi)
 	 */
 	down_write(&sbi->node_change);
 
-	if (__need_flush_quota(sbi)) {
-		up_write(&sbi->node_change);
-		f2fs_unlock_all(sbi);
-		goto retry_flush_quotas;
-	}
-
 	if (get_pages(sbi, F2FS_DIRTY_IMETA)) {
 		up_write(&sbi->node_change);
 		f2fs_unlock_all(sbi);
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
index 1dc02101e5e5..7a6d70d8e851 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1946,7 +1946,10 @@ int f2fs_quota_sync(struct super_block *sb, int type)
 	int cnt;
 	int ret;
 
+	down_read(&sbi->quota_sem);
 	ret = dquot_writeback_dquots(sb, type);
+	up_read(&sbi->quota_sem);
+
 	if (ret)
 		goto out;
 
@@ -2076,32 +2079,40 @@ static void f2fs_truncate_quota_inode_pages(struct super_block *sb)
 
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
 
@@ -2111,22 +2122,27 @@ static int f2fs_dquot_mark_dquot_dirty(struct dquot *dquot)
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
 
@@ -3235,6 +3251,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	}
 
 	init_rwsem(&sbi->cp_rwsem);
+	init_rwsem(&sbi->quota_sem);
 	init_waitqueue_head(&sbi->cp_wait);
 	init_sb_info(sbi);
 
-- 
2.19.0.605.g01d371f741-goog
