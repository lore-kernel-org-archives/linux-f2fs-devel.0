From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to retry fill_super only if recovery failed
Date: Tue, 19 Feb 2019 16:23:53 +0800
Message-ID: <20190219082353.6554-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

With current retry mechanism in f2fs_fill_super, first fill_super
fails due to no memory, then second fill_super runs w/o recovery,
if we succeed, we may lose fsynced data, it doesn't make sense.

Let's retry fill_super only if it occurs non-ENOMEM error during
recovery.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3dc7f56889da..5f692e10d094 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3052,10 +3052,11 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	struct f2fs_super_block *raw_super;
 	struct inode *root;
 	int err;
-	bool retry = true, need_fsck = false;
+	bool skip_recovery = false, need_fsck = false;
 	char *options = NULL;
 	int recovery, i, valid_super_block;
 	struct curseg_info *seg_i;
+	int retry_cnt = 1;
 
 try_onemore:
 	err = -EINVAL;
@@ -3344,7 +3345,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		goto free_meta;
 
 	if (unlikely(is_set_ckpt_flags(sbi, CP_DISABLED_FLAG)))
-		goto skip_recovery;
+		goto reset_checkpoint;
 
 	/* recover fsynced data */
 	if (!test_opt(sbi, DISABLE_ROLL_FORWARD)) {
@@ -3361,11 +3362,13 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		if (need_fsck)
 			set_sbi_flag(sbi, SBI_NEED_FSCK);
 
-		if (!retry)
-			goto skip_recovery;
+		if (skip_recovery)
+			goto reset_checkpoint;
 
 		err = f2fs_recover_fsync_data(sbi, false);
 		if (err < 0) {
+			if (err != -ENOMEM)
+				skip_recovery = true;
 			need_fsck = true;
 			f2fs_msg(sb, KERN_ERR,
 				"Cannot recover all fsync data errno=%d", err);
@@ -3381,7 +3384,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 			goto free_meta;
 		}
 	}
-skip_recovery:
+reset_checkpoint:
 	/* f2fs_recover_fsync_data() cleared this already */
 	clear_sbi_flag(sbi, SBI_POR_DOING);
 
@@ -3427,7 +3430,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 sync_free_meta:
 	/* safe to flush all the data */
 	sync_filesystem(sbi->sb);
-	retry = false;
+	retry_cnt = 0;
 
 free_meta:
 #ifdef CONFIG_QUOTA
@@ -3487,8 +3490,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	kvfree(sbi);
 
 	/* give only one another chance */
-	if (retry) {
-		retry = false;
+	if (retry_cnt > 0 && skip_recovery) {
+		retry_cnt--;
 		shrink_dcache_sb(sb);
 		goto try_onemore;
 	}
-- 
2.18.0.rc1
