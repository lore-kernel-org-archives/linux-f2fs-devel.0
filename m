From: Chao Yu <chao@kernel.org>
Subject: [PATCH v2] f2fs: stop gc/discard thread in prior during umount
Date: Thu, 29 Jun 2017 23:17:45 +0800
Message-ID: <20170629151745.6356-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

This patch resolves kernel panic for xfstests/081, caused by recent f2fs_bug_on

 f2fs: add f2fs_bug_on in __remove_discard_cmd

For fixing, we will stop gc/discard thread in prior in ->kill_sb in order to
avoid referring and releasing race among them.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h    |  1 +
 fs/f2fs/segment.c | 19 +++++++++++++------
 fs/f2fs/super.c   |  7 ++++---
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c27a6264d9bf..da7edb605180 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2288,6 +2288,7 @@ void destroy_flush_cmd_control(struct f2fs_sb_info *sbi, bool free);
 void invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr);
 bool is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr);
 void refresh_sit_entry(struct f2fs_sb_info *sbi, block_t old, block_t new);
+void stop_discard_thread(struct f2fs_sb_info *sbi);
 void f2fs_wait_discard_bios(struct f2fs_sb_info *sbi);
 void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc);
 void release_discard_addrs(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 86a0c1095939..1b22b6b4081c 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1063,6 +1063,18 @@ void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
 		__wait_one_discard_bio(sbi, dc);
 }
 
+void stop_discard_thread(struct f2fs_sb_info *sbi)
+{
+	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
+
+	if (dcc && dcc->f2fs_issue_discard) {
+		struct task_struct *discard_thread = dcc->f2fs_issue_discard;
+
+		dcc->f2fs_issue_discard = NULL;
+		kthread_stop(discard_thread);
+	}
+}
+
 /* This comes from f2fs_put_super */
 void f2fs_wait_discard_bios(struct f2fs_sb_info *sbi)
 {
@@ -1420,12 +1432,7 @@ static void destroy_discard_cmd_control(struct f2fs_sb_info *sbi)
 	if (!dcc)
 		return;
 
-	if (dcc->f2fs_issue_discard) {
-		struct task_struct *discard_thread = dcc->f2fs_issue_discard;
-
-		dcc->f2fs_issue_discard = NULL;
-		kthread_stop(discard_thread);
-	}
+	stop_discard_thread(sbi);
 
 	kfree(dcc);
 	SM_I(sbi)->dcc_info = NULL;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3da6fb276f8b..0a0af82e4dd4 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -566,8 +566,6 @@ static void f2fs_put_super(struct super_block *sb)
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 	int i;
 
-	stop_gc_thread(sbi);
-
 	/* prevent remaining shrinker jobs */
 	mutex_lock(&sbi->umount_mutex);
 
@@ -1974,8 +1972,11 @@ static struct dentry *f2fs_mount(struct file_system_type *fs_type, int flags,
 
 static void kill_f2fs_super(struct super_block *sb)
 {
-	if (sb->s_root)
+	if (sb->s_root) {
 		set_sbi_flag(F2FS_SB(sb), SBI_IS_CLOSE);
+		stop_gc_thread(F2FS_SB(sb));
+		stop_discard_thread(F2FS_SB(sb));
+	}
 	kill_block_super(sb);
 }
 
-- 
2.13.0.90.g1eb437020
