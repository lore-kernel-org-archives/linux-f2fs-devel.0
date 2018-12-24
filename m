From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to retry fill_super only if recovery failed
Date: Mon, 24 Dec 2018 17:09:21 +0800
Message-ID: <20181224090921.123612-1-yuchao0@huawei.com>
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
 fs/f2fs/super.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index cec7ef27b389..c43f86f6be48 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3019,10 +3019,11 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
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
@@ -3307,7 +3308,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		goto free_meta;
 
 	if (unlikely(is_set_ckpt_flags(sbi, CP_DISABLED_FLAG)))
-		goto skip_recovery;
+		goto reset_checkpoint;
 
 	/* recover fsynced data */
 	if (!test_opt(sbi, DISABLE_ROLL_FORWARD)) {
@@ -3324,11 +3325,13 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
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
@@ -3344,7 +3347,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 			goto free_meta;
 		}
 	}
-skip_recovery:
+reset_checkpoint:
 	/* f2fs_recover_fsync_data() cleared this already */
 	clear_sbi_flag(sbi, SBI_POR_DOING);
 
@@ -3440,8 +3443,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
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
