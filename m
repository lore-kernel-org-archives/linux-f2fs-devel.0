From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: don't commit quota files
Date: Tue, 10 Oct 2017 15:53:35 -0700
Message-ID: <20171010225335.22457-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

We don't need to commit every quota changes, since it only recovers fsynced
data. So, we need to rely on quotacheck to fix any inconsistency.
This also tries to resolve deadlock condition as follows.

- f2fs_write_begin
 - f2fs_reserve_block
  - mutex(node_change)
   - dquot_claim_space_nodirty
    - f2fs_mark_dquot_dirty
     - dquot_commit
      - mutex_lock()

- f2fs_setattr
 - dquot_transfer
  - dqget
   - dquot_acquire
    - write_blk
     - f2fs_quota_write
      - f2fs_write_begin
       - mutex(node_change)

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 85ba56ac34f2..5268690dd219 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1641,20 +1641,6 @@ void f2fs_quota_off_umount(struct super_block *sb)
 		f2fs_quota_off(sb, type);
 }
 
-static int f2fs_mark_dquot_dirty(struct dquot *dquot)
-{
-	struct super_block *sb = dquot->dq_sb;
-	struct f2fs_sb_info *sbi = F2FS_SB(sb);
-
-	if (f2fs_sb_has_quota_ino(sb) ||
-		sbi->s_qf_names[USRQUOTA] || sbi->s_qf_names[GRPQUOTA]) {
-		dquot_mark_dquot_dirty(dquot);
-		return dquot_commit(dquot);
-	} else {
-		return dquot_mark_dquot_dirty(dquot);
-	}
-}
-
 int f2fs_get_projid(struct inode *inode, kprojid_t *projid)
 {
 	*projid = F2FS_I(inode)->i_projid;
@@ -1666,7 +1652,7 @@ static const struct dquot_operations f2fs_quota_operations = {
 	.write_dquot	= dquot_commit,
 	.acquire_dquot	= dquot_acquire,
 	.release_dquot	= dquot_release,
-	.mark_dirty	= f2fs_mark_dquot_dirty,
+	.mark_dirty	= dquot_mark_dquot_dirty,
 	.write_info	= dquot_commit_info,
 	.alloc_dquot	= dquot_alloc,
 	.destroy_dquot	= dquot_destroy,
-- 
2.14.0.rc1.383.gd1ce394fe2-goog
